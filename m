From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 12:56:04 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 18:57:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FChBN-0001Ev-DI
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 18:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWBXR4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 12:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWBXR4H
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 12:56:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15506 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932402AbWBXR4G
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 12:56:06 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV70081QDTG0270@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 12:56:05 -0500 (EST)
In-reply-to: <20060224174422.GA13367@hpsvcnb.fc.hp.com>
X-X-Sender: nico@localhost.localdomain
To: Carl Baldwin <cnb@fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16720>

On Fri, 24 Feb 2006, Carl Baldwin wrote:

> Junio,
> 
> This message came to me at exactly the right time.  Yesterday I was
> exploring using git as the content storage back-end for some binary
> files.  Up until now I've only used it for software projects.
> 
> I found the largest RCS file that we had in our current back-end.  It
> contained twelve versions of a binary file.  Each version averaged about
> 20 MB.  The ,v file from RCS was about 250MB.  I did some experiments on
> these binary files.
> 
> First, gzip consistantly is able to compress these files to about 10%
> their original size.  So, they are quite inflated.  Second, xdelta would
> produce a delta between two neighboring revisions of about 2.5MB in size
> that would compress down to about 2MB.  (about the same size as the next
> revision compressed without deltification so packing is ineffective
> here).
> 
> I added these 12 revisions to several version control back-ends
> including subversion and git.  Git produced a much smaller repository
> size than the others simply due to the compression that it applies to
> objects.  It also was at least as fast as the others.
> 
> The problem came when I tried to clone this repository.
> git-pack-objects chewed on these 12 revisions for over an hour before I
> finally interrupted it.  As far as I could tell, it hadn't made much
> progress.

I must ask if you had applied my latest delta patches?

Also did you use a recent version of git that implements pack data 
reuse?


Nicolas
