From: Jeff King <peff@peff.net>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc
 8.2.5
Date: Wed, 30 May 2012 04:51:12 -0400
Message-ID: <20120530085111.GA9917@sigill.intra.peff.net>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
 <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
 <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
 <20120529215613.GB17598@sigill.intra.peff.net>
 <CACBZZX6a2BQVhe8-X5o+WnfbsrqPKa_Cn93GZ1bbq1TLezB97Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 10:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZed1-0005f9-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 10:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379Ab2E3Iv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 04:51:26 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36106
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932264Ab2E3IvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 04:51:22 -0400
Received: (qmail 1641 invoked by uid 107); 30 May 2012 08:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 04:51:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 04:51:12 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX6a2BQVhe8-X5o+WnfbsrqPKa_Cn93GZ1bbq1TLezB97Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198785>

On Wed, May 30, 2012 at 12:42:32AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Anyway, I've tested dropping asciidoc.py from the source distribution
> into compat/asciidoc.py and doing "make doc
> ASCIIDOC=3D../compat/asciidoc.py", it seems to work.
>=20
> I wonder if the easiest solution is to change the default asciidoc
> invocation from "asciidoc" to a small Documentation/asciidoc.sh scrip=
t
> that we supply, it would check if there's an asciidoc present on the
> system, whether it's sufficiently new, and if not fall back on a copy
> we have in compat/.

That makes me somewhat nervous. The asciidoc package on my system
contains 311 files. It seems probable that at least one of those files
beyond asciidoc.py is necessary for the system to work, and that it may
even depend on matching versions.

If we are going to go the route of providing an asciidoc for people
whose asciidoc is buggy, we might as well go all out and provide a
complete standalone asciidoc (or at least some subset) for those who
don't have it at all. Part of me finds that utterly gross, but part of
me likes the fact that we would be able to move our documentation and
our asciidoc interpreter in lockstep, which avoids some other bugs we
have seen in the past.  Of course, that doesn't help the rest of the
documentation toolchain (differing docbook versions have created
problems in the past, too).

I suppose the grossness would depend on how small a minimal asciidoc
distribution could be made (of those 311 files, many are documentation
and examples).

-Peff
