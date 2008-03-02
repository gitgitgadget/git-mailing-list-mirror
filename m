From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sun, 2 Mar 2008 09:04:46 -0500
Message-ID: <20080302140446.GA8410@spearce.org>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com> <200803011641.49874.jnareb@gmail.com> <8384AA89-4ECF-4BB8-8A3B-6A656F2D2903@orakel.ntnu.no> <200803011900.36723.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	eric miao <eric.y.miao@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 15:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVop5-0000hl-Cz
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 15:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYCBOEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 09:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbYCBOEv
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 09:04:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41875 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYCBOEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 09:04:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVonz-0004HH-Cd; Sun, 02 Mar 2008 09:04:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BAC6D20FBAE; Sun,  2 Mar 2008 09:04:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200803011900.36723.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75779>

Jakub Narebski <jnareb@gmail.com> wrote:
> Eyvind Bernhardsen wrote:
> >
> > Okay, as a git n00b I'm probably on completely the wrong track, but if  
> > you made a git repository out of a kernel tarball (cd linux-2.6.24 &&  
> > git init && git add .) and then did a shallow fetch from kernel.org  
> > into that repository, wouldn't the blobs you added get reused  
> > (assuming the tarball you downloaded was fairly recent), thus reducing  
> > the amount of data fetch has to transfer?
> 
> I think it wouldn't. If I understand it correctly, the fetching engine
> deals only with commits. If you have commit, it assumes that you have 
> tree, blobs, and ancestors. If you don't have commit, it assumes that 
> you don't have tree and blobs.

Correct.

I was thinking about this just yesterday.  I think that if we
embedded inside of a tarball created by git-archive the raw sources
of all files, plus the commit SHA-1 and the raw body of that commit,
it should be possible to convert that into a shallow clone.

Unfortunately I think it is possible for git-archive to edit a file
in-place during export, e.g. to edit an RPM spec file and insert
the revision.  That would damage the tree, as the blobs would no
longer hash to the same value as they should be in that commit.

-- 
Shawn.
