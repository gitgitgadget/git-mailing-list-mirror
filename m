Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35D19F499
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775725; cv=none; b=FSwNTzllr25wfE4fBwKjqvxwvyLbTl3YT8VJWvcuoTlzyYmiPilQO6yxT1AlmOndtlbZnMVv1Wy4TUVZplNyfrpvBMA/8H3YeN/NRihnavFODDyQ+9pNxkm6H2wMaT6aeVtPk27FgLKFizum271iOLgTs5PHcsv4/JjmQbxvBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775725; c=relaxed/simple;
	bh=HAZn7FKJtYx9iNL7XcynSsh5SddqPpNN/am2RaaFCOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugwa+SoI0XGuxkoFfMncaAttYGm/garo6UXDIUy19/qMseQPjd0h2PByZxC8FnQYURjbYD10jaaXpdHAFj1sDJCvVH1LM4K1b/RSr+a3k/fgGi9GPqQJlwmVRlpR0Nfx0kz3+5uOmiBr+UXJUyF8JgHNDHhZbGF2nP2PCXlPchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q7SBgAgb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLJOSehF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q7SBgAgb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLJOSehF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 302FC1140B86;
	Tue,  1 Oct 2024 05:42:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 05:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775723; x=1727862123; bh=G4xisZdc3k
	gCBCaRMJypxCwjzpimxxwWG9OL8OEph+A=; b=Q7SBgAgbOAy7x8PKzV6UZMY7dX
	0wlMB8hrbS9KivPgQ0+w9cbroAJvK1UHVsr2aOd9EBY7vehv5U28MauwfJo2mMjm
	PFrVAgP4S1mIlSc88Itl55eRb5jfzweisU+QkFSADtkLOisCMnSuyTOGdZ7YeRax
	nXnyeI6FBpK06XnRQkWvCyof4SayYesg0Elsy2SkfXWvWNeu2ao8g8NnmGRbnPm/
	OGcx9K6Z3coy1ddXJEIjHbptfR432vxzbaMAK01zqIj9RKFt524WjFhFAG4M5ay1
	TXHCLhpOOpj4V80q9dfJVoB7SMe30cfzZhlJ0kRCbErMjZnK0P7alLBPZCig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775723; x=1727862123; bh=G4xisZdc3kgCBCaRMJypxCwjzpim
	xxwWG9OL8OEph+A=; b=eLJOSehFzrg0+DW1+IcSAeNfvYUvtf9sFKRLAxqH2Wue
	5DYMF4Mb2hzHUqgMSsWmBVgXfZP4VbpZd6BMC89dZM6eZDyAvhyknIRmNll4KXYH
	lDvkcAvgBSMkVFsvwVubCCOqINMblOYNHIR8Q3SPyZgjZUTWyaSDjesSoVzIRLk/
	lGvW15fadNwEx09udbLXHJPD2AgS6TtwFh//YMBx1+s2TN0Df3umLAEHkckaZdem
	wZAV4PDg6qltzpdpGEmsDtbLhBAsaW+vnOWy9E78Nutn9Ivn+p4AOwr0q7oeG5rW
	9myOlpyuYHhDsgl73B+WI501ltrsZURIcwEAYDAw6g==
X-ME-Sender: <xms:68P7ZuX28_KuTOvcKOG9AoTm2KvkxAJgIVlRXYR5cY9F3ntglpTLQw>
    <xme:68P7Zqn5wxqTSzg3GKXlSweSdCh6ykBWWTrdrp9JAZiBJlOL15WlJ68Joo6Jj9iAH
    qFgk3EebU2o_8wg9g>
X-ME-Received: <xmr:68P7ZiZ76ySEZ90Xzbddja4BxtH6BK7-8XRVDZZMwFwunh4VQ6ah9i4xIEcBE1rItwjyArqG-YgY0StC3-4Y4XMpDm5YRWeQc67qInd0yr5yNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:68P7ZlX_0ghcK-YK_6Ry3_jenkDdvYlq0if686BOl9bj__LZsjuf_Q>
    <xmx:68P7ZonZ3KeVTCCa4vY_Y0lOoixi7LeEx8lcXPGVYjoun8od7CyWGA>
    <xmx:68P7ZqdRrL1PJWctGLGzgb21fI_CAoDBOVctiQkpyCJ337vzSsqEhQ>
    <xmx:68P7ZqFfTB7TQQTfkMPTWjF8n3SLhEilyknyig_tbRBHa_jwWkginQ>
    <xmx:68P7ZpDhc315jquEjQ47k3DEchbN8NC2PKxwNI-61UUiANuWARz6zYDd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5046e345 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:13 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:41:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 05/25] reftable/basics: handle allocation failures in
 `parse_names()`
Message-ID: <bdfddbebce9f77959fd9544cd5ba3496d5b9dccf.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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

