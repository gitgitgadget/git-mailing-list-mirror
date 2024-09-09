Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D81B3B2B
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881498; cv=none; b=CoNjztOtsVzJAbbnq4i3QIwSAE0RUGnpXnFy3KRSzpXCRR3PYb3DXq5f5NP8h13rzMdRumstM8VK2CALbCe4SZxJMHGvYNIXtwTsrkwj8GeImFfjUrIftJwRbhLuUrxwCQ0zKpCpxJRd4/w65rY9hteV34XioGyAabDPOwTq6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881498; c=relaxed/simple;
	bh=O3fkYiOPfuuDQhKtOxqNDut+i6MK+7mRh3Twxq5pWew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiLffQVPZ5bEwvRAqPtQBAB3I4su+2oxFQYyobDngFpxTaM7NAd38jxot8iRFyij9Yrq0yC2ABaWszXVdtYB0NTwYsAKs9R8lBhoCMOHcaIUDHUSpnt/MKLrUxvsRXgEDNKYiZ81U1UvVTkLpkN+XCgogde35lDPrmX7roFYyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bySUbohZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BURFyzE1; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bySUbohZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BURFyzE1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 737DF11400B9;
	Mon,  9 Sep 2024 07:31:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 09 Sep 2024 07:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725881495; x=1725967895; bh=rVUtv7HmHS
	v96N0JP6rAe3C8XMoLvBQ3vihaW04QYUY=; b=bySUbohZI6LTVMc38lYb71naw/
	59KE1B75Os5oS9GVjypPQwLFEsijPorwyXfa6swSfaKiplWlBzae1GwtGwxyRvrq
	ZefDJcoXyDMpCV/Gsrr2z2qAG33rUji4rUBci2pH5q6W+l03jtfRSBwvdqv/Xujp
	5keomqNR36bU2JGgmcsJO6fe+D93c5a76AL4hApv+6a+rbTieXQF5P2etlhx2hfo
	jCape1m23Oap+ju+5SqLd39JtH11uOZ1Kr9KgZFy8jlUHBymry8i9cVKD82qu7Rz
	hStmFY/lHyL8/ODqCt9qGbOtY56m+7CpQwIC/onhHLpHbjFx7WH+M2OzK3FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725881495; x=1725967895; bh=rVUtv7HmHSv96N0JP6rAe3C8XMoL
	vBQ3vihaW04QYUY=; b=BURFyzE1/BT35GnZTuxfiKCtxHlgr42sJJCYsN0b/ZMP
	bOq1EoHg3P1D5mcv2WLU80mNg/ucaeHRdxyfSEP2zTjf20WOzcHo6MsPUpu/8pRW
	VgNYsklIV9yu7JaaX3Q6EuSVt4H3c5fYRnEB9uoTWnkULGjrA1HxX5qB8VmazY2b
	yiR0UBmRgTpheyufahqFMcNfPDTepu6ggCnWjSyIls/Nzm4pvl2XeOjzD1r/vOFC
	6/eTMhD3xgeTVYgHyuYrxAaQJwIp4oFj89tqqnbWaaI9xap6ksxwKg7SD6bhD3DC
	0xjgaTKmv/0MEMbwATOM8aE9kF5wV+PKLmuDp9RvBw==
X-ME-Sender: <xms:l9zeZnqPx1LvDaN1KkommOAC0BVDU_Blpyp6106XAmacW8OOiTfaWg>
    <xme:l9zeZhrPTeI1tseZB7y_fEbvlg0uzjjQn_EaUZr-RC713My3MSt3PChIGp_950-5A
    cSs-ZKZJXlW04cWQg>
X-ME-Received: <xmr:l9zeZkPiirK5qj1VSLY3FNz2AGYuHUOtiiXiilvTnl7kDU4xzVDKZe7aOLkT3fZZD1cOMgP4a2nBr0Xp6SZRxEU9RxuaypH2eGhKix93Xyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:l9zeZq70EcHsvEAwzGNyXHM62TOphUO5-4jyiVZ8Uqw_U80Y1LMZqQ>
    <xmx:l9zeZm5GJQdwIij2TQkqMNkphwZCMSmF_ibp1BDoNfbDHtyO3rtyBw>
    <xmx:l9zeZihtdFpXDO8yo8ln3k-tz-sFlG41xEY0TAvmbgWGeFkVMua78A>
    <xmx:l9zeZo77IeGNt8-e4KUKqeZCZ98I1_NMoMy3-Jhb9ElvbCIcGDDYBA>
    <xmx:l9zeZmFzPU_EosmV6boc4duytDMwdp2na7LPeZkN1SE9SlIWX-ZGngqz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:31:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51b5fc24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:31:31 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:31:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/6] refs: properly apply exclude patterns to namespaced refs
Message-ID: <8d347bc5599e2a679d50fed073e0f09ffdad85c4.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725881266.git.ps@pks.im>

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
this behaviour to iinstead match against the rull reference name.

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
generic layer.

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
2.46.0.519.g2e7b89e038.dirty

