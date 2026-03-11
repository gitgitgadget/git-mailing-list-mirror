Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CA24E4A1
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250437; cv=none; b=N+jbuweRxa1qfZzbwX8EdIDpHmcDUpg2ttUZMnFO6ETk0szjfnsQ0bJ8Dshdof6LmLUHQP+RSZA7ZvICjpz1MhUWEtz/nysNJu4efscbsc3fk8hCP8X5/zJG0Ny/qocPqfLyByiWj82dpHkUnssizXdMkvFsgj6dCUavTGIMUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250437; c=relaxed/simple;
	bh=EQsVUxBvfdoniZz3oycT2WMJou2Kyh3fryGCcesYhhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcYCFTxcTs099TR3SeUNIQxSdxLQG0Ch1lfTrUqP5PxibzjrPtRxAwmYIJmZEHiVwsgOmc1WM2s6tPy+2vPYEm3rZRsNzFJsE/BgKaiwBGunsCnX4X15wbTnBSw8ltLIVsqwVStBh5YBZfvhDvH/6RrhCXBB9nekr5Sy4/lKQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mufGpiBK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mufGpiBK"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3598e065d8dso41177a91.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250433; x=1773855233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kBv5pwWLcaseCHPGgRgWL4kZV44Lc9qtN9aM+qAO/U=;
        b=mufGpiBKJHKxfFEpQbeEaMk8ZUXLCnF4Ujyl7yqnws3RHVfHwtxqtiEqcXbTL9Mbh3
         0v7okXt51/FZAwmBkLiXjXhFJkT2FX8xDlRCJTjPHR3EhcmdaPvM5T+jT9l7SKlviDLP
         5jWlZR5wB7umogCIOf0pgsJg8F8bWHGWsQtaywRTGkCOOprEbfwrXLsO4Nzdbr5yzxMO
         E0bjptYB8FptSsdzrq2XTH4u0efE3s8xuNhzZf3k9msSAnB3J9g6PGaAe/Snk39NHz1U
         UxduhG+X5u2pB2HMHzPFR665VXw3QorGBJnD978ijS85lMWKgcH0IbA2V5zkfMTxdXB4
         pwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250433; x=1773855233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kBv5pwWLcaseCHPGgRgWL4kZV44Lc9qtN9aM+qAO/U=;
        b=ORYbllWfGFYC0uo8XNYBubQyKdShWYc7/ZBqaMhjxvAYkM7XrN/meliknW2AsIlJv5
         GvxycY2KbNQH+lszK35coGTBp+rHTYy5JdQvnn/QEXiukCmNrnQP2N+7Oas+Q+u23z8W
         ZRBXSejHifbVNSDGt8GkGLeW3vyBSPaVftGLeTkoPLctttqJHcR6+OXOZSOkqu+ZtWhg
         DDuxLifZ0CaGmqFak5eo8p2ajbZcnNMBRupCylCaFiVLRLP0xJp25Z3B9J9wDzmK3p2+
         WAbKotHo4PeBKlpISreNZDtCNOiNifLgP72NLiKhSiqbcVhr/bM6HAKm6HnjHLHVXFol
         3Qgw==
X-Gm-Message-State: AOJu0YzfbW9CdWQ1+2lsPiKWTwqb8I0rzxM0Lyw72nMdGSyq+CtCUMpU
	qyW4KjkxuZmCJZW6gC80m8zCDrmpy07V3D7Ih1yusI88ZxleGxW64sodfhPGag==
X-Gm-Gg: ATEYQzwjuoIc0Ex7sl6YS7K0rNi5oXPj+hbybQs1V4xLDI9mwx941SHTS1SK4OuTO0c
	q/SMMYBN1F8yhOt/XOepG7KaiRp6OndGuNwOwfOf+75V+JlbqpBNP/Q5GF7hkIYxmX/9fAd5A2Y
	uR9YMSSJKOGQHB/fWYoPoyXaqnKPXUnAhtOqIA+LneKBpm4XXJGpOz1d+TSLqdaK8xOdfcd6Iqp
	mZm2lZL8FIm05XS/8isQL+1srhLfYIm5yIUWWlCXjmPnnbO+fRk/zewsJfVhdhsTNW6jsUw65HX
	CJQ0Jhb6AjK9pEaxLjVNje+uD76BkOkNFcP8lftTeP6O4ZTu8cl+jUWD4jny2+m5Zg86fwdKhZQ
	Z8pKAW0HF2HBmrLSNw2z0u/n62hAbh2iq34Of3Tto6LYdh9qHKJBwn4bBJ9QOGVtH60WaTe37sT
	nHhWVEwWdeGFtOfZyv+elYtocJ819zhHEAqmFzfZmbzT9A9XqcPj5myK6l2Ep4VZsRJw==
X-Received: by 2002:a17:90b:3a8c:b0:359:9bad:13d2 with SMTP id 98e67ed59e1d1-35a0137dfd4mr3099649a91.34.1773250433001;
        Wed, 11 Mar 2026 10:33:53 -0700 (PDT)
