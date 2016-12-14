Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A4D1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 20:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbcLNUwf (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 15:52:35 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34032 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754110AbcLNUwd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 15:52:33 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so11695734pgx.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 12:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCb8CZTKeROG7RwPnOW4nfAO/rfGHrLFULq+VYI3XnA=;
        b=prcjFWzBXrGZna++tA5KzeJ813bWDXplSj0ezYLA0bZRT6h0Cv5hpAzbFg5diLZ7Vw
         ZmyZj61wvN/e4+yIsTKbrYxZYvhQkjRzxoGoYrNJYdYkgQ0Hzv0duEF0AzB98ZoLFyin
         3s8dpLfV9cVOHeqxzmLXha1ZVAQLd16ex5o+r7zS93tWhLokMscojicU0dpLjwADp5+u
         LZkRUWqkqNcLXl9U/A3e0wNKQaQK3ztc2J6B7Oxh9DkfJGJYkIBpJ6xaDCeFke9+qRrq
         wxxjNwiXOLTLCJYzVeUlqI6E+rlAXBEATskwto8EAqxSIYSrYQ5YILbQofqqMC46SId6
         RIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCb8CZTKeROG7RwPnOW4nfAO/rfGHrLFULq+VYI3XnA=;
        b=irfJkHl4M+imayfGyALAs0UFxpGCO7bJy5Wlvj4Z6ui2THxq2nqk/Jrpb6HDVtrAyt
         bivrBXsbenNRcLptmFsUUpalqy2PdpnfItZv5vyilDczJnnHdZrWBKhRtBXaSkNkd+uc
         oGw1amzBsasISb6hBrielsKvlMDa1AqlEmvrSUF/OgsX1rNP8LgYV4Y7qM7Io+POZMWw
         1YctMGdr316GWg3hIHG225nCf6WXlL0TcTVob9bEU0AsmtM+0zKCQT/JtIBg/v5sGghU
         t1nS4jFvEtpS+QwlCOoNIl5LRL2DBjLgn4w8+wN5e1Djzd3NN2nIrLDwBZaDds1KlTmu
         qkqg==
X-Gm-Message-State: AKaTC03rBede3vSstYSRXIW0+E8yaWk9JZOAxjQjOgLGCSgKA6MZwmiPysh6IHEgkg10Ea21
X-Received: by 10.99.51.132 with SMTP id z126mr186574497pgz.173.1481748662452;
        Wed, 14 Dec 2016 12:51:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a0bd:b7d6:4331:46ad])
        by smtp.gmail.com with ESMTPSA id i11sm89869786pgn.17.2016.12.14.12.51.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 12:51:00 -0800 (PST)
Date:   Wed, 14 Dec 2016 12:50:59 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 5/5] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161214205059.GE20063@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-6-git-send-email-bmwill@google.com>
 <20161214164050.uxk434kzhw6au4c2@sigill.intra.peff.net>
 <20161214201323.GC20063@google.com>
 <20161214203752.GD20063@google.com>
 <20161214204102.hwjb3i4aaxf3oigq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214204102.hwjb3i4aaxf3oigq@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14, Jeff King wrote:
> On Wed, Dec 14, 2016 at 12:37:52PM -0800, Brandon Williams wrote:
> 
> > Naively looking at the code (and your longer suggestion), is there a
> > reason why we couldn't simply have http-walker set CURLOPT_PROTOCOLS
> > with get_curl_allowed_protocols(0) in the fetch_alternates() function?
> > That way we just override the CURLOPT_PROTOCOLS value when alternates
> > are involved.
> 
> No, because we may have many curl handles (especially for the
> http-walker, which wants to fetch several objects simultaneously), and
> they get recycled as needed for many requests.
> 
> So setting a restriction there on slot->curl will only cover the one
> handle, and miss other ones which may be used later (and likewise, that
> one handle with the restriction may get recycled and used for a
> non-alternate fetch, and would be unnecessarily restrictive).
> 
> That's why any curl-level settings have to happen when we call
> get_active_slot(), since that's when we know what we're actually using
> the handle for.

Fair enough, I figured there may be some reuse happening with the curl
handles but didn't do enough digging to discover that myself.  Thanks :)

-- 
Brandon Williams
