From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.7.4 (and updates to older maintenance tracks)
Date: Sun, 20 Mar 2016 15:43:13 -0400
Message-ID: <20160320194313.GB6288@sigill.intra.peff.net>
References: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com>
 <680C4CDE-233E-4603-B3F1-D68EB126620F@FreeBSD.org>
 <CAPig+cSOjFqcKGaZC1HWGdp7aCg7Dog1GvFYPYRbShARPm9ODQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Renato Botelho <garga@freebsd.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 20:43:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahjFx-0007ar-5M
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 20:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbcCTTnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2016 15:43:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:34976 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbcCTTnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 15:43:16 -0400
Received: (qmail 3147 invoked by uid 102); 20 Mar 2016 19:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 15:43:16 -0400
Received: (qmail 30317 invoked by uid 107); 20 Mar 2016 19:43:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 15:43:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2016 15:43:13 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSOjFqcKGaZC1HWGdp7aCg7Dog1GvFYPYRbShARPm9ODQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289381>

On Sun, Mar 20, 2016 at 01:07:52PM -0400, Eric Sunshine wrote:

> On Sun, Mar 20, 2016 at 11:32 AM, Renato Botelho <garga@freebsd.org> =
wrote:
> >> On Mar 17, 2016, at 18:07, Junio C Hamano <gitster@pobox.com> wrot=
e:
> >> Git v2.7.4 Release Notes
> >>
> >> Junio C Hamano (4):
> >>      Git 2.4.11
> >>      Git 2.5.5
> >>      Git 2.6.6
> >>      Git 2.7.4
> >
> > FYI,
> >
> > 2.7.4 fails to build on FreeBSD 9.x, that uses by default gcc 4.2.1=
=2E I=E2=80=99ve fixed it adding an extra dependency to make force it t=
o require gcc 4.8+. Here is the output:
> >
> > cc -o combine-diff.o -c -MF ./.depend/combine-diff.o.d -MQ combine-=
diff.o -MMD -MP -isystem/usr/local/include -O2 -pipe -fstack-protector =
-fno-strict-aliasing -I. -I/usr/local/include -I/usr/local/include -DUS=
E_CURL_FOR_IMAP_SEND -I/usr/include -DUSE_ST_TIMESPEC -pthread -DHAVE_P=
ATHS_H -DHAVE_STRINGS_H -DGMTIME_UNRELIABLE_ERRORS -DHAVE_CLOCK_GETTIME=
 -DHAVE_CLOCK_MONOTONIC -DHAVE_BSD_SYSCTL -DHAVE_GETDELIM -DSHA1_HEADER=
=3D'<openssl/sha.h>'  -DDIR_HAS_BSD_GROUP_SEMANTICS -DSHELL_PATH=3D'"/b=
in/sh"'  combine-diff.c
> > combine-diff.c: In function 'diff_tree_combined':
> > combine-diff.c:1391: internal compiler error: Segmentation fault: 1=
1
> > Please submit a full bug report,
> > with preprocessed source if appropriate.
> > See <URL:http://gcc.gnu.org/bugs.html> for instructions.
> > Makefile:1924: recipe for target 'combine-diff.o' failed
> > gmake: *** [combine-diff.o] Error 1
> > *** [do-build] Error code 1
>=20
> Interesting. This appears to be the same bug as [1].
>=20
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/287486/fo=
cus=3D287789

Yes. AFAICT that version of gcc is simply buggy, and we are not doing
anything illegal or even particularly exotic. Given how old it is, I'm
not sure it's worth worrying too much about it, but I am happy to work
around it if somebody can figure out how to do so.

I spent some time trying to bisect gcc, but had trouble getting a
working build for a gcc that old.

-Peff
