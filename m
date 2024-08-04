Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C917C8B
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722755549; cv=none; b=Y3NjqFUnDZvJU2T+UTO38OMXfP4oc3nfgoi/DmZ4S8mVUJbagIsJ7QcZ6GQLqa9PJMlIqHl+Z58q8qAZTH0x6N25pYam07bQMeeTZhF8OUwasrkuAugqCJ556ZKwy6egEhW1UIIV3+qmWotNBqLE+SEXSNXHRxlEEREKj/+hTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722755549; c=relaxed/simple;
	bh=O80OWEFy/gRxqTYSAWRl36e/wy393PuuJng9bY62Heg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rix5LanaunmLgIpM1F0aVMPjfM3ANuFD3DXSeGxIxWgGaqWiJ86Oneywsb/BZA8vNGtL0Zjo7NqTU5j60mlE9645Ddhn9Q9XPQ9fLW0eqDdITqIGgklrZwPwUJcROJyLkKFijh1KcmUmXadSFMn2455gG9WcqxC72Mfp/fIgHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHI/slWf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHI/slWf"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef23d04541so108636111fa.2
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722755546; x=1723360346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3jbrDza7f4qi2NyP/CznSHTutp14CJPJ3DFSkcS+AM=;
        b=CHI/slWfyf8cwraVWVl0cNMedwLivAkxbsbIUuQ36BH1DRWTtTyDz5xFjz5oVKgIBP
         AzUyXfpabQo7Bo7U7sR3pQFCFHUp9FO8KH6Iival5SJYPniM99liff2HWF2O50OBnKGv
         1+Yz0RIhe6JvloOllDP5iKPQ1B5a/gwbBQ/wv9vK8PKcyVixYmDMw676/l+dYYO6Fk51
         vnf//4oZPbpaHpg1HkHaLAB/Muqm5N3nu0gtzCzVSYoTcx/FC4aI6l5xgKpjhjTbuPel
         wRGQ/JDl/knfk3ZG7NePO5mkX0on8DnJpyTWstYua5GZLe/bXTB2n/JCzcuNkX/LtfY+
         fiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722755546; x=1723360346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3jbrDza7f4qi2NyP/CznSHTutp14CJPJ3DFSkcS+AM=;
        b=SezGntleT1H8bI1vOAbbI8c/2artecgUJCeeor7fcqKSTUUcdHSrnMqBUqH1V0utPf
         LtMSKvE0VhWqcqlMJjj0js8xYwSmBSF03vikW3ohlDHEvtOYPOcxYvg/wucv/I7c+CNJ
         cZsNFmI7UeMq+IavpYDjrl2KZai0JPhSan4Po/x2irj0vWg4dGWDhKtM6c+Tvb2TUA4w
         NJpYhBM/e7pT6UwrVB3bD9tQgdwORbWPuwl4Cq4m4D2DvMULwy3XAn8CKFBiBh4LUjTq
         e0GBAvlp6yC885nIrICbPLf8byGkxT7CenZa8NgDolZw+geCFROYVQNECjEveajCCPqO
         GVvw==
X-Gm-Message-State: AOJu0YzfvxYCd8mEXNxuhHN36VOxDPerMF5KI7prK8HLm590Nb0syaO/
	bjO6M+xCA10qQZWc8ki7LNi0QI3NUVCkscpmbzs5nPZbttTqLt1XkiFVYtO0aIQ=
X-Google-Smtp-Source: AGHT+IHZAHJ0Qgwas6xBGRGv/uOgfTyjyy0HIAX4xWX3IXIg+QjedbjttY718LwHLSzRbR757asrUw==
X-Received: by 2002:a2e:985a:0:b0:2ef:20ae:d116 with SMTP id 38308e7fff4ca-2f15aa026d3mr50937931fa.0.1722755545261;
        Sun, 04 Aug 2024 00:12:25 -0700 (PDT)
Received: from abdobngad.. ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3c0b7sm88477595e9.23.2024.08.04.00.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 00:12:25 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v3 3/6] [Newcomer] t7004-tag: one command per line
Date: Sun,  4 Aug 2024 10:11:34 +0300
Message-ID: <20240804071137.30326-4-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804071137.30326-1-abdobngad@gmail.com>
References: <20240804071137.30326-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix lines like these:

git tag -l >actual && test_cmp expect actual &&

to

git tag -l >actual &&
test_cmp expect actual &&

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1e31f39646..cfe7653317 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -215,9 +215,11 @@ mytag
 EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l >actual && test_cmp expect actual &&
+	git tag -l >actual &&
+	test_cmp expect actual &&
 	git tag -d &&
-	git tag -l >actual && test_cmp expect actual
+	git tag -l >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success \
-- 
2.43.0

