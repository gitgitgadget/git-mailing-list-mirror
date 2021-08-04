Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B6CC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 18:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E79360EB2
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 18:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbhHDSOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhHDSOw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 14:14:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ADDC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 11:14:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m19so1742275wms.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mXSfns/WRMAjl5ZHkY6A5XIe7gmo3AFOW/fBU3pjTtc=;
        b=eh8+s7stNdoZ6URlsk1vYrEIGLWJ0Hrrg+RiLNaJzrmP7xTPmR3hKp0Cfxi2N6kqzq
         Mw0AiCzaRHsSEXWVRpyVvWkSx+s8v+Hj8CElMrignqocNiUHdzB3MBmjcejjMGEQnaGj
         sv33D2rY3rRbPzSWdLLmHfl4B70HD0jjDoFbice0f4dtZpBgDCVCDKE++D2+3o7tdCf5
         GWkaHKAys692CBK4zZC9MR/X0JlzZR2hyXT/POSAKYFRg715ZHWFc5rDs30tWNvaiZ1i
         7Fpv24BEN74jkx1hwvN92M3HGd2vYvmGh/Y1Cpib28qJ7I5zECBPgbiajD4/O1s+IiDc
         fbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXSfns/WRMAjl5ZHkY6A5XIe7gmo3AFOW/fBU3pjTtc=;
        b=tOGWaqeZGh2ouUNWFg+U2a6LqgPJvUWeEj4REMf7UEPStbQJ1oCLhVHgj4l4wQig6A
         uUkWN3dObmlj1XWDupybQf3BJxcLCfmiCf9QMeAWQnczmF0aSrWNVdb3fIBEaLrmnjzh
         SIjQNoCl0ZLulX5PLiD1mItiO2wdFIFU5orjZdFJyJJkHfVxA0nEF7bUiMwfGGJMTBv3
         p1p3ipUqmoAOnqewyR0w6Ib73lPg1OX+C7Q4FU0G1+SsDsIxlQO8m9O3XHsEdmsGAL2D
         TXnh0/YVEsuwqC5/t0n9HFnW1bd2eKJUlmwz8FTsWaywWNUx+posPI7M2KQeBvWMfyEY
         E8lw==
X-Gm-Message-State: AOAM531DbypcNkgem6bGX4BgvDWRTzAgs7peP9ZbjY8MzM1s/M8UmtFI
        oWR075Qs123wWRMSii1H+2AOben4nes=
X-Google-Smtp-Source: ABdhPJwoeTGAuZFUH8OBypIAATrbvv4hgY5ZRG1AUxXL5irsFqec+CqqSpF8u3mXn7VSpTYcOJ6SPA==
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr10740418wmq.60.1628100876504;
        Wed, 04 Aug 2021 11:14:36 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.232])
        by smtp.googlemail.com with ESMTPSA id j19sm7837187wmi.3.2021.08.04.11.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 11:14:35 -0700 (PDT)
Subject: Re: git revert --continue --no-verify
To:     Taylor Blau <me@ttaylorr.com>,
        Cameron Steffen <cam.steffen94@gmail.com>
Cc:     git@vger.kernel.org
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
 <YQmsJUe6hAMy/QGA@nand.local>
 <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
 <YQmuT2ZYe1mzHBjI@nand.local>
 <CAAVFnNmitHeimogaGUUwWGWhve+wbF6CXcSNUonGCWAgOSKzjA@mail.gmail.com>
 <YQm+PWAtc3rixqsw@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <74443c64-efe9-ea47-e918-d62b8c976abc@gmail.com>
Date:   Wed, 4 Aug 2021 19:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQm+PWAtc3rixqsw@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Cameron and Taylor

On 03/08/2021 23:07, Taylor Blau wrote:
> On Tue, Aug 03, 2021 at 04:33:09PM -0500, Cameron Steffen wrote:
>> Perhaps the issue then is that the pre-commit hook should not run for
>> `git revert --continue`? It does not run for `git revert`.

