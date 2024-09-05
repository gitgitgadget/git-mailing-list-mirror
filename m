Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978C1990DE
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530938; cv=none; b=IB89jOBzHdHq1lgu80lGxlHzSYxT2p7CQ7wwoYdp1M36Jw42YazCgSBPAGz1F5ymqshdUuVL860xpBC7cIRC5K/45ayV7t2wfioMVRYUjnRjQrE93JBQUbrVcrvCFwtT2rzPZcOt9ZFJuUAEtRzi5SjXwgWJ7jAf3dXWG2pXeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530938; c=relaxed/simple;
	bh=v2tHYyF0OaP+fdZ/dLl4LGxbzQ81uXq7nuBW9BPwT4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3vVgfYIQQnkv3t0GMzAgF7UZchZ12gSO2sYo2ObSFzHpyNuPLqLpOeIzh4YX9BrushOd+Z1651U5wh1fDTixz5Wrqj4CVq7kbhO0o5oFvvSr5DobsFQKZzzNJY2R3iRCB4JKxD81WF04iEYTdr8gmY15lA+1qS63njf6MIGNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K4NZN5mv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSlAV3Qm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K4NZN5mv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSlAV3Qm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F8951380359;
	Thu,  5 Sep 2024 06:08:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Sep 2024 06:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530936; x=1725617336; bh=DpeijigHC/
	ZAMWDNooI+XM4asMss1AH6mfDAaUuuA74=; b=K4NZN5mvZ1kLwT99a8Vnmuag1z
	BmU1Sby9QtuGSImONKiUgB7leStrS1TJrs/wV9wUpxOilx/WWQFxfQPU6Ls7oKbP
	1dyaSGBWy4TmABmDdW+OUH1NiFuJARTMroS2TnFdkd00nui5I1xoBel/6l5cfy7E
	h7dlxiRrWE/z5qyJXA/pDMwuqqYM7NAb8ikUyW/2SQHxx17l7O3EN8JTGrDcJtvz
	0PCAFG5f+ru+Uknw4ORdzkwk6jtrUm4NjO5c0Jsw/g5pKzmqnK0Zvsq3h3fCev5v
	mi+NmhmUy/WK51f4WLN2HkeH+qdHr8LcKB2v7cjM7bTFG86VV+ZZox4lLY4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530936; x=1725617336; bh=DpeijigHC/ZAMWDNooI+XM4asMss
	1AH6mfDAaUuuA74=; b=gSlAV3QmcR/PD5lR2MLVaS9nwhyZdyduGPu1oEPg5q/o
	gZw/H7kBq1O6N+Mef8mrM81NWCKL3/bvkvBATw5EljJR9lvjOK4pUA2Dc52BJmLL
	GejF7OEgy1Div64gfJsBauIGTHvG+82CH6OqG4/Hy76zrD3/Ly0MBuQWlViRWdY+
	FRBk+ZZJA+6TAgyW/4+x0eohI00e4zvFaVVMkbVzyRNWw6twZ3wFB6hfn8YQtKhm
	MxHeSz4fjAcYJ6bSU1wp1L4DPSVpQfG+IBo57Xk9tNCE32Hid0UIaUX9+ukExHX1
	BcPWZdanat9mqwdbPd29nSqkbcuLpZJxOchi25KCwA==
X-ME-Sender: <xms:OIPZZupFSSLK9XkvXqAkr-5dABPphbMegs16-a8_E8JbDn9SKvEfLw>
    <xme:OIPZZsocsRWM3sFlQspNfJmE-IUHwX8YFiZpqq3-YJ6H75IY10vn3dFFMyzbh1vZN
    Z-0wk_dQ5n6du49bg>
X-ME-Received: <xmr:OIPZZjMW3wnhs21ozIOj8WwvZ4m_YSgZOnAgwmfW_TopLxgl8Hi--jydhtHVTkBVZT2qYRmLZT9yvKniosFmEd1bvRrkHJ8L6x-jCVq9t7IrrNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehn
    vgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:OIPZZt6x1ZcJrJ5d2JrwYDt2oASEZp9SQrZc0bb0DASzGg-jyKOqHg>
    <xmx:OIPZZt7ztVyuqibEw6eNYlBbfbZ91J1-qnIWgzWxCTJD7Cnq7reyLg>
    <xmx:OIPZZtjlIMjygcPCRI2AciD-TgEYUkDEfdeAXvsKcQei07lLDvY_7A>
    <xmx:OIPZZn5-P2qRlsDAaFbIjoUt-OwQVtVMlVoeyJC2J2VAvqE2mJQwXw>
    <xmx:OIPZZqv5m2AIK7EjtESQl0QOLAKjtaUYAE_3sNMnH0e0UsG1Brd4UhK0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:08:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8cabc077 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:44 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 06/22] submodule: fix leaking fetch task data
Message-ID: <872f39faece60cba10aeb4606fd3ff28b59ee568.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

The `submodule_parallel_fetch` structure contains various data
structures that we use to set up parallel fetches of submodules. We do
not free some of its data though, causing memory leaks. Plug those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c                 | 2 ++
 t/t5526-fetch-submodules.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/submodule.c b/submodule.c
index 97516b0fec1..97d0d47b561 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1883,6 +1883,8 @@ int fetch_submodules(struct repository *r,
 out:
 	free_submodules_data(&spf.changed_submodule_names);
 	string_list_clear(&spf.seen_submodule_names, 0);
+	strbuf_release(&spf.submodules_with_errors);
+	free(spf.oid_fetch_tasks);
 	return spf.result;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 5e566205ba4..2cfb5bd6bb1 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -6,6 +6,7 @@ test_description='Recursive "git fetch" for submodules'
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
-- 
2.46.0.519.g2e7b89e038.dirty

