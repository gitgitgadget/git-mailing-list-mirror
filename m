Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9916395DB8
	for <git@vger.kernel.org>; Sun, 24 May 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779644550; cv=none; b=I77bjbQnwC9vTZEYblkXAfswp2PH3rFx9YxxTsd01gilSOowKNtTHHEs96aIIen2U+sHf6lH6nb3a9Oei+uFrVuVW0fum7Cyw8ygJ5fJ+IrWofD8cBSFERrtUZyvxA0gejQx1rxv3IaoWTdq4w9qzdooaM6aWFVczZoom4zLGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779644550; c=relaxed/simple;
	bh=yu+yEZOCCVkRInQ3f7RBsxJHdOFARRsbSxMXLJaPW4Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rbJFcstEixyczKVK9sqlSuq9jwc/4wVj77MH1+WvTJZ8dnX/ioR0PCUtS7D1a7ABs0SXvzvT0vcYcttZ3X4lyoDH5ICkE2hQLZZMibQKlKNoy520Lcyi9MUWCpgrr1wSwV16FUR6Qe/enIUevkU881eOLgHOaDht0DSBOAYo8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEPnYueY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEPnYueY"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b4000e51fdso99842326d6.1
        for <git@vger.kernel.org>; Sun, 24 May 2026 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779644548; x=1780249348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4Gc0Hae9+3EIppu6xUxu7z/Fnoo0QpIC3M3q6iZKBU=;
        b=ZEPnYueYgs1zEeH+PbudqpfJGnpFZh0R111ZGy+hhJdmcoVPIHTwnkK4v5RjpABZJj
         fagkkLbdNMRedmakMCsa8RsXbgKYyxzGVfbwNkz0Z4S944Z1c3kHFcs0p0eybzpqWoXM
         xb2SpESearBqSVxPNWV9UAuCoikXuW5PbVHckBjpESKs3LxOZzIPzeBI0SgFTBs7VFBH
         a5q84KsDEfkpHiStpBKxKbDxEWRqelDKDIa9NbqipXUma/Y8PJlFAX87FbSg9YfF9BtD
         HiXGQE3rfmGfTtXZc+rv1pipJ7wKmU9SQ5NiW9wWHoLmlxcfQe4msgydSa1v1/uEh15H
         dOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779644548; x=1780249348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4Gc0Hae9+3EIppu6xUxu7z/Fnoo0QpIC3M3q6iZKBU=;
        b=YAsNXCSsuvf6NOxeT/FTmf1Ji6NyaSYLTDmfbnDvd23XlwiqIxOdF2VnDJRXzfTeQe
         mLjRcU6vwzLNJrXZvFJtruthZqUpJMdU1Chod6w3UDz/0j96thtFSE1wZrDhItPOLR92
         GVF8fe87fJB/WMe5CvKA3BZuWtyoLCG17Ft+dwXDahao3Sh1VKtIKJqYZjU5kp7CKvhP
         O7FRe07GpqKyBovtHXu75QHYYEPr9E8+JMMMUP7oyJNf+58QluPj5mNc0q4c7LY0WJRv
         FKe5eMmeWCanK8od2vrpN5NKrqRnRVvjgVVGxmrLwHl9YZmQzDqgMqTl3mEYUwHry+xC
         Ca1g==
X-Gm-Message-State: AOJu0YzsHA5I9YOeCcE/zr42vLXhYGnO9G/ZQxC13Gqllp74kK/+MD1B
	jsVDRAb+Qk21dYsB5Vx1RB71ZQ+aCf5N3tbDlvvMDCe0MhcLdBSo6m9/rKbuZQzJ
