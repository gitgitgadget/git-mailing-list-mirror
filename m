From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui Error
Date: Wed, 14 Feb 2007 01:00:41 -0500
Message-ID: <20070214060041.GA31871@spearce.org>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org> <20070213215303.GA26716@auto.tuwien.ac.at> <20070214022200.GB30884@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Feb 14 07:00:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHDCF-0007yx-BD
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 07:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbXBNGAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 01:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbXBNGAq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 01:00:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44239 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbXBNGAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 01:00:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHDC7-0001Sd-1N; Wed, 14 Feb 2007 01:00:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9DB6B20FBAE; Wed, 14 Feb 2007 01:00:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070214022200.GB30884@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39620>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > * It there any reason, why tags are not included in the list of possible
> > merge sources in Merge/Local Merge?
> > 
> > It only needs one additional line in do_local_merge:
> >          set cmd [list git for-each-ref]
> >          lappend cmd {--format=%(objectname) %(refname)}
> >          lappend cmd refs/heads
> >          lappend cmd refs/remotes
> > +        lappend cmd refs/tags
> >          set fr_fd [open "| $cmd" r]
> 
> I just didn't consider it.  The way I use git-gui for merges, I never
> merge tags.  But its obviously valid in plain Git.  I'll add it.

This is now pushed to repo.or.cz.  It probably won't show up in
git.git for at least a few weeks.  I want to push through some
more features (especially around the blame UI) in git-gui before
I bother Junio with another git-gui merge.  Besides, Git 1.5.0
(including git-gui 0.6.0.1) just shipped.  :)

It turned out to be slightly more difficult than just adding
refs/tags, as %(objectname) would be the name of the annotated tag,
and we need the commit name to match against rev-list output.  So I
had to extend the for-each-ref call to also include %(*objectname).

-- 
Shawn.
