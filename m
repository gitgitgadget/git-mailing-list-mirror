From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 10:12:45 -0400
Message-ID: <20120322141245.GB8803@sigill.intra.peff.net>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net>
 <4F6B0C3E.8090501@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 22 15:12:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAil2-0000v6-VV
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 15:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab2CVOMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 10:12:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56675
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737Ab2CVOMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 10:12:47 -0400
Received: (qmail 1256 invoked by uid 107); 22 Mar 2012 14:13:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 10:13:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 10:12:45 -0400
Content-Disposition: inline
In-Reply-To: <4F6B0C3E.8090501@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193659>

On Thu, Mar 22, 2012 at 12:25:50PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> >What am I missing?
>=20
> The OP meant a case-sensitive fs, not an insensitive one.
> "On a filesystem that *is* case-sensitive, ..."
>=20
> This is a question about core.ignorecase=3Dtrue. The description in
> git-config(1) is so vague, that it's hard to say what behaviour is
> expected.

I don't know. It says:

  If true, this option enables various workarounds to enable git to wor=
k
  better on filesystems that are not case sensitive, like FAT. For
  example, if a directory listing finds "makefile" when git expects
  "Makefile", git will assume it is really the same file, and continue
  to remember it as "Makefile".

which seems pretty clear to me that this is "let git work better on
case-insensitive filesystems", not "make git magically case-insensitive
on case sensitive filesystem". But maybe we could add be more explicit,
like:

-- >8 --
Subject: docs: clarify core.ignorecase on case-sensitive filesystems

core.ignorecase is about handling case-insensitive
filesystems, not making git magically case-insensitive on a
case-sensitive filesystem. That's implied by the current
text, but let's add an explicit note.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c081657..abbab91 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -191,6 +191,10 @@ core.ignorecase::
 The default is false, except linkgit:git-clone[1] or linkgit:git-init[=
1]
 will probe and set core.ignorecase true if appropriate when the reposi=
tory
 is created.
++
+Note that this is about making git work well on a case-insensitive
+filesystem. It will not make git case-insensitive when used on a
+case-sensitive filesystem.
=20
 core.trustctime::
 	If false, the ctime differences between the index and the
--=20
1.7.10.rc0.9.gdcbe9
