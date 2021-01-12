Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC2EC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB4E23122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbhALVhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436955AbhALUcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:32:52 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E3C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:32:12 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 81so6831579ioc.13
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:reply-to:date:subject:mime-version
         :content-transfer-encoding:message-id;
        bh=COxYHUqNuu7jKjYsqAB0jQeIoGQ1enYYVDO3rAmUjEs=;
        b=rnoZRJti6jcHZyVxuVBKPNUFVl+whIGoDPNZDyr4k9RQPbn+MOzkxwm5w4KNXMs4Hn
         bTUBDNwED3qXZYNXfX9rgYBVcZnR8f/ItpR39lt9XecPpTaoR/x1XyVq9S2GS3CIlTSo
         5mJiNLzinOv4DHnqyuvr9ZYWqrQzoTR0OFCY/maJP9InakVGvR0LbW+KGSf5qCu1sPCv
         e2oRw+MOXeFbVmKELF1Z2hJ9rEDCDvxCGTJzK/aCDhcQ7pdxnmOrCwKDqvAnWQciAaFj
         b6Zbz0w1So9oVx7X3wl9N3e0vXbe6nigz2q2SvyjNKgRPvnkQsG/jXWByfmIkuTHPOJ5
         A0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:reply-to:date:subject:mime-version
         :content-transfer-encoding:message-id;
        bh=COxYHUqNuu7jKjYsqAB0jQeIoGQ1enYYVDO3rAmUjEs=;
        b=Zo2jVajCPlMaLVEANSviPiT6R0YaMbLlTxLlRdF3swtDunwyNpE5As+OK0g9EtZoyd
         sr/Dy78RLW1fum4OV0p9KE4ge0P8Jl7smnhQkfsJqg4vOvu17Thjd5QiXl6Srb9dCkmZ
         VRGmdB2ZLj+WqWxdBmj5MT5PJo6CAkA9xPBV1/ED40Bc3AIkfftA+wV49LvQjdoK/oPA
         021n1G32a6f2Gz6UZ7mO3ydp37iLfitZUM27ZJ3HYyDnyifInWJ3CZZVE6vldUjk8zXX
         WfMMIMCLflGdFx3B+DdeoXqrr+dZTi3V2QBTxfpJZ0jNVxX+obvuBd3ngYTVnuByNopI
         HE+A==
X-Gm-Message-State: AOAM530HrNIdWm/FTIAO9seaVUmU5lx2w5CfBOPHUJTdUkG8ydwiAy4R
        oLXxSCygdzWixMd4swmce0+NdldxNb8=
X-Google-Smtp-Source: ABdhPJxnjJYBQodB0/6Zq9wDD6Nv44hqVJnlNAB9uW/yByfarNqwigosetjDlj6+zSQgO/ASk3qpHQ==
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr835935ilj.155.1610483531362;
        Tue, 12 Jan 2021 12:32:11 -0800 (PST)
Received: from DESKTOPK0LA5UO ([67.69.69.139])
        by smtp.gmail.com with ESMTPSA id y3sm3462123ilc.2.2021.01.12.12.32.10
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 12 Jan 2021 12:32:10 -0800 (PST)
From:   "Emma" <emma.j.promo.expert@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: emma.j.promo.expert@gmail.com
Date:   Tue, 12 Jan 2021 15:31:57 -0500
Subject: Good afternoon,
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Message-ID: <DESKTOPK0LA5UOe510a7f41f0141699a7a2c1eca6831b5@DESKTOPK0LA5UO>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, =0D=0A=0D=0AMy name is Emma and I=27d like to know if it would be =
possible to email you some promotional product options? Our company offer=
s a large range of items that you can add your company logo to, like:=0D=0A=
=0D=0APens, Drinkware, Bags, USB=27s, Technology items, Golf Items, T-shi=
rts =26 Jackets, Hats, Lanyards, Koozies, Stickers, Calendars, Branded PP=
E supplies=2E=2E=2Eand so much more=21=0D=0AThank you so very much for yo=
ur time=2E=0D=0A=0D=0APS: This is a 1 time email and we will NOT email yo=
u again if you are not interested=2E=2E=2Ewe promise=21  We are just look=
ing for that 1st chance to prove ourselves=21=0D=0A=0D=0AHave a great and=
 SAFE day=21=0D=0A=0D=0AEmma Jenkins=0D=0AYour Personal Promo =26 PPE Spe=
cialist Team Member=0D=0A

