Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B675C433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC32229C4
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439581AbgLLQ5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 11:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439377AbgLLQ5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 11:57:06 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD0C0613CF
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:56:25 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a11so4428853wrr.13
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd51Lq6rrVdoA8YsQhHVeUTtJvVqIhode6ev++98ttU=;
        b=GQ1SzIUj1mJGN2tVCfBiDEKFB0KFgaxc0OVBR4DXqkapnsEi4lqFqRruvNV7L0Dyt4
         M29gU/QT+aUqDG/HtJX3MTrkyaFyHqyMrTZCx0so6EZPq+pLipgURkXmidX3QHjgidFt
         vQ0rnrkj1UxcuCp6TCZVZZ307X78uaacn/SG+PcKLzdSBcTS1RwYV7InhkPxHTBRXGbg
         CxrCCVA0TMd64n247qnmQ+rqtcwyi+bKRTuXNSz+jZCgB4cyPOr8FnwXyrie3rcdTGo5
         7zkRwN0HgiuzhrBNKWMJUIGyFUvJEY/MXYHywJZsksm1AKplL3jhhtRhx24CYxakiKk1
         lxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd51Lq6rrVdoA8YsQhHVeUTtJvVqIhode6ev++98ttU=;
        b=Z08UBS5qkwyWapooXc/SYkbhgATPTffScg6BFyP7vXXeiLZzGUHOOH/9q0Voh4i3ZB
         pmZ2jZpociKNpX4lK5Po0Ou64TCGW6KWaKOtlcCnJp6enRBIwW96LDPtKDQjjf9IG34o
         iWI1fWgYHb/uMb5jN7kx2XuA9bNnsaS+A0QYdcSAbPJgeH9BOwyo+83FnGLZScOfB4iq
         iltqcRs6M6cLoRQFSW+75mNIzgRPZE1WHKCpAmfMwVCG5UAx5lYKcTCsyTfZSSPGzBCe
         7JCf7LX52IMaggcFKvIrppGmV7o0EqsH++9dAa1P0yylbSLvxUjZTKSIyQzjkzhVvpn4
         Utvg==
X-Gm-Message-State: AOAM533qsjyOkQrvuLBQVTVyU6GnI2bgxPVecBfLvP2exbmNvQpDBnRq
        Iq35TxYNmU1LKFEf1PmxtcA4Qm4TGQGkTRGBo/jfqph8StQ=
X-Google-Smtp-Source: ABdhPJwQRpaoKiuSKfDvBX6nelGIzzaD0bgkdVnDCRC7qeyHYdNXCBENdIbHgFxTgOCPEWWLlaqiC38K5n7qG/1oz8g=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr20105178wrv.255.1607792184408;
 Sat, 12 Dec 2020 08:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20201212165208.780798-1-felipe.contreras@gmail.com>
In-Reply-To: <20201212165208.780798-1-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 12 Dec 2020 10:56:13 -0600
Message-ID: <CAMP44s0WPpGzZHU2tQS4OJwuC2P_zXW+ZpO4rB4w2hEgVUcp+A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] pull: stop warning on every pull
To:     Git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 12, 2020 at 10:52 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> The future of having a sensible "git pull" default is uncertain (it's
> very likely that nothing will change), in the meantime there's no reason
> to keep annoying our users unnecessarily.
>
> This patch is doing one thing, and one thing only: stops warning the
> users on every single pull (warns only if they are not-fast-forward).
>
> Changes since v4:

Hmm, it's not 4 -> 5, It's 5 -> 6.

-- 
Felipe Contreras
