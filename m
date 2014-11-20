From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] t4026: test "normal" color
Date: Thu, 20 Nov 2014 10:16:09 -0500
Message-ID: <20141120151609.GC23680@peff.net>
References: <20141120151418.GA23607@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:16:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTSz-0004IK-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbaKTPQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:16:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:42772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756527AbaKTPQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:16:12 -0500
Received: (qmail 11691 invoked by uid 102); 20 Nov 2014 15:16:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:16:11 -0600
Received: (qmail 13045 invoked by uid 107); 20 Nov 2014 15:16:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:16:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:16:09 -0500
Content-Disposition: inline
In-Reply-To: <20141120151418.GA23607@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user specifiers "normal" for a foreground color, this
should be a noop (while this may sound useless, it is the
only way to specify an unchanged foreground color followed
by a specific background color).

We also check that color "-1" does the same thing. This is
not documented, but has worked forever, so let's make sure
we keep supporting it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4026-color.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 3726a0e..63e4238 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -53,6 +53,14 @@ test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
 
+test_expect_success '"normal" yields no color at all"' '
+	color "normal black" "[40m"
+'
+
+test_expect_success '-1 is a synonym for "normal"' '
+	color "-1 black" "[40m"
+'
+
 test_expect_success 'color too small' '
 	invalid_color "-2"
 '
-- 
2.2.0.rc2.402.g4519813
