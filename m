From: Stephen Bash <bash@genarts.com>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 10:26:02 -0400 (EDT)
Message-ID: <360187633.973068.1369405562399.JavaMail.root@genarts.com>
References: <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jim Greenleaf <james.a.greenleaf@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 24 16:33:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uft46-0007OH-2U
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 16:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab3EXOdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 10:33:50 -0400
Received: from hq.genarts.com ([173.9.65.1]:59531 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752105Ab3EXOdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 10:33:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C45A5BE4032;
	Fri, 24 May 2013 10:26:08 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eZMfO5vnI2iv; Fri, 24 May 2013 10:26:02 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 83292BE3D93;
	Fri, 24 May 2013 10:26:02 -0400 (EDT)
In-Reply-To: <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC27 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225358>

----- Original Message -----
> From: "Thomas Rast" <trast@inf.ethz.ch>
> Sent: Thursday, May 23, 2013 6:56:50 PM
> Subject: Re: git stash deletes/drops changes of
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thomas Rast <trast@inf.ethz.ch> writes:
> >
> > > So maybe it would be time to first make up our minds as to what
> > > --assume-unchanged should actually mean:
> > >
> > > * Ignore changes to a tracked file, but treat them as valuable.
> > >   In this case we'd have to make sure that failures like
> > >   git-stash's are handled properly.
> > >
> > > * Ignore changes to a tracked file, as in "who cares if it was
> > >   changed".
> > >
> > > * A very specific optimization for users who know what they are
> > >   doing.
> >
> > It has always been a promise the user makes to Git that the working
> > tree files that are marked as such will be kept identical to what is
> > in the index (hence there is no need for Git to check if they were
> > modified). And by extension, Git is now free to choose reading from
> > the working tree file when asked to read from blob object recorded
> > in the index for that path, or vice versa, because of that promise.
> >
> > It is not --ignore-changes bit, and has never been.  What are the
> > workflows that are helped if we had such a bit?  If we need to
> > support them, I think you need a real --ignore-changes bit, not
> > an abuse of --assume-unchanged.
> 
> I gather -- from #git -- that it's mostly used for config files, which
> have an annoying habit of being different from the repository.

The web team at my $dayjob has the same problem, and I believe they are also using --assume-unchanged.

This may be slightly too tangential, but a different workflow we experimented with is marking the config file(s) merge=ours in gitattributes on each branch.  Ideally then devs can check in their local settings on their local branches.  Unfortunately, as is probably well known here, the merge attribute is only checked by the low level merge algorithm, so too often settings got bashed incorrectly (only one merge parent changed the file).  Perhaps there are some options in that direction?

Thanks,
Stephen
