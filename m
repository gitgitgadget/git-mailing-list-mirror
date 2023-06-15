Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912BEEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 17:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjFORln (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjFORlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 13:41:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCEB2719
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 10:41:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54fb1bbc3f2so2714401a12.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686850901; x=1689442901;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/njmXvrEuV7X/anYiuzy3umz0zZ3CpYrR6kC74jKsA=;
        b=Fj6F3zfBk7BVcy9epWgydsR80T63xOIuO+WJRiDBit6yB5sS5VMe6AjUPkCBa4du/k
         NSlGTwpgJ4fTRh3k6IGE2016oTnfVe3hor3/F8m3PJjILiNiHwYt4CM/2w2nTR8z0gV7
         CsgrQSj/wyThICZRbz6QbzUud9pJWioI2IBTccVrE2bm9JnnMrI7ZIIm0A3yeSBNE8Zu
         ZjjFNzzwdgRbYQhNye+XHk4YdQimO10/TVv4AhrPTc2rutZkR6OQpICxiR1F1HaJ05CB
         +nz7QinRVPwtBo8T6gI5e4satFgAnl9DBno1eZf4s5d681Lgj6akIygphPseSATMUMjT
         kjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850901; x=1689442901;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r/njmXvrEuV7X/anYiuzy3umz0zZ3CpYrR6kC74jKsA=;
        b=dr5gHNMcfBQ+Fk4veaOfaX1XfxpO+KUUv3WZ/jLdEW9uWPruM1IgLpF3bScX6Clqdd
         Rit8JBA/YNx7zJ9PgUpcwiTKNPUBd/s69FuxnLxfsjwkyixCCMyAqpmAYQL1f28g6gTh
         CNCfCuU/Q+AZD1AucnqBoY4Sxx6VOAot9eaoQ3VhsP5XjxOybZkW39cpQh168GaKXIdY
         B1gXUH22IaA5nry+f6sqDOnI/RjjT2I8n986vGlIHSM/EgbpFZyeKSJD3yG5xMlwMydG
         6kjOUaEUhUo+oS/C5MrqivzXX0uqF1BP0kjPF0e/rvQY2L7dErjf7HYqKL/7Qlp4HbFt
         e8Dg==
X-Gm-Message-State: AC+VfDy+UkHmUU+xf5ZOzeaqa3AqnZpci2bMyLXFG0HF71OMz1W6U5f4
        kbnfQovFJoyy67OOhZFSJe8=
X-Google-Smtp-Source: ACHHUZ7aQTUG+MsdJdiQ3EnZ9ricC4Z22f6tzpXLkRuX9DbVjzDNzXWZoYpK8RABn3h14EQRNBQxkg==
X-Received: by 2002:a17:90a:5183:b0:25e:3841:1921 with SMTP id u3-20020a17090a518300b0025e38411921mr4654236pjh.20.1686850900794;
        Thu, 15 Jun 2023 10:41:40 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id mm15-20020a17090b358f00b0025c256add5dsm2930962pjb.32.2023.06.15.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:41:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: adapt to `cache.h` being no more
References: <pull.1544.git.1686844054022.gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 10:41:39 -0700
In-Reply-To: <pull.1544.git.1686844054022.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 15 Jun 2023 15:47:33
        +0000")
Message-ID: <xmqqa5x0wrl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This is a companion to 4275a22e169c (cache.h: remove this no-longer-used
> header, 2023-05-16).

Thanks.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     cmake: adapt to cache.h being no more
>     
>     This is a companion to 4275a22e169c (cache.h: remove this no-longer-used
>     header, 2023-05-16), based on en/header-split-cache-h-part-3.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1544%2Fdscho%2Fheader-split-cache-h-cmake-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1544/dscho/header-split-cache-h-cmake-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1544
>
>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 2f6e0197ffa..4faa419cc3d 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -227,7 +227,7 @@ add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
>  add_compile_definitions(SHA256_BLK INTERNAL_QSORT RUNTIME_PREFIX)
>  add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
>  			SHA1DC_INIT_SAFE_HASH_DEFAULT=0
> -			SHA1DC_CUSTOM_INCLUDE_SHA1_C="cache.h"
> +			SHA1DC_CUSTOM_INCLUDE_SHA1_C="git-compat-util.h"
>  			SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
>  list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
>  
>
> base-commit: d677f7e76abb837502c589d17889cf8ad591dc09
