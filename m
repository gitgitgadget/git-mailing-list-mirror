Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB470174EEB
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094771; cv=none; b=UmswbWG+QyRoNvujyCNlC1yU0qnwkLw4nh/M3HtysFXoa2lfCkzazQyuy/myIr8BUkPbI77q9FBcyUunBH/7ZN8biUQ/jYjuSaN5n/yvUQVN90juzkH+JcvJT3Fk8HACPcu+1LDVbUbx5B0XPuIZm1pxti+xsEX03/FkmGV1ch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094771; c=relaxed/simple;
	bh=YNwb6XiBLk2En9ysJfJB+/zIdFaMUkYO6yPh9qeTuNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IURxSLxu64KHsJb8VOIZ0a3mszEj18qo8Mek1yOj4HSt3eAki9BSXwlQovDuXvrzg2U+jSUWTMQsRkHSgJus75GHv3BBbuHpx3vBRxX+Kap+ztaGPwglnBJd1VeguYsktG/rxCTekZ0ySI2LEW1TJu3YJJlZdAMD+8FYrvuN6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De2WFNRi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De2WFNRi"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6e40ee57f45so684760a12.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094769; x=1718699569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYA+d81nX33f4R8F8mbcZz1jsyIqtoLV0FEHoSFJveo=;
        b=De2WFNRicUjmWvpOlyYg1sA0Rw6NZgUPL6t13K+H/3ZbihQa3bhHZHrInl6NYR5tRH
         xG5iq+D+Rpr3N3dYPIkc89xkmZZi0xBjpJlbNpwge0/+OPeWFrICDoKAuZ4+p8Hy3p5a
         1B9KbYqcwvtCWxrwfuPckGMdJ24RC4MXxgJdHgCM2LEGSdStpAJhRrLuX2v7h8YN0qaP
         mJaUy+4nehb5VdtnByrfY+JqEKMpHOo1wmYAmwq8+AyiTO5XIh+qcNOc0ikxJA7Hvc8e
         BLIIlgEPMzwoKLYGBMCncDMi/BND9S8gYwChRQYp1Ch7yiFhbEK7ndXgGpkKMNbYLIwn
         Tx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094769; x=1718699569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYA+d81nX33f4R8F8mbcZz1jsyIqtoLV0FEHoSFJveo=;
        b=RnuDGRFz2QJ+SqektcKFgJHp7s5JkBPyP0p2oNb25VcTz05ZbsNzszY0XiCtUsbOxr
         D25ymN4GNj/O5M9dS+a+8zoRs6PzJs9SiKekqgEiUJ77VaPr5v+qjz4XccNxREsLTbig
         BDPdTwcViqfB1xKlEa+lIJVoN2N1dkQs3HbP6IuII5j9ipwosB27L3n1A3PUIjPYXXyP
         T55IWSJKYxRel91vXZkmbbBf+Koca/+sGl6sR2mfZ09sgvhePbUThW9lOs36ggMKLGzq
         9kyNUVV2l1axOamLYZEkQCW7uTFEFzyW6V1R1XxGLIuGXr+sShk2J6Qc1uPjfV1aGS1X
         TkJA==
X-Gm-Message-State: AOJu0Yx9DJ/hMY1x65h2mlarzpqENBd3dcGv2p06owOtxqWPzfDOVhNf
	zi3VwO1fFROHVeYB6fdm+O7bTdD1iJwDe1w9aqMPuUiRqS2wYlomlfKbug==
X-Google-Smtp-Source: AGHT+IHjkszVfz4NSUY/s8m10WR5we8odNrX20DRt8kscNFu3HVMtr7w0nnIpwxe8bep+X3IXThO5A==
X-Received: by 2002:a05:6a21:3994:b0:1b7:ad9:19fc with SMTP id adf61e73a8af0-1b888a41df7mr1399277637.24.1718094768590;
        Tue, 11 Jun 2024 01:32:48 -0700 (PDT)
Received: from Ubuntu.. ([106.206.199.126])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041cff68d0sm5776170b3a.185.2024.06.11.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:32:48 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/7] reftable: remove unncessary curly braces in reftable/pq.c
Date: Tue, 11 Jun 2024 13:49:18 +0530
Message-ID: <20240611083157.9876-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240611083157.9876-1-chandrapratap3519@gmail.com>
References: <20240606154712.15935-1-chandrapratap3519@gmail.com>
 <20240611083157.9876-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/CodingGuidelines, control-flow statements
with a single line as their body must omit curly braces. Make
reftable/pq.c conform to this guideline. Besides that, remove
unnecessary newlines and variable assignment.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index 7fb45d8c60..1a180c5fa6 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -27,22 +27,16 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 	pq->heap[0] = pq->heap[pq->len - 1];
 	pq->len--;
 
-	i = 0;
 	while (i < pq->len) {
 		int min = i;
 		int j = 2 * i + 1;
 		int k = 2 * i + 2;
-		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i])) {
+		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
 			min = j;
-		}
-		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min])) {
+		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
 			min = k;
-		}
-
-		if (min == i) {
+		if (min == i)
 			break;
-		}
-
 		SWAP(pq->heap[i], pq->heap[min]);
 		i = min;
 	}
@@ -60,12 +54,9 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
 	i = pq->len - 1;
 	while (i > 0) {
 		int j = (i - 1) / 2;
-		if (pq_less(&pq->heap[j], &pq->heap[i])) {
+		if (pq_less(&pq->heap[j], &pq->heap[i]))
 			break;
-		}
-
 		SWAP(pq->heap[j], pq->heap[i]);
-
 		i = j;
 	}
 }
-- 
2.45.2.404.g9eaef5822c

