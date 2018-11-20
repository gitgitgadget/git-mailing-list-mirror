Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878841F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeKUGGF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:06:05 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40334 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeKUGGF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:06:05 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so2257024ioh.7
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CJC2GFoNbp2H6ml7kRx4Rmb0531GrR5ZDQxSjs3lP2k=;
        b=lXRs3hrG2WRSYRkSACCk5K9tmTpG07VV9eRsQ/1rDxH6CALq7U66kH5oVSn9PVt7Qc
         UjRU27DT1NTcNCa5/iM5FOgKAY01CQXqe+HQvEFVO8xLipWCmqi246f3Y44TkNb1QfgD
         aIrDg3qvGsQB4POdIHpDAETbcfqCd7LlhiUmhEFS9tsh0XzOn6Sv1S08JJbahHHeaz30
         Xe2jxxhVZJs71yIl3kkxsbGtH0Vum/yPp3Biqu1k1l5+kEcIqYbzyJvmMg2pzt7J9PVp
         xYsS5pbekfAuZ6vG+E8vHR0Xj8Rv3r3cnKkIABzOSfe991K8z0VF74SoLgHaSWiJEsly
         D8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CJC2GFoNbp2H6ml7kRx4Rmb0531GrR5ZDQxSjs3lP2k=;
        b=qKPWq7YKfx2brfWcJ1Plrz3e0jwlzGXKLnqVc0tIDFIKZ8ri7rsFIZrvJWYHBxDIlz
         eaWEspp7sJ66ZYqdmbV+BWM4sFeBcFzHS2Ni/fTqr8x9zWBsYIY384WDyeD3e68b/Hbw
         Yv3L+GZUgYN0yykyhdNximlcCGSLQsX40JZjYUDXM5GSqbbiHA0enxLx/KjM343PHWb0
         PzqQKSQHZH5M+CDfq+43ehZoK8W/6XPYak859MmQ1LlMdfORBeT2mDZKq2vkVLa/+cEk
         2R/WUOdDorvQQ2MbnzojTy+kT0t7+A+0RnQIIW1CNv+Lq0SxQT342L12xyjZjTcxJ0MB
         5q6A==
X-Gm-Message-State: AA+aEWY/CanP1ChOjC6yBJj49PsWlSYj8Xzv3xhuggyXE2a/m15/VieF
        b6x9OX42/1/DUmCDVwftGAWB/S8rSFXezImRSyI=
X-Google-Smtp-Source: AFSGD/XKHQ+2BmZ8t/ky3JnynME38dt4jnADzsGLxKT7CY0DH7xIRartKS2MuM13IsPBTZZTsqb+LNZKMlggkEE/KqA=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr2669240ioa.266.1542742518452;
 Tue, 20 Nov 2018 11:35:18 -0800 (PST)
MIME-Version: 1.0
References: <xmqq36rwcwtu.fsf@gitster-ct.c.googlers.com> <20181120162853.22441-1-pclouds@gmail.com>
In-Reply-To: <20181120162853.22441-1-pclouds@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 20 Nov 2018 11:35:04 -0800
Message-ID: <CAPUEsphujJmC8R8acXFDgexeA61JYS8Fcv7Tog+Jt+bZhHrCDQ@mail.gmail.com>
Subject: Re: [PATCH] clone: fix colliding file detection on APFS
To:     pclouds@gmail.com
Cc:     gitster@pobox.com, git@jeffhostetler.com, git@vger.kernel.org,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

in macOS 10.14.1 with APFS
in Linux using VFAT (for the lulz)

IMHO it would be ideal if test would be enabled/validated for windows
(native, not only cygwin) as it might even work without the override
and if we are to see conflicts, that is probably where most users with
file insensitive filesystems might be found

Carlo
