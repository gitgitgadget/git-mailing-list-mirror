From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v3 2/2] t0303: resurrect commit message as test documentation
Date: Thu, 15 Mar 2012 12:08:01 +0100
Message-ID: <1331809681-26113-2-git-send-email-zbyszek@in.waw.pl>
References: <4F61C828.8060506@in.waw.pl>
 <1331809681-26113-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, jrnieder@gmail.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 15 12:08:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S88Xo-0004vY-9n
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 12:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759917Ab2COLI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 07:08:26 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55806 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756802Ab2COLIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 07:08:24 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S88Xe-0000Ds-Hm; Thu, 15 Mar 2012 12:08:22 +0100
X-Mailer: git-send-email 1.7.10.rc0.160.g12d89
In-Reply-To: <1331809681-26113-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193212>

The commit message which added those tests (861444f 't: add test
harness for external credential helpers' 2011-12-10) provided nice
documentation in the commit message. Let's make it more visible
by putting it in the test description.

The documentation is updated to reflect the fact that
GIT_TEST_CREDENTIAL_HELPER must be set for
GIT_TEST_CREDENTIAL_HELPER_TIMEOUT to be used
and GIT_TEST_CREDENTIAL_HELPER_SETUP can be used.

Based-on-commit-message-by: Jeff King <peff@peff.net>
Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Acked-by: Jeff King <peff@peff.net>
---
 t/t0303-credential-external.sh |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-extern=
al.sh
index e771075..f028fd1 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -1,6 +1,34 @@
 #!/bin/sh
=20
-test_description=3D'external credential helper tests'
+test_description=3D'external credential helper tests
+
+This is a tool for authors of external helper tools to sanity-check
+their helpers. If you have written the "git-credential-foo" helper,
+you check it with:
+
+  make GIT_TEST_CREDENTIAL_HELPER=3Dfoo t0303-credential-external.sh
+
+This assumes that your helper is capable of both storing and
+retrieving credentials (some helpers may be read-only, and they will
+fail these tests).
+
+Please note that the individual tests do not verify all of the
+preconditions themselves, but rather build on each other. A failing
+test means that tests later in the sequence can return false "OK"
+results.
+
+If your helper supports time-based expiration with a configurable
+timeout, you can test that feature with:
+
+  make GIT_TEST_CREDENTIAL_HELPER=3Dfoo \
+       GIT_TEST_CREDENTIAL_HELPER_TIMEOUT=3D"foo --timeout=3D1" \
+       t0303-credential-external.sh
+
+If your helper requires additional setup before the tests are started,
+you can set GIT_TEST_CREDENTIAL_HELPER_SETUP to a sequence of shell
+commands.
+'
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
--=20
1.7.10.rc0.160.g12d89
