Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718EB1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 22:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbcLEWWP (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 17:22:15 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34149 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLEWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 17:22:14 -0500
Received: by mail-pf0-f169.google.com with SMTP id c4so65830312pfb.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 14:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=smR6EEv+MLuRcWCR3PE1m2Wqs57+khO9zLd2BTea9hE=;
        b=iUn7tnkhDZ2efw3YRNgZokNfusckzXDt19ak1vPiuuV12lQFnkDAVY9rYtt1ZE2Plp
         fYVvM/FDw+wsi2n3ZTJGe5w1KXUhqU1HtjrSYMc0r50IU8YdgT6frqdGpO0khd9EvpGO
         3rB1jrw3YC/6Ke1/7rkQDTy1QFlPl3Hiav7TWTVNGCLXf1V+sPDfICEyykK+hQFP74W5
         wIKrcKw26YlfXM5TPU1elqf8hLF75ORljYiuUXI3ucrSQ47p0oGc0I6BXLPR4IBddgTS
         3QllKe98+xD1DOvHI80G0Qcw1wC0OoSqp6gBfQ35w4cfc/simudALuYysTQYV3dj/VW+
         kWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=smR6EEv+MLuRcWCR3PE1m2Wqs57+khO9zLd2BTea9hE=;
        b=PSCGpsbj1xUyzkLFs+VrIf5UmH8p5X7o4AVrTUtVr21D+Eh4+71YvYvsu0HX0zqgb2
         j3tvLtI/GvWxU5FGaA7q7Qvvrb0HAm0dn03ZrJ59evLW9yRwF20vuviUWG9LG9lSzC4I
         fSFBr7yUQWAUDLGowRZbj/DKgelbljhHzX8q6kqEpgF8qBaz+7C+6nEFzzDTAZkfSS+w
         siTB2eKh8JVF+ZyoPmLtrBk041Itp4d59ItE3+WJTMK+ccBcE6Y2T9CY5JLJYdUoVknl
         oe11eLzffTsf+7hoDeVOriERMT5mgqTv8TyJ+766r1R1Hb8C9gsJlNMiaVZRBAiV0mNV
         9ChA==
X-Gm-Message-State: AKaTC01tTA00zmN7jIfJUGi1KiSekYckELCJiXbpDwXkHcLoG8QGBfz/W2a1BvPqAEE+s+pq
X-Received: by 10.98.89.6 with SMTP id n6mr60389743pfb.43.1480976533833;
        Mon, 05 Dec 2016 14:22:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:20ca:c78:1a67:9579])
        by smtp.gmail.com with ESMTPSA id t25sm29844174pgo.9.2016.12.05.14.22.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 14:22:12 -0800 (PST)
Date:   Mon, 5 Dec 2016 14:22:11 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161205222211.GF68588@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
 <20161201235856.GL54082@google.com>
 <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > On 12/01, Junio C Hamano wrote:
> >> Brandon Williams <bmwill@google.com> writes:
> >> 
> >> > I started taking a look at your http redirect series (I really should
> >> > have taking a look at it sooner) and I see exactly what you're talking
> >> > about.  We can easily move this logic into a function to make it easier
> >> > to generate the two whitelists.
> >> 
> >> OK.  With both of them queued, t5812 seems to barf, just FYI; I'll
> >> expect that a future reroll would make things better.
> >
> > Yeah I expected we would see an issue since both these series collide in
> > http.c
> >
> > I'm sending out another reroll of this series so that in Jeff's he can
> > just call 'get_curl_allowed_protocols(-1)' for the non-redirection curl
> > option, which should make this test stop barfing.
> 
> I was hoping to eventually merge Peff's series to older maintenance
> tracks.  How bad would it be if we rebased the v8 of this series
> together with Peff's series to say v2.9 (or even older if it does
> not look too bad)?

I just took Jeff's series and applied it on top of mine (and fixed the
small problem causing t5812 to fail) and then rebased it to v2.9.0.
There were a few issues that needed to be resolved but nothing too
hairy.  So it would definitely be doable to backport it to the
maintenance tracks.

-- 
Brandon Williams
