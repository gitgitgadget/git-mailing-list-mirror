Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDCFC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjDXW0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjDXW0f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:26:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A514A247
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:26:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso736137466b.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682375167; x=1684967167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa+m1edfuxLRsG0HduIv7C+HPKADoyXwMOtkShvvMf0=;
        b=C51pvlxAe+8YdAPxOU9vJQ5iUgKZWIFNSjStTummccE4EPfGEITT+W1isp2m/jiU7J
         HbdP5JxQfELcK4WTOtRosZmtflpNs4TsbGRiQSqkPlicCJ9N1U/+glJ56WQmhoEqh9CE
         LR+7+h7LzpctEyGNBdjzS3smQ7GLdnshd3EqZ7pmcZW5fGT4hguP5hsbi4M0csEPbu4I
         niFoHS8pKDt/Rp2R47UI+/JIIt0R2v1wiYW3FBVLEWIxZ815dJnEyWUS4NTIpaRurVww
         vhxJXKMYn6jGbdgohzSBggIiMiSCLbhbOpsEiKaelGmQx4lu5H3SYl6QAoaaRkLTThEn
         pbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682375167; x=1684967167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa+m1edfuxLRsG0HduIv7C+HPKADoyXwMOtkShvvMf0=;
        b=i8Vq0GTCev2kWysr3eUz6QSk99A+iR20Z3YuQ4uGhW3Eyn/Lb4Cx72ruFGejQqcaK6
         FKvuOIXmQBH4C+Mj73W5Yhw61D8wnWPV0t+WsnQg8B3xs5VycAp9U+q+pSXw3LdoANXs
         PHrLeBup2CI/Li5JVb9ZF0jokCXBzlAvyDuDsD5KmvI4KHmmO0OBq8qiVqlbLJSUJCwl
         9pK9OXNXDm6jsBL2C3Q9Gr/D+HQkUPKlb6rGMLPap2dVJDr9GISVoJ0UHtPuG+nRvuuE
         M+E6Y9e+15ReaUJfnINhJtvuYFp2c+gRgDO4yGrKWcQ2+er4a1vgHumx8Gxh/TDSMK52
         OnnA==
X-Gm-Message-State: AAQBX9fEWKxsg3boTwz4aGMOJRbmNqLV7vme8YdxIP/qR87FzUnQvEvu
        csqcc/J6WSe6HGV47MMj69yu+OOToZ5RL7hgNcM=
X-Google-Smtp-Source: AKy350aX7EdfoVBD9wtuRbgS3eKEu5nV5RskF2sgz/xFrzlNnIA2jC0rHhoo/FnydogK7R5pVL67WLNfTNwNbauBjbE=
X-Received: by 2002:a17:906:66d0:b0:94f:8f37:d54 with SMTP id
 k16-20020a17090666d000b0094f8f370d54mr11123591ejp.44.1682375166991; Mon, 24
 Apr 2023 15:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681428696.git.me@ttaylorr.com> <cover.1682374789.git.me@ttaylorr.com>
 <da896aa358eab65f2629f85189c5be4ad9cec635.1682374789.git.me@ttaylorr.com>
In-Reply-To: <da896aa358eab65f2629f85189c5be4ad9cec635.1682374789.git.me@ttaylorr.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 24 Apr 2023 15:25:55 -0700
Message-ID: <CAPx1GvdHWBdA8XZu8ZHf3PO3QC5qVpb9UdNMG9Xegyk_9ZtHwg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] banned.h: mark `strtok()` and `strtok_r()` as banned
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I eyeballed the whole thing (not the same as real tests of course)
and it looks good, but there's one typo (missing-word-o) here of note:

On Mon, Apr 24, 2023 at 3:20=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
...
> But there are no instances of this in Git's tree which are more
> well-suited to `strtok_r()` than the friendlier
> `string_list_in_place()`, so ban `strtok_r()`, too.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Missing `split_`. Probably not worth a re-roll...

Chris
