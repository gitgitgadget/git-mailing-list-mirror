Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230D4C77B61
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 02:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDNCIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 22:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDNCIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 22:08:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E582D4A
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 19:08:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j17so32399311ejs.5
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 19:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681438115; x=1684030115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG7OSF2jE1go5QkgOX7M5rkZzUToD96UeDSIijZqSu8=;
        b=LsIApJj9dIUwe2SI7H+9eDohy0o3x6igpllYqJINFlq3lsZlSOZn90jQppHkdFYx92
         7aQepjbFJ1AoVoTUxTg1xqp6i8Fxo/Gqkuq9f+ch4SxhA/juTlchukyC5b8KWniHUqb3
         5obOcFEaVxSKFcevA+gTf1zAxK1A+58ELygwlG6pqre8zGVeLnTrD0W+gGw2QjdXE2tQ
         twWPzflMn/3eiklRs4hwwkZ4ma2eUhUWPb9hlK6VCEIcWxs2Bi9nQWL1lObOrA5NECxL
         ePj/qyDiffBO30MiM2wpnTRxmDA9s4iL8XL1Dv1MANOSc7HeJuehN9aF/XGp5MLv1XL1
         aLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681438115; x=1684030115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG7OSF2jE1go5QkgOX7M5rkZzUToD96UeDSIijZqSu8=;
        b=WqkMZw4blriwCKG3hvuqO2yzpa7ahT5QFR3TRACSrQlvau3hZEPxD8M6EpcOGUgCak
         sHSc0wgNso4suq6PKLTbsuTZ6tUqs/Spm3dUymMni9URwmTab2viAglBPJFoEdvxlKx9
         UL7D5NkbubNLozGgbqdyp+ZYNhltOCmp7MM2CWtyLbyaJga6AERNrSkuo08L0/fjXAH4
         dRH1ytxHWNF6jEws2orvrlKngdjjbMpOJr3FK/U2R1y0LTSaSnO94h17OmfYH6cXXiQ7
         0HldPyvy4Dra1adFA2p+wXt54qifICpod8tj/LH3rT8G/94T3xpc50jk7wMwh2eFkt7n
         YNww==
X-Gm-Message-State: AAQBX9cRIB2U1RwuAb21UUIbC3VVvMfIqjeZtLU1azYihxNvubXAfwU7
        YnZqw0sIHB2wUbx9lMwlASvg5PxSZs7ZFAlajwM=
X-Google-Smtp-Source: AKy350apzqSyY1czmNXRQCydjFd1PANXjJC43HhME6s7z8xo8QhmFA5Cl+wKLX1gKO400WXouGej0InS/EfeWKYejtU=
X-Received: by 2002:a17:906:1406:b0:94a:4c68:c1aa with SMTP id
 p6-20020a170906140600b0094a4c68c1aamr2390439ejc.7.1681438114694; Thu, 13 Apr
 2023 19:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681428696.git.me@ttaylorr.com> <1d955f8bc6d2797def516897d019a186e461b648.1681428696.git.me@ttaylorr.com>
 <xmqq8revw8c9.fsf@gitster.g>
In-Reply-To: <xmqq8revw8c9.fsf@gitster.g>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 13 Apr 2023 19:08:23 -0700
Message-ID: <CAPx1Gvf8JgsPg3V-VO+RA3XL_DxMaHEv8MLOh+DjEo67nT=v_g@mail.gmail.com>
Subject: Re: [PATCH 5/5] banned.h: mark `strtok()`, `strtok_r()` as banned
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2023 at 7:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> ... At best, they may point out awkwardness of the function [strtok_r]

The awkward interface for strtok as extended to strtok_r is why
we (Keith Bostic and I) came up with what's now strsep. Of course
strsep is not standard and has its own issues but it can be used
to parse $PATH for instance, or old-style /etc/passwd entries.

In this case (tests) it's probably not that important to be efficient
anyway,

Chris
