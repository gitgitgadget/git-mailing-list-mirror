Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3060620C11
	for <e@80x24.org>; Wed,  6 Dec 2017 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbdLFPnO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 6 Dec 2017 10:43:14 -0500
Received: from elephants.elehost.com ([216.66.27.132]:36366 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbdLFPnO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 10:43:14 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vB6FhAU3049218
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Dec 2017 10:43:10 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <008d01d36e48$747cc130$5d764390$@nexbridge.com> <877eu0uvb2.fsf@evledraar.gmail.com> <20171206084833.GA9501@sigill.intra.peff.net>
In-Reply-To: <20171206084833.GA9501@sigill.intra.peff.net>
Subject: RE: Documentation Breakage at 2.5.6
Date:   Wed, 6 Dec 2017 10:43:03 -0500
Message-ID: <002601d36ea8$ea80b160$bf821420$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFJqr9tdoz5nNh/MRDCzDickCDUBQFCj0pwAi1FvPmkLnIpoA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On December 6, 2017 3:49 AM, Jeff King wrote:
>On Wed, Dec 06, 2017 at 09:14:57AM +0100, Ævar Arnfjörð Bjarmason wrote:
>> > I'm trying to upgrade the NonStop port from 2.3.7 upward eventually 
>> > to
>> > 2.15.1 and hit a snag on documentation. The xmlto component is a bit 
>> > new to me and I hit the following error:
>Did it work before in v2.3.7? If so, can you bisect to the breakage?
It worked fine at 2.3.7. No seeming dependency on docbook at that point - it was never on my system.

>One alternative is to try to avoid docbook entirely. The only way to get manpages with asciidoc is to generate docbook and then process it, but:
I have asciidoc installed, but using it via Make?

> - you can generate HTML directly (and "make -C Documentation html" does
>  this). Perhaps not as nice, but you still at least have some
>   documentation.
Not an option. I need git help to work.

> - asciidoctor can generate manpages directly. I don't think our
>   Makefile supports that now, but it might not be too hard to hack in
>  (we already have some basic asciidoctor support). I'm not sure how
 > hard it would be to get Ruby running on NonStop
Ruby runs fine. I'm a bit out of my configuration depth here.

>And of course one final option is to generate the manpages elsewhere and copy them in, since they're platform-independent.
>In fact, that's what quick-install-man should do (you just have to clone Junio's >git-manpages repository -- see the INSTALL file).

I've gone down this path and it works. Much cleaner in fact. Dependencies of docbook (jade) are too reliant on GCC C++ forms to port to the platform - not to mention being SVN, which is culturally uncomfortable 😉

One request to Junio: Would it be possible to tag the commits to align with the tags in the main repo? That way, I can build a nice little Jenkins job to automatically fetch the correct commit for man pages when packaging up a release.

-Peff

