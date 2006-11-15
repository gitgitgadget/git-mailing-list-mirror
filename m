X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so large)?
Date: Wed, 15 Nov 2006 17:33:00 -0500
Message-ID: <20061115223300.GF24861@spearce.org>
References: <455B90AD.3060707@freescale.com> <20061115221616.GD24861@spearce.org> <455B9411.4090708@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 22:33:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <455B9411.4090708@freescale.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31518>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTJl-0007iw-2M for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162007AbWKOWdH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031016AbWKOWdG
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:33:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60335 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031013AbWKOWdE
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:33:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkTJN-0000oe-KN; Wed, 15 Nov 2006 17:32:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0035F20FB0B; Wed, 15 Nov 2006 17:33:00 -0500 (EST)
To: Timur Tabi <timur@freescale.com>
Sender: git-owner@vger.kernel.org

Timur Tabi <timur@freescale.com> wrote:
> Shawn Pearce wrote:
> 
> >Have you tried "git repack -a -d" to repack the loose objects into
> >a pack file?  Doing this every so often should reduce your disk
> >space consumed by a HUGE amount.
> 
> Woah!  It shrunk that bad boy down to 420M!  That should do it, thanks!
> 
> I wonder why the powerpc tree shrank so much.  Do you think the maintainer 
> just needs to run git-repack on his tree?

Possible, yes.

However published repositories don't tend to repack as often as
it makes things harder for people who clone/fetch over HTTP rather
than the native git protocol.

The reason is that HTTP can fetch individual loose objects that
you don't have yet, but if the object is only available in a pack
file then you need to fetch the entire pack file.  But you might
already have most of that pack file, so now you are downloading
lots of data you already have.  :-(

-- 
