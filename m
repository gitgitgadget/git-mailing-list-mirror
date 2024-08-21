Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293D199956
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244157; cv=none; b=U5kAEadVMj77VdtBY0F0ncBThGVhtJAFOWL1yv2eEfocVc6Y7QH6BiTR5Z2IT9nO8Vq9pYzbb7U6vloACS0Hinz5wP6oDrtCKh++yGMvjs6Id7wTryOAgYurgsCnkvZpOKvDdP9oTPK+vnVvBv3T+bI6bmhuBVwqUmtYChWK/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244157; c=relaxed/simple;
	bh=F6Ll+kebVEWNfVCewmYyA3w1aLfK5yHdCCiWyt+qaQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqpHuqrfP1XEDiBqJA2H3CjQndMWcN5c07tPhdZSpoZDiswzs3F+jnSCKcq8hUdcTwoXZNdGyWK7jB3kME6O2o8JlKf6ji3zaZJbdakCd4Ag1osk4WbPamGglxUiddbhSfS0rK353e5yEWA7hs0pa6bv+q/zDNeCG1nnN5JL2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6lZij7c; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6lZij7c"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so4834380a12.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244155; x=1724848955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djhsm1ZWS+CvJVfKqGt3b/MT7c/o2mK2WpsPEkOb1sg=;
        b=R6lZij7cX7bldli4JLg2OS+bA+txRYLh2Bnp2WuozJZ1uGFegg1KSvOBmcjl9ZifJ6
         eLUORuC8yrSuyb8DRZqCvMOXtwD8Lwuw3i26/pF5FyI1aaXCxMMtdvPWBTq7aUJjE/fn
         fV7gVIj3mQ9gYVIyVcmcKc6wR43+TolrTQCmz2A8jwvRD1JDuDYS8dHhqh2xsTDPvDsX
         a+u+i1TMtPw2OdmWl/3f8W9+KHBLwaAIN27ZkTF4kbUwfTpi46xKkw2KwE9eCx7YtYmv
         aA/T06mi97uyKifx+FQcX05TqZztCZgWX+nwxQjYadNzU+DIeN0FCx11QvtDr5U8QaNC
         XAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244155; x=1724848955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djhsm1ZWS+CvJVfKqGt3b/MT7c/o2mK2WpsPEkOb1sg=;
        b=FmETdFqM1wZJKcQujpRaBAPr9mp+8qgcMIS4DnsJ9hcUmFJsW2ZFPucwweFg4931fH
         qIPB7XGqgd/Wf4bEnRCUe9zrXWtA9XxvpatkVMSB9215we7waKlgDB4iea1jibs8rQCR
         3xi8iTNBcEwipkjRbzeky7C4aKfKY/nsTTJI7XyVEtQct1yvp14RjtUZWvy/AL+4dKsq
         CzpLDDogIQzn4pvkfUnVRuPTEelPaYbhKzswv1pA2BkHEIIzYkSrbunIuVIhcaIguEM3
         NjSf1dElXhRB+GgDJBwBjqFDlSs4zkzswuOIhHZmSvQD0IUrk3AUT4SbUAoYYw19wE+8
         rmHw==
X-Gm-Message-State: AOJu0YxMGmRH3g2stCzH1DkI7zlC1qT5ecGpeGW1qpuXLn0DPXS7tpQS
	tngyWJxL06d2ODzGkhHwnfJiKfHhJUaMV1uFuFhREt4pkemRQRXseOSRVanY
X-Google-Smtp-Source: AGHT+IH8ydquhJbW2CFO6ljXuDKDb49ZXsBoznKVd4ZOpj+YoSVr1PQ7T/oGUOcFHD4DuJ/OZC/ETA==
X-Received: by 2002:a17:90a:8cc:b0:2d3:c31f:c822 with SMTP id 98e67ed59e1d1-2d5e9a1f56emr2404232a91.21.1724244155418;
        Wed, 21 Aug 2024 05:42:35 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:34 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 07/11] t-reftable-block: use xstrfmt() instead of xstrdup()
Date: Wed, 21 Aug 2024 18:00:57 +0530
Message-ID: <20240821124150.4463-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240821124150.4463-1-chandrapratap3519@gmail.com>
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
 <20240821124150.4463-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use xstrfmt() to assign a formatted string to a ref record's
refname instead of xstrdup(). This helps save the overhead of
a local 'char' buffer as well as makes the test more compact.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index ad3d128ea7..81484bc646 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -44,10 +44,7 @@ static void t_block_read_write(void)
 	check_int(ret, ==, REFTABLE_API_ERROR);
 
 	for (i = 0; i < N; i++) {
-		char name[100];
-		snprintf(name, sizeof(name), "branch%02"PRIuMAX, (uintmax_t)i);
-
-		rec.u.ref.refname = xstrdup(name);
+		rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
 		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
 
-- 
2.45.GIT

