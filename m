X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 21:43:17 -0500
Message-ID: <20061220024317.GA27918@spearce.org>
References: <7vpsafmh89.fsf@assigned-by-dhcp.cox.net> <655753.13323.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 02:43:41 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <655753.13323.qm@web31812.mail.mud.yahoo.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34902>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwrQX-0002Lt-8I for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964819AbWLTCn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWLTCn0
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:43:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54627 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964819AbWLTCn0 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 21:43:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwrQC-00059P-M8; Tue, 19 Dec 2006 21:43:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 061EC20FB65; Tue, 19 Dec 2006 21:43:17 -0500 (EST)
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> wrote:
> > Junio C Hamano <junkio@cox.net> writes:
> > 1510fe is buggy and it is my fault.
> > 
> > For now, this _should_ get you keep going.
> > 
> > However, if this fixes it for you, that means we would still
> > have the problem on Cygwin X-<.
> 
> Yep -- that fixed it.

It might be a problem on Cygwin.  :-)

I completely fail to see how this patch would cause a segfault
downstream in xdl_merge.  All this controls is do we mmap data from
the working directory or decompress it from the ODB.  Either way we
should have loaded the file size or content into the diff_filespec.

My other related change (7da41f48c) in this area has a better chance
of causing a problem as it may be bypassing loading the file content
into the diff_filespec where before we were always loading it.
However none of my testing ever showed that would cause a problem.

-- 
