Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFFEC001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 09:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjHGJ7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjHGJ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 05:59:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8E1F9
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 02:59:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31783d02093so3806689f8f.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691402383; x=1692007183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C29H4UScy1zNmyjd8CuuUqOMAfNRa83O4QpSgcspPms=;
        b=IPUcuClG6vBShddmvL4NKGpIgFlNCdnfhHDQYmWekkX+lMAzQuj9X9Atr+cc2z/pL4
         KPl7c90eWKs9t20nY5CvuogCqBi16ZcnLDKQWgnz3S+dpwrxQneRXz2Hb4ReZ0wlhpm7
         DqZyrsDVJZiE8xxmHDUiDjPPiUJ11CycXaJubX2EQmmVTrEwEHE5WICOxuyqMNVjzMGs
         jDT/Sli7NcIR1kpKwILnSLlGlKj0qbuacuXcYUSs1afB7ylxzSi97Ik3Z8qNPGtEey1a
         CV+wSQ5UTjLDkVpv6Sbp2bn2F6/kqiyDak3OvzZQ18CKHAHydZXkCERFu2Oor1dlxYKk
         SasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691402383; x=1692007183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C29H4UScy1zNmyjd8CuuUqOMAfNRa83O4QpSgcspPms=;
        b=XYfDMvQkU9C7DoFAnSRrZapNMhHxxDWiZzYK4mkxCNgwffdtgyGm3TSb0pLyTAWIKQ
         78FVI6oWRPCk1uXscVUs562eCOhNCej4TRkn6KUnSnBgQthObt1lTar/1OUE8VuZeOfD
         eOSFMd3SAIFgDtOta+UYdUJYAQpijUsBrTpgUmZ9bTiukdseFbF1UsBUXwBcW8pDvATs
         nONAVGmWKpn9fA6kxj8zTtCZRsyXnHvTP+LhDntHJMq2moVkDzkg6IpW11mLGP8/GLcY
         8ziev3rKO29oQ8v/jz1i5KWK4RpfusLIDz6+VBPqWV772qbdmPmyfhXJLFQnTyOY99Ld
         ts6A==
X-Gm-Message-State: AOJu0Yyl7dWOY0q2V8ObqRu0svkdki3Db1/4mT0J2W4aN7/3eIBRcPFD
        30dAyzIpIOte9GBAfUOZLG4=
X-Google-Smtp-Source: AGHT+IEpVaqbIRyPobwFVyzVgbclaaY8csiJINE17IAyOdBUZusXfUTxYmfkN5WFzQVW/4IDOvP0aA==
X-Received: by 2002:adf:dd81:0:b0:315:99be:6fe4 with SMTP id x1-20020adfdd81000000b0031599be6fe4mr6640811wrl.69.1691402382486;
        Mon, 07 Aug 2023 02:59:42 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id e10-20020adfe38a000000b00317a29af4b2sm9935431wrm.68.2023.08.07.02.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 02:59:42 -0700 (PDT)
Message-ID: <b43a5b46-f391-bd9e-4bf2-bfeaa3548f3e@gmail.com>
Date:   Mon, 7 Aug 2023 10:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase --skip: fix commit message clean up when skipping
 squash
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>
 <xmqqedkj515a.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqedkj515a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08/2023 21:20, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> ... The test is also updated to explicitly check
>> the commit messages rather than relying on grep to ensure they do not
>> contain any stay commit headers.
> 
> "stay" -> "stray" presumably.

I see this is in next already, thanks for fixing that and the other typo 
pointed out by Marc

>> To check the commit message the function test_commit_message() is moved
>> from t3437-rebase-fixup-options.sh to test-lib.sh. As the function is
>> now publicly available it is updated to provide better error detection
>> and avoid overwriting the commonly used files "actual" and "expect".
>> Support for reading the expected commit message from stdin is also
>> added.
> 
> It may make it cleaner to do the refactoring as a separate
> preparatory patch, but the end-result is not so large from
> the diffstat below, so it probably is OK.

