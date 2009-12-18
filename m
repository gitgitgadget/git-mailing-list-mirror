From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Thu, 17 Dec 2009 22:55:50 -0500
Message-ID: <1261108550.2868.63.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
	 <1260825629.9379.56.camel@localhost>
	 <20091215023918.GA14689@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
	 <1260851180.9379.88.camel@localhost>
	 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
	 <1260970885.2788.87.camel@localhost>
	 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
	 <1261003041.2788.142.camel@localhost>
	 <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
	 <1261067369.2868.10.camel@localhost>
	 <alpine.LFD.2.00.0912172149020.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:56:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLTwd-00060I-HF
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 04:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbZLRDzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 22:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755786AbZLRDzz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 22:55:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbZLRDzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 22:55:54 -0500
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBI3tppp016516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 17 Dec 2009 22:55:52 -0500
Received: from [10.11.10.49] (vpn-10-49.rdu.redhat.com [10.11.10.49])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBI3to4u032594;
	Thu, 17 Dec 2009 22:55:51 -0500
In-Reply-To: <alpine.LFD.2.00.0912172149020.23173@xanadu.home>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135399>

On Thu, 2009-12-17 at 22:33 -0500, Nicolas Pitre wrote:
> On Thu, 17 Dec 2009, Eric Paris wrote:
> 
> > This alone almost certainly tells me how I broke it.
> > 
> > For quite some time (a period of months) linux-next was broken and I had
> > to carry a patch to ACPI to make it boot.  I dropped that patch at the
> > head of my stgit trees in all of my repositories.  So I wouldn't be at
> > all surprised to learn that eventually kernel-2 found that object in
> > kernel-1.  Sometime when I dropped that patch from kernel-1 (because it
> > finally got fixed upstream) I can see how it broke.
> > 
> > But now that patch shouldn't be needed by any tree since I have long
> > since dropped it from the stgit stack.  So if we cleaned up all of the
> > useless objects in this tree I bet this object wouldn't be needed.  Not
> > exactly a situation that I'd expect git to be able to dig out of itself
> > thought.
> 
> I let the script I provided previously ran for a while.  And the commit 
> I found to contain the missing object belongs to 
> refs/patches/fsnotify/fsnotify-group-priorities.log.

At least when I thought it was in ACPI I could imagine what I had done
wrong.  Now I'm not so sure.

In any case, I've redesigned with a clear alternative repo that I never
work in and a cron job to clean up garbage every night.  So hopefully
noone will hear from me again.

Nicolas, thanks so much for hunting this down!

-Eric

>   So I simply 
> deleted that branch entirely and now the repack can proceed.  And with a 
> 'git gc --aggressive' the 1.2GB repository shrank to a mere 5.2 MB.  :-) 
> Of course I didn't bring back all the reflogs though.  But I would 
> have expected a repository reduction of the same magnitude even with 
> them.
> 
> 
> Nicolas
