Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA119A285
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624787; cv=none; b=APxJ/0R4NJv2WJ979pRCy0cWBicP4KuIoqCivjpdxvh4IJ/VS2F4jtDGev880VFh61vrkiupoWXZNeamGTOrEsBGraDcc8lwSGlOq8FBbzDgKiLa/ziax0Mwg9aVP7v0jhwB9JuAF8h0ydsHd6vXfitKy9ZrujKI6Pj3vRbjr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624787; c=relaxed/simple;
	bh=YQH+lqYLyF4IbR4d1QlUUoDWOLIW7BXsyyu+9emWFSs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9tToprDBfyL9+NC68ind7oIUKJMvHbmO29z9cp1jaCBWlUS4YFCB6bv8XAiP7r3DYwI8IyIsZmp+OnaUwMaoPPMyLgI/W2KZpqzXCeRMz4lwpk11FNNqqq3/4eAZ485CogoELAbgxHIOfNmqZautRKFJ3+4r8v9cWBVcWSRmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QVsZCaAE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9QXjhp+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QVsZCaAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9QXjhp+"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEC211140126
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 11 Oct 2024 01:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624784; x=1728711184; bh=76+3ktQFP6
	30sy/tipwq0PurRyayIZv8BeEVytbj9iI=; b=QVsZCaAE4qIh3Zvlo3CumalMSu
	DDoCPKC5VSaKfRk2d0b1cpwDRl62W7SCmJkchEC2vq8H18u0ykJtZkBi7JuhJOTR
	aXDcs+R9FfK1yeAgoFD/uhy3+23d8SybmzFFChKQvOzNHgpJfbsaKMFSnPS4SlJH
	802Jwdcx1GYVW0Uv9jhSfMbMNbGa4LulS/MIad9yETimImAp0xx/rOz8n6u38bTz
	RydIAip4zzE0VrtGLSkLAo4TIUHDScRBKkf1XIa6yLzKWLqUwnoUVYulPMOqyfcT
	pWxvhsxxkphcgPvnAtprZtMtc3oSYFYGnVkqIMPa7Yr3mqhne7hP11ssb+qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624784; x=1728711184; bh=76+3ktQFP630sy/tipwq0PurRyay
	IZv8BeEVytbj9iI=; b=W9QXjhp+oY+Hed9jNjMMf2kl0UIXV8ZkXdmixlStMQZu
	3dE+R2y2CPqW37KnBCUx2u6dlokRt+M6FuZIke8klvn+fCYaNaWEts1lpZ+MlviM
	kDq5BzJePii/BM6ivCnEBljgyEEPxaxJjz5fAaqMeuOV5nrPPdaxfxgxUyRDeMJJ
	BK4wetlJ8nOTPAcSpW/qqZ4omvrWEY4gMI5ixDD1/EfLy0l8YffMoyEGp4eClGGS
	b0CtLyNKPc1438g/h9Hyd+Iwx0IOQPcNn+tLoexfdrX6vqwKqAlLVTlK6ZPCPz+U
	5cU+/A6gb/ZXLZ2TvkQ7Mv5z6IiihMrdzgvhSU3SIA==
X-ME-Sender: <xms:kLgIZ9RFYHAYzyVueftTO0ZlOPi5SZozEudT0exxnjXpKx9P5NjG6Q>
    <xme:kLgIZ2xPINdVbF6miFwtNZ-iRg8-rwZBu3Z979R-OEnSmjAzVib6k592EZk-oV27G
    n_e9nLHgSbgA1Ti4g>
X-ME-Received: <xmr:kLgIZy0xDXepFi7K0diiPJ3DD_Qkht0qoc1bI6him2hi2T4upQiyBIXrX4VlG1Nr_WaXSLwcKk_ZmLAi4MiQGYWP-M7FFGQ3qyG34SlKGsNtBjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kLgIZ1DKKyu7pKeTaGz4zNzmpSuth8iYhqCqT_OUwd1rgtp22_-l8Q>
    <xmx:kLgIZ2jIbNfxSODJS-Gvkx7CNMQCbK8D9s4Ti_MCCJCYlVR6PRiQ9g>
    <xmx:kLgIZ5pgJeZ8AYWLBnws-_Cto0bGczeHywPO6an2OGK4HodmoorXtg>
    <xmx:kLgIZxgPSp9KssOcXKvNqNZfkaLYjKrkKnHEPE6LEujldiM9cpfCww>
    <xmx:kLgIZ6bPM8z8aHaQHlY5VygKcAAochy-hOIVeKvCAo60guTnocQ79xBS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b6bb08b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:57 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/21] t/helper: stop re-initialization of `the_repository`
Message-ID: <8e10ee844c6bcc98f1a848452932408b20244fda.1728624670.git.ps@pks.im>
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

While "common-main.c" already initializes `the_repository` for us, we do
so a second time in the "read-cache" test helper. This causes a memory
leak because the old repository's contents isn't released.

Stop calling `initialize_repository()` to plug this leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-cache.c  | 2 --
 t/t7519-status-fsmonitor.sh | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index d285c656bd3..e277dde8e71 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -11,8 +11,6 @@ int cmd__read_cache(int argc, const char **argv)
 	int i, cnt = 1;
 	const char *name = NULL;
 
-	initialize_repository(the_repository);
-
 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
 		argc--;
 		argv++;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 7ee69ecdd4a..0f88a58a819 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -2,6 +2,7 @@
 
 test_description='git status with file system watcher'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note, after "git reset --hard HEAD" no extensions exist other than 'TREE'
-- 
2.47.0.dirty

