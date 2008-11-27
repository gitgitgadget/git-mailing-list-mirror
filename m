From: Nicolas Pitre <nico@cam.org>
Subject: Re: git fsck segmentation fault
Date: Thu, 27 Nov 2008 14:57:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811271449500.14328@xanadu.home>
References: <200811271814.06941.simon@lst.de>
 <alpine.LFD.2.00.0811271243250.14328@xanadu.home>
 <200811272010.20891.simon@lst.de> <200811272021.56108.simon@lst.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 21:01:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5n33-0006U8-DC
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 21:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYK0T5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 14:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYK0T5w
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 14:57:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41142 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYK0T5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 14:57:52 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KB0009A0CS9QK80@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 27 Nov 2008 14:57:46 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200811272021.56108.simon@lst.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101823>

On Thu, 27 Nov 2008, Simon Hausmann wrote:

> On Thursday 27 November 2008 20:10:20 Simon Hausmann wrote:
> > On Thursday 27 November 2008 18:47:41 Nicolas Pitre wrote:
> > > On Thu, 27 Nov 2008, Simon Hausmann wrote:
> > > > Hi,
> > > >
> > > > when running git fsck --full -v (version 1.6.0.4.26.g7c30c) on a medium
> > > > sized
> > >
> > > That version doesn't exist in the git repo.
> >
> > Ah, oops, it was a merge commit, corresponding to maint as of 5aa3bd.
> >
> > > > (930M) repository I get a segfault.
> > > >
> > > > The backtrace indicates an infinite recursion. Here's the output from
> > > > the last few lines:
> > >
> > > [...]
> > >
> > > Could you try with latest master branch please?  It is more robust
> > > against some kind of pack corruptions that could send the code into
> > > infinite loops.
> >
> > Same problem with git version 1.6.0.4.790.gaa14a
> 
> Forgot to paste the changed line numbers of the recursion:
[...]

Well... Your initial backtrace showed recursion in unpack_entry() which 
was rather odd in the first place.  Your latest backtrace shows a loop 
in make_object() which has nothing to do what so ever with 
unpack_entry().  So the backtrace might not be really useful.

I suspect you'll have to bisect git to find the issue, given that some 
old version can be found to be good.  For example, does it work with 
v1.5.2.5?


Nicolas
