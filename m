Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9172018A
	for <e@80x24.org>; Fri,  1 Jul 2016 13:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbcGAN5u (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 09:57:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:59860 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbcGAN5s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 09:57:48 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MOSNd-1bDjkY0FFt-005swJ; Fri, 01 Jul 2016 15:57:43
 +0200
Date:	Fri, 1 Jul 2016 15:57:42 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <xmqqy45n52xp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607011551550.12947@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de> <xmqqy45n52xp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b42XgTc0lu9k5pRtcgy0viRhSu3tCp7xDRBQ2XeCyzDyttaa7v7
 aaSavqrEKSx6ksf+7HpB0j3rg3LMeGlS+Extmi1pYpdxu+JAGQkmEweIUB3tQZEu/mLLwO3
 MMRjLMczyD8mk/JzfDg5CcExNQOtL7IWecrEkY9sSYAtGbFU0TwWmy7Oe3AoT7EIfBzzWax
 KLAAyBoHQ7feZY4zMu9IQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Ydc3XeXSV7g=:w+5KwooHE0sLpvki6RxWGB
 93hmXrr3TcnHf5wLXcOYei5XRJOEcMhCUS0Jbq9P/tqxYbo3Et0uFsO3/nEnhUNx7OheR6NY2
 XvaNAQSZVi1ePt7R9ejgchgNM0mjsptcjZ8ch/wwZfJKDfXN9HbBtoLUG+Hg46sxFQolY01lL
 88ULIMpLhczkorG95Ck/VMzdhSjRF+16a7kVP/JjTi7P1BDTysEn41WP0bxM1N6M4iOfMo/5N
 PeCpImdFUg4qUBuMjzveyjbfhDPuFQzjJSxmOZkNOxEbLpf8Gih88GEfmPAitEVU8U3T4TuV5
 9QFl3qtoqMDFKO3jwSUET/arqGR/DnonPI3waUitCt4BBtupF4k8+QUc+q0JE/TQI6xshTZ7T
 EZO9Ak7N1kMjFbVQk9ASf5IjoZjYn1UwfGc9ktVuaoxuEfvVKMTNL8MOwtju0bAEmJNECqfcM
 z1oJcs73yQkeBzxmjDS8acFqxe6oRhmAOEY/2AFeBbANchxB3sJ+pkM6/CTbGhwTsFOYC2msC
 vPjePGyZ2YdD7VFsTtkFk7fgTI6fBbH8TAqHA1oykeV7Io26/tB98EUqnbRvEsfIAUviBsoao
 NFwsdflbvLi8jP+z5ZhvV4ahHbf5M2+JAdjdEs7aN18oYC/lCc8Z5g/CYFKlhiCX3D67Hn0P3
 vJxqnCnuLBAWVkZ8lDkOCyt30w6AuzcexMX7TrsfcyzNphIDA0a2Q5/0ZkddVo+4CsQ89TelD
 8/ZgDv7F8aF+q64HyvLNGXd24mCM4ZcKUGfXx2VO41WDPcAsis6NDnWxjDanBas1S9TDAR5cb
 LLWG0t0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > While developing patch series, it is a good practice to run the test
> > suite from time to time, just to make sure that obvious bugs are caught
> > early. With complex patch series, it is common to run `make -j15 -k
> > test`, i.e. run the tests in parallel and not stop at the first failing
> > test but continue.
> 
> Hmmm, my tests run in parallel and do not stop at the first one
> without '-k'.  What are we doing differently?

Probably none of your tests are failing... When I run tests with -j15 and
without -k, as soon as *any* test fails, the other 14 jobs stop after
running their respective current tests.

This is particularly annoying when some early test fails and a subsequent
test run reveals that *also* one of those pesky SVN tests failed.

> > It is the most convenient way to determine which tests failed after
> > running the entire test suite, in parallel, to look for left-over "trash
> > directory.t*" subdirectories in the t/ subdirectory.
> 
> Good idea, but I'd drop "in the t/ subdirectory" from the
> description.

Okay.

> > +failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard trash\ directory.t[0-9]*)))
> > +
> 
> This would not work if you use --root=<there> in GIT_TEST_OPTS, I am
> afraid.

Bah. You're correct. Would it be okay with you if I simply punted, like
this:

ifeq (,$(findstring --root,$(GIT_TEST_OPTS)))
failed: ...
else
failed:
	echo "Sorry, the 'failed' rule is incompatible with --root=..." >&2
endif

? I really do not have time to spend more time on this right now...

Ciao,
Dscho
