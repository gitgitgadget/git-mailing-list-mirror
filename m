Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755A1FA247
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624752; cv=none; b=WDgYbJoEPJ8UhV6rC45+nB7mU8aZAyhL16CvKGUcW33BU+Ol/Se7lsV5x8/7fT/4PBJzXp17ihDLq31EKYJe8z2IlCE0f4kMU4ff5bZ/qGx7aAuMupU27wNcqaIuXh3ChGuzy6xM6AwF9RIzYWD0Y77RGPH635CpxOGEUJBbv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624752; c=relaxed/simple;
	bh=mdiN6ue/eOZdFWkdYu8EOE/ga50DanGvi8gNXSeh5QU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoUW8vbtpbntV3LPTGFA55WACMelXp8FiM+oSNLRi62YLqrA6PDgxp2knHrmJ6IS0TYQ0Y3D7yM4kPfotu8eOEa4cm5z/VhM1Yitj8/PrpLap8gC9VViK78cWE1FMp8KBgxItYA6Jdj4q/C0N3ggOXrfCcCAdHzz6WG0JzgZn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m6D4WKGB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JpYE9Iup; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m6D4WKGB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JpYE9Iup"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 73D1B1380158
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 11 Oct 2024 01:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624749; x=1728711149; bh=sJ4deOtsyp
	fqcT64kwHJU5mmp+as5epFSpTG2Rq+xU4=; b=m6D4WKGBxuwKbnG/9HJez0cbiX
	1gwZSKFAR1H7WP6MI1Ttg/gm9Ha4FOOAJZ89TrRGf8rnlMdr7vBlN3JeGwkKCYe7
	xGvUbTgede3A010WBCgMa3MzmB6w1kTdZ4Y9qVy+cJ9pYIy1iGqwBPDPbvHjm1Ma
	Z3nWRiYaa/jd2Y2Cq0oQY0bfVxmZmLAszAfZUOnw4FqpHEJVC2/pRyDHihuMwF5c
	mh/gQyMobAMQzXSvicKk8hyEPcLMtvdp8rjBiwAMbvrt6VuZS2STYHIqaKCTCgyt
	quOTcDlkIh/+DwrZLMmsFRVIe0e0x8Eenoi1MR0PPN9RJsX/1AiW6R/1nXxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624749; x=1728711149; bh=sJ4deOtsypfqcT64kwHJU5mmp+as
	5epFSpTG2Rq+xU4=; b=JpYE9IupoMYvwlFnIpGYrsx+w3nX3WUb1BXJuKPmWhsi
	AEHnOjN8UL2dSYgKvsw4LEAiKTxTUH2fCX1lA+9JNLmOSygDCGBaB72kxvBeHwKw
	niMXjbIUHp1G6RSmjkNpXATaCxWOtP457YHshBUk587GfehCM9KNYh9x9zmi4dEl
	nhkjpZ+a6oRAnX3QO1CO+ilN85e1uMEEz9kiYThxBcWH1mo1JjGLr6FQ/Nr0fpZU
	UQr5PA1zD2KXaB4UwSfuqPAtC5Hl0q4enWRcSJ9GGIrokYJ3R8cGsKO8SjKdeqxu
	pF0pDHd7KQHSTKeQnABQV0ebaOA7MakX1MIgQ795rQ==
X-ME-Sender: <xms:bbgIZ5gY-lCtwLAW6CNAy5OcwolYWhfwWcNgaUG7kIY-ijGzBPYATg>
    <xme:bbgIZ-Akq_CRrVnqYYTHDkrS8f0jBrQdluvhm0sBOHka4rSXwmP7g5ypDZCBW-hEG
    JvedX2ACqhLCMc4xw>
X-ME-Received: <xmr:bbgIZ5FL4HGqyMpZnUj-g0xuqazMvE1hgCcYQGdy_E-iUmkDDsju7pn3muFeEBZJyI68tOkMKznJLXnQPoFLmWCFag1KiWau-Rf1yly-pc_qY20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepieeljeehtdeiie
    ekhfevkeeviedtvdehhedtudeigfegtdejhffhfedukeeujeehnecuffhomhgrihhnpegu
    ihhffhhophhtrdhnohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bbgIZ-Te86zIKscxNXzi_H2FCk5CSsb0BbHUH52zFXz6TwRxEN0S4A>
    <xmx:bbgIZ2yDiiwlrqmiNVdG18jFSBoAQWgNXOWZbc8dMOqeyZIH_RP5pg>
    <xmx:bbgIZ06Zg7nWRwjYt_ibIh_9rwncZ7yLWvY5ahZpfcy0dOchYnddfQ>
    <xmx:bbgIZ7zrSaNf8AB33L2PFHSqfcKrbOH2bujZZXJeqMSdv0CdlSAWhg>
    <xmx:bbgIZ7piKrGGkVuIuWw_70eANhMVOs5Q200FxxvIlmepKfl1k6iOVQvs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b4235a7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:22 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/21] diff-lib: fix leaking diffopts in `do_diff_cache()`
Message-ID: <60af98cb2c7752edc7cd5c5fe8173dc5b2522a7b.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

In `do_diff_cache()` we initialize a new `rev_info` and then overwrite
its `diffopt` with a user-provided set of options. This can leak memory
because `repo_init_revisions()` may end up allocating memory for the
`diffopt` itself depending on the configuration. And as that field is
overwritten we won't ever free that.

Plug the memory leak by releasing the diffopts before we overwrite them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff-lib.c           | 1 +
 t/t7610-mergetool.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 6b14b959629..3cf353946f5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -661,6 +661,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 
 	repo_init_revisions(opt->repo, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
+	diff_free(&revs.diffopt);
 	revs.diffopt = *opt;
 	revs.diffopt.no_free = 1;
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 22b3a85b3e9..5c5e79e9905 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -10,6 +10,7 @@ Testing basic merge tool invocation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # All the mergetool test work by checking out a temporary branch based
-- 
2.47.0.dirty

