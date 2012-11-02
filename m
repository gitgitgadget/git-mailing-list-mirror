From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated
 properly
Date: Fri, 2 Nov 2012 16:17:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211021612320.7256@s15462909.onlinehome-server.info>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com> <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com> <20121031003721.GV15167@elie.Belkin> <20121102131255.GB2598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJ00-0007MS-3X
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778Ab2KBPRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:17:19 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:60489 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756619Ab2KBPRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:17:18 -0400
Received: (qmail invoked by alias); 02 Nov 2012 15:17:16 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp002) with SMTP; 02 Nov 2012 16:17:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NiXR1C2kNjWLhAJPHoe3lBvT5S3qAVjvk1EIZTR
	8KjZ6G3UvAAFCI
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20121102131255.GB2598@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208946>

Hi Peff,

On Fri, 2 Nov 2012, Jeff King wrote:

> On Tue, Oct 30, 2012 at 05:37:21PM -0700, Jonathan Nieder wrote:
> 
> > If the commit does not have the SHOWN or UNINTERESTING flag set but it
> > is going to get the UNINTERESTING flag set during the walk because of
> > a negative commit listed on the command line, this patch won't help.
> 
> Right, so my understanding of the situation is that doing this:
> 
>   $ git branch foo master~1
>   $ git fast-export foo master~1..master
> 
> won't show "foo", which seems wrong to me. _But_ we currently get that
> wrong already, so Felipe's patches are not making anything worse, but
> are fixing some situations (namely when master~1 is not mentioned on the
> command-line, but rather in a marks file).
> 
> Is that correct?
> 
> If so, then this series isn't regressing behavior; the only downside is
> that it's an incomplete fix. In theory this could get in the way of the
> full fix later on, but given the commit messages and the archive of this
> discussion, it would be simple enough to revert it later in favor of a
> more full fix. Is that accurate?

>From my understanding, yes.

> Sorry if I am belaboring the discussion. I just want to make sure I
> understand the situation before deciding what to do with the topic. It
> sounds like the consensus at this point is "not perfect, but good enough
> to make forward progress".

I appreciate that stance very much. The patch Sverre and I proposed was
also an incomplete fix (although I suspect it would fix the issue you
pointed out above), so I agree with the "perfect is the enemy of the good"
approach, obviously.

May I just ask to include a summary of that rationale into the commit
message rather than relying on people having internet access and knowing
where to look? Adding the following to the commit message would be good
enough for me:

	Note that

		$ git branch foo master~1
		$ git fast-export foo master~1..master

	still does not update the "foo" ref, but a partial fix is better
	than no fix.

Thanks,
Dscho
