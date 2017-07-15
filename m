Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82022082F
	for <e@80x24.org>; Sat, 15 Jul 2017 20:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbdGOUBA (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 16:01:00 -0400
Received: from mout.web.de ([212.227.17.12]:58788 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbdGOUA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 16:00:59 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MF3nL-1dPYY92TaV-00GFYG; Sat, 15
 Jul 2017 22:00:46 +0200
Subject: [PATCH 2/2] use MOVE_ARRAY
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5f4f0479-8e77-bec4-e982-2c7f37e70e7c@web.de>
Date:   Sat, 15 Jul 2017 22:00:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WAgUACu8Z5El6ingWaRCCUhcsV6RPD5BSgANT4u5OK+r99pqHYL
 LPQbo2BG2gAK4czDKH1pzFw/Y44OLRz+M18mupIT3UvIpTC3Bm6/AWwcb4fMdB6QW97JhQM
 zTVqlNStmoGf//lBGznA0NbpTHVPl7L6zyvgVxUSpvDyRxhB6bB6bNbYK4TzktvZzTO/sqm
 a3nRvq7k2xqzRf/i7r+7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A38a/stTRxg=:ghsyJbT7LZfSZZc+l0J7E/
 XuBK7tgRSKmGTU38uOQ5uPIk8cplB/vCSivCD4nsD0/EKG94l4ssK5aheKzv9imGwRnuyz2pd
 dG5kjD+U9sQNqxnZh+ZmK4ViE2LoFvl3VrnlnWGY71rTN6boYMMu5y46aqnqAOBy16SrHJLZG
 04LlmQz0jcT7LI8g6ANZCbpeKFZ7w47XKmVwfLyoaCT1jAc1Sr4+yqNabJpltcN7da92gr5TH
 lcdsC+c6WENFE9OKmntvAZjrS0nKuS6HKsSep348GZ0dc6Za+CGuWHrnlwzFHeoroGcfWAddW
 x8+r3zd8mkS4Hi9VrJCyq8wyMBDkxApsHxtZ2bWkfeiDP8iUNhDR1dRvr3Z4gRWMJqyoo9ByH
 jbfIVcFVGw8Wq/3HCA7ugzFadvWgwZmTRWvEe4cooVJZj10VAHEWIl0+gdXiolGPw2qrhBp3a
 X8o+JnODG/DhJ8o9I5mn0npBva5FjU0oKw81xfY6WzVpRB+xPBYI19ythPQq2FoJfHdNqJ3h+
 pjKDdPo4xR80jDEmFo+ky8LbH+0MKjVejFE4JxDK9CHhsWD1NI8psr3PZodeSGeaIhn/dsBPW
 wPbOXkm5J6mJ9DJa4wnTlMet9va01Vcrp0CZfIWEQRc2K1jW16KoaqDaoQ46CxD6AsfPl3ELj
 7WtpDvh13Uf0ECL9loPZ0Hm0oijx32dZRBXSzpUQ7lW5DTAIAj8cy62JHOL8M/5ZToQOSzzke
 oR0sGTbamIvADeCwrx4gERP6aGVv50Il0w8dqF12pUOxWmRl0YLbQVWBp+g7dE88RDP/e4ss1
 IoRoJbeTLyfeREnYqX/uSzSftDTCnTfYa/sHhBlS9jxpp9gw5k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the code for moving members inside of an array and make it more
robust by using the helper macro MOVE_ARRAY.  It calculates the size
based on the specified number of elements for us and supports NULL
pointers when that number is zero.  Raw memmove(3) calls with NULL can
cause the compiler to (over-eagerly) optimize out later NULL checks.

This patch was generated with contrib/coccinelle/array.cocci and spatch
(Coccinelle).

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Downside: The one in builtin/ls-files.c papers over a report by UBSan
for the case of istate->cache being NULL.  Technically we still try to
add pos to NULL if pruning an empty index, but we won't see it anymore.
Will send a separate patch.

 builtin/ls-files.c     | 3 +--
 builtin/merge.c        | 2 +-
 builtin/pack-objects.c | 5 ++---
 cache-tree.c           | 5 ++---
 commit.c               | 5 ++---
 notes-merge.c          | 3 +--
 read-cache.c           | 5 ++---
 reflog-walk.c          | 7 +++----
 string-list.c          | 8 +++-----
 9 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b8514a0029..dc4a6aa3d9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -378,8 +378,7 @@ static void prune_index(struct index_state *istate,
 		}
 		last = next;
 	}
-	memmove(istate->cache, istate->cache + pos,
-		(last - pos) * sizeof(struct cache_entry *));
+	MOVE_ARRAY(istate->cache, istate->cache + pos, last - pos);
 	istate->cache_nr = last - pos;
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 900bafdb45..d5797b8fe7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -537,7 +537,7 @@ static void parse_branch_merge_options(char *bmo)
 		die(_("Bad branch.%s.mergeoptions string: %s"), branch,
 		    split_cmdline_strerror(argc));
 	REALLOC_ARRAY(argv, argc + 2);
-	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
+	MOVE_ARRAY(argv + 1, argv, argc + 1);
 	argc++;
 	argv[0] = "branch.*.mergeoptions";
 	parse_options(argc, argv, NULL, builtin_merge_options,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f4a8441fe9..e730b415bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1298,9 +1298,8 @@ static int check_pbase_path(unsigned hash)
 		   done_pbase_paths_alloc);
 	done_pbase_paths_num++;
 	if (pos < done_pbase_paths_num)
-		memmove(done_pbase_paths + pos + 1,
-			done_pbase_paths + pos,
-			(done_pbase_paths_num - pos - 1) * sizeof(unsigned));
+		MOVE_ARRAY(done_pbase_paths + pos + 1, done_pbase_paths + pos,
+			   done_pbase_paths_num - pos - 1);
 	done_pbase_paths[pos] = hash;
 	return 0;
 }
