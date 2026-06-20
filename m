Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563A37B003
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781950325; cv=none; b=nUz/5YOFvkEgM93IbFforq5sXKtE499tnDtyOZ2OFqvbRwuT7RNRZryUQB3NrZc7Pf3qToZHEBCl49Y379LDDvGC0OsCj4HRE5piGGZiQ2I74KhaK4Lqko+dDo6nnxIFCzAazgQkKU1jlm82gPFRhvTXOHbxktTq9Jk/r6AuOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781950325; c=relaxed/simple;
	bh=VoJBM2TaCWZbnqdxQzbQM14K34l+2aq66X3EB565jLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa4jspZStNPklmWKMEQZTotOhW0QujUcKre4dcZAXObPwc46z7GDTTcFI/SCKF8FaV05hLIE0zsgjOp1h03WSJgvwfbOwcKeBlSMUSVJR+5aEjxDbNwJpANnGPE3tP5PjGLC1HObWH5tWwFbN7FdIWjLoB6JzqNm3sbowbHsomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8wBT4qf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8wBT4qf"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4624c1409c9so2122125f8f.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781950322; x=1782555122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtJAgboXYp4yoTCrPA7OE0CSyW9xN43DqI4/D9hAmL8=;
        b=C8wBT4qfiV5P/YGUpKg3WbrUfDDR4++qyCmZuR/5dhHYr09zjYAzEaK9qfS8bWNQKi
         aZVN3jZEwSiZv0j+XmjA16HRyYYz4vGtPEPZ1RUi0yOeTbruPXDX28x4sNHMVMTAAWa7
         5cEA46xrebO3KbvQVnBcu/EwwsVRJraOVQk4hBHgHUC6tpggJS7iW6bsGAFuOdf4zVLI
         a0Vcp2MebGTg//iAffj9VN4PLT9nTb74wNVzHf5aDpvUszV39hPoF0xBnmvuKhB0gG63
         y8xr3XLaHiCfuCkDPkoAtfZa3IGh+tXEP/sPzLWV//KKs5Vr/pHyDiRRjY27TU62PyCE
         ZsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781950322; x=1782555122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rtJAgboXYp4yoTCrPA7OE0CSyW9xN43DqI4/D9hAmL8=;
        b=p3IurZW2poqqm8zJUy+tEjLnbegeKLXzxqlaDMRm+dRfy89Zazng4AKxEla1ashmQd
         ilE19dTZD5m2tY0iCrDYFgH0GtSA6lxZPtYazSOIpG8sZ07lrrGZF/PIh88Qi8melWAj
         ef+TNQsI18Rz/mQB2OXH5INmhFuxlGE+xyZNsU0wn+F7T68bYKZSuOXQDosv9nWb0Z2h
         FiL3PmP3xjmQ9SEW44D20FkGn3oI/Ss+2fhrOboH8mfM9/R/kHBKByOf7NU0Iau4tYYA
         LeU7RCE75iFpe9Hnxsed+cCL5+Ou5oOOj9UMBg6vlKP8BvkbfvonJL4pvIfGOyykBa/l
         hLSw==
X-Gm-Message-State: AOJu0YxjQGchrzjCFwa6E0dfqZhAYUUObOL8lquKcXO5KNxdr/5gjY/U
	vY23Mm6kJC6GJ6g+4L8/pUu/Nw5Jtj+RWlMxTukNQVqvTI31BEuOg7trAQD4vfAx
