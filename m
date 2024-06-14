Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854591922FE
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358726; cv=none; b=qsLsggaI9dj8NnK6QY8DUtPoJRTb3QQrT3TRHWpjT54PFKC4g3mv3Sfz15gIv1WUTCDB7UdW+2ssR6jvEYhX7QxLhDstldQ49EI+kWiJ6D+qVxEtcwX6ATUca9c7Q5D1JPmDFWxD6lOrpcKSoo8HhtmnxXZiU8WK10RdbNveLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358726; c=relaxed/simple;
	bh=YNwb6XiBLk2En9ysJfJB+/zIdFaMUkYO6yPh9qeTuNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoW2IxbZn5VBMYdcLMdAKVAve4HUMstFc0fnWtbqIoLIrkvl4rp7xEBZk32SjVzBrhIquoj5l8nMOJs1Xy9Ea7V/VJqIe15OYcPL2oig4eBzGfjR1Pk2VhlxWAWxtsOLIhfdr9dpXx+1uz8iTdQ0zf9GjjGHWmvbDFM3sJ4JiZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRJHt7Xi; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRJHt7Xi"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso1661444a12.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 02:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718358724; x=1718963524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYA+d81nX33f4R8F8mbcZz1jsyIqtoLV0FEHoSFJveo=;
        b=TRJHt7XiYVR7y0kPP4kGKvb5PeHfMquyqEYW6oib2OJ5crroW4/DB5jm4R9BSlFnhY
         FavYjHh8pye1ffL6njxETBy/cZutx/G6npSMmV30R0SOWRsm9Es5ByvRimH2srVBj4Hn
         p6onMTL379g384pOFICpczG4LT3qOijzaZCAsZy+vevszBrTQMMqo3FG3cDwexmQLQ5k
         Ji7Bz//cinojj8/uZxUq3lla0I/0ff4MXJD7yYA4XZiEqtz4mOiknD72B8eaOSf8/2DM
         9gT9WP3ueZ8jERZvSPeanHvoGWGV+7Ol8sdLRzLSYXj/aN5yLvV5eczhzcQXlsn98v+l
         LAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358724; x=1718963524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYA+d81nX33f4R8F8mbcZz1jsyIqtoLV0FEHoSFJveo=;
        b=vhRlmpArS7jZS25wFq+8dQGfA2WabJ9R3mYvXAbzk/ChgaL7n59qJUfsZd9zoYwPbN
         FqhAdNFzmOzvuaUp5Thhe+Duf54BAwTdm+SLXnAhshkf2/rW+yv0cLY3redx/AX5KUhT
         OEAs0CyyiRdTyd7NJuU6ElRYJ0deNXgUMXHycbIzk2WNoWgb7tDzt5mFHftLj4YLCvvu
         +6LWc3fDNDnyDWby+8/czKIqwWPPf1cJdNsp1K8xipqdr1SIwKrcFKEXcfBKdvlGH0PK
         Tv1vRnkHeS7tNIzAcxgEXBMhYADLP0Znxfd19o7pmvc8IseVpvms5qrQSwF1d42wPDtY
         kH/g==
X-Gm-Message-State: AOJu0Yx1uq3NE0u4DhF0krqRgaJwrYVkr5TsFtMFEp3TlLBF3mZVmT/+
	WZ9T7RDl4LW3XS5bWdHkcQ8bln7n+oJ2G+GjG8eRZo5eq6OXfBheyxZ/vsi3NUY=
X-Google-Smtp-Source: AGHT+IFQtVlXLY7f0+D8/bNKE8qiTRuD22BZXQoYWhHdsezfoOq1lwRhjfHBmWjvg6DrqNnuyigmOA==
X-Received: by 2002:a05:6a20:7288:b0:1b1:c77f:56c3 with SMTP id adf61e73a8af0-1bae7e0c23dmr2695180637.7.1718358723890;
        Fri, 14 Jun 2024 02:52:03 -0700 (PDT)
Received: from Ubuntu.. ([117.96.146.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f868b83afesm9230005ad.156.2024.06.14.02.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:52:03 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/7] reftable: remove unncessary curly braces in reftable/pq.c
Date: Fri, 14 Jun 2024 15:18:01 +0530
Message-ID: <20240614095136.12052-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240614095136.12052-1-chandrapratap3519@gmail.com>
References: <20240611083157.9876-1-chandrapratap3519@gmail.com>
 <20240614095136.12052-1-chandrapratap3519@gmail.com>
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

