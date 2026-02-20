Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B93358D9
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575894; cv=none; b=LtKmBkrkJ21JAr0Z+ENPCebz3s/EwoaenDnHL87kQJYeJOtk7SwOP3lDTSKua7yeRYph/PepaBi5voAGyO39wR8Ne5cwWZEIdMYPrzI9lUi1Lae9nObxzgOqnHRxNmnJZa7QBzfvpBl0nQjupz4MZCjf5+hzXEGmq1tWwDQ3da4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575894; c=relaxed/simple;
	bh=93MxZyblBhdXaRIN/zdA/tFUEDJOnW6/TrOx7aUQdjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwmV9UCBgheGMd0pYE4nxkxPDkcFtt9I5nDMVIflO7JL6mKfXOkeLP+W8ZB9wWTRFxnMLR6gqPD3d3f81frleXWHPbs6N/HV2CUSveYj/u4Eyyk0F17kDWvEM5IbBd/lqN2TzoFm1tTpZaJ+4PuEk/SG612VdayNJP8kXqUZxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OerPlEGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSxGafr1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OerPlEGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSxGafr1"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 545781D00045;
	Fri, 20 Feb 2026 03:24:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 20 Feb 2026 03:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575891;
	 x=1771662291; bh=w3O8QEU8QqCFGjvTD06zByLsUmV6biJnnwyWyd2rSm0=; b=
	OerPlEGHghC6weUk1SigJccV9nc+3vpARzsg2nyxUhSSJU49hVzwxK3NlFnw/EJb
	NDHaL6suCROP6P+aPI8qdF0u42afjrNvXYwAv+FqWrdnw8QW5ENZffog3GupOEvi
	V7T0UXCO5WbESSh/ZVQEo+nY/D+AkucTBVPBECf/wwKiumwTQDfhzmfKCbkG8zc3
	sTK3VzMa4wMKa3RbaUKHkf68obVlDXmauqytpE1cGsxLjgcADQ4kKqXG82mJfAXf
	PYRiH4QtsOqZxtYmtLCZHOueJQCOsJK7e5HHLC0MVrLXLWlo+WCJJBxGzGMPx6+s
	eW20Bha3YPQQQunMgpyZ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575891; x=
	1771662291; bh=w3O8QEU8QqCFGjvTD06zByLsUmV6biJnnwyWyd2rSm0=; b=H
	SxGafr1Z6izEN6H4mCwVclqu1Q2odN58JxUW0kh/KOLvr0mcHF8qt9+siCi+rtUl
	6640aGVdxDgFk7TXPqdbV58QkJJd1hjfG7nl2IDZUss4q6K8gFkl0hmsZ87ldM6L
	D3HUnBx/YF/53bZC8ruBsWLz12NoMRfXFYmspmYkMXUxMefMY2w3SndoJvRweNk4
	OmBMbCauy4CFKZJOYdpvSrCl73pz7cAin1qFfDC0Tfnem9c+PIs5MJhfO5mIz73W
	M3DCVCIwN4VC/eakrW1QcZgiGopOAaj14Nx2Ux6PKCmtI8cQwX7/nv7nNei7OqLN
	78G9zPh+oBWkXonI4XfIA==
X-ME-Sender: <xms:UxqYaV9yBqpVVJRSormZYxJuaCTLV4uzBb8eoSgLca9tUjvoRBhhsg>
    <xme:UxqYafurp9n79WIVv-2uXP4nnUG2JSUVp_ZHrUEJ3ha9oes6itnzpH8v64WO25Ce-
    zYfIX72VRBr0-14tRez-imiZ_5nKzfa5P6MyhLzxCu2W0v05JHhLQ>
X-ME-Received: <xmr:UxqYaQqylLoLnvQPpZ82zlgijvruMSGmqAryfZcqYdkzoHcOzU4azp7n0QP6MkrPWHJpHV_IqDA3ppVjrCZZoPIC6tu_iau_xoeL1Z2IsOn6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefhgffgtdelteeuveeugfdvffejtdfhudetieejheekleeikedvfeelffdvieekgfen
    ucffohhmrghinhepphhrvghfihigvghsrdhnrhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:UxqYaUkTV_5VcZCvTbbFbzfByWTwwZUyATpfcfiEXtHEwXqwT2IbQg>
    <xmx:UxqYacxJeYUY2s7Qg8QsHRMkGg7mYny12TRQmz4lYTrXoi8WKuGmVg>
    <xmx:UxqYaUmfmVoQX1ihfembEPfRAuvzf7MMPUC83IviL_wxGvqeQMp5Rg>
    <xmx:UxqYadcaZZm4ol8rTmL3Rwgg4Ae4nu3lxxA-JWaS0DDL2hd0mHM8tQ>
    <xmx:UxqYaUs7TY-6PNQjFJH-ctNCsLCVLVnYlQADhOk3IT6wlseB63XCdV4J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a691d139 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:13 +0100
