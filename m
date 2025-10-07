Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450D2DE714
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840246; cv=none; b=WfN1sdSTDa22PPoQYDVchGp/kIWBgWpEdUMNXResEZhL1bT0BYoh8eiPlpGTN6f1dpTq8z34LDo+5tZuWOqf20IwLCUG31zs6wURWmSZxHVg6rFGqVO3KCyZ3bddGZTxG8ZrjmsdHq8XJqb+6cIOf/KfE1D+KO3QJjq8xwOarGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840246; c=relaxed/simple;
	bh=xyi25JHyc7+rLxukwqq4olFtQuQLGYG9haQooJow8NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVPV5I6DuD5mc4862yKh4/fCsikwynspYOOT6QasDZA6RzhTNAGZB04B0o41L2yzCcvnK6lVao+DhNmAFU0RZdwR+dHhV4nSltxK2RIgce1pZSeN5eFPByy8GPb/H47y37O6ajxuO21RZBmHNVmhvBDoLv40OlfQp3cIDwlYozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqnqoEv0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqnqoEv0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0308469a4so3555353f8f.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759840243; x=1760445043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kjb5JZHG+6QTQQHbpR0DA1f7jQzPWc9uix9qH1/dK0=;
        b=DqnqoEv0+Lfe1wxLUU7M0yHZjylaWEHuucYExwwhLeA4NVIKySLmHuEf+jUv6vozTW
         oEFvJK+8e387bO6hMdJmK71naX0Kk0CJMMaBMRzwMWqj7n5+ftAugSR9bUAIAgvGgi6F
         E6Up3iVX17DiJBt0O5Iayo7uxtRl2Z4CUC2zWc8s5esMOMltx9xykJ8kMgyMftflprcO
         v2qgAsKSyiwf/25SPUSLYqglwamKfZ7J2EhHoKf9yTp7oURRsDHdF1sIg6egscVn/DD1
         yhs2WDCude3F7TTHsWl2v2h5GsjLtMKVdtDs72bsahGmS8bP/j0vkwz6PSze69nMgaT8
         tYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840243; x=1760445043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kjb5JZHG+6QTQQHbpR0DA1f7jQzPWc9uix9qH1/dK0=;
        b=qHFv2vHN03iQ+R7e+Fzd2U/tn8bUVc1X+7dAjTd26qMR+ecmvTtJmTa5FUqbQO2r5M
         PwL+bx6uaroAt3tNi7/k0HLaHkkVSKtH0r+8IBW6M3SkNLcxm6Zammo/Xv+LsaBSToZ4
         RvOGk47KQ4NrM8/UM3E8ETsCjjSP7a574k0jnB3FVt6fkpC+MpfM9HeGB6lHm9WViDzX
         y4oCaOYGvNyjfdXoYWNI6lWY3h7Z7LcuAluACxtEQ7r/j5lcb1D3wQAh5NlsDxvc+AGq
         Bzf0TAU6SqmFyyvroPmKHcIHWQnJHk9imy7RvTZX76Zi2OWlvYUWkufQX8uvpimEIjON
         Eg1A==
X-Gm-Message-State: AOJu0YzV8U3MFByo06luSqIPFgLEwaOmNWw+sPQv+flcQdq8ql4hfNNE
	+xi16C/oAjBlRRwjBn1N4Og4n/JgSDmGGvOP5ycG6n79d66aN9JuNdck9X5JMfEf
X-Gm-Gg: ASbGnctXfz++t8RwgdfAd1zsyZ2c9cw07I/FgML6pwksHYN4zu9nDirtbWzF0+FLI1X
	vYmpkjkZ6HBj5fLJ7yxLUIz3c6bMJzJgObRgVyCWeCo/Y+vIPj/97y3pPFqiD8tj/6PcHzM6UvM
	wYRX+XFgbsuNi63Ku1Yw4gdr2FBysaDwBD4e1DNxpvibpZAB6V+8C2PhJQh0To86HY+Ppn+qqK5
	jO/vpTM9ZogCwjpZXGm4XV7+SvnkRiTXQiDRMZfir90TeCJqqX+iFAlyKAUoTpv9Y6e9dNAyat+
	lnxXxy+is81kPA+Fb2sJvZQiYjck8O31AziUgYCCjUhDt0zhZRixC/kWtMhgP5s3tV9rpua1jyf
	zxRBLZoPLDJ/89HNrbPCFvIVzTiK7EX2MhTMTCaRK5c0E0fYOTocrAnE39KZSV0EqzvYV0QuoFw
	==
X-Google-Smtp-Source: AGHT+IF/f1lBdsHZy2Wgbj522vLxLtFDGKDfvwYQw1zDnTiWP9SMDjVi76rhHJoT7LNmLh/rdQpW4w==
X-Received: by 2002:a05:6000:2011:b0:403:e61e:82e6 with SMTP id ffacd0b85a97d-425671c6d92mr11242727f8f.46.1759840242452;
        Tue, 07 Oct 2025 05:30:42 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm25476185f8f.43.2025.10.07.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:30:41 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] t9350: properly count annotated tags
Date: Tue,  7 Oct 2025 14:29:56 +0200
Message-ID: <20251007122958.1089680-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251007122958.1089680-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In t9350-fast-export.sh, these existing tests:

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

