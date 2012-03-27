From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2] tests: unset COLUMNS inherited from environment
Date: Tue, 27 Mar 2012 08:22:02 +0200
Message-ID: <1332829323-6048-1-git-send-email-zbyszek@in.waw.pl>
References: <20120327051714.GB20897@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Tue Mar 27 08:24:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPpG-0000nW-9C
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab2C0GYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 02:24:10 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56342 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab2C0GYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:24:08 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SCPp8-0008Ck-5C; Tue, 27 Mar 2012 08:24:06 +0200
X-Mailer: git-send-email 1.7.10.rc1.222.gc0040.dirty
In-Reply-To: <20120327051714.GB20897@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194019>

$COLUMNS must be unset to not interfere with the tests. The tests
already ignore the terminal size because output is redirected to a
file, but COLUMNS overrides terminal size detection and changes the
test output away from the standard 80.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
Right, it is better to unset $COLUMNS globally. t4016 was also affected=
=2E

 t/test-lib.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 30ed4d7..b7d7100 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -46,7 +46,7 @@ EDITOR=3D:
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
-unset VISUAL EMAIL LANGUAGE $(perl -e '
+unset VISUAL EMAIL LANGUAGE COLUMNS $(perl -e '
 	my @env =3D keys %ENV;
 	my $ok =3D join("|", qw(
 		TRACE
--=20
1.7.10.rc1.222.gc0040.dirty
