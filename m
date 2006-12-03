X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: EGIT unpackedreadr problem
Date: Sat, 2 Dec 2006 21:25:13 -0500
Message-ID: <20061203022513.GB26668@spearce.org>
References: <200612030200.13857.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 02:25:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612030200.13857.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33085>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqh2f-0001bo-M7 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 03:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424725AbWLCCZS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 21:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759615AbWLCCZS
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 21:25:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57240 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1759614AbWLCCZR
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 21:25:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gqh2O-0005lt-Px; Sat, 02 Dec 2006 21:25:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3C38620FB7F; Sat,  2 Dec 2006 21:25:14 -0500 (EST)
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Subject: [PATCH] Utility to show a log.

Thanks.  This is somewhat handy so I've applied the utility program.

Like your other patch to Commit class this one had some whitespace
issues.  In the future could you apply the Eclipse formatter (using
the Java Conventions style) to the source before genererating a diff?
 
> Not sure what's going on. The  UnpackedReader "looks" like it does
> the equivalent of what it did before,but apparently it isn't. 

Yea...  I broke the legacy header parsing in 42691339.
The breakage actually showed up in one of the unit tests
(test009_CreateCommitOldFormat) but I didn't notice it before
pushing the changes out as I failed to run the entire unit test
suite first.  Whoops.

I found it and fixed it in f70704f9.  The issue was we were copying
the remaining data from the Inflater ontop of the data we had
already decompressed out for the header; this meant that we lost the
leading bytes of each object.  I just neglated to push the fix out.
Double whoops.

-- 
