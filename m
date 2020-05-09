Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B3BC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487F821582
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGOp/Dt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgEIRlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 13:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgEIRlA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 13:41:00 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C35C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 10:40:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t199so11474210oif.7
        for <git@vger.kernel.org>; Sat, 09 May 2020 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voj0G4v2GTkmRkJ654LVeaCdRc5kP/G1ZrR1SSo7m0k=;
        b=dGOp/Dt22tRW7zOn+W/QMc4LhqyS6JyAMwNGvyOe+ftXos8mCPkgf4u75sPRgAhaqD
         K98XnkbJG6085tp8KaNDq4f0FI2LbRyQcNIdvlagVDw8oPhVRuQNQp5K2JCvSZpObFV6
         vDpItSSJsEsJC/LCKpTofAcxJtANBh1DcvfCcY9N3RceWX8kkTiwtBVDUK3Cm1WExNBx
         LyhWIYYrtPGziMwlKV6y+JhPzdte8U0RkPuyhOb2DQLAMViwbW6aEeWLwIw1ZVd+snbt
         I/s5wbSYFTKsU8CcBDZ3FzUQK8ydWGVcRywtZZE/atcR5SsrnYKODde329dOjIuCEog6
         Jx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voj0G4v2GTkmRkJ654LVeaCdRc5kP/G1ZrR1SSo7m0k=;
        b=Mt3pJrf1/1M57Ow0U41Lo4qkGc2qPTeRbuFKep9DawrNMID84+ZDShmvo9x+EcF/I5
         64wwwTJmDNw8NGMbHXdo2VyHoxmpETeajmjMBiGElAw23SaiHWRBEwUjHc5phQOPcT04
         N5crl9blISgA4+4VoaGJ4pRbbCK68OK6ZJB9n7rThoMUh5RBS4h+oBHJFI1+Ux+WyVZx
         bi/2stC8BDEuxqMh1VPgy2O/0hYSTZCcklzXH2ys4ADhFtWOCPwTxhqan0nUiBxCPlhf
         P8K1/pMgGzyCZyZbj5rIMH828qG6cBFmYuUdmUAW1mukJ0IfGt/Vm7PGcxHpQCiAfIru
         U8Nw==
X-Gm-Message-State: AGi0PuaeHIjPaurqbPNvaatnP2mmdnm9K+nm0kQ+9G+xU4sCwWvyAHjI
        jWY4hKJlRK/trAhcYoTDke6NLAboxt2yXyvdEos=
X-Google-Smtp-Source: APiQypJYa2n/aM9A8g9pcG1WiBV6+5nQCasCX2IW0qLplEhjUBQeoNeifaBSAwutA8cJv3xUqr8MagVDS7cLdv8k4tQ=
X-Received: by 2002:aca:c142:: with SMTP id r63mr14135131oif.84.1589046058724;
 Sat, 09 May 2020 10:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.606.git.1587412477.gitgitgadget@gmail.com>
 <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
 <CAP8UFD2b_27VeLFg3BrbacoJ5+GAxa+JrF3E2jS_dN-xyCRP_Q@mail.gmail.com>
In-Reply-To: <CAP8UFD2b_27VeLFg3BrbacoJ5+GAxa+JrF3E2jS_dN-xyCRP_Q@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 9 May 2020 23:10:47 +0530
Message-ID: <CA+CkUQ8WYd+sR6cBKxK73SJZR-yFnea6Gz+pNABSso44Sgv6Pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 6:47 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> It's ok to refer to a previous commit, but I think it would be better
> if you could repeat a bit the reasons why removing the
> fetch_if_missing global is a good idea, and not just rely on the
> previous commit.

I agree with that.

> "it is plausible" also doesn't make it very clear that it's what the
> patch is actually doing.

Thanks for pointing it out. Will improve.

Regards,
Hariom
