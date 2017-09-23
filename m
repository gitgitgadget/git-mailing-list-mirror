Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CDD2047F
	for <e@80x24.org>; Sat, 23 Sep 2017 09:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750831AbdIWJpH (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 05:45:07 -0400
Received: from mout.web.de ([217.72.192.78]:62154 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbdIWJpF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 05:45:05 -0400
Received: from [192.168.178.36] ([91.20.61.209]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZeVM-1dWU7z24RY-00lSLD; Sat, 23
 Sep 2017 11:44:59 +0200
Subject: [PATCH 2/3] refs: pass NULL to refs_resolve_ref_unsafe() if hash is
 not needed
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7ea7726d-0173-61f9-3056-939916e3f472@web.de>
Date:   Sat, 23 Sep 2017 11:44:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:D6c8ZLWbJgD3Ax5C6Pck3V6zyJLIL0dy1dXiFYttl8Sw7OM/r5a
 kMbKVslmz60nEuhZXPGWj1Yw3d/sMB/HuSrpxOAE0NRTGV5BY7A9TIefm+j2jpaKWkP5yub
 Ljlqafkg/IAjA9WJZbdYe1Fuq2TBfXtOTrJ2H91R9yPZHEQoRMGclkd6RRVQ7rju+hrnaR7
 qBb/reyCw200LNyUZbEgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8p5Vk1BKh2s=:V1kYg6Scku9rc64McdpCvP
 lwHmJ/42TBqZe+erRY5E80eF50LXBlwXqU/SmZ0ylvLr3DJGsZGY11T1Orv+PL25LE+vbFT9F
 +CFvLkXyOKyohHVWJC/rIfQJfvuUQlJ28Vx9bItIzu2dJkphQMYq4lo5tkgToEX3Mv/erp2uP
 aI1OXKKP+JGBSNu9A3oK/R6fVe+YVPPa+zEHN0qgZSz2w5xJxl/SB7zJlZCPIlhAE0h7a3Bh8
 W8uVsAKdNB2kusbpiEIVBSLt2J+DrpS3R/fCP9394sRm8n0lrzHYtKb3B1q6DSq8XiVkzhCgI
 a3C3eaDYrxhyhnFq0VpeZdE/zWOHo1cV2VV4X003Jzi/dkATsSi6V1EJ4OzeW9b2MmMXv/hSV
 VPOfj8rgqqXu7cjL54riEwZuBZ3y3NbdTxn/M5X0Q4/EZkTS55ItmS9dtLYtWcfE96varCnPa
 V6YbtQaZYHJxgYDJ7TjCgZXw7d/WJ9QcpM1KSivnx8BVhESLN5d2qA8NKuDfHOybqrXV1Mpcz
 868JBFWy37dXvGjQOZqZOueBouLtYs8CwcjGLYwjlVrx1s+TqNmsfmkkM+Hr0OWMz1s42cAYn
 1gvr8RwCJrIFurqLD/P8vD8I2B2zOXYqhXk35IWJwqP07BqXN2m79hdyGfPJzHe+o7l5AUyKw
 2VABRkxBZTvTw2SMr5u7kvVL8nK8C8fsokf/VkzPHp79HaiGN+2Na/pvUAAplpC5moMRY0Lnm
 7IxyAXoZrkMloGIoJlER9F0Du4xqd0Yu5o403UeqgxP/rYGEpEb6uJEtwg1S1B3WISQKrNDl9
 0J7BzTyckMYEKmyiHbCkrtTBhmMbYgahtBiqBsJ+ohuo7tehKA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows us to get rid of two write-only variables, one of them
being a SHA1 buffer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 refs/files-backend.c | 3 +--
 worktree.c           | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 32663a999e..a3134d23ab 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1676,13 +1676,12 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 * check with HEAD only which should cover 99% of all usage
 		 * scenarios (even 100% of the default ones).
 		 */
-		struct object_id head_oid;
 		int head_flag;
 		const char *head_ref;
 
 		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
 						   RESOLVE_REF_READING,
-						   head_oid.hash, &head_flag);
+						   NULL, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
diff --git a/worktree.c b/worktree.c
index 8aaeea0377..70015629dc 100644
--- a/worktree.c
+++ b/worktree.c
@@ -307,7 +307,6 @@ const struct worktree *find_shared_symref(const char *symref,
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
 		const char *symref_target;
-		unsigned char sha1[20];
 		struct ref_store *refs;
 		int flags;
 
@@ -327,7 +326,7 @@ const struct worktree *find_shared_symref(const char *symref,
 
 		refs = get_worktree_ref_store(wt);
 		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
-							sha1, &flags);
+							NULL, &flags);
 		if ((flags & REF_ISSYMREF) && !strcmp(symref_target, target)) {
 			existing = wt;
 			break;
-- 
2.14.1
