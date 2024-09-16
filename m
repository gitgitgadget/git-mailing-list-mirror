Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05C158527
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489715; cv=none; b=rB9XJPr2dhawRC/nk+gejHOLNV+fa+S2QWWdgkkt4vdFGOzQ2JlQVe7IrGWwVCpeIXPuWQxBf3Bf+lrJ2eYHvbVUFjX5D6y4Jj2ldazQxkvB4RdSBl4usLBsL12iHdwnJskEAYNfnXmMCD7wF4BIdI3Vcbukvf3KwY+9fzNiQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489715; c=relaxed/simple;
	bh=Ofr6Tmii79+neGaKQYRCAGmshCISYKm8dtO2vQF5cgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMtRNEkA021gLNlkSOdZn3Es3wwveHe2kQXXn60aAzuJT9GUvOIKXco+QKD5MYvSUo602ZrKdykkxBy4ZHrUTLbJgjG08yYMO3j0LYGNC6iDaWlVYG3mby5LaTI91EpIkGnHjWhPvkha/csfVgbJ1JflAx8oktCR0M0KL7QO+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ud7BSMD2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHOzPvHe; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ud7BSMD2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHOzPvHe"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 804A111401C3;
	Mon, 16 Sep 2024 08:28:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Sep 2024 08:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489713; x=1726576113; bh=no9ZwsFyx+
	yOpy5alXBb0jGrhuWxKMEHPi14+erKWqc=; b=Ud7BSMD2GWAejGHHeYBW0dZK+7
	EbzIuKwncPkVhxlJ3HoGFhhidHoUxd+FmNWSv9AVJMdC22m3pSC1z6TXl/yKg06n
	qFytLqsTi38XmmljNQOCIsXGCkw8cdQnblWJg5B6Y3rIDZKWW/d6uVMpyGWl/kFk
	HCTJVahxPYA9OENhJrqOgVZmQvDDHfwF6ZK30IVeF1BLNhBEJTXDJbM6N6+Ump2P
	lNJ7m3U+bm5zhWW4TDscuoedbYG0Zd14EALNJVrqODX/bdh/85ALDoYeSFEMNQBO
	dFavPQHLX+FH3WDUHEECJpTMnFr/TCH/9Z4jXLz44bWE37MeL6rHUG0en89A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489713; x=1726576113; bh=no9ZwsFyx+yOpy5alXBb0jGrhuWx
	KMEHPi14+erKWqc=; b=RHOzPvHeXpoaWPGMFvBnF6/XNPWDZvXk/OKDDHkuNMOn
	+eUpW+8lb+BoSdidWvNWzkoAWFZLpi1yijqHg0iUzYLSZ+y695BkWStARb9g2bIA
	zCvvCXDwoJGdYMyAeb92nLCFHsj5hdW7OXkE45IXX1xtkKSYZ5Q/UHBSnpcTQMjv
	eblbsItNIDTAXastXTkNr+6oiEY590r/AfmludaTo5Si2NgqG4PywQpZueS/vzjL
	nENID+4mpEvuriXQwePs9JdQ2hdYjnI0elIWuiw+sQ2Drb4pBexBZFeUr+owQhUQ
	B411AN6DSVWB0w++GZIHiUClXLyUNI8JRuqN/AiUEA==
X-ME-Sender: <xms:cSToZsspVwV_I_I21W06WCYuXOfbOd3Fw9801Vb1OqxgIIkMJobdOQ>
    <xme:cSToZpdJw27Laxp5sKGQ-KrLKRytxNVa-DcSxEIfMPk28DocvmftEoT9A687PJsv6
    YBLk3n6PtGZn_fAYg>
X-ME-Received: <xmr:cSToZnxX2F00PAijgn5s_3V33cmQ43psKrxS21PvCY1gTQ2hpHf8NVOdcU75sd0FI-jNBLKBJ5kruVMkM1udouWUxnkUlTe3CeDXfBcssK_nCFXt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:cSToZvMT6sYBUqB3xcQ58S9YpsVodtQQ-tJGaugYW3WGkNsGMKKziw>
    <xmx:cSToZs-U3lm0N1u-h-K-H2yf_xjB86U1blD3S1mmwUEuXZWEX_0qtQ>
    <xmx:cSToZnXyMW_3lstiFc5P_WXSjRtq-6_Tbj3IiI3Pjy-QTmd3QQLecg>
    <xmx:cSToZlfrkqR2u-thCmBmI-RQqIljrG_IlHg24SyMfDMK8GX31w5zSA>
    <xmx:cSToZuLM06OZPh0JCbVqCTgRYTqerC-ytmQyfN5LjkY_AMNM6usE2wrl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90a0d468 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:15 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 05/22] reftable/basics: handle allocation failures in
 `parse_names()`
