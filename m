Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E91F9AA7
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624775; cv=none; b=qtRN8jO+K+5V5ZuuWL0aC9PvKXv0cpnG4s8+V/Va6p8BPK9jY/NCj7wMnqJpRukYUkabSwsBZ5n3kGEf9/Kzt9KoeQWEbUkO+xzV+oiB7TIt2g3XMTea598FbC6buNbUs9pQKcZnhidYFL2Dly4/aikwKVmBQiAF875RoaTsXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624775; c=relaxed/simple;
	bh=8m04HFlqdCTdA6Ohgz4zVvskbeSsPm0QI5Xq+CN3D0I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR61+3VeH4/gTLxPlDKRW1sh0E5iiIiRLCqlpLhJkg+aZIrBQnysEOjxxGEd7VKLLpWL1Ue5c7/vBpMOeY8oqmLXjNtYkk84Em3NxfkkaZuya00atr7PyVt9iVtKHNhHfvoRmd6fSCAxiCa+CWAiYd4dRFXTHA4Ochb/9EKDcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UL8bTDzb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNwY0ehU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UL8bTDzb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNwY0ehU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F0D31140135
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 01:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624773; x=1728711173; bh=bAFKi7QxuD
	Ddn5Ffp9cMNlApG+6az0YdD1+EC6TZ5pM=; b=UL8bTDzbNx2Q+e93+geikFYFwg
	Yem1RNA15/dZkGCEaYniYtckAwu3SrJ2T0tyrsEj3BuSSyU5VCw9pHtigMtUu3TE
	/d/sj/AVZCRlKgPDOlSQDwPxdI9vlU14Qy6OjgAjpGoaY0JRalS5zm4RQ3SSFSVe
	vbAkShZdYPeKZ2OIbOciXWA6ZVmfroZUehneVQLmcmnaUk3F+1kG7ctDkkFBmqGP
	FmeKdsZTnYr5NpalzHawfjYdP4FPWaSS7/uQ/588qPeh+wcfozdSEFtwXVahIcU4
	hv9hepTOXe3DKooTkChxTzyPypzZQtpK/dz5L/BbCF+nUTlUN6OR2j7ZKFfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624773; x=1728711173; bh=bAFKi7QxuDDdn5Ffp9cMNlApG+6a
	z0YdD1+EC6TZ5pM=; b=jNwY0ehUCpBtS+LJg26Jf1YWEFtl1JAQpNuMafg2cRqf
	sg5L/iWSJZbQo9neGmRtLMJWuo3QdvqU4x4UdCIP4zD1IpW4CY1Wyb7JFMA9TJdG
	ZM2OObTonTjF6f11eIE7zKletzukkEn0ZXDJ8fzETWyaB561utUSByuwlTwfkNC3
	jYqc5wrJkcuT6ufgVwOYWDYV5GR4X6VgDZWxt1AUeVMTIsAS+T1KGRtaVTQcX6lV
	2KZhWzU9sfesX71x3jdsSXekMe+yHFVp3SbDw0j4gk82M6ViKIv6ShwG8rOh7hOv
	3//oTXGg0VxAIEmnmoJTY3LXXCN14h6+ExxSoDEycA==
X-ME-Sender: <xms:hbgIZ56ll5fc6rR3NX_YDhmY4OBff6UrC7YZXPgj5__g-4cgB9fWdA>
    <xme:hbgIZ26U-8PGKqaDcOrCIsOljOeqdgrV3kPztGmNcIt1S9fr3renBj5LJTRdAQ_C1
    lQjNINHzJBPlwzNvw>
X-ME-Received: <xmr:hbgIZwdfQarMaUXzb0s5r8GcakQQPen3GvzD85rzt_997GmIHZtTaRms6XZ5OeWVtdTRGehN7RvJciYYl9c0WBZseywngmuLVG-wCL_ZwsffcFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hbgIZyIsjSpm2Hzlh2kfFFwERo0N4E3Li6mBzZJi_NcFOSL7BprVug>
    <xmx:hbgIZ9IaXluMRKPYUuBnjjC7iu9WekS_0bF9BOEqk-9Q3_TeUn9jAg>
    <xmx:hbgIZ7yzqMkbH7nNsMP-pAsgiHeUsDRKnHFOSDuK8MJsF7ZztnugnQ>
    <xmx:hbgIZ5IAPZrL4yZntGFAl_Nv_JBnY9gn3g2TeTDCTBp_rB7_luP_yw>
    <xmx:hbgIZ7jZ3MSLU0qowt_GcFzJbXdBQvorJjPt-OmVz2IyGJyIDjXFEGDX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e4f1467 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:46 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/21] combine-diff: fix leaking lost lines
Message-ID: <8d305d9b1c8b234f0a029d5db462a0f3bf5b7d12.1728624670.git.ps@pks.im>
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

The `cnt` variable tracks the number of lines in a patch diff. It can
happen though that there are no newlines, in which case we'd still end
up allocating our array of `sline`s. In fact, we always allocate it with
`cnt + 2` entries. But when we loop through the array to clear it at the
end of this function we only loop until `lno < cnt`, and thus we may not
end up releasing whatever the two extra `sline`s contain.

Plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 combine-diff.c           | 2 +-
 t/t4038-diff-combined.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index f6b624dc288..3c6d9507fec 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1220,7 +1220,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	}
 	free(result);
 
-	for (lno = 0; lno < cnt; lno++) {
+	for (lno = 0; lno < cnt + 2; lno++) {
 		if (sline[lno].lost) {
 			struct lline *ll = sline[lno].lost;
 			while (ll) {
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 2ce26e585c9..00190802d83 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -5,6 +5,7 @@ test_description='combined diff'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
-- 
2.47.0.dirty

