Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015041E6D3
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205499; cv=none; b=GkbNNv9bHX6E7JRAu+NPmt0k9aJRAw1uI+XzKPMd8aOyawDNHrheuZuL2/aLgEqM8LqL877kQPMH2tnTWr2QREGlZVOtXYtOKb9wY5mbAkuu1LIJYNiJBekAtWW6ptdHvphjp8JovgpKvL8lQ2U9KfTvjZhsfE5eyMINZd8UBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205499; c=relaxed/simple;
	bh=jCNp3eT0MD7bQdZNP5D6BAUMdv/R1tzjY/0MQthTnoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnczzEHG8tFlPCz2BghRzHtT6A2J7aXzoRuKS4uQcUxZ/kvSTQMp1Qc4sg3XXVkl77ZD7PTPagZV6bGO7BaokwzM4tEmCyfb/81lcbLgdWAw+3FAsiKzOL3xp7pVCgLPGbQSiZftB1ipXa+CLpjYVt+VKbTzcgIsVTwhnLaZKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H9wMIl5h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQYm2GJv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H9wMIl5h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQYm2GJv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B31E414000AF
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:38:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 08:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784205496;
	 x=1784291896; bh=eJ73SAIwIjGLx8uiRqZPKvi89Cjk+1vX0AY59PfVsjU=; b=
	H9wMIl5h3xpttq+t5yR/gZKVpt62YhdLuB/CFh0cM2ZDyqkqaS5bDj4sNU49u11J
	IXFqZPBBRrKI5cyXCnmS+qlcJpuAoqaUaVI1in6pq2PG6/bHJBE7QYPg6zc2IO4M
	OtC2bwwN48mnzsgeassDG9IJYBIKTgXobocY+Xbsfa6OU2Pm0j62jOd/V2h0uYHt
	vmXklRxHq7QVZL6ptJayJjv21EkTHs2ycg5uSdmmyxo9v/lYC+iVMs+Ugy0Ug5rM
	npUe+WSVQt9X7IY4ipUBR73Wll6559bssePKRxtordMKLtgre+qMO3f9n3eUxtU8
	elHEDyB4zpCAd/NMorHdmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784205496; x=
	1784291896; bh=eJ73SAIwIjGLx8uiRqZPKvi89Cjk+1vX0AY59PfVsjU=; b=j
	QYm2GJv7MjwZUJRov7CdJkzibEoasjGidzE9Wxs9IZZ2XN5Zzcm+22dg0Vdj9Amt
	MztCbsonEfXh/eLIaKjkXcmr729/Xaz9nkIi0QdCx2K6Jv0d3JMS78msaX60jTwX
	PIEwsxK26TKF/1Lp/XuAMU4ccyZo/za40KFJ4vMH9/zqcSeWfhxNtUjqs+Rlx+sK
	NLnVxaJ0JMk/jnUiW/gkXVLjdnFdvAUxiTJ9dlbyFq1UBt3UTxd/97WazCLqN1aO
	QOk56b5IAmp3ZHcBAZTHQ40kjBD3lUsNt631x3Qo0ir4fkwgPh2JmfR+NR/Hbh4q
	Zszfu6BGK/6mYCAMb0gLw==
X-ME-Sender: <xms:uNBYakfcH9I9oH098TOfB4H0Mk4Ghv5tu2SiekPoBph-T75fUs4kHw>
    <xme:uNBYatKojGF6Nwe5a5R-xMMtvWyf-spnk-X_tgZwQ22Y-XQBK4X2y6_71kxUxtKtX
    h63SfzzxmBV7QsXtFHfFXB9brf4XQhpccO4QpwiwtjGjDMuYqlx1A>
