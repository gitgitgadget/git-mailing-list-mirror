From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: sanitize more git environment variables
Date: Wed, 26 Jan 2011 15:33:32 -0500
Message-ID: <20110126203331.GA27478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 21:33:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiC3g-0004Nn-7c
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab1AZUde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 15:33:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51867 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab1AZUdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 15:33:33 -0500
Received: (qmail 8465 invoked by uid 111); 26 Jan 2011 20:33:32 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 26 Jan 2011 20:33:32 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jan 2011 15:33:32 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165537>

These variables should generally not be set in one's
environment, but they do get set by rebase, which means
doing an interactive rebase like:

  pick abcd1234 foo
  exec make test

will cause false negatives in the test suite.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 42f2f14..0fdc541 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -70,6 +70,9 @@ unset GIT_NOTES_REF
 unset GIT_NOTES_DISPLAY_REF
 unset GIT_NOTES_REWRITE_REF
 unset GIT_NOTES_REWRITE_MODE
+unset GIT_REFLOG_ACTION
+unset GIT_CHERRY_PICK_HELP
+unset GIT_QUIET
 GIT_MERGE_VERBOSITY=5
 export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
-- 
1.7.0.9.7.g36b59
