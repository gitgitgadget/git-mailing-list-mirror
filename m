From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui Error
Date: Tue, 13 Feb 2007 02:45:19 -0500
Message-ID: <20070213074519.GA32687@spearce.org>
References: <20070213065616.GA4195@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Feb 13 08:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGsLw-0006qO-Lv
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 08:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbXBMHpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 02:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbXBMHpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 02:45:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57795 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbXBMHpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 02:45:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGsLp-0007T5-4f; Tue, 13 Feb 2007 02:45:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BF83620FBAE; Tue, 13 Feb 2007 02:45:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070213065616.GA4195@auto.tuwien.ac.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39503>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> Starting git-gui without any parameters display an error message instead
> of a usage message:

Starting it with no parameters (`git-gui` or `git gui`) should
work just fine.  I do this all of the time on Mac OS X and Windows,
as it opens a commit window and keeps it running.
 
> Error in startup script: child process exited abnormally
>     while executing
> "close $fd"
>     (procedure "load_all_heads" line 11)
>     invoked from within
> "load_all_heads"
>     invoked from within
> "if {[is_enabled transport]} {
>         load_all_remotes
>         load_all_heads
> 
>         populate_branch_menu
>         populate_fetch_menu
>         populate_push_menu
> }"

According to this backtrace, we were trying to startup the UI
and load the branches, but:

  git for-each-ref --format=%(refname) refs/heads

returned a non-zero exit code or something else with it went wrong.
Is this maybe a brand new repository?  This is most certainly a bug
in git-gui, but I'd like to understand more about the environment
so I can track it down.

-- 
Shawn.
