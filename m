From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 19:22:17 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070327172216.GA24200@informatik.uni-freiburg.de>
References: <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org> <20070327112549.GA12178@informatik.uni-freiburg.de> <20070327115029.GC12178@informatik.uni-freiburg.de> <20070327155306.GQ22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:22:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWFNM-0005i4-W2
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 19:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934012AbXC0RW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 13:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934013AbXC0RW0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 13:22:26 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:50048 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934012AbXC0RWZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 13:22:25 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HWFNF-0003uH-PS; Tue, 27 Mar 2007 19:22:21 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2RHMIqn024492;
	Tue, 27 Mar 2007 19:22:18 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2RHMHRK024491;
	Tue, 27 Mar 2007 19:22:17 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Martin Waitz <tali@admingilde.org>, Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070327155306.GQ22773@admingilde.org>
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43288>

Hallali,

Martin Waitz wrote:
> On Tue, Mar 27, 2007 at 01:50:29PM +0200, Uwe Kleine-K=F6nig wrote:
> > If you separate the odbs e.g by the pathname of the subproject, wha=
t
> > happens if I choose to move the linux kernel in my embedded Linux
> > project from /linux to /kernel/linux?
>=20
> Then a new separate object database would have to be created.
> This is the part I really don't like about separate object databases,
> but perhaps some persistent alternates information could help here.
>=20
> For any other way to separate the odb (project id, whatever), we
> can't get a list of references into it by a path-limited traversal
> in the parent. Thus separate odbs which are not bound to a special
> location have some serious downsides.
(CVS comes to mind ...)
This currently convinces me that a separate odb is wrong.

> > Or maybe worse:  If I currently track the Kernel in a tree (because=
 of
> > git lacking submodule support) and switch to submodule.  Then
> > linux/Makefile has to exist in both the supermodule's and the
> > submodule's odb.
>=20
> Sorry, I don't understand you here.
Assume I have

	embeddedproject$ git ls-tree HEAD | grep linux
	040000 tree 0123456789abcdef... linux-2.6

and then I commit on top of that, s.t. I get:

	embeddedproject$ git ls-tree HEAD | grep linux
	040000 commit 0123456789abcde0... linux-2.6

(or how ever you save submodules).  Then you might have to duplicate th=
e
objects of linux-2.6, because they are part of both histories.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

primes where sieve (p:xs) =3D [ x | x<-xs, x `rem` p /=3D 0 ]; \
primes =3D map head (iterate sieve [2..])
