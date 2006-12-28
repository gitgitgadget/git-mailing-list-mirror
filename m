From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Why git-merge-resolve in git-am?
Date: Thu, 28 Dec 2006 02:48:58 -0500
Message-ID: <20061228074857.GC17304@spearce.org>
References: <20061228014525.GC16612@spearce.org> <7vr6uk3h2p.fsf@assigned-by-dhcp.cox.net> <20061228022038.GE16612@spearce.org> <7virfw3gb2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:49:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzq0m-0002EE-K9
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWL1HtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWL1HtF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:49:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46148 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964957AbWL1HtE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:49:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzq09-0000B1-IO; Thu, 28 Dec 2006 02:48:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8C47420FB65; Thu, 28 Dec 2006 02:48:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virfw3gb2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35534>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Good reasons, but all are strictly historical.  So there's actually
> > no technical reason we can't use merge-recursive here in git-am.
> 
> A very early version of recursive was unusable (it did not pay
> attention to the merge base the caller gave it and tried to
> always compute it by itself), but that was fixed sometime later.
> 
> I do not recall offhand C version still has that fix (I think it
> does but you should double check); as long ias it honors the
> merge base the caller computed, it should be Ok to replace
> resolve with recursive.  Go wild.

I checked.  It does use the merge base supplied by the caller,
but only if the caller supplies only one merge base.  Otherwise it
computes its own.

This isn't a problem for git-am as we only supply one merge base.
What was a problem was git-am supplies trees, not commits, and the
code internally uses commits.  I fixed that in patch 9/11 'Allow
merging bare trees' in my recent series.

-- 
Shawn.
