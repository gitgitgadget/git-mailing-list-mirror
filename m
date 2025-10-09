Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751382E1F1F
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012720; cv=none; b=g9/OycoAGowkvrukvxMn9s6OlncC+UGDe3IjmdiXIkyjOrtmWlvOVAUJhXB557ZM/29pHOA/KmIjfYbcMe9BgJ0Bn/NSpWeLImQL0g9Mimh2rQtyXUZoHJbheY46G7jzm0VYz9aZrrrhUC8x9hg1+mD429QAE+t6a2GTQUIrvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012720; c=relaxed/simple;
	bh=Z/ERojsJHXA/6pN0s1OPbO1PCRgxayhgRQ2B8k4IR68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCHWOCnhooQMSyvQwSC+PHPfB7oxbUoE4l2Djt0reopsbg+rO1tw7c0akexjr2vWmyHA44J9uzhvKjBbfpmEzKFHPifFj7EFF0+9mUIg1GKEYEsVGsmA78bfQ8TSHmhoJZF9PUkjr0lJxD7lmu6IHmgGd8IKY6uMHq2ED2a6CgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oltq/n0p; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oltq/n0p"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so8617915e9.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012716; x=1760617516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4xRwZCscrTBPhl4uLdfXTc5v172JGQJzGUtMB7Dy1I=;
        b=Oltq/n0p0ErMHlSPBCQWjnSOUy6RjkTYdW0g/FWPnp2sPJBnsfFfxvasni2dxLOpHP
         seYm2eZsqP7KIHPXrR7oQmwWwN3HntqgNdABw9GDvl9j4gx/pSFM2FAM/+Ui92a1tasE
         4eJW5QQJzUhN47FteCEw6AfSA3LSSCi5KopVGgu2SBYWRx/acssux4x6/MA8+ORy1iOz
         5Eej5MMsMN2IhlP51H+bTlDKDsb9LSqrxFDtutANXN14EGWE/aDkiJUvTeN7IMRqc+1x
         tHyEMyUisqkKOB/AYX/l0Gg7Y5LXXlVeW6pQtA6lMf4BbMQl3X6RHYjC9MTDUpiGAiIg
         iMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012716; x=1760617516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4xRwZCscrTBPhl4uLdfXTc5v172JGQJzGUtMB7Dy1I=;
        b=lPmlnC5zUtAJgU71bNN9n6U2sTtQeBTQmT+fK+NsO83ntVlCDWCXEwK4A8Mrd6AGa0
         f48d+aMGoj+b3FzacuJA2lC6QigkopomNEZLoAqYFbpWr2nYgnj6TtSTNMWYPU5uNAV3
         0Qt6ANTl47XNStdOuVuVKQ82hj94q9i35buu+s4EWkSXwIN4xNNx7Co78hdMkt6e0Qpe
         3H3y8VaSJVkCyVPPNorzp/ETiTuSmfsWuOupxq8L7ddjvJXlVMZ2H3ddFC2MmTwprXaT
         ZkszvZ45nuVbmE759jgOdtGW20rkuf/26RPM6OPnrv0WTHvh0u27VX9ZuUO89H23fMUg
         c1Kg==
X-Gm-Message-State: AOJu0YyWn2/Xq69NLjk+OCO/uPlQEv8Y0WEy3Cfvxmog+itW1ZRn9sj4
	J4oKq2bFIBZARshwf5x1ktjiWAJRDyGUJbDmof3Ssst70RGLmq2tVJQjwzsRfM4m
