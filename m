From: Jeff King <peff@peff.net>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc
 8.2.5
Date: Tue, 29 May 2012 17:56:13 -0400
Message-ID: <20120529215613.GB17598@sigill.intra.peff.net>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
 <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
 <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 23:56:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZUOq-0006Ou-US
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 23:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab2E2V4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 17:56:17 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:35427
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511Ab2E2V4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 17:56:16 -0400
Received: (qmail 29130 invoked by uid 107); 29 May 2012 21:56:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 May 2012 17:56:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2012 17:56:13 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198768>

On Tue, May 29, 2012 at 02:31:38PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Tue, May 29, 2012 at 2:03 PM, Thomas Rast <trast@inf.ethz.ch> wrot=
e:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >> Jeff King's 6cf378f0cbe7c7f944637892caeb9058c90a185a broke my Git
> >> build on CentOS 5.5. The patch suggests that it only breaks
> >> compatibility with asciidoc 7 but that isn't actually the case.
> >
> > The commit message of 6cf378f0 is not correct in that respect. =C2=A0=
My
> > ancient 71c020c5 has the right numbers: asciidoc 8.4.1 is the one t=
hat
> > introduced the new inline-literal behavior. =C2=A0Based on my littl=
e survey
> > in

Yeah, sorry, this is my fault. It came up in discussion but I never
amended the commit message. The magic number is definitely 8.4.1.

> Well, me and and others using current production RHEL releases:
>=20
>     $ cat /etc/redhat-release && yum info asciidoc.noarch|grep Versio=
n
>     CentOS release 5.5 (Final)
>     Version    : 8.1.0
>     $ cat /etc/redhat-release && yum info asciidoc.noarch|grep Versio=
n
>     CentOS release 5.5 (Final)
>     Version    : 8.2.5
>=20
> I can't quite recall how I ended up with 8.2.5 on one of the boxes,
> but it seems 8.1.0 may actually be the stock version.

=46rom my searches, there is no stock version in RHEL5 or CentOS 5. The=
y
did not start shipping asciidoc until RHEL6, which includes 8.4.5. It's
very easy to find 3rd-party RPMs for asciidoc, which is presumably why
you have multiple versions. And these days it's easy to find 8.4.5
packaged for el5.

Can you check your yum sources? I may be wrong that asciidoc was never
part of the base system, but I can't find it in the RHEL or CentOS
package lists, and google searching turns up only 3rd-party versions.
Of course, it may also have been installed as a one-off, outside of yum=
,
or the yum sources changed after it was installed, so your check may
yield nothing interesting.

> Or we could just decide to break RHEL 5 and systems released at a
> similar time, but that isn't what the patch suggested it was doing, s=
o
> we should probably step back and ponder whether that's something we
> want to do.

It was not intentional to break RHEL5 in particular, but it was
definitely intentional to stop working with older versions of asciidoc.
As I wrote above, I'm not sure that there _is_ an official version of
asciidoc for RHEL 5.

> Personally I think having a hard dependency on a version of a softwar=
e
> package released more recently than 2007 (8.2.5 came out on
> 2007-11-18) is way too soon, it would be similar to breaking on a GCC
> older than 4.2.0 which came out around the same time.

I think that's over-simplifying. We can use old versions of gcc (or eve=
n
antique proprietary compilers) because they all accept C89 or some
reasonable variant, a standard which was mature at the time of their
writing. Asciidoc is much less mature, and the no-inline-literal syntax
sucks, and was the source of a very large number of recurring bugs. We
have to balance the pain of supporting the old versions with the pain o=
f
leaving behind people with no other option.

So it is not just "well, this modern syntax is a little nicer". It is
fixing real documentation formatting bugs that affect all users (on old
and modern asciidoc), and closing the hole so that they don't happen
again.

And unlike compilers, it is relatively easy to work around; because the
build result is architecture independent, Junio can (and does) produce
built versions which plug into the Makefile.

I'm very sympathetic to having platform support dropped. It's annoying
for the user. But given that it's a 3rd-party install anyway (and you
can install a newer 3rd-party RPM), and that you can additionally use
"make quick-install-man" to avoid needing asciidoc entirely, and given
the sheer number of bugs this patch fixes (and prevents), to me the
balance still argues for keeping the patch.

One thing we could do better at is not silently producing crappy result=
s
(e.g., by detecting a too-old asciidoc version during the build process=
,
and advising the user to upgrade or user quick-install). Or even having
a deprecation period with warning, though I feel that's less important
for a build breakage than a run-time change of behavior.

-Peff
