Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ABC3358D3
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575891; cv=none; b=AEfDBZ6I6ggcV5NT3MGIdoyIJ6+oXnWKRgbzxedLQQj5okj2SoSjijoz+HQ7G0uzVsX8xImAshqeJLJiIMp+4StPZjH6Gq1ltqi3wOBoJeSMBVLqqP35q435IogjwChV7MufxBJNcAbcu9oAdBOgP17TovI3Z5EQsQApWntMUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575891; c=relaxed/simple;
	bh=vRWDa9WAOTR9GFa8pbc5rcsW/MuZnFOC6gfmjaRkKCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HobvEnsxD8daRe4oyrlkTY3/EJqt6yK5QLTxvHJ+AvXAQC0SuB2x2hAi3H811LcqC74z/NtfkA+4BlgbKczzUj2cpUw6FVYe1bhK+J5vEggjzJRXM/H+XAXtNdr3weXC6nNiXLIySq1trxOsU7czfVXA9Ahk18tWahYg5cInie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=odqalvcl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t1J/tCTp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="odqalvcl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t1J/tCTp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E9E7D1D000DD;
	Fri, 20 Feb 2026 03:24:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 03:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575888;
	 x=1771662288; bh=Z+Whrtsk+qmrEmLa2DW85ffNquYWHkPdpARgIm024V8=; b=
	odqalvclXaPu354Cggrj3PKwtKYNOvHLogzsXW/Gh0l1cQC2S9Amkx/4qRd7ZbgP
	Vrr2HV0QwxaBCDVo7upUyaWEszT3k498jqmg8LPGkOQQsLAHRAUdpkqZEjeUPVpo
	/UhE4zfSo5nM94/mcb1oRi/8x2UCUop7cC5cgFoXTMobypAfnH4oExI/1p3sJp4X
	gFUoYvotk4/uQ9wFj8mbsPACVsUSnE2S2/2xwQHe4hXGG7Z7gVfl+H4I4pWH3bk+
	ep2Nk6rnfyhe4MjVdfITfAT33OKdpRG81Y2TDo6eR3NPB/jPAL6kuS4y5yxCVdU7
	0zn45pwiNMIYF9FLQB1vhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575888; x=
	1771662288; bh=Z+Whrtsk+qmrEmLa2DW85ffNquYWHkPdpARgIm024V8=; b=t
	1J/tCTpUVULYtsaucLckzvqDX7tLDFzQ1FbvNsyoYl371Af+eIq5tBaOGbXaxNJc
	rhpx4yO2Xebs5+3ifDb1hs/x3ZqnEkdghXXnoUNUXmiO6PfCfxa+TXtBZMzKXzu2
	5C+VXN/whsq2uP9ebsSSdmP2YpH3WTQk64+/MRPrXQxZjw1HPdmeO9oBihMRYbiX
	1XE1IuBaR2pH+i0xA3MiDdUeV53hax190AT5dEf/bR3sPJP7gcIkXug+G/nNWpBx
	fdVT/6ttRY9nSpc38xtrONLrBLgE/UMTkLBpCQ7n1oDoXV6c/LFfMgxZJdDGLP12
	jInyKsxZMbnVtV+oylOzQ==
X-ME-Sender: <xms:UBqYaRRYiJvHW8zYPpCKMkrSO3dvAG4e7PqlxPGGf0kupAmRh0hiaQ>
    <xme:UBqYaQwYMxsbaMK3cjYTXaScRVAy7wi2G2bew2BkL0wky6GLXSgaQXe0QSy8ZIt3P
    0KGpytLV2kMfcuzkryoJniqVdU_2q62eorglRaFyVqrR25Kl72MTw>
X-ME-Received: <xmr:UBqYaUf7tEM0Q_WrO7DRb-wZT8x9M-eq_irY7Go9CajOs4ycaYnHdikRGOUhvz3YGgD4BHrTYDws4CDng3iBwsgM5MK2_fZgPATBc6-8yUlJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UBqYaUIQH81U2mQs0-jTF338Va2GKx3sWODAfNi4NtD1BIfBVpYFfQ>
    <xmx:UBqYadG1c2GHU_GSTuNmtx2oFulb7ACE00rsm2RSIkvBr-C-nHst3w>
    <xmx:UBqYaWob4uuuZhl8iD9R24rDkXs8xf4Pc4Mt1kIrr6WgjISaF1S65w>
    <xmx:UBqYaeSaM6EH9m1Fjf9V7EmnlRzkAYu4Zl_IBm1Md8XW4Auyxf2rLw>
    <xmx:UBqYaVC0CwhFTmOFzrKBkGKPRGNuKRU6vH1yFx2Fh3blEU-AwHUpYOFg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5c8b57c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:12 +0100
