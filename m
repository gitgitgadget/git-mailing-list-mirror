Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7281D1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 20:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJCDng (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:43:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46358 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeJCDng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:43:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so3336841edg.13
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xr7J+E2O1sCgdh5yVPwVlkmaykTw7OhWIEPOx4Cn+Es=;
        b=Jji71J9nTo7pTZ+W07KQx6gyhL5e318isSyO6zB/TF1ggaE6mIknPaKGsi2oqSijh0
         2bJpb64ptLaBIkOCsglLBBcaDCDi8lCFVmTB8oVcBvhXNor7CEOxpiH1IHnEhl6pnqKR
         9/OC1XnBdQmxw+S4fBkvJXoK7DS1OKD7p+9jYG5eOawW1Lye8pFo8IbAWcfUhCWyMB7J
         OTFcZ457RmtH3hyry0YUZzoAemWNjvFLuZ4Yym9fOvWHLbVLrHymadvSHoZHfreGaHP+
         udPB2O2rIy7UMSbT8Zle9+iHhLDwJlF/WwDE6My+luwPv7N5CAnd6vash0y5qgS6eXlW
         U4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xr7J+E2O1sCgdh5yVPwVlkmaykTw7OhWIEPOx4Cn+Es=;
        b=PqJeW17Zn+zN/N0GSXDxWlfg3zQalsp5Fbyv4BEblejXqGB74N8WCTK1zKIzLC+9eD
         CpJ5VB64xfmwOZOrWzotXCcJDdpE6NzVRPc2Do21EEqehI6LJ0xV39idO4ckzV6xVT6c
         W6Yk0U5zucLLljL6RCld4JiwxRh/8pXCcagcsWIlQhFZ1MpIM18SOpo9CO33XBnzigH1
         QfFCt9yVO4Vo8tcQg+3hWUsD58a1THf8spj1yiJuQ2D70TV/fJnF68GqGgHJsbX32aAH
         gsLD5MMS6NLOdVPGAL3bPiUZZ9l1si6f4O+zQNyzwU0GHDmNgleyAL2vcVO6OwUE7Yl0
         LmyQ==
X-Gm-Message-State: ABuFfoi9R4z7anRK0lPSE6hQfHh2KAVttrldD5b7nnyROYrFQbxU8oJJ
        J0nfw/PW0y5LQJYbqInN9UWHTZpl/SwTyiOsK18d3A==
X-Google-Smtp-Source: ACcGV63egLKZm0n6slU2XPwOTWZE8FZKobT7WLZ+S0QHMU3XT2w6jhSZXDfo6jSiKr0ZKv3MEaI1zG8RgRqlzvsfQ0E=
X-Received: by 2002:a50:cf0a:: with SMTP id c10-v6mr26070938edk.242.1538513901167;
 Tue, 02 Oct 2018 13:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
 <20181002195519.GB2014@sigill.intra.peff.net> <CA+P7+xrjpEe_3_mAwZ73O2JP2Pd518OFnSf+gfmbTJW7A3Q=Nw@mail.gmail.com>
 <20181002203124.GC2014@sigill.intra.peff.net>
In-Reply-To: <20181002203124.GC2014@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 2 Oct 2018 13:58:10 -0700
Message-ID: <CA+P7+xqxov6-+t6ixuVxUvi=yfjDuxsa8poGL0TrUrWoj3NUNA@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: process every source file at once
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 1:31 PM Jeff King <peff@peff.net> wrote:
> Actually, I guess we do not need to save $? at all, since we have only a
> single process to care about. So even simpler:
>
>   spatch ... 2>$@+ 2>$@.log ||
>   {
>         cat $@.log
>         exit 1
>   }
>   # if we get here, we were successful
>   mv $@+ $@ ;# etc
>
> would work. That's missing all the Makefile=required backslashes and
> semicolons, of course. ;)
>

I opted to drop to just save the return, immediately after calling.
It's a bit less code change, and I think the result is as clear as the
above would be. This way we do drop the subshell, not that it matters
much in the end...

Thanks,
Jake

> -Peff
