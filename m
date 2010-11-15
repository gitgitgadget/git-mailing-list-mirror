From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Multiple clients accessing git over NFS
Date: Mon, 15 Nov 2010 11:24:32 -0500
Message-ID: <20101115162432.GA6258@fieldses.org>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
 <rmi39r3mrf6.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Khawaja Shams <kshams@usc.edu>, git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 17:24:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI1rG-0003D0-Jb
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 17:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757915Ab0KOQYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 11:24:37 -0500
Received: from fieldses.org ([174.143.236.118]:36632 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757908Ab0KOQYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 11:24:37 -0500
Received: from bfields by fieldses.org with local (Exim 4.72)
	(envelope-from <bfields@fieldses.org>)
	id 1PI1r6-0002X6-Lv; Mon, 15 Nov 2010 11:24:32 -0500
Content-Disposition: inline
In-Reply-To: <rmi39r3mrf6.fsf@fnord.ir.bbn.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161495>

On Sun, Nov 14, 2010 at 06:11:41PM -0500, Greg Troxel wrote:
> 
> Khawaja Shams <kshams@usc.edu> writes:
> 
> > Is it a recommended practice to share a repository over NFS, where
> > multiple clients can be pushing changes simultaneously?  In our
> > production environment, we have a Git repository setup behind
> > git-http-backend. We would like to place multiple Apache servers
> > behind a load balancer to maximize availability and performance.
> > Before we proceed, we wanted to check to see if this practice has a
> > potential to cause repository corruption. If there are other ways
> > others have solved this problem, we would be very interested in
> > learning about those as well. Thank you.
> 
> NFS locking has historically been problematic, and my impression is that
> most people avoid it.  Perhaps it's ok on Solaris, but without serious
> testing, I'd be worried.

Does git actually do file locking when people push to a bare repo?

If all it needs is for rename and/or O_EXCL to be atomic--that should be
fine over NFS.

--b.

> 
> Can you explain what you have set up, and what your performance
> situation is, and why you think adding a second or third apache over NFS
> will help?  How many users?  How many pushes/day?
> 
> One option is to have a multi-core box with tons of RAM running apache;
> I've done that for trac (8 core, 16G, RAID5) because trac/python is so
> piggy, and buying a $3K box was cheaper than making trac go faster.
> That doesn't get you into remote FS locking issues.
