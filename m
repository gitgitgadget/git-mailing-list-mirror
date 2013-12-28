From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t0000: drop "known breakage" test
Date: Sat, 28 Dec 2013 04:33:40 -0500
Message-ID: <20131228093340.GC21109@sigill.intra.peff.net>
References: <20131228092731.GA26337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 28 10:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwqHD-0001Va-D8
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 10:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab3L1Jdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 04:33:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:51498 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752550Ab3L1Jdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 04:33:42 -0500
Received: (qmail 1083 invoked by uid 102); 28 Dec 2013 09:33:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Dec 2013 03:33:43 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Dec 2013 04:33:40 -0500
Content-Disposition: inline
In-Reply-To: <20131228092731.GA26337@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239764>

Having a simulated "known breakage" test means that the test
suite will always tell us there is a bug to be fixed, even
though it is only simulated.

The right way to test this is in a sub-test, that can also
check that we provide the correct exit status and output.
Fortunately, we already have such a test (added much later
by 5ebf89e).

We could arguably get rid of the simulated success test
immediately above, as well, as it is also redundant with the
tests added in 5ebf89e. However, it does not have the
annoying behavior of the "known breakage" test. It may also
be easier to debug if the test suite is truly broken, since
it is not a test-within-a-test, as the later tests are.

Signed-off-by: Jeff King <peff@peff.net>
---
I am not _that_ bothered by the "known breakage", but AFAICT there is
zero benefit to keeping this redundant test. But maybe I am missing
something.

 t/t0000-basic.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index e6c5b63..a2bb63c 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -41,9 +41,6 @@ test_expect_success '.git/objects should have 3 subdirectories' '
 test_expect_success 'success is reported like this' '
 	:
 '
-test_expect_failure 'pretend we have a known breakage' '
-	false
-'
 
 run_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
-- 
1.8.5.1.399.g900e7cd
