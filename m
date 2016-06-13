From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] repack: document --unpack-unreachable option
Date: Mon, 13 Jun 2016 00:33:54 -0400
Message-ID: <20160613043354.GA3902@sigill.intra.peff.net>
References: <20160613043313.GA29422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 06:34:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCJZb-0006dE-MC
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 06:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbcFMEeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 00:34:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:53591 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbcFMEd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 00:33:59 -0400
Received: (qmail 23399 invoked by uid 102); 13 Jun 2016 04:33:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:33:56 -0400
Received: (qmail 10017 invoked by uid 107); 13 Jun 2016 04:34:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:34:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 00:33:54 -0400
Content-Disposition: inline
In-Reply-To: <20160613043313.GA29422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297150>

This was added back in 7e52f56 (gc: do not explode objects
which will be immediately pruned, 2012-04-07), but not
documented at the time, since it was an internal detail
between git-gc and git-repack. However, as people with
complicated setups may want to effectively reimplement the
steps of git-gc themselves, it is nice for us to document
these interfaces.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-repack.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index b9c02ce..cde7b44 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -128,6 +128,12 @@ other objects in that pack they already have locally.
 	with `-b` or `repack.writeBitmaps`, as it ensures that the
 	bitmapped packfile has the necessary objects.
 
+--unpack-unreachable=<when>::
+	When loosening unreachable objects, do not bother loosening any
+	objects older than `<when>`. This can be used to optimize out
+	the write of any objects that would be immediately pruned by
+	a follow-up `git prune`.
+
 Configuration
 -------------
 
-- 
2.9.0.rc2.149.gd580ccd
