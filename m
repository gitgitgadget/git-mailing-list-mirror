Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399CF20248
	for <e@80x24.org>; Tue,  5 Mar 2019 18:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfCESm6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 13:42:58 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:34625 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbfCESm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 13:42:58 -0500
Received: from DESKTOP-E4U7JCE ([5.168.31.165])
        by smtp-33.iol.local with ESMTPA
        id 1F1ihVvgTlgOv1F1ihW0rq; Tue, 05 Mar 2019 19:42:55 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1551811375; bh=o7oWYhMfgm0PFtER8lGkQr/eBXICNAzLgdCOpTGdfcQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=rGYX7ep9bOB5IGMWu+g7AMTEJOUTVXqM1bFr76PXzLom1Faqh8zaUn55s6HDxGRLu
         63b82cgSibR5EaKXya7yM6B6C4oMJxWoKbOTm7tpugW/H5ZMQKqFcXM2rerZEqtJSP
         Y7EEzGgyUG5pOuhNiLxhZEDOO2mw8Le1yVPRTH3XghCthH2FzSvQw+IJEsi/wYCDcA
         k4PcfbSwXmm+3X8y3pmLq1V3qFdA5NFxHuRlGknpE656U0rmeYb2sLe216nvM24MZt
         k61V90tVrtCf+2IHrF4Nl6uQxusMJ2MSr8tPGq82Hz1Sgx+tqh3MYxd0J0/Ex4yN/H
         0+8MhUZJIVwdw==
X-CNFS-Analysis: v=2.3 cv=MoqDFFSe c=1 sm=1 tr=0
 a=P9yetr8jBxga4aTyYjpHnA==:117 a=P9yetr8jBxga4aTyYjpHnA==:17
 a=IkcTkHD0fZMA:10 a=Uk8YgelpAKDIxx3_VVgA:9 a=QEXdDO2ut3YA:10
Message-ID: <1551811374.1607.3.camel@libero.it>
Subject: Re: Can't build first git commit
From:   Fabio Aiuto <polinice83@libero.it>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Tue, 05 Mar 2019 19:42:54 +0100
In-Reply-To: <20190304204007.GA32691@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
         <20190304204007.GA32691@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJ46M/aT+Td24No/oVzCYe9YkjXOzmv+zVirojn1n7zjDH5K47gAUSGfB5si8gFicnuVsJBlIywCz2FY6BxOp6hwh/2ND6Oeat510OWKbj48JSne+2Xx
 k4Iz/vi7CzdQj/hG0uJqU2TJ1DxnP09cCnkiopCrSn5HxiqYUd0fexOQjfeuAtUeX+2yv8RcisgIdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thank you Jeff I'll have news within few days!!!
Il giorno lun, 04/03/2019 alle 15.40 -0500, Jeff King ha scritto:
> On Mon, Mar 04, 2019 at 08:58:37PM +0100, Fabio Aiuto wrote:
> 
> > I'm trying to build first commit of git made by Linus. I mean the
> > one
> > named e83c5163316f89bfbde7d9ab23... (I think this is enough).
> > But at building stage i have the following error:
> > 
> > make all 
> > gcc -g -o update-cache update-cache.o read-cache.o -lssl
> > /usr/bin/ld: update-cache.o: undefined reference to symbol
> > 'SHA1_Update@@OPENSSL_1_1_0'
> 
> The sha1 routines are in libcrypto. See 3be4b61aa4 (Link with
> -lcrypto
> instead of -lssl when using openssl libraries., 2005-05-10). I also
> needed -lz. See 9426167765 (Add "-lz" to link line to get in zlib.,
> 2005-04-08).
> 
> You can patch the Makefile, or just override it like:
> 
>   make LIBS='-lcrypto -lz'
> 
> which builds for me on current Debian unstable. I don't think you can
> actually fetch with that old build, but I used periodically check
> that
> Git v1.0 can fetch happily from GitHub. I haven't in a while, so let
> me
> know if you try it and it doesn't work. ;)
> 
> -Peff