Subject: [PATCH 09/17] refs: generalize
 `refs_for_each_fullref_in_prefixes()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-9-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `refs_for_each_fullref_in_prefixes()` can be used to
iterate over all references part of any of the user-provided prefixes.
In contrast to the `prefix` parameter of `refs_for_each_ref_ext()` it
knows to handle the case well where multiple of the passed-in prefixes
start with a common prefix by computing longest common prefixes and then
iterating over those.

While we could move this logic into `refs_for_each_ref_ext()`, this one
feels somewhat special as we perform multiple iterations. But what we
_can_ do is to generalize how this function works: instead of accepting
only a small handful of parameters, we can have it accept the full
options structure.

One obvious exception is that the caller must not provide a prefix via
the options. But this case can be easily detected.

Refactor the code accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ls-refs.c    | 11 +++++++----
 ref-filter.c | 11 +++++++----
 refs.c       | 39 +++++++++++++++------------------------
 refs.h       | 16 +++++-----------
 4 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 8641281b86..9759826ca7 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -160,6 +160,7 @@ static int ls_refs_config(const char *var, const char *value,
 
 int ls_refs(struct repository *r, struct packet_reader *request)
 {
+	struct refs_for_each_ref_options opts = { 0 };
 	struct ls_refs_data data;
 
 	memset(&data, 0, sizeof(data));
@@ -201,10 +202,12 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	send_possibly_unborn_head(&data);
 	if (!data.prefixes.nr)
 		strvec_push(&data.prefixes, "");
-	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
-					  get_git_namespace(), data.prefixes.v,
-					  hidden_refs_to_excludes(&data.hidden_refs),
-					  send_ref, &data);
+
+	opts.exclude_patterns = hidden_refs_to_excludes(&data.hidden_refs);
+	opts.namespace = get_git_namespace();
+
+	refs_for_each_ref_in_prefixes(get_main_ref_store(r), data.prefixes.v,
+				      &opts, send_ref, &data);
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
diff --git a/ref-filter.c b/ref-filter.c
index 049e845a19..7c682e0a33 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2807,6 +2807,10 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       refs_for_each_cb cb,
 				       void *cb_data)
 {
+	struct refs_for_each_ref_options opts = {
+		.exclude_patterns = filter->exclude.v,
+	};
+
 	if (filter->kind & FILTER_REFS_ROOT_REFS) {
 		/* In this case, we want to print all refs including root refs. */
 		return for_each_fullref_with_seek(filter, cb, cb_data,
@@ -2836,10 +2840,9 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
-	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
-						 NULL, filter->name_patterns,
-						 filter->exclude.v,
-						 cb, cb_data);
+	return refs_for_each_ref_in_prefixes(get_main_ref_store(the_repository),
+					     filter->name_patterns, &opts,
+					     cb, cb_data);
 }
 
 /*
diff --git a/refs.c b/refs.c
index 99994879d9..20d34faeb5 100644
--- a/refs.c
+++ b/refs.c
@@ -2029,40 +2029,31 @@ static void find_longest_prefixes(struct string_list *out,
 	strbuf_release(&prefix);
 }
 
-int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
-				      const char *namespace,
-				      const char **patterns,
-				      const char **exclude_patterns,
-				      refs_for_each_cb fn, void *cb_data)
+int refs_for_each_ref_in_prefixes(struct ref_store *ref_store,
+				  const char **prefixes,
+				  const struct refs_for_each_ref_options *opts,
+				  refs_for_each_cb cb, void *cb_data)
 {
-	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
-	struct string_list prefixes = STRING_LIST_INIT_DUP;
+	struct string_list longest_prefixes = STRING_LIST_INIT_DUP;
 	struct string_list_item *prefix;
-	struct strbuf buf = STRBUF_INIT;
-	int ret = 0, namespace_len;
+	int ret = 0;
 
-	find_longest_prefixes(&prefixes, patterns);
+	if (opts->prefix)
+		BUG("refs_for_each_ref_in_prefixes called with specific prefix");
 
-	if (namespace)
-		strbuf_addstr(&buf, namespace);
-	namespace_len = buf.len;
+	find_longest_prefixes(&longest_prefixes, prefixes);
 
-	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
-							   namespace,
-							   &namespaced_exclude_patterns);
+	for_each_string_list_item(prefix, &longest_prefixes) {
+		struct refs_for_each_ref_options prefix_opts = *opts;
+		prefix_opts.prefix = prefix->string;
 
-	for_each_string_list_item(prefix, &prefixes) {
-		strbuf_addstr(&buf, prefix->string);
-		ret = refs_for_each_fullref_in(ref_store, buf.buf,
-					       exclude_patterns, fn, cb_data);
+		ret = refs_for_each_ref_ext(ref_store, cb, cb_data,
+					    &prefix_opts);
 		if (ret)
 			break;
-		strbuf_setlen(&buf, namespace_len);
 	}
 
-	strvec_clear(&namespaced_exclude_patterns);
-	string_list_clear(&prefixes, 0);
-	strbuf_release(&buf);
+	string_list_clear(&longest_prefixes, 0);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 2bde60aa0e..65d1665c72 100644
--- a/refs.h
+++ b/refs.h
@@ -520,19 +520,13 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     refs_for_each_cb fn, void *cb_data);
 
 /**
- * iterate all refs in "patterns" by partitioning patterns into disjoint sets
+ * Iterate all refs in "prefixes" by partitioning prefixes into disjoint sets
  * and iterating the longest-common prefix of each set.
- *
- * references matching any pattern in "exclude_patterns" are omitted from the
- * result set on a best-effort basis.
- *
- * callers should be prepared to ignore references that they did not ask for.
  */
-int refs_for_each_fullref_in_prefixes(struct ref_store *refs,
-				      const char *namespace,
-				      const char **patterns,
-				      const char **exclude_patterns,
-				      refs_for_each_cb fn, void *cb_data);
+int refs_for_each_ref_in_prefixes(struct ref_store *refs,
+				  const char **prefixes,
+				  const struct refs_for_each_ref_options *opts,
+				  refs_for_each_cb cb, void *cb_data);
 
 /* iterates all refs that match the specified glob pattern. */
 int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,

-- 
2.53.0.414.gf7e9f6c205.dirty

