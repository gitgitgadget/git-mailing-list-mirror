From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] repack: make parsed string options const-correct
Date: Wed, 22 Jan 2014 20:28:30 -0500
Message-ID: <20140123012830.GB19472@sigill.intra.peff.net>
References: <20140123012656.GC17254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 02:28:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W695w-0007Pd-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 02:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbaAWB2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 20:28:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:37237 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752659AbaAWB2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 20:28:32 -0500
Received: (qmail 5705 invoked by uid 102); 23 Jan 2014 01:28:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jan 2014 19:28:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jan 2014 20:28:30 -0500
Content-Disposition: inline
In-Reply-To: <20140123012656.GC17254@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240890>

When we use OPT_STRING to parse an option, we get back a
pointer into the argv array, which should be "const char *".
The compiler doesn't notice because it gets passed through a
"void *" in the option struct.

Signed-off-by: Jeff King <peff@peff.net>
---
Not a big deal, but just for consistency with the next patch.

 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 528725b..7f89c7c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -129,7 +129,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	/* variables to be filled by option parsing */
 	int pack_everything = 0;
 	int delete_redundant = 0;
-	char *unpack_unreachable = NULL;
+	const char *unpack_unreachable = NULL;
 	int window = 0, window_memory = 0;
 	int depth = 0;
 	int max_pack_size = 0;
-- 
1.8.5.2.500.g8060133
