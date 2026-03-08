Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D730F95E
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993061; cv=none; b=U9GPHokmXJtU6mjDDQo8VsFk1iwxaqEUj7gHiksRkWfXvdo7w8hwn7TrRJPaXAhYLWa+pLDoqoK3pOVRX3OAt5/QHZ9CYzrvPj3aVcxSUBB8EhLZ4rpDuuAofkr5FZ0DjtgnaMRNtcZmufZYgNzOSAwU8EkOr49AAPQzEqH79L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993061; c=relaxed/simple;
	bh=w4j82fP9z70KNoGWOH7SNvUN8d6tewamEWKkq5DWep0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZziVy3kBZ8E0KSZ3u1kdnH6Gcc/eoZ2t6nSwXk6ahMaglkOYC5HOlkliqHusFyXm4jhWfF1U+dXrl6EuBplXdUI77t7RdSYJC3Wxbwy7mIe+GOlbEPL6H3qyKqrjULMKQRoRRlmrWKcKPAhLPO/vH6/uI6UT5oK80Cza2TmzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ+A4ImW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ+A4ImW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7377119453so1996678a12.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772993060; x=1773597860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pOfqTtoECIBI2dnf+RSfaKx4s28mS9z7INyIm2Q/pQ=;
        b=eZ+A4ImWm0eX/hiJviJ2CDTpj+H6J0TEKDQ6gDq7VaswjHoDmVxjTpmKYkhjRIHW5c
         biHpscTjXhuivmRI1dOPTKNFbLUBH0v4Nzkqp471eLYvLknvEuMpHNkUodMh7Eq+YtK0
         J64QLliAwLLiVH3fdM9ISqbT65ICQ0iffdetVTxHyiXeMCFTotS7Gu+e2trcs6/5grKU
         yemPbRZxSj37llzrEi/rtBuzgTQc0qcRRIhKyD8B8+k13GWS/H0CTe4CKC9FZgd/I9cR
         MH79PV0ovaS+j8SdWOHRDYJ0HvCMWEt69UJbBKTE2kn3D84PQ/BP1fSV39Vnwaa/Aco9
         yhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772993060; x=1773597860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pOfqTtoECIBI2dnf+RSfaKx4s28mS9z7INyIm2Q/pQ=;
        b=JTsGqlvahOR2rU0kmr2L6gpHET3maF1WnntytPdfy/ks5obzIzUDtQbBLbpOCX9o67
         v5jtcVTwY1MbQUVoncAwrsvv9ODFp/GsrjPNfwNUVf1xtltkgii4m0ngj9U54A5gjisv
         1HNrN29kbQEmUyVPfOdY0/R704Xs4ab94RiHTl1zbB09Lb77uZkQBCPLMvAx2OCa3KHx
         zGPsED0akWSI0H7W07/2UmEVInB4J/Tw+HDv6LQpPdRM9JClD86YpXU/P3+2CHUp360e
         6WrHXF1ot0XiWBT51HSlcDp+g8s30HUrrEOATIO1J5atvsjRIPBWFhA5L8PR1n8xsp+Z
         Uoog==
X-Gm-Message-State: AOJu0YwROj8Hf05IxNAQx+SmWHDXdCJouHtyd8Wo7RoJOKGc4/ZTwTww
	DzyYnLR/NLvIqGKLgqsDrAx7GEvVP00GDn2j9tgSCmI5UfCaoDijdWcrgxPPaA==
X-Gm-Gg: ATEYQzwWZTd5aULJLPNYFcQ32fWfyhKB7QDTNi7geF4DN+x6lI9jnTaHLDsaykoW0ed
	p+7NiFhFCIjgS++VhMPvk8zpvkBSL0y4dbyZu7lhYI679tSdJpVg2Fyjx+CHJ0TYJNltt216KL8
	ceZLXHzuYqzgUMo7BlCcLS597ycBPMeo4h32+8eSw7S/ZBfmqsacv2fPVZEix0xWn1TlMLu1Q7X
	GU3Cq5xN+QrdDopNrA+OnvWBkyYxn2BG3Ux7WH18c0uIsac7pnMxBCyBQqdm9yIMBlDquvPDngU
	48wUtSPMV/6dCGtasfe6w7JN+LoBTShl/HhX35T2aekYtmVdxgIkZATmqWwj2ZOpOPk34TKgfzZ
	OTsx9mDTHNjaIFPip/HToRhuZhTzCDC50nDgO9yE21TYwEm6XGattUQqpRD7gg6EEMd0w7QJBS3
	fgSD/BwG6I84lv2K192djCYpmG0SqQi217/UW4hiPU8u01HIw6nRSYzvc=
X-Received: by 2002:a05:6a21:3e0d:b0:398:6b9a:675f with SMTP id adf61e73a8af0-3986b9b92c6mr5136969637.63.1772993059737;
        Sun, 08 Mar 2026 11:04:19 -0700 (PDT)
Received: from d ([49.43.41.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636a92sm7835541b3a.1.2026.03.08.11.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:04:19 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v1 2/2] list-objects-filter-options: avoid strbuf_split_str()
Date: Sun,  8 Mar 2026 18:03:59 +0000
Message-ID: <20260308180359.31188-3-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260308180359.31188-1-deveshigurgaon@gmail.com>
References: <20260308180359.31188-1-deveshigurgaon@gmail.com>
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

Walk the input string directly with strchr() to find each '+'.  Copy
each sub-spec into a temporary buffer and strip the '+' only when
another sub-spec follows.  Change the helpers to take const char *
instead of struct strbuf *.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 list-objects-filter-options.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 7f3e7b8f50..f536085a7c 100644
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
+		const char *sep = strchr(p, '+');
+		size_t len = sep ? (size_t)(sep - p + 1) : strlen(p);
+		char *sub = xmemdupz(p, len);
+
+		/* strip '+' separator, but only when more sub-specs follow */
+		if (sep && *(sep + 1))
+			sub[len - 1] = '\0';
+
+		result = parse_combine_subfilter(filter_options, sub, errbuf);
+		free(sub);
+		if (!sep)
+			break;
+		p = sep + 1;
 	}
 
 	filter_options->choice = LOFC_COMBINE;
 
 cleanup:
-	strbuf_list_free(subspecs);
 	if (result)
 		list_objects_filter_release(filter_options);
 	return result;
-- 
2.52.0.230.gd8af7cadaa

