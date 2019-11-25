Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51066C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CF120862
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZcBoJA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKYOXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:23:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38871 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKYOXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:23:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so16185255wmk.3
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 06:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RDOS9B9TmATCi8FqH17U2zKaScGEumdG7hSY10gIx7g=;
        b=dZcBoJA4Qk0TfB0MKDOpfV87b0Kr7mfuj2UL8g7TdbDRGD6He5Dt7Qqgq++tOOnhEI
         lyiFyJ8mWs4H5kQZDpjW1oa7JMubmEVibgbLK/0UfossZWusfaorp6mYxidWIdnr0822
         5BoeIZxXwG2LwRWWxH0qRT/Y/kmik0NZ2mwW8/z9FMuVoW2mkvrsyHQcmZz3y0SDIcrL
         8Zv9s6huSPi8XSGJNbT/E24XXfTB9OJaEDO/EiUtb9VT9iG4+9sHKPHQlDi2vAPKyeSt
         ra8d+YFDtyugOHaHTjeweqi34Yhubn8SMrIj+kwVveKIlUZnd/r2Ssh5z0YWs3PYSwgU
         gVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RDOS9B9TmATCi8FqH17U2zKaScGEumdG7hSY10gIx7g=;
        b=IawsAgguljMbWCkvXW5Ap8EO4JMs4Z8olk2WBN5pOlf17NGfwc1NjFjL7YsxW+Mw/4
         mHMKhYskLvHzZ0eDAS1NmmAkxMz3tMt78ywDvoUfMmV6ESuVXY4aii0DwGqeAhAa9K4K
         YVcDS9i0X5XsDSt3iiwOHporrBmkZeu+oPqIvLdBHrUiejT5MTzshkcwyObRXe0AM4SC
         AcGixIirbEDATZzD6ENm5ojTz8DwTZT3SLSi3wFSxIeudtKQhR/djH2f9rJhluNhmoof
         oGUjvT9+wNcAdflwQD9JERlh4jRe9WIGWCfQUBras8JmH/QzjZ9qFctk+sqDgda/kR5A
         KZPA==
X-Gm-Message-State: APjAAAX9ZZRUWqZJM+f1yz9HM6nxxkUUzXG7DiHPz8s6FTuAb+dUuV/z
        xc5BSlmWGsYVNzjl1VmpeK4=
X-Google-Smtp-Source: APXvYqzZf2/0jUS/jNJEKBe4cyhlk4jCbugFS9AFIGf3EflsRkoVqDCo53ntpOMjqEA/MOBvjll0RQ==
X-Received: by 2002:a1c:7904:: with SMTP id l4mr29812113wme.141.1574691808161;
        Mon, 25 Nov 2019 06:23:28 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id u1sm8448120wmc.3.2019.11.25.06.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 06:23:27 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
 <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
 <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
 <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
 <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com>
 <94573071-556b-caae-b159-40c168a08f44@gmail.com>
 <xmqqr21wy80o.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <43bdadd2-9ea9-4e50-1f47-ec18e0db4794@gmail.com>
Date:   Mon, 25 Nov 2019 14:23:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqr21wy80o.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/11/2019 03:00, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> We do actually check that there is a valid HEAD before we try to fixup
>> a commit. Though perhaps we should still change this patch as HEAD may
>> be changed by another process between that check and re-reading it
>> here. If you try to fixup a commit without a valid HEAD you get
>>
>> error: need a HEAD to fixup
>> hint: Could not execute the todo command
>> hint:
>> hint:     fixup faef1a5a7637ff91b3611aabd1b96541da5f5536 P
>> hint:
>> hint: It has been rescheduled; To edit the command before continuing, please
>> hint: edit the todo list first:
>> hint:
>> hint:     git rebase --edit-todo
>> hint:     git rebase --continue
>> error: could not copy '.git/rebase-merge/message-squash' to
>> '.git/rebase-merge/message'
>>
>> The last error message is unfortunate but we do exit in an orderly
>> manner rather than segfaulting.
> 
> Thanks for thinking about the issue further.
> 
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index d2f1d5bd23..4f55f0cd1c 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -67,6 +67,21 @@ test_expect_success 'setup' '
>>   SHELL=
>>   export SHELL
>>
>> +test_expect_success 'fixup on orphan branch errors out' '
>> +
>> +       test_when_finished "git switch master" &&
>> +       write_script switch-branch.sh <<-\EOF &&
>> +       git symbolic-ref HEAD refs/heads/does-not-exist &&
>> +       git rm -rf .
> 
> That "git rm -rf ." scares me, though.

I know I'm not too keen on it my self but we need to empty the worktree 
and index if we're going to switch to an unborn branch

> 
>> +       EOF
>> +       (
>> +               set_fake_editor &&
>> +               FAKE_LINES="exec_./switch-branch.sh \
>> +                           fixup 1" git rebase -i HEAD^
>> +       ) &&
>> +       test_pause
>> +'
>> +
>>
>> I think it would be useful to add something like this to the test
>> suite (changed to check the error message, with a better name for the
>> script and modified to expect failure) What do you think?
> 
> So, we try an interactive rebase, try to apply a fix-up on an unborn
> branch and expect it to fail in a controlled way, something like
> 
> 	(
> 		# we are in subshell so freely export
> 		set_fake_editor &&
> 		export FAKE_LINES="exec_./switch-branch.sh fixup 1" &&
> 		test_must_fail git rebase -i HEAD^ 2>error &&
> 		test_i18ngrep "... what we expect ..." error
> 	)
> 
> Perhaps.  I do not think of a good reason why we should allow
> switching to another branch when "rebase -i" gives control back to
> the user, so in the longer run, the checked condition may not stay
> the same (I suspect you would catch "does-not-exist is unborn and
> there is nothing to 'fixup'" right now---I am envisioning that the
> condition that is checked and the message we would issue would be
> "we gave you a detached HEAD for a good reason---stay there and do
> not switch to any other branch") and the message expected by this
> test would have to be updated.

I agree there's no good reason for a user to do this. 'git switch' will 
refuse to switch branches during a rebase for that reason. At the moment 
we check HEAD with get_oid() so that would need changing to check if the 
user has switched to another branch (perhaps it could be done when we 
check that the index and worktree are clean after running an exec command).

Best Wishes

Phillip

> 
> Thanks.
> 
> 
> 