X-Gm-Gg: Acq92OHPHi2IMyFnFyIEtg1HoWMbc349W3uoRxfpjJylbX4dPljfBb/Lc0d131Y4qPr
	DScz0GpfqDIwe75lQD3kasz8nA7HKxVl10k0O+brMKUkSE2f85pCenU+tZKr4ePXykRuB91i+SY
	VBnvzR+FsYh8jsvp7I1Z/+YgKG4hgBHyswJGUDB90EDc6a9nic2N2y+csB/fisC5QxiPUEw3NJt
	WIvC8Jb8jGBu4+s+sFb0O0zNcYO/SGvLSvTWRi+sBfExOyXTLlBVzr5lBySgCJPYp6LEjPe3GbX
	WDS7PxjxxDZoOtynBYZRBL84wyeFPMwPJYxJOfKS52IbymkD5um1+S72B4bkQ5E7VmrTy/1akzs
	3YAR13tIMU4q9d/nP5KW+b8BvPLF7tCuJJnBFMM3w1OFEstxyzYU7LtfaQO19qvP1Gx8p3g75si
	ivpwHTY3xDI0E5CPtW8HAUNWUClnlZltynrOuF
X-Received: by 2002:a05:6214:c88:b0:8be:35bd:8273 with SMTP id 6a1803df08f44-8cc7b616dd9mr177536376d6.12.1779644546795;
        Sun, 24 May 2026 10:42:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.235.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131eaeasm87272716d6.44.2026.05.24.10.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 10:42:25 -0700 (PDT)
Message-Id: <4742f5e634b55820f3b5a626ec97e24617fdae3d.1779644541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 17:42:19 +0000
Subject: [PATCH 2/3] commit-reach: optimize queue scan in paint_down_to_common
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

paint_down_to_common() terminates when every commit remaining in its
priority queue is STALE. This was checked by queue_has_nonstale(),
which performed an O(n) linear scan of the entire queue on every
iteration, resulting in O(n*m) total overhead where n is the queue
size and m is the number of commits processed.

Replace this with an O(1) nonstale_count that tracks the number of
non-stale commits currently in the queue. The counter is incremented
by maybe_enqueue() and decremented on dequeue and by mark_stale()
when a commit transitions to STALE while still in the queue. Since
each commit appears at most once (guaranteed by the ENQUEUED flag
from the previous commit), the counter is exact.

ahead_behind() also uses queue_has_nonstale() and will be converted
in the next commit.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index c16d4b061c..356ff52d08 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -40,12 +40,25 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	return 0;
 }
 
-static void maybe_enqueue(struct prio_queue *queue, struct commit *c)
+static void maybe_enqueue(struct prio_queue *queue, struct commit *c,
+			  int *nonstale_count)
 {
 	if (c->object.flags & ENQUEUED)
 		return;
 	c->object.flags |= ENQUEUED;
 	prio_queue_put(queue, c);
+	if (!(c->object.flags & STALE))
+		(*nonstale_count)++;
+}
+
+static void mark_stale(struct commit *c, unsigned queued_flag,
+		       int *nonstale_count)
+{
+	if (!(c->object.flags & STALE)) {
+		if (c->object.flags & queued_flag)
+			(*nonstale_count)--;
+		c->object.flags |= STALE;
+	}
 }
 
 static int queue_has_nonstale(struct prio_queue *queue)
@@ -68,6 +81,7 @@ static int paint_down_to_common(struct repository *r,
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	int i;
+	int nonstale_count = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
@@ -79,20 +93,22 @@ static int paint_down_to_common(struct repository *r,
 		commit_list_append(one, result);
 		return 0;
 	}
-	maybe_enqueue(&queue, one);
+	maybe_enqueue(&queue, one, &nonstale_count);
 
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
-		maybe_enqueue(&queue, twos[i]);
+		maybe_enqueue(&queue, twos[i], &nonstale_count);
 	}
 
-	while (queue_has_nonstale(&queue)) {
+	while (nonstale_count > 0) {
 		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
 
 		commit->object.flags &= ~ENQUEUED;
+		if (!(commit->object.flags & STALE))
+			nonstale_count--;
 
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
@@ -134,8 +150,10 @@ static int paint_down_to_common(struct repository *r,
 				return error(_("could not parse commit %s"),
 					     oid_to_hex(&p->object.oid));
 			}
+			if (flags & STALE)
+				mark_stale(p, ENQUEUED, &nonstale_count);
 			p->object.flags |= flags;
-			maybe_enqueue(&queue, p);
+			maybe_enqueue(&queue, p, &nonstale_count);
 		}
 	}
 
-- 
gitgitgadget