Subject: [PATCH 08/17] refs: generalize `refs_for_each_namespaced_ref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-8-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `refs_for_each_namespaced_ref()` iterates through all
references that are part of the current ref namespace. This namespace
can be configured by setting the `GIT_NAMESPACE` environment variable
and is then retrieved by calling `get_git_namespace()`.

If a namespace is configured, then we:

  - Obviously only yield refs that exist in this namespace.

  - Rewrite exclude patterns so that they work for the given namespace,
    if any namespace is currently configured.

Port this logic to `refs_for_each_ref_ext()` by adding a new `namespace`
field to the options structure. This gives callers more flexibility as
they can decide by themselves whether they want to use the globally
configured or an arbitrary other namespace.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 47 +++++++++++++++++++++++++++++------------------
 refs.h |  6 ++++++
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index ac34bbe6c1..99994879d9 100644
--- a/refs.c
+++ b/refs.c
@@ -1845,9 +1845,13 @@ int refs_for_each_ref_ext(struct ref_store *refs,
 			  refs_for_each_cb cb, void *cb_data,
 			  const struct refs_for_each_ref_options *opts)
 {
+	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
+	struct strbuf namespaced_prefix = STRBUF_INIT;
 	struct strbuf real_pattern = STRBUF_INIT;
 	struct for_each_ref_filter filter;
 	struct ref_iterator *iter;
+	const char **exclude_patterns;
+	const char *prefix;
 	int ret;
 
 	if (!refs)
@@ -1876,11 +1880,29 @@ int refs_for_each_ref_ext(struct ref_store *refs,
 		cb_data = &filter;
 	}
 
-	iter = refs_ref_iterator_begin(refs, opts->prefix ? opts->prefix : "",
-				       opts->exclude_patterns,
+	if (opts->namespace) {
+		strbuf_addstr(&namespaced_prefix, opts->namespace);
+		if (opts->prefix)
+			strbuf_addstr(&namespaced_prefix, opts->prefix);
+		else
+			strbuf_addstr(&namespaced_prefix, "refs/");
+
+		prefix = namespaced_prefix.buf;
+		exclude_patterns = get_namespaced_exclude_patterns(opts->exclude_patterns,
+								   opts->namespace,
+								   &namespaced_exclude_patterns);
+	} else {
+		prefix = opts->prefix ? opts->prefix : "";
+		exclude_patterns = opts->exclude_patterns;
+	}
+
+	iter = refs_ref_iterator_begin(refs, prefix, exclude_patterns,
 				       opts->trim_prefix, opts->flags);
 
 	ret = do_for_each_ref_iterator(iter, cb, cb_data);
+
+	strvec_clear(&namespaced_exclude_patterns);
+	strbuf_release(&namespaced_prefix);
 	strbuf_release(&real_pattern);
 	return ret;
 }
@@ -1927,22 +1949,11 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 const char **exclude_patterns,
 				 refs_for_each_cb cb, void *cb_data)
 {
-	struct refs_for_each_ref_options opts = { 0 };
-	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
-	struct strbuf prefix = STRBUF_INIT;
-	int ret;
-
-	opts.exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
-								get_git_namespace(),
-								&namespaced_exclude_patterns);
-	strbuf_addf(&prefix, "%srefs/", get_git_namespace());
-	opts.prefix = prefix.buf;
-
-	ret = refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-
-	strvec_clear(&namespaced_exclude_patterns);
-	strbuf_release(&prefix);
-	return ret;
+	struct refs_for_each_ref_options opts = {
+		.exclude_patterns = exclude_patterns,
+		.namespace = get_git_namespace(),
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
diff --git a/refs.h b/refs.h
index a66dbf3865..2bde60aa0e 100644
--- a/refs.h
+++ b/refs.h
@@ -468,6 +468,12 @@ struct refs_for_each_ref_options {
 	 */
 	const char *pattern;
 
+	/*
+	 * If set, only yield refs part of the configured namespace. Exclude
+	 * patterns will be rewritten to apply to the namespace.
+	 */
+	const char *namespace;
+
 	/*
 	 * Exclude any references that match any of these patterns on a
 	 * best-effort basis. The caller needs to be prepared for the exclude

-- 
2.53.0.414.gf7e9f6c205.dirty

