Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCFCC43217
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 09:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiKUJu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 04:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiKUJuD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 04:50:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98681144F
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 01:50:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t4so8040797wmj.5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwut3OYmJfBu0YvMz5NTk8WVx1/wd3C+396MjBAItUc=;
        b=eqbIF76YCgpebSnfKxRPOziSivbhYaDzWHPOkidxAug2xA4WryrPMNQuWac27PM09q
         Ys7/hmdWUB52LCyn3AaDxmDCxPkseqkeCMVbj9t10Efk3+AyVMIeHyq9rFCqWCWw7Q8A
         oIVtIKzVPFDmu7RgS+hiCeJ0ng6q59nLReCdKzqBN8Il0/qEyvWsFrsJZP+JTqFOG7Fn
         RLhkj1Yz6F/zpum0OwAtIeJV7Eux/OhrSn7LUymcokRjh9UwDs20lBm1KEU7cPlutDlv
         OwfbCiCDkPw6djtU1wzbkLSDC/RrgaPFOsXFoxJqgsWQMi8FbA+WrtkZJ9Cro1i8+fvF
         9UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jwut3OYmJfBu0YvMz5NTk8WVx1/wd3C+396MjBAItUc=;
        b=fcFzNExSjg0PtUi9l33WzNJXE4yDkbaq8tq9C8/fzci2XsPtYPgDLVs8AqsV1JlmTO
         jSn4xiZ69fDR12UEQOvyorC8R8nBC7f+Q9vROB0VUvjvfRApxx1A+BFLa+TA85nLam0N
         Vt0CimdHCd/0bYDtZMCe1dzIIhSy4w8HNAzMRS6MXUvoCIEkg/PA/0PynS20TaYes6b/
         AINVOi2c++pDUGb5lsuQEdlfDZOtHrgnbIZMg7OHUhDoVYKRiQsJpgaMvkNan+RZ+oGT
         g++KBbEt0jzyD/jTIoPg/engV+vjBsVwn4zkXElMBksG3/62ajnc+t9TVycVTd9L01q8
         pxFQ==
X-Gm-Message-State: ANoB5pmK0UCzBB2rWkiJ0J7PxYuH5+dsLDiuTSJ8U2DMbQxkS99xWaak
        vwnkxxgLi8kNe1wyJitZRU0=
X-Google-Smtp-Source: AA0mqf6udjcJ5Hb65LXo2yA/8MhWFR3woUCd2XZ4FbALi6Nqr7Kn2QNFGRDLvux2GaeOtQ84acf8TQ==
X-Received: by 2002:a05:600c:22c4:b0:3cf:71b7:7a41 with SMTP id 4-20020a05600c22c400b003cf71b77a41mr12329017wmg.31.1669024200391;
        Mon, 21 Nov 2022 01:50:00 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d490b000000b0023691d62cffsm9011223wrq.70.2022.11.21.01.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:49:59 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4220fa3f-fc3f-aff0-fb03-b5dc4b24d087@dunelm.org.uk>
Date:   Mon, 21 Nov 2022 09:49:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] sequencer: unify label lookup
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1414.git.1668098622.gitgitgadget@gmail.com>
 <ecb81b873a8d72c57fd4812ec86d103927437cf1.1668098622.git.gitgitgadget@gmail.com>
 <93qo066o-8r35-9q15-rq62-9r398o50p5p6@tzk.qr>
