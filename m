Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F439A4BA
	for <git@vger.kernel.org>; Sun, 24 May 2026 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779644551; cv=none; b=kq2DFd/bMR9R79Hq24cdZcGSgLzqNFTbN6twVrGoekM+zgkdHKDZDbvvYTAqOekwl6L4vaRMAF9Q/8kWeazccHqUhaX6YdnbVAw+cZfZaquTI4N7aNA73ElhFVQU4Eja1Eoteyn1vbVMnsz/vU68Igff1qHonTiFr63pUTq5Mn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779644551; c=relaxed/simple;
	bh=Tzf7MyHSZXtpC5HS5UWvumYPHkx2G+DS6+AmajDJY7Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dJY34FwfKbJG26/CY1efXrKuVTHlzTsX2V9hlrIpiOGrCIW43UigzZwMN0qv60+AgG/hmsu3yJltQ3fnPo6GNhDPSWpvegras5LKGP2+cnKdWFlGno68vzW+xnB8zT7i6mlkVfOJ19mgAOZlo/Lnwa5HZ0xdjV3VaDxiBOPMIL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmuuxkNh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmuuxkNh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso137524696d6.1
        for <git@vger.kernel.org>; Sun, 24 May 2026 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779644549; x=1780249349; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V0o4kw0ZuOEd29AlytYMOPlJqVzjswVAdppPVOw/oA=;
        b=dmuuxkNhdwVdyL5rCBPmKRGKcKftLyMj11LbkTuAmQaYYxChMtjld80ASttXhk8ze6
         97qW9YILg+lRIyYGCGejZCaoaQbdp6GM62KzUvd+WS0lvpTMdsieUFVBi/blDSaLNGBD
         0QxXB1txom8ugJdilTL+AGQg3ktMk0Jq5JQMvgRqyWauuzdeq6mxqooY+3+zpYUCyhpQ
         NNRC0A0kZsegm8AI2jX1LxW/oMaX43kFGCmYXU2+qFcAcnZuqWIpljGOLSpg1XAVqmVH
         xEyYW6ku7nDCjztip5mmKApwSYlt/xMdH4owTuRwpn2CjmEk2xVMl17lwUAO5b+TtrIg
         o/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779644549; x=1780249349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3V0o4kw0ZuOEd29AlytYMOPlJqVzjswVAdppPVOw/oA=;
        b=nvoMTQyBlNMPPfbz5WQtjbsoeLYohVntZmgZwORpoZAdeIdlC0FVBJSBDYUQKy8R0r
         ajrobx6kA8LEB+FbUiC9AI0PsC7OZATbH2gpcqV6zhqyaQ3pYe2ze//i9v9yMiVW6NK7
         ES8tX7qVhoEfuHeDJItS9nt6+hxQ2MSDbCKOXjmFVqP66zzCMmo7O4yQS1Wnbx9C4fDa
         ygsH+sT04L6PXW/iauWEIW/QyZrG9Y+yQ4eX1NuvJpm+42PuanSPLnoKDu4El5yhe8sr
         M6ZZpaRafW5OO6YWylWwyvSBhSwbtoaK7UJHOogfJMTE4hGEm8cBwMwNelKjWZJj39eA
         +w/Q==
X-Gm-Message-State: AOJu0Ywm/5n/4YJMNxCz2UiCvKbR6vkkI6CtB8VGdDeHswRtdUOCmY/x
	tE5ZX2dQWfsHOZaipcWlek3YHvxt/csijksb/V/8kRFF6iOSvIfrFEFTpHzi4DBs
X-Gm-Gg: Acq92OFgAnByse8r/bN2+4JM6fO8LNDz2Zvmvd7KiQaB0omqMoIjXhk16ocASvvs8Ch
	/60J/KpHe9bsOD18tr5NCm1ISPQgkAwNxrRMREPc6W0lqU9jDeTiZd7o3m+CCt8rt7ArFC1VMnP
	+tJvrK3gnE5z/gbl2d4zybILannxdyXHz9kYk4QEPg01a9y77ihLQH5mhD+o1hAzQDJOprESVSK
	Agem4jepTHJ3g80QJXGbQEzOoq6kmiQTnYRCQdDw6enO3Kb4oRCDw3jBlZkpFQF2SPxHdhZH1NW
	0Lhh2CeWbwFJRpPQXW+ZMJG6K9IsUz+bSueddmz7MBqvdBFposNEdn3xzxX/vsMyCYU2xTVMleV
	JpemHB34JZQ0KEt3C84PbGM9JhwmJKS/3ppmmtbxU65MiuV+mQJZfKyuKY0n7TlshguCjohlcXn
	km8ojubtHuD8MPA3ngpA8T/YX/Cg==