Received: from d.iiitdmj.ac.in ([14.139.241.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0f6d190csm749973a91.14.2026.03.11.10.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:33:52 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v3 2/2] list-objects-filter-options: avoid strbuf_split_str()
Date: Wed, 11 Mar 2026 17:33:36 +0000
Message-ID: <20260311173336.8395-3-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260311173336.8395-1-deveshigurgaon@gmail.com>
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
 <20260311173336.8395-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_combine_filter() splits a combine: filter spec at '+' using
strbuf_split_str(), which yields an array of strbufs with the
delimiter left at the end of each non-final piece.  The code then
mutates each non-final piece to strip the trailing '+' before parsing.

Allocating an array of strbufs is unnecessary.  The function processes
one sub-spec at a time and does not use strbuf editing on the pieces.
The two helpers it calls, has_reserved_character() and
parse_combine_subfilter(), only read the string content of the strbuf
they receive.

Walk the input string directly with strchrnul() to find each '+',
copying each sub-spec into a reusable temporary buffer.  The '+'
delimiter is naturally excluded.  Empty sub-specs (e.g. from a
trailing '+') are silently skipped for consistency.  Change the
helpers to take const char * instead of struct strbuf *.

The test that expected an error on a trailing '+' is removed, since
that behavior was incorrect.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 list-objects-filter-options.c       | 40 ++++++++++++++---------------
 t/t6112-rev-list-filters-objects.sh |  4 ---
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 7f3e7b8f50..cef67e5919 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -125,9 +125,9 @@ int gently_parse_list_objects_filter(
 static const char *RESERVED_NON_WS = "~`!@#$^&*()[]{}\\;'\",<>?";
 
 static int has_reserved_character(
-	struct strbuf *sub_spec, struct strbuf *errbuf)
+	const char *sub_spec, struct strbuf *errbuf)
 {
-	const char *c = sub_spec->buf;
+	const char *c = sub_spec;
 	while (*c) {
 		if (*c <= ' ' || strchr(RESERVED_NON_WS, *c)) {
 			strbuf_addf(
@@ -144,7 +144,7 @@ static int has_reserved_character(
 
 static int parse_combine_subfilter(
 	struct list_objects_filter_options *filter_options,
-	struct strbuf *subspec,
+	const char *subspec,
 	struct strbuf *errbuf)
 {
 	size_t new_index = filter_options->sub_nr;
@@ -155,7 +155,7 @@ static int parse_combine_subfilter(
 		      filter_options->sub_alloc);
 	list_objects_filter_init(&filter_options->sub[new_index]);
 
-	decoded = url_percent_decode(subspec->buf);
+	decoded = url_percent_decode(subspec);
 
 	result = has_reserved_character(subspec, errbuf);
 	if (result)
@@ -182,34 +182,34 @@ static int parse_combine_filter(
 	const char *arg,
 	struct strbuf *errbuf)
 {
-	struct strbuf **subspecs = strbuf_split_str(arg, '+', 0);
-	size_t sub;
+	const char *p = arg;
+	struct strbuf sub = STRBUF_INIT;
 	int result = 0;
 
-	if (!subspecs[0]) {
+	if (!*p) {
 		strbuf_addstr(errbuf, _("expected something after combine:"));
 		result = 1;
 		goto cleanup;
 	}
 
-	for (sub = 0; subspecs[sub] && !result; sub++) {
-		if (subspecs[sub + 1]) {
-			/*
-			 * This is not the last subspec. Remove trailing "+" so
-			 * we can parse it.
-			 */
-			size_t last = subspecs[sub]->len - 1;
-			assert(subspecs[sub]->buf[last] == '+');
-			strbuf_remove(subspecs[sub], last, 1);
-		}
-		result = parse_combine_subfilter(
-			filter_options, subspecs[sub], errbuf);
+	while (*p && !result) {
+		const char *end = strchrnul(p, '+');
+
+		strbuf_reset(&sub);
+		strbuf_add(&sub, p, end - p);
+
+		if (sub.len)
+			result = parse_combine_subfilter(filter_options, sub.buf, errbuf);
+
+		if (!*end)
+			break;
+		p = end + 1;
 	}
+	strbuf_release(&sub);
 
 	filter_options->choice = LOFC_COMBINE;
 
 cleanup:
-	strbuf_list_free(subspecs);
 	if (result)
 		list_objects_filter_release(filter_options);
 	return result;
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 0387f35a32..39211ef989 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -483,10 +483,6 @@ test_expect_success 'combine:... with non-encoded reserved chars' '
 		"must escape char in sub-filter-spec: .\~."
 '
 
-test_expect_success 'validate err msg for "combine:<valid-filter>+"' '
-	expect_invalid_filter_spec combine:tree:2+ "expected .tree:<depth>."
-'
-
 test_expect_success 'combine:... with edge-case hex digits: Ff Aa 0 9' '
 	git -C r3 rev-list --objects --filter="combine:tree:2+bl%6Fb:n%6fne" \
 		HEAD >actual &&
-- 
2.52.0.230.gd8af7cadaa

