Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B91CF7B2
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695905; cv=none; b=msIkw4M7kLctwDeDBp24+xAtE2M1q0fVh1ajNZsvOtWk6IW8jEh9ZYg/VI0+bl37IcDOOs6dQaUguRMEmCZJVfwq6sv8uAwDEtL7m1nAYzBCBQ/ksH2eguFaVOsX1jd7POZc5xJp/Dhmz0F5QPjltQbNoal/50Y0xBPW/Ez/ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695905; c=relaxed/simple;
	bh=SJJn7zJEIJxi+cBL7LBZz49+l1xbADAbIY7AOp7CAts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JXpakzbc46tnBS7bYY6hw+i6XKVGxVmH3Mwo6AxiZqi5cjJWweiBEO4wehr6AMTkFchAYMhZZNqZIH4Wf0u+1tZXlyuib9e8cpCBPA8KHCAhESVgoueViEWuWE+lUk91PnIInl77nK1HsPs7mjT6Di+LNyhbO4UQcPH6jmkthZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RuPwQ37V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F6ajzKuP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RuPwQ37V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6ajzKuP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DECB114016A;
	Wed, 23 Oct 2024 11:05:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 23 Oct 2024 11:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1729695901; x=1729782301; bh=auvPFnNdHAmfbmLCiWo33fXA3E9Q6Al6
	jw/NO1hcc1o=; b=RuPwQ37V8Th/wfzDaMRnmNoSnA2zAGoubZVsfmEIq68aAegq
	Kt00uQrm+FhpZwKVDITjio7bFbaKoYvR8IPdcoQN+J7SnMfuGkbnZlQyarxuv22S
	6L6TJ0V3KeJqVNYzAj7FbV3ET1XRzyNUVNBEn9kFy2yApQRVHLhYCnFw5sSIad3l
	i92IcErou8U82A3SRoG37UyFnUflzPA6A3++gzwluONR2wz/b5OuGccG+zLXR6xf
	nsdMViNKXGcAgHvQtv28SjOUX2a7S19NgRnqFSf3AOeHQiBjoYqG2Q3t9iP4o/gC
	qBVY+CBP93Pdr2dE1iYI8s+iMyIeeGy+Rv7Tdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1729695901; x=1729782301; bh=auvPFnNdHAmfbmLCiWo33fXA3E9Q6Al6jw/
	NO1hcc1o=; b=F6ajzKuPDG2prnLQ2jrLCPBAU/Ftmrxsko0qZfwdogthPSKOXlj
	//Ew4jzmllkb6qoJv0S+2IwjwfqTECqGXqVXa3uCCOoYti1biWXvx7p9QXYDToZY
	Frx1GmIabcyaEKM1ZtheTx+fk0MmkN1GHfBB6E/qOiGVzqBP0bq6/HDOsqnkTEfT
	eSOxnuiHMSe3H2xqMp/g5TFSUPOFlyP4SG6YtbhPMi1oge+fSAavIXXV3TnqBknz
	Q7ks3gSxSbdMx+iqPXMZHxlt1xm+mngHjtvHSgaCMB/RmJ4WOX59/fh8hBenXNRE
	LNaCdYXxqsfXLraBGR/I2U8uvuI6ee+txUg==
X-ME-Sender: <xms:nRAZZzWIOHtlP5Gb_u5MWqfTyDPakhQ1RgezUP_G8vXC34CNTps6nQ>
    <xme:nRAZZ7m4QxD69g0S4uTD_nwc4XfreN39XMBNX-si5MvY482ejUYVLBdOE82oUCsMG
    3n2pDsHpUbKmCGP-g>
X-ME-Received: <xmr:nRAZZ_Y0uHSdaX-2w233WhkaKI-_c7LXgLvFJprkv-9LUYyret7nfLbUJHZ9N7bYsxUaOQjt5zf_Tztfc58CoNubX0qC--3_tbVgGdMLi3PD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepieeuvdfhteetlefghfehtddvheelhfdtfffhhffgleejfedv
    teefveeltdeuiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nRAZZ-X8rp3AYphvLkNZsDLGjOvLE_PwZBGLZcqbG77ZvGfIFAxLMg>
    <xmx:nRAZZ9kvF1BI5owzqaGz-VM_y3Xsamf96tXR_6IzpaXOf9BTlPprNw>
    <xmx:nRAZZ7fxzrkdwof1IRUQpxgD57CGnStRqCFbHtcleRF3bAvI9uC6cQ>
    <xmx:nRAZZ3HmmAOS-6D5qzuALHQXvUO2gGrCCcE1kZBo6ZRkJT1ldpuvBA>
    <xmx:nRAZZyz_3CcaUSfytvLeYCxnlAlh7PIsAQbn_gr2hSEtqMu4SJILwtvX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 11:05:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 572a5e0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 15:03:25 +0000 (UTC)
Date: Wed, 23 Oct 2024 17:04:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] compat/mingw: implement POSIX-style atomic renames
Message-ID: <cover.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

so after chatting with Johannes recently I decided to have another stab
at the failures we've seen on Windows with the reftable backend. A quick
refresher: reftables use a central "tables.lock" file that gets updated
via renames such that the update itself is atomic. This causes issues on
Windows when there are many concurrent readers/writers because Windows
does not allow you to rename a file over another file that is held open
by another process by default. This issue is surfaced by t0610, where we
spawn a 100 concurrent git-update-ref(1) processes.

This patch series aims to fix the issue on Windows by implementing
POSIX-style atomic renames. The first two patches refactor the code such
that we use `FILE_SHARE_DELETE` to open files, which allows other
processes to delete the file even while we have an open handle. This
sharing mode is also important in the context of renames, which are
treated like a deletion of the replaced file. The third patch then
reimplements renames via `SetFileAttributesByHandle(FileRenameInfoEx)`,
which has a flag `FILE_RENAME_FLAG_POSIX_SEMANTICS`. When set, Windows
allows us to replace files during a rename which still have an open
handle.

There's one catch: this is only supported in Windows 10 and newer. On
one hand this means that we have to provide the required definitions
ourselves, as we cannot bump the Windows SDK version. On the other hand
we also have to support the case where older Windows versions now fail
at runtime due to `FileRenameInfoEx` being unsupported. But overall this
isn't too bad, I'd say. Johannes has also kindly tested the fallback
logic for me on Windows 8.1.

With these changes t0610 now passes on my Windows 10 machine, but this
may also have a positive impact on other parts of Git where we might
have previously failed.

Thanks!

Patrick

Patrick Steinhardt (3):
  compat/mingw: share file handles created via `CreateFileW()`
  compat/mingw: allow deletion of most opened files
  compat/mingw: support POSIX semantics for atomic renames

 compat/mingw.c             | 146 +++++++++++++++++++++++++++++++++++--
 t/t0610-reftable-basics.sh |   8 +-
 2 files changed, 145 insertions(+), 9 deletions(-)
-- 
2.47.0.118.gfd3785337b.dirty

