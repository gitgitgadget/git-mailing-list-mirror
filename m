From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] document 'agent' protocol capability
Date: Wed, 24 Jul 2013 04:03:13 -0400
Message-ID: <20130724080313.GC4425@sigill.intra.peff.net>
References: <20130724080051.GA3890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 10:03:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1u2e-0004A0-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 10:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab3GXIDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 04:03:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:36974 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab3GXIDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 04:03:17 -0400
Received: (qmail 23434 invoked by uid 102); 24 Jul 2013 08:03:16 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 03:03:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 04:03:13 -0400
Content-Disposition: inline
In-Reply-To: <20130724080051.GA3890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231086>

This was added in ff5effd (include agent identifier in
capability string, 2012-08-03), but neither the syntax nor
the semantics were ever documented outside of the commit
message.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/protocol-capabilities.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 9bc2a10..d35159e 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -22,7 +22,8 @@ The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
 recognized by the receive-pack (push to server) process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
-by both upload-pack and receive-pack protocols.
+by both upload-pack and receive-pack protocols.  The 'agent' capability
+may optionally be sent in both protocols.
 
 All other capabilities are only recognized by the upload-pack (fetch
 from server) process.
@@ -123,6 +124,20 @@ send/read OBJ_OFS_DELTA (aka type 6) in a packfile.
 its base by position in pack rather than by an obj-id.  That is, they can
 send/read OBJ_OFS_DELTA (aka type 6) in a packfile.
 
+agent
+-----
+
+The server may optionally send a capability of the form `agent=X` to
+notify the client that the server is running version `X`. The client may
+optionally return its own agent string by responding with an `agent=Y`
+capability (but it MUST NOT do so if the server did not mention the
+agent capability). The `X` and `Y` strings may contain any printable
+ASCII characters except space (i.e., the byte range 32 < x < 127), and
+are typically of the form "package/version" (e.g., "git/1.8.3.1"). The
+agent strings are purely informative for statistics and debugging
+purposes, and MUST NOT be used to programatically assume the presence
+or absence of particular features.
+
 shallow
 -------
 
-- 
1.8.3.rc1.30.gff0fb75
