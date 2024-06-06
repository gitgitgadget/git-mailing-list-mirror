Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C7198823
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688908; cv=none; b=oo98pkxT8tzw71baW7diedTJbB7F0Qgrfpho/oGkUqm2KNoGt+5mOMN12Y+nr1NBs/wOVG2Ebi4tjnMsc7eGa0E7pp3aFVy+E+crY55SAyKp/es2HJ7F9rSi/PE/n2qEzhTT3oaqeIvjWs2UBPhDon7oPy4N1fitt6LHW4Dhlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688908; c=relaxed/simple;
	bh=ZBvpDLNHNjoQCJ3AZJra3cFXcfo2DTAZf2kQPpx1UIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnVXDCuFubz3fNVmk2etKhyEsKoYHcTlaqRjYdpQCDDQVZgKKRg1s6Km1C+yR/W/SKKOx+GBb9Pj3BltHVypZXdH1YzZYm8y2k4bNbvgc/AjXefecYSj1d+I1USmEKhOmpG+CvxxUbKmphBPqA2IfPDsS5ixXpLYN8wnDha4lPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1+4JENy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1+4JENy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f61f775738so10173265ad.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688906; x=1718293706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOyBXezJzIQcgORZHKSHMuaHcOuwfGm1OzY8yhzYeac=;
        b=A1+4JENyfBmJ6jP0R4DhMWIrZVDvVQ86d9r7l8y5slNbYbJKWeV5GvtSJ/n/6AIsGS
         U+SHBDkvhSoUTTnSOIVRDfRkuNQ/HQZa/eKsHF0xT4BHDnuOU6d2Ap7l1HKTYiPG1Jtc
         inE0tehWq6xXqs3dRWmoNS+tmfFahdO2dbXqcDQsJxmHjR5wvL9eQBJT5sRdN99iIPcz
         CiC4LATDLr1+HF5fkMapm5Eh0f0YbrAF0gLKsb25MzY6j35cuoI63Ffwq4ODXQAlfOG3
         /j4htc2ON5Wwm0Tn9a2281swssWgHnZp2IK/CJOYA/xAOoYd9gjfkW0OgJF5GPxtTDKV
         3wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688906; x=1718293706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOyBXezJzIQcgORZHKSHMuaHcOuwfGm1OzY8yhzYeac=;
        b=tSCJiWpoGNmgg/AbVMQK8+3kXLrzLJnaoAEjVf3uQvnEjib8yY0Dh/BbGM5p9tL8qU
         8d0JxWcXYan4oj1RNxQugjoldaYlWhDmFVzBQW2ouYR+ClmoMC7Pg+r//XBpd+VR2fFb
         MabMlFw/IpSkAWkEieHQ2DpTZVrxxzfz9DyT9ft0zkYz1pamxppc4rPgD3VK/69Ybq4P
         BleEEkh+Lz/y1j2+rL58Go4rZQsEmaxEQ0zXGwo6RKg9+fHS76DfEcP0QiCVekXLB34R
         MsGF8yC7tgSoT4KRcrBNczQF/45juxSLhUCj69bpifVVCKsDU7JeL9hyauJtYC70W6fO
         ijPQ==
X-Gm-Message-State: AOJu0YwMs1vyPv5zwH9AR+tNpAGFMs1gLqMxV1jcOmk1Ge42azduJgnN
	5p/WZt4ZMgVkUCkUjfCn/lYayNGMs8xn1xtFxIll7NQgWgQTe9jADePLkOWnWX0=
X-Google-Smtp-Source: AGHT+IGNs4YQTCghFZB2ssijBIxoPRcQgNe3c4nF7Td+bxg4SiCAPuZGsLV8BoeaJFEJ2/nczIPgqg==
X-Received: by 2002:a17:902:f606:b0:1f4:64d9:5cfd with SMTP id d9443c01a7336-1f6a5a5ca36mr72854655ad.42.1717688906115;
        Thu, 06 Jun 2024 08:48:26 -0700 (PDT)
Received: from Ubuntu.. ([223.176.20.76])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd76fa8fsm16937405ad.100.2024.06.06.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:48:25 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 3/6] t-reftable-pq: make merged_iter_pqueue_check() static
Date: Thu,  6 Jun 2024 20:53:39 +0530
Message-ID: <20240606154712.15935-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606154712.15935-1-chandrapratap3519@gmail.com>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606154712.15935-1-chandrapratap3519@gmail.com>
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

