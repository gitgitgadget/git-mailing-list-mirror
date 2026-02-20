Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC3336EC6
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575900; cv=none; b=lhuIMUasTIszQewbWpxnsX55SfVyVyRFtCljHIONrZYqFg3j3e78w4+PngTCb7lldpYR7M7lPojnD9I0XCvgKG+oed6Kaadhip5Cdit+IqtDNxclRM1kuJdQ605YBMnCiBTg6Hqus2RCtluSGI/3dAAti0GvwODgpylmBM6z9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575900; c=relaxed/simple;
	bh=I8eQ1x7qpkOYvfors3xHDiZfeN/pnDTP0piN1Yqyvtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGs6uj87f2j4s0s2owSz1AYO8en6JHgyXMAPi4FFt8xBHKzzYFFPTlXZUcMgJrrEtNLfRRY7CMyUI3pdS0fsCPnoz2iGOjYEfV2X/wQrpAQ7VnEZnMfF/3VfBlBx3hYSi0iNf+wkvghP42e9GpvHFIutvRpICFwNQdlDUbArGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nz+XMcZv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7mT2BP9; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nz+XMcZv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7mT2BP9"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0EF8E7A0011;
	Fri, 20 Feb 2026 03:24:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 20 Feb 2026 03:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575897;
	 x=1771662297; bh=m7nWxCZcKx9iX07mwO5XkcU54vaVIqIY2Fhab7WAySc=; b=
	Nz+XMcZvbCC6oOSaiPZYpYDdaZ33WpfOq6GicxIPSgGmZrIZ/QXz8WjyN3lLQuAG
	urz3AQk6viLtR++D+4Ak6+2+let8ma8mCcYbS3AI69UdQii+9lWWDhQmp9hlfZfw
	nwF/LMuBuaTBuBT6Tz2IkdmGRE9jgsvkOj6MkctbmGFkGDth9K/yciEsNab6VP8d
	BmokWK60X9gr7m6LrWtQeXH4TbGVBmNyyV6GsUwNMJslU9sqZhhdDTNVh7iI7fZi
	PuP2K1mXEFsIlJ7XmpnBEDAzR2GHWkgfs8dAEzBLmjx0IhBZ4gFffnTjKpq6lZdV
	J7nAUzlktuIClBOcV7XeEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575897; x=
	1771662297; bh=m7nWxCZcKx9iX07mwO5XkcU54vaVIqIY2Fhab7WAySc=; b=F
	7mT2BP9GSxyLyaTI0CvvnN4Asp7ApErC+ki4famtVpvNoIASN67AKpFb7M6MrjNF
	QZHPzo7yeaaurDcNqSYYTc0Ahrd2tjLjmeEq9hmNZ47U/aHyVliinyUMe8cXg12N
	T2w0rXsXapy6jMCoXeLRRwC/0Yc0b7ifb+FpVNUAiIM3HQmU0JKThbEUXpB8AWu5
	ZLIAV+FMvW4GU85z0T6ezir9soF2WmosAAREOTV44m28iVedfR9dpOMBAUfr52Fo
	qWlldygz5nlHOtLRpdqilPXLgsBSMjy4Wk6cOdjyS4kzGjvQQiEvyKgWhq+QDQc5
	JtLPlIdBbIVpw54BcnHsg==
X-ME-Sender: <xms:WRqYacZXl-3ztVDHVXq8xCVlUJoNzSZg2xel_FXvMXf41Q4GsPyT1w>
    <xme:WRqYadbiZ5k5zHKs_pD4Ke6kTKliyCSK1DYft9yJCzUn4Kn6RNp5chfwg2N8XzBU_
    NA7cjeTRSqW6gicX0FMkDGOVBnVHuAdhkVcBsuFz4MBNVs5AT18Qw>
X-ME-Received: <xmr:WRqYaUnPmIxdbRPrMKkfhXK_IPC2m7Qlbj23iouP82oa7G-eKUXpgXGTg5lFtIH4hBcxNbA3k2rKPVY362p0LFNLTrrv5hL_hs5JmWeblTCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WRqYaRwhcrQa5zQqPtnyqb3spAgnT5N_CPLRhRpuIkdLXQJ0tXiKGA>
    <xmx:WRqYaaO-7RUSztFxQE8dbClCsybswSDgs_Qwcl9SWASKyMMpVeycgA>
    <xmx:WRqYadSIXKWMzNPYvnxVoOCVF-hBF5iuHEW4hfG3_XAGkT6z4VEv1Q>
    <xmx:WRqYaQZtWWLKhz4MinannF941n8kZSKq3woPMgnPukHZGKmDViiwkg>
    <xmx:WRqYaSLff_naSyVKpAPiD0FqCosDRphGqkOgq72ykx4Dv8k_x2m24wKO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c27fd16c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:15 +0100