X-ME-Received: <xmr:uNBYarL4SiJIf21HBEucjlZ73vH26sQ7BgxdKymwQjjR-q3DGk0kt54pqFl2YUf-3lbRaxibcwKZT7fVjeY0T6gzOICHuHxs4eEHniTR>
X-ME-Proxy-Cause: dmFkZTEz1lpuhwAwq5UCwI/1Bs/prQsRBZGNgxNHjpAbj64iYIYNHhUktzNABdnbeBGlau
    rcZQucpg2cGuhmAx7a3A9FM3CV71G/yvew7BZl5RmldAR13IMKPvtNoIQCLfjJ+8WnQ/rx
    0J5ir/4CKkWPFUclrDUa80qC3oRBx4IHbJkrrarVM6pi0AIeJIGIGNY+bC61q947VeSY0I
    3tx8mcnza4bntrY5H/UCUJ0brNtvhkwZPtSm4cZvastLrUD5p8GtJsQ+R+boyqk65ty7Xj
    1W1+rjc919ernMTi8mlHfO70+RdwOdOAaHiqp9uFXAQiHwVe6blCLdrZzboberPWvH2hOs
    i78D2UJnTmJbNq0dulbejOaxq7u2g2Y4zC+ewTu6Be59r/WiwI5SiMbseKT+kum83+ELMw
    hzxcIMz6UVViLwu5Lm8imuuWj1oVQRF5KY7z4EsfYJcT4ySSqSAHzYzEHk4vZPt5p2qKCJ
    FUGNjYgZfqGgdq5XkL63/o+cbE9QFA1wgFYl7RiSXhKhG+xm/DYNTHZe4rfySc3YW6y8Rp
    zO9WyDj6Ofe5TW01+mZPdlloAhk/td+YEKbhpNbUa7J9aGS5snnVUzOaeJ8O89z/lCrg+b
    Q7Xwbh3GakX9Obtfbdmy/RPfKPcLkpM8eKarK8KT5pj4DoGZMuD7J2RLVfXQ
X-ME-Proxy: <xmx:uNBYavFQ6f0cZpkyyeUQGw-z_tDSuVTl_7izGA4e-M-vDJ7jYE6-XQ>
    <xmx:uNBYagnyYPhbIpJbjwZDOO6X8Z7x73HcdEXALtx9kuNQ98ArtJnF9g>
    <xmx:uNBYasIQsoqj2w7YFM88FxcxIowUUUCOGiuRIqnmv1Cr2xFD6S75dA>
    <xmx:uNBYahZ4tsap1kyW3WVguu0FlmVksxxyNDKapdHGzQbKnm5ZMsw4uw>
    <xmx:uNBYaqO-B7qcNKc5ECuMg-J_OmL1ApeA1Ccyv_ThPAm8Vuu6w_Tw4Zdo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jul 2026 08:38:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8cc4e3f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jul 2026 12:38:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 14:38:03 +0200
Subject: [PATCH 2/3] refspec: let callers pass in hash algorithm when
 parsing items
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-refspec-wo-the-repository-v1-2-aa40844d067f@pks.im>
References: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
In-Reply-To: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When parsing a refspec item we need to know about the hash algorithm
used by the repository so that we can decide whether or not a given
string is an exact object ID. We use `the_hash_algo` for this, which
makes the code implicitly depend on `the_repository`.

Refactor `refspec_item_init_fetch()`, `refspec_item_init_push()` and
`valid_fetch_refspec()` so that callers have to pass in the hash
algorithm explicitly and adapt callers accordingly. For now, all of
the callers simply pass `the_hash_algo`, so there is no change in
behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c |  3 ++-
 builtin/pull.c  |  2 +-
 refspec.c       | 30 +++++++++++++++++-------------
 refspec.h       |  9 ++++++---
 remote.c        |  2 +-
 5 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e676b79ba..1d4a129039 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -601,7 +601,8 @@ static struct ref *get_ref_map(struct remote *remote,
 		struct refspec_item tag_refspec;
 
 		/* also fetch all tags */
-		refspec_item_init_push(&tag_refspec, TAG_REFSPEC);
+		refspec_item_init_push(&tag_refspec, TAG_REFSPEC,
+				       the_hash_algo);
 		get_fetch_map(remote_refs, &tag_refspec, &tail, 0);
 		refspec_item_clear(&tag_refspec);
 	} else if (tags == TAGS_DEFAULT && *autotags) {
diff --git a/builtin/pull.c b/builtin/pull.c
index d49b09114a..db3ee0aab3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -612,7 +612,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 	const char *spec_src;
 	const char *merge_branch;
 
-	if (!refspec_item_init_fetch(&spec, refspec))
+	if (!refspec_item_init_fetch(&spec, refspec, the_hash_algo))
 		die(_("invalid refspec '%s'"), refspec);
 	spec_src = spec.src;
 	if (!*spec_src || !strcmp(spec_src, "HEAD"))
diff --git a/refspec.c b/refspec.c
index fb89bce1db..33a6fb8e45 100644
--- a/refspec.c
+++ b/refspec.c
@@ -16,7 +16,8 @@
  * Parses the provided refspec 'refspec' and populates the refspec_item 'item'.
  * Returns 1 if successful and 0 if the refspec is invalid.
  */
-static int parse_refspec(struct refspec_item *item, const char *refspec, int fetch)
+static int parse_refspec(struct refspec_item *item, const char *refspec,
+			 const struct git_hash_algo *algo, int fetch)
 {
 	size_t llen;
 	int is_glob;
@@ -84,7 +85,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		 */
 		if (!*item->src)
 			return 0; /* negative refspecs must not be empty */
-		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
+		else if (llen == algo->hexsz && !get_oid_hex_algop(item->src, &unused, algo))
 			return 0; /* negative refspecs cannot be exact sha1 */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
@@ -101,7 +102,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		/* LHS */
 		if (!*item->src)
 			; /* empty is ok; it means "HEAD" */
-		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
+		else if (llen == algo->hexsz && !get_oid_hex_algop(item->src, &unused, algo))
 			item->exact_sha1 = 1; /* ok */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
@@ -154,21 +155,23 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 }
 
 static int refspec_item_init(struct refspec_item *item, const char *refspec,
-			     int fetch)
+			     const struct git_hash_algo *algo, int fetch)
 {
 	memset(item, 0, sizeof(*item));
 	item->raw = xstrdup(refspec);
-	return parse_refspec(item, refspec, fetch);
+	return parse_refspec(item, refspec, algo, fetch);
 }
 
