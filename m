Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5672C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 05:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0AE61CB3
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 05:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhGGF5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGGF5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 01:57:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824DC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 22:54:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o18so1095550pgu.10
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 22:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2vpZFDxA4kUdl+Zsm7o/PfXxywnJXRNo+AHut7hhbe0=;
        b=PK7h8giUu+YKgKlrg7+H953K/A8SDkE3LeLaGIE33weKjEtRrDRokgapyPO8rvv8vp
         2OPBRK+uHg1w1Lk2ZkVyQW08W9okguiqjNeJFdcv3PoxGjccHv+QDfi57GzJUNXEHM7I
         22m4llfNPrHmojMntZg0QgccXOed8QzM9m1QZf+j5Lqix0JKD90ZOX3L3VDFSCSkr0d8
         1+C5WFe732OtB18ufceoKVioNltXDSWIT00Fh+om6MErXccrGdsYhAdTTc5zUJo1xXct
         pBRnBVI77vZt0GmQZh5vbyLEmQaEs/sRu4Y4rSRrZ58DBvYyEEquD8xVAXe2m6cyBofQ
         EBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2vpZFDxA4kUdl+Zsm7o/PfXxywnJXRNo+AHut7hhbe0=;
        b=ghUv8mdKfqK2xqBemm1eiCMDRNwr+MmG0yoAkuqdQwCK443WOB8RHQjqS2sK3C2/Dw
         NplRvdEuJEy11MklJLkmiKstu+7qKafgLRSQLIYSytBDuuWCrrmJwL7o2EZvvKqBeLqe
         TXDIdLRgIevCtlAZx4wu7sJB+uyjVDUB66htn68BC7hvnyBGF/ZFzHRur6GlHSTEtgR+
         LG7YgSJNFkyg32YyGtzs4/r19D1iDDreG77J1dy3WOLJMsGxsPDBDllQsA+uuud+ldm7
         YRMHTq15ra3NfxSH+TQbkxeLwATK/eWeAeXoHzHHgFpa/6ZCACxOxBqlcPcoNAI+NIeP
         YM6w==
X-Gm-Message-State: AOAM531i6MpR9LAwLcYDqynx1hYWd+Tl+8x0bqDhELLUyVNGi3jJ68TK
        MIulNTID7fHpqO6HCXVKieI=
X-Google-Smtp-Source: ABdhPJzN6l9c6jOg+2gLJrbnYxmYrg+gHMCatuBKL2YEhVK50HKcuVjm0Mf0OGGT+mgV+7cJZz1xhg==
X-Received: by 2002:a63:3854:: with SMTP id h20mr16228648pgn.209.1625637264314;
        Tue, 06 Jul 2021 22:54:24 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id o34sm21777090pgm.6.2021.07.06.22.54.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 22:54:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: What's cooking in git.git (Jul 2021, #01; Tue, 6)
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqqim1mgbty.fsf@gitster.g>
Date:   Wed, 7 Jul 2021 11:24:21 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D929FDCA-C4FD-4A25-B683-7F49E8C769B5@gmail.com>
References: <xmqqim1mgbty.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-Jul-2021, at 06:49, Junio C Hamano <gitster@pobox.com> wrote:
>=20
>=20
> * ar/submodule-add (2021-06-16) 3 commits
> - submodule--helper: introduce add-config subcommand
> - submodule--helper: introduce add-clone subcommand
> - submodule--helper: refactor module_clone()
>=20
> Rewrite of "git submodule" in C continues.
>=20
> Waiting for reviews.

Just a small note, this series has been superseded by the [one] that
I sent yesterday, so it would be preferable to get reviews on that
series instead.

[one] =
https://lore.kernel.org/git/20210706181936.34087-1-raykar.ath@gmail.com/

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

