Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA481E5B88
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777086; cv=none; b=QyqO7cYNEkqAztiyAIjPMj4YBG35GpT7AUKYommGAtBtF3/Uy1YNIBUs6Q0NVa0fiJFcZMo4peXyTUWn+1kRgeOkslNnSYmcYjRdio5qE+xfUyP9dgGu/kBSP5mSqpZib67nblFErr+QLP9zPd5FSqsxgsz8SepPzLKG7smYduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777086; c=relaxed/simple;
	bh=d3O264YOAPhSs3LowgQv+OytQy4Jom6SpOx2HWimA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7bH9C7xZtsqYvM5fYjqYn7WdhAk9Q6aB8NCy75yrGAcZ8N/E13woboIfdhoLXH6w/pdgAOZppUJ/FmVAQtit1ACh9eSWwNv89IxJrLcWToxg6xaIs/8Cq+JJTFijJ5wKdBsflq1yXOG3wPs/SY7eAISma+rXmRW9Qb8VXtE/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X06T+Mzs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X06T+Mzs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so8617345e9.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783777083; x=1784381883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=X06T+Mzsk2GunsBSltyI8eE8GSZYdlKW6wh1HIMdSh0fb9l6fBVbv+05pBClaeLha4
         EuaqSci0SwASnUlpFGV1Ww1/UFPOQ3EXYRqjnD/VBzkyfO3LXuTYKrPBwdh5Ps7CWpPt
         5TNph9mBAgzVRErNrnWD4CXDNzAtJzgr+8QZ2tnqUs5f8iC9bGDPQm9IIR4e1jvgnWQx
         X55zPXj/dJl5D5zpP5kHQSn00Zo20SYVa7BW2voy3LO6NJBg4hYuqeOEBTizi1lZR1wK
         DyeMZEbNBf14LPq7uoTaKbDxVZzBjQDe2gF0Q1f8TE8fHjKi+8WEhEpNVyPocO9o/Al5
         bc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783777083; x=1784381883;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=abSyFqg8mtYumRoGlfm40P3/dqueLkuvoL0w7KDnNznGZwVvrf3nfN209x6ouxup4I
         4UigTnRIiSRzz/ZvbMh3gl3M4wRR+R5uGGyc91a6Rqml9bBrv2YrNV6oNgoSbpFzGF+0
         99tsDE+x+btoKfEd/+SCSAa6QkH7XQS9g1V0l2GO44GH5e2sw3Pw0+GNZq35xtURn07T
         MbOBulixYZvQ2lohjuql+sZGB2/IQu9uKBOfvkvlMbBO/gc/qx+UGAvQXyAlWn+IWmYP
         RW9XXY7ih808kMFhgfUpJwrFhhNTv60HM9O0+dqSiDp0BwrS/uf1z/fqKU50p5QeOZxF
         0KPA==
X-Gm-Message-State: AOJu0YwBRA5XlyLJ12olZhEzQydgZZjtzyfT/Ex2D9vzMetI7uqWTNb+
	CJO/nYkp6OsgvaB7AVBtv8IE9Cyy5Pu2AU+gCkoJSB69+OeNeOKPKD6rvxc2R9BY
