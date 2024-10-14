Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95B1A4F04
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908486; cv=none; b=Qa3ay35MVH2hwJ/GNm+T0cBl0Y3urB7c0fNc3X1/Apa3aQ/t+IDBO255P3ljEIGn4q0FQvsDGqVRHySkz8QyafQGYgZk2QY6T58DHvGCigOvjBGSdTPGOqHd1w0b1PyftBX2BLjLll8YEjkWIXXpMuv8vKb8f5Jk7Cp1e93PM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908486; c=relaxed/simple;
	bh=OVeKR2gKotxaTVfUDznfksjbL1OH385CTjK0c8fBtjU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTMjjZRryBB5/zypm72QAh8LGavOnL/IMqSyMaCk1IiyfwPQ++RpX/odmgzRsaX/3eIKKZba6Eka7n2wCsHXnVBkF5acAtFmy/jPniBPFWEytSPAMI4pZXIuTak8v/IcrL9zerw97TuyRRt0dMliQ04y6nycxrizT8ydJgkz8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ogQeLt4/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGNeyf+S; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ogQeLt4/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGNeyf+S"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A630711401ED
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 14 Oct 2024 08:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908483; x=1728994883; bh=fDY6ebe/3R
	mX5qqZk8gsyQSz4XZDyjR59e0bMG1cbxo=; b=ogQeLt4/oivcFjbienAYPMb5HT
	UMyr4Nam2f/xOULJGsPfCeo/an2IYSM0F0vAL1bvKqE2EmdetsubwrcJeUxQv6VZ
	r6iB77TY/eWMzW7EkbcmKeKUJVSrR1i3Mf7PY0aGVyhVhVRMj9rW6Hy2/2JXb1JU
	Dfbg4QmN3dlyomZMKoceqNIe7oAy68v5JKrtK8u+0jB3SyUBB6VJcftrh1BzhHje
	sI5Kix//OyIOmeTYgwYmEmhy2SxZAxNThM2sV+kxjhADVDX7v31bklwTGachI4W+
	ts0whr9a8ScWkIpY3AxmKUsboTTNkPMPk2XaFA6avBjqEbiwQxKQy8Wxw5lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908483; x=1728994883; bh=fDY6ebe/3RmX5qqZk8gsyQSz4XZD
	yjR59e0bMG1cbxo=; b=CGNeyf+SDryGxb+ky1eiDbx6MdiiCTHejMvMT0Gdyf+f
	NehaaE6gC98ofZO//Mo2NiJwNVpSaRbr4Ai5aiOnOhDlfiYFXIKZJBc7lJkpNTkd
	GJmHRu+YnAOcpaJUbqi917cI67iq8GURuqyaMchuZV8C97JRmfMf3hIbtA5bi5nw
	lAfeiWuwfUA2m8qfeWgUFA7vLrrCiqaN/xvaeXM4e+04GBAoicpWY6v70NuzavBW
	BCOkmz28dlDoTRjNju1iP72QrDE0hyDwouElMblmF08vcZig/R5DH493UKtJYnk2
	7uJeLI1zS+lkP0qljc4HHzvBNdj4Z0tB4QczoAZr5A==
X-ME-Sender: <xms:wwwNZ-MNffAAnUMoOl-GUELYD_smPlTO4GzI6YjSYE5kspbIUwfB1w>
    <xme:wwwNZ8_38q4UQjNs_0GtuTWVzBDr_QyN9_7jNn5-85mySYeLhVlz77vn0NhV-jJbG
    ZQq15aCtrpKU6UquA>
X-ME-Received: <xmr:wwwNZ1TVS7SuMmTGPlNUtBSfS-RqdKcBFCGzaEq5H8km0pM4qkSQs8e0J1Hz2aTcXRMlqZgbVhkABO0UzCl2Xh2LZF2c3dMRhXd5haLaY7_hjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wwwNZ-u4Rqxpx2nybKhlUQ5L31GwOVE4svII2T9xbRWXCSk3rwpKLA>
    <xmx:wwwNZ2eiJ2NGgUQqqIVke3U7YZCq3bPj5TVQwpEP7KBAy4MVSMCJfg>
    <xmx:wwwNZy1Mo10hWrvrMswMArLFPcqHi1tAEGF7U-DNwBFbJ2qyXY3Oqg>
    <xmx:wwwNZ69uEUcxSBvmS33uGYuyvl4Gtj8DytxxWcNRsnojTz8S7nuimg>
    <xmx:wwwNZ6HWRewHAhOWb-Dv3nPPhWUj60Nn2kUYLSeJZVIh93T-1G8RCdPX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff503fd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:09 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/10] t/lib-gpg: fix setup of GNUPGHOME in MinGW
Message-ID: <f5700647839a21b5aed0d2dc45e65bed36ddd392.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
point to a test-specific directory. This is done by using "$PWD/gpghome"
as value, where "$PWD" is the current test's trash directory.

This is broken for MinGW though because "$PWD" will use Windows-style
paths that contain drive letters. What we really want in this context is
a Unix-style path, which we can get by using `$(pwd)` instead. It is
somewhat puzzling that nobody ever hit this issue, but it may easily be
that nobody ever tests on Windows with GnuPG installed, which would make
us skip those tests.

Adapt the code accordingly to fix tests using this library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index add11e88fc0..3845b6ac449 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -6,7 +6,7 @@
 #   executed in an eval'ed subshell that changes the working directory to a
 #   temporary one.
 
-GNUPGHOME="$PWD/gpghome"
+GNUPGHOME="$(pwd)/gpghome"
 export GNUPGHOME
 
 test_lazy_prereq GPG '
-- 
2.47.0.dirty

