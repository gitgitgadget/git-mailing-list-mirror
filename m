Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31EDA1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbcLEXWy (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 18:22:54 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36688 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753380AbcLEXWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:22:53 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so141136696pgc.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 15:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JZxQVxKgHiF+QSBFm04O8utVq7Jj1imc5sZoMXHl7Ik=;
        b=dPPKPDzopaDDJ+gNuHVUjeQuj5eAvbm1PEbC/UrUU7rPCt4HmX+EKkq4MrZIa/egrF
         5J2VPUwEu9lJfiOE1KDx2UC+bAWbJxJOq0h8sijUSF8qXk+QaElJ36HxdVoRhyKda1aj
         Tzt8D4a4QtF2guQecRrZ3UV3cN9162kvg5Nt1hWXN02Oq/m8LGRnqmCQuCBHOSovHayn
         mfiZgOcvQbXLfuFl6inc9hIvLNJgKs1YoFKQPlA+whjL3Fbydx0Nk+n7z4vfmbfkPSws
         0rEF0vVQvMztMGOiNFjyq86IWkq74/PnPYIioQn2FFgO3lLYh/JTeGaa70GlPbwCHGsy
         H0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZxQVxKgHiF+QSBFm04O8utVq7Jj1imc5sZoMXHl7Ik=;
        b=GXWDXt5S+WM2uR54TH2iNvd00KO/Blrn22PMRI4q5PzJ720rkwIQWsaG0EgMfpJNUZ
         lcyuCMNGGbVTd5n4NSy00AIF+ZaGd6FTUykvBf7mLpWbsQAm+Zl0yeIi9mbB/bdowQS1
         2MqxIF29gWz4Uc7mlMOX/BTSBb7tKNPWvLwbxTfNOx6gZkfqI1y2bZwxUItxMh1Ra4eG
         zhgYwz6L73lY/3EgPq2tJDpygpACwiTQKe+0ttOvf1av6qIlB52lM7WMV657htRZV5Au
         PKcbLwF69eC82onwwHGHjATnetHUlutObmbTTeY9V22yV2/Ao9juSyw96DofTkMzTP96
         sbVg==
X-Gm-Message-State: AKaTC00ykNH8KDFQIk/4hPwL6qXSozbly07+6m4wGz38vfjxG3FcBvSHDk0hRhhdZUYK/dSX
X-Received: by 10.84.216.10 with SMTP id m10mr129700638pli.131.1480980172548;
        Mon, 05 Dec 2016 15:22:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:20ca:c78:1a67:9579])
        by smtp.gmail.com with ESMTPSA id b71sm29791315pfj.62.2016.12.05.15.22.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 15:22:51 -0800 (PST)
Date:   Mon, 5 Dec 2016 15:22:50 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161205232250.GA173397@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
 <20161201235856.GL54082@google.com>
 <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
 <20161205222211.GF68588@google.com>
 <xmqqa8ca2cc7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa8ca2cc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > I just took Jeff's series and applied it on top of mine (and fixed the
> > small problem causing t5812 to fail) and then rebased it to v2.9.0.
> > There were a few issues that needed to be resolved but nothing too
> > hairy.  So it would definitely be doable to backport it to the
> > maintenance tracks.
> 
> Thanks for trying.  I'd definitely prefer a series that is based on
> an older codebase that is merged to pu->next->master->maint (in
> other words, avoid "backport" and rather have "forward merge").

Ah ok.  Do you want me to send out the combined patch series based on
2.9.0 (or some other point in time) then?

-- 
Brandon Williams