In-Reply-To: <93qo066o-8r35-9q15-rq62-9r398o50p5p6@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 18/11/2022 13:40, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 10 Nov 2022, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The arguments to the `reset` and `merge` commands may be a label created
>> with a `label` command or an arbitrary commit name. The `merge` command
>> uses the lookup_label() function to lookup its arguments but `reset` has
>> a slightly different version of that function in do_reset(). Reduce this
>> code duplication by calling lookup_label() from do_reset() as well.
>>
>> This change improves the behavior of `reset` when the argument is a
>> tree.  Previously `reset` would accept a tree only for the rebase to
>> fail with
>>
>>         update_ref failed for ref 'HEAD': cannot update ref 'HEAD': trying to write non-commit object da5497437fd67ca928333aab79c4b4b55036ea66 to branch 'HEAD'
>>
>> Using lookup_label() means do_reset() will now error out straight away
>> if its argument is not a commit.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> Very nice.
> 
>  From reading the patch, I get the impression that this also addresses
> https://github.com/gitgitgadget/git/issues/199, i.e. allowing `reset
> <tag>`.
> 
> Am I right?
> Dscho

I think so, the tag will be dereferenced by lookup_commit_reference()

Best Wishes

Phillip

> P.S.: FWIW here is my ACK for both patches.
> 
>>   sequencer.c              | 49 ++++++++++++++++++++--------------------
>>   t/t3430-rebase-merges.sh |  8 +++++++
>>   2 files changed, 33 insertions(+), 24 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index e658df7e8ff..21f5032df0d 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -3696,6 +3696,26 @@ static const char *reflog_message(struct replay_opts *opts,
>>   	return buf.buf;
>>   }
>>
>> +static struct commit *lookup_label(const char *label, int len,
>> +				   struct strbuf *buf)
>> +{
>> +	struct commit *commit;
>> +
>> +	strbuf_reset(buf);
>> +	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
>> +	commit = lookup_commit_reference_by_name(buf->buf);
>> +	if (!commit) {
>> +		/* fall back to non-rewritten ref or commit */
>> +		strbuf_splice(buf, 0, strlen("refs/rewritten/"), "", 0);
>> +		commit = lookup_commit_reference_by_name(buf->buf);
>> +	}
>> +
>> +	if (!commit)
>> +		error(_("could not resolve '%s'"), buf->buf);
>> +
>> +	return commit;
>> +}
>> +
>>   static int do_reset(struct repository *r,
>>   		    const char *name, int len,
>>   		    struct replay_opts *opts)
>> @@ -3727,6 +3747,7 @@ static int do_reset(struct repository *r,
>>   		oidcpy(&oid, &opts->squash_onto);
>>   	} else {
>>   		int i;
>> +		struct commit *commit;
>>
>>   		/* Determine the length of the label */
>>   		for (i = 0; i < len; i++)
>> @@ -3734,12 +3755,12 @@ static int do_reset(struct repository *r,
>>   				break;
>>   		len = i;
>>
>> -		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
>> -		if (get_oid(ref_name.buf, &oid) &&
>> -		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
>> -			ret = error(_("could not read '%s'"), ref_name.buf);
>> +		commit = lookup_label(name, len, &ref_name);
>> +		if (!commit) {
>> +			ret = -1;
>>   			goto cleanup;
>>   		}
>> +		oid = commit->object.oid;
>>   	}
>>
>>   	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
>> @@ -3786,26 +3807,6 @@ cleanup:
>>   	return ret;
>>   }
>>
>> -static struct commit *lookup_label(const char *label, int len,
>> -				   struct strbuf *buf)
>> -{
>> -	struct commit *commit;
>> -
>> -	strbuf_reset(buf);
>> -	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
>> -	commit = lookup_commit_reference_by_name(buf->buf);
>> -	if (!commit) {
>> -		/* fall back to non-rewritten ref or commit */
>> -		strbuf_splice(buf, 0, strlen("refs/rewritten/"), "", 0);
>> -		commit = lookup_commit_reference_by_name(buf->buf);
>> -	}
>> -
>> -	if (!commit)
>> -		error(_("could not resolve '%s'"), buf->buf);
>> -
>> -	return commit;
>> -}
>> -
>>   static int do_merge(struct repository *r,
>>   		    struct commit *commit,
>>   		    const char *arg, int arg_len,
>> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
>> index f351701fec2..fbbc4439bfe 100755
>> --- a/t/t3430-rebase-merges.sh
>> +++ b/t/t3430-rebase-merges.sh
>> @@ -138,6 +138,14 @@ test_expect_success '`reset` refuses to overwrite untracked files' '
>>   	git rebase --abort
>>   '
>>
>> +test_expect_success '`reset` rejects trees' '
>> +	test_when_finished "test_might_fail git rebase --abort" &&
>> +	test_must_fail env GIT_SEQUENCE_EDITOR="echo reset A^{tree} >" \
>> +		git rebase -i B C >out 2>err &&
>> +	grep "object .* is a tree" err &&
>> +	test_must_be_empty out
>> +'
>> +
>>   test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
>>   	test_when_finished "test_might_fail git rebase --abort" &&
>>   	git checkout -b conflicting-merge A &&
>> --
>> gitgitgadget
>>
>>
