Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33A620451
	for <e@80x24.org>; Tue, 13 Dec 2016 22:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbcLMWtY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 17:49:24 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36557 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbcLMWtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 17:49:23 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so209920pfz.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r2OJgB3Cu8pdbeveYVDOagyzkcXxKsneFCeO3sCT4aY=;
        b=jxV2vD5ybPIH/gBgF6ODIkyXBhhQr1XA2izUmvmB0XYfMjvanUv2SKRPUlbjdBSbZY
         dpuJX/RKNh3b1r4xxPnA28Gc08CCBI3EoeITUMS3Mg1M14d05Duf4cgrOgsKkQBRG293
         SAsCu4zt6qaqLJxUyAQKbBf5z+83+GaZGefNqx/zU3p0cXMZctvjitR9TLYmlmv0BFK0
         9b5ilDxn3JRnOTej1NNuzYI5ov7YV0uiPvM8/PGaWcmED9aainWk/fP4kz/I2xwr12kN
         2qWV82/Q+ZpINLYiRQpzHu8kCBUf4mtmG951nJiYEXHoqrH64VuI3rn3RBwYpj/n5MR6
         vuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2OJgB3Cu8pdbeveYVDOagyzkcXxKsneFCeO3sCT4aY=;
        b=kY5NNcMykjsjHdPQbjkODXfXxuy4IQ1TA99gEzT+7v6SoMvZvfP/edlHI6k6cShFHM
         zqwtDQ1AHS05N8LDenvGrFKECYyE38R/U6DEN6egXQL5YS9VF4qOqg8pxxw6e0+1hwkF
         NucEp/Hj3WZDhBWmcljlyaNQWJLPmkb8kpvEtodgh9tpTIUj3Hy06L04xR1Aferbwxp6
         XRtFwgykeSQiYalfarC8oyR4Y17Fe8CjA9VaCZwUyaW875fRAkqteI0Flyaivhmlt/4d
         xQf2eoqsIsd1lsXzGxbLh6Gkl/rsblQflcl8QEiCn4ObDCiJueZ78UD46LSH5fqsJAI1
         0e3g==
X-Gm-Message-State: AKaTC03VqAinTgraohhQmGW8sW2JUQoXM6mDu0ztuh/X/1n/ISNrXtlgCHTPul1qs+/t9oTs
X-Received: by 10.84.208.227 with SMTP id c32mr200004513plj.144.1481669362795;
        Tue, 13 Dec 2016 14:49:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e076:1f78:6a8d:c0a])
        by smtp.gmail.com with ESMTPSA id f14sm82349238pfk.5.2016.12.13.14.49.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 14:49:21 -0800 (PST)
Date:   Tue, 13 Dec 2016 14:49:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] dir: convert create_simplify to use the pathspec
 struct interface
Message-ID: <20161213224920.GB4121@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-3-git-send-email-bmwill@google.com>
 <CACsJy8AX09pxkyUkLU905v1MpXocLzV5bK0APuNmMUNb50Lavg@mail.gmail.com>
 <20161208000357.GJ116201@google.com>
 <CACsJy8DtUwnOjBV49navkfgqPzEsNuX2LVaeVU=Ap2PWLpGFdA@mail.gmail.com>
 <20161208181957.GP116201@google.com>
 <CACsJy8Cc6hE1Rbqjrc93xDMc0UUm0yMh0A-fyu3dfJ2G1jhENQ@mail.gmail.com>
 <20161209192316.GB88637@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161209192316.GB88637@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09, Brandon Williams wrote:
> On 12/09, Duy Nguyen wrote:
> > On Fri, Dec 9, 2016 at 1:19 AM, Brandon Williams <bmwill@google.com> wrote:
> > > On 12/08, Duy Nguyen wrote:
> > >> On Thu, Dec 8, 2016 at 7:03 AM, Brandon Williams <bmwill@google.com> wrote:
> > >> > On 12/07, Duy Nguyen wrote:
> > >> >> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > >> >> > Convert 'create_simplify()' to use the pathspec struct interface from
> > >> >> > using the '_raw' entry in the pathspec.
> > >> >>
> > >> >> It would be even better to kill this create_simplify() and let
> > >> >> simplify_away() handle struct pathspec directly.
> > >> >>
> > >> >> There is a bug in this code, that might have been found if we
> > >> >> simpify_away() handled pathspec directly: the memcmp() in
> > >> >> simplify_away() will not play well with :(icase) magic. My bad. If
> > >> >> :(icase) is used, the easiest/safe way is simplify nothing. Later on
> > >> >> maybe we can teach simplify_away() to do strncasecmp instead. We could
> > >> >> ignore exclude patterns there too (although not excluding is not a
> > >> >> bug).
> > >> >
> > >> > So are you implying that the simplify struct needs to be killed?  That
> > >> > way the pathspec struct itself is being passed around instead?
> > >>
> > >> Yes. simplify struct was a thing when pathspec was an array of char *.
> > >> At this point I think it can retire (when we have time to retire it)
> > >
> > > Alright, then for now I can leave this change as is and have a follow up
> > > series that kills the simplify struct.
> > 
> > Do let me know if you decide to drop it, so I can put it back in my backlog.
> 
> K will do
> 

This actually turned out to be more straight forward than I thought.
I'll reroll this series again (with a few other changes) and include
killing the simplify struct.

-- 
Brandon Williams
