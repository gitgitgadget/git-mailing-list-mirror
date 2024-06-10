Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDE823DC
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025079; cv=none; b=Ha8lUoLKHsrM7zIt0NA0N1JC5KQP+S0AZl+LOcJtrrl1Kv88oTEOkrNAUn1iQRaV+58YxT3QgPqfB2aVI6XyF0s2C+PmgKfVi1ul5u7aLNz9nzYD798V6pU8BdnkeAv37Z/jw1JyP4Ogl064WOWrchGhbe0NVba6rknlncYwfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025079; c=relaxed/simple;
	bh=Vg8lr4/Bm+hHi8Pl4iOuphqxbznv+5JAh8YSrO08Rjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnF6CxhbVb+PrZSJOhUPPHd6MIr4DByPUPkQhR68JFU2O8auPVrXskA+kd3V9jn9eWU55Vh3pVtHPmd/+yenulMIabnhrCeq1iwYmGP7wMpJGr3ud+5pcaadWD5WE2RPb863QO8i+n6SPkOKAkxTbCP7rqx/Izs+evhKAcogbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTT5zCTZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTT5zCTZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70423e8e6c9so1513424b3a.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718025076; x=1718629876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4X3e3Z7MOsPGcx9grwDTf7tmbLprv2+NFWd/pBK21s=;
        b=JTT5zCTZ3lsXhnoDPxkpc4q0n/JKy4KWtYFzpwWhqKGqjxmtMSKeeIDl46DM66QX/o
         na1W4/JMxScdkmFPOgj9KbOCW+cYoG/AkExCcoenNNdW2Hziu+krTx3T3832MhHFvIJP
         uyrsP2LYCD60R6QBuWkEBFt8J2snVu9fViKwa0i00RrS2q0Y94q6IUO5gDdWTR5M1XYW
         x1XscimSFl0zQjk1/SAfZCBIuIomgnLpx01Urqo+Qjs3FDHZElbcqlgupgsIpbzpo8zl
         XhAAN+TDRfos4bFEjqroVVwuGNE/vSiP7mjehKWF9IkWhe5lgMjKGa82uuOFnCWgqEFO
         TxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025076; x=1718629876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4X3e3Z7MOsPGcx9grwDTf7tmbLprv2+NFWd/pBK21s=;
        b=wGaYsEYuGvMe4Cv0BfRV0G0W/A4KXO2EX6vP3nvUwBgQIkAN4tSZhjNik9Nh9v6FbO
         tNNUQNmqBaH0Q2WoO+Eb9AtPfxLxxlqMYQJg5gTue9MJ3eNvyFB+D5wVNfmai1JecP7o
         /P2jVuggwbhoRlb0EnNllsE1hNIvlTwtGB7kaoZI5JuKbKL2FnQX6MqlCAXcRCUNKbcy
         u4bEBiQ5p9+mv/MF3LEI89HwyZQONc8Nvj1uyrb8vgUy3Dya8eKiTTdR52qpPjbC05F0
         XpmLD2eL+/3w3EYhGVA/3JgzyOPTt32XYjEZw8lTYi8syBVbKHun9WP15Kv6wrcLVGbV
         gkeQ==
X-Gm-Message-State: AOJu0Yw9xSUaEmHNOtlZCJWvSJNog9C+jA9C1/eNiABBl5VaTDsjy6Vw
	bdxshfJp8eO6m2wCja+11SeIptUf6PVG9KgDdw3QiCparLEiWAs99Z9qPdsz
X-Google-Smtp-Source: AGHT+IF2tZpEoy9FZfHL3Kd4up3yr8lIPrBtVg5gRe3QELZYyV2d5rveHJUKZYyxctaS2qgLW7c75A==
X-Received: by 2002:a05:6a00:1404:b0:704:6ea0:2bac with SMTP id d2e1a72fcca58-7046ea05af3mr3996003b3a.8.1718025075868;
        Mon, 10 Jun 2024 06:11:15 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70599bcac14sm1378516b3a.1.2024.06.10.06.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:11:15 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] reftable: remove unnecessary curly braces in reftable/tree.c
Date: Mon, 10 Jun 2024 18:31:28 +0530
Message-ID: <20240610131017.8321-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240610131017.8321-1-chandrapratap3519@gmail.com>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
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
2.45.2.404.g9eaef5822c

