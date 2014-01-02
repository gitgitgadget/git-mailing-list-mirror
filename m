From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] name-hash: retire unused index_name_exists()
Date: Thu,  2 Jan 2014 16:57:12 -0500
Message-ID: <1388699832-4075-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 02 22:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyqHO-0004FT-E6
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbaABV6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:58:09 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:54661 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbaABV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:58:07 -0500
Received: by mail-ig0-f169.google.com with SMTP id hk11so42460780igb.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 13:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=0NklSXgoGI2nzYNRLBGiXKFtFDTNUU9o+Wgakhb8dXw=;
        b=QMQ0swLYpWh2z1XHO/4Ds3ZffFIoaIvnVjKtd+I6Jr3VFsnvELXOt8m2o7pFwyutgW
         wtW2qnkkhA2rPBXaZlQyQ4RPpp5irdwJNmcko5k7nW45G9a1sfnZAQ6cXi0JNdwjCa+z
         XqWiQsAGaJI8hMR0Ow07Kw/Jx3HORcD6WoP1eKru/XxOZbUOkxWIM/8/i3F7Pa2+b0Tt
         ck4o9TDTWzz6xhqWmzqVOSN35NzUtNf9BJ88DbhxRJ3Cc57TxQQN+u5DHEc/zC9meFLL
         MnANSJqJExRv+A06MLYsooeq0NY9GnnKzoTygrCTU8b4qVM304uExLpWbr7MKy4fvCdf
         JHEA==
X-Received: by 10.42.208.211 with SMTP id gd19mr61475139icb.15.1388699887112;
        Thu, 02 Jan 2014 13:58:07 -0800 (PST)
Received: from floomp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id a1sm1957853igo.0.2014.01.02.13.58.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 13:58:06 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239890>

db5360f3f496 (name-hash: refactor polymorphic index_name_exists();
2013-09-17) split index_name_exists() into index_file_exists() and
index_dir_exists() but retained index_name_exists() as a thin wrapper
to avoid disturbing possible in-flight topics. Since this change
landed in 'master' some time ago and there are no in-flight topics
referencing index_name_exists(), retire it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

The only difference from v1 [1] is that a comment added by
kb/fast-hashmap in 'next' referencing obsolete index_name_exists()
is also adjusted.

[1]: http://article.gmane.org/gmane.comp.version-control.git/239575/


 cache.h     | 2 --
 name-hash.c | 9 +--------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 2a21fbc..d0d1f2b 100644
--- a/cache.h
+++ b/cache.h
@@ -316,7 +316,6 @@ extern void free_name_hash(struct index_state *istate);
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
-#define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
@@ -466,7 +465,6 @@ extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
-extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/name-hash.c b/name-hash.c
index 9a3bd3f..97444d0 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -115,7 +115,7 @@ static int cache_entry_cmp(const struct cache_entry *ce1,
 {
 	/*
 	 * For remove_name_hash, find the exact entry (pointer equality); for
-	 * index_name_exists, find all entries with matching hash code and
+	 * index_file_exists, find all entries with matching hash code and
 	 * decide whether the entry matches in same_name.
 	 */
 	return remove ? !(ce1 == ce2) : 0;
@@ -227,13 +227,6 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	return NULL;
 }
 
-struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
-{
-	if (namelen > 0 && name[namelen - 1] == '/')
-		return index_dir_exists(istate, name, namelen - 1);
-	return index_file_exists(istate, name, namelen, icase);
-}
-
 void free_name_hash(struct index_state *istate)
 {
 	if (!istate->name_hash_initialized)
-- 
1.8.3.2