Message-ID: <1f98abe9812e7fe951a62680e842c592231f2bf3.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures in `parse_names()` by returning `NULL` in
case any allocation fails. While at it, refactor the function to return
the array directly instead of assigning it to an out-pointer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                | 20 ++++++++++++++++----
 reftable/basics.h                |  9 ++++++---
 reftable/stack.c                 |  6 +++++-
 t/unit-tests/t-reftable-basics.c | 11 ++++++-----
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index b404900b5d9..b9bbf061e9d 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -130,14 +130,14 @@ size_t names_length(const char **names)
 	return p - names;
 }
 
-void parse_names(char *buf, int size, char ***namesp)
+char **parse_names(char *buf, int size)
 {
 	char **names = NULL;
 	size_t names_cap = 0;
 	size_t names_len = 0;
-
 	char *p = buf;
 	char *end = buf + size;
+
 	while (p < end) {
 		char *next = strchr(p, '\n');
 		if (next && next < end) {
@@ -147,14 +147,26 @@ void parse_names(char *buf, int size, char ***namesp)
 		}
 		if (p < next) {
 			REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
-			names[names_len++] = xstrdup(p);
+			if (!names)
+				goto err;
+
+			names[names_len] = strdup(p);
+			if (!names[names_len++])
+				goto err;
 		}
 		p = next + 1;
 	}
 
 	REFTABLE_REALLOC_ARRAY(names, names_len + 1);
 	names[names_len] = NULL;
-	*namesp = names;
+
+	return names;
+
+err:
+	for (size_t i = 0; i < names_len; i++)
+		free(names[i]);
+	free(names);
+	return NULL;
 }
 
 int names_equal(const char **a, const char **b)
diff --git a/reftable/basics.h b/reftable/basics.h
index f107e148605..69adeab2e4b 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -38,9 +38,12 @@ size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
  */
 void free_names(char **a);
 
-/* parse a newline separated list of names. `size` is the length of the buffer,
- * without terminating '\0'. Empty names are discarded. */
-void parse_names(char *buf, int size, char ***namesp);
+/*
+ * Parse a newline separated list of names. `size` is the length of the buffer,
+ * without terminating '\0'. Empty names are discarded. Returns a `NULL`
+ * pointer when allocations fail.
+ */
+char **parse_names(char *buf, int size);
 
 /* compares two NULL-terminated arrays of strings. */
 int names_equal(const char **a, const char **b);
diff --git a/reftable/stack.c b/reftable/stack.c
index ce0a35216ba..498fae846d7 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -108,7 +108,11 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
 	buf[size] = 0;
 
-	parse_names(buf, size, namesp);
+	*namesp = parse_names(buf, size);
+	if (!*namesp) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 
 done:
 	reftable_free(buf);
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index e5556ebf527..1fa77b6faff 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -72,13 +72,14 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	if_test ("parse_names works for basic input") {
 		char in1[] = "line\n";
 		char in2[] = "a\nb\nc";
-		char **out = NULL;
-		parse_names(in1, strlen(in1), &out);
+		char **out = parse_names(in1, strlen(in1));
+		check(out != NULL);
 		check_str(out[0], "line");
 		check(!out[1]);
 		free_names(out);
 
-		parse_names(in2, strlen(in2), &out);
+		out = parse_names(in2, strlen(in2));
+		check(out != NULL);
 		check_str(out[0], "a");
 		check_str(out[1], "b");
 		check_str(out[2], "c");
@@ -88,8 +89,8 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 
 	if_test ("parse_names drops empty string") {
 		char in[] = "a\n\nb\n";
-		char **out = NULL;
-		parse_names(in, strlen(in), &out);
+		char **out = parse_names(in, strlen(in));
+		check(out != NULL);
 		check_str(out[0], "a");
 		/* simply '\n' should be dropped as empty string */
 		check_str(out[1], "b");
-- 
2.46.0.551.gc5ee8f2d1c.dirty

