Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D192CC64EC4
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjB1Xag (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjB1Xac (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:30:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC0D231D3
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:30:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i10so12155009plr.9
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUXn6dMFqFA9mBl9W9dJ7o7akcyxuEdzStuBFPHkzUU=;
        b=AcPmqa/c1Ik5JpXPaGUURDow8IreYb9z3T91VaTxKjeTZHBMzw67QrsV335majK+Z8
         iCcrcDCWlOWpHsOEnwcGorkCEh1SCQxcPJe/9rMrzbfEzydR5GsAUtUEnSN60GFnHkWI
         HhS+vDmj/XIEDKkikq26IVmf0W5wWdeSTb++P6RHDTDfMe25Z324fP/fOe9/+VbLKZ0q
         U/BoMONdNkedhd+4WeIGVHdwIVM5WV5j8fdTM11Wl+Y89YQIguGa/EHieiq+cNcaw+NH
         QGNfly0m31OCb+T6J56wjt3frhJSmDFDojR/W7D+gFTUEVTBsnWlcFrdN70aWfDdbYf6
         ruJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUXn6dMFqFA9mBl9W9dJ7o7akcyxuEdzStuBFPHkzUU=;
        b=bbhk5GHHZ0IRHeeDUCxKDvK6sXYbOGmFJCX/KdJIujQYQb7btX0QFrHExtD0WnK37A
         5MuU4eAemYGlkUJom22V+l0mdTLfY/45IasrSsNHz9+IX9j/GDcvJWmBqGdsDExj+/ie
         p8B7HgFkhj8Xrt4jKJf//XeL2mAswJFSWE60PLwJU68o6Ws8FRLVrKINTiSOXU9rNUl9
         6afySHJQ9ExYibsCM0CfYn+rugc8W7eSHB8Jk2aNd7cLN7oXz1FFsq9RZIKA2yS83BeX
         hHmbG1gXfDIuW+GxievDUxojb/JklAD2o0btY5R3eINAP4/7FmYKjf7RFtzCwk/98t92
         CGmw==
X-Gm-Message-State: AO0yUKX7hUvc2qLRF9OlqpxQzxFpp6bUoi+w1uugwN3sQ/uavO/HZKBn
        FTYy00u8ns0FOun4bbDA5hA=
X-Google-Smtp-Source: AK7set+daLNBtnsLW+zjhbtV01qutGllijjlyMukodehJbvaF8RhHeRZ00yXcQzfg2DowMwLhwiF1Q==
X-Received: by 2002:a05:6a20:6a03:b0:bf:58d1:cea0 with SMTP id p3-20020a056a206a0300b000bf58d1cea0mr10454729pzk.31.1677627030679;
        Tue, 28 Feb 2023 15:30:30 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id e18-20020a656892000000b004fbd91d9716sm6239652pgt.15.2023.02.28.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:30:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        peff@peff.net
Subject: Re: [PATCH v2 2/6] tests: Use `git submodule add` instead of `git add`
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230228185642.2357806-2-calvinwan@google.com>
Date:   Tue, 28 Feb 2023 15:30:29 -0800
In-Reply-To: <20230228185642.2357806-2-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 28 Feb 2023 18:56:38 +0000")
Message-ID: <xmqqttz5pduy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
> index b2bdd1fcb4..dd2858648b 100755
> --- a/t/t2013-checkout-submodule.sh
> +++ b/t/t2013-checkout-submodule.sh
> @@ -10,7 +10,7 @@ test_expect_success 'setup' '
>  	(cd submodule &&
>  	 git init &&
>  	 test_commit first) &&
> -	git add submodule &&
> +	git submodule add ./submodule &&

The change from "submodule" to "./submodule" was not explained in
the proposed log message.  I think this is necessary for "git
submodule add" to function as expected, but if that is why we are
making this change, perhaps we should mention it?

> @@ -51,6 +51,7 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .gitm
>  	git config diff.ignoreSubmodules none &&
>  	git config -f .gitmodules submodule.submodule.path submodule &&
>  	git config -f .gitmodules submodule.submodule.ignore untracked &&
> +	git commit -m "Update patterns in .gitmodules" .gitmodules &&

What does "patterns" refer here (another one in the next hunk)?

> diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
> index e9451cd567..11bc136f6e 100755
> --- a/t/t2103-update-index-ignore-missing.sh
> +++ b/t/t2103-update-index-ignore-missing.sh
> @@ -36,7 +36,7 @@ test_expect_success basics '
>  		git add file &&
>  		git commit -m "sub initial"
>  	) &&
> -	git add xyzzy &&
> +	git add ./xyzzy &&

Is this supposed to have become "git submodule add ./xyzzy"?  Or
"git add xyzzy" will trigger "don't add gitlink" warning but you can
write "git add ./xyzzy" as a way to work around the warning?

Or is this an incomplete change that wasn't spotted during
proofreading?

> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 302e4cbdba..f8ef70b5a2 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -28,7 +28,7 @@ test_expect_success setup '
>  			git add junk &&
>  			git commit -m "Initial junk"
>  		) &&
> -		git add gar/bage &&
> +		git submodule add ./gar/bage ./gar/bage &&

Why does this one (and only this one) look different?  Everybody
else changed "git add A" to "git submodule add ./A", it seems?

> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> ...

I think I saw a code section that was touched in the previous patch
that hand-crafted .gitmodules file to make the gitlink it adds into
a submodule.  It is unexpected and puzzling that there is no removal
of that "cat >.gitmodules" from t4060.

