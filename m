From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git reflog show
Date: Tue, 26 Dec 2006 00:48:15 -0500
Message-ID: <20061226054815.GC28084@spearce.org>
References: <20061223101956.GD9396@spearce.org> <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de> <20061224061151.GE7443@spearce.org> <Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wmpq83g.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 06:48:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz5Aw-0005aI-Aw
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 06:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWLZFsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 00:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWLZFsW
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 00:48:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60719 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932371AbWLZFsV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 00:48:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gz5Af-0005ru-B4; Tue, 26 Dec 2006 00:48:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1222420FB65; Tue, 26 Dec 2006 00:48:16 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35412>

Junio C Hamano <junkio@cox.net> wrote:
> A sensible way to reuse existing code to implement Shawn's one
> is to add the revisions to rev.pending, and iterate over that
> array like "git show" does.  This does not need to touch the
> existing revision walking code at all.  The most valuable parts
> of the revision walking code are about ancestry traversal and
> history simplification with pathspec, neither of which makes
> much sense to use when "walking" reflog.  Reflog walking might
> want to use the filtering by commit_match() but then it is only
> the matter of renaming the function to a bit more specific name
> and exporting it.
> 
> You can largely reuse the display side of the code that way, and
> I think you should be able to hook into the code without making
> it too specific to the reflog (perhaps using object->util and/or
> a callback) if you need to give extra information (e.g. comments
> and commit information from the log).

So what you are proposing is to make the reflog visible in 'git log'
by a new option?  Or to just try to reuse all of its display code
but keep the reflog under 'git reflog show' ?
 
-- 
Shawn.
