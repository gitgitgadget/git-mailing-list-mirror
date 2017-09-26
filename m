Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FEED202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 00:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936574AbdIZARf (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:17:35 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:48709 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935704AbdIZARf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:17:35 -0400
Received: by mail-pf0-f171.google.com with SMTP id n24so4660282pfk.5
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=to571e6z2wzCURkJJjx6j3XCBblU704cmClH8WgIND4=;
        b=IJE82IKDvdgytiDUYOmU0O4OfogpxdxCJOEqZNudFM5bOq03274II35mf4j+SKX/kq
         gj0vnOBPKyTyLYOrrDzO/s/6DakvFw0HKB0bfA6k7JePFcXBG1AKjGos+eEjLG5+4wOI
         3e7McSrnsSOa111oYBwAQ89IyDdd6TBaAEhB+U5p2tR0GmOZ1aR/v06P/xAcwPF3pGgE
         E9QVC149YYK9mBKcAhwRFR0DLQe7NyZ3yj+60OG02evqCI/FRtCaaZkt6MYAWmEywCo+
         XJn8pHhlcetHe3i9ptj9tyvtH5M5ppJd25U9OummhL79YBpl4WlEUxLsLzEbuiBfZqQv
         qH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=to571e6z2wzCURkJJjx6j3XCBblU704cmClH8WgIND4=;
        b=qCbOGzRO8xMxEqCt9BQ2G7eHtpeHdslnt2Z49pysqkAxVcEBnm3iOo+ciJwXmt2kze
         016TpCxRXcA8OmFHEdiCzmPrWxLl19W2oe1tRAqfBGxxAydOyJzs6bAEgoCAqcv5SbhQ
         ua7zds4BicHupSyltWpTWs4RJlyV2nHPa2llnUFhodeZBYe/xexMheSnwn2r0Ib07BIz
         K23PA2+gC2WFltmB40NO0sPCpoacDZxuqa8OVPBxj1ctbMyIIPA8UoA2S/XSEddIm6iA
         iiEDbiHBJrhTlnYsyNB+UA9x0GVKp5SOi4tW3wv+QyVP+OC0TgqufZUT6ZDeAb2rpMqD
         0V5Q==
X-Gm-Message-State: AHPjjUiSYDOlpydPrg2Q82/00zBkuNZ+ktgPa0uwJ7l2qBsOlyuwiqXl
        ocn/HeRk76lJfWO6aBJT9j0=
X-Google-Smtp-Source: AOwi7QDU7WvWr19X8cFtznYl9B4+E1nLBNYoRvrMgIk5x/Xj9psbsu/fQvPJtXG9IYuO+VJAAO+vcw==
X-Received: by 10.99.114.92 with SMTP id c28mr9027535pgn.378.1506385054441;
        Mon, 25 Sep 2017 17:17:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id j2sm13478115pgn.26.2017.09.25.17.17.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 17:17:33 -0700 (PDT)
Date:   Mon, 25 Sep 2017 17:17:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926001732.GP27425@aiede.mtv.corp.google.com>
References: <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
 <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
 <20170926001602.GO27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926001602.GO27425@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> On Mon, Sep 25, 2017 at 08:09:13PM -0400, Jeff King wrote:

>> ENODATA is not too bad. On my glibc system it yields "No data available"
>> from strerror(), which is at least comprehensible.
>>
>> We're still left with the question of whether it is defined everywhere
>> (and what to fallback to when it isn't).
>
> So,
>
> #ifndef EUNDERFLOW
> #ifdef ENODATA
> #define ENODATA EUNDERFLOW
> #else
> #define ENODATA ESPIPE
> #endif
> #endif
>
> ?

Uh, pretend I said

#ifndef EUNDERFLOW
# ifdef ENODATA
#  define EUNDERFLOW ENODATA
# else
#  define EUNDERFLOW ESPIPE
# endif
#endif

Sorry for the nonsense.
Jonathan
