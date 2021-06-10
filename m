Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B09AC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F33A613D8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFJQDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJQDH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:03:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D6C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:01:02 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m137so2631418oig.6
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RRVBKkxdTUPDA6JT+YCdFKWW+EHArUfOxdpoRjViE+I=;
        b=c+MnxArEnrkaTLu+zGD8SYn+0/FDonbDIvgQZe03a/IGVODrh58KkUmjFLYqqOyhgq
         0M76D6wpfQWTRhNlIcQluH9d985Tw4hgqudLR8ufW5KORXvHWkS/zY2+c+epOo7+Aldi
         nt5MEmwJuI7NnhOuinYap7nhIyxA9oV0ZVCr5FBQmp1qDCGgQP+LCHe9W2nivgcNyjhJ
         7HFIWGaFtVtL7DzR7DjCC/iHCMdvrAfXjCHmWYHFmbVOxEvBsiHzzp2lKqrGKjWnZbJA
         KXEE7sHmveLnrcPSJTIaxmUdkz0PlXygA5Gk3vTPrfrizE102JAW/xR9I3HyUhJY0Lku
         HtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RRVBKkxdTUPDA6JT+YCdFKWW+EHArUfOxdpoRjViE+I=;
        b=gy1Ap/u1jPP9sRJgEjjddeeWLdAhkKTb+SBLU2hfo0LbRihX+hx4lFawlUGTW6pmfQ
         C8yEbS9dgd+/hOkWKQ67FIXsSie8NJdEGZWtHQKJzBvGdsBQ998ppXIzqXL2+ut84U3G
         qP5nhTivHjyq8SSrvo9FRVOOK6PlJSAPi/j9oa7nTBDWKncnFzC7pQUuL636EnR0jbUd
         J5ufKwdAvW81n3IZIgReDdQvHT0X8OYYjSbl8qCht/aCh7MEPiDuC9p0P1n9OE+QtNqq
         Jrjpync9KqLpCn9zCtJK/4Zb+r7YMfIQju3DVAEmjyhaJiUS4KrS/kvrViVHxp1apZ2L
         iU9A==
X-Gm-Message-State: AOAM531XOlRinYi3k4nEHVDIBgL291OzJNT+52nq99m5B1dxhk77Bgle
        UXwI94PnVUaQcdjNTTBgDLI=
X-Google-Smtp-Source: ABdhPJyCPYlLOxcSpa5maOeX48fiPUhaexVWbI3bUg+guxlnD99WJjM0sdbdvpwYZ0TgitktHWnWNg==
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr3986382oih.164.1623340861861;
        Thu, 10 Jun 2021 09:01:01 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n127sm611397oif.55.2021.06.10.09.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:01:01 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:00:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c2373b93140_b25b1208c2@natae.notmuch>
In-Reply-To: <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Jun 10, 2021 at 08:41:21AM +0200, Johannes Sixt wrote:
> 
> > Am 09.06.21 um 21:28 schrieb Felipe Contreras:
> > > Virtually everyone is using it, and it's one of the first things we
> > > teach newcomers in order to resolve conflicts efficiently.
> > > 
> > > Let's make it the default.
> > 
> > I tested diff3 style the VERY FIRST TIME the other day and was greated
> > with the below. Needless to say that this change is a no-go from my POV.
> > [...]
> 
> I didn't look too deeply at your example, but I suspect it may be
> related to the fact that diff3 does not try to minimize the conflicts as
> much (and then the recursive merge on top of that piles on extra layers
> of confusion).
> 
> There's a lot more discussion in this old thread:
> 
>   https://lore.kernel.org/git/20130306150548.GC15375@pengutronix.de/

Geezus. My patches always end up kicking the hornest nest don't they?

Maybe it would make sense to revive the zdiff3 patch and attempt to make
that the default. That would take a lot of time though, so it wasn't as
easy as just flipping a switch from "merge" to "diff3".

But there is value in attempting to make the default merge.conflictstyle
work for everyone (or last least as many people as possible). It's
shinning a light on issues that are already present now.

For reference--and since gmane links don't work any more--here are the
relevant links for the past discussions:

https://lore.kernel.org/git/20130306150548.GC15375@pengutronix.de/
https://lore.kernel.org/git/alpine.LFD.1.10.0808311021120.12958@nehalem.linux-foundation.org/
https://lore.kernel.org/git/1220056963-2352-5-git-send-email-gitster@pobox.com/

Cheers.

-- 
Felipe Contreras
