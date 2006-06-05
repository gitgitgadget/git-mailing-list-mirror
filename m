From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Gitk feature - show nearby tags
Date: Mon, 5 Jun 2006 22:19:02 +0200
Message-ID: <20060605201902.GB17300@diku.dk>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com> <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net> <20060603151240.GA4024@diku.dk> <7vejy48wp5.fsf@assigned-by-dhcp.cox.net> <20060605000423.GA29521@diku.dk> <7v3bek7589.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 22:19:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnLXZ-0005b7-Jp
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 22:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWFEUTG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Jun 2006 16:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWFEUTG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 16:19:06 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:55002 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751411AbWFEUTF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 16:19:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id DCD96770014;
	Mon,  5 Jun 2006 22:19:03 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19823-20; Mon,  5 Jun 2006 22:19:02 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7F68F770021;
	Mon,  5 Jun 2006 22:19:02 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 587AE6DF8AC; Mon,  5 Jun 2006 22:15:44 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 68A53625FA; Mon,  5 Jun 2006 22:19:02 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bek7589.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21339>

Junio C Hamano <junkio@cox.net> wrote Sun, Jun 04, 2006:
> Jonas Fonseca <fonseca@diku.dk> writes:
>=20
> >>     - I want to see the neighbouring commits, but UP or DOWN
> >>       does not do what I na=EFvely expect.  It scrolls the lower
> >>       pane.  I say TAB to go up.
> >
> > I wonder what tig version you are using. If you are using the tig
> > version from my git repo this should also be working to your
> > expectation, making ...
>=20
> Whichever was the latest when I wrote the message.  I see you
> have added a handful commits on it since then.

Yes, I added your Makefile patch. Thanks for that one.

> >>     - Press UP or DOWN and I can move the highlight to
> >>       neighbouring commits.  This is wonderful, but the lower
> >>       pane does not follow this -- it keeps showing the original
> >>       commit, and I have to say ENTER again.
> >
> > .. this unnecessary.
>=20
> Maybe I am misusing it then.

I admit the basic user controls might still have some rough spots.
Here is my take on what you are trying to do:

 - When you open tig, UP/DOWN will move the cursor line.

 - When you press ENTER on the commit you would like to see, it will
   open the split view and move focus to the diff view.  So if you pres=
s
   Enter again it will start scrolling the diff view. This is much like
   the way Mutt works.

 - If you press UP/DOWN (while the diff view is focused) you will move
   to previous or next commit in the main view (the one-line log view)
   and load it in the diff view. That is, there is no reason to switch
   to the main view unless you want to navigate to a commit without
   repeatedly reloading the diff view which is clearly not what you are
   requesting.

Is this not what you requested? That you can "see neighbouring commit"
by pressing UP and DOWN? But without having to press ENTER again.

Now, I've experienced some problems with ncurses and key detection but
only for Insert/Delete and Home/End. If UP/DOWN scrolls the diff view
something is terrible wrong.

> I like viewing the list in the upper and diff/log in the lower
> at the same time, and that is the primary reason I liked tig, so
> moving around in the commit list view and not seeing the
> diff/log updated in sync was major dissapointment at least for
> me.

Ok, well I can just make it optional, if you want the split view always
to be in sync, even while moving when the main view is in focus.

--=20
Jonas Fonseca
