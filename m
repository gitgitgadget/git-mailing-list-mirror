Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C651F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDCScE (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:32:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35005 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeDCScD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:32:03 -0400
Received: by mail-pl0-f68.google.com with SMTP id 61-v6so8062776plb.2
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hjDnU7TnjBUyNwYKmandXTkJ2r22a2GuoOJ09tw3K0k=;
        b=CjVrdsT86+TUH7WJW3ABFjHgvHHr8VH+WPmtsNQ+WnYoqIHiieqjo1Lki/heAq4UcE
         0CQQge2gN0d+L74JgMwODXzQCqgo8r5osd+qOaq73wtZTPlOvl2uNsUXvrgvzkAINA7F
         6w9qYd+NA8/RhBJ+oFo9p/yh3NJdyzn6JL01IldwMV8KTqYLwB4Lph7j1WRVvziaoI59
         K2Kwo/NEjbxTQ8o70XOndqRg28eTx1s7WcebSea1k5tVto85fRbPAYY33aGbm59hslUm
         2O4CXVI/SujEbcZN4pvPRHIIUF3/46WZEe0jI/wlGmqFVx9s0JrTze6watYO3EZJUgP/
         BEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hjDnU7TnjBUyNwYKmandXTkJ2r22a2GuoOJ09tw3K0k=;
        b=BP+kk2cQxaIa0YaAohj/Q9Lp0VEybdy7KD84rjYy5kSBUQ99Bvi3IQNu9fT5gOMWuq
         lkZCXa4AxVbZlozG8epcciDgLfv+UbKmk974pi1hFe0TfzXKA+DECLa/vBBh0OJPcz9s
         FKPIqVxO7UK2kwiQKQvajckIgPHSodSu5qz44II87Tcp3xmmeCpoqX62/Yo3WLhCAsJx
         YcEBhSkq8Cgffz1LqFkDs3z4NJS4AR5pbpBLCqi2uTWFKKuBdTDBSKPNG2NIY+myS5Hq
         ro4x9CRR6b3A5GYXAvK0daa72J6xapLqigYsbt47G+Uby+O5ArFO4Y4kUS0Yivizin3K
         a3+g==
X-Gm-Message-State: AElRT7GlLUmsyLxgn9mv6vKYIboqan2gM5uUO80kNWWR5lGOAHQZ/TFY
        YRzvPF6YCRXQ6Ug42IHMiF0c7ngfIzw=
X-Google-Smtp-Source: AIpwx4/65lMwuPxymcEktTAs4TPq57iBQjok9ces6/AFL6CZmSyBxSZKjYuSx6ZVkQCFAV9X3FOV+A==
X-Received: by 10.99.49.84 with SMTP id x81mr5206122pgx.38.1522780322865;
        Tue, 03 Apr 2018 11:32:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id c15sm7034779pfm.114.2018.04.03.11.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 11:32:02 -0700 (PDT)
Date:   Tue, 3 Apr 2018 11:32:01 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
Subject: Re: [PATCH 2/6] commit: add generation number to struct commmit
Message-ID: <20180403183201.GC100220@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403165143.80661-3-dstolee@microsoft.com>
 <20180403180536.GB100220@google.com>
 <20180403182800.GA8377@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403182800.GA8377@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/03, Jeff King wrote:
> On Tue, Apr 03, 2018 at 11:05:36AM -0700, Brandon Williams wrote:
> 
> > On 04/03, Derrick Stolee wrote:
> > > The generation number of a commit is defined recursively as follows:
> > > 
> > > * If a commit A has no parents, then the generation number of A is one.
> > > * If a commit A has parents, then the generation number of A is one
> > >   more than the maximum generation number among the parents of A.
> > > 
> > > Add a uint32_t generation field to struct commit so we can pass this
> > 
> > Is there any reason to believe this would be too small of a value in the
> > future?  Or is a 32 bit unsigned good enough?
> 
> The linux kernel took ~10 years to produce 500k commits. Even assuming
> those were all linear (and they're not), that gives us ~80,000 years of
> leeway. So even if the pace of development speeds up or we have a
> quicker project, it still seems we have a pretty reasonable safety
> margin.
> 
> -Peff

I figured as much, but just wanted to check since the windows folks
seems to produce commits pretty quickly.

-- 
Brandon Williams
