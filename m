Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3221E2892
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600871; cv=none; b=XrnTU9Kx4SlZ1/wdYKQ85LcmBwR0FKKhTtrFdYR2IivPe/+ajO8R+X1SpLitI6raGTj5KH9dc0gRKFiT6bUtEgNgSF6BJoy7hmDRJJWeikrOPHK8yW9UgJjJrsfUpsDO2SXuOwvCzQLhSdRd7eX/p8DtQQZxSFgXUvFrlff1Qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600871; c=relaxed/simple;
	bh=6dcZwXz7GFp7iAldfAYFiGDg1AfVonu0hu3Z6u9wQN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYjs+4di6p3hmOv9EAJtJs7jeoB1LlEhA7c7HGvgpZrpVlBLriSiI6LePAVgbXui0sAocuwPLNwFDFpzQ3NHhYs9qJ09OF8zxYo6Z4tnyD5qYCKAc2LG4/kx5zs0KT1N4KUhB8jkbUBoppyH3jPDSFBJLFz37iTSNQEnBDgQ2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg8cb0As; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg8cb0As"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7104f939aa7so2557817b3a.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 05:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722600869; x=1723205669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIDjQDvcxNu4l7Bz0MrT/RMIwMtJCJpsOd0bgbZFxZ8=;
        b=eg8cb0Asmv9A/gWiIPton7s79PyBEB6Ht3DmObD6otkEmZ/H2GyVZYihh8y3hdOg0C
         +7BgJ9MRkBf1+5tTeds6D0QX9twchzgqLbwDIl09QZ5ee8RjKV6wwfeYmuA3EDiwlz9o
         S6TkWdMcmdxDhXRv5KLrjMITi4+5AkYDOtoqjn7fL7OVRge2LPtu8UBhplHfLMGlEO7N
         PmbDrVnMHEhzZF8bWFrBi00bNya4d4gY5XG78gNU65xyXpVCcVdQerLxAtKk+j0hmmp9
         pGI0s2C9DVXfyGe2bN6DoUtmP/cvBs9Mmgb1MWsPUgdaUOu0/dgpVc7sgYpiH35AeOAN
         JSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722600869; x=1723205669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIDjQDvcxNu4l7Bz0MrT/RMIwMtJCJpsOd0bgbZFxZ8=;
        b=JhUKRlF922ABLEEpmx9h1l8KP43g/zGrGahaz3yvYv0g1mSE8H7aOs5+vc7nuVTNhy
         7qz3lTKDn28sQsgfQR2WZ4tmczh3vigiivHtbdM6XL1AS32Y/8BGl86fssd6uqxCkqhL
         Peeqj+AGBBCEhWXyUiuQvcqefvBVLZiZl5jqUsyY9SfCYwNp1LN0KFJ4noZoEpLcy7JP
         TAA9PRDfUdLKlqn1J/CpBbYVpfbm8igyj1G4lmmVhr/Xx6vFUAZt2F5YwHPoRh+Tpvs2
         FWiHuwRcZ0BxWYm68MBGgWUQKg4zkMhJ6kB95tyfOaK2B9xCv0clX0Mdf2swVQV6Uh9m
         Kb9g==
X-Gm-Message-State: AOJu0YzQui8aq5yTzxFwy1gbVUywOWxyJmL32jOOmtztRr7Adgzxy4y/
	mD38JJxzwhI8zk9mv7ajT/dBiaHSOwL+9FlTexSTRt6HQbTKAvXzVT7U+w==
X-Google-Smtp-Source: AGHT+IGlPaHoPXVtHAB0XZqTIy411povLM0QEepbSII1dt3tA+Nl+Tg4D5ao20eOAkoQTr+oLBEs8w==
X-Received: by 2002:a05:6a20:9f86:b0:1be:e1e1:d5de with SMTP id adf61e73a8af0-1c6995ab96fmr4170449637.30.1722600868309;
        Fri, 02 Aug 2024 05:14:28 -0700 (PDT)
Received: from Ubuntu.. ([106.213.168.25])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec16034sm1294534b3a.15.2024.08.02.05.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:14:27 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 1/5] reftable: remove unnecessary curly braces in reftable/tree.c
Date: Fri,  2 Aug 2024 17:38:04 +0530
Message-ID: <20240802121318.4583-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240802121318.4583-1-chandrapratap3519@gmail.com>
References: <20240722061836.4176-1-chandrapratap3519@gmail.com>
 <20240802121318.4583-1-chandrapratap3519@gmail.com>
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

