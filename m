Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B135C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D5920733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLQSnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:43:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37838 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfLQSnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:43:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so4352150wmf.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 10:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAW5Xa0iAmquJwknc0zW6eKKWaGnz2A0goQqt4RsV/s=;
        b=rYR4/sh8G1aQ7LV36cA7TrxIPFx9wqn7OwfvLv4YDpyEnkx78ylh+CKP3epm1wVmHS
         AkTsCmFq6ck4UnZAmBUukkI79UuGRBM+wm8HWKP2/MdK7SR00WKxZCsovSdDv7TXlQw5
         w5KB3ulg1cbf3+cJ22JvNkRlVgtH1nAKbrbJ4axqcjT0XadQty/cf0gQvZ7GnffDDXem
         IkPoOgy1egXulAD6zogx1uqtYUSsRs3IQM3rRByF+RUaP3z1xNona64V4mI1ckj87TOZ
         JGIPfZFZaP57uxve//crQjyy398bdlvwy1xokcycGLFBe2GF2Lkc5N8exTEvMX+T1aBY
         d25w==
X-Gm-Message-State: APjAAAU4yigmtleMz/2VQvHjDlhGXdkZlf1weLFoMhhtAabciVuoyuT4
        8HcHR5MhT4276LGjvHKanOFe8SKamKUeyX28Hmxa7pa7
X-Google-Smtp-Source: APXvYqyJGIUZQZAn2voLdQcfmcwIL/8BZFUlRld+C7VSAudsJMdVQ+9+iHePfgEqCo4sxq0A/IDmSi0xCzt01nwo4t4=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr7434932wml.55.1576608193581;
 Tue, 17 Dec 2019 10:43:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576583819.git.liu.denton@gmail.com> <f1acb2a0dfb39a4ff047d721edde821e9e296e72.1576583819.git.liu.denton@gmail.com>
In-Reply-To: <f1acb2a0dfb39a4ff047d721edde821e9e296e72.1576583819.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Dec 2019 13:43:02 -0500
Message-ID: <CAPig+cQ4=CeGJmVp4S9xdR9UVN2mLRndX7+cCdSn8rhaEgdcmg@mail.gmail.com>
Subject: Re: [PATCH 04/15] t0003: use named parameters in attr_check()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 7:01 AM Denton Liu <liu.denton@gmail.com> wrote:
> We had named the parameters in attr_check() but $2 was being used
> instead of $expect. Make all variable accesses in attr_check() use named
> variables instead of numbered arguments for clarity.
>
> While we're at it, add variable assignments to the &&-chain. These
> aren't ever expected to fail but for stylistic purposes, include them
> anyway for stylistic purposes.

As a justification, "stylistic purposes" isn't very strong. However, a
solid justification is that keeping the &&-chain intact even for these
assignments means that if someone comes along in the future and
inserts code _above_ the assignments, and if that code could fail in
some way, then the intact &&-chain will ensure that that failure is
noticed rather than going unnoticed.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
