Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72B72042F
	for <e@80x24.org>; Wed, 16 Nov 2016 14:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbcKPOjb (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 09:39:31 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:49799 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbcKPOja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 09:39:30 -0500
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c71N0-0008Or-Vy; Wed, 16 Nov 2016 15:39:27 +0100
Date:   Wed, 16 Nov 2016 15:39:25 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Message-ID: <20161116143925.GA32631@book.hvoigt.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
 <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
 <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
 <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
 <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com>
 <20161115120718.GA7854@book.hvoigt.net>
 <20161115153159.mxfl73dnhljad5so@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115153159.mxfl73dnhljad5so@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 10:31:59AM -0500, Jeff King wrote:
> On Tue, Nov 15, 2016 at 01:07:18PM +0100, Heiko Voigt wrote:
> 
> > On Fri, Nov 11, 2016 at 09:22:51AM +0100, Lars Schneider wrote:
> > > To all macOS users on the list:
> > > Does anyone execute the tests with GIT_TEST_HTTPD enabled successfully?
> > 
> > Nope. The following tests fail for me on master: 5539, 5540, 5541, 5542,
> > 5550, 5551, 5561, 5812.
> 
> Failing how? Does apache fail to start up? Do tests fails? What does
> "-v" say? Is there anything interesting in httpd/error.log in the trash
> directory?

This is what I see for 5539:

$ GIT_TEST_HTTPD=1 ./t5539-fetch-http-shallow.sh -v
Initialized empty Git repository in /Users/hvoigt/Repository/git4/t/trash directory.t5539-fetch-http-shallow/.git/
checking prerequisite: NOT_ROOT

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir" &&
	uid=$(id -u) &&
	test "$uid" != 0

)
prerequisite NOT_ROOT ok
httpd: Syntax error on line 65 of /Users/hvoigt/Repository/git4/t/lib-httpd/apache.conf: Cannot load modules/mod_mpm_prefork.so into server: dlopen(/Users/hvoigt/Repository/git4/t/trash directory.t5539-fetch-http-shallow/httpd/modules/mod_mpm_prefork.so, 10): image not found
error: web server setup failed


It seems the other failures have the same cause.

Cheers Heiko
