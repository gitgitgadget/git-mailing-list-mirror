From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue, 13))
Date: Wed, 14 Dec 2011 17:17:14 +0100
Message-ID: <201112141717.15021.trast@student.ethz.ch>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org> <20111214070916.GA14954@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:17:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RarWZ-00087j-Oz
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab1LNQRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:17:19 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:32084 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115Ab1LNQRR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:17:17 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 17:17:12 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 17:17:15 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20111214070916.GA14954@elie.hsd1.il.comcast.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187140>

Jonathan Nieder wrote:
> Junio C Hamano wrote:
> > Will merge to 'next' after taking another look.
> 
> The middle commit looks good.  The bottom commit could be improved as
> discussed at [1], but I guess that can happen in-tree.
> 
> However, the top commit ("test test-terminal's sanity") still does not
> seem right to me.

I wasn't under the impression that we were done with this, either :-)

> It makes the same test run three times.  Probably I should send an
> alternate patch to get that sanity-check to run once, but I am also
> not convinced the sanity-check is needed at all --- wouldn't any test
> that is relying on output from test_terminal act as a sanity check for
> it already?

It didn't.  Or more precisely, Michael Haggerty ran into the behavior
of

  git rev-parse ... | while read sha; do git checkout $sha; make test; done

couldn't make any sense of it, and reported it on IRC.  So in some
sense, it took infrequent circumstances and two developers' time; next
time around I'd prefer it to be detected automatically.

> As an aside, I also still believe that running "git shortlog" without
> explicitly passing "HEAD" when testing how it reacts to [core] pager
> configuration was a bug and a distraction, hence the patch at [2].

Why not.  Some other test should verify how shortlog reacts to the
tty-ness of stdin, but that's yet another direction.

> I also find Jeff's patch [3] appealing.

Me too, though wonder whether feeding a file full of garbage wouldn't
be better, so as to trip up commands that try to read only from a
non-tty stdin.



> [1] http://thread.gmane.org/gmane.comp.version-control.git/186923/focus=186944
> [2] http://article.gmane.org/gmane.comp.version-control.git/186932
> [3] http://article.gmane.org/gmane.comp.version-control.git/186936

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
