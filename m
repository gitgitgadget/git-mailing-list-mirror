Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E17A20357
	for <e@80x24.org>; Fri,  7 Jul 2017 19:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbdGGTdG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 7 Jul 2017 15:33:06 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:37176 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdGGTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 15:33:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 01828100056;
        Fri,  7 Jul 2017 19:33:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1RIZ9p_EXm88; Fri,  7 Jul 2017 19:33:03 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id E25468002E;
        Fri,  7 Jul 2017 19:33:03 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Fri, 7 Jul 2017 19:33:03 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Fri, 7 Jul 2017 19:33:03 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Junio C Hamano' <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "benpeart@microsoft.com" <benpeart@microsoft.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "peff@peff.net" <peff@peff.net>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>
Subject: RE: [PATCH v5 7/7] fsmonitor: add a performance test
Thread-Topic: [PATCH v5 7/7] fsmonitor: add a performance test
Thread-Index: AQHS90+/gGPSC3jXbUu8Wjqn71m4dKJIwIHQ
Date:   Fri, 7 Jul 2017 19:33:03 +0000
Message-ID: <5aeeffc9774249b08ee510d7fbd93d29@exmbdft7.ad.twosigma.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
        <20170610134026.104552-8-benpeart@microsoft.com>
        <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
        <9c1ed8d4-6bdb-e709-758d-4b010525e9e3@gmail.com>
        <xmqqvany2z84.fsf@gitster.mtv.corp.google.com>
        <7ec36d90-7fbc-c30f-e15e-f06d39e1f206@gmail.com>
 <xmqqeftsayeg.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqeftsayeg.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.15]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C
> Hamano
> Sent: Friday, July 7, 2017 2:35 PM
> To: Ben Peart <peartben@gmail.com>
> Cc: git@vger.kernel.org; benpeart@microsoft.com; pclouds@gmail.com;
> johannes.schindelin@gmx.de; David Turner <David.Turner@twosigma.com>;
> peff@peff.net; christian.couder@gmail.com; avarab@gmail.com
> Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
> 
> Ben Peart <peartben@gmail.com> writes:
> 
> > On 6/14/2017 2:36 PM, Junio C Hamano wrote:
> >> Ben Peart <peartben@gmail.com> writes:
> >>
> >>>> Having said all that, I think you are using this ONLY on windows;
> >>>> perhaps it is better to drop #ifdef GIT_WINDOWS_NATIVE from all of
> >>>> the above and arrange Makefile to build test-drop-cache only on
> >>>> that platform, or something?
> >>>
> >>> I didn't find any other examples of Windows only tools.  I'll update
> >>> the #ifdef to properly dump the file system cache on Linux as well
> >>> and only error out on other platforms.
> >>
> >> If this will become Windows-only, then I have no problem with
> >> platform specfic typedef ;-) I have no problem with CamelCase,
> >> either, as that follows the local convention on the platform (similar
> >> to those in compat/* that are only for Windows).
> >>
> >> Having said all that.
> >>
> >> Another approach is to build this helper on all platforms, ...
> 
> ... and having said all that, I think it is perfectly fine to do such a clean-up long
> after the series gets more exposure to wider audiences as a follow-up patch.
> Let's get the primary part that affects people's everyday use of Git right and then
> worry about the test details later.
> 
> A quick show of hands to the list audiences.  How many of you guys actually
> tried this series on 'pu' and checked to see its performance (and correctness ;-)
> characteristics?
> 
> Do you folks like it?  Rather not have such complexity in the core part of the
> system?  A good first step to start adding more performance improvements?  No
> opinion?

I have not had the chance to test the latest version out yet.  The idea, broadly, seems sound, but as Ben notes in a later mail, the details are important.  Since he's going to re-roll with more interesting invalidation logic, I'll wait to try it again until a new version is available.
