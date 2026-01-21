Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949749252D
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000418; cv=none; b=CgQAfmRxwLLo1eELZ4VMD1y9YXIKAk0D/7bXNhHn25ZQmX0hFMr7R0qIhIP0Bsyrv1KGBw5TZMvS19+40B9wt24N2BdAFqmh40W8pf63bQpMlvIA287UQhJ6wHXEj7hZMgflg0t9WuebjOeseTsGnp3bbtADeWS7HJQRuGLZ8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000418; c=relaxed/simple;
	bh=jl1yRIIWjaqGtMcZk6KSCHoiJ87CVDBOc56K/Jzvspw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L06jEj8VxcknRSt4Jaq3nqbYmOIiT5VgsIiRfUnheiUS+Gjvlc2BR44applxbIGSihok8JU241Ujh/iCY9fiSsCRKX+XHrBQN7qMRmNe6Ei++USw7akrqZy1NdccHOcGMz6fV82aq+jYLyV4WXx9d8SjBVbwBBuPdMUJaBUxoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecJFA9Kh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecJFA9Kh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso689632a91.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769000416; x=1769605216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN5OtJmaX0ADpthu1ZfZ8/zcAAe5lGBS/J2XeS++Z40=;
        b=ecJFA9KhB/Ey0f+XZiPBuccLZ18UUenkAuC5VAvCq8NPtzqU9Rw8XLCS53FwJrwMZG
         TGbZRj4dAwWx9VZ+UdxLLw1K7Z8oub47CYfbzqK1ND5Ju2zay6IIiKeHeL18KHTYAKBd
         K5Bv58dtiEUwKv2A3RccHENdiaRf6zcDcldTdpNoLBOxCTtBs6AmoeDwHcXt0M1B/bj2
         OgnJ59c1EGz7FeQXPNTN4nnohoGvdhOehgH4qgQ66ek2Yq4ttKrYL3VCdPb4cTBqyMXr
         Jgw7RZZZRXNil3NLBmO40mzemEwgCOrQBt7S9dUNmiTNPixeBVpVmT74n/i5H0wqiwqL
         jo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769000416; x=1769605216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eN5OtJmaX0ADpthu1ZfZ8/zcAAe5lGBS/J2XeS++Z40=;
        b=gTZiswaGjnPv9VMMS1pjmsMz6ZZ2Xx3srwyUFNoBqSHVkVSb+FDyOu8pOtYJhyiiri
         bcgcO0zchm8049CNZBHjH4mS3sPPw9b3+8wv7xnIy7g48c98kkuo/SyY7KuGcLBobd/o
         nhTB8gu8yy5p78kGTR1ZFDHWyPN2fi3wrwzi+qlAiVHufqvEl8yAzpVYuq0qWLtBKW60
         R5Pn66NG6KbZY4aydO2qht7zkPt1Pu0spDMA5n2lEZFwQQbG1Pi15zc0SzzZnkgGtoDQ
         a+YWHw+mQD/UdH/ew/eyO0cF9sbpX6odQMvzeU8HuJ9ydE8wjDvnNZ88+94TjU8oJBXI
         0SAQ==
X-Gm-Message-State: AOJu0Yy/DYSeN8021DRSs02gL2vYvbznQ+IGmfO03e16eXsRRYRqiyhx
	t1eQsOQo7jsJ6spH4wmedtwjdOOpY5QjDK0wLa0YrqLcvXqgryDfwUUSG0duz85x
