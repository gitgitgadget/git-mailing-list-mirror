Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83634EF05
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847987; cv=none; b=lxhT2X5dnM/kGIpyVykDMaRJFhp0TNKDDYmJIxmp2IjI2RA1B2W4+f9w6E7G8ytS7NCrQTzjVvqroycNQoHp23XM7Dznc6NHPKTbowu2Z+M/hK56PlpX2dphzFdb4Y5s+VkkBXaISUMpBGztEZmoHbPlPlVIMuAPD4cHlmx3LYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847987; c=relaxed/simple;
	bh=X0O4wF6RZXSkgkK8H4EajyGecH66CPC5KPmnftSvlqM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Rj9oxTtdxd13hUxRgsHX54+6GiPvhLO8aY0VhAyG+iFct03nhN4tJOxf6oGRaa/gqgodQr8buM7Y9FputlUj6X9+6ZxZsVMQPoKz0VdUFDee2q3VBVh0Z5WVrOTPfNAlSSc14gGguJL+f3R/9rr7WJdVoaQHPb1BHpD5A//teVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wp2Ha5bo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2b/yqFt; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wp2Ha5bo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2b/yqFt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C010140018E;
	Mon, 23 Feb 2026 06:59:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 06:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771847983;
	 x=1771934383; bh=aqenySt4tQjEy+bu4iEjvnn1EQV8HSW/42DhuIEkcMg=; b=
	Wp2Ha5boErpBMczlM1xba5PRpwdgNbRy+PBhlRxUssXRQiF9iUTnpzFqNZbbVu9u
	fEEacrAQqRvqc4RboHAphdcuV4zyxC3tBwDvSFWCrwl9gpGlq97en2noIWbC87CH
	pXDDM/Zs8zrjfETVk+jAWn/R0tgl/qbcNd7YLH/6YizJsOcJtqLbmsRb4K7bLkIa
	W2SBOa0ks04WKpcJgnO3yt87KuuJ2tUZ6ZIGgecS1BJdN2J0F42qrIJ3tyHlwM2G
	z4CheLdqHSCvhpyU0iml/d76BE1l61Asb2kYRH0uLTpuhHU47OrnCh7WZIlyAUq5
	fbjs7OlR+R6Uo1hhpWYubg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771847983; x=
	1771934383; bh=aqenySt4tQjEy+bu4iEjvnn1EQV8HSW/42DhuIEkcMg=; b=V
	2b/yqFtjNZiSBrlEazhXopCaxjIew75VkDn/tI3xY8O6/tfdYuRFNE9Ls0MqdZMM
	3+hxlxXdYjslDTwSAyQnjgwPAFA5HHsW02fkUCFRQn4laiLN9oxO4PEFpKGTMr1X
	CqxJXH6N93EmxSxwHXcAYqfh4TmlAs0ANL9xW3UuGNIg3BcEV4uSHJKOhy4IxOrW
	tgC4tVYLB8wlqbr+FFxGqkkWkEIYfG4tLdP1KgwUb5nkX5vacnvBT/qjvs67WSvZ
	Y4US7JAOpF63BDI6vS4iUAom0X12fX4YCDY2pTDTPnT3VAtDHYito4m9kwsGgOG5
	CUnakL13ylfFkKGeH2qUw==
X-ME-Sender: <xms:L0GcaYO6VM0O5WJSXfepJm2WFct9SGxOzB5RBwuqtyyST-mgBGGT2A>
    <xme:L0GcaWYTO8nXA1E_9z1yJmGsc6-J2YLo508j6mfet3--lXKc8C4lb8oIpQ3tKm1KM
    z0iyQf4gyoh4sdQInWmxEABCHI-qrH3pFolwTFCpAPOZILD59G2>
