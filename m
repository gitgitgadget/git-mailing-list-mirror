Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A1EC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0364A2086A
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN0XnPrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgICKpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgICKpo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 06:45:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7FC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 03:45:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so3166710ejl.7
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YkG1jYa+eii0aqD/b5hE8zoWNrJso7cWhduTpcYkmDg=;
        b=CN0XnPrnVFbLdUo7jvbTUDV7ob/DYTfQuVewaRQVz8Q5JrmLg9OMFonPRvWt+ybit5
         KGybokUA3FTakLf/Pdr/IadE1vjUm4dz1e9lri5qpSM81Vvs4TKsB5GuDaBwDmzsGeya
         i/4aPwXCAwZlvKz/82+UeWf4LTpufqM58JqAHS3E7J3lXCWh1mAtmbtXPldGCsxVSLxx
         nTe/CgRscwpsEQC+Szd48Vwlz/0ICpg3Fandjh4LHzjsvQBLahVi8p8dKrjSR6X3zHi3
         Yio7bS+Ew5YKzFGDeAQfNwfJT+IWMM0jNqQ2Lwi5pe9s8dou8YP5hAl728IftMp/v0eR
         z6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YkG1jYa+eii0aqD/b5hE8zoWNrJso7cWhduTpcYkmDg=;
        b=XiQM9PNDAw2WTs0TQosyq4Ngtof2On2nuN2wUb+7IRDkMqkEU7zY0/t+ZDusD0vdZk
         LiasZPAgI5TUiASXvuSgAZ92gE3M80fkYp0qUreMwmzr7CiThefNVODXC2Xg+XKGgRkE
         A+rDdrKu3FzNSVrr6f8DigetmaSeMWM6vdkXkZUBJA7Dhve2gMTBBJRlYGXLHMYYb9oF
         cpudyY62hDPVJE33OK5iFVkgPvtSTKSxjCthO6lsI7ruANwekGUqnNAqZTdEV5la1Iw7
         qKJOibffROrkTllYY2rRh/cDEH96n7fyMG7Kzyp9bAY1x38cJedyn2ec1kK+dVktcGlZ
         Jfag==
X-Gm-Message-State: AOAM530EVDD8PdiLaAKA0XtPyQi+xNIurfuGB6VkoZOa6KCzGRmRa6Ai
        ON6dKdMfDoZKRiOrTKBlR5V6oPX6ySg=
X-Google-Smtp-Source: ABdhPJyg2AMTA1QqB5vViafRkEpCzzNuNLUvSMTD9K2TajcV+PgpcyMMmpo3+BsGA3RDDxvdRmeCsQ==
X-Received: by 2002:a17:907:3301:: with SMTP id ym1mr1531487ejb.367.1599129942797;
        Thu, 03 Sep 2020 03:45:42 -0700 (PDT)
Received: from szeder.dev (84-236-109-131.pool.digikabel.hu. [84.236.109.131])
        by smtp.gmail.com with ESMTPSA id u15sm2298165edj.69.2020.09.03.03.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 03:45:42 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:45:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] ci: stop linking built-ins to the dashed versions
Message-ID: <20200903104537.GA27325@szeder.dev>
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
 <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
 <99a53284925315995e30d417cb58dfb176b036ed.1598443012.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99a53284925315995e30d417cb58dfb176b036ed.1598443012.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 26, 2020 at 11:56:52AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Originally, all of Git's subcommands were implemented in their own
> executable/script, using the naming scheme `git-<command-name>`. When
> more and more functionality was turned into built-in commands (i.e. the
> `git` executable could run them without spawning a separate process),
> for backwards-compatibility, we hard-link the `git` executable to
> `git-<built-in>` for every built-in.
> 
> This backwards-compatibility was needed to support scripts that called
> the dashed form, even if we deprecated that a _long_ time ago.
> 
> For that reason, we just introduced a Makefile knob to skip linking
> them. To make sure that this keeps working, teach the CI
> (and PR) builds to skip generating those hard-links.
> 
> This is actually not such a big change: e4597aae6590 (run test suite
> without dashed git-commands in PATH, 2009-12-02) made sure that our test
> suite does not require dashed commands. With this Makefile knob, the
> commitment is just a little stronger (running tests with `--with-dashes`
> would _still_ not see the dashed form of the built-ins).
> 
> There is a subtle change in behavior with this patch, though: as we no
> longer even _build_ the dashed executables, running the test suite would
> fail if any of Git's scripted commands (e.g. `git-request-pull`) still
> This would have succeeded previously (and would have been unintentional,
> of course) because `bin-wrappers/git` sets `GIT_EXEC_PATH` to the
> top-level directory (which would still have contained, say,
> `git-rev-parse`).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 6c27b886b8..1df9402c3b 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>  *) ln -s "$cache_dir/.prove" t/.prove;;
>  esac
>  
> -make
> +make SKIP_DASHED_BUILT_INS=YesPlease

Please make sure that this Makefile knob is set in all jobs building
and testing Git, or justify in the commit message why it isn't.

>  case "$jobname" in
>  linux-gcc)
>  	make test
> -- 
> gitgitgadget
