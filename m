From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 11:49:34 -0700
Organization: Hewlett Packard
Message-ID: <20060224184934.GA387@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain> <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 19:49:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCi0e-0007dM-NQ
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 19:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWBXSti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 13:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWBXSti
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 13:49:38 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:26323 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932423AbWBXSth (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 13:49:37 -0500
Received: from smtp2.fc.hp.com (smtp2.fc.hp.com [15.11.136.114])
	by atlrel7.hp.com (Postfix) with ESMTP id CE5CB342D4;
	Fri, 24 Feb 2006 13:49:34 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id A12FBD0C;
	Fri, 24 Feb 2006 18:49:34 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 91331BFA3; Fri, 24 Feb 2006 11:49:34 -0700 (MST)
To: Nicolas Pitre <nico@cam.org>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16725>

I've updated to a very current master branch.  This seems to include the
pack data reuse stuff.  I've not made an attempt yet to apply your delta
patches.

git-repack quickly gets up to 5% (2/36) and hangs there.  I'll let it
run for a while just to see how far it claims to get.  I'm not hopeful.

Maybe your patches can help?

Carl

On Fri, Feb 24, 2006 at 12:56:04PM -0500, Nicolas Pitre wrote:
> On Fri, 24 Feb 2006, Carl Baldwin wrote:
> 
> > Junio,
> > 
> > This message came to me at exactly the right time.  Yesterday I was
> > exploring using git as the content storage back-end for some binary
> > files.  Up until now I've only used it for software projects.
> > 
> > I found the largest RCS file that we had in our current back-end.  It
> > contained twelve versions of a binary file.  Each version averaged about
> > 20 MB.  The ,v file from RCS was about 250MB.  I did some experiments on
> > these binary files.
> > 
> > First, gzip consistantly is able to compress these files to about 10%
> > their original size.  So, they are quite inflated.  Second, xdelta would
> > produce a delta between two neighboring revisions of about 2.5MB in size
> > that would compress down to about 2MB.  (about the same size as the next
> > revision compressed without deltification so packing is ineffective
> > here).
> > 
> > I added these 12 revisions to several version control back-ends
> > including subversion and git.  Git produced a much smaller repository
> > size than the others simply due to the compression that it applies to
> > objects.  It also was at least as fast as the others.
> > 
> > The problem came when I tried to clone this repository.
> > git-pack-objects chewed on these 12 revisions for over an hour before I
> > finally interrupted it.  As far as I could tell, it hadn't made much
> > progress.
> 
> I must ask if you had applied my latest delta patches?
> 
> Also did you use a recent version of git that implements pack data 
> reuse?
> 
> 
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
