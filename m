From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 12:23:54 -0700
Organization: Hewlett Packard
Message-ID: <20060224192354.GC387@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain> <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain> <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 20:24:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCiXw-0008RS-NK
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 20:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWBXTYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 14:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWBXTYA
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 14:24:00 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:8129 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932433AbWBXTX7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 14:23:59 -0500
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel8.hp.com (Postfix) with ESMTP id F2C0D341B8;
	Fri, 24 Feb 2006 14:23:54 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 942246E9D;
	Fri, 24 Feb 2006 19:23:54 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 87829BFA3; Fri, 24 Feb 2006 12:23:54 -0700 (MST)
To: Nicolas Pitre <nico@cam.org>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16729>

On Fri, Feb 24, 2006 at 01:57:20PM -0500, Nicolas Pitre wrote:
> On Fri, 24 Feb 2006, Carl Baldwin wrote:
> 
> > My version is 1.2.1.  I have not been following your work.  When was
> > pack data reuse introduced?
> 
> Try out version 1.2.3.

I'm on it now.

> > From where can I obtain your delta patches?
> 
> Forget them for now -- they won't help you.

Ah, I have been looking at your patches and clearly they will not help.

> > There is really no opportunity for pack-data reuse in this case.  The
> > repository had never been packed or cloned in the first place.  As I
> > said, I do not intend to pack these binary files at all since there is
> > no benefit in this case.
> 
> Yes there is, as long as you have version 1.2.3.  The clone logic will 
> simply reuse already packed data without attempting to recompute it.

I meant that there is no benefit in disk space usage.  Packing may
actually increase my disk space usage in this case.  Refer to what I
said about experimentally running gzip and xdelta on the files
independantly of git.

I see what you're saying about this data reuse helping to speed up
subsequent cloning operations.  However, if packing takes this long and
doesn't give me any disk space savings then I don't want to pay the very
heavy price of packing these files even the first time nor do I want to
pay the price incrementally.

The most I would tolerate for the first pack is a few seconds.  The most
I would tolerate for any incremental pack is about 1 second.

BTW, git repack has been going for 30 minutes and has packed 4/36
objects.  :-)

> I think you really should try git version 1.2.3 with a packed 
> repository.  It might handle your special case just fine.

No, not when I'm not willing to pay the price to pack even once.  This
isn't a case where I have one such repository and 'once its been packed
then its packed'.  This is only one example of such a repository.  I am
looking for a process for revisioning this type of data that will be
used over and over.  Git may not be the answer here but it sure is
looking good in many other ways.

I think the right answer would be for git to avoid trying to pack files
like this.  Junio mentioned something like this in his message.

Thanks for your input.

Cheers,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
