Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C64C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEADA2082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdRLNNCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgA3WTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:19:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38010 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WTi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:19:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so2374666pgm.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3W1/7shJI9KGG9G4P2aIIfpdqSc4e500ctRplM8vmM=;
        b=OdRLNNCr1aosNQe0cQLSog/2+FJzUbWRuBYftL7B9fYE671mzrfNhAGM8X8CYf4KYj
         Tw89KSGIGe/EG2emXlFnbKnvMswmsa0G5gFePbJ+Zw3bQPaT6Ed4OMrvns/SnmZApOcz
         GAA0gL4fYWY1FLzjERUy8R2uTUcTXxRbvL0ajKQbV1s1BVPjadg8R6il3iyUvfNar7JQ
         cMP4myI760XhR7juqooKjlBYsa3nmcf1nG3cr0WV+RLzJoRptORKjMC2U0lsLfD4PlMh
         MaH77WrnVa2TyGILGCFwkp0Xdfj1rqPNf0Sk3tpIx1QCAZlUmVdpgvTvjQRKhbSBrKtk
         kWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3W1/7shJI9KGG9G4P2aIIfpdqSc4e500ctRplM8vmM=;
        b=MiptqQmmmW68iOdy+tGTLW1xUp7HJ0I5ssdTrY2qIsnNqjWqJ57icIexM7rMJVpWr/
         lnajaTAXoK8RZZUka4/54mL17nDt60ugE12p5Ho4xSyPWIQu27fP+CsIBMh+K7q/TzPO
         cfoAn9XpIJNwDOR4zUvIDI+J6FA5wiFS4CobyV9Mm6SpnE2nGap/LBE8cHKAtm4/WCmk
         c+X3tY4Y4x+yfEvQbX8PRs+P2Byj75Am/7L/2L3T3/xGaGzwYQczL26K6mtO7Fo9cEmV
         fxohvQ0NQiK0rEMYW7tXuNXqdqwXzmn+W47LUVcWr/U9qMeFwqVe/PAGUqfNqHhN6Bje
         cFqw==
X-Gm-Message-State: APjAAAW21DY5YvFSszSO6XJX4W9gXAd3rvDrj1PT5DfTvgXowec+n176
        biRZgiV63zcZWCGEkLlpCMQEdDbyZFDvdVdwWRc=
X-Google-Smtp-Source: APXvYqzPcSTypbTCCGFQl0XNZcAfNQuFU0SVJwYr5nONepcWcjt0IUrm+Ga9dcyXbVFoRROe2Ip68fdmgShiHwj3A6A=
X-Received: by 2002:a63:4282:: with SMTP id p124mr6634923pga.155.1580422778125;
 Thu, 30 Jan 2020 14:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-3-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-3-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:19:26 +0100
Message-ID: <CAN0heSo6K42mmPkLE=QPo93OJmzbN0Xj-uYOE-wOT2N5ctda5g@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] help: move list_config_help to builtin/help
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> To make help.o usable by other commands again, move list_config_help()
> into builtin/help.c (where it makes sense to assume other builtin libraries
> are present).

Nit: I think this could be patch 01/15. It shuffles things around --
*then*, starting with patch 02/15, we can add exciting stuff.


Martin