I was in two minds about splitting out the refactoring, but in the end I 
decided that as I was adding the ability to read the expected message 
from stdin for this commit it was easier include it all here rather than 
splitting it out.

> I am not sure if deviating from expect vs actual is such a good
> idea.  It is not like use of two temporary files are transparent to
> the caller of the new test helper---indeed, expect and actual are
> likely to be used by the caller in tests that comes before or after
> the ones that use test_commit_message, and by using a pair of files
> that are different, the caller will now see two extra untracked
> files left in the working tree.

That's true, looking at test-lib-functions.sh it seems I unwittingly 
followed the example of test_cmp_config() which uses 
{actual,expect}.config when it calls test_cmp(). Anyway as this is in 
next I assume you're happy enough with the implementation as it stands.

Best Wishes

Phillip

> The only case such a renaming could help callers is when they do
> 
> 	cat >expect <<\-EOF &&
> 	here to prepare some outcome
> 	EOF
> 	git do-something-to-make-commit &&
> 	test_commit_message HEAD <<\-EOF &&
> 	here is what we expect to see in HEAD
> 	EOF
> 	git some-other-thing >actual &&
> 	test_cmp expect actual
> 	
> as use of files other than expect/actual in test_commit_message will
> avoid stomping on the "expect" file that was already prepared.
> 
> I suspect that it would be rare, and something we can fix when need
> arises by allowing test_commit_message to accept an option to use
> non-standard filenames for its temporaries.  The current callers,
> both the existing ones in t3437 and the new ones added by this
> patch, would not benefit.  The only externally visible side effect
> is that the existing ones will have two extra untracked files in
> their working tree.
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>      rebase --skip: fix commit message clean up when skipping squash
>>      
>>      This patch is based on maint.
>> ...
>>   sequencer.c                     | 26 +++++++++++----
>>   t/t3418-rebase-continue.sh      | 58 +++++++++++++++++++++++----------
>>   t/t3437-rebase-fixup-options.sh | 15 ---------
>>   t/test-lib-functions.sh         | 33 +++++++++++++++++++
>>   4 files changed, 93 insertions(+), 39 deletions(-)
> 
> OK.
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index bceb6abcb6c..af271ab6fbd 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -5038,19 +5038,31 @@ static int commit_staged_changes(struct repository *r,
>>   				 * We need to update the squash message to skip
>>   				 * the latest commit message.
>>   				 */
>> +				int res = 0;
>>   				struct commit *commit;
>> +				const char *msg;
>>   				const char *path = rebase_path_squash_msg();
>>   				const char *encoding = get_commit_output_encoding();
>>   
>> -				if (parse_head(r, &commit) ||
>> -				    !(p = repo_logmsg_reencode(r, commit, NULL, encoding)) ||
>> -				    write_message(p, strlen(p), path, 0)) {
>> -					repo_unuse_commit_buffer(r, commit, p);
>> -					return error(_("could not write file: "
>> +				if (parse_head(r, &commit))
>> +					return error(_("could not parse HEAD"));
>> +
>> +				p = repo_logmsg_reencode(r, commit, NULL, encoding);
>> +				if (!p)  {
>> +					res = error(_("could not parse commit %s"),
>> +						    oid_to_hex(&commit->object.oid));
>> +					goto unuse_commit_buffer;
>> +				}
>> +				find_commit_subject(p, &msg);
>> +				if (write_message(msg, strlen(msg), path, 0)) {
>> +					res = error(_("could not write file: "
>>   						       "'%s'"), path);
>> +					goto unuse_commit_buffer;
>>   				}
>> -				repo_unuse_commit_buffer(r,
>> -							 commit, p);
>> +			unuse_commit_buffer:
>> +				repo_unuse_commit_buffer(r, commit, p);
>> +				if (res)
>> +					return res;
>>   			}
>>   		}
> 
> Just as described in the proposed log message.  Looking good.
> 
> Will queue.  Thanks.

