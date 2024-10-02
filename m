Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F3200105
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866544; cv=none; b=JL/JqaFPj49JzO+XWKymaLUeydqUlO2Mik06Mg9Z5WMdlLDznrj+Jh9ClB4tO51zZ7R7S2Ao10MUW3P9+8ZzFDSkQUG7QHBzqCmuuZiIOyhoI0pdOChKHH8Vyja4CbuC3bXVIIdI7swNN4Vc7RNTVSJDITbfD7I7DpPxywmZuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866544; c=relaxed/simple;
	bh=HAZn7FKJtYx9iNL7XcynSsh5SddqPpNN/am2RaaFCOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HruGqY2iFsB9QG+9KRkKPDBgDXAqeL1vM6/uR7Iz140JsfyfkndS45jFNy8YHxTl5wgIbtqnL2YkLbSOltLn4YDqyzaizp6wmRRpd8L7cexU6JsVD0yyCtcvofHErMGHD+Ip5X9Y3UGtbTANo6bHYkkFNzDc3AcwbHHtP/1KiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LB9DGtBF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EGJRqgk9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LB9DGtBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EGJRqgk9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BCFF313805FE;
	Wed,  2 Oct 2024 06:55:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 02 Oct 2024 06:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866541; x=1727952941; bh=G4xisZdc3k
	gCBCaRMJypxCwjzpimxxwWG9OL8OEph+A=; b=LB9DGtBFY/WEeyFu/uQGGkpr5t
	Pqxs5TSb+WKRkezRmYFQ6t17fmDZ4mkJgJz+39b+gFgW3OQH67f2fglakx0GC/rN
	eyk4y20vwDUittyGjYXuiXOxf+0JLkMyyG/kOs1nkm04HhSlA23Z/eLJlLyDKpv/
	WRJc0lFMCP5eGMC+yQ6uhI9M+VPLuADC2bKaX9/P/NBiBW91XmOh1F1lANTBRAc1
	vV2pE3d42kzprlTSmPgPV/DfShJMOytplMwMVq4CjUkoRPdTjLsFaM143K1BZVm+
	0sOZ7acdoeOBbLQOCsmZ/2Qzw+0ZByrqbldD/pz/pKVhmfyRCpM1TU6bHjqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866541; x=1727952941; bh=G4xisZdc3kgCBCaRMJypxCwjzpim
	xxwWG9OL8OEph+A=; b=EGJRqgk9Ls5hX+YiW/V9edDaImFUuv7SyPKZxZzZZZsc
	TQAZve6duCytE+pq08nSJR3rbyvYfeYbpsX9nSbKN+pjC1G9pc+HZSD80zYl+oVE
	gXyaXopx7ZSwlThQD6Omp7ndTEJ6zmcMOrbb6hWEJ01rWcQwNIUPoE6KIPNUt3Ed
	wntNeT7MOJFM6vzv/Bxc3KSvpaHh1Y9TO+D50gy8V9el/qZ+erEzn7+s+DIsBmcw
	R6wSJVDAYbS7VOCa+BzDrA6HRoMPdVuExrWHgvi2qDVHPSB32Px1IwchqAa0mlPj
	ZgNtAaFAn/UtFwT5P4ezTbZvgQAvTrhYGXoXOBRqhA==
X-ME-Sender: <xms:rSb9ZjLNGWa8m6Iqfhf7Ji-402nJcsO1Nx45jsdGfNGzfMC3gKHL_A>
    <xme:rSb9ZnJmZXWgcYiofErX5Ef_q7kGoz0wYjL-0UIO21wRI9ezXTemz4-OZSJUC3hqJ
    arke3WJn1PZbtUtrQ>
X-ME-Received: <xmr:rSb9Zrtir1rlY_tNgpkdY5-2ya9LpCD2Xq8qgYe8BjGIFjDCq2ZhSBfiOCOzpMIEWoXbaNJg3sDyjPH6A0TDNo9TwdOomXV_bJHgA8Mm5kAaye-f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhm
X-ME-Proxy: <xmx:rSb9ZsZ3qKKuYxcVF4ta_rk31-GaQMgtouj215jXO4Qx151C_S-jew>
    <xmx:rSb9ZqanIvhZXV-mxfq5XT7AbpXQiTCeoNoBlR2wfPSnWKIwJDwtIw>
    <xmx:rSb9ZgAiT8sfeURojcbz4qTmnGuyZb6qUKEpltHDT_B5TRyS5Q7EpA>
    <xmx:rSb9ZoYL23ORrV6m6grWO5k7McyUlZUob7w39v9O9JFtJ6bu6LYnLA>
    <xmx:rSb9ZhVFtDRae79Kq8zJN35xqRwhnwE6oe9CTIJQO7TgaQNYs2hx59Rm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9923bc15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:50 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 05/25] reftable/basics: handle allocation failures in
 `parse_names()`
Message-ID: <bdfddbebce9f77959fd9544cd5ba3496d5b9dccf.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

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
index 3350bbffa2..ea53cf102a 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -135,14 +135,14 @@ size_t names_length(const char **names)
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
@@ -152,14 +152,26 @@ void parse_names(char *buf, int size, char ***namesp)
 		}
 		if (p < next) {
 			REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
-			names[names_len++] = xstrdup(p);
+			if (!names)
+				goto err;
+
+			names[names_len] = reftable_strdup(p);
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
+		reftable_free(names[i]);
+	reftable_free(names);
+	return NULL;
 }
 
 int names_equal(const char **a, const char **b)
diff --git a/reftable/basics.h b/reftable/basics.h
index f107e14860..69adeab2e4 100644
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
index ce0a35216b..498fae846d 100644
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
index e5556ebf52..1fa77b6faf 100644
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
2.47.0.rc0.dirty

