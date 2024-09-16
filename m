Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685CA13C8E8
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476608; cv=none; b=JUDZVLA1T7AncdIEpJ55CefSmBOS3VW/yYNPDCt0Vltbhq+DDFlQL9UX+RM++ni9kNzWfiOpFaCd6SBM9UEjRLMVjtYwzgmr6poLsNiFMpkoKOGs5z/6ftuSd07ZvJ+q/yoXVXCzmz5E16WOt4rRop/qi/GBYAafbfzH1Cy6VE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476608; c=relaxed/simple;
	bh=uF2Nmbpst+4vJpluuciHEzDA46YXMWfRknvzvtMxf/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe2XV1ScRFZ/K56LKz5jHrj2c4SHULutGGcLWlfUpmul0OnIO2Av3MPO/nZEcHrI8B4oTapFwMk6KpojTPLcUMucQIweTzBN1AtlGdzQm55lhLVmnVT1CVtbz016FcclNqGDs3Npd5eTbew1Rle7xpiAc/LKy9SKxpKp0SG2PAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NRByEsN9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZzJYJRGP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NRByEsN9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZzJYJRGP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A385114023F;
	Mon, 16 Sep 2024 04:50:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 16 Sep 2024 04:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726476605; x=1726563005; bh=hwQSyJ4EGd
	GvWKgIekodrLf30L/b1E+xy7W57VYFLa4=; b=NRByEsN9qZoTEjFgKN6MgFa7HA
	Y8kuwlUimNadzeV/rpRGC1Ll7gHXGuOq1AnjfLpBrT54TRxE2UIfDitwEoHoseQh
	dNLOaPxXXVU3PdsfkT5ckHI6T9fviMXs0ewX0At/f+PGTqmmPaZVZqojAG+OGs10
	j9dFc6Yi+e0JzLkA18fvKcMhqEfCRUOCo+rxcQo2lFf1rixU93D1Bm+LjsmG9XSB
	6aCwYhXynrG9LaufBEttGixWA9VKMYcGsECjEaiVlV38cQgMBIspfgtJKtJxp8Et
	GQ9exZi1zFvkcFSLg4QHwWodqxoJYnl/z1RoOwqXRMgWNuU0RC/xgMatF61g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726476605; x=1726563005; bh=hwQSyJ4EGdGvWKgIekodrLf30L/b
	1E+xy7W57VYFLa4=; b=ZzJYJRGPMCyyXuj6DSBRsnBmhtSdvqUozZhiZ6FORW13
	0jd7xJlhVmdD3H3dpgVwglcmKw5cX/ui9gvjrH4RDU3/LtOj5B+QYMhn2rUZu+JZ
	VBbOCbUD4bKNE272kkUbh7d0ahvQH8MaTBCI5oxWoEVmuEJUJ0wbWLLdbp54vwZE
	JbzX4mWR7lUubPHayxQtpB8hifVUq/ox1GMkjzxrDrKMKSixTS9+J74o+pAedCE5
	Gp4kv5vAXh7kcIdq3WOi/VPL7ZR9op69CTnjo2UJXFLBV7WJVvjNf1bD8TBii7XN
	erUHW81rtD6R3XeVdUTZcUqkQ4ifT9h9q6XXZPLw5Q==
X-ME-Sender: <xms:PfHnZrq8aKrsd6aGDiS_mLM1PS3HgaUIgL8kllwHLmqcMy-62C7oBw>
    <xme:PfHnZlqTlTfn0OuLftTcrvfXZ78odaF0Xu8-8shgJAsROu8kWMxDJAbgQZoHEqpHY
    F9p5RL63io2Va5QWQ>
X-ME-Received: <xmr:PfHnZoPxaufTf9R4kcjiNOSF_AZaQQkGT3vIp2lrsF2F0cCHHfMxmkyJIej6vWMKnhnePqAJAZYc-OqmLk5bvGEsbxnO-l1hXtAyAZ_yE_Dw8r-D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:PfHnZu7yKyH0XX1btOfKxWZIphBbXSaIsrQhxW_rVZlXE3svHLAy5A>
    <xmx:PfHnZq4HpC9wgfrBU8GU6GGa3_dlLSXhSCrSA29cwalYI2KWJ4TSkA>
    <xmx:PfHnZmg1DCH29F5_cotuebnCzYEJWRaBD_CL8qaAxMnEHOE42Z3hTQ>
    <xmx:PfHnZs6-q-htjcFdmCLyX88qUcG8bqYIi4m4b5nCUfdVYlspnFByow>
    <xmx:PfHnZgngbg3JGu6l6x5crLxjcknYga_YbcEqiXy2ldaRQAXdC9XT4p7f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 04:50:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93f4b081 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 08:49:47 +0000 (UTC)
Date: Mon, 16 Sep 2024 10:50:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/6] refs: properly apply exclude patterns to namespaced
 refs
Message-ID: <7497166422ea702aabdf4159b0d7780f1422ba13.1726476401.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726476401.git.ps@pks.im>

Reference namespaces allow commands like git-upload-pack(1) to serve
different sets of references to the client depending on which namespace
is enabled, which is for example useful in fork networks. Namespaced
refs are stored with a `refs/namespaces/$namespace` prefix, but all the
user will ultimately see is a stripped version where that prefix is
removed.

