Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB4C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBCD60F56
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbhHCTRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhHCTRa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:17:30 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B301CC061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:17:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q6so29354448oiw.7
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2669Zpaw+bsKKUk2Euq1/DbNAsZhP0Hf+IpnqvFCl60=;
        b=c1x1VWkiHIRTp4UTqfhz9W+ObzcoY9K5mdIlI6Pk9uPrEpdINVgsLwlavB2rPGgExG
         Fx/k5xu1ac42OFwnYS7b1WkoR8kMs5KZUnQB1NFs0Vq2LbQaQia0zIsxU9FhN+FuUp65
         LpLQBUK4DoC90m/CBQ2K215i4Q/XVBAuBh+bgEajX5ViWJCFlZe/K5sLyH0Zox0CKVdI
         oAbckjQ0VBFijTOVnIrpp6qvIiJ4mQT5JEars3kEOaAwe/9xmHZVdUJFqh2pQKDGCGsC
         Vkrs/hpji606lobmzdnVV9GNJEas6ThfURd7rov1hFjaIK7PUJD7IKjKL1spDDIYev5U
         qO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2669Zpaw+bsKKUk2Euq1/DbNAsZhP0Hf+IpnqvFCl60=;
        b=WJ7eDqe+Ed7X+H5csjUleTyN1FVTJsfPt4bT6r+R+JEawmOARZ8Dyhi9hBTeQP2En0
         b3rMZYr/8TLgKog1AH8tL5DavVyS8koDBBWaAyeQ4Z8CF6P2Pd1MSJcSlEtW0LrMc1TL
         G1LANY7OCPJd4G+oQ4aHd2SeTIc+sDpsV7FxFKEyt/3lnxwYwNZlN/XeQkJ8KFyqf4WD
         2U98gyY2pxVQwh6bJbdrVqx7u/QLWeqWhnTGpimZWLZQZl7daCtbRoFkUoFUuLQtZmi2
         0/OyOAX1yx1xxj8tIKU1EgXztC/tcG41lzbgbM93sclUMl8UY7veuFUTHBDoek+B0t/O
         DUKQ==
X-Gm-Message-State: AOAM533ZyxOv2F4LOBuhcCSxa0Qux/vhte9ewiQ7zufqEensQqFT6+zx
        QYVVcgLkdRAGSR0xkXiye7sCQYDtdmTM4l2QMhZLX8cHu5SBTg==
X-Google-Smtp-Source: ABdhPJwCkIMHihdUBt+z+QQbGYzASeotD/V0wdJF9+WvXWuz2didY6u6ys2OA0sGNCD2uGUnqfWP5rprXhui/hv5Lqw=
X-Received: by 2002:a54:4094:: with SMTP id i20mr15724582oii.159.1628018237879;
 Tue, 03 Aug 2021 12:17:17 -0700 (PDT)
MIME-Version: 1.0
From:   Cameron Steffen <cam.steffen94@gmail.com>
Date:   Tue, 3 Aug 2021 14:17:07 -0500
Message-ID: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
Subject: git revert --continue --no-verify
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today I tried to run this command and I just got a help screen. I am
using 2.32.0.

git revert --continue --no-verify
