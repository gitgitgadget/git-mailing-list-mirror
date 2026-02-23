Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E0364EB3
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848008; cv=none; b=JA+ZsLOKGhD4SXMjz+gidT2nNA495m3oMFMeVBSWEWY0hBdRzFNBO0ZioWvKgMzTeqijDElVOcQ2nmyQNVNrmG5cm8AYEAV/62c8ASmd4w+PkMt1A/2zF2Uua+nMiooov6j4fikIedcYScRoLQMBQlC5R0tnNSbB/Uxlemqkuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848008; c=relaxed/simple;
	bh=AuOXInNbxQfj7n6xpRAWNGNMarDS36IR3x1U9ZQp+oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wc74HOBC13D5GT7n1EpIkUXXRmbdcNjbyrIB8bewG47XGdZHGi7NmmKCAvx/wYybFsY0ngDwG/XhCzclF2ezAkvx/bRBYuKsnx6iuELOE22ENZeRPdfl6MIBrV8thiBFPEeJrN/lmC5X6dTC7+7OQ0030Ifljl3holRJONKGrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pSizyGH5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPr2uFbs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pSizyGH5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPr2uFbs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A1C49EC05BB;
	Mon, 23 Feb 2026 07:00:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 07:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848004;
	 x=1771934404; bh=lvj9TOpkOAOW37IIJIEQPN+uXWAvEPQpoOnrrqzpUBw=; b=
	pSizyGH5j/INjRJjRK2a+jtZAyIhBRYW2F4hub9yxFVLJM4gYUTe5gqiFMkT+uiN
	OtD4COqHSLvet7g7BzH2CUGPzRgFdA6+UjRpXXTpqRdEdA8Xka2KBH4DJ8zWqkjV
	YpBmxoIMDggQ0BefqG9JosGrnFuO+udgzp2xWOetYG0Jbr2hf1jlelYf3mP7o5Q2
	aFhCGizv9JtaAlIFlmFvpJdObMxpy0wEIt7JXVt6eyiFmKrea0Z66MEv78fwxhLw
	A+Qcgjg2DpQnMaSzgN5Kqpz+wKCotaxzdBrjenmeEicIisUTnDFLujOsrd9CGK+e
	UhfhQ1o1mM+GpAfnaxYqYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848004; x=
	1771934404; bh=lvj9TOpkOAOW37IIJIEQPN+uXWAvEPQpoOnrrqzpUBw=; b=I
	Pr2uFbsg16jKMoHg4tHYFuGx+QOh9UqH1vkG5hEx6l9uhg736zHvHOBZGpv7q7qY
	BKMvznCrFbh5KtI2lFyJ5PJ6rHsJi7S9FUzw1QfDycJpibpT9MHF/E4mTQQDM9oz
	exqGW/khf78CNwcHqgY1e5nBGN45JKymF0knOOhhMcYtxxCwLKD/3yf1sKp8ElQc
	yx5lShNwng51iTfzhDQZY2BAdf30eXHdh6B5AlrkwreiHPpu3dKNhficG8ZzkgI0
	Jbx/LLi2YILxazCLBI1iexQF4nmb5usmgcNb2815M4eXTXlbQs93d9tLEFEe96HG
	NgrUUnFKPbG2mIfQd29zA==
X-ME-Sender: <xms:REGcaUrrOtMmlf5K-6rFPCOXpCD86bjmbQ94xG_iQ7xLQBOufdM8Qg>
    <xme:REGcaSGihKXnkOwjQ3bqQBgeLrrOsnFq17eCO84NmOO1OUFX5R6hQeloPHwd_RUKC
    bLQHnLmXzY-db9uV3F_bWxIFc-DL8jg30y_kivjQE2AzlYEWNfB>
X-ME-Received: <xmr:REGcaWm2DOxgZrRfeHGmqTpQyt5UpSu2uvKSHMZwtrEzC4LVZUVdZZ3n0af1oFtcPJwIhr0rY6PurnqbDro0HfFNbVKmPqhXdDfKSZoc2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:REGcaVmE4gx0AknE61mdFynNI12Ng7zEkDSZfxtye8JaJTCtuDjgJg>
    <xmx:REGcaXvLx5lTehzgEm5eq1VkbzVcGPFtFXqK8qYnpLVCJ0IoWMzLBw>
    <xmx:REGcaYmm10QNQt9apYgIjC2P1puSR2cvRXNqSNWbXcW45ctxw8TBfA>
    <xmx:REGcaSsIkNHpko26ftSTRY2PckMSguiAq4OYw2SzMc-XpRreQFvtzg>
    <xmx:REGcaYlG6xXPDDy4ytjhAbA6t90WhHK_m_X__EC-r-MBjmzqcczRg2Qa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36b33214 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:42 +0100
Subject: [PATCH v2 08/17] refs: generalize `refs_for_each_namespaced_ref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-8-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
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
 refs.h |  7 +++++++
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index e4402d787f..0d0f0edbfb 100644
--- a/refs.c
+++ b/refs.c
@@ -1848,10 +1848,14 @@ int refs_for_each_ref_ext(struct ref_store *refs,
 			  refs_for_each_cb cb, void *cb_data,
 			  const struct refs_for_each_ref_options *opts)
 {
+	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
+	struct strbuf namespaced_prefix = STRBUF_INIT;
 	struct strbuf real_pattern = STRBUF_INIT;
 	struct for_each_ref_filter filter;
 	struct ref_iterator *iter;
 	size_t trim_prefix = opts->trim_prefix;
+	const char **exclude_patterns;
+	const char *prefix;
 	int ret;
 
 	if (!refs)
@@ -1886,11 +1890,29 @@ int refs_for_each_ref_ext(struct ref_store *refs,
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
 				       trim_prefix, opts->flags);
 
 	ret = do_for_each_ref_iterator(iter, cb, cb_data);
+
+	strvec_clear(&namespaced_exclude_patterns);
+	strbuf_release(&namespaced_prefix);
 	strbuf_release(&real_pattern);
 	return ret;
 }
@@ -1937,22 +1959,11 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
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
index a66dbf3865..5a5fb4e1e4 100644
--- a/refs.h
+++ b/refs.h
@@ -468,6 +468,13 @@ struct refs_for_each_ref_options {
 	 */
 	const char *pattern;
 
+	/*
+	 * If set, only yield refs part of the configured namespace. Exclude
+	 * patterns will be rewritten to apply to the namespace, and the prefix
+	 * will be considered relative to the namespace.
+	 */
+	const char *namespace;
+
 	/*
 	 * Exclude any references that match any of these patterns on a
 	 * best-effort basis. The caller needs to be prepared for the exclude

-- 
2.53.0.536.g309c995771.dirty

