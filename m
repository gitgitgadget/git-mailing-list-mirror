From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Thu, 17 Apr 2008 18:03:27 +0200
Message-ID: <20080417160327.GA13462@atjola.homenet>
References: <87od88eslq.dlv@maison.homelinux.org> <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org> <20080417153421.GA13117@atjola.homenet> <alpine.LFD.1.00.0804170841270.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 18:35:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmWav-0006sM-Ec
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 18:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbYDQQDb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 12:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbYDQQDb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 12:03:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:46709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755160AbYDQQDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 12:03:30 -0400
Received: (qmail invoked by alias); 17 Apr 2008 16:03:28 -0000
Received: from i577AFE10.versanet.de (EHLO atjola.local) [87.122.254.16]
  by mail.gmx.net (mp047) with SMTP; 17 Apr 2008 18:03:28 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+iQ0sa736iF8prGwV/wrGJ6b6/aZwCpFaIi5lztU
	y3fywqoudFF1VU
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0804170841270.2879@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79800>

On 2008.04.17 08:44:07 -0700, Linus Torvalds wrote:
>=20
>=20
> On Thu, 17 Apr 2008, Bj=F6rn Steinbrink wrote:
> >=20
> > Debian has its own dash which is supposed to be a lightweight
> > alternative to bash and "for checking POSIX compliance of scripts"
> > (quote from the packages description). I don't happen to know off-h=
and
> > whether POSIX says that echo should default to -e, but dash seems t=
o do
> > that:
> >=20
> > $ dash
> > $ a=3D"hello\nhi"
> > $ echo $a
> > hello
> > hi
>=20
> Ahh. So that "echo" should just be replaced with a 'printf "%s\n"'=20
> instead?=20
>=20
> We have a _lot_ of "echo"s though. I suspect the only ones we'd ever =
catch=20
> are the ones explicitly tested for. I suspect that the dash echo is j=
ust=20
> broken.

Wow, seems that "echo" in itself is "broken". According to POSIX[1]
backslashes induce implementation defined behaviour, and there seem to
be two historic versions of echo, one that knows about -n and one that
interprets escape sequences. So echo is totally non-portable unless you
avoid -n as well as backslashes. Ouch.

The POSIX docs, as well as random Google results, indeed recommend to
use printf instead. But that switch seems painful as well...

Bj=F6rn

[1] http://www.opengroup.org/onlinepubs/009695399/utilities/echo.html
