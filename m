Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C2F1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 12:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbcIBMGy (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 08:06:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36194 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbcIBMGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 08:06:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so2591439wmf.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VQ+dtDR26bgKaRiwI08TIrHd66XRHatpsg1yLmXQ5w=;
        b=xSGYvq9YnSMxwW9qVSVNXH8LkNSMG9Xm+p3jK12fw5wDn2w/k4VcdPcJgoAH9KQlPG
         8e5fiC4/GguvE/iCqABD9wU67ZhkhCX5kIN1X4IJ+sy+1a3kKFs2/C/6OfRIYyF6J7jX
         47HuF5R2rTYmf6ap5BYu/sFiqf5SPThv75gxrjxxblAbx5nVgfQZuu88D9WftqbCrFep
         pjqJfQxqysZNLomFT60eyNwdlQqmc9vhAxswPAbHJFFrU+a9+UABiKcep6Agr2pK5yVm
         m9M/Gx4Gy57+G0TyPmuV349iJUrv/hF11oPu4Fz+4kP+JIFGyQM3nUHQSSVQPECzAVV5
         2JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VQ+dtDR26bgKaRiwI08TIrHd66XRHatpsg1yLmXQ5w=;
        b=YS8/2fYfF9t7lh2ZnUDhsYM0bSnWONUKF5wiLgo+so3jlGW9IKbvwQsBJyfA8a7uxl
         wQn9No0v/ciXT/nA+KXQVk+AyWZZi/xF22YnQS/xho0Z6NymSld/STXSGBOtJ8PGU8Le
         MSsoln2QMkLaYe9e+hgtSRTnrO+xOSJg0fgz/a640Fkk7+Zp1W5yt2Qt3CVrhDba2oYV
         nKNlmRgQ32piIP/zxYxgMfBN3D5wZ7l44zs2yaek9pzhec9ZsW8tZdljod1bx5b3IIjm
         V478vMiX08rukSA/efee4wKKGEsE4t7xQTJaXYcH9+WUy6P+hBUNHl9IYIOjr/ULGMgz
         UvLA==
X-Gm-Message-State: AE9vXwObMk9/7R8I7n4q53mNDuu2F53nhem3pVedmZEG6COSc9JLqz7ofOlco7d8cn5zww==
X-Received: by 10.194.164.229 with SMTP id yt5mr18942608wjb.39.1472818009437;
        Fri, 02 Sep 2016 05:06:49 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id e5sm3291427wma.13.2016.09.02.05.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 05:06:48 -0700 (PDT)
Message-ID: <1472818007.4680.53.camel@kaarsemaker.net>
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Date:   Fri, 02 Sep 2016 14:06:47 +0200
In-Reply-To: <alpine.DEB.2.20.1609012009070.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
           <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de>
          <1472718808.4680.19.camel@kaarsemaker.net>
          <alpine.DEB.2.20.1609011658300.129229@virtualbox>
         <1472746749.4680.33.camel@kaarsemaker.net>
         <alpine.DEB.2.20.1609012009070.129229@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On vr, 2016-09-02 at 09:13 +0200, Johannes Schindelin wrote:

> As Git for Windows does not ship with translations (for multiple
> reasons), it would not be a regression.

I'm confused, how does "git for windows does not ship with
translations" translate to "this is not a regression"? Is this patch
series only meant to be for git for windows and not go into git.git
itself?

D.
