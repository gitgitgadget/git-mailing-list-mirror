X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 23:38:29 -0400
Message-ID: <20061029033829.GA3435@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net> <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org> <4543DA2E.9030300@tromer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 03:39:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4543DA2E.9030300@tromer.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30408>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge1Vi-0005qG-30 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 04:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964965AbWJ2Dig (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 23:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWJ2Dig
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 23:38:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:31953 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S964965AbWJ2Dig
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 23:38:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge1V5-0005Yf-9n; Sat, 28 Oct 2006 23:38:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0AA1120E45B; Sat, 28 Oct 2006 23:38:29 -0400 (EDT)
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org

Eran Tromer <git2eran@tromer.org> wrote:
> Hi Shawn,
> 
> On 2006-10-28 09:21, Shawn Pearce wrote:
> > Lets say that a pack X is NOT eligible to be repacked if
> > "$GIT_DIR/objects/pack/pack-X.keep" exists.
> > 
> > Thus we want to have the new ".keep" file for historical packs and
> > incoming receive-pack between steps c and g.  In the former case
> > the historical pack is already "very large" and thus one additional
> > empty file to indicate we want to retain that pack as-is is trivial
> > overhead (relatively speaking); in the latter case the lifespan of
> > the file is relatively short and thus any overhead associated with it
> > on the local filesystem is free (it may never even hit the platter).
> 
> Sounds perfect.
> 
> It would be nice to have whoever creates a pack-*.keep file put
> something useful as the content of the file, so we'll know what to clean
> up after abnormal termination:
> 
> $ grep -l ^git-receive-pack $GIT_DIR/objects/pack/pack-*.keep

Yes, that's a very good idea.  When I do the git-receive-pack
implementation tonight I'll try to dump useful information to the
.keep file such that you can easily grep for the stale .keeps
and decide which ones should go.

-- 
