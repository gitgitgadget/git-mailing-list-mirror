Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C31465AB
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476610; cv=none; b=KaVONbq0vAANZKaAuAnL5+FY6WIc9t4Y4NNqO/wFcskuqCT5NqXl+X3th68x6AYeCqGWh1eBIxykZ0wwMsBkQLZL/Ulsq9zAp6VCbw4FbSS64E7Y19UqcFHYu1PbdM2KVjtzijWmi5oghB+Sv+XO+XYwvDl60oZTgVMnP0HiM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476610; c=relaxed/simple;
	bh=2k8tKV6JcxbrciAZu3c9IvG7hqXAI3TJVmM38NRtGGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muMvK9EZQMRzQd3f46Etk5ln2E42XTqAcNet4ruqd2K6QV2gGIvSFVjeAzDCN1vj8TQ1T+dsOeveIbwSsZp2osPCRo6U+cz+OEialYvyIeSNEhgvBAP/W2BfZyQ9E92N3aroKDB4zXQxMsixuK7zBNSuSJQdCYXtjQmQkiONV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sxEp3n8+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhzrX3cX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sxEp3n8+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhzrX3cX"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6B2C1140230;
	Mon, 16 Sep 2024 04:50:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 04:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726476607; x=1726563007; bh=cEnGlSHqBf
	qrDUZ/GGN045m+GI9fkh88X/AnxhEe/20=; b=sxEp3n8+60yCzyzUJ3/HvXCHAD
	8hOqtrbUurideHIo4kuxSCt4q+eXw25txqSQPZPZGJnhOfJXicVO7oczFvTeVgIH
	o0THpOjxcHXiHPbxC51WEy230Pjm7o8ufPVL/6POQKiogc4Pl9H9sy5S13IMWj5h
	mFtcB1/ASCjAUV8zU84mtmIDQIC/CHSlV/uBrSZV/n4Q+/RYX3H3xdQFtRxDt8CG
	pUDwgjU2imDx/X4IatYP3y7acxc0as+rWHQETrYHboibiGM9nznJQk8ogXyllssM
	tzmkLEyuppu8ZvvuoJz6Ga29V3aB00YYOjC5m9aYno7DrNrXc3wTCxK7NPhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726476607; x=1726563007; bh=cEnGlSHqBfqrDUZ/GGN045m+GI9f
	kh88X/AnxhEe/20=; b=bhzrX3cXEw2HjV0Z5yfMzm2b+G8rdAIDQtZOEHwHp9aX
	jhHXyJvVedgGKZ4dGi9W4kTRFmgl4S7B+p31FbTv1XgkHC1iMBbNhi//aZP3FE/X
	KJyY/J293amAUiHoBVG0NZQyB6OBNz4AhYU1Qf5UmVB3Ej3/OPOBpx9CKPpsCTJf
	Cw7CFMSjR7NUsZWfc73evy4cgrTPhtIYdPRgloNtQKJ5Gf5W64J5xwlkhazAKWNm
	pMSELfJh5wMMQLsecMAJhEuv8pJhXzZQ8UVZCQYtimCdUgB2e/+RbVBYPq+6RKrj
	pPtCLtfNmQVTB810V872ROTwBjFP8ewSyoN/1DlFzA==
X-ME-Sender: <xms:P_HnZr9DXHyXBmixvuh7xTd9f5MutfT11ahorkbpEJdFAJCo8TtJPQ>
    <xme:P_HnZnuOMDZJ1QrxFvuh9K8BE5Ols9RBd13Zh6KvsBaWJXLbUpmT8SrmqC9KoRLUN
    Vrbp7kGrqu-21_kXQ>
X-ME-Received: <xmr:P_HnZpCEc63H6ksm4ldpDVklfKGAYwH3G8RjhcChXrE_E9IAlurxaUNDxIMuRkhWhiMc9dL58m0RwJoZa0aitzzaPKDPig79BIiuj2esdt2t0Ezv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:P_HnZnc97PwCBRVh-CEsPzkdw5AyY_svMIKleXY_K5HJLFvX6oRE9Q>
    <xmx:P_HnZgPaxge0N7Eemv_fJrhhBjMPbdY_epQPVyJm4pMcXYUjUmDjqw>
    <xmx:P_HnZpkhNA2SHxeel7HZ4ZpvMblakaVvW_GgthW3nRsFfLhkbSVXkg>
    <xmx:P_HnZqtVC49VLbrDY1tWGvsZwLbRlrUk8da03RsezfHjF5g2OfmXWA>
    <xmx:P_HnZlrBW9y1EIUA5cQwJD_4okSrO61bK3G0-_XFnMx9-hXbuta8XVoI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 04:50:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2d8478d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 08:49:50 +0000 (UTC)