The way that this interacts with "transfer.hideRefs" is not immediately
obvious: the hidden refs can either apply to the stripped references, or
to the non-stripped ones that still have the namespace prefix. In fact,
the "transfer.hideRefs" machinery does the former and applies to the
stripped reference by default, but rules can have "^" prefixed to switch
this behaviour to instead match against the full reference name.

Namespaces are exclusively handled at the generic "refs" layer, the
respective backends have no clue that such a thing even exists. This
also has the consequence that they cannot handle hiding references as
soon as reference namespaces come into play because they neither know
whether a namespace is active, nor do they know how to strip references
if they are active.

Handling such exclude patterns in `refs_for_each_namespaced_ref()` and
`refs_for_each_fullref_in_prefixes()` is broken though, as both support
that the user passes both namespaces and exclude patterns. In the case
where both are set we will exclude references with unstripped names,
even though we really wanted to exclude references based on their
stripped names.

This only surfaces when:

  - A repository uses reference namespaces.

  - "transfer.hideRefs" is active.

  - The namespaced references are packed into the "packed-refs" file.

None of our tests exercise this scenario, and thus we haven't ever hit
it. While t5509 exercises both (1) and (2), it does not happen to hit
(3). It is trivial to demonstrate the bug though by explicitly packing
refs in the tests, and then we indeed surface the breakage.

Fix this bug by prefixing exclude patterns with the namespace in the
generic layer. The newly introduced function will be used outside of
"refs.c" in the next patch, so we add a declaration to "refs.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                           | 35 ++++++++++++++++++++++++++++----
 refs.h                           |  9 ++++++++
 t/t5509-fetch-push-namespaces.sh |  1 +
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index ceb72d4bd74..b3a367ea12c 100644
--- a/refs.c
+++ b/refs.c
@@ -1517,6 +1517,19 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
 	return hide_refs->v;
 }
 
+const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
+					     const char *namespace,
+					     struct strvec *out)
+{
+	if (!namespace || !*namespace || !exclude_patterns || !*exclude_patterns)
+		return exclude_patterns;
+
+	for (size_t i = 0; exclude_patterns[i]; i++)
+		strvec_pushf(out, "%s%s", namespace, exclude_patterns[i]);
+
+	return out->v;
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
@@ -1634,11 +1647,19 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 const char **exclude_patterns,
 				 each_ref_fn fn, void *cb_data)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
+	struct strbuf prefix = STRBUF_INIT;
 	int ret;
-	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(refs, buf.buf, exclude_patterns, fn, 0, 0, cb_data);
-	strbuf_release(&buf);
+
+	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
+							   get_git_namespace(),
+							   &namespaced_exclude_patterns);
+
+	strbuf_addf(&prefix, "%srefs/", get_git_namespace());
+	ret = do_for_each_ref(refs, prefix.buf, exclude_patterns, fn, 0, 0, cb_data);
+
+	strvec_clear(&namespaced_exclude_patterns);
+	strbuf_release(&prefix);
 	return ret;
 }
 
@@ -1719,6 +1740,7 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
 				      const char **exclude_patterns,
 				      each_ref_fn fn, void *cb_data)
 {
+	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
 	struct string_list_item *prefix;
 	struct strbuf buf = STRBUF_INIT;
@@ -1730,6 +1752,10 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
 		strbuf_addstr(&buf, namespace);
 	namespace_len = buf.len;
 
+	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
+							   namespace,
+							   &namespaced_exclude_patterns);
+
 	for_each_string_list_item(prefix, &prefixes) {
 		strbuf_addstr(&buf, prefix->string);
 		ret = refs_for_each_fullref_in(ref_store, buf.buf,
@@ -1739,6 +1765,7 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
 		strbuf_setlen(&buf, namespace_len);
 	}
 
+	strvec_clear(&namespaced_exclude_patterns);
 	string_list_clear(&prefixes, 0);
 	strbuf_release(&buf);
 	return ret;
diff --git a/refs.h b/refs.h
index f8b919a1388..3f774e96d18 100644
--- a/refs.h
+++ b/refs.h
@@ -859,6 +859,15 @@ int ref_is_hidden(const char *, const char *, const struct strvec *);
  */
 const char **hidden_refs_to_excludes(const struct strvec *hide_refs);
 
+/*
+ * Prefix all exclude patterns with the namespace, if any. This is required
+ * because exclude patterns apply to the stripped reference name, not the full
+ * reference name with the namespace.
+ */
+const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
+					     const char *namespace,
+					     struct strvec *out);
+
 /* Is this a per-worktree ref living in the refs/ namespace? */
 int is_per_worktree_ref(const char *refname);
 
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 05090feaf92..98e8352b6cc 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -96,6 +96,7 @@ test_expect_success 'hide namespaced refs with transfer.hideRefs' '
 '
 
 test_expect_success 'check that transfer.hideRefs does not match unstripped refs' '
+	git -C pushee pack-refs --all &&
 	GIT_NAMESPACE=namespace \
 		git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
 		ls-remote "ext::git %s ." >actual &&
-- 
2.46.0.551.gc5ee8f2d1c.dirty

