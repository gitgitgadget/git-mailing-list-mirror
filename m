From: Pavel Roskin <proski@gnu.org>
Subject: Re: branch.pu.forcefetch
Date: Thu, 28 Dec 2006 22:34:23 -0500
Message-ID: <1167363263.15189.79.camel@dv>
References: <1167251519.2247.10.camel@dv>
	 <7vfyb159dn.fsf@assigned-by-dhcp.cox.net> <1167341346.12660.17.camel@dv>
	 <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net> <1167355326.15189.34.camel@dv>
	 <7v8xgrsabr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 04:34:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H08Vz-0004vE-E1
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 04:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbWL2De1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 22:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbWL2De1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 22:34:27 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:40040 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbWL2De1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 22:34:27 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1H08VZ-0000i9-1v
	for git@vger.kernel.org; Thu, 28 Dec 2006 22:34:13 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1H08Vj-00088t-Tq; Thu, 28 Dec 2006 22:34:23 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xgrsabr.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35577>

On Thu, 2006-12-28 at 18:30 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> >> Are you talking about "remote.origin.fetch = +pu:refs/heads/pu"?
> >
> > Yes, I'm talking about that line.  And I don't like that I have to use a
> > magic token "refs/heads/pu" that doesn't correspond to a real file to
> > make it possible to keep git up-to-date.
> 
> I think we misunderstood each other.

I just didn't notice that your question used a different line.  I was
talking about

	fetch = +refs/heads/pu:refs/remotes/origin/pu

> That line is inconsistent
> with what your config has, which is the separate-remote layout,
> which I did not know you were using.  In separate-remote layout,
> you don't have refs/heads/pu so if we do not do the patches you
> are agreeing to, you would want to have something like:
> 
> 	[remote "origin"]
>                 fetch = +refs/heads/pu:refs/remotes/origin/pu
>         	fetch = refs/heads/*:refs/remotes/origin/*

I get it now.  "refs/heads/pu" must be the path on the remote side.

The whole thing remains pretty hairy for my taste, but it looks like we
are going to untangle it step-by-step.

> Turning it off by default was not a wise thing to do in general
> for a long time, because rewound/rebased tip loses information,
> and we did not have reflog enabled by default.  Your message
> raised this issue to attention of the list, and I suggested two
> patches out of it, both of which I think are sane things to do.
> If the list agrees, we can turn it off by default now.

Just a random idea - if fast-forward fails, save the original head
somewhere under refs as a backup.  It's like "patch" saving *.orig files
if there is any doubt that the patch was applied cleanly.

But I'm fine with reflog too.

-- 
Regards,
Pavel Roskin
