Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F5C1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbcLNR4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 12:56:40 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34352 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbcLNR4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 12:56:39 -0500
Received: by mail-pf0-f177.google.com with SMTP id c4so4734033pfb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VysrHJv+llJ5k5x7lTThd2WNNpPTSHeABa0fPp/QZbc=;
        b=QzWa6p3f8AwaZ5L5FMk8NjzOqeO+ES6UITXqZZMzzxsY+35R+Tef4dZVWwyikZ1Gk5
         kZVer8imBjdN8ER3WoJ79H3992TadsImSbRaIaIPsMOtaOEHe9OqvyG/jttQmC+IU97S
         D4Pyy8W4PimxpK0vxYe29vCO2HgYto83qiFKGTUFDrmr5Oo3V0W/n5eO/IWapNzzIbkB
         ZOoGtP4LHxRw63XBc96CbN2bs0IUWTF9TNh//EKecONoGPUwZo66M38Z6aFPAjSaYg3r
         lYZi2575xxEhej+kIOPYWzesIo7/8TRxyeoPKcMxU3lNLIDWb+vWJwMV1+SfQ3P9iaQ/
         nbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VysrHJv+llJ5k5x7lTThd2WNNpPTSHeABa0fPp/QZbc=;
        b=U9WKCZR5ba4MS4DhTx8OvgT3QxwtexMx419ZrzZFIprgAV7yoU7ywuAR00JuUVnfq0
         lx3NA7mVbOYmSiGbB6oaJQvxy6diMV67oxjhLiUr2J+8D68JaTgTJKeubIu+7F/ksSWU
         MmGe9+yD3euFeD/oECWB9pE42kWx0MTD9lV/v6VQ0dYhTo9A1cEiUS6HQQIq8zjDAPUv
         qW8Epa5k+Uo6miZdSouKQfUm7Wv6aJYlp8Zlfgomnc/Jb2CN8KEnoDquqAdIwakDWhOr
         RsiJNkFGEOZ0LheSQ2PwpSwRMh26zQ9uXtLEX3KA/P9VW+ZSgL4EPNNWYaSTh6lqR7sZ
         y4zQ==
X-Gm-Message-State: AKaTC02mNeQISSBVTVOC2Lg6f7giXwd9I2X9j6vtZdj+Ajs05aD7WwScftFQ3PvOqpm9PkNT
X-Received: by 10.99.109.6 with SMTP id i6mr186819705pgc.139.1481738198233;
        Wed, 14 Dec 2016 09:56:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a0bd:b7d6:4331:46ad])
        by smtp.gmail.com with ESMTPSA id a68sm89366333pgc.31.2016.12.14.09.56.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 09:56:37 -0800 (PST)
Date:   Wed, 14 Dec 2016 09:56:35 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 3/5] http: always warn if libcurl version is too old
Message-ID: <20161214175635.GA20063@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-4-git-send-email-bmwill@google.com>
 <20161214160123.a6a7fve5qz5xgg7n@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214160123.a6a7fve5qz5xgg7n@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14, Jeff King wrote:
> On Tue, Dec 13, 2016 at 05:40:35PM -0800, Brandon Williams wrote:
> 
> > diff --git a/transport.c b/transport.c
> > index e1ba78b..fbd799d 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -700,11 +700,6 @@ void transport_check_allowed(const char *type)
> >  		die("transport '%s' not allowed", type);
> >  }
> >  
> > -int transport_restrict_protocols(void)
> > -{
> > -	return !!protocol_whitelist();
> > -}
> > -
> 
> This function was subtly broken as of patch 2 of the series. It's
> probably not a big deal in the long run, but should the series be
> re-ordered to put this one first?
> 
> I think the commit message would need adjusted, but it probably should
> mention the reasons this is a good idea even _without_ the new config
> system. Namely that even when there's no protocol whitelist, newer
> versions of curl have all of the other non-http protocols disabled.
> 
> I wonder if anybody is actually using a version of curl old enough to
> trigger this. If so, they're going to get the warning every time they
> fetch via http. We might need to stick it behind an "advice.*" config
> option, though I'm inclined to leave it as-is and see if anybody
> actually complains.
> 
> -Peff

Yeah you're right, transport_restrict_protocols() is definitely broken
after patch 2.  Since I'm probably going to need to do a reroll based on
some of your comments in the other patches in the series we might as
well reorder patch 2 and 3 so this isn't broken between patches.

-- 
Brandon Williams