X-Received: by 2002:a05:6214:4306:b0:8c2:7cc5:b5d5 with SMTP id 6a1803df08f44-8cc6e694af4mr209365116d6.17.1779644547910;
        Sun, 24 May 2026 10:42:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.235.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm88119086d6.38.2026.05.24.10.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 10:42:27 -0700 (PDT)
Message-Id: <711a0e2235103489f17ff867439e007abd0e4291.1779644541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 17:42:20 +0000
Subject: [PATCH 3/3] commit-reach: optimize queue scan in ahead_behind
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Apply the same nonstale_count optimization from the previous commit
to ahead_behind(). This replaces the remaining caller of the O(n)
queue_has_nonstale() scan with an O(1) counter check, allowing
queue_has_nonstale() to be removed.

ahead_behind() already deduplicates queue entries using the PARENT2
flag (via insert_no_dup), so the counter is maintained through
insert_no_dup() and mark_stale() using PARENT2 as the queued_flag.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 356ff52d08..41deb8fc78 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -61,16 +61,6 @@ static void mark_stale(struct commit *c, unsigned queued_flag,
 	}
 }
 
-static int queue_has_nonstale(struct prio_queue *queue)
-{
-	for (size_t i = 0; i < queue->nr; i++) {
-		struct commit *commit = queue->array[i].data;
-		if (!(commit->object.flags & STALE))
-			return 1;
-	}
-	return 0;
-}
-
 /* all input commits in one and twos[] must have been parsed! */
 static int paint_down_to_common(struct repository *r,
 				struct commit *one, int n,
@@ -1051,12 +1041,15 @@ struct commit_list *get_reachable_subset(struct commit **from, size_t nr_from,
 define_commit_slab(bit_arrays, struct bitmap *);
 static struct bit_arrays bit_arrays;
 
-static void insert_no_dup(struct prio_queue *queue, struct commit *c)
+static void insert_no_dup(struct prio_queue *queue, struct commit *c,
+			  int *nonstale_count)
 {
 	if (c->object.flags & PARENT2)
 		return;
 	prio_queue_put(queue, c);
 	c->object.flags |= PARENT2;
+	if (!(c->object.flags & STALE))
+		(*nonstale_count)++;
 }
 
 static struct bitmap *get_bit_array(struct commit *c, int width)
@@ -1082,6 +1075,7 @@ void ahead_behind(struct repository *r,
 {
 	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
 	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
+	int nonstale_count = 0;
 
 	if (!commits_nr || !counts_nr)
 		return;
@@ -1100,14 +1094,17 @@ void ahead_behind(struct repository *r,
 		struct bitmap *bitmap = get_bit_array(c, width);
 
 		bitmap_set(bitmap, i);
-		insert_no_dup(&queue, c);
+		insert_no_dup(&queue, c, &nonstale_count);
 	}
 
-	while (queue_has_nonstale(&queue)) {
+	while (nonstale_count > 0) {
 		struct commit *c = prio_queue_get(&queue);
 		struct commit_list *p;
 		struct bitmap *bitmap_c = get_bit_array(c, width);
 
+		if (!(c->object.flags & STALE))
+			nonstale_count--;
+
 		for (size_t i = 0; i < counts_nr; i++) {
 			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
 			int reach_from_base = !!bitmap_get(bitmap_c, counts[i].base_index);
@@ -1136,9 +1133,9 @@ void ahead_behind(struct repository *r,
 			 * queue is STALE.
 			 */
 			if (bitmap_popcount(bitmap_p) == commits_nr)
-				p->item->object.flags |= STALE;
+				mark_stale(p->item, PARENT2, &nonstale_count);
 
-			insert_no_dup(&queue, p->item);
+			insert_no_dup(&queue, p->item, &nonstale_count);
 		}
 
 		free_bit_array(c);
-- 
gitgitgadget
