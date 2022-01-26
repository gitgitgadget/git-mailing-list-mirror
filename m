Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE9CC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbiAZR16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiAZR15 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 12:27:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF8C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:27:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i65so311719pfc.9
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QA9Jy/iKqgKEQsaXWgIG4R4jrNJw4TrOTldRbQbBbKU=;
        b=fT8C/358fXcisD29fvv0T8th8KWC/1vK7KFpFyO2sxFUaWk+Xy1qKDiK4oJKsItXyN
         SBffx2Qjvh9gaozHPP/GxqDLXDrf0TAFdK7PmdaKJbjRVkbS/obXfTSCREAoXsgvdt82
         0qXFJcN5T9vi2Q4ZwQF1Xrt6ul7noichLa8Lqa5MgguhojwjX/3/EjoqYdloLFUFoCfH
         0gbP5ItLm3tkiRAKwpmBdhqChAQfwluwFOhJeOoM8MLVi6d7EpLGT1f8bIhoCRTBVDAZ
         knYzIpdf5KJW2VejxvxDZE4Nc4GeQYLuPa+r3AZx+8Oz30ufoqcaUtN/m45uF/aUyrq/
         aZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QA9Jy/iKqgKEQsaXWgIG4R4jrNJw4TrOTldRbQbBbKU=;
        b=5ssGH+pCO+TCP5F4aOPFndvBrEDZ0cPVKE8qZunzWwsWQuGu/UQKx5i12eDFiCwJOr
         HQUBeI5Sg61Q5VL4W8z3B64ihUWBxAtWIwnqhtfLJjlnaB8ugInWdwjq1ttHZmKHzgJs
         TA0nLsm3+nsUYhRlm+K7kcnt88r/ibFTAJ5+wpYtj5bnWlRoWoPt/9FVYkhV2CMOjhZ7
         ujdw2QY0JZUMxo6o8c8U7vozUrhGdRy+w8hqcPHRbuZfdmGbguAr3/M8qa4Fm3zZzAel
         EYQQt7VRn3EAzXUnl42yiJZ+zCsu61D2/6o6pApi6paWgeZndQ1WGCwdJNOy9Mi/50wo
         096A==
X-Gm-Message-State: AOAM532OxzABtrlbECQw/z5jwguBvOn4eU0V7wkSTAPTCXeB5qJbfZeZ
        g24Y6F/a4cPpP0RWNGshWR6B6A==
X-Google-Smtp-Source: ABdhPJzYolN/eJgzwVAJnWP7MxT6pS3WAWE0j9GL2jo0jEh4yZ8Zp6rEMooVyR1uBDlgat3CEwZ6tQ==
X-Received: by 2002:a65:6403:: with SMTP id a3mr15445361pgv.399.1643218076522;
        Wed, 26 Jan 2022 09:27:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:6aef:b12a:4316:e953])
        by smtp.gmail.com with ESMTPSA id z25sm2592333pfg.129.2022.01.26.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:27:55 -0800 (PST)
Date:   Wed, 26 Jan 2022 09:27:49 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        gitscale@google.com
Subject: Re: Submodule UX overhaul update (was: What's cooking in git.git
 (Jan 2022, #07; Mon, 24))
Message-ID: <YfGElSykenUSs/Lh@google.com>
References: <xmqq35lc53e9.fsf@gitster.g>
 <YfBTRuPrGGjepe+D@google.com>
 <220126.867damfuvo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220126.867damfuvo.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 03:09:19PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Tue, Jan 25 2022, Emily Shaffer wrote:
> 
> >> * ab/config-based-hooks-2 (2022-01-07) 17 commits
> >>   (merged to 'next' on 2022-01-19 at 594b6da22c)
> >>  + run-command: remove old run_hook_{le,ve}() hook API
> >>  + receive-pack: convert push-to-checkout hook to hook.h
> >>  + read-cache: convert post-index-change to use hook.h
> >>  + commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
> >>  + git-p4: use 'git hook' to run hooks
> >>  + send-email: use 'git hook run' for 'sendemail-validate'
> >>  + git hook run: add an --ignore-missing flag
> >>  + hooks: convert worktree 'post-checkout' hook to hook library
> >>  + hooks: convert non-worktree 'post-checkout' hook to hook library
> >>  + merge: convert post-merge to use hook.h
> >>  + am: convert applypatch-msg to use hook.h
> >>  + rebase: convert pre-rebase to use hook.h
> >>  + hook API: add a run_hooks_l() wrapper
> >>  + am: convert {pre,post}-applypatch to use hook.h
> >>  + gc: use hook library for pre-auto-gc hook
> >>  + hook API: add a run_hooks() wrapper
> >>  + hook: add 'run' subcommand
> >> 
> >>  More "config-based hooks".
> >> 
> >>  Will cook in 'next'.
> >>  source: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
> >> 
> >
> > Very excited to see this one go in and looking forward to the next set!
> > By the way, this reduced the number of patches Google is carrying
> > internally on top of 'next' from 46 to 29. :) (All but 7 of those are
> > the rest of config-based-hooks.)
> 
> Good to hear, I'm waiting on Junio to merge this down, and will then
> submit the next step in the config-based hook conversion.

Thanks!

> 
> > It might seem slightly selfish for me to include config-based-hooks in
> > the "submodules update" letter, but this is actually very important for
> > submodules too - without config-based hooks, we don't have a good way to
> > distribute a hook across an entire Git superproject-and-submodules
> > codebase. With config-based hooks + "config.superproject" shared between
> > the submodules and superproject, this becomes a very easy story :)
> 
> I'm probably missing something, not that config-based hooks aren't great
> & all that, but for this specific use-case wouldn't core.hooksPath work?
> I.e. to simply set that in the submodules to the superproject's
> .git/hooks directory?
> 
> That could even be done with the includeIf + include.path mechanism to
> apply to all projects below a certain path, which presumably is similar
> to how it would work with config-based hooks.

It's not quite so simple. We could set core.hooksPath in /etc/gitconfig,
but a user who already has core.hooksPath set in ~/.gitconfig would
override it. And since we're currently working with users who previously
used Repo, it wouldn't surprise me to see savvy users globally setting
core.hooksPath because that doesn't interfere with Repo's own hook
system. In that case, even using an includeIf around the /etc/gitconfig
line won't help, because I'd guess the config included at the system
level will still be overridden by the config included at the global
level.

And anyway.... we've been shipping config based hooks internally for
over a year now, so there's not much reason to stop now ;)

> 
> Obviously the full config-based hook mechanism is much nicer, I just
> wonder if it's something you can use as a transitory mechanism until
> then.
> 

 - Emily
