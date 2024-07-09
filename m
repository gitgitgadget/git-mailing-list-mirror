Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E713213A
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 05:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503579; cv=none; b=LLW6SvK8Sc5firHtREQA/uYA7EwbzZy0G9zeiDe6SMkPd1lM777LnxssKhG2A1LRJ7Wlr68GIg+QfrWDyRWRVAaXq6CRue5z6ygZVYqBAVIaM9GKd5CoaLT57TmEMOf77Vcw8mdRYWDE1WVMQuoJFsYMibLoQZOWTfJY0zyw9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503579; c=relaxed/simple;
	bh=bKyNNqkunT7MSXJ5o9xsmRqfxJFuS9Q3A9/phvSI8W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTM/cSQExKKOsb3TP9gEmFhpF4Kchg/Bxjf46KdqMIZUazsVHhtJZUnypuw3ed5fyRC+FQ4yNuo6oXVzDVbSpv0ySXworpnKrM1mKpJDxq9tPmNUbKTK3TMDG8JppdyN12i6i+bemtDRsurNtjLhN+EfHxTbfPBWI6pOellmGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShpJ38Ws; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShpJ38Ws"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2598001aae7so2380437fac.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 22:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720503576; x=1721108376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8y6UNrFd3/6BUDhlXb8VSUHrm8G92ZU3xaEH/MoZSc=;
        b=ShpJ38WsbqWAcdNp5Gsx7hG8o1i9VHhIfE/YJgXSQVatYTbIiCSRjZa4OwsF3xjl+u
         h8eTzhq+6Yq+OM8mfk7AjCoKXwGuwOHsQ506BZGdf9CuTSerJSjfSj8u4THyp8Hen1hC
         uwq+z4MwTU9OJMiD1M3lN9n10gWlomJIyKofHkEPUyGDBFyNbU1Va+yISUpCGai4soZo
         /GWTauxJqxz4p2HUJer/2ARLqWkiHHmc8D3vVAF+UdwpRF5rCBZaSdF0Cnzt4eUHqdp4
         HKcacpI6tJLgmA7LhSwuMeDoiqNof9Vy/B6WghN/5FqG4iA6eTbmfr1r5+i6rHRDgGwY
         k4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503576; x=1721108376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8y6UNrFd3/6BUDhlXb8VSUHrm8G92ZU3xaEH/MoZSc=;
        b=kDs4xu7hk7tNxKg8zf8ByKOgniDO0eg4u2/xVvEb8oSSEwTBHUvcnkIqu4gmyn/lH0
         0k7bL+9SGOalRsYuC0c6OQ4hoPKP9CRxMegPyzqtZfqvDV7Vy8fJ4RKcCiNUwRlTwLbj
         EgWuIafiqd0rkD6EYfNPc959mCOJ4ZQ43E1s9a3q2bH1rrD/aBZQQs25qTBgzKXm4ydz
         aYTfxp5zWarA+gd8u3DidcmtQMMkr4xNEhAIjDZP/cQ70meNaq798dgAlwnelRjQTM6i
         YfTh4ALiyvquEj9kdQNKCUvOgof/N3CP6QR9jTb07o/UNOvEZ72a5vDVrkRRJ/7mITws
         kXkA==
X-Gm-Message-State: AOJu0YxUv34XSwg1rJUA9UgiXmJOIW/Wdqe6eT6DOYv/BEDHIykhVv9J
	TfLqziiItQZhoofSOFDyTgcrPrVgf/WyzZLcWavD3JLaL421NaYa4dcrkw==
X-Google-Smtp-Source: AGHT+IGRX81cvo+i9zBo3qwfzDVY16RXF9HWIWK5wUBsh/ROZ8BaalYWJzDD/pacj8Ux0avnOi6MGw==
X-Received: by 2002:a05:6870:d892:b0:25e:2072:b1c with SMTP id 586e51a60fabf-25eae81302dmr1200548fac.25.1720503575828;
        Mon, 08 Jul 2024 22:39:35 -0700 (PDT)
Received: from Ubuntu.. ([117.96.144.60])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-77d61922ee6sm718448a12.46.2024.07.08.22.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:39:35 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	karthik.188@gmail.com
Subject: [PATCH v2 7/7] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
Date: Tue,  9 Jul 2024 10:58:46 +0530
Message-ID: <20240709053847.4453-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240709053847.4453-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling reftable_new_merged_table(), if the hash ID of the
passsed reftable_table parameter doesn't match the passed hash_id
parameter, a REFTABLE_FORMAT_ERROR is thrown. This case is
currently left unexercised, so add a test for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index e0054e379e..50047aa90b 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/merged.h"
 #include "reftable/reader.h"
+#include "reftable/reftable-error.h"
 #include "reftable/reftable-generic.h"
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
@@ -440,6 +441,8 @@ static void t_default_write_opts(void)
 	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
 
 	reftable_table_from_reader(&tab[0], rd);
+	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
 	check(!err);
 
-- 
2.45.2.404.g9eaef5822c

