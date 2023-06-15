Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F2EB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 03:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbjFODG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 23:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbjFODGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 23:06:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09426A9
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 20:06:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5428d1915acso197865a12.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 20:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686798414; x=1689390414;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbHCr3b/fGo+QPXj+OqAQx/CIPTlcYZ9cSdP4DdV9jU=;
        b=bFzxWOn4vVj0Ot4JuF8RiKBYwssSfYaD/Z67GNYaKDUS9mL8DXUBf99OwkotIZWX6P
         difRv6A28NMKzmdv5VVyY3nMJefVVU0AS5CmMrHXJcCDnjDjDdB4dVoo3KTqkBV0Df6t
         B/rCYIlzWnPHYbNObxoX6IHGfNl8n3ZopBo0QpPc9nj16Vc1bcjckbTnj9fABPXy80e4
         fXEFkGG2icQxzJ2vjVdJKNo+mdLg5HQHb2avMJbDhJGFYWOOvXjtZIzj+5muqrQm9tQw
         E4dKWWHicUMkt3BawDgJVCkTqNTEDXuRGFClPAdErrfEM2y+ViR7ZLiJXZZI7e1q3GBT
         QukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686798414; x=1689390414;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbHCr3b/fGo+QPXj+OqAQx/CIPTlcYZ9cSdP4DdV9jU=;
        b=k3Q3EuSBwPV8uXW+UIR/oiW/RerCf5qdFl9iOnljEusOIP+uvSfq/Qb4GTSf1bz073
         P06LTyAyWn3QchlX1VVjfsCGpvN61T38iizyHUMLV+DkiyljWAZeIiZQVirS//GteeLz
         4LCHX15dbsJmbYOdHkF8rTy5butnTLvYTc01qGWH3aXG6wZ2LfXAD/5lUfojflZnNes1
         Xp6t3mOJHoRi9cBFq4G0/U3ifzFTvvsWkp87YlkF+BydgSHxA3baXHFkJbEZtw3vfK2T
         V8rIFWmCqvhqJ2EbNaQuxBAsmTy6fxYoPQ+hNY8xSL32YpKk818UYpRSpfHto3eh6B7h
         ENBg==
X-Gm-Message-State: AC+VfDx+fRERq/Yhgne5XCMNz+tep8Woqwm1zgyU3iAFbsZms56FQkaQ
        uhPN6QH92UCp2d/ax3DyUWoGNRcpWv0=
X-Google-Smtp-Source: ACHHUZ7KeHYmEwBnV09Eikp2qNmVrWM0OtRwcp0aY7IgXUuHtJ/2sdwusvoOU0mqfSR5wIRIUmeCc0hVbrw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a65:434d:0:b0:528:a60c:c06b with SMTP id
 k13-20020a65434d000000b00528a60cc06bmr530422pgq.1.1686798413848; Wed, 14 Jun
 2023 20:06:53 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:06:52 -0700
In-Reply-To: <CAP8UFD1uTFCMoh9SnxNpRkvAK=6_VLLo_7yH5tuqS2auyX5G4Q@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
 <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com> <CAP8UFD1uTFCMoh9SnxNpRkvAK=6_VLLo_7yH5tuqS2auyX5G4Q@mail.gmail.com>
Message-ID: <owlycz1xo243.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 0/9] docs: interpret-trailers: reword and add examples
From:   Linus Arver <linusa@google.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Q2hyaXN0aWFuIENvdWRlciA8Y2hyaXN0aWFuLmNvdWRlckBnbWFpbC5jb20+IHdyaXRlczoNCg0K
PiBPbiBUdWUsIEp1biA2LCAyMDIzIGF0IDQ6MDjigK9BTSBMaW51cyBBcnZlciB2aWEgR2l0R2l0
R2FkZ2V0DQo+IDxnaXRnaXRnYWRnZXRAZ21haWwuY29tPiB3cm90ZToNCg0KPj4gVGhpcyBzZXJp
ZXMgbWFrZXMgc29tZSBzbWFsbCBpbXByb3ZlbWVudHMgdG8gdGhlIGRvY3MgZm9yDQo+PiBnaXQt
aW50ZXJwcmV0LXRyYWlsZXJzLiBUaGUgaW50ZW50IGlzIHRvIG1ha2UgaXQgZWFzaWVyIHRvIHJl
YWQgZm9yDQo+PiBiZWdpbm5lcnMgd2hvIGhhdmUgbmV2ZXIgdXNlZCB0aGlzIGNvbW1hbmQgYmVm
b3JlLg0KDQo+IFRoYW5rcywgYW5kIHNvcnJ5IGZvciB0aGUgbGF0ZSByZXZpZXcuIEkgZm91bmQg
YSBmZXcgdGhpbmdzIHRoYXQgSQ0KPiB0aGluayBjb3VsZCBiZSBpbXByb3ZlZCwgYnV0IEkgbGlr
ZSB0aGUgZGlyZWN0aW9uLg0KDQpObyB3b3JyaWVzLiBUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3
IGNvbW1lbnRzIQ0K
