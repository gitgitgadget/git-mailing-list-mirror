Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93391F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 11:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbdKMLTM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 06:19:12 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:42471 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752114AbdKMLTL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 06:19:11 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id vADBJ0pg023126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 Nov 2017 12:19:00 +0100
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id vADBJ0Rw023122;
        Mon, 13 Nov 2017 12:19:00 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Mon, 13 Nov 2017 12:19:00 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Kevin Willford <kewillf@microsoft.com>
cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: RE: cherry-pick very slow on big repository
In-Reply-To: <CY4PR21MB0855CA8ABB6BE4F176902F36B7540@CY4PR21MB0855.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.00.1711131217010.22867@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se> <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net> <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se> <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com> <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
 <CY4PR21MB0855CA8ABB6BE4F176902F36B7540@CY4PR21MB0855.namprd21.prod.outlook.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 13 Nov 2017 12:19:00 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford:

> Since this is happening during a merge, you might need to use merge.renameLimit
> or the merge strategy option of -Xno-renames.  Although the code does fallback
> to use the diff.renameLimit but there is still a lot that is done before even checking
> the rename limit so I would first try getting renames turned off.

That makes quite a large difference, with this setting it finishes in 
just a few seconds:

   $ time git -c merge.renameLimit=1 cherry-pick -x 717eb328940ca2e33f14ed27576e656327854b7b
   [redacted 0576fbaf89] Redacted
    Author: Redacted <redacted>
    Date: Mon Oct 16 15:58:05 2017 +0200
    1 file changed, 2 insertions(+), 2 deletions(-)

   real    0m15,473s
   user    0m14,904s
   sys     0m0,488s

I'll add this setting for the repository for the future, thank you!

-- 
\\// Peter - http://www.softwolves.pp.se/
