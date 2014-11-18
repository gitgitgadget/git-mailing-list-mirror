From: Jeff King <peff@peff.net>
Subject: [PATCH] t0090: mark add-interactive test with PERL prerequisite
Date: Tue, 18 Nov 2014 12:22:31 -0500
Message-ID: <20141118172231.GA16387@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:22:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqmUA-0007CP-T7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbaKRRWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:22:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:41767 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753860AbaKRRWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:22:33 -0500
Received: (qmail 20944 invoked by uid 102); 18 Nov 2014 17:22:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 11:22:33 -0600
Received: (qmail 17924 invoked by uid 107); 18 Nov 2014 17:22:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 12:22:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 12:22:31 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The add-interactive system is built in perl. If you build
with NO_PERL, running "git commit --interactive" will exit
with an error and the test will fail.

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed by Michael while working around gitweb failures by setting
NO_PERL. :)

It didn't reproduce for me in my existing build directory, presumably
because I had an old git-add--interactive build product lying around.
But running the tests in a clean clone with NO_PERL set reproduces
easily.

 t/t0090-cache-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 158cf4f..067f4c6 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -131,7 +131,7 @@ test_expect_success 'second commit has cache-tree' '
 	test_cache_tree
 '
 
-test_expect_success 'commit --interactive gives cache-tree on partial commit' '
+test_expect_success PERL 'commit --interactive gives cache-tree on partial commit' '
 	cat <<-\EOT >foo.c &&
 	int foo()
 	{
-- 
2.1.2.596.g7379948
