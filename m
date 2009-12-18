From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Thu, 17 Dec 2009 22:52:24 -0500
Message-ID: <1261108344.2868.60.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
	 <1260851180.9379.88.camel@localhost>
	 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
	 <1260970885.2788.87.camel@localhost>
	 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
	 <1261003041.2788.142.camel@localhost>
	 <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
	 <1261067369.2868.10.camel@localhost>
	 <alpine.LFD.2.00.0912172149020.23173@xanadu.home>
	 <f488382f0912171944m6c7d7fdas8fe2b12755358b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLTtZ-0005AV-DE
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 04:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbZLRDwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 22:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbZLRDwd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 22:52:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756085AbZLRDwc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 22:52:32 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBI3qQQO011119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 17 Dec 2009 22:52:26 -0500
Received: from [10.11.10.49] (vpn-10-49.rdu.redhat.com [10.11.10.49])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBI3qP8R026674;
	Thu, 17 Dec 2009 22:52:25 -0500
In-Reply-To: <f488382f0912171944m6c7d7fdas8fe2b12755358b@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135398>

On Thu, 2009-12-17 at 19:44 -0800, Steven Noonan wrote:
> On Thu, Dec 17, 2009 at 7:33 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Thu, 17 Dec 2009, Eric Paris wrote:
> >
> >> This alone almost certainly tells me how I broke it.
> >>
> >> For quite some time (a period of months) linux-next was broken and I had
> >> to carry a patch to ACPI to make it boot.  I dropped that patch at the
> >> head of my stgit trees in all of my repositories.  So I wouldn't be at
> >> all surprised to learn that eventually kernel-2 found that object in
> >> kernel-1.  Sometime when I dropped that patch from kernel-1 (because it
> >> finally got fixed upstream) I can see how it broke.
> >>
> >> But now that patch shouldn't be needed by any tree since I have long
> >> since dropped it from the stgit stack.  So if we cleaned up all of the
> >> useless objects in this tree I bet this object wouldn't be needed.  Not
> >> exactly a situation that I'd expect git to be able to dig out of itself
> >> thought.
> >
> > I let the script I provided previously ran for a while.  And the commit
> > I found to contain the missing object belongs to
> > refs/patches/fsnotify/fsnotify-group-priorities.log.  So I simply
> > deleted that branch entirely and now the repack can proceed.  And with a
> > 'git gc --aggressive' the 1.2GB repository shrank to a mere 5.2 MB.  :-)
> > Of course I didn't bring back all the reflogs though.  But I would
> > have expected a repository reduction of the same magnitude even with
> > them.
> >
> 
> Are we talking about the same Linux kernel repository as before?
> Because if so, that reduction in size doesn't make any sense to me.
> The smallest size I've seen for the Linux kernel repository (in the
> past year) is 250MB.

Remember that the real code object are in an alternative repository
which isn't going to shrink like this.  (A nicely packed repo with the
majority of the objects in question is around 500M)