diff --git a/cache-tree.c b/cache-tree.c
index ec23d8c03d..2440d1dc89 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -131,9 +131,8 @@ static int do_invalidate_path(struct cache_tree *it, const char *path)
 			 * move 4 and 5 up one place (2 entries)
 			 * 2 = 6 - 3 - 1 = subtree_nr - pos - 1
 			 */
-			memmove(it->down+pos, it->down+pos+1,
-				sizeof(struct cache_tree_sub *) *
-				(it->subtree_nr - pos - 1));
+			MOVE_ARRAY(it->down + pos, it->down + pos + 1,
+				   it->subtree_nr - pos - 1);
 			it->subtree_nr--;
 		}
 		return 1;
diff --git a/commit.c b/commit.c
index cbfd689939..d3150d6270 100644
--- a/commit.c
+++ b/commit.c
@@ -223,9 +223,8 @@ int unregister_shallow(const struct object_id *oid)
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < commit_graft_nr)
-		memmove(commit_graft + pos, commit_graft + pos + 1,
-				sizeof(struct commit_graft *)
-				* (commit_graft_nr - pos - 1));
+		MOVE_ARRAY(commit_graft + pos, commit_graft + pos + 1,
+			   commit_graft_nr - pos - 1);
 	commit_graft_nr--;
 	return 0;
 }
diff --git a/notes-merge.c b/notes-merge.c
index 70e3fbeefb..c12b354f10 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -99,8 +99,7 @@ static struct notes_merge_pair *find_notes_merge_pair_pos(
 	else {
 		*occupied = 0;
 		if (insert_new && i < len) {
-			memmove(list + i + 1, list + i,
-				(len - i) * sizeof(struct notes_merge_pair));
+			MOVE_ARRAY(list + i + 1, list + i, len - i);
 			memset(list + i, 0, sizeof(struct notes_merge_pair));
 		}
 	}
diff --git a/read-cache.c b/read-cache.c
index 2121b6e7bb..acfb028f48 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -515,9 +515,8 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
 		return 0;
-	memmove(istate->cache + pos,
-		istate->cache + pos + 1,
-		(istate->cache_nr - pos) * sizeof(struct cache_entry *));
+	MOVE_ARRAY(istate->cache + pos, istate->cache + pos + 1,
+		   istate->cache_nr - pos);
 	return 1;
 }
 
diff --git a/reflog-walk.c b/reflog-walk.c
index 081f89b70d..81bca2ed23 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -111,10 +111,9 @@ static struct commit_info *get_commit_info(struct commit *commit,
 			struct commit_info *result = &lifo->items[i];
 			if (pop) {
 				if (i + 1 < lifo->nr)
-					memmove(lifo->items + i,
-						lifo->items + i + 1,
-						(lifo->nr - i) *
-						sizeof(struct commit_info));
+					MOVE_ARRAY(lifo->items + i,
+						   lifo->items + i + 1,
+						   lifo->nr - i);
 				lifo->nr--;
 			}
 			return result;
diff --git a/string-list.c b/string-list.c
index c650500c6e..806b4c8723 100644
--- a/string-list.c
+++ b/string-list.c
@@ -43,9 +43,8 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 	ALLOC_GROW(list->items, list->nr+1, list->alloc);
 	if (index < list->nr)
-		memmove(list->items + index + 1, list->items + index,
-				(list->nr - index)
-				* sizeof(struct string_list_item));
+		MOVE_ARRAY(list->items + index + 1, list->items + index,
+			   list->nr - index);
 	list->items[index].string = list->strdup_strings ?
 		xstrdup(string) : (char *)string;
 	list->items[index].util = NULL;
@@ -77,8 +76,7 @@ void string_list_remove(struct string_list *list, const char *string,
 			free(list->items[i].util);
 
 		list->nr--;
-		memmove(list->items + i, list->items + i + 1,
-			(list->nr - i) * sizeof(struct string_list_item));
+		MOVE_ARRAY(list->items + i, list->items + i + 1, list->nr - i);
 	}
 }
 
-- 
2.13.3
