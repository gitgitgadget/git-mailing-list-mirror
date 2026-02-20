Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858171E9B12
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575887; cv=none; b=NrwFoixKPohsFenjux3yfk4m7SpSqY5D+Ez/0hYocwMO/jLGr8sBjggY7lhR5dHUMf6g007y9qoyVBcspiqLeHrw37HmFguXQloilZbiuw5TRBVLuk7VafwXu9N0J3HXbpxn3cgjgN/bNXT/neeI4TRXdhk/DnwScCTE8oNBtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575887; c=relaxed/simple;
	bh=i+iv6fUiHP5WdvCK8qzlsg8sZOezwIDBGHsCwRcz7jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPAgmxmfwjbPAwnk+TvsGyCLl7BmpiYi08+UO0wD+9X/gwwkeGrDxrcEJPYcj2eWgtpFWlZaO7t1vjnyItzuPqLHdj6GsUvbk32msznfgqnzYksk3jIiFNYivBvKjBShrPsAg/ziDr69GmC2ObKBeZ19DTEyoqK9GtCeIeY9HzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZUFasRMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ug6IoZRm; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZUFasRMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ug6IoZRm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 959087A0011;
	Fri, 20 Feb 2026 03:24:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 03:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575885;
	 x=1771662285; bh=G7qmaM95mSOmo3G0QkdKyYRgPZ5Gl6YU3qhw3US42OQ=; b=
	ZUFasRMfZBY3sDzcb/hcucZ7Kuqguw5e6JNGYNDeonxixhqKBKWUXI7oVCQchxf4
	OQmc6MtinrTadPA/s93BN2dOaH2nT8Er/Wtv6xmMjk1v2HLIedzhE8UUDZD1Tng8
	9Ttszh6DLLP9Gpyf3aXJvnZS7j3BYLe2qsPIud+XNHibKYqHYF8VjLOKsVzY5nKH
	8HAoNEYyHwbZJn0cb4fH1HtE8vIA+NKD7Jdyn4mmw/MILqORUQAmeXwHq3JD5fKI
	pmXRNKQF/G3VxAxFghHuX2KD7daeJGoamoSsDthDfpVNFq0elI8rx+/lHj9v3qKu
	MFmBvdPoQQm+549KWkWclQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575885; x=
	1771662285; bh=G7qmaM95mSOmo3G0QkdKyYRgPZ5Gl6YU3qhw3US42OQ=; b=u
	g6IoZRmDPoX59QZKAUHm28yT2EfnpYpME350Drs9c9/GlBtITu/u9vDp+d/gk4+w
	w656lNTpD6Lx7uyyhjjY3LzVnGvibY4r7AYQNND1G18xx7UWU4x4cnhFD01c0+kX
	4f0vx2fsfk6b2EJOr0M1U3SwQxJdm5Xvh71s57Vf593dP2+MAtmYreIQlCv+xB54
	qbryYWgObv/4KR9tIBXBArSXtuUrY8LQEiba5rR+JekT+XGxafbEzqW6+avPUo0P
	xAsAo5BOaSB8FNZC4PoplMoWhlMCGCxMs2trC7ypBkfXVyde7b0r24CLLdjb7UKp
	SIVX2dZrO+7ojKBkWLP+g==
X-ME-Sender: <xms:TRqYaTfmo59Q4ikA8GFu0CHekJTPtWL9BwHAjNlcnPW1RSL5VSZaKw>
    <xme:TRqYafMO5v7Q_gimFhTZ9WfHz2INTtMZh8HJig6D-d3suOsbU76ejGdx6evBYPn30
    _sJNq7h0u1z-PyfWOz43GWoMruvBDbCRuOsPUpXWAxQR86Mutmu_g>
X-ME-Received: <xmr:TRqYaaKlr--rZGw1R830IA8Gwi5tDPNt6hnFvA7J0ohIcLf_W_ZAPHO7BS75S_A8hEaIksi_cGNyC-dHP7AMUCAcv79VaASS1AIpFoYFZ6oG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TRqYaQFbyzHZx9vKNQJ31UKj4iqzP0mu3Pa2Dw_F1wDMyAd5Q66ftw>
    <xmx:TRqYaSQjC5QIUzS5OMid0toRYteC9BlkEGAMVgSE-EL0YpWJmj3PVg>
    <xmx:TRqYacE5GEWgL6dK-U4m9gONK8g-9ab0tjrNGUJvd4izlKLA2Kt_7Q>
    <xmx:TRqYae-vtKb00ZBHThY7sGi6jcIurTFY5u7mJ5BqgMfCzcVRn9dZSQ>
    <xmx:TRqYaaMsVIlEgn0g1syH8zglfXXnc4HrNwIxQ2H_qAj4_OCn6D7g7iKM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe0148d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:11 +0100
