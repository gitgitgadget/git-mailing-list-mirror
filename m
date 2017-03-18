Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B9C2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 14:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdCRODa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 18 Mar 2017 10:03:30 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:57498 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751007AbdCROD3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 10:03:29 -0400
Received: from app01.ox.hosteurope.de ([92.51.170.8]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:128)
        id 1cpE1B-0000MV-MS; Sat, 18 Mar 2017 14:03:37 +0100
Date:   Sat, 18 Mar 2017 14:03:37 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Reply-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Florian Adamus <florian-adamus@gmx.de>
Message-ID: <1904675654.3064641.1489842217692.JavaMail.open-xchange@app01.ox.hosteurope.de>
In-Reply-To: <2ebd249b-39a4-23c2-13e3-23c91a938313@web.de>
References: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66> <179b5d92-ee96-c2df-dbd8-eb96f7bbdb24@virtuell-zuhause.de> <20170315155952.x2tpiudi6rbqidvi@sigill.intra.peff.net> <20170315161308.sbyoxzst7ffcu6qs@sigill.intra.peff.net> <93ccf86d-0090-a311-9825-7e23fd6a4141@web.de> <xmqq4lyudyaq.fsf@gitster.mtv.corp.google.com> <2ebd249b-39a4-23c2-13e3-23c91a938313@web.de>
Subject: Re: Commiting files larger than 4 GB on Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev61
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1489845809;fed99393;
X-HE-SMSGID: 1cpE1B-0000MV-MS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Torsten Bögershausen <tboegi@web.de> hat am 17. März 2017 um 06:29
> geschrieben:
> 
> 
> On 15/03/17 22:29, Junio C Hamano wrote:
> > Torsten Bögershausen <tboegi@web.de> writes:
> >
> >> The real "show stopper" is at the end.
> >> ...
> >>
> >> ==========================
> >> And it seams as if zlib is the limitation here.
> >> Unless we include the zlib source code into Git and redefine uLong,
> >> is there a nice way around this:
> >> ===========================
> >>
> >>
> >> /usr/include/zconf.h:#  define uLong                 z_uLong
> >> /usr/include/zconf.h:#  define uLongf                z_uLongf
> >> /usr/include/zconf.h:typedef unsigned long  uLong; /* 32 bits or more */
> >> /usr/include/zconf.h:typedef uLong FAR uLongf;
> > Hmph.  Would ef49a7a0 ("zlib: zlib can only process 4GB at a time",
> > 2011-06-10) and e01503b5 ("zlib: allow feeding more than 4GB in one
> > go", 2011-06-10) help us here, though?
> >
> That is good news.
> I tried to replace all "unsigned long" with size_t and got that compiling
> without warnings under Windows 64 bit.
> 
> Compiling this on a 32 bit Linux gave lots of warnings..
> 
> Converting all unsigned long into is probably an overkill.
> Some may stay, some may be converted into off_t, and some size_t.
> 
> Does anybody wants to pick this up?

I'd be interested, altough I can't promise to get it done in the near future.
