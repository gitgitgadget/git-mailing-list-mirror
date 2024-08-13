Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7C3BB47
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540700; cv=none; b=Rs4y2jFY7Y/VTSkbfqB9BNT3e9TQqsAuW0gXb+WIAa+kvYvb1a4EmawEam8Sb0Qvg++VlVVVdt5LHda/u1cGdp/YaMfsi+ptkxdsjDeyvKOpgGHTDex9IKTecTPNJE+l979Vm/qTGVqBnpLDUlMSCEMyaZ7JUcpHHGuf34eK3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540700; c=relaxed/simple;
	bh=R8JvX71D4ABtRR4ZdwiGRt7d8rb1UdBq7g6/U58A2DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf1rwf98homR/8bY73/bAse62NrltLmPub8Kk/c47AXnsATFSG8SWzKmovHSvsGmIwFv83ZUDGdY7D9TSfFpjsxoyTaoLdPkdPvM5TBpciObfl2V30qFWyh4X2dO1c2DpTswT/4Zojd/7OtEtgvgScMFsFxDP4vjkRdIkeChshQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O2ZjZaTZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f58k8j8E; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O2ZjZaTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f58k8j8E"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6A6731151A8C;
	Tue, 13 Aug 2024 05:18:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 05:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540698; x=1723627098; bh=j3CiZlqMNE
	0hLVPUvMD+54d6o0PLFG641z0U7vtLD1c=; b=O2ZjZaTZ3ye1FVN3jDBIt4pf+A
	VteG3QCPhf/s5S3qnA4YGzpRH8+NLG4vLKz4Nl2+4YZhPH00DwzeWPHhfN6BHVhr
	rIjKUB/ac6KBDV54Le6X8M+EwVhIzNpd2NH5qT15QxZ45XEfIftcrNbkgNwWdoCy
	aVKP6O1JCNHF7JtHLFr6EjpxiqWftFz+RyGMLwoahal+2UDJuaa3QXRK5XtEhx4M
	Ojxl+WBWSO54gBA8ShPedGL5sH4y/yc9LcjJDpS0wTG57+xTSshQ9HiKiONlUgGg
	/RpwAJlBcN4PNabWqRnrlh+1Oe5hbhX+gH/N3YbS6mY8/QPwggk3lCDDle1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540698; x=1723627098; bh=j3CiZlqMNE0hLVPUvMD+54d6o0PL
	FG641z0U7vtLD1c=; b=f58k8j8E6dWFIgWAH9I6BdIZdgWrDloPQbJ9cxOnH3p0
	s4w3zSdLlGqSOUY63XfcLSaQ4yGuuXSpK1BU9cvtzyFkq+BIaXPBWxSyWD3FNxxR
	rqoH+SU95tXU1XNUTruhy0/rXGAqjEm21jw1h8QiLIa+wReCZXDZ1gst1qAm3lV8
	UsCW2nVbh4g3T50Jh8cvKHqC1v3iQOd4RX7idW9G18Ir/Kukpc9hBABtOxu09YK1
	v7+YoEf0V2hv6EXaqMqE+gPw6dFyA2UXvxEzYFetjYca59sWYFKSEbgS5BRTM9Jg
	jg8ECkwmynGUkM3oPF2PIaO8bwiozJcGLIkbPmFVuA==
X-ME-Sender: <xms:2iS7ZhkBgxilYOgycl2XHCOXWr_UWrLWen2czoGn3wO0F4I1ECn-Tg>
    <xme:2iS7Zs0Jxhu6PAet5c5XBSngwveSP8h8UvrwwRkDokItyGCZkltCjp3iTX_SSqBAX
    KkRlOS34EnRTm3t1A>
X-ME-Received: <xmr:2iS7ZnqyfIY61Rfx0q2_S33g1NeEH6bmwditOmfcBoiFHbMh4s1Mxl-zjZWsHsWtQfVpjtrQsuaOy_iXuGMSFkemP6i3B3R3QZnEHE1cQofe2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprg
    hrtghtihgtlhgrmhhphihrihgusehouhhtlhhoohhkrdgtohhm