Subject: [PATCH 11/17] refs: replace `refs_for_each_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-11-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_ref_in()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                  |  8 ++++++--
 builtin/rev-parse.c       | 13 +++++++++----
 pack-bitmap.c             | 13 +++++++------
 refs.c                    | 34 ++++++++++++++++++----------------
 refs.h                    |  2 --
 t/helper/test-ref-store.c |  7 +++++--
 6 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2bdad4ee42..296836c154 100644
--- a/bisect.c
+++ b/bisect.c
@@ -473,8 +473,12 @@ static int register_ref(const struct reference *ref, void *cb_data UNUSED)
 
 static int read_bisect_refs(void)
 {
-	return refs_for_each_ref_in(get_main_ref_store(the_repository),
-				    "refs/bisect/", register_ref, NULL);
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/bisect/",
+		.trim_prefix = strlen("refs/bisect/"),
+	};
+	return refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				     register_ref, NULL, &opts);
 }
 
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9032cc6327..02703f2fb8 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -613,13 +613,18 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
 
 static void handle_ref_opt(const char *pattern, const char *prefix)
 {
-	if (pattern)
+	if (pattern) {
 		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
 					  show_reference, pattern, prefix,
 					  NULL);
-	else
-		refs_for_each_ref_in(get_main_ref_store(the_repository),
-				     prefix, show_reference, NULL);
+	} else {
+		struct refs_for_each_ref_options opts = {
+			.prefix = prefix,
+			.trim_prefix = strlen(prefix),
+		};
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      show_reference, NULL, &opts);
+	}
 	clear_ref_exclusions(&ref_excludes);
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index efef7081e6..22419bfb33 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3326,6 +3326,7 @@ static const struct string_list *bitmap_preferred_tips(struct repository *r)
 void for_each_preferred_bitmap_tip(struct repository *repo,
 				   refs_for_each_cb cb, void *cb_data)
 {
+	struct refs_for_each_ref_options opts = { 0 };
 	struct string_list_item *item;
 	const struct string_list *preferred_tips;
 	struct strbuf buf = STRBUF_INIT;
@@ -3335,16 +3336,16 @@ void for_each_preferred_bitmap_tip(struct repository *repo,
 		return;
 
 	for_each_string_list_item(item, preferred_tips) {
-		const char *pattern = item->string;
+		opts.prefix = item->string;
 
-		if (!ends_with(pattern, "/")) {
+		if (!ends_with(opts.prefix, "/")) {
 			strbuf_reset(&buf);
-			strbuf_addf(&buf, "%s/", pattern);
-			pattern = buf.buf;
+			strbuf_addf(&buf, "%s/", opts.prefix);
+			opts.prefix = buf.buf;
 		}
 
-		refs_for_each_ref_in(get_main_ref_store(repo),
-				     pattern, cb, cb_data);
+		refs_for_each_ref_ext(get_main_ref_store(repo),
+				      cb, cb_data, &opts);
 	}
 
 	strbuf_release(&buf);
diff --git a/refs.c b/refs.c
index 3b676432b4..b42a1bfa3f 100644
--- a/refs.c
+++ b/refs.c
@@ -527,19 +527,31 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
 
-int refs_for_each_tag_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
+int refs_for_each_tag_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/tags/", fn, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/tags/",
+		.trim_prefix = strlen("refs/tags/"),
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_branch_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
+int refs_for_each_branch_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/heads/",
+		.trim_prefix = strlen("refs/heads/"),
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_remote_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
+int refs_for_each_remote_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/remotes/",
+		.trim_prefix = strlen("refs/remotes/"),
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 int refs_head_ref_namespaced(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
@@ -1924,16 +1936,6 @@ int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 refs_for_each_cb cb, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.prefix = prefix,
-		.trim_prefix = strlen(prefix),
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
 			     refs_for_each_cb cb, void *cb_data)
diff --git a/refs.h b/refs.h
index 65d1665c72..c9f8d3e6cb 100644
--- a/refs.h
+++ b/refs.h
@@ -500,8 +500,6 @@ int refs_for_each_ref(struct ref_store *refs,
 int refs_for_each_ref_ext(struct ref_store *refs,
 			  refs_for_each_cb cb, void *cb_data,
 			  const struct refs_for_each_ref_options *opts);
-int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 refs_for_each_cb fn, void *cb_data);
 int refs_for_each_tag_ref(struct ref_store *refs,
 			  refs_for_each_cb fn, void *cb_data);
 int refs_for_each_branch_ref(struct ref_store *refs,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b1215947c5..a2ef1b6949 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -163,8 +163,11 @@ static int each_ref(const struct reference *ref, void *cb_data UNUSED)
 static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
 {
 	const char *prefix = notnull(*argv++, "prefix");
-
-	return refs_for_each_ref_in(refs, prefix, each_ref, NULL);
+	struct refs_for_each_ref_options opts = {
+		.prefix = prefix,
+		.trim_prefix = strlen(prefix),
+	};
+	return refs_for_each_ref_ext(refs, each_ref, NULL, &opts);
 }
 
 static int cmd_for_each_ref__exclude(struct ref_store *refs, const char **argv)

-- 
2.53.0.414.gf7e9f6c205.dirty

