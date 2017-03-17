Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C16320951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbdCQWna (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:43:30 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33260 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdCQWna (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:43:30 -0400
Received: by mail-pg0-f46.google.com with SMTP id n190so49697130pga.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ppp1w13jcYMkEFEsnUhWx+0Aqtj3dNqEVDq+TQeRVfM=;
        b=ifP9t1e8dLnCJf4Zy4By/RaQfoBfQZe0l/J4L92D4QrDHHBCijdvoMo43fv7aSmLM7
         kIJN8Iz2wMUBJ0WKHq3Q81cf5HHw7Mq8PGjpORSX6e7rmdJ7+UPqP/C7pfCnqv3AVah/
         sg4hu3n8k1oLoHbuZqKfHXmRBeRlcnkwKJD67cUFK8lHkIROzkNuu5gaWWKpVwkFCMqe
         EB2SIC/yB3pVv5afycKYkIqh9474VFNxv4khI7ZW2eev/Pr/WBxQNLlFi0v0Ch9YxNwS
         rG11ooCCX4c9maTFRFAaco2umwS1BMchLry+Sz/m9fDS0F8Gmh8Vp2XEBifdbUwNO4TZ
         AemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ppp1w13jcYMkEFEsnUhWx+0Aqtj3dNqEVDq+TQeRVfM=;
        b=VRM8XsdukGOJ3py4lBZVYT25PmDph56iXODdShhArKmY4A3P0e1lOETXX/RfULtznB
         qoC1W7x6tWc+L4sbqXy6qPZ/4Bb90LlDhs/lT770oqEXtQ9gafx36fpJC9c5di4sUKcu
         WzRAz4QoUV9UTbEcrYpmJD1+UVR7LKVAvnO8fQOA8Fh4Iwm29FBV6wZz8u0+UYDWekbj
         NEueTYF4KLX4r8XIpLC4m6osQMOTHWFk11qxnHqQVTLLk9wdzHwwcrPn1EtqzfsXz6c9
         P0s8LdIKCIYhs5AhedQZhh7Hut3wlXqJV35eHDRnFhU3ur0kyF9NL8ndt29+1+teMZbC
         CtYw==
X-Gm-Message-State: AFeK/H0aqpkgTH7/Lrzst8UUkNVW/wRmyF5KMKpaJBcVNJVYHsFvrK0We0H6OIzInSxGrIYs
X-Received: by 10.98.42.151 with SMTP id q145mr19113420pfq.175.1489790554318;
        Fri, 17 Mar 2017 15:42:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id z25sm6053084pfi.28.2017.03.17.15.42.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:42:33 -0700 (PDT)
Date:   Fri, 17 Mar 2017 15:42:32 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: fix build with no thread support
Message-ID: <20170317224232.GE63813@google.com>
References: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
 <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
 <20170317184701.GB110341@google.com>
 <20170317223741.qwfh2zw37y3jbeev@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317223741.qwfh2zw37y3jbeev@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Jeff King wrote:
> On Fri, Mar 17, 2017 at 11:47:01AM -0700, Brandon Williams wrote:
> 
> > While taking a look at this bug I discovered that the test suite doesn't
> > pass 100% of the test when compiled with the NO_PTHREADS option. The
> > following tests seem to be failing:
> > 
> > t1060-object-corruption.sh                       (Wstat: 256 Tests: 13 Failed: 3)
> >   Failed tests:  7-9
> >   Non-zero exit status: 1
> > t5306-pack-nobase.sh                             (Wstat: 256 Tests: 4 Failed: 1)
> >   Failed test:  4
> >   Non-zero exit status: 1
> > t5504-fetch-receive-strict.sh                    (Wstat: 256 Tests: 12 Failed: 2)
> >   Failed tests:  4-5
> >   Non-zero exit status: 1
> > t5530-upload-pack-error.sh                       (Wstat: 256 Tests: 10 Failed: 1)
> >   Failed test:  10
> >   Non-zero exit status: 1
> > 
> > I didn't take a close look at it but this would seem to indicate that we
> > don't worry to much about systems without pthreads support.  Just food
> > for thought.
> 
> Hmm. We used to. What version did you test? Everything passes for me at
> 0281e487f^ (after that it fails to build). So AFAICT v2.12.0 is the
> first release which does not work with NO_PTHREADS.
> 
> -Peff

The version I ran tests on was what the master branch was pointing to a
day or so ago:

v2.12.0-264-gd6db3f216

-- 
Brandon Williams
