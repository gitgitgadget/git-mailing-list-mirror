Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB5175561
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094779; cv=none; b=bH33djDe8zItvI9jbzLsWbPBDmfPCIMr9dqSyvXPlUg6zZTch/hj6SwcbCaC/k1FoMap5gO2jfr79FDh1KW99hvk0mdpjSbo68t/fYcLMy9sqyvbyNWmICDFA72T1AhmjUCpWoHl92uH90GeVq/8nnPuS871ebtDOFj7UbgCNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094779; c=relaxed/simple;
	bh=ZBvpDLNHNjoQCJ3AZJra3cFXcfo2DTAZf2kQPpx1UIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu181XY60dOcrcfVy/99zt9wsi0Gbp9axKSlAhHXD0X3+7rruuiWZYksb0XEOPc1lWBQhfa33+Tb+/MkYah/BMwcqLjOXx9aV/fCYAHAvwKfWg89ZnQDKgd/frSZKUQ0DQ7V3ba1Ny3qSV3qwPBhGMqPVaDUlcGo6e3UZSUTDQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXo1DzFW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXo1DzFW"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7041a7d4beeso3046226b3a.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094777; x=1718699577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOyBXezJzIQcgORZHKSHMuaHcOuwfGm1OzY8yhzYeac=;
        b=RXo1DzFWghx1ZsfEZfjw/INsaWbqMDjUaxHNh8HhE4cKoOdBtPTkfYm9LwokL82YAo
         FltkvSte6RwMaLQ+GZeXacpBtxj8iUHn++eZcIbU2fkxawjm9eCVMSpYo9FAcqTDirwo
         yNfvgDzDL6bBZaL6ycDLirSgGOKSLODFb4aYQQl79zUCwL2Jd3CMrZy5smM+guTm5CTw
         NEjSbQpIHdHbSXae+nRkfMdiH3H/XPEFGM7vynts63Y/7Zi/XD16F5lhpbZEbYyD1Qjq
         enjUVIWRdUTJbFysPm1xwJPrkrGQ2+O+DaI1ZBhIe5M0Srd3Ga6NczyIbJSB+Y6Ndyh1
         wTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094777; x=1718699577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOyBXezJzIQcgORZHKSHMuaHcOuwfGm1OzY8yhzYeac=;
        b=P000yix2wz6PZ/6NgCqFLgOiDWGujtZiji0GIfRyCdECaIgcB6Z3CDfs2LHwu1vetB
         xpqE4dAAvq44TU7eR3AR1bBT6c6aYfKvpCOl68kRg6Vflh23DUM544ZB6mLbD7GoNXYq
         UGXfZYA49gucz9SkoMC7OHYPHsgsO30QpXuDSh3QG5VCXJsiOonyRcoDrRWXtqpQ6GTa
         Cj4vlv6sXnU3u48sKVgCBqAAnxoNfWhJb0y5j9MLtHQOmfW2BsKNum1DiSKAMlytyQu4
         x9RK5h7RDe9++8qeh1mnOPTfcbtmdRYwq8+l7+hsyqw7Hjoeh4JbygFqBqnifebBUKj/
         VPsw==
X-Gm-Message-State: AOJu0Yy5mB/0jhxSMn3neIqDQWfsL3C1/3hdruuSply0YWPJCCJdp8js
	CLmGymZbrXE0dtj5O7ypxOkUj5jGrOZWQ3/ifmR/DdrpueXFXwJ8GI4THA==
X-Google-Smtp-Source: AGHT+IHqgumkQkZsfheHVRoD413vyoydp2yGuE1wwJFG9vroJaojG/HnC89fQWeeYlpRQ77OHD3c7w==
X-Received: by 2002:a05:6a20:3258:b0:1b5:77db:c77f with SMTP id adf61e73a8af0-1b577dbc8b0mr6290693637.60.1718094777075;
        Tue, 11 Jun 2024 01:32:57 -0700 (PDT)
Received: from Ubuntu.. ([106.206.199.126])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041cff68d0sm5776170b3a.185.2024.06.11.01.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:32:56 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/7] t-reftable-pq: make merged_iter_pqueue_check() static
Date: Tue, 11 Jun 2024 13:49:21 +0530
Message-ID: <20240611083157.9876-5-chandrapratap3519@gmail.com>
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

merged_iter_pqueue_check() is a function previously defined in
reftable/pq_test.c (now t/unit-tests/t-reftable-pq.c) and used in
the testing of a priority queue as defined by reftable/pq.{c, h}.
As such, this function is only called by reftable/pq_test.c and it
makes little sense to expose it to non-testing code via reftable/pq.h.

Hence, make this function static and remove its prototype from
reftable/pq.h.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.h                | 1 -
 t/unit-tests/t-reftable-pq.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/reftable/pq.h b/reftable/pq.h
index f796c23179..707bd26767 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -22,7 +22,6 @@ struct merged_iter_pqueue {
 	size_t cap;
 };
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index a47a9473f3..7d151f8582 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -10,7 +10,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
 	for (size_t i = 1; i < pq.len; i++) {
 		size_t parent = (i - 1) / 2;
-- 
2.45.2.404.g9eaef5822c

