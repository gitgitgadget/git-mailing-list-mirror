From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 13/19] tree-diff: diff_tree() should now be static
Date: Mon, 24 Feb 2014 20:21:45 +0400
Message-ID: <dcab79b62b86dea995828195ec8a7693d487d385.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHn-0003qk-PD
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbaBXQVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:21:36 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34243 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbaBXQVg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:36 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyHe-00040h-LY; Mon, 24 Feb 2014 20:21:34 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyJJ-0007A3-Qp; Mon, 24 Feb 2014 20:23:17 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242602>

We reworked all its users to use the functionality through
diff_tree_sha1 variant in recent patches (see "tree-diff: allow
diff_tree_sha1 to accept NULL sha1" and what comes next).

diff_tree() is now not used outside tree-diff.c - make it static.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

 ( new patch )

 diff.h      | 2 --
 tree-diff.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/diff.h b/diff.h
index e79f3b3..5d7b9f7 100644
--- a/diff.h
+++ b/diff.h
@@ -189,8 +189,6 @@ const char *diff_line_prefix(struct diff_options *);
 
 extern const char mime_boundary_leader[];
 
-extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
-		     const char *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *base,
diff --git a/tree-diff.c b/tree-diff.c
index 2fd6d0e..b99622c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -137,8 +137,8 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 	}
 }
 
-int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
-	      const char *base_str, struct diff_options *opt)
+static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
+		     const char *base_str, struct diff_options *opt)
 {
 	struct strbuf base;
 	int baselen = strlen(base_str);
-- 
1.9.rc1.181.g641f458
