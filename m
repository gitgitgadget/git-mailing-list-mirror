Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434312FB0B7
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345359; cv=none; b=f02qDrX80Bd+2dkPXsyXi1bnOiMFssS1MoazlTjMj7IYZgQzuLpkmeOdGPkBFVtBJSovUeD6UocFtVThqY8qV35LsoxA2P8QwjCPbmdNmkpmhqZYhmooZrq2uO5uyLhk3PSNzjJ7hhdIKJlWZWj0jRlQ1mWNgnVgneRtqxM37Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345359; c=relaxed/simple;
	bh=Z/ERojsJHXA/6pN0s1OPbO1PCRgxayhgRQ2B8k4IR68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErD3Dd/fUs/8lIIlwlj5QGFm+FFa9BGq3L1mXZG9itT0GWNKB0i9UmNZwLuwRDlt3cnGFPMiGLd2OINi43DXNcLEl83pJV6pENTccu2nDEg3VrRpeyDk56ju78kgJpuZkEKpTabjDCfCc/NWYObrO0wpNcJhfjAI8d5d9Kj3l8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv18TmzP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv18TmzP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee12807d97so2451995f8f.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345355; x=1760950155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4xRwZCscrTBPhl4uLdfXTc5v172JGQJzGUtMB7Dy1I=;
        b=mv18TmzPwJpQtF0HEne7a6hoeAeqyJAaicKuwz/JvZUApvEQK3d5jw5RJmQQ0Feo0E
         yN7ch9KTslR7x7UlEC4FUqesPi6nR7eCuXdwqFhhTLid7qsKPtrGwNb/xLDT6LFyFSfT
         wQVIZnkvr5rfXUMIumomTbpWy5vrj4WGf/uur9wLxkteq1CTGvDSiXfqmXV9OfNfspvS
         8szFPZYzBkFlbNlzlavhilAq3WmCyzlDNaWTykADFi3+yCSji7Ar5TfWSLfr24sllNY9
         MBDymMfpGgfGQj5lvgVJPeGg1S5nPqWnligDIQ2yyFbC6CfLU2a7KsdwvDXe/3H5Yfy0
         asnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345355; x=1760950155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4xRwZCscrTBPhl4uLdfXTc5v172JGQJzGUtMB7Dy1I=;
        b=YC7l7a6yLyKrEg6VCV4bG41TtoVaV0Tnsnb3gsZsE7HDwwWydonSx8BYUdcdvL7EQR
         BQKdlR8sA5plTeBNzwF/3SZWOFWU07eFT1eXjOM1KhXokiVLZdHHIbA3jbAvAEkz5KH0
         w5wQoWmgXVAvEltm4ORLJguGBSHllwpl24rFa19BJVTU3Af8vubi6ngaTE6fxns8kIiR
         lElIeT5jxX/62YNTRqPhDFE/wSdtTi1HxMgELqOIR0MIDtKhsnXCrN0qmqDLq64trfQB
         LVPBHPQlKPMKXcJyFxeVwyVXK+rlN/KDgl2q6keTXYSA+Ij5q1F8zjo9M+vusKQAqeHv
         hpSQ==
X-Gm-Message-State: AOJu0Yyu4w5Q0dRmgESQL+FSSJqR4pXIZMrWYgxNR57fN88eD7M/LWbg
	WkURqg0YbdoM6Ye7ElO3NVbdKsEe+/e10TWCPLSmU+3AU8PhWXCQmj30qtP0NJUV
X-Gm-Gg: ASbGnctnCspzR8PaSj7d8zCqreb0ByiqZlufJ87qtYOtdH5chNqhXf8LZEIJfjS3rFd
	MKVUNaZZeVG06QXeZu/SNzBNDd7EbzESlVmTDr4ssFHa9K4RiRAerLk96p8dD3X0H+RDS8ZqT0E
	RzCnIe7KdEaV9jiy9cQf+KzRm5bt+mbAu4mgKyZJ3ytWwjRs5skJsOJSbUKdtwJBGhc0FRHjkYl
	r0THc7pogKGorY4IlI0HEgxcTDJMGklh+k1jmOz8Ui56V/0osbWWgUtTUAegqime/HmML4eK8K8
	r64ov4tOmw1vPy1xLQJ6rw6QK5Xcqk4jk1ica9s4nm5j4n+lFxneiwSV4exHOJYoFTkbyEHS6HF
	4fxg6tg/YiSe3I0kB8NqGEwbkgSmyjJi/AbgndgQtArQz2KVP9sY4vC0QBV4I/wR/tTov5ddC7Z
	cSrWU=
X-Google-Smtp-Source: AGHT+IGVX4lhtOivWgq5ZTP65AOWSpo7cM0p3J+5pE8cCQf6qO7S2WarBV7ezEXvJgHiDEIufSCutA==
X-Received: by 2002:a05:6000:41cc:b0:426:d56e:124c with SMTP id ffacd0b85a97d-426d56e125dmr4456797f8f.32.1760345354998;
        Mon, 13 Oct 2025 01:49:14 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm15630220f8f.13.2025.10.13.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:49:13 -0700 (PDT)
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
Subject: [PATCH v3 3/5] t9350: properly count annotated tags
Date: Mon, 13 Oct 2025 10:48:55 +0200
Message-ID: <20251013084857.1646783-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251013084857.1646783-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com>
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

