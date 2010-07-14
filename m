From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC 4/4] Add interactive mode to git-shell for user-friendliness
Date: Wed, 14 Jul 2010 17:40:37 +0200
Message-ID: <201007141740.37867.trast@student.ethz.ch>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu> <4C3DC2BD.6020907@digium.com> <20100714152444.GA26674@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Kevin P. Fleming" <kpfleming@digium.com>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 17:41:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ458-00035e-JU
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 17:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab0GNPlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 11:41:04 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:36504 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516Ab0GNPlD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 11:41:03 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 14 Jul
 2010 17:41:00 +0200
Received: from thomas.localnet (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 14 Jul
 2010 17:40:39 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20100714152444.GA26674@pcpool00.mathematik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150999>

[Please don't trim the Cc list without good reason.]

Bernhard R. Link wrote:
> * Kevin P. Fleming <kpfleming@digium.com> [100714 15:59]:
> > On 07/14/2010 04:04 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> > > On Wed, Jul 14, 2010 at 03:01, Greg Brockman <gdb@mit.edu> wrote:
> > >> +               execl(prog, prog, (char *) NULL);
> > >
> > > Why the casting of NULL? It's not done in the builtin/help.c code=
=2E
> > >
> > > Anyway, if it was cast it should be to (const char *), shouldn't =
it?
> >
> > When a NULL sentinel is passed to a varargs function that only
> > understands 'char *' arguments, the NULL must be cast specifically,
> > otherwise it will appear in the varargs array as an int or a long.
>=20
> To be more specific: If NULL is (void *)0 then it does not need to be
> cast. Sadly the standard allows to define it as 0, and so it is on
> some systems. So to be portable it needs to be cast to be a pointer,
> otherwise the varargs argument is assumed to be an int.

Worse, the pointer representations need not be the same between types,
even though that is a fairly exotic idea:

  http://c-faq.com/null/machexamp.html

So it seems execl() must always have an explicitly-cast (char*)NULL
sentinel.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
