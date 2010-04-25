From: Jeff King <peff@peff.net>
Subject: Re: Bugreport: Git responds with stderr instead of stdout
Date: Sun, 25 Apr 2010 15:22:07 -0400
Message-ID: <20100425192207.GA14736@coredump.intra.peff.net>
References: <20100425130607.2c92740f@pennie-farthing>
 <v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
 <y2g51dd1af81004251124zc4da759dka2ceebe1d9735fd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Jack Desert <jackdesert556@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 21:22:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O67PH-0008Hw-On
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 21:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab0DYTWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 15:22:13 -0400
Received: from peff.net ([208.65.91.99]:51450 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab0DYTWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 15:22:12 -0400
Received: (qmail 29749 invoked by uid 107); 25 Apr 2010 19:22:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Apr 2010 15:22:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Apr 2010 15:22:07 -0400
Content-Disposition: inline
In-Reply-To: <y2g51dd1af81004251124zc4da759dka2ceebe1d9735fd7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145760>

On Sun, Apr 25, 2010 at 06:24:43PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Sun, Apr 25, 2010 at 18:10, Jacob Helwig <jacob.helwig@gmail.com> =
wrote:
> > I can't really say if it's actually a bug, or not, but as to your
> > question about where to file a bug report: You just did. =C2=A0This=
 mailing
> > list is the correct place.
>=20
> I've had some issues scripting `git fetch` because on error it'll
> print to stdout and not stderr.

Errors should go to stderr, so I imagine patches would be welcome. Whic=
h
messages went to stdout?

> Are there some general guidelines for git's utilities that they follo=
w
> in this regard or does each tool just do its own thing?

In practice, each tool does its own thing because they evolved
differently and from different authors. I think we are slowly convergin=
g
on similar behavior, though, as people fix warts.  As to exactly what
that behavior is, I don't know that anybody has ever enumerated it
exactly. Verbose status and progress reports, especially human readable
ones, should probably always go to stderr.

The "Switched to a new branch" message that started this thread is
correct to go to stderr.  If you want to silence the message but keep
stderr open for actual errors, the right way is to use "-q".

I tend to think the only thing that should go to stdout is the "main"
output of a command. For something like "ls-files", that is obviously
the list of files. For something like "checkout", which is about
changing the repository and not about querying it, I think there is
probably nothing that makes sense on stdout.

-Peff
