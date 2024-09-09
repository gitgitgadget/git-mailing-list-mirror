Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0521AF4F0
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881500; cv=none; b=UresFMiDcSAys4nFNY9AeAdAh6aK0mAnB9fmKbrjfBNd5Jrf4Bhl//1UErSZJfA8sVdwxQyTcihLj2gDZW4S0V121nKJlcniQm0eJjEbMQr8R32fmkn6XFqc0Q9uRURgcwef9NCIOn6fhKdNrjJ2zfrayXZ31bTIJjxQgLXWhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881500; c=relaxed/simple;
	bh=BaTY/OTN72ADIQwHJACLHlcM4oEniZSOBlm6vxWg1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH3Eow4VtPbdPchpljS+dVU4OmXFhLyqyMswd/7sEqk6DJo0LRWFW0ulvQc8azIAMQIpEhZtdh+tUf3YzL/cjq5E/0G8B+vt2+0JcemNHZfdd+RsrZomzMtzmqK2Dgp5iGoB/7l7rYXqSF0uY4avoUKh7x/QCHuRPtCo3OeM+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=skKsnqTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FoMjXECK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="skKsnqTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FoMjXECK"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 7676B138016B;
	Mon,  9 Sep 2024 07:31:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 09 Sep 2024 07:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725881497; x=1725967897; bh=qmXvOgnQAj
	IwVrM3rF/ee0ommHR2mZthHSmbNvKH46c=; b=skKsnqTEYT8zbocsq7TZF7wTZH
	XD5CuHI7y6w5BNlzBZik8kiWPuPooj/wzzfgL0Cj7INsoRZFKzgAJ7irXam/r/jO
	bbrqU2eSnJGYHlNF5E73UQmcouLwi+Rrdj1ZrSq5aGh8tmZRYofpthPaAymzrtkF
	1gEAOIjOSMBKPil6d50bmfyPJjuxW/P4ZYIwDVA087WLUsxC8wXyI5jIVi8EsCPD
	2JwfOXFJDYJyMaPy4Vp8AVJuihTVuVNTflGTi/8uZyRlJuAmgioUc2wLwlRK1ZRO
	XTjyxjNSwKfnzLBzi3ZBlWgziRcKoXz1CSJu1tqBshU79pkpSOIsMLxSPY5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725881497; x=1725967897; bh=qmXvOgnQAjIwVrM3rF/ee0ommHR2
	mZthHSmbNvKH46c=; b=FoMjXECKM99+1fXbtFNcDD+yGZ8EWszN4Oo6lLhDFocD
	AtRU+ZcY2hwE4O7RhAlt8EVsRC3TEXTxa0ULHPnVOaAAqo80c/tIkyi7Zzgk+hib
	YbSqIBgms6ALg0/ECO9aIsVr4dBN2M9skALHJnncDsW540SZwifY63JCy+TwACPN
	hh9wuPugWV+VRv8vYpmnnbXAigRks7594hy+/kkj7gKs1WBeMSSSvED0wW6k3D4h
	uxRsnKACsNf5ZA3SBunjIMNWTCKjGLPNFZvXRuTtw3BY9NyfsFgVjy9/3/0WzGGR
	bp5Oqeu2PGBjiexOIqsrt92hJGi1uEBjSPQ8W4jeRw==
X-ME-Sender: <xms:mdzeZrFuRWaTVJsVQrwYX2aL7A5c0KbDYk4123lbEff5UalUeutt3w>
    <xme:mdzeZoVDJb4XMBDCeX76I9cWidzjYT3ylI9UxM2EzClWjP8sFScggxXf0xN_2IpuE
    _PJI4YQS3_SmQk72w>
X-ME-Received: <xmr:mdzeZtKVg_yv3eli6rvSFRM_67f85Y2HUB4w1NauwU_wdyUGXnm3Zo8al4dxTkuqml51PgmUo-PU91R78XUFJVMdnhWUkw79q9Q6FT22Bgw>
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
X-ME-Proxy: <xmx:mdzeZpHiHDsE9-PMzUR_eCu5vidTeVXOM2mbYBG8USz9cK2rMFo9VA>
    <xmx:mdzeZhWCyvbo7P2Hj9Hbi4FfETUdjo1a1RK002BDs96X0injM-LM8g>
    <xmx:mdzeZkPdWqeYTBcn2gCQ7boRER2Msr7aua_XutJc8Qyg7dBQlmC9Jg>
    <xmx:mdzeZg3522p4WZcVop1OMugoKRIO_aGbeOXXLSzef9Hg_bQw0KI5rQ>
    <xmx:mdzeZujcuSuw_XcNC4AK5QH-IuTeXeG3ADg1pJ9jx9GiXshrL_HtS56i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:31:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 484de5ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:31:34 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:31:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/6] builtin/receive-pack: fix exclude patterns when
 announcing refs
Message-ID: <0317a5a7edeab29b7cad31d11140bd99f459144f.1725881266.git.ps@pks.im>
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
2.46.0.519.g2e7b89e038.dirty

