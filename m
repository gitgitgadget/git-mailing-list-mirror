Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258B56B8C
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116655; cv=none; b=asbkemWfIRW2bCIDzkvnT8xlbj9wnPuV3xh4HZng4aNgZD4gP82wXJAanDwN2mvBU0Zh/i90VGMaQgJlZXIFfe3jZkA3tIXfVyPJjrFytS1w0zWiCndiTsH5beN3YRpDuw/hIrPT3Jl4yPuPOzRb0BoA4FcAoYl2ASvkS3kOxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116655; c=relaxed/simple;
	bh=ceMm0C4l0yqhmFhIZinJpY7S1wQhLjpe28bHcNSUY4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2x6CZuLQM4L2n1ehhu4usWcPyKZgFC8xzAB1QmkOgyBfhiF0GmPm3w2SShshKUblRYW2YVDbgfR/0Rh1tepjUiZOqZXB09x1EdKBukdeTo1/vP0e/GS3gRiSURlzvLoNE1ikH+hGZ4nBAEUGfs/X8lfdkgd9ObvdpUVDkE44yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUkk00z3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUkk00z3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so38554765ad.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721116652; x=1721721452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBLK/PFNEJM2zP2TvSFC9UyFEkUARDFoE4yw9WyM7k0=;
        b=kUkk00z3F1T1aBl4mmTnYlyBFE4zLl6nt609lgVuCDGbFRUL+oLWl2OH8PvmFwfWVk
         jXayD+DKrh5tDusEEM4WXoQSSZJejqjgPoA7adOFhU6TXOwDm1wRH8EnhdhXb95nFTzF
         IncNeyZGlXaMZXMCGL69QsqX+0Fnr2VPCLVSZnzBRUHDahEZA5kK7jSfcayONgGxh2tD
         /jwWrgxzY8qQPPEWuHx5GsEW0B8xdB9sbcgXW8aaph1HdQy9+E5miQ0RzqCQZ1y0NB01
         zy6cHQL7IWCWN5l9dhKCldqOgtbb40CivwLJXx69YnwNG5RRdL47URnu87z4t6TZidop
         kY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116652; x=1721721452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBLK/PFNEJM2zP2TvSFC9UyFEkUARDFoE4yw9WyM7k0=;
        b=o97oDpVXJFEnXihrsh34SKaNJCQMUxh/Vf/CLGMuOfyBMbPq1f2UqrK//+30DMzg46
         z3SsdahwAvJiDLi3zwOEEFdYC+tbw5Hr7Wjh7+N2nDirm+qLuODbyECcKFL8rI9gBhVb
         j4ONg4rxzNJPKxeYO0aiq11oD7DDG9Fz2FVUCBd7qreO4G+YmGfMEMNNJIK5jbZahLbD
         Tv4Ui7xtrw+locZwv++NBAPCZW/RJZRmLNC1QjDcKfNED5aAj/Gb/F9mI7cB4NmxRSnA
         38bUnXodTyF7IzVia9x+N0vNqqH4IE2gRzzh9+IC2CqjJXtd/htufIDezB+Vw+Qj5YWo
         sW+A==
X-Gm-Message-State: AOJu0YwruRqy3O+hN2qOzkxwMhIc4QgUZyhvkUBffsdNTupvzswFq7s+
	KoXZ4WY5GJ5/LJ0dHciv5DXD+V/F5YxXwtRkXf1Zxlg6zwTwQDupGD4gtUQF
X-Google-Smtp-Source: AGHT+IEymuiTjtT6xZpeSS+BVecVX8JrE51WYxPhBcnaqkrY2r6CzIgTFLT3Uz++ZrktD8OJLE8IrA==
X-Received: by 2002:a17:903:1110:b0:1fb:719a:28cc with SMTP id d9443c01a7336-1fc3cb37b6fmr14254385ad.18.1721116652396;
        Tue, 16 Jul 2024 00:57:32 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.176])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fc0bc3a599sm53691435ad.232.2024.07.16.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:57:31 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 4/5] t-reftable-tree: add test for non-existent key
Date: Tue, 16 Jul 2024 13:18:16 +0530
Message-ID: <20240716075641.4264-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240716075641.4264-1-chandrapratap3519@gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for tree_search(), the case for
non-existent key is not exercised. Improve this by adding a
test-case for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 68b1b31176..e04e555509 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -43,6 +43,7 @@ static void t_tree_search(void)
 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
 	}
 
+	check(!tree_search(values, &root, &test_compare, 0));
 	tree_free(root);
 }
 
-- 
2.45.GIT