X-Gm-Gg: ASbGnctfFTiYVwyTFy9s+HpKlsG1OYmqfQb74nblgA7tLNTquHelSlBSBRxuvnL/3FI
	EsE5ErdZKWHAEF8N5lMiAJN1ZJZvPxd/pyuihzMh4Ia6BZxrxDCkI40xsvmqq1En0Zyki9YOhEZ
	Sj+jLf5Z+roUEKGmc94/CFuyp7voJ04oTzxkvFmI4EqXKtWJDqR4RTjXe4zFzdzERaMjC2IYjhj
	D7A2JNgDxWIOYqncGprzcTeqEKl2GEYyC1r9WR0oCjn6j70i7zzGmb/3UTfMbW4T+nQMu2eXfDx
	LdtOHkTNw1jfGgQn6HFLY6Vm9d8NOlt2BIOnLIuRr6nlxKJb+VH34bDuazNqmji4W4clVT/AiC4
	01tCBfJjLHtAzO74ELd9bG99aRKuiNKvV0IUk78+qcbwG/gXMIrBhNHi+wGb0+DnpP7N41WoKzI
	K3+CMQXzralOBh5Ety6OI=
X-Google-Smtp-Source: AGHT+IFiwBYXVAg6l6UcreC+prgA411n0kxniUYCn3chBx8ujIPi9cl/DyJpPhYYksioBrvEncWhEA==
X-Received: by 2002:a05:600c:1e8c:b0:46e:326e:4501 with SMTP id 5b1f17b1804b1-46fa9a9ea20mr57393615e9.10.1760012715838;
        Thu, 09 Oct 2025 05:25:15 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07cbasm84831475e9.7.2025.10.09.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:25:14 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/5] t9350: properly count annotated tags
Date: Thu,  9 Oct 2025 14:24:55 +0200
Message-ID: <20251009122457.1273701-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251009122457.1273701-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "t9350-fast-export.sh", these existing tests:

  - 'fast-export | fast-import when main is tagged'
  - 'cope with tagger-less tags'

are checking the number of annotated tags in the test repo by comparing
it with some hardcoded values.

This could be an issue if some new tests that have some prerequisites
add new annotated tags to the repo before these existing tests. When
the prerequisites would be satisfied, the number of annotated tags
would be different from when some prerequisites would not be satisfied.

As we are going to add new tests that add new annotated tags in a
following commit, let's properly count the number of annotated tag in
the repo by incrementing a counter each time a new annotated tag is
added, and then by comparing the number of annotated tags to the value
of the counter when checking the number of annotated tags.

This is a bit ugly, but it makes it explicit that some tests are
interdependent. Alternative solutions, like moving the new tests to
the end of the script, were considered, but were rejected because they
would instead hide the technical debt and could confuse developers in
the future.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t9350-fast-export.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 8f85c69d62..21ff26939c 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -35,6 +35,7 @@ test_expect_success 'setup' '
 	git commit -m sitzt file2 &&
 	test_tick &&
 	git tag -a -m valentin muss &&
+	ANNOTATED_TAG_COUNT=1 &&
 	git merge -s ours main
 
 '
@@ -229,7 +230,8 @@ EOF
 
 test_expect_success 'set up faked signed tag' '
 
-	git fast-import <signed-tag-import
+	git fast-import <signed-tag-import &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
 
 '
 
@@ -491,8 +493,9 @@ test_expect_success 'fast-export -C -C | fast-import' '
 test_expect_success 'fast-export | fast-import when main is tagged' '
 
 	git tag -m msg last &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1)) &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
-	test $(grep -c "^tag " output) = 3
+	test $(grep -c "^tag " output) = $ANNOTATED_TAG_COUNT
 
 '
 
@@ -506,12 +509,13 @@ test_expect_success 'cope with tagger-less tags' '
 
 	TAG=$(git hash-object --literally -t tag -w tag-content) &&
 	git update-ref refs/tags/sonnenschein $TAG &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1)) &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
-	test $(grep -c "^tag " output) = 4 &&
+	test $(grep -c "^tag " output) = $ANNOTATED_TAG_COUNT &&
 	! grep "Unspecified Tagger" output &&
 	git fast-export -C -C --signed-tags=strip --all \
 		--fake-missing-tagger > output &&
-	test $(grep -c "^tag " output) = 4 &&
+	test $(grep -c "^tag " output) = $ANNOTATED_TAG_COUNT &&
 	grep "Unspecified Tagger" output
 
 '
-- 
2.51.0.438.g6987fc0bae

