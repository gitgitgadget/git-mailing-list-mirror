Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D611F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbdKJOFI (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 09:05:08 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:52212 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751661AbdKJOFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 09:05:08 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id vAAE53fL017447
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 Nov 2017 15:05:03 +0100
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id vAAE53qm017444;
        Fri, 10 Nov 2017 15:05:03 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Fri, 10 Nov 2017 15:05:03 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Derrick Stolee <stolee@gmail.com>
cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: cherry-pick very slow on big repository
In-Reply-To: <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com>
Message-ID: <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se> <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net> <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se> <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 10 Nov 2017 15:05:03 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee:

> Git is spending time detecting renames, which implies you probably 
> renamed a folder or added and deleted a large number of files. This 
> rename detection is quadratic (# adds times # deletes).

Yes, a couple of directories with a lot of template files have been 
renamed (and some removed, some added) between the current development 
branch and this old maintenance branch. I get the "Performing inexact 
rename detection" a lot when merging changes in the other direction.

However, none of them applies to these particular commits, which only 
touches files that are in the exact same location on both branches.

> You can remove this rename detection by running your cherry-pick 
> with `git -c diff.renameLimit=1 cherry-pick ...`

That didn't work, actually it failed to finish with this setting in 
effect, it hangs in such a way that I can't stop it with Ctrl+C 
(neither when running from the command line, nor when running inside 
gdb). It didn't finish in the 20 minutes I gave it.

I also tried with diff.renames=false, which also seemed to fail.

-- 
\\// Peter - http://www.softwolves.pp.se/
