From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2 2/2] t0303: resurrect commit message as test documentation
Date: Wed, 14 Mar 2012 15:18:24 +0100
Message-ID: <1331734704-14281-2-git-send-email-zbyszek@in.waw.pl>
References: <20120314141401.GC28595@in.waw.pl>
 <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 15:18:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7p2W-0002Fj-51
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454Ab2CNOSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 10:18:49 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55767 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964930Ab2CNOSs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:18:48 -0400
Received: from escher.fuw.edu.pl ([193.0.82.249])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S7p2J-0008Md-K8; Wed, 14 Mar 2012 15:18:44 +0100
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193110>

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
---
 t/t0303-credential-external.sh |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-extern=
al.sh
index 4479bf8..136da1e 100755
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
1.7.9.1
