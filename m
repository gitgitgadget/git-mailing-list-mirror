Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7852C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 12:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9BD22520
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 12:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVA7w6nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfKTMmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:42:47 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:39303 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfKTMmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 07:42:47 -0500
Received: by mail-il1-f175.google.com with SMTP id a7so23269550ild.6
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RgiVarp2NX5Ll5BYGEUD9M1gyWmpHzKb8Sue6vsmPWU=;
        b=XVA7w6nVam98eeCLfJWjL/yu5xasheDA/E9/sGz/WUORoTqO13n1d2u/VNJHYvNNb8
         V1xjUfXriIr48Jgg4RZ+yrhAPm+fv2poFXrrFsMWRF6p3oMiv5zm2x3uliZyFPYBl/Og
         ztSX+CxVG0hWVgIYyTk+fii2Q4KdyHRHDly96uyaKJ1g4kHR7MODX4xlZo7rGKC+1lRQ
         Z/vaUSw/aptgEf8LU4eqfkHRyuto5AbyAL52z0LyiH3Y/VABzlzEbTNMEfQEDaXEbJXL
         l8mdB5Tb1gvTO7bT8/EcyVr9Yf1N5RXpQDO4o0F5DXJ6etU0F8GzQvl+pxXM67Wjq0no
         N6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RgiVarp2NX5Ll5BYGEUD9M1gyWmpHzKb8Sue6vsmPWU=;
        b=aGUWkZ/b4yxsWGGciFZXq6nCQervZgHPVeapUCn9XRE72ut2gkFctECQrEcebzVdaD
         ww/Tz0WABzDJlibkz7IN54tM9KS2YTT8BdIpPIXmviYwLX49xHVVmgrjaC5vbfBetVY7
         CnEkmBdOkagPdJCZhbqFYTtWPonq2WDAFlSsU33h1WV9eSDXNwUH2gUWmKXb8/kdObly
         JsbCP9dlmuB5vgwyAM9IW2idzPvKmHmUuEzXfxxO0ZaHvcFeZO1QFTwO6ZeGAxOH+vU1
         Xqvct0IJSLHE9lgNW0RGhjTN9myIpjwdApB2hE57R6X+IK2iPiutIF3c1T9ldY2OyTFI
         5aEQ==
X-Gm-Message-State: APjAAAX2GtzFtb+wvrip9m2Das9rJfhL55CuQ2RhJFfGzxBQrOOKLcfv
        0v2UrCBMvjQytSNIpTovH5t8a/wgNgUNO4WufcABZu93
X-Google-Smtp-Source: APXvYqxQNnQwy4+ug9+fpFwHbFM3tcuu59lb1nLg2ZR7c1b7RvfMw8iqKO48t2ZdwlWorYfPLd9f2t2vSLo6xzsYkj0=
X-Received: by 2002:a92:6a07:: with SMTP id f7mr3312569ilc.41.1574253766209;
 Wed, 20 Nov 2019 04:42:46 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 20 Nov 2019 07:41:23 -0500
Message-ID: <CAH8yC8n+ta4BSAE4rEfhKxe3T9poVdc94HvSk=6PEA4YbmwVyA@mail.gmail.com>
Subject: Commit signing and pinentry problems
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm having an annoying problem that I can't figure out. I hope Git has
a setting to fix it.

I have a desktop workstation where I sit at the keyboard about 1/3 of
the time. Git signing works as expected. About 2/3 of the time I SSH
into the machine. Git signing does not work when SSH'd in.

When Git signing fails over SSH an error looks like:

   $ git commit -S log.h -m "Remove unneeded header"
   error: gpg failed to sign the data
   fatal: failed to write commit object

I just noticed this today (but it makes sense)...

    - Go to desktop workstation, log in
    - Go to remote machine, log in
    - Sign at remote machine over SSH
      - Desktop workstation will open GUI password prompt
      - Remote machine sign operation will hang until GUI prompt times-out

The problem was reported to Ubuntu but no activity:
https://bugs.launchpad.net/ubuntu/+source/pinentry/+bug/1852696 .

Does anyone know how to use Git to work around pinentry brain-dead-ness?

Thanks in advance.