-int refspec_item_init_fetch(struct refspec_item *item, const char *refspec)
+int refspec_item_init_fetch(struct refspec_item *item, const char *refspec,
+			    const struct git_hash_algo *algo)
 {
-	return refspec_item_init(item, refspec, 1);
+	return refspec_item_init(item, refspec, algo, 1);
 }
 
-int refspec_item_init_push(struct refspec_item *item, const char *refspec)
+int refspec_item_init_push(struct refspec_item *item, const char *refspec,
+			   const struct git_hash_algo *algo)
 {
-	return refspec_item_init(item, refspec, 0);
+	return refspec_item_init(item, refspec, algo, 0);
 }
 
 void refspec_item_clear(struct refspec_item *item)
@@ -200,9 +203,9 @@ void refspec_append(struct refspec *rs, const char *refspec)
 	int ret;
 
 	if (rs->fetch)
-		ret = refspec_item_init_fetch(&item, refspec);
+		ret = refspec_item_init_fetch(&item, refspec, the_hash_algo);
 	else
-		ret = refspec_item_init_push(&item, refspec);
+		ret = refspec_item_init_push(&item, refspec, the_hash_algo);
 	if (!ret)
 		die(_("invalid refspec '%s'"), refspec);
 
@@ -246,10 +249,11 @@ void refspec_clear(struct refspec *rs)
 	rs->fetch = 0;
 }
 
-int valid_fetch_refspec(const char *fetch_refspec_str)
+int valid_fetch_refspec(const char *fetch_refspec_str,
+			const struct git_hash_algo *algo)
 {
 	struct refspec_item refspec;
-	int ret = refspec_item_init_fetch(&refspec, fetch_refspec_str);
+	int ret = refspec_item_init_fetch(&refspec, fetch_refspec_str, algo);
 	refspec_item_clear(&refspec);
 	return ret;
 }
diff --git a/refspec.h b/refspec.h
index 832d6f923c..e482b720a8 100644
--- a/refspec.h
+++ b/refspec.h
@@ -1,6 +1,7 @@
 #ifndef REFSPEC_H
 #define REFSPEC_H
 
+struct git_hash_algo;
 struct string_list;
 struct strvec;
 
@@ -33,8 +34,10 @@ struct refspec_item {
 	char *raw;
 };
 
-int refspec_item_init_fetch(struct refspec_item *item, const char *refspec);
-int refspec_item_init_push(struct refspec_item *item, const char *refspec);
+int refspec_item_init_fetch(struct refspec_item *item, const char *refspec,
+			    const struct git_hash_algo *algo);
+int refspec_item_init_push(struct refspec_item *item, const char *refspec,
+			   const struct git_hash_algo *algo);
 void refspec_item_clear(struct refspec_item *item);
 
 /**
@@ -61,7 +64,7 @@ __attribute__((format (printf,2,3)))
 void refspec_appendf(struct refspec *rs, const char *fmt, ...);
 void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
 
-int valid_fetch_refspec(const char *refspec);
+int valid_fetch_refspec(const char *refspec, const struct git_hash_algo *algo);
 
 /*
  * Determine what <prefix> values to pass to the peer in ref-prefix lines
diff --git a/remote.c b/remote.c
index e6c52c850c..b4dff1e5f9 100644
--- a/remote.c
+++ b/remote.c
@@ -3039,7 +3039,7 @@ int valid_remote_name(const char *name)
 	int result;
 	struct strbuf refspec = STRBUF_INIT;
 	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
-	result = valid_fetch_refspec(refspec.buf);
+	result = valid_fetch_refspec(refspec.buf, the_hash_algo);
 	strbuf_release(&refspec);
 	return result;
 }

-- 
2.55.0.313.g8d093f411d.dirty

