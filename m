From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Restraining git pull/fetch to the current branch
Date: Thu, 11 Jan 2007 19:59:21 -0500
Message-ID: <20070112005921.GE23864@spearce.org>
References: <Pine.LNX.4.64.0701112127000.12870@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 01:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5AlX-00039h-Ab
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbXALA73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbXALA72
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:59:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42776 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbXALA72 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:59:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5AlN-0008Cs-0L; Thu, 11 Jan 2007 19:59:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 83B9820FBAE; Thu, 11 Jan 2007 19:59:21 -0500 (EST)
To: Julian Phillips <julian@quantumfyre.co.uk>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701112127000.12870@beast.quantumfyre.co.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36648>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> While trying out git on a large repository (10000s of commits, 1000s of 
> branches, ~2.5Gb when packed) at work I noticed that doing a pull was 
> taking a long time (longer than I was prepared to wait anyway).
> 
> A quick test showed that a small repository (1 commit, 24k .git/objects) 
> with 1000 branches took 1m30 to do "git pull" (local xfs partition).  I 
> don't know if this is reasonable or not, but all I actually cared 
> about was updating the current branch, which "git pull origin 
> <branch_name>" did in 0.3s.
> 
> So what I would like to know is: is there any way to make a pull/fetch 
> with no options default to only fetching the current branch? (other than 
> scripting "git pull/fetch origin $(git symbolic-ref HEAD)" that is)

No, but fortunately bash has a fancy alias tool:

	alias gp='git pull origin $(git symbolic-ref HEAD)'

perhaps your shell can help.  :-)


Life is going to be painful with that repository with current Git
(1.5.0 and later) as the new default configuration for a clone is to
copy every branch into refs/remotes/origin/*, where * is wildcarded
against the current set of branches on the remote repository.
If that takes "a long time" you will be processing a lot of refs
you don't care about (or need to care about).

-- 
Shawn.
