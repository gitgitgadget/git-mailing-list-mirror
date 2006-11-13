X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: should git download missing objects?
Date: Mon, 13 Nov 2006 14:54:14 -0500
Message-ID: <20061113195414.GD17244@spearce.org>
References: <ej7fgp$8ca$1@sea.gmane.org> <7vwt60bggs.fsf@assigned-by-dhcp.cox.net> <20061113194532.GA4547@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 19:55:23 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061113194532.GA4547@steel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31315>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjhtE-0001HW-5m for gcvg-git@gmane.org; Mon, 13 Nov
 2006 20:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933043AbWKMTy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 14:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933044AbWKMTyZ
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 14:54:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:31152 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S933043AbWKMTyY
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 14:54:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gjhsf-000680-Mr; Mon, 13 Nov 2006 14:54:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 EA31620FB0B; Mon, 13 Nov 2006 14:54:14 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen <fork0@t-online.de> wrote:
> Junio C Hamano, Sun, Nov 12, 2006 20:41:23 +0100:
> > Since this is not everyday anyway, a far easier way would be to
> > clone-pack from the upstream into a new repository, take the
> > pack you downloaded from that new repository and mv it into your
> > corrupt repository.  You can run fsck-objects to see if you got
> > back everything you lost earlier.
> 
> I get into such a situation annoyingly often, by using
> "git clone -l -s from to" and doing some "cleanup" in the
> origin repository. For example, it happens that I remove a tag,
> or a branch, and do a repack or prune afterwards. The related
> repositories, which had "accidentally" referenced the pruned
> objects become "corrupt", as you put it.
> 
> At the moment, if I run into the situation, I copy packs/objects from
> all repos I have (objects/info/alternates are useful here too), run a
> fsck-objects/repack and hope nothing is lost. It works, as I almost
> always have "accidental" backups somewhere, but is kind of annoying to
> setup. A tool to do this job more effectively will be very handy (at
> least, it wont have to copy gigabytes of data over switched windows
> network. Not often, I hope. Not _so_ many gigabytes, possibly).


One of my coworkers recently lost a single loose tree object.
We suspect his Windows virus scanner deleted the file.  :-(

Copying the one bad object from another repository immediately fixed
the breakage caused, but it was very annoying to not be able to run a
"git fetch --missing-objects" or some such.  Fortunately it was just
the one object and it was also still loose in another repository.
scp was handy.  :-)

-- 
