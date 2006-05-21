From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Make '@' not valid in a ref name.
Date: Sat, 20 May 2006 21:37:51 -0400
Message-ID: <20060521013751.GA7516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:38:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhctL-0005L9-79
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWEUBh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWEUBh4
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:37:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:26577 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932161AbWEUBh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 21:37:56 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fhct5-0005Bn-8r; Sat, 20 May 2006 21:37:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E94F212691; Sat, 20 May 2006 21:37:52 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20421>

Now that the sha1 expression syntax supports looking up a ref's
value at a prior point in time through the '@' operator the '@'
operator should not be permitted in a ref name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

90d3212d5351d2f6c6ad33578c9f9df2e07af12e
 refs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

90d3212d5351d2f6c6ad33578c9f9df2e07af12e
diff --git a/refs.c b/refs.c
index eeb1196..2530c99 100644
--- a/refs.c
+++ b/refs.c
@@ -213,14 +213,14 @@ int get_ref_sha1(const char *ref, unsign
  *
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
- * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
+ * - it has ASCII control character, "@", "~", "^", ":" or SP,
  * - it ends with a "/".
  */
 
 static inline int bad_ref_char(int ch)
 {
 	return (((unsigned) ch) <= ' ' ||
-		ch == '~' || ch == '^' || ch == ':' ||
+		ch == '@' || ch == '~' || ch == '^' || ch == ':' ||
 		/* 2.13 Pattern Matching Notation */
 		ch == '?' || ch == '*' || ch == '[');
 }
-- 
1.3.3.gfad60
