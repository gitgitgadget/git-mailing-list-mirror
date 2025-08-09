Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDD2AE90
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754713382; cv=none; b=sI/AStFgyp3i8w+EFCG+4jz/nm2+GJpGByhx2Y6HmGcbsKcuq5aCBukh919z4q1FlTvM2/R75zgJv2BduYV141bUh1YUXK3VQ0mSIDLDPrw/UrNBYkpPPZ5a6V2KKU/p3xcJKeDilvIS3XF3gCnnrbpLJCqnFZfHDxTEXgRJe40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754713382; c=relaxed/simple;
	bh=MH0bqi5y1JjK/2Blur7YTqBz+CqBMsGYOVlB6378hWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJdY84Z1eop47a6NILVxfqWn7QnV3G5YOc1NlS77zMh6AfNW891L5xSxMEuuupfFFQsxZv+/NkwK4+Ef++hkLVQ+rTKn/DQ1jhKdoDm9aYhZyB4vZfRfOK/0YOxDBms99cFY8a0SHWMKA84LR/LxIIM0X4xZRlcRH0gnAwpVnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkwP5CM3; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkwP5CM3"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2318089a12.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 21:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754713379; x=1755318179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KEzJuW8EpGLLvZNgythwTZZDT2mj33aQNvYJ5x95pA=;
        b=MkwP5CM3w6He6pOW87y4T+kWVoQaTVWgiyt7cMYdNOM25xEUBO2EtSp5DzM/H9lQid
         JTklvTAhVnSEo8bUN0QtRaFnRHaDynz8/Lp5Dm7KMYDdIsP62fA45VdjNf9M8Lpc6iUH
         PlDv6e/lY48GZs3zZBxlAcDqyEfUHMQSW9ZIg3ypigYEIQa6A3kP5mYks7eUAf73CYKA
         /DT0TGScIYu5qS+pak9Jch+ZydmyfU4XnYpg6s7NbfXIvtJQr/oTu+OiWgtDl2N2Aq3p
         i2SwL8nILJoVwWiL5i4NptM+1UccqDDt7yWOso0dYjFGP7gnfOo/eUVf1JJJc+gzpelK
         E0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754713379; x=1755318179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KEzJuW8EpGLLvZNgythwTZZDT2mj33aQNvYJ5x95pA=;
        b=tZ/IrqlsUATnIZL3KkVYJoFHKerIX8ZFwRt8wcxWrPWVvetPvKglNqNCiCS135BDMV
         B/tJvcG78JRiosedMxHIQZLp0zvbJATFDiz3ZtnIfQyjSmn0EDmaZoRNNvEjBKt8ifl4
         Dh8NdEXDBWkG6rNdceKTtiWU36gixmu22lWZ2AAx9Xvwj5k9ED/S9OJvPC+19iHBhZG2
         qIpqnTiRN8G1+6XkehAx/5phHus9NPQUdwWXM1wSCnve/PLUGqkZZyJBB2QljbDeAIxF
         m1jpAQwCc+b+VuGaOHzPlGXlhMcST7t50IHDLlBCHf9LYUHdCO1lrWDvmHK5p/62gYIM
         vTkQ==
X-Gm-Message-State: AOJu0YzkBauhkP1zWy6GznJDFbMWQCw3lvJ9wwuN16Mm/feWy8IW5U0i
	WOyqR4SRWcUENWPKtObigGwJQP6Z3NXY5DNOQlA34KX+UF7N6n18M5do
X-Gm-Gg: ASbGncsruUjET5IAvJUmEe7Qpkyxu3fIs9S1VeQS4d6MBsltJ6kzD+ZKWfBFVf8mRtl
	qP4vZAc3eKSNA6hoFrXlTlFs8zVGG79S779uLsZvp8udwGwd6a4cYgXhNpIxMsXZANTjkDAV6id
	EgNSd4zegLHkIYg8Xjnb4RFwBPUjvhOVZyW4r0eOl1sw/I802NsEFMm9nBoe8+HxidANxzN3cis
	Btg9NiCzOkpqAD4124Md3BuNLAjXfHPF20BvQx6qAA7MQCXx4QZHMI+VI7qsn/L/5JkOKrPk0tq
	gjeHA8kYH9fvc2kW84kb3Bo2ya4CKCtmdv8+b/I2eVSgtSChXZSUZT0vMh5tgHeawBjEYHTtAXJ
	pHwOlagG3QH7D83q2psnaTYZ1xGu+kZ7R38MPvD1SaBJXis+1ft9gQtYLHgMcIlrT