Subject: [PATCH 07/17] refs: speed up `refs_for_each_glob_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-7-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `refs_for_each_glob_ref_in()` can be used to iterate
through all refs in a specific prefix with globbing. The logic to handle
this is currently hosted by `refs_for_each_glob_ref_in()`, which sets up
a callback function that knows to filter out refs that _don't_ match the
given globbing pattern.

The way we do this is somewhat inefficient though: even though the
function is expected to only yield refs in the given prefix, we still
end up iterating through _all_ references, regardless of whether or not
their name matches the given prefix.

Extend `refs_for_each_ref_ext()` so that it can handle patterns and
adapt `refs_for_each_glob_ref_in()` to use it. This means we continue to
use the same callback-based infrastructure to filter individual refs via
the globbing pattern, but we can now also use the other functionality of
the `_ext()` variant.

Most importantly, this means that we now properly handle the prefix.
This results in a performance improvement when using a prefix where a
significant majority of refs exists outside of the prefix. The following
benchmark is an extreme case, with 1 million refs that exist outside the
prefix and a single ref that exists inside it:

    Benchmark 1: git rev-parse --branches=refs/heads/* (rev = HEAD~)
      Time (mean ± σ):     115.9 ms ±   0.7 ms    [User: 113.0 ms, System: 2.4 ms]
      Range (min … max):   114.9 ms … 117.8 ms    25 runs

    Benchmark 2: git rev-parse --branches=refs/heads/* (rev = HEAD)
      Time (mean ± σ):       1.1 ms ±   0.1 ms    [User: 0.3 ms, System: 0.7 ms]
      Range (min … max):     1.0 ms …   2.3 ms    2092 runs

    Summary
      git rev-parse --branches=refs/heads/* (rev = HEAD) ran
      107.01 ± 6.49 times faster than git rev-parse --branches=refs/heads/* (rev = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 69 ++++++++++++++++++++++++++++++++++++++----------------------------
 refs.h | 10 ++++++++++
 2 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index ec9e466381..ac34bbe6c1 100644
--- a/refs.c
+++ b/refs.c
@@ -590,40 +590,23 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
 
-int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb fn,
+int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb cb,
 			      const char *pattern, const char *prefix, void *cb_data)
 {
-	struct strbuf real_pattern = STRBUF_INIT;
-	struct for_each_ref_filter filter;
-	int ret;
-
-	if (!prefix && !starts_with(pattern, "refs/"))
-		strbuf_addstr(&real_pattern, "refs/");
-	else if (prefix)
-		strbuf_addstr(&real_pattern, prefix);
-	strbuf_addstr(&real_pattern, pattern);
-
-	if (!has_glob_specials(pattern)) {
-		/* Append implied '/' '*' if not present. */
-		strbuf_complete(&real_pattern, '/');
-		/* No need to check for '*', there is none. */
-		strbuf_addch(&real_pattern, '*');
-	}
-
-	filter.pattern = real_pattern.buf;
-	filter.prefix = prefix;
-	filter.fn = fn;
-	filter.cb_data = cb_data;
-	ret = refs_for_each_ref(refs, for_each_filter_refs, &filter);
-
-	strbuf_release(&real_pattern);
-	return ret;
+	struct refs_for_each_ref_options opts = {
+		.pattern = pattern,
+		.prefix = prefix,
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,
+int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb cb,
 			   const char *pattern, void *cb_data)
 {
-	return refs_for_each_glob_ref_in(refs, fn, pattern, NULL, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.pattern = pattern,
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 const char *prettify_refname(const char *name)
@@ -1862,16 +1845,44 @@ int refs_for_each_ref_ext(struct ref_store *refs,
 			  refs_for_each_cb cb, void *cb_data,
 			  const struct refs_for_each_ref_options *opts)
 {
+	struct strbuf real_pattern = STRBUF_INIT;
+	struct for_each_ref_filter filter;
 	struct ref_iterator *iter;
+	int ret;
 
 	if (!refs)
 		return 0;
 
+	if (opts->pattern) {
+		if (!opts->prefix && !starts_with(opts->pattern, "refs/"))
+			strbuf_addstr(&real_pattern, "refs/");
+		else if (opts->prefix)
+			strbuf_addstr(&real_pattern, opts->prefix);
+		strbuf_addstr(&real_pattern, opts->pattern);
+
+		if (!has_glob_specials(opts->pattern)) {
+			/* Append implied '/' '*' if not present. */
+			strbuf_complete(&real_pattern, '/');
+			/* No need to check for '*', there is none. */
+			strbuf_addch(&real_pattern, '*');
+		}
+
+		filter.pattern = real_pattern.buf;
+		filter.prefix = opts->prefix;
+		filter.fn = cb;
+		filter.cb_data = cb_data;
+
+		cb = for_each_filter_refs;
+		cb_data = &filter;
+	}
+
 	iter = refs_ref_iterator_begin(refs, opts->prefix ? opts->prefix : "",
 				       opts->exclude_patterns,
 				       opts->trim_prefix, opts->flags);
 
-	return do_for_each_ref_iterator(iter, cb, cb_data);
+	ret = do_for_each_ref_iterator(iter, cb, cb_data);
+	strbuf_release(&real_pattern);
+	return ret;
 }
 
 int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
diff --git a/refs.h b/refs.h
index bb9c64a51c..a66dbf3865 100644
--- a/refs.h
+++ b/refs.h
@@ -458,6 +458,16 @@ struct refs_for_each_ref_options {
 	/* Only iterate over references that have this given prefix. */
 	const char *prefix;
 
+	/*
+	 * A globbing pattern that can be used to only yield refs that match.
+	 * If given, refs will be matched against the pattern with
+	 * `wildmatch()`.
+	 *
+	 * If the pattern doesn't contain any globbing characters then it is
+	 * treated as if it was ending with "/" and "*".
+	 */
+	const char *pattern;
+
 	/*
 	 * Exclude any references that match any of these patterns on a
 	 * best-effort basis. The caller needs to be prepared for the exclude

-- 
2.53.0.414.gf7e9f6c205.dirty

