Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E7C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2971960FF4
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhG0RMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0RMc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:12:32 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA9C061760
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:12:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pg12-20020a17090b1e0cb0290177328fc06dso100637pjb.2
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jti8i4g2/LmjKt+WhPfcogF1qbYMid6nRWCShxhzuQE=;
        b=ssNNLzDFwdMsfQ3oBVe4aWRv8GTBrJHhAp/vqHz1GDb4SRfWHPeZv9bdOWVNho2sX4
         XjLfZBd6XYv6UUnYx9xEgcBRMG/zqohKaLhwadybcgf8Eum4JurGoOnhzpA0Kif277k2
         OruhSkPYgTztnhgBU3eCBAGRq5CfVOP/QmP5TK12L+VBuTCc37hpBLP91g6HEmd+x0yX
         PGoPSy0gkNNVu14chekKTtZDLaFb6wgYiwLzxSuv5Hitn421OSH7b5vby8YtK0nxyLkc
         v03Iv/TmqrP4HBxy4ck7AEPrWZiDKHNXPEikJkStv7eDThU/rgkr7Di3+F/ZJjGdFwGU
         3aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jti8i4g2/LmjKt+WhPfcogF1qbYMid6nRWCShxhzuQE=;
        b=jeDpf4eHfxRJ6vm0hp7V4wCnaYbNt17BTK+Cn7enkXn2fSeJpo1C3BXKLH75x8AOf+
         5NTb5rgPZxJwtdK4w8Ff8S76Jy5HfHaTvrNX6/SM8qZCXtVBXnCcLIyAgUjUODVEZoe0
         Q5Y4wd/bB6c60pTvZYxb9GOpAUyIgqUHXcDmuFAeHrFLuZwTSz7ZcaVnPO5/S/69EHdx
         vIA8khPfhTAnSwsQ6k3cMhraaOzG42O40jlmyu/zCT/1ws7ZRqEStYP/wMf+rUn1l+nf
         5Rfc6asHy3CH0DT5fLIjslExzqD/GHLQplsM1JbfnsyaKd/z4mSSKptj+7i7IfCyGJCf
         fF2g==
X-Gm-Message-State: AOAM530sEBfZEJSCR5SnUses6y+NdkHWCHuBDoc/LeF4oVgkCTljIofe
        V+GazUTS7Wj/sE/iAKF90TmQg4ZA03WqiDeNzefN
X-Google-Smtp-Source: ABdhPJwVQql0vbNs8UFb6zfFGaxbrAcg+e92kU75GrAj5rQ7i9LhxD2fKwhUbFkflbyZBERlScFDajV4OrVjNXK6K9qk
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7b93:b029:12b:a0a5:78d2 with
 SMTP id w19-20020a1709027b93b029012ba0a578d2mr19526059pll.51.1627405951696;
 Tue, 27 Jul 2021 10:12:31 -0700 (PDT)
Date:   Tue, 27 Jul 2021 10:12:25 -0700
In-Reply-To: <20210616004508.87186-2-emilyshaffer@google.com>
Message-Id: <20210727171225.2457893-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210616004508.87186-2-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH v2 1/4] t7400-submodule-basic: modernize inspect() helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index a924fdb7a6..f5dc051a6e 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -107,25 +107,18 @@ test_expect_success 'setup - repository to add submodules to' '
>  # generates, which will expand symbolic links.
>  submodurl=$(pwd -P)
>  
> -listbranches() {
> -	git for-each-ref --format='%(refname)' 'refs/heads/*'
> -}
> -
>  inspect() {
>  	dir=$1 &&
> -	dotdot="${2:-..}" &&
>  
> -	(
> -		cd "$dir" &&
> -		listbranches >"$dotdot/heads" &&
> -		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
> -		git rev-parse HEAD >"$dotdot/head-sha1" &&
> -		git update-index --refresh &&
> -		git diff-files --exit-code &&
> -		git clean -n -d -x >"$dotdot/untracked"
> -	)
> +	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> +	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
> +	git -C "$dir" rev-parse HEAD >head-sha1 &&
> +	git -C "$dir" update-index --refresh &&
> +	git -C "$dir" diff-files --exit-code &&
> +	git -C "$dir" clean -n -d -x >untracked
>  }
>  
> +

Stray extra line.

Other than that, this is definitely a good simplification.
