Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A412F18AF9
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629191; cv=none; b=rMRTKrtW4hD6yY0pZK+NP/yapc8iX1Wu5g6jH02UMfPQkwI2sWDdFiVBaFSTPPV92Br8JkH7DyBSHsQL68I+W40ivCuwEN22QxuIjmJvr+Lh/j12IflHOb6z1n9+4lwzvPI+QFJqr3GUyWF/izxG3SPwyJnELh8tg9PR90p0HdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629191; c=relaxed/simple;
	bh=usfSD7IjlLiLtR/rVwdWNzfZ76N/u78FuvcZHoxoyz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw+TQnj2WY70NgMwqOCCqdzPaLI/S6d3Qsv3tQZ2TJYdEt9eKylF16cJq2t9mpO/fQKNmD13HdyiYtN40Svw8NI1vwXB5iPgrJSLOFYh1X5A3juLnxTFosrxAOtVtMaH8YZh2lGRvZmWauDGL+XMH/H9rTJIMPrGDzhOZ5idHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0Eudrci; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0Eudrci"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a1215dd114so831317a12.1
        for <git@vger.kernel.org>; Sun, 21 Jul 2024 23:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721629189; x=1722233989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uby8YAjXbOwtPujs+EUEgvHqkRO2jGGiEsAdlalx9go=;
        b=a0EudrcizDUPkgTd5+/lAff7vEEUr9smR8t9NaAqli/3Rp2RzeQOD9ra3m0BYanSYp
         B49Q29DZmj4oW81NHtVDZIMlgoK4ZRefiAeg6djJGHgeB8ehvFNhE6+5uQ8cdBX8dw5I
         OWYdJfD41/USnTqHZlHUQrRWmL+iP9uvfdgCYzCzsCAtDXZcIwAorMnZPq20Gi4gMDTZ
         2LSlTQduNGt9B8f6kXixFMgDKWIONp8G1jmYaDxfFLLAYXimH1uZGIgi2hwrSrxPQUXO
         QaSlHgRKKnEsWutrVlRlNTLKwuRI1CX3W2Quop4BJAS+pQAC6O1KLQ8/ULBx5tlHNGjp
         bJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721629189; x=1722233989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uby8YAjXbOwtPujs+EUEgvHqkRO2jGGiEsAdlalx9go=;
        b=pnddlnd8Ewi0o9vU7kWirYoW0zybE+OMgnEEQ9TfCjYcBy5JkwNdKlpIfbrP4ZfJF2
         rF9Rys/lwqQMxtnzAOSPDKJDklNK5YOkpwN5CuCpDiAQW3ZXww3yAw0lKXY4nCz4SvXU
         2yWwBTY5HCii+Av2rYbrilAaA4xFxpdhVZl5NT/d2YLsP7NJluANm4DjdVJK295ddWvk
         WRk79s+zgnlJiu+55oFcrBXa1SK2lteKfR09QFuq6UPoejmsE7mq1VMBi0up58mqMbRs
         OGZqRuczHVKYg3lLAbjo++zQolshyf9JD/b2xSV7L+NBnDiaV+jzKXbd0WJEzM7TjKqR
         2zdg==
X-Gm-Message-State: AOJu0YyKw2VxMKPI7vRpzYoWEr89zql4DcLEDBuFYS1k8Q4uCZWjt0uG
	Ti34K+zXM9tnDzz4B//Eto5HXWgCnGyyEnXusByzCEmX1K6kRX/q5niwv8wC4Ag=
X-Google-Smtp-Source: AGHT+IFIntBUEibwmCWqKVraooyGw14p3QpP1m4FC7wA+juUgjPnokjJpdLqJUhSo0tI/2tN2RXMRg==
X-Received: by 2002:a05:6a21:99a3:b0:1c0:f759:9544 with SMTP id adf61e73a8af0-1c422847decmr10046702637.11.1721629188681;
        Sun, 21 Jul 2024 23:19:48 -0700 (PDT)
Received: from Ubuntu.. ([106.220.63.154])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f31a73csm46362885ad.143.2024.07.21.23.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:19:48 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v5 4/5] t-reftable-tree: add test for non-existent key
Date: Mon, 22 Jul 2024 11:27:57 +0530
Message-ID: <20240722061836.4176-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240722061836.4176-1-chandrapratap3519@gmail.com>
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
 <20240722061836.4176-1-chandrapratap3519@gmail.com>
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
index 07c6c6dce5..6cd35b0ea0 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -46,6 +46,7 @@ static void t_tree_search(void)
 		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
 	}
 
+	check(!tree_search(values, &root, t_compare, 0));
 	tree_free(root);
 }
 
-- 
2.45.GIT

