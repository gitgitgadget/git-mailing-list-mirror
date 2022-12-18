Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9E9C4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 10:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiLRKwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 05:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiLRKwp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 05:52:45 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE7CC9
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 02:52:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id kw15so15532114ejc.10
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 02:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsan+u5XZK6YPl5nUuLrewWKXZ2Gvswh8MekPi99bTg=;
        b=cg1ugIaq2031piP9Mn0O5AuWJw65bLWdnjaPcVwpAqeDv4yGmEauKi/EbKTgt0RUuE
         aCLNxQjJ/P9MTg6AeHbzeCkKePh3eaH9QNdidG3SPJZ2h3lZ3dTBGbXncJV/dNHBlN6x
         23POp+tBqLdKf6laIHF76J9kHhkGyhpNQ8jQgfHzHT6KKnZHiIWT67V1xpRfJ1oPj05s
         7qPf9A8vMOqmyXHoYdk8d5PC/GvdMM7Ui3FaET+hvLMAn0jmVcgoDLxPd0H99bYqlV03
         8LDSp7ZptNUEvPGGAr0wuGWMezE0i4Rwtg0s03TgONR3nJdSLiKresLERRuQQ4QsSZET
         V3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsan+u5XZK6YPl5nUuLrewWKXZ2Gvswh8MekPi99bTg=;
        b=kPrQmYQLzas9Sf5Xdx8LUDQTk9Fu/IYULHRIP+6glP9bvs92d14jYvCKur0+410vy7
         itldxxM9CM1/igXCE7LD7QV9yNv0wK2wUehywVpS+G4+nZLAlwmcwLnK/UMMJFoWIQ0G
         5RsCF0KTM9cZ9BP016HNr7FZwMW9CwFLcHZg//u4A5PBEGwrMIBWBlqSqkgaQPFSbuiU
         Mrjv8/NcCiNrRbXy8ME5vRp76dtpQhd/WxAwv5hcRA/kG31R0qFDXI3XLkiPdvNLrr1Z
         VxJP2SSarwzYGgiwLl7IBjKIeZ65Q6z6tVtWeYAzJgT0yp5HSloHXqfsyKBkNmigncCG
         KGrw==
X-Gm-Message-State: ANoB5pl5yQwflFGesEWuFuYFBxBcLKpGLX26gga43uV1EtYDQvcxg4dX
        FzLZVZ8FXz8kdd230xfLKho=
X-Google-Smtp-Source: AA0mqf644WTpsuxuEsBBpNvv3FIlX8fojsdqJOI3yrtMigoOxVhgycDB4JQ0Aew55OP7HhoGJe5Aog==
X-Received: by 2002:a17:906:3799:b0:7c1:286a:d87c with SMTP id n25-20020a170906379900b007c1286ad87cmr35903977ejc.65.1671360762236;
        Sun, 18 Dec 2022 02:52:42 -0800 (PST)
Received: from localhost (78-131-14-113.pool.digikabel.hu. [78.131.14.113])
        by smtp.gmail.com with ESMTPSA id kx22-20020a170907775600b007c17b3a4163sm3101048ejc.15.2022.12.18.02.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:52:41 -0800 (PST)
Date:   Sun, 18 Dec 2022 11:52:39 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Askar Safin <safinaskar@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: https://github.com/rust-lang/rust is not bisectable
Message-ID: <20221218105239.GD3411@szeder.dev>
References: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
 <878rj6rnuo.fsf@igel.home>
 <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com>
 <20221218093734.GC3411@szeder.dev>
 <CAPnZJGBwFMPAJKj9Qa_Vv9yJWrGaNXqaNaPUSrYcjZ8J+OfLrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnZJGBwFMPAJKj9Qa_Vv9yJWrGaNXqaNaPUSrYcjZ8J+OfLrg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 18, 2022 at 01:03:54PM +0300, Askar Safin wrote:
> SZEDER Gábor, yes, in this particular case this helps.

Not just in this particular case, but this solves a general issue of
bisecting non-linear histories that is the file/testcase/whatever of
interest is not present in all candidate revisions in the range '^good
bad'.

> (But
> I still wonder how to tell git-bisect to ignore commits, which are not
> descendants of good commit.)

In general you do not want to tell that to bisect, because any one of
them could have introduced the change you are looking for.  Consider
the following piece of history, where commits 'm<N>' are on the master
branch, 'b<N>' are on a different branch, and the commit marked with C
made a buggy change, and commits marked with G and B are the ones you
marked as good and bad you started the bisection.

            (G)            (M)  (B)
  m1---m2---m3---m4---m5---m6---m7
        \                 /
         b1---b2---b3---b4
                   (C)

If bisect were to ignore commits "which are not descendants of good
commit", then it wouldn't look at any of the 'b<N>' commits made on
the side branch.  It would only look at commits m{3,4,5,6,7}, and thus
report m6 as the first bad commit, which is clearly not the case.


