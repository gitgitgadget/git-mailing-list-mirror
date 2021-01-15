Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A37BC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDA1235E4
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAOJP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAOJPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 04:15:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFDDC061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 01:14:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id 6so12289994ejz.5
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 01:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CGXHWjalCL0dWACX4h8bYRB9GukeW50TQaBQDkEWXOI=;
        b=JYRWeLz46U7MMDU0yvm1bD35ltmhRXzbzy4qvDnDi/IUjyukiy3cc/NJXzCbcH/BEg
         Heh61Cp5zRCAeDi4OzMHavMGkOrwcTueirRu+lltlVPA6jDPgv1ue+TTMh6CG7mi4N4G
         36sOJtrDqhVbcRMQuF7rTIKlGBnhv0ZAGl9uONFEkJYGUeP6JYWkcbc+EVTvf+W6rC3j
         30M47TKdBs7i9Om97X+qzhFr4c9pMd2v1fw27IOp1f75PKetaxQGNPtjnPwFjUGHxLJk
         Z0CXMfJIEz0srhErcHt+2+pWN6Nm+vIzM5/JsG3HWOwnF35pJzhK3OU7ALxZE3m2iSdA
         Wgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CGXHWjalCL0dWACX4h8bYRB9GukeW50TQaBQDkEWXOI=;
        b=ZrcrTlyL9rOhbjXiYyDz8WKc4HhtJ8b29H38sVzVA631+3gzlmFlMRSQJLKBEHUE4Z
         q41kdNHeN/pwtjMPNPjXNqfG8cHlL+vsF8BTc6+KGyRT/O5TL8YiUwbhjk1+Sh4jqVP7
         XkS2gBXjQOBXDpFearDTvj4oJPOMuxOV4PziTrsqcMSijvsVuqrGqoQuWNtCa3GEY+DJ
         5EJSO26YXvop7mz6FJq5t6rOJ7e8/Lyt/Jku9tbm6vpfdeK1Pbp/yDYchTyP4K5pV8i7
         hsfjzncxfHLIJmsNL5FHp3XIqwWLNkN02r+o9sSFAaz39ntuBUUlbV3Y7en811CaXVh+
         5NTw==
X-Gm-Message-State: AOAM5301MpdLvcSG7iTE4hI8E4DxH2ru8uVYveNYg4NELlZ5ZZOrVP6f
        9PNIGyVusdrpLWZC3w4UsZddYJH6oZkilA==
X-Google-Smtp-Source: ABdhPJwykWVN70tnpKbv/pgyBsp7wlZuAwiJlepEVnZjSSekMMdVv1zH7Ss0XRy9dAfMwyultaBSfw==
X-Received: by 2002:a17:906:7f83:: with SMTP id f3mr7821170ejr.282.1610702083371;
        Fri, 15 Jan 2021 01:14:43 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id p16sm3262266edw.44.2021.01.15.01.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 01:14:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/6] tests: use "test_might_fail ok=sigpipe grep" when
 appropriate
References: <20191115040909.GA21654@sigill.intra.peff.net>
 <20210114233515.31298-5-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20210114233515.31298-5-avarab@gmail.com>
Date:   Fri, 15 Jan 2021 10:14:40 +0100
Message-ID: <87r1mm4l4v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 15 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>  test_expect_success 'cherry picks did not become git merge commits' '
>  	bad_cherries=3D$(git rev-list --parents --all --grep=3DCherry |
> -		grep " .* " | cut -f1 -d" ") &&
> +		test_might_fail ok=3Dsigpipe grep grep " .* " | cut -f1 -d" ") &&
> [...]
> -		grep " .* " | cut -f1 -d" ") &&
> +		test_might_fail ok=3Dsigpipe grep grep " .* " | cut -f1 -d" ") &&

So, "grep grep" is an obvious typo there. Oops. The test still passes
because it's fragile to begin with, we're just checking that we get no
output, so "grep this string is not here" would also pass.
