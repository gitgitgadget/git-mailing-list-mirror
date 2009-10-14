From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Wed, 14 Oct 2009 11:56:54 +0200
Message-ID: <200910141156.55536.trast@student.ethz.ch>
References: <0016e68fd0123a175304754694b4@google.com> <7vljjf226t.fsf@alter.siamese.dyndns.org> <200910131051.47117.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 12:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My0gX-0004Uc-7q
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757930AbZJNJ6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757153AbZJNJ6S
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:58:18 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:26620 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756569AbZJNJ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:58:17 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 14 Oct
 2009 11:57:29 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 14 Oct
 2009 11:57:47 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <200910131051.47117.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130277>

Thomas Rast wrote:
> Junio C Hamano wrote:
> > 
> > #1. These used to detach, but will create a local branch
> > 
> >  $ git checkout origin/next        ;# as if with -t
> >  $ git checkout xyzzy/frotz        ;# as if with -t (origin is not special)
> 
> Agreed, though I'm still in favour of a cleaner syntax for explicit
> detaching.  (Cleaner in the sense that ^0 is documented as having a
> completely different purpose and only works by accident.)

Not sure if it's too late in the thread, but after sleeping over it
and re-reading (and the other developments in the thread) I'm not
happy with my earlier opinion any more.  I think the DWIM part of it
is a bad idea because of this:

> >  $ git checkout origin/master      ;# detach, or refuse???
> 
> This seems to be the trickiest of them.  Maybe check out 'master', to
> make the process repeatable.  Imagine, in your setting,
> 
>   git checkout origin/next           ;# creates 'next' as with -t
>   git checkout -                     ;# back
>   git checkout origin/next           ;# should go to 'next' again
> 
> Then again, that would trade the confusion of detaching for the
> confusion of not checking out the exact commit that the user
> specified.  Worse, 'next' could conceivably be tracking (as per
> branch.next.merge) some entirely different branch, making the "Your
> branch is behind..." message misleading.

So I think we're now mixing up two different goals in this thread:
a) Stopping the users from hurting themselves by inadvertent detaching
b) Helping the users by DWIMming local branches for them

I'm all for (a), but (b) is much harder.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
