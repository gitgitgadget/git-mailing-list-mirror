From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 4/5] merge: make function try_merge_command non static
Date: Thu, 25 Mar 2010 05:58:16 +0100
Message-ID: <20100325045818.14832.7391.chriscool@tuxfamily.org>
References: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:03:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufES-0002Gs-CQ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab0CYFDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:03:24 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49343 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab0CYFDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:03:23 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 56B9C818083;
	Thu, 25 Mar 2010 06:03:14 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 233CE818036;
	Thu, 25 Mar 2010 06:03:12 +0100 (CET)
X-git-sha1: 8395b588190d86a47413a99b94cd3df7dec79957 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143155>

and while at it let's move declaration of checkout_fast_forward()
into "merge-recursive.h" instead of "cache.h"

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/merge.c   |    4 ++--
 cache.h           |    3 ---
 merge-recursive.h |    4 ++++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f163d53..fc240f9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -548,8 +548,8 @@ static void write_tree_trivial(unsigned char *sha1)
 		die("git write-tree failed to write a tree");
 }
 
-static int try_merge_command(const char *strategy, struct commit_list *common,
-			     const char *head_arg, struct commit_list *remotes)
+int try_merge_command(const char *strategy, struct commit_list *common,
+		      const char *head_arg, struct commit_list *remotes)
 {
 	const char **args;
 	int i = 0, x = 0, ret;
diff --git a/cache.h b/cache.h
index ded3090..f7e501e 100644
--- a/cache.h
+++ b/cache.h
@@ -1056,7 +1056,4 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
 
-/* builtin/merge.c */
-int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
-
 #endif /* CACHE_H */
diff --git a/merge-recursive.h b/merge-recursive.h
index be8410a..8640c00 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -53,4 +53,8 @@ int merge_recursive_generic(struct merge_options *o,
 void init_merge_options(struct merge_options *o);
 struct tree *write_tree_from_memory(struct merge_options *o);
 
+/* builtin/merge.c */
+int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
+int try_merge_command(const char *strategy, struct commit_list *common, const char *head_arg, struct commit_list *remotes);
+
 #endif
-- 
1.7.0.2.398.g89bc8ce
