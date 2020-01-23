Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCEBC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8950221835
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUbu68TI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAWU2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:28:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40636 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgAWU2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 15:28:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so1939716pgt.7
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 12:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiwLmTQ2ma9igSnKi0od7dKWWlM4H0MIK0ffS9B0oeI=;
        b=eUbu68TIkKyrsyZC/wqkXi7glxCjrpueSU3kmYngm3DnSDAD4nf7sPxYxMCbKZ3NCF
         sScYeqLM73hbkkAQNpTg5sgVLYBPDT6j4oUHhKR5jsmBIo/O6NRRvofXRVhKChKtABcY
         caf5cwrnmKRuk1KC+NXLKE5DkZLywnb+CegdDMN8JSVPfMEEZYgG3IbZ26h5JnEX2sHy
         05jfDUG3IhsYMooZv0sx94WHZ9orWWs26MVZAgjLRtriYYcypsZjbaKNdCrZ/9Y97Vcw
         WI1REqOSVl90dBMVVyAYXAxVqp7JV5otX7rWyGDGgxmibjDekyutWZwYV/Dfs7CS8+j1
         MLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiwLmTQ2ma9igSnKi0od7dKWWlM4H0MIK0ffS9B0oeI=;
        b=ItpmndZ2R74eSthVmVyovChxk6rg+cv5C9pZKxhYNlPODbP61ThLZUYCmM3YKH6j/S
         bF/3AQPLUH+H1ywX1/9AWwPAAbkzA7y3Yfm76x26isZXbdyjVtr2H1JY6C0FaLIghI5q
         0G7rYFwaWbg9Mk8ymVgOZWc3s8KGsTGIoYTdxIS5HiciTpYolIiSyV5PtFYP2Nrvu7Ui
         npFudX5UBXlPpbFWRBN8p2djTHG4RzvjDqXQIP1GdXy/QSkjH2INPnW5mCHP+hr9RzJm
         p59gLy6uaxTWSxZB1jEBuM34oSeSMm/FQ8w1GBYJPVYUuNUzZzVITHQeQ38RPy9KCSR1
         bP6w==
X-Gm-Message-State: APjAAAXtNKPTG4oGSK5XIswFKoBwawvq0VfcpQCQC0qBENRKktW3h/EG
        ZUoSyw15GQFmoEynViZ/MaUbAMz7Gipatd1O1sgICrmd
X-Google-Smtp-Source: APXvYqwDzEAkTKR9YeaowoXIiz8f5CPihYh1/fC/SCEUCOSh3AWCJPLc3GON+h6X3bQPSTemzvaiU01DJRzK8rkOzdI=
X-Received: by 2002:a63:4282:: with SMTP id p124mr140272pga.155.1579811309925;
 Thu, 23 Jan 2020 12:28:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579805218.git.matheus.bernardino@usp.br> <6ec39af930871496dd7694ea27eeca69d5d60c96.1579805218.git.matheus.bernardino@usp.br>
In-Reply-To: <6ec39af930871496dd7694ea27eeca69d5d60c96.1579805218.git.matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 23 Jan 2020 21:28:18 +0100
Message-ID: <CAN0heSq3gvZeUXnqzbjFY-1axmFXEJDO4oRp9abRO8TuxJQuDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: sparse-checkout: mention --cone option
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Thu, 23 Jan 2020 at 20:02, Matheus Tavares <matheus.bernardino@usp.br> wrote:
> In af09ce2 ("sparse-checkout: init and set in cone mode", 2019-11-21),
> the '--cone' option was added to 'git sparse-checkout init'. Add this
> option to the respective doc file.

Nit: s/respective/corresponding/

"Respective" sounds -- to me at least -- like you're tweaking two
different files. Maybe that's just me.

>  To avoid interfering with other worktrees, it first enables the
>  `extensions.worktreeConfig` setting and makes sure to set the
>  `core.sparseCheckout` setting in the worktree-specific config file.
> ++
> +When `--cone` is provided the `core.sparseCheckoutCone` setting is also

Nit: maybe add a comma after "provided". Without it, I could see someone
false-starting the parsing as "provided with the" or even "provided to
the". Those readings obviously don't work out in the end, but with an
extra comma, I think it's easier to just naturally read this the way
it's intended.

> +set, allowing for better performance with a limited set of patterns
> +(see 'CONE PATTERN SET' bellow).

s/bellow/below/

Martin
