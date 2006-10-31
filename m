X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Allow pack header preprocessing before unpack-objects/index-pack.
Date: Tue, 31 Oct 2006 15:08:41 -0500
Message-ID: <20061031200841.GC23671@spearce.org>
References: <20061031075629.GA7691@spearce.org> <Pine.LNX.4.64.0610311400180.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 20:09:27 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610311400180.11384@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30595>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gezum-0006nJ-6o for gcvg-git@gmane.org; Tue, 31 Oct
 2006 21:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945938AbWJaUIs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 15:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945966AbWJaUIs
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 15:08:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:64989 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1945938AbWJaUIs
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 15:08:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GezuW-0001Gb-2U; Tue, 31 Oct 2006 15:08:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1113D20FB0C; Tue, 31 Oct 2006 15:08:42 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 31 Oct 2006, Shawn Pearce wrote:
> 
> > However if the caller consumes the pack header from the input stream
> > then its no longer available for unpack-objects or index-pack --stdin,
> > both of which need the version and object count to process the stream.
> > 
> > This change introduces --pack_header=ver,cnt as a command line option
> > that the caller can supply to indicate it has already consumed the
> > pack header and what version and object count were found in that
> > header.  As this option is only meant for low level applications
> > such as receive-pack we are not documenting it at this time.
> 
> This breaks index-pack, and unpack-objects with OBJ_OFS_DELTA, if 
> --pack-header is used.  The header is not accounted in the pack's offset 
> and therefore every object's offset is wrong.
> 
> What about this patch instead?  This makes things much simpler IMHO.

Agreed.  The idea you are using here came to me in my sleep last
night; I didn't have time to look at it until now however.  You just
beat me to posting it.  :-)

-- 
