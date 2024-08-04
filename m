Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1DD50269
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780694; cv=none; b=opRLZk2df+qF5jySnAxNRwJHnTlDt9KcZ2AiWqqM2xHmuLi/xXjQE7r6H8o2algti93CI/QssmS4o+uL807Ts2KMMDUelX8iyQ3a9hPIzsDpA//YVOdM8s4+7lGNK1APt8bm7dsyanQz6042DH4UJJXeNHo1DiHGtPVArexmRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780694; c=relaxed/simple;
	bh=6dcZwXz7GFp7iAldfAYFiGDg1AfVonu0hu3Z6u9wQN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brTd5NXs/3JmkwCoQ9uj3CtHXlt2yo2VCh5oJUtNkVz229ssVVynkzXoad6Pvw+ET9ef6psd0yITcDlD99OW6lL/5ZwgDlQd/WAy3vOQiQlJIsGzK5qQUm/qhki0YH+1Bu5qvoxbZDl9SjDPnCHgh0t/uGNhFQAQ0T77oN5b7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLPr6m+a; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLPr6m+a"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d18112b60so3670559b3a.1
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722780692; x=1723385492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIDjQDvcxNu4l7Bz0MrT/RMIwMtJCJpsOd0bgbZFxZ8=;
        b=VLPr6m+a9OvUKDLUufjh34Oj4WGae0UKp3V3QPbyuHNnd6TPo7kNk2liuzUwaIxLMK
         WhnYetvLBhYGb19HVTeu7GcS/UfXnrfK1uz/EzgOaLexKC6PNvEmALfdv3qgF0L5asU3
         uyvH2+b0wgJwOt5LWuyNWPMjFbfjMxr/eIHMi7R9f7EZSegnqQGndGtpV4PagLod1Rj0
         2vtxQ257Iu8kapUu53v3Ff1ITvqJpYsbRdmokYpYzjvDfdep2WN7LNE2zrpAGjJ+LDC7
         7LKZH/CkGSyxGdESSLCuzlJKVAluLFjiLKWc3tLSWas9h2yClAFjEOktVL84FKYpRSq/
         GyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722780692; x=1723385492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIDjQDvcxNu4l7Bz0MrT/RMIwMtJCJpsOd0bgbZFxZ8=;
        b=OH7tuNOMKGpDovbNACa9Wn/MqbaYSriR3n0zZPSOdtlelTb/SyERrrJwIihYkW3RdI
         ps8bKbuxjl9mpDLWq0ySSJGuopi/7BrG6KZ3pOhlpohpjupMMxztpCdEcZcPq1jeSA7H
         RY3PtmoeORufceXzGhzz0+ziedR9uMOjkKkn4FvPBOlNOcViz5sfIsg+Nk7JnI6mLtBP
         CSIzyd5qrDC8HiL1X0GAfKlRYzAwkqqoLiHq2YTRyAJ7Jv930pxRm+QMJVcm1OGWz4Au
         EFa9pQJkJFawf71mxlR7x8rifvztDTWrXZHlKSPIMejqjiXy6DwJcOvX52SYMtvFnP7V
         mH8Q==
X-Gm-Message-State: AOJu0Yy3+kBeqxlLoEYZRUE7re5lGT38JBpnaGngMQF1X7JlyFKi0ylj
	NCulOgwTr0aFbi36r4RDnVrA9dw8E8ewN9khxLgsrDOFDqOEN0nGXz/TgIUX
X-Google-Smtp-Source: AGHT+IG2g/+u1DjIIiIbJp4Fp6uDuHQK+f6hBumb6TtWJtlozVN0pKrhfllF8gXCEDnK1VsI4ueDlQ==
X-Received: by 2002:aa7:830b:0:b0:70c:e1ec:4233 with SMTP id d2e1a72fcca58-71065e4c8aemr12647069b3a.6.1722780691636;
        Sun, 04 Aug 2024 07:11:31 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.183])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec269d2sm4125047b3a.17.2024.08.04.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:11:31 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 1/5] reftable: remove unnecessary curly braces in reftable/tree.c
Date: Sun,  4 Aug 2024 19:36:45 +0530
Message-ID: <20240804141105.4268-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240804141105.4268-1-chandrapratap3519@gmail.com>
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
 <20240804141105.4268-1-chandrapratap3519@gmail.com>
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