X-ME-Received: <xmr:L0GcacruGkyAXS5amB2isPcsoQd4NNqMms2rkMD_7rpkm5MTu22Pr2wHOru6EMSRR_7L6ycA053HILa1YQOBszEqls4HNwJJptleU7v7jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:L0GcaaarA9Hz8QuEpIvZ2LiA-0SxruzF-wfDlKWCdbM1STXJF7GYgg>
    <xmx:L0GcaUS1MOYIJSlqemYvFmQsGqgTPExejEf6udIxAPg1Hy_gN7uF8Q>
    <xmx:L0GcaR7H2eLzRqrEbYN3Vg8s4XjKTT-8i6x97EuFiGPAJMTljRNDYg>
    <xmx:L0GcaZzFGUE1vZZbHMncsQ5UVP7geQBb5Y9TMiIwNkSs2ldtaGReGQ>
    <xmx:L0GcaV4T7_e2_a29IjBm14ussUza7vhn0tOSTlCdBJl0NM5agivlU-Ni>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 06:59:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id add5b458 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:59:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/17] refs: unify `refs_for_each_*()` functions
Date: Mon, 23 Feb 2026 12:59:34 +0100
Message-Id: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZBnGkC/42NQQrCMBBFr1Jm7UgStCGuvEfpIqYTO4hpSWpRS
 u7u2BO4fJ//39+gUGYqcGk2yLRy4SkJmEMDYfTpTsiDMBhlWmWMwvlRMFMsGKeM5MOIr8SRg19
 kifZsTWjdKcSgQByzVPm9+7teeOSyTPmz3636l/5rXjUq1FZbdRucG0hfpX/kJ/S11i+MpgALx
 wAAAA==
X-Change-ID: 20260220-pks-refs-for-each-unification-7572c694cfc0
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Hi,

we currently have 14 different `refs_for_each_*()` functions, with each
of them doing slightly different things. This makes for a confusing API
surface, and because the API is not built for extension we have to add a
new function every now and then to handle another esoteric edge case
that will ultimately only have at most a handful of callers.

This design isn't really sensible in my opinion, and this patch series
aims to fix that. Instead of having a dozen different functions, it
introduces a new `refs_for_each_ref_ext()` function that simply takes an
options structure as input. From thereon, callers can mix and match the
parameters that they care about.

The patch series is structured like this:

  - Patches 1 to 5 introduce some preliminary cleanups.

  - Patches 6 to 9 introduce `refs_for_each_ref_ext()` and move
    more functionality into it. This also fixes a performance bug that
    we have in one of the implementations.

  - Patch 10 adds some more verification for options that would have
    caught the bugs in ps/for-each-ref-in-fixes.

  - The remaining patches drop 7 out of 14 functions and replace them
    with `refs_for_each_ref_ext()`. It results in a bit of churn, so
    while I think this churn is worth it, I consider these patches to be
    optional.

The patch series is built on top of 73fd77805f (The 5th batch,
2026-02-17) with ps/for-each-ref-in-fixes at 6375a00ef1 (bisect:
simplify string_list memory handling, 2026-02-19) merged into it.

Changes in v2:
  - Move the removal of `refs_for_each_include_root_ref()` to the
    beginning of the series to avoid some unnecessary churn.
  - Some commit message improvements.
  - Make the converted version of `refs_for_each_glob_ref_in()` fit into
    the new calling conventions a bit better. The function was still
    stripping the prefix unconditionally for example, which I've now
    changed.
  - Link to v1: https://lore.kernel.org/r/20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (17):
      refs: remove unused `refs_for_each_include_root_ref()`
      refs: move `refs_head_ref_namespaced()`
      refs: move `do_for_each_ref_flags` further up
      refs: rename `do_for_each_ref_flags`
      refs: rename `each_ref_fn`
      refs: introduce `refs_for_each_ref_ext`
      refs: speed up `refs_for_each_glob_ref_in()`
      refs: generalize `refs_for_each_namespaced_ref()`
      refs: generalize `refs_for_each_fullref_in_prefixes()`
      refs: improve verification for-each-ref options
      refs: replace `refs_for_each_ref_in()`
      refs: replace `refs_for_each_rawref()`
      refs: replace `refs_for_each_rawref_in()`
      refs: replace `refs_for_each_glob_ref_in()`
      refs: replace `refs_for_each_glob_ref()`
      refs: replace `refs_for_each_namespaced_ref()`
      refs: replace `refs_for_each_fullref_in()`

 bisect.c                  |  16 ++-
 builtin/bisect.c          |  37 +++++--
 builtin/describe.c        |   7 +-
 builtin/fetch.c           |   7 +-
 builtin/fsck.c            |   7 +-
 builtin/receive-pack.c    |   8 +-
 builtin/remote.c          |   8 +-
 builtin/rev-parse.c       |  38 ++++---
 builtin/show-ref.c        |  21 ++--
 fetch-pack.c              |  15 ++-
 http-backend.c            |   8 +-
 ls-refs.c                 |  11 +-
 notes.c                   |   7 +-
 pack-bitmap.c             |  15 +--
 pack-bitmap.h             |   2 +-
 ref-filter.c              |  19 ++--
 refs.c                    | 271 ++++++++++++++++++++++------------------------
 refs.h                    | 199 +++++++++++++++++-----------------
 refs/files-backend.c      |  19 ++--
 refs/iterator.c           |   2 +-
 refs/packed-backend.c     |   8 +-
 refs/reftable-backend.c   |  10 +-
 revision.c                |  49 ++++++---
 submodule.c               |   2 +-
 t/helper/test-ref-store.c |  15 ++-
 upload-pack.c             |  13 ++-
 worktree.c                |   2 +-
 worktree.h                |   2 +-
 28 files changed, 457 insertions(+), 361 deletions(-)