X-Gm-Gg: AZuq6aIz4qiF+gpajoA3F/K2+sysuYJh79VajZfrpS2hVD258qDtczN1TFqb7/7N5QX
	+Y5/c8qPwmsqdXYadbVEZTyTfQbGl9zbJcEcKNrEtgGKhLBVWhMpl6j7b0kVxsL2/iNKI8RLeX4
	2y7h6WMQY5MkwP0RtlgEhjJE/9/ghGTFC6kCLcWGUz4/Tg3X78z8b3XolP6ef4heRaNsYSoIpA4
	CMfHcofa1Niprow9nWTXXrB9YjLOz2VORPDoQ1AHGRtfdMgJZBz2/m5iETJjdV/OvB4z9adT8pi
	cTxg+alZjznJuQU/Vz2ktR0iwSlq9Cm0XJ1OeW5ymLYsgKSVKKajhiR8FB1kfFCNehsceZ4VUku
	Cmrm7cFzW7lvTBDaJ7ifp1Xzkyx4f4WybS2TxtxFPcCaeq1pI9BFpL7E379JKYfPmbgwghPbhLg
	Vatm4phNAv/q/nvRdJwPstZKp9dStEbcp9IL3H8bnvOrfgYsS671LFGIUV9jPhmHKhTCLS
X-Received: by 2002:a17:90b:4984:b0:34e:6e7d:7e73 with SMTP id 98e67ed59e1d1-352678b93d7mr18716734a91.11.1769000415491;
        Wed, 21 Jan 2026 05:00:15 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677c9315sm17771142a91.2.2026.01.21.05.00.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Jan 2026 05:00:15 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Amisha Chhajed <amishhhaaaa@gmail.com>
Subject: [PATCH v7] sparse-checkout: optimize string_list construction and add tests to verify deduplication.
Date: Wed, 21 Jan 2026 18:30:05 +0530
Message-ID: <20260121130005.72375-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120153829.48044-1-amishhhaaaa@gmail.com>
References: <20260120153829.48044-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve O(n^2) complexity to O(n log n) while building a sorted
'string_list' by constructing it unsorted then sorting it
followed by removing duplicates.

sparse-checkout deduplicates repeated cone-mode patterns,
but this behaviour was previously untested, add tests that
verify that sparse-checkout file contain each cone
pattern only once and sparse-checkout list reports each pattern
only once.

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/sparse-checkout.c          |  7 +++--
 t/t1091-sparse-checkout-builtin.sh | 48 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..7dfb276bf0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -91,10 +91,11 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
 			/* pe->pattern starts with "/", skip it */
-			string_list_insert(&sl, pe->pattern + 1);
+			string_list_append(&sl, pe->pattern + 1);
 		}
 
 		string_list_sort(&sl);
+		string_list_remove_duplicates(&sl, 0);
 
 		for (i = 0; i < sl.nr; i++) {
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
@@ -289,7 +290,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	string_list_sort(&sl);
@@ -311,7 +312,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	strbuf_release(&parent_pattern);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b2da4feaef..cd0aed9975 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -817,6 +817,54 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	test_cmp expect out
 '
 
+test_expect_success 'sparse-checkout deduplicates repeated cone patterns' '
+	rm -f repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout init --cone &&
+	git -C repo sparse-checkout add --stdin <<-\EOF &&
+	foo/bar/baz
+	a/b/c
+	foo/bar/baz
+	a/b
+	EOF
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/a/
+	!/a/*/
+	/foo/
+	!/foo/*/
+	/foo/bar/
+	!/foo/bar/*/
+	/a/b/
+	/foo/bar/baz/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout
+'
+
+test_expect_success 'sparse-checkout list deduplicates repeated cone patterns' '
+	rm -f repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout init --cone &&
+	cat <<-\EOF >repo/.git/info/sparse-checkout &&
+	/*
+	!/*/
+	/a/
+	!/a/*/
+	/foo/
+	!/foo/*/
+	/foo/bar/
+	!/foo/bar/*/
+	/a/b/
+	/foo/bar/baz/
+	/foo/bar/baz/
+	EOF
+	git -C repo sparse-checkout list >actual &&
+	cat <<-\EOF >expect &&
+	a/b
+	foo/bar/baz
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'malformed cone-mode patterns' '
 	git -C repo sparse-checkout init --cone &&
 	mkdir -p repo/foo/bar &&
-- 
2.51.0

