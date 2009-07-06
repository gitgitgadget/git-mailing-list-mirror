From: Mattias Nissler <mattias.nissler@gmx.de>
Subject: Re: [PATCH/RFC] git-svn: Fix branch detection when repository root
 is inaccessible
Date: Tue, 07 Jul 2009 00:28:13 +0200
Message-ID: <1246919293.4618.12.camel@kea>
References: <1246794706.4818.33.camel@kea>
	 <20090706212742.GA8219@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 00:28:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNwfg-00085V-Qe
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 00:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZGFW2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 18:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZGFW2N
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 18:28:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:52725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752452AbZGFW2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 18:28:12 -0400
Received: (qmail invoked by alias); 06 Jul 2009 22:28:15 -0000
Received: from e182067244.adsl.alicedsl.de (EHLO [192.168.1.50]) [85.182.67.244]
  by mail.gmx.net (mp009) with SMTP; 07 Jul 2009 00:28:15 +0200
X-Authenticated: #429267
X-Provags-ID: V01U2FsdGVkX19N+b46qgdNFavt8oA5E7ytvA/2HgkY/TU+q2z1q/
	zC5iBR9ITscbdP
In-Reply-To: <20090706212742.GA8219@dcvr.yhbt.net>
X-Mailer: Evolution 2.26.2 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122806>

Hi Eric,

On Mon, 2009-07-06 at 14:27 -0700, Eric Wong wrote:
> Fixing the minimize logic is definitely a wanted improvement I haven't
> been able to fix myself.  Unfortunately, your patch breaks the
> t9138-git-svn-multiple-branches.sh test for me.  

I see the same here, not sure why I've missed it before. I've had a look
at the problem and found that the test is actually depending on the
minimizing logic, i.e. needs to specify -d project1/<tag-or-branch-dir>
for the tag or branch destination where the project1 prefix is due to
the minimization at clone time. Dropping the project1 part makes the
test succeed. I'll simply update the test to do so.

I also think this is much better from a usability point of view since
you can now use the original branch or tag dir you've given to clone in
order to specify the branch or tag destination.

> I haven't looked at it
> at all, but I'll try to take a look at it later today after I process other
> things in my overflowing work queue; but I definitely want access issues
> fixed for people with restrictive repo setups.
> 
> One thing I would do is to split out the making of dup_changed_paths()
> the default behavior into a separate patch.  I think this is a good
> change since it makes things less surprising for future hackers of
> git svn.

Ok, will do so. I'll send updated patches in reply to this mail.

Finally, a big thanks for the nice job on git-svn. I've just experienced
lots of trouble with the mercurial SVN integration and it's really a
pain in the ass even to just get a simple clean rebase done properly.
git-svn is really way more mature and it's a pleasure to use it for
everyday work.

Mattias
