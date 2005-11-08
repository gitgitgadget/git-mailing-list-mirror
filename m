From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Comments on recursive merge..
Date: Tue, 8 Nov 2005 23:36:09 +0100
Message-ID: <20051108223609.GA4805@c165.ib.student.liu.se>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org> <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de> <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 23:37:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZc4h-00065Q-Kq
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 23:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbVKHWgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 17:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbVKHWgR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 17:36:17 -0500
Received: from [85.8.31.11] ([85.8.31.11]:52111 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965242AbVKHWgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 17:36:16 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 2A8AC4103; Tue,  8 Nov 2005 23:44:33 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZc4X-0001Xv-00; Tue, 08 Nov 2005 23:36:09 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11363>

On Tue, Nov 08, 2005 at 01:52:06PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 8 Nov 2005, Fredrik Kuivinen wrote:
> >
> > * The code for finding common ancestors is also written in Python and
> >   is probably a bit slower than git-merge-base.
> 
> Btw, what part of git-merge-bases is it that makes it not be practical?
> 

The problem is in the multiple-common-ancestors case. If we have three
common ancestors, A, B and C, we will start with merging A with B. The
result is a new 'virtual' commit object (not stored in the object
database), lets call it V. We are then going to merge V with C. To do
that we need to get the common ancestor(s) of V and C, and as V
doesn't exist in the database we can't use git-merge-base.

I haven't given it a lot of thought though, it might be possible to
use git-merge-base in some way and get the same results as we get now.

It would certainly be possible to use git-merge-base in the first
iteration and use the python code only when we actually have any
'virtual' commit objects.

- Fredrik
