Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1ABC433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D1920737
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBjpIODz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgGWU7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgGWU7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 16:59:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7133BC0619D3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 13:59:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o22so3776983pjw.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 13:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lludc7YSV5KE+UhPOOVv+wMtkHU6ShHnEuNUFrz9Reo=;
        b=sBjpIODzTLV+WH/92u5dFW9bK8Qv2dkxDUzHNKYpkutIHQybgyOVPspsNpTlXhbAIx
         jEp6krXEbI6Ccb1AkajGUVvPb2CSB6KjCI2YWxV6A/YG6YOvwChTlhQh5h7lNCtApDmx
         z80gv3R1TLyRbE/Q64dM+KEkVVucOdGIS2tBiyJXIckJpcAsXhXfSkG4u1DxWa//YrPl
         2TqM4+H0HCRDY/yazT2xd8tFp3/J1KTz8zRXM7svwusMfweKjxxeu7A1+BdGZjKs8E0P
         WkAR9RHL9l4lQRB0oNTao9DTAUpx0rq4MsIw2kw2EVEl3Ka5JWhS2ZnYzXdVUXB9q0Bx
         YnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lludc7YSV5KE+UhPOOVv+wMtkHU6ShHnEuNUFrz9Reo=;
        b=Ua7KPe5KQ3xzGWZy2mWwJYwkT7yEv218PWYMUgDqz2xVhC/BAMfd44hToGvqBCp4B9
         Q59enRTtuZs5nYg6xtedyuNGpkaK/NY6vUSq9JcviebB9lxIS3ZuKG3b08Khmt+T595c
         q2o/mpTFS88884UYHiKUBdo61FdOG3HSaUMmtDZrMH5Z4rFdKrUkrZqzIwbgU2LdVlin
         Y5IsAFmMaYfX35AZKdnxefovsY3wW0HXdLaaLozXJGxpITS3oWJ1CRxEMs0aAGaF/C7/
         sTCzGBj0Osh3wvMVsrVUlN1wLQu+khbKQlmpmKp8WMnCUh25sEmdep+r5nxfKnjUejWT
         2zqg==
X-Gm-Message-State: AOAM533ZjtG4Ngyc8vuWH6JtJeAPMuBTXUHCxWNdFpOyBWFlzrR3LXPu
        Bsc/AnQgbtIaA9lAu+1XOgA=
X-Google-Smtp-Source: ABdhPJxEDAUlWFL4tFu2YETAmij/SgOqGWR3ANQu141RtJMqgp3Ek2mNKz1Juj4NBbybrM+2BrN3uw==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr2108595pjs.37.1595537970778;
        Thu, 23 Jul 2020 13:59:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id np5sm3937543pjb.43.2020.07.23.13.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:59:30 -0700 (PDT)
Date:   Thu, 23 Jul 2020 13:59:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Carmen Andoh <candoh@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>
Subject: Re: Git Inclusion Summit
Message-ID: <20200723205928.GB3579560@google.com>
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing some people from the previous discussion[1])
Hi,

Carmen Andoh wrote:

> There's been some conversation about holding a virtual contributor
> summit focused on inclusion [1]. I've volunteered to work with
> Jonathan Nieder’s team on organizing this event.

Welcome!

[...]
> This can be run unconference style like previous contributor summits:
> we'll use a spreadsheet to choose and vote on topics.

That worked well in [4], so sounds good to me.

[...]
> Who all are invited?
>
> Git core contributors on https://lore.kernel.org/git/., anyone
> interested in teaching OSS projects about DEI.
[...]
> When?
> Anytime between mid August - mid September.  To get consensus on
> preferred dates [3], including summit duration and times, please vote
> at the whenisgood link below by Thursday, July 30th. Please specify in
> comments if you prefer a .5 day, 1 day, 1.5 days or other for the
> event duration.

The 2019 Git contributors summit was two half-days, which seemed to work
well.  That made it easier to get some time zone overlap between Europe
and the United States.  More time than that in a day on video and
people would start to get tired.

Thoughts about how to get reasonable coverage for people in different
time zones?  It's subtle, but the whenisgood link appears to assume
U.S. pacific time --- I'd be willing to start a little earlier or end
a little later if it makes participation from other time zones easier.

Thanks,
Jonathan

> [1] https://lore.kernel.org/git/20200610222719.GE148632@google.com
> [2] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006121525140.56@tvgsbejvaqbjf.bet/
> [3] http://whenisgood.net/9z2diyy
[4] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet/
