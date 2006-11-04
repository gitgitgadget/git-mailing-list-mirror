X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git bug? + question
Date: Sat, 4 Nov 2006 00:10:08 -0500
Message-ID: <20061104051008.GC9003@spearce.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca> <20061103081232.GB15972@diana.vm.bytemark.co.uk> <20061103042540.192bbd18.seanlkml@sympatico.ca> <20061103202945.GA7585@spearce.org> <20061103232936.GC6970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 05:10:25 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061103232936.GC6970@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30905>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgDnQ-0003vP-J8 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 06:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753594AbWKDFKR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 00:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbWKDFKR
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 00:10:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42462 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1753364AbWKDFKP
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 00:10:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgDnF-0006AA-N5; Sat, 04 Nov 2006 00:10:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 115CB20E491; Sat,  4 Nov 2006 00:10:08 -0500 (EST)
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Nov 03, 2006 at 03:29:45PM -0500, Shawn Pearce wrote:
> 
> > Nack.  I'd rather see the entries added/removed from .git/config when
> > the branch is created/deleted, just like the ref and the reflog are
> > created/deleted.  It makes behavior more consistent for the user
> > and it is mostly self documenting...
> 
> If we go this route, please consider updating .git/auto-branch-config or
> similar, and adding the functionality to include that file into
> .git/config.
> 
> I think the concept of automagically munging a user-editable config file
> is problematic, especially when users might manage those files with
> version control or other systems.

Most users that I know use repo-config to munge their .git/config
rather than editing it by hand.  Though with more data stored in
it for branches and remotes that is probably going to change.

If we go this route I wonder if want to say create a config file
per branch and then use a wildcard include like Apache's httpd.conf
wildcard include, e.g.:

	.git/config:
		include branch_configs/**/*.config

	.git/branch_configs/refs/heads/master.config:
		[branch "master"]
			...

As then git-branch is only manipulating one file per branch.

-- 
