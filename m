From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] strbuf.h: drop asciidoc list formatting from API docs
Date: Fri, 16 Jan 2015 04:05:10 -0500
Message-ID: <20150116090510.GC31113@peff.net>
References: <20150116090225.GA30797@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 10:05:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC2qG-0003kc-70
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 10:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbbAPJFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 04:05:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:35422 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751272AbbAPJFM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 04:05:12 -0500
Received: (qmail 2927 invoked by uid 102); 16 Jan 2015 09:05:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:05:12 -0600
Received: (qmail 23464 invoked by uid 107); 16 Jan 2015 09:05:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:05:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:05:10 -0500
Content-Disposition: inline
In-Reply-To: <20150116090225.GA30797@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262542>

Using a hanging indent is much more readable. This means we
won't format as asciidoc anymore, but since we don't have a
working system for extracting these comments anyway, it's
probably more important to just make the source readable.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 74 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index fd57e45..ab5ff27 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -13,44 +13,44 @@
  *
  * strbufs have some invariants that are very important to keep in mind:
  *
- * . The `buf` member is never NULL, so it can be used in any usual C
- * string operations safely. strbuf's _have_ to be initialized either by
- * `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
- * +
- * Do *not* assume anything on what `buf` really is (e.g. if it is
- * allocated memory or not), use `strbuf_detach()` to unwrap a memory
- * buffer from its strbuf shell in a safe way. That is the sole supported
- * way. This will give you a malloced buffer that you can later `free()`.
- * +
- * However, it is totally safe to modify anything in the string pointed by
- * the `buf` member, between the indices `0` and `len-1` (inclusive).
+ *  - The `buf` member is never NULL, so it can be used in any usual C
+ *    string operations safely. strbuf's _have_ to be initialized either by
+ *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
  *
- * . The `buf` member is a byte array that has at least `len + 1` bytes
- *   allocated. The extra byte is used to store a `'\0'`, allowing the
- *   `buf` member to be a valid C-string. Every strbuf function ensure this
- *   invariant is preserved.
- * +
- * NOTE: It is OK to "play" with the buffer directly if you work it this
- *       way:
- * +
- * ----
- * strbuf_grow(sb, SOME_SIZE); <1>
- * strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
- * ----
- * <1> Here, the memory array starting at `sb->buf`, and of length
- * `strbuf_avail(sb)` is all yours, and you can be sure that
- * `strbuf_avail(sb)` is at least `SOME_SIZE`.
- * +
- * NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.
- * +
- * Doing so is safe, though if it has to be done in many places, adding the
- * missing API to the strbuf module is the way to go.
- * +
- * WARNING: Do _not_ assume that the area that is yours is of size `alloc
- * - 1` even if it's true in the current implementation. Alloc is somehow a
- * "private" member that should not be messed with. Use `strbuf_avail()`
- * instead.
- */
+ *    Do *not* assume anything on what `buf` really is (e.g. if it is
+ *    allocated memory or not), use `strbuf_detach()` to unwrap a memory
+ *    buffer from its strbuf shell in a safe way. That is the sole supported
+ *    way. This will give you a malloced buffer that you can later `free()`.
+ *
+ *    However, it is totally safe to modify anything in the string pointed by
+ *    the `buf` member, between the indices `0` and `len-1` (inclusive).
+ *
+ *  - The `buf` member is a byte array that has at least `len + 1` bytes
+ *    allocated. The extra byte is used to store a `'\0'`, allowing the
+ *    `buf` member to be a valid C-string. Every strbuf function ensure this
+ *    invariant is preserved.
+ *
+ *    NOTE: It is OK to "play" with the buffer directly if you work it this
+ *    way:
+ *
+ *    ----
+ *    strbuf_grow(sb, SOME_SIZE); <1>
+ *    strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+ *    ----
+ *    <1> Here, the memory array starting at `sb->buf`, and of length
+ *    `strbuf_avail(sb)` is all yours, and you can be sure that
+ *    `strbuf_avail(sb)` is at least `SOME_SIZE`.
+ *
+ *    NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.
+ *
+ *    Doing so is safe, though if it has to be done in many places, adding the
+ *    missing API to the strbuf module is the way to go.
+ *
+ *    WARNING: Do _not_ assume that the area that is yours is of size `alloc
+ *    - 1` even if it's true in the current implementation. Alloc is somehow a
+ *    "private" member that should not be messed with. Use `strbuf_avail()`
+ *    instead.
+*/
 
 /**
  * Data Structures
-- 
2.2.1.425.g441bb3c