Date: Mon, 16 Sep 2024 10:50:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/6] builtin/receive-pack: fix exclude patterns when
 announcing refs
Message-ID: <3dc6ae936c88d3105bc82daab3edd805c9b5c63b.1726476401.git.ps@pks.im>
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

In `write_head_info()` we announce references to the remote client. We
need to honor "transfer.hideRefs" here so that we do not announce any
references that the client shouldn't be able to learn about. This is
done via two separate mechanisms:

  - We hand over exclude patterns to the reference backend. We can only
    honor "plain" exclude patterns here that do not have prefixes with
    special meaning such as "^" or "!". Filtering down the references is
    handled by `hidden_refs_to_excludes()`.

  - In `show_ref_cb()` we perform a second check against hidden refs.
    For one this is done such that we can handle those special prefixes.
    And second, handling exclude patterns in ref backends is optional,
    so we also have to handle "normal" patterns.

The special-meaning "^" prefix alters whether a hidden ref applies to
the namespace-stripped reference name or the full name. So while we
would usually call `refs_for_each_namespaced_ref()` to only get those
references in the current namespace, we can't because we'd get the
already-rewritten reference names. Instead, we are forced to use
`refs_for_each_fullref_in()` and then manually strip away the namespace
prefix such that we have access to both names.

But this also means that we do not get namespace handling for exclude
patterns, which `refs_for_each_namespaced_ref()` brings for free. This
results in a bug because we potentially end up hiding away references
based on their namespaced name and not on the stripped name as we really
should be doing.

Fix this by manually rewriting the exclude patterns to their namespaced
variants.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c           | 18 ++++++++++++++++--
 t/t5509-fetch-push-namespaces.sh |  8 ++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3f35140e489..478c62ca836 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -339,12 +339,26 @@ static void show_one_alternate_ref(const struct object_id *oid,
 static void write_head_info(void)
 {
 	static struct oidset seen = OIDSET_INIT;
+	struct strvec excludes_vector = STRVEC_INIT;
+	const char **exclude_patterns;
+
+	/*
+	 * We need access to the reference names both with and without their
+	 * namespace and thus cannot use `refs_for_each_namespaced_ref()`. We
+	 * thus have to adapt exclude patterns to carry the namespace prefix
+	 * ourselves.
+	 */
+	exclude_patterns = get_namespaced_exclude_patterns(
+		hidden_refs_to_excludes(&hidden_refs),
+		get_git_namespace(), &excludes_vector);
 
 	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
-				 hidden_refs_to_excludes(&hidden_refs),
-				 show_ref_cb, &seen);
+				 exclude_patterns, show_ref_cb, &seen);
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
+
 	oidset_clear(&seen);
+	strvec_clear(&excludes_vector);
+
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_oid());
 
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 98e8352b6cc..f029ae0d286 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -124,6 +124,14 @@ test_expect_success 'try to update a ref that is not hidden' '
 	git -C original push pushee-namespaced main
 '
 
+test_expect_success 'git-receive-pack(1) with transfer.hideRefs does not match unstripped refs during advertisement' '
+	git -C pushee update-ref refs/namespaces/namespace/refs/heads/foo/1 refs/namespaces/namespace/refs/heads/main &&
+	git -C pushee pack-refs --all &&
+	test_config -C pushee transfer.hideRefs refs/namespaces/namespace/refs/heads/foo &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C original push pushee-namespaced main &&
+	test_grep refs/heads/foo/1 trace
+'
+
 test_expect_success 'try to update a hidden full ref' '
 	test_config -C pushee transfer.hideRefs "^refs/namespaces/namespace/refs/heads/main" &&
 	test_must_fail git -C original push pushee-namespaced main
-- 
2.46.0.551.gc5ee8f2d1c.dirty

