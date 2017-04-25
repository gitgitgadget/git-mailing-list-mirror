Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B40207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 07:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980798AbdDYHzy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 25 Apr 2017 03:55:54 -0400
Received: from bouvier.getmail.no ([84.210.184.8]:52139 "EHLO
        bouvier.getmail.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943248AbdDYHzw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 03:55:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bouvier.getmail.no (Postfix) with ESMTP id 7B2F24414F;
        Tue, 25 Apr 2017 09:55:50 +0200 (CEST)
Received: from bouvier.getmail.no ([127.0.0.1])
        by localhost (bouvier.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9sWxUcq4unmK; Tue, 25 Apr 2017 09:55:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by bouvier.getmail.no (Postfix) with ESMTP id 10AD644160;
        Tue, 25 Apr 2017 09:55:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at bouvier.get.c.bitbit.net
Received: from bouvier.getmail.no ([127.0.0.1])
        by localhost (bouvier.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D4YCLGoik4rx; Tue, 25 Apr 2017 09:55:49 +0200 (CEST)
Received: from perkele.intern.softwolves.pp.se (cm-84.209.33.229.getinternet.no [84.209.33.229])
        by bouvier.getmail.no (Postfix) with ESMTPSA id E1A7B4414F;
        Tue, 25 Apr 2017 09:55:49 +0200 (CEST)
Received: from peter (helo=localhost)
        by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.84_2)
        (envelope-from <peter@softwolves.pp.se>)
        id 1d2vKA-0006Ci-4q; Tue, 25 Apr 2017 09:55:50 +0200
Date:   Tue, 25 Apr 2017 08:55:50 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
In-Reply-To: <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
Message-ID: <alpine.DEB.2.11.1704250851420.23677@perkele.intern.softwolves.pp.se>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org> <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se> <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org> <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org> <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se> <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de> <85f2b6d1-107b-0624-af82-92446f28269e@web.de> <02ddca3c-a11f-7c0c-947e-5ca87a62cdee@web.de>
 <alpine.DEB.2.11.1704241912510.30460@perkele.intern.softwolves.pp.se> <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe:

>> This needs to be >=. The spec says that if the value is 0xffffffff, there 
>> should be a zip64 record with the actual size (even if it is 0xffffffff).
> Could you please cite the relevant part?

4.4.8 compressed size: (4 bytes)
4.4.9 uncompressed size: (4 bytes)

"If an archive is in ZIP64 format and the value in this field is 
0xFFFFFFFF, the size will be in the corresponding 8 byte ZIP64 
extended information extra field."


Of course, there is no definition of how they define that "an archive 
is in ZIP64 format", but I would say that is whenever it has any ZIP64 
structures.

-- 
\\// Peter - http://www.softwolves.pp.se/