X-Gm-Gg: AfdE7cm+qwPR+RN+VX7Q0eKIDP7Qihnl46iqg9TyFyRHsiNTfu913zOO+y7JZrNQEEs
	CIbOEjfLviR3WBd9lCWju8viTKYAQ2Y3F3ZBLE6HFGcVTliP++EMX1rywIbw3+1EmK8actt2TH8
	yET/cQ2MJjQOP5vX6SjZUj12EwFqyHE3jlgmxa1+WNJLAKo2z7O/cV365QiyiKWBj0bZqvNDyqs
	QJgzm/hvB1Ej0yDiB0NphzUW6sv/6JzOmLhWKpWUtrGivqimupwMV/Xe6SnvBKf4iS3ukTevRDt
	7A8+SV5jlSL8T7hGFNigoXX+cJK3GWsJEdd10PYxmzAJ4jbMrFvsKcUhgIb13p/39+Dyd1q0E+m
	T6QZQ6GSX07Op/yTioPmqsWxxX1GCrjUebUq3EFCFaeQ6udZURPcQC5IkHl5qLiHY6PzNhtUsR5
	PSeQ/AW7AQFi86OLgjJ7DYa9zoAlh38cqXILRXaRMK26VhAMU19i5UKMtb1/Y3TnhYZUsYhlQ/O
	Kvtb4f0uqqd+r4hAGb6snXq2w8PJxq4/Azdz6E7Laf0ZXAY4YbKxNN1xLQO3LWJHANLs1S/THSd
	nBXuOiBCr0SkJNW80Kkw3SyfLV8CfgeBVi8KbiGNVm4mQaY/zooUcrdJvQas+Ongi0XVtEolZRl
	c+Ui7F2DzyMVpKR4NZAlR
X-Received: by 2002:a05:600c:674a:b0:493:f80c:5455 with SMTP id 5b1f17b1804b1-493f87d85a9mr27092055e9.5.1783777082984;
        Sat, 11 Jul 2026 06:38:02 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm220999015e9.10.2026.07.11.06.38.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 06:38:02 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v9 2/4] revision: add next_commit_to_show()
Date: Sat, 11 Jul 2026 15:37:51 +0200
Message-ID: <20260711-ps-pre-commit-indent-v9-2-eab6676e82f7@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

get_revision() gets its commits from two sources depending on the mode:

1. Normally it gets the commits from get_revision_internal().

2. --max-count-oldest which was introduced at bb4ce23284 (revision.c:
   implement --max-count-oldest, 2026-05-19) gets the commits by popping
   from a saved list at revs->commits marking SHOWN and CHILD_SHOWN on
   each popped commit.

Extract the choice logic into a helper, next_commit_to_show(), which
returns the next commit regardless of the source it comes from.

This has no change in behavior. The helper is needed in a subsequent
commit that pre-fetches two commits into a buffer for lookahead purposes
and needs to pre-fetch from the same source.

The --reverse branch keeps its own pop loop. Using the helper for
--reverse would additionally set SHOWN and CHILD_SHOWN which is not
desired and a behavior change.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 revision.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/revision.c b/revision.c
index 0c95edef59..288935943f 100644
--- a/revision.c
+++ b/revision.c
@@ -4658,12 +4658,34 @@ static void retrieve_oldest_commits(struct rev_info *revs,
 		commit_list_insert(c, queue);
 }
 
+/*
+ * Returns the next commit that will be shown, regardless of whether it comes
+ * directly from the revision walk or from the list saved by the staged output
+ * of --max-count-oldest.
+ */
+static struct commit *next_commit_to_show(struct rev_info *revs)
+{
+	struct commit *c;
+	struct commit_list *p;
+
+	if (!revs->max_count_stage)
+		return get_revision_internal(revs);
+
+	c = pop_commit(&revs->commits);
+	if (c) {
+		c->object.flags |= SHOWN;
+		if (!(c->object.flags & BOUNDARY))
+			for (p = c->parents; p; p = p->next)
+				p->item->object.flags |= CHILD_SHOWN;
+	}
+	return c;
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c;
 	struct commit_list *reversed;
 	struct commit_list *queue = NULL;
-	struct commit_list *p;
 
 	if (revs->max_count_type == 1 && !revs->max_count_stage) {
 		retrieve_oldest_commits(revs, &queue);
@@ -4693,17 +4715,7 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	if (revs->max_count_stage) {
-		c = pop_commit(&revs->commits);
-		if (c) {
-			c->object.flags |= SHOWN;
-			if (!(c->object.flags & BOUNDARY))
-				for (p = c->parents; p; p = p->next)
-					p->item->object.flags |= CHILD_SHOWN;
-		}
-	} else {
-		c = get_revision_internal(revs);
-	}
+	c = next_commit_to_show(revs);
 
 	if (c && revs->graph)
 		graph_update(revs->graph, c);

-- 
2.54.0
