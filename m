From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 21:35:47 +0200
Message-ID: <5F01034D-8964-47AC-8FB5-F68C44D7FFD5@wincent.com>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net> <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org> <bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com> <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sverre@rabbelier.nl, "Jeff King" <peff@peff.net>,
	"Andreas Ericsson" <ae@op5.se>, "Eric Raible" <raible@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:37:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7F5e-00048c-Mr
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 21:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbYFMTgo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbYFMTgo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 15:36:44 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:48455 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbYFMTgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 15:36:43 -0400
Received: from cuzco.lan (185.pool85-53-11.dynamic.orange.es [85.53.11.185])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m5DJZlsX013841
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 13 Jun 2008 15:35:49 -0400
In-Reply-To: <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84935>

El 13/6/2008, a las 21:21, Junio C Hamano escribi=F3:

> To stash is like putting something in /tmp on a system that runs a =20
> cron
> job to clean out cruft from there once in a while.  Another analogy =20
> is to
> spitting an information out to syslog, so that it is kept until logs =
=20
> are
> rotated.


Judging from the number of people who have chimed in on this thread =20
saying "I expect Git to remember what I told it to remember" indicates =
=20
that all too few think of the stash as being like "/tmp" or a logfile. =
=20
There are two problems:

1) the name of the command, "stash" (and worse still "stash _save_") =20
is giving people a misleading impression about what it does

2) the documentation isn't clear enough about what the command does, =20
or people don't read it

I suspect that no matter how good the documentation is, a command =20
called "git stash save" that remembers stuff only temporarily will =20
continue to evoke reactions of puzzlement for as long as it works that =
=20
way. Seeing as Git is usually extremely conservative about throwing =20
away people's stuff, the ephemeralness of "git stash" backing store is =
=20
likely to be quite surprising for many.

What are the options?

- improve the documentation

- rename the command (can't see that happening)

- change the behaviour to "keep" until popped/cleared

I think the latter's the best, and a patch for it was already posted =20
at the beginning of this thread.

Cheers,
Wincent
