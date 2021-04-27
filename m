Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2370DC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E473060241
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhD0PWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhD0PWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 11:22:21 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D6C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 08:21:38 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id u22so19231547vsu.6
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=II8Ls53RclzYUcWQjTCZhqcGp0b0FAABWAgmFqUlYuY=;
        b=RWmTnKqDy+BI+Q18GROKb4XsZSnt+zAmYh9sqSA23UY7Kywqs0EQc8voslPrTjQvBq
         aXP4uX7PRArDD7hJVzAzMcy392djUOHYhBahv+TZSCKcDmFFHoJeyUrfkFxaDlDpQkU9
         7TtBn85pFHeMZuEOCkCSc+XH6/Qt+8MXGyWw+SZ6o3BdYObMyW8l+3Q9hFFawCoeam1D
         s/ntXatjgUcw9cfvXwR+i1HRHdBqyMx5LW27nJEO4/7sDY4L1kcm8Vv2vaJoE7xdJ8JY
         n8go+rXKv2CrjMpQFN/UbDlQH900ofCKUlpAT+7TnxEfF4nGO5GjOegPnq51jkPN9ORn
         7rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=II8Ls53RclzYUcWQjTCZhqcGp0b0FAABWAgmFqUlYuY=;
        b=pnNSr7b52oIrpBfcsl07+0ED/xUbO3iPcumf00qkD6fOh6UghwjLm483eFj3ztnIwI
         9bjtqKdQ1L6cCWoQg+a8xKmGo2HxFcQZUIDMxMGGHboyOwBMvNYS7YGVeWaWLw82IpnM
         1IGjAod4exf61DVWAwoRLq8ZFa4y5nuKGw3c/Ic3XD1xh6iNq8lyZDw0Tiawj3MnKHTw
         N/vPFWO+w0QL4THsx+cWoIW/4ZVyMKCJHuD6UZhOWv0EPf4dk37/g9+KrEe+26Ttf1m5
         U/+AZ5Lw40m5aXgC67Q9udEXmlyrqqqtcJMYwTjOrE0/PDA9qRd1fMMV2V4ka0WQLhLI
         pRrw==
X-Gm-Message-State: AOAM530cGeLYfU8/dHQz1UNgj1utlPIKVexUWxv9yqnjVrD2uMOKzRk6
        ZoaA8UorcINTIeydSAs9ahlcTuvhO2GuVpSYzgKJeQ==
X-Google-Smtp-Source: ABdhPJyIcpPdrzBC7lbAG85s8VvtYtdZLtvaI8/7H3eSmXFCCVGYEnNoK6fzeZq3Tw6V1gP4Auy6iFJBO9ldOW6gKSo=
X-Received: by 2002:a67:eb45:: with SMTP id x5mr18955991vso.28.1619536897195;
 Tue, 27 Apr 2021 08:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <554bb1ac3aed066eb578a305b7fe76f1660f6153.1618832277.git.gitgitgadget@gmail.com>
 <xmqqy2dc698w.fsf@gitster.g>
In-Reply-To: <xmqqy2dc698w.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 17:21:25 +0200
Message-ID: <CAFQ2z_PUwjVOShyDi67bw2X7K1x=s66Lpwn14UcWeUrksJSRbw@mail.gmail.com>
Subject: Re: [PATCH v7 02/28] refs: document reflog_expire_fn's flag argument
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 9:34 PM Junio C Hamano <gitster@pobox.com> wrote:> =
> +/*
> > + * `flags` accepts a bitmask of `expire_reflog_flags`.
> > + */
>
> OK.  It would have been better to say what expire_reflog_flags is
> (i.e. `enum expire_reflog_flags`), though.

Done, in the last version.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
