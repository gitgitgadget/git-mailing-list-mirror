Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D518037
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159533; cv=none; b=U1Cb2NLqSNB8Hjy3bMqiL5FmoTNaHD9Omse9xM0wjkXEy5pV4TSbL3oQd8HaiLMX0za2g5GWxTG4DytxDrF6Z6HP14hNBUmR1fhhIHGxHPGIj9SUDue0AL6qU/K4TgRnfm2Sxycf+gnNzBlparot2Uj26FrzYHmnrBSqEKwikzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159533; c=relaxed/simple;
	bh=WF5gQ0IIb1Zd6WWsUYspG9iaGDVxScVBObd5Sh/189s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir8AiiFlzBgTv/M7OJIyu5jjzv+IdyOHQdL1AOekKGP/CbQhteSx5r1NcqSIkn9mpl5dF+Jl/AoYXreByRhMOKuFjgAae/McAwlCIvUN45dPCpOUQxpz9HhB5xOkpnDaqRrtvsx5+6wW9xo9/sUduftzqWxd2/HiTjOHsv5PhRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZLsKHP5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVC+1Lud; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZLsKHP5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVC+1Lud"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E5CB1140315;
	Tue, 24 Sep 2024 02:32:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 24 Sep 2024 02:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159530; x=1727245930; bh=rYmy33Vnzq
	/bUz/SWWXRD16SBVilTkfuBt1++mE6vNs=; b=TZLsKHP5iau75KX3D9zH8yY9T7
	PU9L68BjsX7+3AJBwhbhDWJdT4BPQZNcc66O0gYx84gfwnkLbEuuOr/JNODKprzT
	X6okMyKaJ9zl5EvMrTHMApH1EsCAPzP+E3LQtXPyC60KyziuJVzMmSTSg7SZA+9T
	wjD4sz96BTGk7+blfm4jrlnaHErsaydb3Gu/pPbtIyuqJWvzxuOc8GWf8YKyT0l2
	dxOVDiCvet5YZvS1JYfKvjAOgzjhNbyseQf2LALxvh79ikZB6K8gU79XiNuq4VeC
	hPvL9wiTueI7Vfod0+CEs/h62Uc/kD7Vgandp8NNBCq9hJYgI1PyuSg8ZMOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159530; x=1727245930; bh=rYmy33Vnzq/bUz/SWWXRD16SBVil
	TkfuBt1++mE6vNs=; b=aVC+1Lud6Tk9ka/GbivgHDpkfrIerdxfd+T2sCJ2fkMD
	ys26Z93zA1RMLZ4U73hu4fryRG1CJ5a4w2E5Sn9fv24nFuOq6JNWDTsOAkI4UpjJ
	kO1uX/vWL40jKlSBLDw2bkSi4Mpv1qEWrUX5jWV9E6MhfUgeZXSI9tNYBZc8sRBT
	9/QQyXFnDCMjSfenBhuwdzrhEmLfyC9w0hJy63SV49svQKVJ+1u02OtFaPlmCoDk
	sgGwgHOoT/lEQ02nhsMgZzqqaOUqPRKaOdzfgd1lMcr3/QOaRl2OKmEcECqHHNoP
	BqhZnu0q0nWjEcZg8jjy7V8hO9LcvcjEdjeebCHnTQ==
X-ME-Sender: <xms:6lzyZuycFHOrzStp1BN1N3ruKrSeXBrc984xOOwURCkxtw65kfWc4w>
    <xme:6lzyZqT0SB5tW5O6OaNi-I9K_WqDa88hc1a2IMDZ0R-lU-uu_X8HpC9hUXyt8jIQC
    zSY3klXForjjbtDbA>
X-ME-Received: <xmr:6lzyZgXaayf2w5xTIi03TVcOpiNGPxlYUUTddQjqA54YznuxJx2YvkUKytEsPlqbSHXB9cQmr_Qo1TPxbyHj5ydI809h_oV16DsCiRMzrMkj7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6lzyZki-S0Zfy_K5-yGP2Nkc6AX8v-gwJ6yIbMLG2t8aWAjEzUmUbw>
    <xmx:6lzyZgB52BEDxl3mLzYKgJ1feZcR17DDbS5ClSqyIcwskLlfIoW-pg>
    <xmx:6lzyZlIhyCLTqUr8Cv-LGRaio57d2164BbQpMClAEME6OopDgF63zg>
    <xmx:6lzyZnBtW-MWNCnNh2tI8_neZvBZ0e5yGe-pWMEic8r_zpwN47yCXA>
    <xmx:6lzyZjOfAG0Eu0OOIohVW4kNo0pnj7Spr93i6edr3vq5vch2G0h4yKLf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa7e9de7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:36 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/22] reftable/basics: handle allocation failures in
 `parse_names()`
Message-ID: <ad028020df717a57879cf3fdf5a3648bfebd2c78.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

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
index 3350bbffa23..82bfb807631 100644
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