X-Google-Smtp-Source: AGHT+IGBiBK+a9tVf24f12e3vW7FXodvROYYMlITzM0MBLTMxuurWiHSF1joyqN8sd7AIh674Auj+A==
X-Received: by 2002:a17:902:fb4c:b0:240:7753:3c22 with SMTP id d9443c01a7336-242c21e09c2mr52838855ad.33.1754713379432;
        Fri, 08 Aug 2025 21:22:59 -0700 (PDT)
Received: from localhost.localdomain (awork062197.netvigator.com. [203.198.28.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102acbc56sm13005992a91.2.2025.08.08.21.22.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Aug 2025 21:22:59 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	stolee@gmail.com,
	ttaylorr@github.com
Subject: [PATCH v4] bloom: enable bloom filter with wildcard pathspec in revision traversal
Date: Sat,  9 Aug 2025 12:22:36 +0800
Message-Id: <20250809042236.72695-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250809021642.22195-1-yldhome2d2@gmail.com>
References: <20250809021642.22195-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When traversing commits, a pathspec item can be used to limit the
traversal to commits that modify the specified paths. And the
commit-graph includes a Bloom filter to exclude commits that definitely
did not modify a given pathspec item. During commit traversal, the
Bloom filter can significantly improve performance. However, it is
disabled if the specified pathspec item contains wildcard characters
or magic signatures.

For performance reason, enable Bloom filter even if a pathspec item
contains wildcard characters by filtering only the non-wildcard part of
the pathspec item.

The function of pathspec magic signature is generally to narrow down
the path specified by the pathspecs. So, enable Bloom filter when
the magic signature is "top", "glob", "attr", "--depth" or "literal".
"exclude" is used to select paths other than the specified path, rather
than serving as a filtering function, so it cannot be used together with
the Bloom filter. Since Bloom filter is not case insensitive even in
case insensitive system (e.g. MacOS), it cannot be used together with
"icase" magic.

With this optimization, we get some improvements for pathspecs with
wildcards or magic signatures. First, in the Git repository we see these
modest results:

git log -100 -- "t/*"

Benchmark 1: new
  Time (mean ± σ):      20.4 ms ±   0.6 ms
  Range (min … max):    19.3 ms …  24.4 ms

Benchmark 2: old
  Time (mean ± σ):      23.4 ms ±   0.5 ms
  Range (min … max):    22.5 ms …  24.7 ms

git log -100 -- ":(top)t"

Benchmark 1: new
  Time (mean ± σ):      16.2 ms ±   0.4 ms
  Range (min … max):    15.3 ms …  17.2 ms

Benchmark 2: old
  Time (mean ± σ):      18.6 ms ±   0.5 ms
  Range (min … max):    17.6 ms …  20.4 ms

But in a larger repo, such as the LLVM project repo below, we get even
better results:

git log -100 -- "libc/*"

Benchmark 1: new
  Time (mean ± σ):      16.0 ms ±   0.6 ms
  Range (min … max):    14.7 ms …  17.8 ms

Benchmark 2: old
  Time (mean ± σ):      26.7 ms ±   0.5 ms
  Range (min … max):    25.4 ms …  27.8 ms

git log -100 -- ":(top)libc"

Benchmark 1: new
  Time (mean ± σ):      15.6 ms ±   0.6 ms
  Range (min … max):    14.4 ms …  17.7 ms

Benchmark 2: old
  Time (mean ± σ):      19.6 ms ±   0.5 ms
  Range (min … max):    18.6 ms …  20.6 ms

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
[jc: avoid allocating zero length path in
convert_pathspec_to_bloom_keyvec()]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c           | 45 +++++++++++++++++++++++++++-----------------
 t/t4216-log-bloom.sh | 31 ++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/revision.c b/revision.c
index 18f300d455..79372fd483 100644
--- a/revision.c
+++ b/revision.c
@@ -671,12 +671,17 @@ static void trace2_bloom_filter_statistics_atexit(void)
 
 static int forbid_bloom_filters(struct pathspec *spec)
 {
-	if (spec->has_wildcard)
-		return 1;
-	if (spec->magic & ~PATHSPEC_LITERAL)
+	unsigned int allowed_magic =
+		PATHSPEC_FROMTOP |
+		PATHSPEC_MAXDEPTH |
+		PATHSPEC_LITERAL |
+		PATHSPEC_GLOB |
+		PATHSPEC_ATTR;
+
+	if (spec->magic & ~allowed_magic)
 		return 1;
 	for (size_t nr = 0; nr < spec->nr; nr++)
-		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
+		if (spec->items[nr].magic & ~allowed_magic)
 			return 1;
 
 	return 0;
@@ -691,26 +696,32 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
 	char *path_alloc = NULL;
 	const char *path;
 	size_t len;
-	int res = 0;
 
+	len = pi->nowildcard_len;
+	if (len != pi->len) {
+		/*
+		 * for path like "dir/file*", nowildcard part would be
+		 * "dir/file", but only "dir" should be used for the
+		 * bloom filter
+		 */
+		while (len > 0 && pi->match[len - 1] != '/')
+			len--;
+	}
 	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
+	if (len > 0 && pi->match[len - 1] == '/')
+		len--;
+
+	if (!len)
+		return -1;
+
+	if (len != pi->len) {
+		path_alloc = xmemdupz(pi->match, len);
 		path = path_alloc;
 	} else
 		path = pi->match;
 
-	len = strlen(path);
-	if (!len) {
-		res = -1;
-		goto cleanup;
-	}
-
 	*out = bloom_keyvec_new(path, len, settings);
-
-cleanup:
-	free(path_alloc);
-	return res;
+	return 0;
 }
 
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 639868ac56..1064990de3 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -154,11 +154,34 @@ test_expect_success 'git log with multiple literal paths uses Bloom filter' '
 	test_bloom_filters_used "-- file*"
 '
 
-test_expect_success 'git log with path contains a wildcard does not use Bloom filter' '
+test_expect_success 'git log with paths all contain non-wildcard part uses Bloom filter' '
+	test_bloom_filters_used "-- A/\* file4" &&
+	test_bloom_filters_used "-- A/file\*" &&
+	test_bloom_filters_used "-- * A/\*"
+'
+
+test_expect_success 'git log with path only contains wildcard part does not use Bloom filter' '
 	test_bloom_filters_not_used "-- file\*" &&
-	test_bloom_filters_not_used "-- A/\* file4" &&
-	test_bloom_filters_not_used "-- file4 A/\*" &&
-	test_bloom_filters_not_used "-- * A/\*"
+	test_bloom_filters_not_used "-- file\* A/\*" &&
+	test_bloom_filters_not_used "-- file\* *" &&
+	test_bloom_filters_not_used "-- \*"
+'
+
+test_expect_success 'git log with path contains various magic signatures' '
+	cd A &&
+	test_bloom_filters_used "-- \:\(top\)B" &&
+	cd .. &&
+
+	test_bloom_filters_used "-- \:\(glob\)A/\*\*/C" &&
+	test_bloom_filters_not_used "-- \:\(icase\)FILE4" &&
+	test_bloom_filters_not_used "-- \:\(exclude\)A/B/C" &&
+
+	test_when_finished "rm -f .gitattributes" &&
+	cat >.gitattributes <<-EOF &&
+	A/file1 text
+	A/B/file2 -text
+	EOF
+	test_bloom_filters_used "-- \:\(attr\:text\)A"
 '
 
 test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
-- 
2.39.5 (Apple Git-154)

