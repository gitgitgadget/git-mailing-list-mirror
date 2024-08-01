Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927A18953E
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510336; cv=none; b=sk1CqiaUXvbHSrQKp99b/fCSP7FA2fBmOSnVVfOOAEXzVTmZNjB3hEUv0bmJQxWmVkgAuYM23n8NGggHKBWV3iIOA8CniMbx+q2OKXHzb4CyJrFcs34AzMhvDB+AEQRxT+myj/xDPBZWCAHrLKY8YzHhCzZ2Gddjx/9rCJ7Boao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510336; c=relaxed/simple;
	bh=/4OTsqp7/0XagHHoHG87U3Cq8P4orhehoCjdV+Ws0UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcAdlyHjFV5N3OdZHiVGLKZxdc4ZBx8yASTjXGnFHG7Dr6P9NjyTEV70DwCFvY6Nc7MWvQOjlChXqQHM+Z7+E3pmBB+Nid1t7Rv/JXomMBAadLaZsDvUhNXdqnuI34JNVLixslsbJetxX7XGsH7tRyUlk52xcgMjuhtD6FQ0Bts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4pm29td; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4pm29td"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc611a0f8cso50173885ad.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510332; x=1723115132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c6I6L2UI6Z07sVX/I4RZEpVOj4WiiO0O3zVyC+4ckQ=;
        b=U4pm29tdHGMfJ6p0os/tZ6hrHJ1JhSVP6Y9fm9ZwoRWs9vyPpuRamSUcAH2uJXpML6
         LRugtOSBjsj/uW56P5Zt9XxyIbznk7NumhB8YIDISBiO/sJlLPPI9J4Sh93Xi5gZxv6p
         Nmv6Nufg+I/8Ul8vV6rasM7ZriNNfk22TRo9WCEyn0b1ySq/JN7T2aivPidCrSjpPLcv
         v/yKZYLxk8r13CC3i4mEEKmS28v8JFjV3FAaFLmjN5+7+lDGmP17ZeE3uqlRkG6LynDd
         RhHuW5YXrUP8kAfQCbqsJyawgnYnPfuFG/f2QiUzbKIKFw96QXnd0ClMGPm5hSPe2ywY
         Zfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510332; x=1723115132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0c6I6L2UI6Z07sVX/I4RZEpVOj4WiiO0O3zVyC+4ckQ=;
        b=pczeMwhDtw+uyOKvrA8FGmW0eBKeREGBKMyoM9OaPt5L30WQM9KQEpNFcmq+/pteh1
         KussZalIe8BMF7lGYJT1pXQd7EgnqCIv602AVPHnpDaLIUMUrlgOykewj/t6/KrHJbxH
         oU5G88aQ4q1I67amSc7G6mi9ywYraLwyjqrTUZ8Q8qZWKUborQnX9HX25IsOFqZ2LAMQ
         TSFIF53w4lgq9W8cStZvd7WauSlh1Pur1qoGLt2ZCzXIrLzt01XIQbqQR1xt/uVTZoG6
         slZradejrPSbGT2EJHCrDgTtVvAvgNKlD9BLAHIYzPFR6DpM5rGbd5cOiWaO9UR1qcFX
         uSbg==
X-Gm-Message-State: AOJu0YzHQexvjadJz3aVm37stgWeMTRJ6Ge4N0kF1i0PLbTgnJjt4JHO
	Tyffi6wcZksSGH5ZWKCJAmTbAhHXTe+V4KtYkbTbtGm7QjUSKNig1jKtJw==
X-Google-Smtp-Source: AGHT+IFduLw6dzOsz8z5nZ9sFjeCx6Bb8txeDz/XBINt5bNg/6iH0ldVocRi1Iw6AVVme4/Xkg6jIQ==
X-Received: by 2002:a17:902:c942:b0:1fc:57b7:995c with SMTP id d9443c01a7336-1ff4ce58802mr25934735ad.7.1722510332188;
        Thu, 01 Aug 2024 04:05:32 -0700 (PDT)
Received: from Ubuntu.. ([106.194.76.199])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7edd90dsm136663985ad.161.2024.08.01.04.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:05:31 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 4/7] t-reftable-pq: make merged_iter_pqueue_check() static
Date: Thu,  1 Aug 2024 16:29:45 +0530
Message-ID: <20240801110453.5087-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240801110453.5087-1-chandrapratap3519@gmail.com>
References: <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240801110453.5087-1-chandrapratap3519@gmail.com>
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
index a78aba9e71..220e82be19 100644
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
2.45.GIT

