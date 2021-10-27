Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD76C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 22:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6B160E75
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJ0WQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhJ0WQd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 18:16:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF143C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 15:14:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f3so1053912lfu.12
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3geipHf6aFb/oVA4Oe7f28znBnbOBR1+WPbFFbMoZo=;
        b=TGOTBR/Sc4RBd2inq9jhPEhf+IsvwbEhqM2tDoBQa2CJXzNKXi113yMRsBCBcl7S2O
         E2TOXI2ZIzUbRrGbO9791sftgAcBKLUDnC+4OT0gFqq4JmRD+z9MYH+fdE+ZREOFsm4O
         ggtEXGYfxaWFTNxTKDbSF885aXjLq2mm8H6SbeApy735/V3JSzsT/2cdryGKofFNxDcm
         YaQ6KVCNnf7h7bMUglcjzQUr5MRDdeUgs1Q/H7b2s86slQ6ekowWsRN20hzeOLQoURge
         i3wvg9ItlwcxNS9NGdGInLoGhlV+rZTUUeEVgvKCgD4sZeguDgMQTp8OQCsuUB2cq0oK
         nGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3geipHf6aFb/oVA4Oe7f28znBnbOBR1+WPbFFbMoZo=;
        b=2M/uXLzLwFmvdBefFggdRpLOFILtjNHCpvlOS3RQoEsi0ZJ3qDk5gCO5+OW/ujIMXY
         1azs8Kso4F2YuMPY0QuYfi6sdr8xmF82YdwGBIvjmTjs5m0UMSOka5zg/v2N/xDd/2Nk
         O3YCT4LlGKNk0VpXfvOdxZUB/T4D/IctC/AS9EVc8YniCbEMMn11mV7HyEKm/lqVD8h+
         upItz4Q9Cirgk51R6GRTBXaVI7Lhq5CVepIK8a3cB8ycRwLezWeTH3Dz7ykk/rsYXckN
         pC5O+WcyQoP+feck+b6xt4NpkWoi/KaNjXPBgng6jxmaP7k52D9Bf66S2ailUsntA7W+
         dItg==
X-Gm-Message-State: AOAM531GB8HOS5oxLgsa7NXd6jABAGeoIVJCwYqU5hcP430M5Aq7SRSB
        ntR9CcKCTL8uBoBwwjJDg/t4GkSjpKqnf3HLzTE=
X-Google-Smtp-Source: ABdhPJxzqE56z/puoEPlGdpIHQYlDtp7364HA3ycuWhjQK3e0G8MkUxmtPD2RR4pAlb5rUuTv/tLEBf8ejw+mGFOf90=
X-Received: by 2002:ac2:4e43:: with SMTP id f3mr369475lfr.364.1635372846218;
 Wed, 27 Oct 2021 15:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
 <ca1c6a86-23ab-57ae-b1ca-64a9851d72db@web.de> <00a67af9-da41-6df4-afc0-5ae7c7714bfd@gmail.com>
In-Reply-To: <00a67af9-da41-6df4-afc0-5ae7c7714bfd@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 27 Oct 2021 15:13:54 -0700
Message-ID: <CAPx1GvcBXi127ujDBNgdpbvc_yB=BpvgSBNN62KYZb=8b52k_A@mail.gmail.com>
Subject: Re: [PATCH v2] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 11:17 PM Derrick Stolee <stolee@gmail.com> wrote:
(regarding a pointer that "backs up one before the beginning
of the array" as it were)

> I also see the specification saying this is undefined, but I do not
> understand how any reasonable compiler/runtime could do anything
> other than store "path - 1" as if it was an unsigned integer. ...

This Standard C rule dates back to old segmented systems.
If you put some array A into its own segment, and use only
the offset as the "pointer", and the segment offset starts at
zero, then A[0] is at "address zero".  So the imaginary element
at A[-1] is at "address max", and a loop like:

    for (p = &A[N]; p >= &A[0]; p--)

is an infinite loop.

In practice nobody is using these architectures today, but the
restriction still exists.

Chris
