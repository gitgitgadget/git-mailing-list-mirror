From: Jeff King <peff@peff.net>
Subject: [PATCH] t/gitweb-lib: use $PERL_PATH to run gitweb
Date: Tue, 1 May 2012 13:55:00 -0400
Message-ID: <20120501175500.GA24258@sigill.intra.peff.net>
References: <201205011323.45190.tboegi@web.de>
 <4FA00E09.2090708@in.waw.pl>
 <7vsjfjalx6.fsf@alter.siamese.dyndns.org>
 <4FA0176B.50300@in.waw.pl>
 <20120501170810.GA22444@sigill.intra.peff.net>
 <4FA02274.6070601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>, jnareb@gmail.com,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 01 19:55:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHI9-0006i8-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214Ab2EARzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:55:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53541
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754756Ab2EARzG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:55:06 -0400
Received: (qmail 8459 invoked by uid 107); 1 May 2012 17:55:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 13:55:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 13:55:00 -0400
Content-Disposition: inline
In-Reply-To: <4FA02274.6070601@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196715>

The current code runs "perl gitweb.cgi" to test gitweb. This
will use whatever version of perl happens to be first in the
PATH. We are better off using the specific perl that the
user specified via PERL_PATH, which matches what gets put on
the #!-line of the built gitweb.cgi.

Signed-off-by: Jeff King <peff@peff.net>
---
On Tue, May 01, 2012 at 07:50:44PM +0200, Torsten B=C3=B6gershausen wro=
te:

> > Torsten, does that fix your problem?
> Yes, it does.

OK, here it is with a commit message.

 t/gitweb-lib.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 21d11d6..ae2dc46 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -69,7 +69,7 @@ gitweb_run () {
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- "$SCRIPT_NAME" \
+	"$PERL_PATH" -- "$SCRIPT_NAME" \
 		>gitweb.output 2>gitweb.log &&
 	perl -w -e '
 		open O, ">gitweb.headers";
--=20
1.7.10.630.g31718
