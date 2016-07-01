Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032E920FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 06:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbcGAGo3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:44:29 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:40237 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbcGAGo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:44:28 -0400
X-Greylist: delayed 130233 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Jul 2016 02:44:28 EDT
Received: from [91.113.179.170] (helo=[192.168.92.22])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1bIsBX-0003w2-56; Fri, 01 Jul 2016 08:44:19 +0200
Subject: Re: topological index field for commit objects
To:	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net> <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net> <5774F4C7.805@gmail.com>
 <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
 <20160701031711.GA4832@sigill.intra.peff.net>
Cc:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
From:	Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <df4f72c0-72fc-a779-3fda-3fbc146419db@syntevo.com>
Date:	Fri, 1 Jul 2016 08:45:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160701031711.GA4832@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 01.07.2016 05:17, Jeff King wrote:
> On Thu, Jun 30, 2016 at 11:12:52AM -0700, Linus Torvalds wrote:
>
>> I do think that it's ok to cache generation numbers somewhere if there
>> is an algorithm that can make use of them, but every time this comes
>> up, it's just not been important enough to make a big deal and a new
>> incompatible object format for it. The committer date is preexisting
>> and has existing pseudo-generation-number usage, so..improving on the
>> quality of it sounds like a good idea.
>
> If you are OK with a cache, I don't think one needs to change the object
> format at all. It can be computed on the fly, and is purely a local
> optimization.

What I like about the local cache is that it can be fixed easily: if we 
had generation numbers already, there would certainly be a few 
repositories now which would violate the parent - child condition 
(however that has happened) and then you have to deal with this scenario 
anyway (or tell the user to rewrite his entire history). It's a lot 
easier to throw away and rebuild the cache.

Also, the local cache can be improved over time, starting with 
generation numbers now and one day supporting a FELINE index or whatever 
will come.

-Marc
