From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui Error
Date: Tue, 13 Feb 2007 21:22:00 -0500
Message-ID: <20070214022200.GB30884@spearce.org>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org> <20070213215303.GA26716@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Feb 14 03:22:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH9ml-0001zH-BH
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 03:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbXBNCWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 21:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbXBNCWI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 21:22:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38819 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbXBNCWH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 21:22:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HH9mM-0004Nz-GB; Tue, 13 Feb 2007 21:21:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2680120FBAE; Tue, 13 Feb 2007 21:22:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070213215303.GA26716@auto.tuwien.ac.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39611>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> My fault, I had only a too old GIT core (1.4.1) in my path.
> With the current version, the problem disapears.

Yea, I figured (much later) it was something like that.  I still
think there is a bug in git-gui, namely not telling you that it
requires Git 1.5.x or later if it finds out the 'git' its invoking
is older than that.  I'll probably patch it tonight, but it won't
ship that way in 1.5.0.
 
> Some notes about using git-gui: 
> 
> * Fetching over ssh results in an empty dialog. The password prompt is
> only shown in the terminal window, which is likly to be hidden by the
> the main window of git-gui.

This is a "feature".  I only use git-gui + ssh with an ssh-agent
and public key authentication, so I never get password prompts.
Unfortunately Tcl does not permit me to setup bi-directional pipes
to a process (heck, I can't get both stdout and stderr except by
going through cat!), and even if it does, I think ssh would demand
the tty to get the password, thereby bypassing my pipe anyway.

Basically I don't know how to improve this.  If someone has a bright
idea, please pass it along!
 
> * It there any reason, why tags are not included in the list of possible
> merge sources in Merge/Local Merge?
> 
> It only needs one additional line in do_local_merge:
>          set cmd [list git for-each-ref]
>          lappend cmd {--format=%(objectname) %(refname)}
>          lappend cmd refs/heads
>          lappend cmd refs/remotes
> +        lappend cmd refs/tags
>          set fr_fd [open "| $cmd" r]

I just didn't consider it.  The way I use git-gui for merges, I never
merge tags.  But its obviously valid in plain Git.  I'll add it.

-- 
Shawn.
