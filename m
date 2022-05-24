Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AFBC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbiEXTkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiEXTkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:40:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E475205
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:40:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h11so23215926eda.8
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Wv/3S3DQ9aEefKwPfPBBtTjyB7Mf2iYcMkamcxryFoY=;
        b=NVB7mqiiqUy1sC4k1WstgbAoXMTuINfQzQ4q8g+vcoFCvs6DvGRvQc1FB4WYQw/oGB
         qIjm+lhOILqVOYZrz4HN0t3NNhwp858gAvbB/wwlDwsjB/uOArFJuV5fuTKaN0dkikpI
         E2BD9AVvg31IVggeUZ4Oql1kZeCtTOGZ0lxec1iZ48LtV4ZEkZdUM1xekf1KhoSVLiUL
         /JSp5BZkHiUUNizsCYpSPGaY+fC1HimLSuPkeqRD9GRViAWOOow3VfybRC6Q5u9MgSzl
         TjXEcSJRKNLPXQ/P2uQ4qFKeQ9Qj/chdedjaC1ik3NmTR9NMxsQYlUYuUetW6uX+DKyU
         455w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Wv/3S3DQ9aEefKwPfPBBtTjyB7Mf2iYcMkamcxryFoY=;
        b=2d2vGBSI4TzLURki5LigqJr3tTG9ThGX77DuOHYSJ89uDSSX0T14wqo22yn6c6/bzf
         UtwRL6M41a3pXnmxRl+S8CoVMtOA9rA6GYafwv1/8IJE65eUB414ejv7yN/5g4/M3iTI
         I/uZi5+wjoUPRhn3ZomtBCnvKv87NxE601GwyfIsXoHfD9T5yODMiYYnyL0JrMwbVkeB
         7ILCu/t1BW5AGhlk8k6W572tPCtsB7xXGZ/77z2msL42EufNtlUe8LTGTtMC3qr7qDd5
         +/uSrRNh6EDqu/DzA+Ozr7mgxp2W3/0UV4VRL5qKHQMw8koSgg6Qj+RDsdkA7CTggwzZ
         8u9A==
X-Gm-Message-State: AOAM532mgw/zEjmD2blJwbRX9xZNhX/Amy3pubCBRUljVToqdpqaSqpz
        aEfG6ENYHOQHp1PSxKJErM4=
X-Google-Smtp-Source: ABdhPJzx7s+7r+BJC0X+2iDhEeKRZkCDs4UNH54b/dcf9plPKKQDPMUiLphNYR0am9Anpz12M1fQww==
X-Received: by 2002:a05:6402:1654:b0:42a:c4c7:e85e with SMTP id s20-20020a056402165400b0042ac4c7e85emr30289854edx.181.1653421208719;
        Tue, 24 May 2022 12:40:08 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906100100b006f506ed0b42sm7328278ejm.48.2022.05.24.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:40:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntaNz-003X40-EY;
        Tue, 24 May 2022 21:40:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 1/4] pack-bitmap.c: check preferred pack validity
 when opening MIDX bitmap
Date:   Tue, 24 May 2022 21:36:45 +0200
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <618e8a6166473d238e62ce6243d9a0b2b72ee2f0.1653418457.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <618e8a6166473d238e62ce6243d9a0b2b72ee2f0.1653418457.git.me@ttaylorr.com>
Message-ID: <220524.864k1ewwh4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Taylor Blau wrote:

Just nits on the error reporting:

> @@ -353,6 +355,20 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  		warning(_("multi-pack bitmap is missing required reverse index"));
>  		goto cleanup;
>  	}
> +
> +	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> +		if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
> +			die(_("could not open pack %s"),
> +			    bitmap_git->midx->pack_names[i]);

Some existing API users of this & their error handling suggest that this
message is wrong. I.e. it's not that we couldn't open it, but that we
could open it and there's something wrong with it. Or perhaps their
messages are misleading?

> +	}
> +
> +	preferred = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
> +	if (!is_pack_valid(preferred)) {
> +		warning(_("preferred pack (%s) is invalid"),
> +			preferred->pack_name);

Likewise this? E.g. perhaps the permissions are just wrong or whatever,
per open_packed_git_1().
