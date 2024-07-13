Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3713A889
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878330; cv=none; b=nQCuxbaZWXtKhyonIiXxpm/tdsS/FE6/WgHeYHvxob/lyu/WVPf8MD3hWN/+94Yuc6HEvSUSRC1tCcBddGkhSzzp58IOdCqi/9K7f6DQPP1u30DEs13yJ5bjaj/yTGv37ZDyecg0kUdc1hB73rq3UeWRsJOrG1PuTQ0S3/TH1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878330; c=relaxed/simple;
	bh=NKLRjRIvuJP94W+tCj4VNJ0/Xh/FWZbhInoDE+UGwyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClGXz6E1fYE2jykctLRKHKp6iCJYcaI1QaLYQfZOHnM5vjZhwaUi4vf4FScgg87UnTB2tYvLo7n3uXbTpkl8eQuK+LOwKLHpfBmg0kkLqZGmFQt3w6NzkFtGZMCEtTR9L/EGe4wRC8yOlh+G1mJDZxgEwTNsfVYvefCcbX+Bya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFxF5znA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFxF5znA"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367818349a0so1638067f8f.1
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878327; x=1721483127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWpRRpBwnZmw3yWd0ypb6JPNeFDHxwHjwgCkp69QJus=;
        b=WFxF5znAQUHYP/3r2vUJ9Kpgq2dpq1FBsLAb1RmQewb9bxCXbf877qzLixjTmdc9fN
         OjqFkoqyataVWwHdzLuNkc6cfwyobcg0wjW+ZPCEIR836BYPTc/CB81fYZmSAQok7Dmb
         hOqlldTcJNf5D2wRFJulbExs2wPJb66YZFqadbv1zso5KRX5SsOQUHyGNH09+4pVxbvu
         BOsinMQcVGUcnzmrnqotCkZN3vdUqryJwmBNzbw0Pif/ueoGGq8MJjV98ajrQo0P1O9I
         XwrJ6zGUyKp9vS11RB8JRE1M+HovIzjUypwFJy+Q27WarZTn+Kp0yDX4lZ/B99SoF07g
         8uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878327; x=1721483127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWpRRpBwnZmw3yWd0ypb6JPNeFDHxwHjwgCkp69QJus=;
        b=eDrllkvuNNnPb9DP6brrF9VHKzLQcFdLJzO/PvCt0dt4FViBjOJ1YpKP7jykA/v8Zz
         cepnSYUiaYNIYBQhsXwSNsbIsUAjHWKkWeaKa1C2EhBR94rkZkxaC83EOqrFAP8IIwmz
         TDX0cpFrp7shHNHhft037NosywpikQj9MdX4WNUm7BQMckFpQSr49UGIslAiG51GBXm2
         FnG3HIjaSoycI0MlEtVnrVTR2NgXxkEey+Q8AtSW/Y0rf1Y25pFedZIAwx4LDZIdwYrl
         5H1CWylRVZ/nsTPc9itI+9KX9MJMtjyJbfCG7df69SFuyvZtGWldgO1N/hOVWLMHeNgW
         H5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ig9ZZoRYEGwtvI7xqs40sHPAxKxcmoyEHyGNuo+LHPgVvjBJPZwcPZRbT0B+o2T0clk8zeHT2pC/1QE+qMxVUEqo
X-Gm-Message-State: AOJu0Ywl/ZgDke0Pdj2gY/0rd27ppqqnj0wdeGhBQAEG1FVBTiv7hXhz
	HOo2/jfTN5Jpa2TFDIkDiTub0o0jK8oS1ofcd+uRX3LFuInAPVEj
X-Google-Smtp-Source: AGHT+IFbryThF5soWxj4jy+cuNMQtrk75pkUE8GiwEoAOGGMHlIzt563idvcVgF85tw6BoHD9+oV9Q==
X-Received: by 2002:a5d:4750:0:b0:367:fb86:c2f9 with SMTP id ffacd0b85a97d-367fb86c436mr4576767f8f.30.1720878327097;
        Sat, 13 Jul 2024 06:45:27 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 5/8] clang-format: formalize some of the spacing rules
Date: Sat, 13 Jul 2024 15:45:15 +0200
Message-ID: <20240713134518.773053-6-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some spacing rules that we follow in the project and it makes
sense to formalize them:
* Ensure there is no space inserted after the logical not '!' operator.
* Ensure there is no space before the case statement's colon.
* Ensure there is no space before the first bracket '[' of an array.
* Ensure there is no space in empty blocks.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.clang-format b/.clang-format
index 914254a29b..a0dd1f2eb9 100644
--- a/.clang-format
+++ b/.clang-format
@@ -121,11 +121,18 @@ PointerAlignment: Right
 # x = (int32)y;    not    x = (int32) y;
 SpaceAfterCStyleCast: false
 
+# No space is inserted after the logical not operator
+SpaceAfterLogicalNot: false
+
 # Insert spaces before and after assignment operators
 # int a = 5;    not    int a=5;
 # a += 42;             a+=42;
 SpaceBeforeAssignmentOperators: true
 
+# Spaces will be removed before case colon.
+# case 1: break;    not     case 1 : break;
+SpaceBeforeCaseColon: false
+
 # Put a space before opening parentheses only after control statement keywords.
 # void f() {
 #   if (true) {
@@ -134,6 +141,13 @@ SpaceBeforeAssignmentOperators: true
 # }
 SpaceBeforeParens: ControlStatements
 
+# No space before first '[' in arrays
+# int a[5][5];     not      int a [5][5];
+SpaceBeforeSquareBrackets: false
+
+# No space will be inserted into {}
+# while (true) {}    not    while (true) { }
+SpaceInEmptyBlock: false
 
 # The number of spaces before trailing line comments (// - comments).
 # This does not affect trailing block comments (/* - comments).
-- 
2.45.2

