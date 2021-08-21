Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60449C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 02:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433ED6108F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 02:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhHUCN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 22:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhHUCN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 22:13:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E8C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 19:13:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so2236906pjw.2
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dr6TWwFsVA2gRQtlWC8zDfv3+2+ypnat1kV9oXaphds=;
        b=g6P8+aos5wBliK8NpZ7WrtzLJiFRUSegUzkSPLZdlOhXLzQTg6LGP2etTg/pI+EIme
         Ce1vpo9+voFPflhcW06YRmvghx2JMi77VCJqjo9U1QpThQJAmZJ4Y8WvqyX1SxETRFXp
         9Gg6ijKNsFKSlfuNcNeeN5mI0iGHKyvklsQOwMDobJc+dfeS9mLjK0JwBwEbdcz9FKkM
         /Me7sM0KpPQTGLg5Vto6X/lFeZHdSZozVT0DzVv+P6uPNoCL9oqBQZ4gWyDSPRE9oijQ
         TR4pM9MtsHJmd8QhTPn7FWa/1cLV+OyBmZyhKXYm3ydVJfQb6di0/w2WmmsCCGS8ZCN3
         tx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dr6TWwFsVA2gRQtlWC8zDfv3+2+ypnat1kV9oXaphds=;
        b=igFsLTkNsE/bFNY+Yza6D6g6YSZgUHXwpBOZpA6XuMUuHTtY2yluyVArzyM0PpKb/Y
         JyaBS1a7zyDqgRw1LNd4IWJU0H01wtHk4G9LpLBx6rLllX2PG00s8Zjc1D/G31YpZKVM
         qYelYFBQTgKS/ZG7bLApO/GOv8PeEIKWaPBRUEiWo4A9xvrCpMPkxQTtuaeXG++HaFGB
         YABBJG1NLgKr5fUDL04EMTc+ZtGCDesClYdFSnvSeas2puU6o02jr2Sd/pnr0XQWyQW8
         3I+XFg+vO5GPYOkFLp2G1mL8ZSmpbbjy5dGhE44b7kGSqUNd0lGuzsYJ0fEPoqSILAcG
         4dPg==
X-Gm-Message-State: AOAM532QVpbbZ7Xhr503qHTNph6fxUEcefIhbUSCnK5oBD8f3mB6NmHq
        Pi46xjPvvh0NSAwaZVTKHZY=
X-Google-Smtp-Source: ABdhPJyx9MgRHQfHI+pVHE6iqeUIO04TzGR4W3I+mw/GFInXgFQ0deJljWFTgc5u5+85pwP574KSbA==
X-Received: by 2002:a17:903:32c3:b0:12d:cdc8:9460 with SMTP id i3-20020a17090332c300b0012dcdc89460mr18985389plr.28.1629512000411;
        Fri, 20 Aug 2021 19:13:20 -0700 (PDT)
Received: from localhost ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id d15sm6914520pfh.34.2021.08.20.19.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 19:13:20 -0700 (PDT)
Date:   Sat, 21 Aug 2021 09:13:17 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make: add INSTALL_STRIP variable
Message-ID: <YSBhPdK8jYIQUNhP@danh.dev>
References: <20210820105052.30631-1-bagasdotme@gmail.com>
 <YR+Tp2AGeeKyRKoC@danh.dev>
 <xmqqwnogt20q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwnogt20q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-20 11:16:37-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> >>  install: all
> >> +ifdef INSTALL_STRIP
> >> +	$(MAKE) strip
> >> +endif
> >
> > I believe it's better to write like this:
> >
> > ----- 8< ------
> > ifdef INSTALL_STRIP
> > install: strip
> > endif
> >
> > install: all
> > 	....
> > ---- >8-------
> >
> > IOW, install depends on strip, not install invoke strip.
> > I think it would work better for:
> >
> > 	make install strip
> 
> I think you meant "it would work better than 'make install strip'",
> and if so, I tend to agree.  With
> 
> 	echo INSTALL_STRIP=YesPlease >>config.mak
> 
> either Bagas's or your "before installing, make sure we strip"
> change lets
> 
> 	make install
> 
> just work without "strip" given on the command line.
> 
> If users with such a config.mak type "make install strip", it will
> make the recipe for "install" wait until "strip" is done, which is
> what we want, but "strip" on the command line for them is redundant,
> and there is no way for them to install unstripped binaries, which
> may be a bit of downside.
> 
> But for those who do not always want to use INSTALL_STRIP, as Dscho
> said after I mentioned the "make variable" thing, we probably a
> wrong thing when they say "make -j strip install", as there is
> nothing to make recipe for "install" to wait for "strip", so it is
> not a fully satisfactory solution.

In that case, we can use this construct (since we depends on GNU Make,
anyway).

---- 8< ------
ifneq ($(filter install,$(MAKECMDGOALS)),)
ifneq ($(filter strip,$(MAKECMDGOALS)),)
install: strip
endif
endif
---- >8 -----

MAKECMDGOALS is available from at least GNU Make 3.75.1 in 1997.

Anyway, maybe it's only me, but I think people may want to install
first, then strip later for debug mapping.

> 
> I think we want two things:
> 
>  (1) if a user says "make [-j] strip install", make sure "install"
>      won't start before "strip" finishes;
> 
>  (2) if a user wants to always install stripped binary, allow some
>      make variable in config.mak so that "make install" would do
>      that without an explicit "strip".
> 
> Of course, if a user does not have (2) configured, "make install"
> should install unstripped binaries, but that goes without saying.
> 
> And after thinking it like this, perhaps a new "install-stripped"
> target that runs "strip" and then "install" as originally proposed
> in the thread that triggered this discussion may be the simplest
> approach.  We can control the optional dependency between "strip"
> and "install", those who want to install stripped binary can use
> "install-stripped" instead of "install", and they can on-demand
> choose to install unstripped binary (which was a potential downside
> of the "make variable" approach under discussion here).
> 
> Thanks.
> 

-- 
Danh
