Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83401FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 19:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764352AbcINT4S (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 15:56:18 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:46022 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755879AbcINT4R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 15:56:17 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Sep 2016 15:56:17 EDT
Received: from [84.131.240.40] (helo=sandbox)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bkG8r-0004oZ-GB; Wed, 14 Sep 2016 21:46:45 +0200
Date:   Wed, 14 Sep 2016 21:46:43 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 2/2] serialize collection of refs that contain submodule
 changes
Message-ID: <20160914194643.GC7613@sandbox>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
 <20160914175130.GB7613@sandbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160914175130.GB7613@sandbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 07:51:30PM +0200, Heiko Voigt wrote:
> Here are some numbers (using the my development clone of git
> itself) from my local machine:
> 
> rm -rf <test-git> && mkdir <test-git> &&
> (cd <test-git> && git init) &&
> time git push --mirror <test-git>
> 
>    real	0m16.056s
>    user	0m24.424s
>    sys	0m1.380s
> 
>    real	0m15.885s
>    user	0m24.204s
>    sys	0m1.296s
> 
>    real	0m16.731s
>    user	0m24.176s
>    sys	0m1.244s
> 
> rm -rf <test-git> && mkdir <test-git> &&
> (cd <test-git> && git init) &&
> time git push --mirror --recurse-submodules=check <test-git>
> 
>    real	0m21.441s
>    user	0m29.560s
>    sys	0m1.480s
> 
>    real	0m21.319s
>    user	0m29.484s
>    sys	0m1.464s
> 
>    real	0m21.261s
>    user	0m29.252s
>    sys	0m1.592s
> 
> Without my patches and --recurse-submodules=check the numbers are
> basically the same. I stopped the test with --recurse-submodules=check
> after ~ 9 minutes.

Fun fact, I let the push without my patch and with
--recurse-submodules=check finish:

real	27m7.962s
user	27m15.568s
sys	0m2.016s

Thats quite some time...

Cheers Heiko