The general rule for cherry-pick, revert and rebase is that if the 
commit message is edited then the commit is made with --verify and if 
the commit message is not being edited then the commit is made with 
--no-verify. I think the reasoning for this is that if the user has 
altered the commit message or contents and they have a pre-commit hook 
set then it is reasonable to check the new commit is acceptable to the 
hook. There are some exceptions to this which are oversights (for 
example I think we always pass --no-verify when committing a conflict 
resolution with 'git rebase --continue' even though the editor opens 
when committing in that case - I should try and fix that)

For 'git revert --continue' the commit is made when sequencer_continue() 
calls continue_single_pick() which looks like

static int continue_single_pick(struct repository *r, struct replay_opts 
*opts)
{
	struct strvec argv = STRVEC_INIT;
	int ret;

	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
		return error(_("no cherry-pick or revert in progress"));

	strvec_push(&argv, "commit");

	/*
	 * continue_single_pick() handles the case of recovering from a
	 * conflict.  should_edit() doesn't handle that case; for a conflict,
	 * we want to edit if the user asked for it, or if they didn't specify
	 * and stdin is a tty.
	 */
	if (!opts->edit || (opts->edit < 0 && !isatty(0)))
		/*
		 * Include --cleanup=strip as well because we don't want the
		 * "# Conflicts:" messages.
		 */
		strvec_pushl(&argv, "--no-edit", "--cleanup=strip", NULL);

	ret = run_command_v_opt(argv.v, RUN_GIT_CMD);
	strvec_clear(&argv);
	return ret;
}

It runs git commit directly and never passes --no-verify. I wouldn't be 
opposed to someone adding support for --no-verify (and --no-edit) to 
"cherry-pick/revert/rebase --continue" on the understanding that it only 
applied when committing the conflict resolution. There is a possible 
confusion for users though who might expect that the options passed with 
'--continue' applied to all the commits made by the command.

> This does look like an oversight to me, but you'll have to bear with me
> since I am relatively unfamiliar with the sequencer code.
> 
> Ultimately `git revert` calls do_pick_commit()

This is what happens when we are picking commits, the commit made with 
'--continue' uses a different code path

> which either calls
> do_commit() or run_git_commit(). A couple of curiosities there:
> 
>    - do_commit() does fall back to run_git_commit() if it has the
>      VERIFY_MSG bit set in `flags`.
>    - run_git_commit() passes `-n` only when VERIFY_MSG *isn't* set, so
>      the VERIFY_MSG bit does imply that the pre-commit hook would be run
>      there.
>    - when do_pick_commit() does have to fall back to run_git_commit(), it
>      sets the VERIFY_MSG bit in flags.

Calling run_git_commit() there is not a fallback it, that call is used 
to reword commits once they have been picked (see 450efe2d53 ("rebase 
-i: always update HEAD before rewording", 2019-08-19) for the reasoning 
behind this) . Because the message is being edited there is no point in 
going through do_commit().

> But we never end up calling run_git_commit() (except in the case of
> errors) because do_pick_commit() special-cases `command == TODO_REVERT`
> (which is the case for `git revert`) and calls `do_commit()`.
> 
> But it gets weirder: do_commit() calls run_git_commit() itself, but
> before the caller in do_pick_commit() has had a chance to add VERIFY_MSG
> to the flags.

do_commit() does not change the flags that it is called with - callers 
that want VERIFY_MSG will set that before they call do_commit(). 
do_commit() is there to commit simple picks without forking 'git commit'

> So I suspect that this is an oversight, but perhaps somebody more
> familiar with this code could confirm my thinking.

I hope the above helps - basically the idea is "if the commit has been 
edited use VERIFY_MSG" and --continue unhelpfully uses a completely 
different code-path to the main commit picking/reverting loop.

Best Wishes

Phillip

> Thanks,
> Taylor
> 

