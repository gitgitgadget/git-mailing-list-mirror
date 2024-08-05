Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7717278D
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902394; cv=none; b=gjLEpTc7dvHEdy8egdITZ64LlHVLD2zwq11sDmZeVqiJcspyu8bUzgzMKw+0Vv+A7NDpTH0J2pmyACIChKi+Ix/qlctiUjBC8oZEiRwH8nWlVZFoDNc1y2erAIyHTpYk4Q17ls0vp2W8kaqSfWIdkMSfQj1ClkvSGusTLJ94obM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902394; c=relaxed/simple;
	bh=Wyw+z4scJOkOkZqootZyKv6ntDDDvDBeZRyW2UsbHQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0PLSO3rYqEIF6sWy2zahiejGVXBMkmJGfImPl4gblx2MRE8KNpi73Hpssll06oJFTsbDwMyV2blDFMlv8fZpiJC91AI3NW3c62iSb2n51Iy/3Ge+x8IElKIKdnT9i+n+V8WCtF8orgJbWvA92ChavpkCXvO0+HQoFOZA0RdulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edvfAu/k; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edvfAu/k"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281faefea9so64046035e9.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 16:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902390; x=1723507190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fX06hHVdKYktUipBWQ7oKsQcnujp62bG+T8+GT2P7w=;
        b=edvfAu/kii5kZ2laQ8POl1Eaulknn4tfPUF8KFv1yU6ooi97AxFJNDXT+LUEVgr9fH
         hXsQFm3YPHZ3yYYjcqFeHxbGD3a7S6AhR2R2F0ElZbeMTkjgAmz30FM8TJSDv7FW0PzP
         sly68qhQQNkTQIBz7sIY1RI8LLDT++uaUhh6AdmmMmHqV7hNhsxdbuUpcdKBDJYCNZ3L
         ASXdgmkPosbLDIjXB72quAfoO0ni2/on+Zfb/ZP6w0gfJmz0dNBkOXiodStxjNtPS+Gf
         jOgL0dfmjyhHfTE8DuyXG+//7ze9oITiNhdcmVxfbzM+6tg5Aj4NrMIdUqlc/4Moyfuk
         65Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902390; x=1723507190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fX06hHVdKYktUipBWQ7oKsQcnujp62bG+T8+GT2P7w=;
        b=OjKBPGxbnbpvlmRoMbLqL7xlr1S1W+61fNruLCmcbiwG/7mPY4zOuUAm91oW4XMvyL
         m2TPIkkL38sa2eepiL8C7qyTxwfyvlid06xmQOqPYNQxw9Bm92J0MgMFkHYEQQfMadAP
         gq4YG4dFSySWOLEaaDUhYQin1VlrlvBv9GgKwKescD4ho+lisOC2z+BRKtF6RocY/rEh
         YgQaUpdoinNDmmbFk1rslGvxZtpGLVxlwJGhxqG3+c6EvHwz0cFYZDPNfr+WHri1h/Hi
         lCPiatGy91bNemVzGOt+/nQrT0DTf3N3j10WmFv6CzjA/z9T4t3cUPo6novJXoEjbdn2
         UaVQ==
X-Gm-Message-State: AOJu0Yz5LCjXZyDd7mviwPo8cniTQK8/wNvTHWi5NGwNSPJL/4j1NGQL
	/M3ELy0nSe6Oirfg2JkI+in6nlHfpq4nF/82T0hA2lf3cze4+zH6hjpWaM4Y
X-Google-Smtp-Source: AGHT+IG48P2rknjqg2VjKbGootbxmFGMaUFklX5TaMpoYyN2eXzBOG/Tt1+RPi4bOnP9IYhWflcdSA==
X-Received: by 2002:a5d:5c88:0:b0:368:3808:7f68 with SMTP id ffacd0b85a97d-36bc5a0076amr6888665f8f.15.1722902390298;
        Mon, 05 Aug 2024 16:59:50 -0700 (PDT)
Received: from abdobngad.. ([197.40.47.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd074583sm11219065f8f.108.2024.08.05.16.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:59:50 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v4 5/8] [Newcomer] t7004: Use indented here-doc
Date: Tue,  6 Aug 2024 02:59:14 +0300
Message-ID: <20240805235917.190699-6-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805235917.190699-1-abdobngad@gmail.com>
References: <20240805235917.190699-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use <<-\EOF instead of <<\EOF where the latter allows us to indent
the body of the here-doc.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b9fe58fbee..242e38887b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -389,10 +389,10 @@ test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documenta
 
 test_expect_success 'listing tags in column' '
 	COLUMNS=41 git tag -l --column=row >actual &&
-	cat >expected <<\EOF &&
-a1      aa1     cba     t210    t211
-v0.2.1  v1.0    v1.0.1  v1.1.3
-EOF
+	cat >expected <<-\EOF &&
+	a1      aa1     cba     t210    t211
+	v0.2.1  v1.0    v1.0.1  v1.1.3
+	EOF
 	test_cmp expected actual
 '
 
@@ -400,10 +400,10 @@ test_expect_success 'listing tags in column with column.*' '
 	test_config column.tag row &&
 	test_config column.ui dense &&
 	COLUMNS=40 git tag -l >actual &&
-	cat >expected <<\EOF &&
-a1      aa1   cba     t210    t211
-v0.2.1  v1.0  v1.0.1  v1.1.3
-EOF
+	cat >expected <<-\EOF &&
+	a1      aa1   cba     t210    t211
+	v0.2.1  v1.0  v1.0.1  v1.1.3
+	EOF
 	test_cmp expected actual
 '
 
@@ -414,17 +414,17 @@ test_expect_success 'listing tag with -n --column should fail' '
 test_expect_success 'listing tags -n in column with column.ui ignored' '
 	test_config column.ui "row dense" &&
 	COLUMNS=40 git tag -l -n >actual &&
-	cat >expected <<\EOF &&
-a1              Foo
-aa1             Foo
-cba             Foo
-t210            Foo
-t211            Foo
-v0.2.1          Foo
-v1.0            Foo
-v1.0.1          Foo
-v1.1.3          Foo
-EOF
+	cat >expected <<-\EOF &&
+	a1              Foo
+	aa1             Foo
+	cba             Foo
+	t210            Foo
+	t211            Foo
+	v0.2.1          Foo
+	v1.0            Foo
+	v1.0.1          Foo
+	v1.1.3          Foo
+	EOF
 	test_cmp expected actual
 '
 
-- 
2.43.0

