Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053317BA7
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629184; cv=none; b=OrEwT82t8g1Zu9g1vh8/VUUQd8UnRPZoq60L+FL4yPjygNDOHwfXuVr4qlurxjUmPh7iJtZWlrmIuGC7BRtKUmw1BlgvJpHRwiCO2fPMoY2F9ppety5PhsZpW3KazMDiebgnuhkXgUXQShYmiH9VphEKv7aqL/vdhQZKyvo6uVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629184; c=relaxed/simple;
	bh=6dcZwXz7GFp7iAldfAYFiGDg1AfVonu0hu3Z6u9wQN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7869EiEsVzQ/f1PVJwMB50VtEB3uiNAirwbLwZhEiKfg/3gpE16VOzFGJ00Kc9bIlbB0NOWQZVmuj/hea0UDTXmCtlT/szp6xYayAgWVEFZ0OFh32G0ZJ3TMOdhdlr/+dtjDkhHs4W4XIUk+mmPA0yDcn/sxwAX0A6ExB5PGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwQcg2Il; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwQcg2Il"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa9ecfb321so25173535ad.0
        for <git@vger.kernel.org>; Sun, 21 Jul 2024 23:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721629182; x=1722233982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIDjQDvcxNu4l7Bz0MrT/RMIwMtJCJpsOd0bgbZFxZ8=;
        b=CwQcg2IlYmyv58dhgJyw+JWsHrsgxKGH2X3xdWtbnWVofSpC9Uoeq5FvoQADDCUspw
         biV3OiRosxWfp6Khvb5tfvkpVNg7ncGQ8UoMujV/D9zhYPFdpNKBR7wY0NoqbYrxGuSe
         LFrux/NR5e7DhIIj92T/U9lgH1CtEGb2SX7+fnIjcwpnHEsrLwmqR6FSx3NzAA5n2d6C
         P+jHNfTcN/b9lbbKV/zBZ5TsHUi8HXd/f8RY5mb3uj8craqeodQZhpjfzt16kkMC9g/9
         MGdgQ7GyeBHvsAKhnQCjaMhU7tEgJj1mysUowL9enMMa9a0BJpsc6IvIg6YTLMLOMPFN
         VghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721629182; x=1722233982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIDjQDvcxNu4l7Bz0MrT/RMIwMtJCJpsOd0bgbZFxZ8=;
        b=AhkCyA5rS2M1qciCau87xlzwqtNJH3PTO1cElICHlbnBr1vdxwZJi+xkNsndpx38/i
         iJbVUMRtPIOp6GYtoqqyQRhO7gUnXDwEQQOyoltyDQa4n4+1G5Afhqo6EoZ1RndufvEs
         GB0h4IOzbHzw4MD+qD+POJZe6EM4dvM96SlFFt7CSglBsEYrQVvPBjdPkpQW5Y2eA/u/
         w/5vMFdmrfCQn+oCSRxUE3WYKUsLEUpgWXq7OTMuJNFDTtj6+CPINq1tdFoGhEPHYJpa
         g6cw4L43VzApfITh+PI+Yl2SjGnqJgaAm+pDI7TQJOw39vt5TaoM9UYNW3CoFQ562Tfp
         vKeQ==
X-Gm-Message-State: AOJu0YwmgT6OO3MsYQE/mVCSveqC1+FJ9FvG4aDmXA2fHR7FMi1ox0QL
	zWP+N8u/tNmCv+xELg5bsGfS1jAxNU4kw8TJYMiPAp1+8uG8glVu9xh+Grw+q60=
X-Google-Smtp-Source: AGHT+IGW1G58HzjLSG4jJo5KcxBWs9QbzjB8hKu299863ThZS8FEmHaQhfWVHFwpJ+knR8lvGOYH+g==
X-Received: by 2002:a17:902:e5ce:b0:1fd:8bed:6645 with SMTP id d9443c01a7336-1fd8bed6b8emr19603595ad.61.1721629181439;
        Sun, 21 Jul 2024 23:19:41 -0700 (PDT)
Received: from Ubuntu.. ([106.220.63.154])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f31a73csm46362885ad.143.2024.07.21.23.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:19:41 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v5 1/5] reftable: remove unnecessary curly braces in reftable/tree.c
Date: Mon, 22 Jul 2024 11:27:54 +0530
Message-ID: <20240722061836.4176-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240722061836.4176-1-chandrapratap3519@gmail.com>
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
 <20240722061836.4176-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/CodingGuidelines, single-line control-flow
statements must omit curly braces (except for some special cases).
Make reftable/tree.c adhere to this guideline.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/tree.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/reftable/tree.c b/reftable/tree.c
index 528f33ae38..5ffb2e0d69 100644
--- a/reftable/tree.c
+++ b/reftable/tree.c
@@ -39,25 +39,20 @@ struct tree_node *tree_search(void *key, struct tree_node **rootp,
 void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
 		void *arg)
 {
-	if (t->left) {
+	if (t->left)
 		infix_walk(t->left, action, arg);
-	}
 	action(arg, t->key);
-	if (t->right) {
+	if (t->right)
 		infix_walk(t->right, action, arg);
-	}
 }
 
 void tree_free(struct tree_node *t)
 {
-	if (!t) {
+	if (!t)
 		return;
-	}
-	if (t->left) {
+	if (t->left)
 		tree_free(t->left);
-	}
-	if (t->right) {
+	if (t->right)
 		tree_free(t->right);
-	}
 	reftable_free(t);
 }
-- 
2.45.GIT

