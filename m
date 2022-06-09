Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E51C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 14:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbiFIOqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 10:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiFIOqR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 10:46:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91535102C
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 07:46:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso1765600pjb.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CG2Zdp/u7sLqSQc7G03dmQeab9Sh+15GSKkg2O2rkC0=;
        b=lTzXQNCGRLWRq3BHSlvPGdzO1pfvvr1kdH1voYSfo+iJwKG8umwr999Cr1pxgzoPKC
         YMPmA4GYf4veZFkacoJLC50xfyK7js/UK5g4Gw8qV/P3uxQjC4Wbk0B2765bzdvYSdXM
         zm4+azxHY/zfofAgeiph5s50lchJ/M1h8C2McnwIrRyFgr9KpxvSyknjtVaprD6LuBPr
         PAAJsLOpmv77P+8xZ371GiouvIwge5ABQ6M7d50LQYRjyuztw+297azFdJ/F8q7OnzHM
         KWiaCpNDBZsN69fYCTGfiGtwHWhBFL1RkqNMubEtIpqzRqsROhtvzVQUSYZkqXZ+2snX
         vDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CG2Zdp/u7sLqSQc7G03dmQeab9Sh+15GSKkg2O2rkC0=;
        b=rAvao9BkWsHQBhamIbSOn/Z/qk9//hm85PoD7CVbo5BS64DJJDl6SE7r2aDppatWR+
         3Y9Jjgb9QTdbfYW4aoCfdiZmpC5bL3EPODuKuGEo+OSfsjY3zAmStdchQb32ONTlTy4z
         m9Tn1YwNLfT5T0r5blOzwjbXGXW9u9gseqK8HHQUtyKsdDvbO3Iwnb/iE224Ipuh16v8
         q69Ax2OMvsVmj4+/5MFDbMSr67Ff1xFSMWlnYiSry0OlG3biUMKPFPJ+iz90OmD5J1+Y
         BS8By1YX5L0LvKUY5dbXlvUDLCt1BOw/sV78fCTHSQJreqY5bg48LmaUG8WbuZ8YSnDr
         lCdw==
X-Gm-Message-State: AOAM533I0BLr60xBN7fEV9vd7fJ/WvpjPXSyMPWtIrJFDwMO0IPOIOZ9
        icBst6MQD1y7UsLnnVv9GWwm+/FX6IeOcVPEwFDEPgaDe/k=
X-Google-Smtp-Source: ABdhPJwv2Y0AjwK0sghAmhDNZ4SFyaoY8yMNQQZSTg0zfI8J+co8JVxONvtKt6PfNv+n7TIC7D4nBC/3uLl/HWkIrxY=
X-Received: by 2002:a17:902:e806:b0:164:164c:5a63 with SMTP id
 u6-20020a170902e80600b00164164c5a63mr39659085plg.102.1654785976039; Thu, 09
 Jun 2022 07:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2206091000590.349@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2206091000590.349@tvgsbejvaqbjf.bet>
From:   Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>
Date:   Thu, 9 Jun 2022 07:46:04 -0700
Message-ID: <CANWRddNa1nB9shoppfXuA2yqmd2353HVBopoufkh0SevnVrngA@mail.gmail.com>
Subject: Re: Best way to update `HEAD` in mirrored repos
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Thu, Jun 9, 2022 at 1:02 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>
> The reason is that `set-head` expects options to come before arguments,
> like so:
>
>         git remote set-head -a origin
>
> Ciao,
> Johannes


Hmm, that doesn't seem to work for me either - I get the same type of
error as before.
Here's a minimal repro:
    $ git clone git@github.com:git/gitscm-old.git --mirror
    $ cd gitscm-old.git
    $ git remote set-head -a origin
      error: Not a valid ref: refs/remotes/origin/master

Git version: git version 2.32.1 (Apple Git-133)

Let me know if I'm missing anything.

Cheers,
Rodrigo