X-ME-Proxy: <xmx:2iS7ZhkGzeSJdgWR-8WEgInORs7yzfZeP7tJKE-FI1JTmCVbBRhmZQ>
    <xmx:2iS7Zv3SFSiQ-gYO4cgb4z5mGmbVZ_mzqE5NgWmOtYpXuavKtqBMsA>
    <xmx:2iS7ZgvA_BQk_MhS69gQcyMdQC2b8k_W2AgFtwvC92z9mQv5DeAvYA>
    <xmx:2iS7ZjU46QqKgXtLrgknzMfcebIz10-NwKcEUXSxDUKepeJKUMezvA>
    <xmx:2iS7Zv_rQSccKBxZJDvFB_Y_I2oBxOQYRRpWCfV0PpaNJAB3qBG1wNmX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:18:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5cc30123 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:18:00 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:18:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: ArcticLampyrid <ArcticLampyrid@outlook.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] bundle: default to SHA1 when reading bundle headers
Message-ID: <7e15c3daf95283f62030fe7b5dd0bbf8e467881a.1723540604.git.ps@pks.im>
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
 <cover.1723540604.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540604.git.ps@pks.im>

We hit a segfault when trying to open a bundle via `git bundle
list-heads` when running outside of a repository. This is caused by
c8aed5e8da (repository: stop setting SHA1 as the default object hash,
2024-05-07), which stopped setting the default object hash so that
`the_hash_algo` is a `NULL` pointer when running outside of any repo.

This is only a symptom of a deeper issue though. Bundles default to the
SHA1 object format unless they advertise an "@object-format=" header.
Consequently, it has been wrong in the first place to use the object
format used by the current repository when parsing bundles. The
consequence is that trying to open a bundle that uses a different object
hash than the current repository will fail:

    $ git bundle list-heads sha1.bundle
    error: unrecognized header: ee4b540943284700a32591ad09f7e15bdeb2a10c HEAD (45)

Fix the bug by defaulting to the SHA1 object hash. We already handle the
"@object-format=" header as expected, so we don't need to adapt this
part.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bundle.c               |  7 ++++++-
 t/t6020-bundle-misc.sh | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index ce164c37bc..b0a8a925cb 100644
--- a/bundle.c
+++ b/bundle.c
@@ -89,7 +89,12 @@ int read_bundle_header_fd(int fd, struct bundle_header *header,
 		goto abort;
 	}
 
-	header->hash_algo = the_hash_algo;
+	/*
+	 * The default hash format for bundles is SHA1, unless told otherwise
+	 * by an "object-format=" capability, which is being handled in
+	 * `parse_capability()`.
+	 */
+	header->hash_algo = &hash_algos[GIT_HASH_SHA1];
 
 	/* The bundle header ends with an empty line */
 	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 703434b472..34b5cd62c2 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -659,4 +659,29 @@ test_expect_success 'unbundle outside of a repository' '
 	test_cmp expect err
 '
 
+test_expect_success 'list-heads outside of a repository' '
+	git bundle create some.bundle HEAD &&
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) HEAD
+	EOF
+	nongit git bundle list-heads "$(pwd)/some.bundle" >actual &&
+	test_cmp expect actual
+'
+
+for hash in sha1 sha256
+do
+	test_expect_success "list-heads with bundle using $hash" '
+		test_when_finished "rm -rf hash" &&
+		git init --object-format=$hash hash &&
+		test_commit -C hash initial &&
+		git -C hash bundle create hash.bundle HEAD &&
+
+		cat >expect <<-EOF &&
+		$(git -C hash rev-parse HEAD) HEAD
+		EOF
+		git bundle list-heads hash/hash.bundle >actual &&
+		test_cmp expect actual
+	'
+done
+
 test_done
-- 
2.46.0.46.g406f326d27.dirty

