Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C08BC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiKNWEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNWEg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:04:36 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C7645E
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:04:35 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c1-20020a170902d48100b0018723580343so9861405plg.15
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bdTAc8VlAqpbC7ByO7B983SCNAZ9KZnN8AYaKi3Ra4=;
        b=VkwfguLaiXkbUl3Ob2melweOpr9N74cAvRJmB3WNEObU2b1PpHE5L620iKwOnNtwny
         YueSyUJvnUCmK0RJRDFcfySgIC7YY5EMXMUOFNciW1tNcyxIyk2lxErqIMrG44NmHY+C
         n1N/NfHxLBMrwTpRdIq2X2QZWrYP2QN0Qh27PInmG/PScm6D+9osE9fKp+uV96s8+oJk
         AlCExUEV01/tq5r/NU/dc6HyeqCKgVte39FX+McYaXKfO0dUIKjlE9ETQH2nk3x2DuXG
         LqOvJcMSCv9/QogECCyVaBVf35XbvqwcocW9jZtA7HcFwv7Jt1Tl2eCYKl+PI0JbHk3x
         hR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3bdTAc8VlAqpbC7ByO7B983SCNAZ9KZnN8AYaKi3Ra4=;
        b=Q31UWh+aBm7aiDhHjz0jfjjCZhpI2Z/GLYvdDBjRw4Py32vkxrju2cYMvLBVGS3v1A
         AlS8qKjQ7FZNnwncI3xTaujzDaPAldarqwwX/1xb3lkMYqrRE4mrJPXHcUUxPq+dKiQv
         xWxMduLb+K+a2k6hp5hMxU8wc07pSmQAUWGHZFLce/xqS90GkoZROztOgdY0gXbqbCV2
         I+mMpGyP0XZMnv7V5CLnBLHuh25kHH9qYLGcomAYM32WF6m/m/9AqRP71MO7O44fwWue
         BvTFg6xmD3jJbnWfsG+kh/oCGs0GQ8t/DqkvW8DHUWKhQRdtOmKfa31e+wHiIDEKrM+P
         xz+g==
X-Gm-Message-State: ANoB5pmFxnTgL8C1oC3Ts3UyvXPWwmWdSmmyzTZu7Oj6xnuxa+/lDrqC
        R3ZoE1k5E1DaEnPdTWSq7Uhg9j5/12/V3A==
X-Google-Smtp-Source: AA0mqf4ktSu1xL7U4OPSKg//7fQ3TRBbq/a/16F4LFXo/TJLV408BFyA+TvJme9QxY5fvFKwo1Rth0BM/YheVg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1d44:b0:213:4741:a8b with SMTP id
 ok4-20020a17090b1d4400b0021347410a8bmr15103604pjb.89.1668463475481; Mon, 14
 Nov 2022 14:04:35 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:04:33 -0800
In-Reply-To: <patch-v2-07.10-eaa73f5b1e4-20221114T100803Z-avarab@gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <patch-v2-07.10-eaa73f5b1e4-20221114T100803Z-avarab@gmail.com>
Message-ID: <kl6l1qq5p4zy.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 07/10] submodule--helper: convert "{update,clone}" to
 their own "--super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 40939b0b18e..e13615eb939 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -131,13 +131,6 @@ static char *get_submodule_displaypath_sp(const char=
 *path, const char *prefix,
>  	}
>  }
> =20
> -static char *get_submodule_displaypath(const char *path, const char *pre=
fix)
> -{
> -	const char *super_prefix =3D get_super_prefix();
> -
> -	return get_submodule_displaypath_sp(path, prefix, super_prefix);
> -}
> -

It feels a bit odd that the function we keep is the one with _sp,
especially since the "original" is gone. FWIW, I wouldn't mind if we
just changed the signature of get_submodule_displaypath() instead of
introducing the _sp helper.

