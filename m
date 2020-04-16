Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8895C2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 02:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9D720725
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 02:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvFyLUA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgDPCFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728397AbgDPCFQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 22:05:16 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689CDC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 19:05:14 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d17so14196964qto.6
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UoO7HydSt2gMWn+gnLyEIidm8jBzGwz/YcNdVbFlDRQ=;
        b=bvFyLUA+7UYxMNxvm6nv1QmIfvH0MEMuxptV2B0m4pPE4a6fmLK62gdhKwWf6nA0qr
         5o9J/8C70JUo9FeqtPWM1QLeZOWRusB1vtzvimbLhdUrW62gjGv3hTR993qWwOmpmHoI
         YqV2/+E2QSLn0Pp7qDHYbc277kbcHlAjBiqdvGPoRsdZvop7lEpYSIeWtysphYhKQJaT
         Pwm+qf3iAG4aFgGyCpql8SAoUK9dNiJxt1uL4TGuIo9eNwptWZ7xgCifv9giV203gXG2
         Io12sddUUG35oTokF907sgoCUUNvaIyyozGoKXFYh9R+GeFE/m4JHJU73+7WC0alMUp0
         +9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UoO7HydSt2gMWn+gnLyEIidm8jBzGwz/YcNdVbFlDRQ=;
        b=UtWCFAu2/Oj6+Uk7JKpwYK+ul7JGTTBxawVo50FWTaC6g5ojB0ToPnOL9Gj59daAyH
         lgcR19oei0r6AWlzmKAwW04eEj/J1ogR99p6av59XdoajJlISAjNYP+DsjggdWdZ4Wc5
         Tr+f5VY+LW8YWJvNwEoOeCUqi9qInvaeFN/OAYS6yiB3HWHpEvTpfHMuYoPTMyN8rfu/
         8CnB1nN5iO2Z5ecOwSY986bpiPCy4e/IetYNQLqOnfawnIvO1dos/1gLXmTFFLLl/DZS
         H3bzgyjTvdwETzSoCLx54vBYtKVMl0bjc5/nd8JQUfefm+stBu2w725SCeCJpSzj0yiH
         iYug==
X-Gm-Message-State: AGi0PuZ85lYcjw8KFsOB5V55/YAHeCYQNQzzD+pIb+2iz3DYFaNXfguq
        pRVH2yyVCXTjwIPYlE2vNnXlkJ62XIeNiUQLCjiN
X-Google-Smtp-Source: APiQypLTPKZ1Isjm8jnjV1ILs1CrRZN3Flq80fD1LTs+Ui2YDBEBvYM3ARDGYTbwLn5aEQKSMviL2FIaZGK80NXbb0zZ
X-Received: by 2002:a0c:fc0c:: with SMTP id z12mr7694077qvo.41.1587002713462;
 Wed, 15 Apr 2020 19:05:13 -0700 (PDT)
Date:   Wed, 15 Apr 2020 19:05:09 -0700
In-Reply-To: <20200414235057.GA6863@syl.local>
Message-Id: <20200416020509.225014-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200414235057.GA6863@syl.local>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     stolee@gmail.com, newren@gmail.com, jonathantanmy@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Here's a patch that I didn't sign-off on that fixes the problem for me.
> 
> --- >8 ---
> 
> Subject: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
> 
> In bd0b42aed3 (fetch-pack: do not take shallow lock unnecessarily,
> 2019-01-10), the author noted that 'is_repository_shallow' produces
> visible side-effect(s) by setting 'is_shallow' and 'shallow_stat'.

Thanks for the reference to my commit. When I wrote that, if I remember
correctly, I found it difficult to be able to guarantee that the
clearing of is_shallow and shallow_stat was performed upon every
commit-lock (which creates a new shallow file) and
<unlink+rollback-lock> (which removes the shallow file, potentially
changing the repo state from shallow to none), so I added the NEEDSWORK
instead. I see that this patch makes some progress in solving that.

> @@ -1630,6 +1630,7 @@ static void update_shallow(struct fetch_pack_args *args,
>  		if (*alternate_shallow_file == '\0') { /* --unshallow */
>  			unlink_or_warn(git_path_shallow(the_repository));
>  			rollback_lock_file(&shallow_lock);
> +			reset_repository_shallow(the_repository);
>  		} else
>  			commit_lock_file(&shallow_lock);
>  		alternate_shallow_file = NULL;

Here, do you need a reset in the "else" branch as well? (I.e. in both
branches, so you can put it outside the "if" block.) I didn't look at it
too closely, but I would think that when the shallow_lock file is
committed, there might have been no shallow beforehand, changing the
state from no-shallow to shallow.

> @@ -411,6 +411,7 @@ void prune_shallow(unsigned options)
>  			die_errno("failed to write to %s",
>  				  get_lock_file_path(&shallow_lock));
>  		commit_lock_file(&shallow_lock);
> +		reset_repository_shallow(the_repository);
>  	} else {
>  		unlink(git_path_shallow(the_repository));
>  		rollback_lock_file(&shallow_lock);

And the opposite case here - reset in the "else" branch because the
state could have changed from shallow to no-shallow.

In any case, I think the commit message should discuss why
reset_repository_shallow() is added only on the unlink+rollback side in
one "if" statement, but only on the opposite "commit" side in another
"if" statement.