X-Gm-Gg: AfdE7ckPrr5zKpdA3M5LsXL1/heMaWdRLShl0ZJffdOi4UJh//9IdO5tL/INc4Oz1Ef
	XnjkGfIpcr8zboEXB/W7ziXc5TuqojQUpFW9xjl5DoL2My5F1YR/93zuIkO/kYLQU57LCye+oAg
	5rYD/2QASqXy9rmeZNnOucXJMlIOxkfSwh1HiyZiyZUwMb6Q2rGW9HgLYwoJj3o7/3uOfB3EZ9e
	9r9r4wf22QkPkgKCiqUyzific8J79n8bi5ckBZznZZw3TurFwXk6tRDoopl1Nubj2AhAV2tf06U
	twuJ02PI+18ZTIinMFdg91noBm2X5kbVa27YRvuZ8Ycao8Gq2pd+ipjsiPOWkdidPzcupZwf4GD
	+5OXmpxfXU/IOOCu93lmJmN2cFlPS0jB1Vnhlg/EYIrqvOPv++wnaAqbbzkApfWgv/Rox6gf0Y3
	LOByt7Ig52TeZgGSPOIFozTc/yW38+0fkCgo53V1a5nhkj+g+gF/0PG1Xn1LH2OHsCCySAzNZoS
	Gj/xOl1Q3uqV/AfXx6ewHY0mhVQJp5ARb2VC2+7swClVynMDEfJIrMXTTZzoRPh8BEySma9VVdl
	w5lgJGf5G+RzK9aTGxgiY3RZ0+xJ3Lg7i0EOtzd7H4xbp4sYotE/uv3D
X-Received: by 2002:a05:600c:6211:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-492490af44amr40002315e9.27.1781950321902;
        Sat, 20 Jun 2026 03:12:01 -0700 (PDT)
Received: from localhost.localdomain ([89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1f886sm126350925e9.4.2026.06.20.03.12.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Jun 2026 03:12:01 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: krka@spotify.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	pabloosabaterr@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com,
	Kristofer Karlsson <stoansen@gmail.com>
Subject: [PATCH v6 2/3] revision: add peek functions for lookahead
Date: Sat, 20 Jun 2026 12:11:51 +0200
Message-ID: <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The graph code in a subsequent commit needs to be able to look ahead in
order to set indentation-related flags.

Using revs->commits is brittle and the data structure that holds the
pending commits might change in the future.

Add two functions that abstract this for the graph.

Helped-by: Kristofer Karlsson <stoansen@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 revision.c | 38 ++++++++++++++++++++++++++++++++++++++
 revision.h | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/revision.c b/revision.c
index e91d7e1f11..a472a28853 100644
--- a/revision.c
+++ b/revision.c
@@ -3708,6 +3708,44 @@ static unsigned int count_explore_walked;
 static unsigned int count_indegree_walked;
 static unsigned int count_topo_walked;
 
+struct commit *revision_peek_next_commit (struct rev_info *revs)
+{
+	struct topo_walk_info *info = revs->topo_walk_info;
+
+	if (info)
+		return prio_queue_peek(&info->topo_queue);
+	if (revs->commits)
+		return revs->commits->item;
+
+	return NULL;
+}
+
+int revision_has_commits_after (struct rev_info *revs, int n)
+{
+	struct topo_walk_info *info = revs->topo_walk_info;
+
+	if (info) {
+		int visible = 0;
+		for (size_t i = 0; i < info->topo_queue.nr && visible < n; i++) {
+			struct commit *c = info->topo_queue.array[i].data;
+			if (get_commit_action(revs, c) == commit_show)
+				visible++;
+		}
+		return visible > n-1;
+	}
+	if (revs->commits) {
+		struct commit_list *cl;
+		int visible = 0;
+		for (cl = revs->commits; cl && visible < n; cl = cl->next) {
+			if (get_commit_action(revs, cl->item) == commit_show)
+				visible++;
+		}
+		return visible > n-1;
+	}
+
+	return 0;
+}
+
 static void trace2_topo_walk_statistics_atexit(void)
 {
 	struct json_writer jw = JSON_WRITER_INIT;
diff --git a/revision.h b/revision.h
index 00c392be37..a10c6b0940 100644
--- a/revision.h
+++ b/revision.h
@@ -572,4 +572,14 @@ int rewrite_parents(struct rev_info *revs,
  */
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
+/*
+ * Peek into revision's next commit without consuming it.
+ */
+struct commit *revision_peek_next_commit(struct rev_info *revs);
+
+/*
+ * Check if there are n more commits to be shown yet.
+ */
+int revision_has_commits_after(struct rev_info *revs, int n);
+
 #endif

-- 
2.54.0