Range-diff versus v1:

 -:  ---------- >  1:  97473a19a8 refs: remove unused `refs_for_each_include_root_ref()`
 1:  312fde9bc7 !  2:  625d8bde9d refs: move `refs_head_ref_namespaced()`
    @@ Commit message
     
         The function `refs_head_ref_namespaced()` is somewhat special when
         compared to most of the other functions that take a callback function:
    -    while `refs_for_each_*()` functions yield multiple refs, we only yield
    -    at most the HEAD ref of the current function. As such, the function is
    -    related to `refs_head_ref()` and not to the for-each functions.
    +    while `refs_for_each_*()` functions yield multiple refs,
    +    `refs_heasd_ref_namespaced()` will only yield at most the HEAD ref of
    +    the current namespace. As such, the function is related to
    +    `refs_head_ref()` and not to the for-each functions.
     
         Move the function to be located next to `refs_head_ref()` to clarify.
     
 2:  fd0fa20a37 =  3:  2f5a6e7d27 refs: move `do_for_each_ref_flags` further up
 3:  f11af1c8e7 !  4:  a817b11091 refs: rename `do_for_each_ref_flags`
    @@ refs.c: int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
     +			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
      }
      
    - int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
    - 				    void *cb_data)
    - {
    - 	return do_for_each_ref(refs, "", NULL, fn, 0,
    --			       DO_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
    -+			       REFS_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
    - }
    - 
      static int qsort_strcmp(const void *va, const void *vb)
     @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
      
 4:  37be4c5f59 !  5:  f06b4fc5e4 refs: rename `each_ref_fn`
    @@ refs.c: int refs_for_each_namespaced_ref(struct ref_store *refs,
      {
      	return do_for_each_ref(refs, prefix, NULL, fn, 0,
      			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
    - }
    - 
    --int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
    -+int refs_for_each_include_root_refs(struct ref_store *refs, refs_for_each_cb fn,
    - 				    void *cb_data)
    - {
    - 	return do_for_each_ref(refs, "", NULL, fn, 0,
     @@ refs.c: int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
      				      const char *namespace,
      				      const char **patterns,
    @@ refs.h: int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
     +			    refs_for_each_cb fn, void *cb_data);
      
      /*
    -  * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
    -  */
    --int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
    -+int refs_for_each_include_root_refs(struct ref_store *refs, refs_for_each_cb fn,
    - 				    void *cb_data);
    - 
    - /*
    +  * Normalizes partial refs to their fully qualified form.
     @@ refs.h: void ref_iterator_free(struct ref_iterator *ref_iterator);
       * iterator style.
       */
 5:  d70867c5f6 <  -:  ---------- refs: remove unused `refs_for_each_include_root_ref()`
 6:  b22f654698 =  6:  58620a64dd refs: introduce `refs_for_each_ref_ext`
 7:  0a050b61f7 !  7:  2ca0ddb23a refs: speed up `refs_for_each_glob_ref_in()`
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## refs.c ##
    +@@ refs.c: char *refs_resolve_refdup(struct ref_store *refs,
    + /* The argument to for_each_filter_refs */
    + struct for_each_ref_filter {
    + 	const char *pattern;
    +-	const char *prefix;
    ++	size_t trim_prefix;
    + 	refs_for_each_cb *fn;
    + 	void *cb_data;
    + };
    +@@ refs.c: static int for_each_filter_refs(const struct reference *ref, void *data)
    + 
    + 	if (wildmatch(filter->pattern, ref->name, 0))
    + 		return 0;
    +-	if (filter->prefix) {
    ++	if (filter->trim_prefix) {
    + 		struct reference skipped = *ref;
    +-		skip_prefix(skipped.name, filter->prefix, &skipped.name);
    ++		if (strlen(skipped.name) <= filter->trim_prefix)
    ++			BUG("attempt to trim too many characters");
    ++		skipped.name += filter->trim_prefix;
    + 		return filter->fn(&skipped, filter->cb_data);
    + 	} else {
    + 		return filter->fn(ref, filter->cb_data);
     @@ refs.c: void normalize_glob_ref(struct string_list_item *item, const char *prefix,
      	strbuf_release(&normalized_pattern);
      }
    @@ refs.c: void normalize_glob_ref(struct string_list_item *item, const char *prefi
     +	struct refs_for_each_ref_options opts = {
     +		.pattern = pattern,
     +		.prefix = prefix,
    ++		.trim_prefix = prefix ? strlen(prefix) : 0,
     +	};
     +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
      }
    @@ refs.c: int refs_for_each_ref_ext(struct ref_store *refs,
     +	struct strbuf real_pattern = STRBUF_INIT;
     +	struct for_each_ref_filter filter;
      	struct ref_iterator *iter;
    ++	size_t trim_prefix = opts->trim_prefix;
     +	int ret;
      
      	if (!refs)
    @@ refs.c: int refs_for_each_ref_ext(struct ref_store *refs,
     +		}
     +
     +		filter.pattern = real_pattern.buf;
    -+		filter.prefix = opts->prefix;
    ++		filter.trim_prefix = opts->trim_prefix;
     +		filter.fn = cb;
     +		filter.cb_data = cb_data;
     +
    ++		/*
    ++		 * We need to trim the prefix in the callback function as the
    ++		 * pattern is expected to match on the full refname.
    ++		 */
    ++		trim_prefix = 0;
    ++
     +		cb = for_each_filter_refs;
     +		cb_data = &filter;
     +	}
     +
      	iter = refs_ref_iterator_begin(refs, opts->prefix ? opts->prefix : "",
      				       opts->exclude_patterns,
    - 				       opts->trim_prefix, opts->flags);
    +-				       opts->trim_prefix, opts->flags);
    ++				       trim_prefix, opts->flags);
      
     -	return do_for_each_ref_iterator(iter, cb, cb_data);
     +	ret = do_for_each_ref_iterator(iter, cb, cb_data);
 8:  b15d334f14 !  8:  01a640a61d refs: generalize `refs_for_each_namespaced_ref()`
    @@ refs.c: int refs_for_each_ref_ext(struct ref_store *refs,
      	struct strbuf real_pattern = STRBUF_INIT;
      	struct for_each_ref_filter filter;
      	struct ref_iterator *iter;
    + 	size_t trim_prefix = opts->trim_prefix;
     +	const char **exclude_patterns;
     +	const char *prefix;
      	int ret;
    @@ refs.c: int refs_for_each_ref_ext(struct ref_store *refs,
     +	}
     +
     +	iter = refs_ref_iterator_begin(refs, prefix, exclude_patterns,
    - 				       opts->trim_prefix, opts->flags);
    + 				       trim_prefix, opts->flags);
      
      	ret = do_for_each_ref_iterator(iter, cb, cb_data);
     +
    @@ refs.h: struct refs_for_each_ref_options {
      
     +	/*
     +	 * If set, only yield refs part of the configured namespace. Exclude
    -+	 * patterns will be rewritten to apply to the namespace.
    ++	 * patterns will be rewritten to apply to the namespace, and the prefix
    ++	 * will be considered relative to the namespace.
     +	 */
     +	const char *namespace;
     +
 9:  2e63b1ab88 =  9:  241030d7ad refs: generalize `refs_for_each_fullref_in_prefixes()`
10:  b408e5c1f0 ! 10:  548aae78f0 refs: improve verification for-each-ref options
    @@ refs.c: int refs_for_each_ref_ext(struct ref_store *refs,
      
      	if (!refs)
     -		return 0;
    -+		BUG("no refs passed");
    ++		BUG("no ref store passed");
     +
     +	if (opts->trim_prefix) {
     +		size_t prefix_len;
11:  5c9401df32 = 11:  b0a5c835be refs: replace `refs_for_each_ref_in()`
12:  39a5f1ef21 = 12:  59f5632719 refs: replace `refs_for_each_rawref()`
13:  5568ee95d0 = 13:  8b99f6e38c refs: replace `refs_for_each_rawref_in()`
14:  d73e6362ae ! 14:  ed75a64569 refs: replace `refs_for_each_glob_ref_in()`
    @@ builtin/bisect.c: static void bisect_status(struct bisect_state *state,
     +	struct refs_for_each_ref_options opts = {
     +		.pattern = good_glob,
     +		.prefix = "refs/bisect/",
    ++		.trim_prefix = strlen("refs/bisect/"),
     +	};
      
      	if (refs_ref_exists(get_main_ref_store(the_repository), bad_ref))
    @@ builtin/bisect.c: static int add_bisect_ref(const struct reference *ref, void *c
      {
     +	struct refs_for_each_ref_options opts = {
     +		.prefix = "refs/bisect/",
    ++		.trim_prefix = strlen("refs/bisect/"),
     +	};
      	int res = 0;
      	struct add_bisect_ref_data cb = { revs };
    @@ builtin/bisect.c: static int verify_good(const struct bisect_terms *terms, const
     +	struct refs_for_each_ref_options opts = {
     +		.pattern = good_glob,
     +		.prefix = "refs/bisect/",
    ++		.trim_prefix = strlen("refs/bisect/"),
     +	};
      
     -	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
    @@ builtin/rev-parse.c: static int opt_with_value(const char *arg, const char *opt,
     +		struct refs_for_each_ref_options opts = {
     +			.pattern = pattern,
     +			.prefix = prefix,
    ++			.trim_prefix = prefix ? strlen(prefix) : 0,
     +		};
     +		refs_for_each_ref_ext(get_main_ref_store(the_repository),
     +				      show_reference, NULL, &opts);
    @@ refs.c: void normalize_glob_ref(struct string_list_item *item, const char *prefi
     -	struct refs_for_each_ref_options opts = {
     -		.pattern = pattern,
     -		.prefix = prefix,
    +-		.trim_prefix = prefix ? strlen(prefix) : 0,
     -	};
     -	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
     -}
    @@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *revs,
      	} else if (skip_prefix(arg, "--branches=", &optarg)) {
     +		struct refs_for_each_ref_options opts = {
     +			.prefix = "refs/heads/",
    ++			.trim_prefix = strlen("refs/heads/"),
     +			.pattern = optarg,
     +		};
      		struct all_refs_cb cb;
    @@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *revs,
      	} else if (skip_prefix(arg, "--tags=", &optarg)) {
     +		struct refs_for_each_ref_options opts = {
     +			.prefix = "refs/tags/",
    ++			.trim_prefix = strlen("refs/tags/"),
     +			.pattern = optarg,
     +		};
      		struct all_refs_cb cb;
    @@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *revs,
      	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
     +		struct refs_for_each_ref_options opts = {
     +			.prefix = "refs/remotes/",
    ++			.trim_prefix = strlen("refs/remotes/"),
     +			.pattern = optarg,
     +		};
      		struct all_refs_cb cb;
15:  c957d80f2d = 15:  6256a04ecf refs: replace `refs_for_each_glob_ref()`
16:  229d69d91c = 16:  ef356544bf refs: replace `refs_for_each_namespaced_ref()`
17:  4e0fe9f805 = 17:  4616cdc618 refs: replace `refs_for_each_fullref_in()`

---
base-commit: dbbe43524e0814c1f93325795ed6aa26eb6e587e
change-id: 20260220-pks-refs-for-each-unification-7572c694cfc0

