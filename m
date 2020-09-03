Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7332C433E7
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 00:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8040020773
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 00:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk2Qt0hE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgICACl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgICACk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 20:02:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0ADC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 17:02:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so695673pfa.10
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WI8LjpnZbfbOO7GiBwc73ytGftB2LWuV0CCno9cDIxQ=;
        b=Qk2Qt0hEbamFcH8Ok5Ef12VDnfsqK/DU++6fLs/bMF4GiDFKeGB0iDvTRL9f/xzCUM
         nITzwoz91U35LHtIXYvX4G70d/q1tWPR/bPMLqW6E74Jdqq6XsYhNwE49INEvOdQTt89
         83UD9Rq3uHDANkF7i859yQs9LsuQfWoSUEsh4uLZm4dBOWmINjyEF0mnxNoMuclTAtht
         VCCWJG48oPp90t34ZeIZMSyVboLpUSw8KBgZUEBRZ2ImSsmqztB3ievGZbponeA5FZCA
         lIwNTuWisyXtZp30e3zUL9Sb8rlEIvdUp/DPasLzTA2vIy4xpOJO51V/6CYyWZnDrsyS
         LxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WI8LjpnZbfbOO7GiBwc73ytGftB2LWuV0CCno9cDIxQ=;
        b=S1yhYkad1xvtN/Khe+4sYt2AUUQTr3lccvAJigHbl95mWvzvMNEeswSU//ARCt3ETh
         +jLdyotpyKqrLlRis4gm9FiuWttB6luvI6AiCikrLArGaB94vIUlyNRMpKTwgPhE1M0i
         KNlWygIN9i7ideAs3c4CV1L64dVDjSqu+llqcEmTYI5g6eyT62RYKwKGlLybvNr9vsQl
         eJzXSdlKyGkVtBWspJ8AA4A+QD/oWfbUPAJRqSiCJF3OOjsFCacTNeRIBE8HedKALXyL
         Ajwm5jK1vcM+cJ9vt33pvlzCVH9vus64GtVe7JAnAOJWNAbgET198TAxRgIPQDKoWH9W
         wbdQ==
X-Gm-Message-State: AOAM531tFu2iALOoTUxXJqgsa/LGtrWQmB1blxEYOWo+n1cEZtBeJhYv
        hPszBoACUALiUOmV2/vtz7w=
X-Google-Smtp-Source: ABdhPJwTbToXWh9moVJttWkKZQGo777w5NW/PBaYGLS3Vue2CnlfIclx0q4pnDpTSbt9inamtoSpWw==
X-Received: by 2002:a17:902:9303:: with SMTP id bc3mr811106plb.170.1599091358794;
        Wed, 02 Sep 2020 17:02:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 65sm681051pfx.104.2020.09.02.17.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 17:02:38 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:02:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] vcbuild: fix batch file name in README
Message-ID: <20200903000236.GC4035286@google.com>
References: <pull.721.git.1599077900986.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.721.git.1599077900986.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing Jeff Hostetler, vcbuild expert)
Orgad Shaneh wrote:

> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-721%2Forgads%2Fvcbuild-readme-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-721/orgads/vcbuild-readme-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/721
>
>  compat/vcbuild/README | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Makes sense.  This discrepancy is already present in the initial
contribution dce7d295514 (msvc: support building Git using MS Visual
C++, 2019-06-25), so it's probably from documentation going out of
date between review rounds.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> index 42292e7c09..51fb083dbb 100644
> --- a/compat/vcbuild/README
> +++ b/compat/vcbuild/README
> @@ -26,8 +26,8 @@ The Steps to Build Git with VS2015 or VS2017 from the command line.
>     Use ONE of the following forms which should match how you want to
>     compile git.exe.
>  
> -   $ ./compat/vcbuild/vcpkg_copy_packages.bat debug
> -   $ ./compat/vcbuild/vcpkg_copy_packages.bat release
> +   $ ./compat/vcbuild/vcpkg_copy_dlls.bat debug
> +   $ ./compat/vcbuild/vcpkg_copy_dlls.bat release
>  
>  3. Build git using MSVC from an SDK bash window using one of the
>     following commands:
> 
> base-commit: e19713638985533ce461db072b49112da5bd2042
> -- 
> gitgitgadget
