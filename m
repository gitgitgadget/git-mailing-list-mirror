From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD state while preserving its staged state
Date: Mon, 6 May 2013 11:51:55 +0200
Message-ID: <87r4hkigg4.fsf@linux-k42r.v.cablecom.net>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
	<87obcryvcw.fsf@hexa.v.cablecom.net>
	<7va9oawmbp.fsf@alter.siamese.dyndns.org>
	<7v61yywm49.fsf@alter.siamese.dyndns.org>
	<CADeMBopBvCmb4cz8p8vf-jXaOhfzP3GZKF94Efgsh-NOBs+d3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	<jrnieder@gmail.com>
To: Dimitar Bonev <dsbonev@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 11:52:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZI5T-0003lF-4f
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 11:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab3EFJv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 05:51:58 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:48799 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab3EFJv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 05:51:57 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 6 May
 2013 11:51:55 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 6 May 2013 11:51:55 +0200
In-Reply-To: <CADeMBopBvCmb4cz8p8vf-jXaOhfzP3GZKF94Efgsh-NOBs+d3Q@mail.gmail.com>
	(Dimitar Bonev's message of "Sun, 5 May 2013 01:46:28 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223433>

Dimitar Bonev <dsbonev@gmail.com> writes:

> One more argument against the suggestion of doing a commit ahead of
> time is that I like to think in separation to reduce complexity - in
> particular I like to think only for the working dir and index states,
> commits - I treat them as finished work. If I have to amend a commit,
> it is about fixing a mistake - adding/removing a wrong file, fixing a
> typo, that sort of things and not for actual work to be done.

Aside from what's been said already, there's a fundamental problem with
your approach: it doesn't scale in any direction.  You cannot use it if
you want to do the same dance with more than one version "set aside",
because the index gives you exactly one more storage area.  And it does
not generalize in any useful way, whereas using temporary commits is
useful also if you want to briefly leave a branch with unfinished work
to do something else.  Furthermore, knowing how to work with temporary
commits (in the plural), and clean them up using 'rebase -i', *is* a
part of "work to be done" in most git workflows.  Namely, it is used to
reshape your branch from a "how did I hack this up" angle into a "how do
I explain this to others" angle.

So I hope I'm not misconstruing what Junio and Jonathan said, but I
think you can sum up our position as: your proposal is a very specific
solution to a very narrow problem -- that is only needed because your
environment (PowerShell) is arguably broken.  All the while, there are
several existing solutions that we consider more natural, and that
generalize to other use-cases.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
