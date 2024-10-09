Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F481E0489
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485837; cv=none; b=tJB9wk7BNjsaeqaclI9sUMFG0FWzOW6mcToz9v/yaEyJL5Fqty7lNtDRqYUBBCzZxvQd01nDyDBxu7vG7tBazKoWyvgWFmNZAMthtbHUBxd0ObNbkD9ZVejV8gSn/hq9Stpbe6HrHCqVOQNMn7tDvK+zZfyGFsrzI0XlEXaKngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485837; c=relaxed/simple;
	bh=LzrMZS8SOrFaA7rJy/l+ZrivqB1OIvWmVDxOeGUPzhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEQlBN4UzNaOhrSwOa6M00gW0k7mj8mSfBagyLK+qqIIsPBEG/ingvvS+yzYBvXLJ7BsrJt1QTrczvnz2330tlhzQpd8qLmC597qsUWyGGuMAHZH7JkRsfeM7SL32zL5Te+YDmsygEmTGkrVmcl4xQ82xpEutkSwgoNTqWG2ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T3dLvfgr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbJSYpEx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T3dLvfgr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbJSYpEx"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05502114015D;
	Wed,  9 Oct 2024 10:57:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Oct 2024 10:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485835; x=1728572235; bh=m9rOFqWALe
	H04MMhZTCFnVAon7cxhTEPn/4acBhy0vk=; b=T3dLvfgr5b6Z5kvGFgjRWQrmDp
	egh1ycPre6lsiFvaXy+ICSRj05x5z9D762tgDjoedRnUQbJ5khbA4E3vH38FnJks
	nIBUMdwg+R58LH0MSgKjArJrk3mXa0Vqc16dR/yzEGTMRJitTbGlNo3MNFuFM8Zj
	9YNFRMLXZvQO78rqtZme7xIp6WZveZkI1l4GACbqogzrxU0RTq8ybLbUbHB03q8j
	IOPPyAZVsWb9+QkjxFJOy5gkhAOO9LRKYCetorvOdiVeqknMJmDF27Gul2JbPkjZ
	IONowJHHVuwUPHQ/XlrSi0i7pea9N2ZbCaMGZ0SxLs7jT2nFNW3oN4sOJX4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485835; x=1728572235; bh=m9rOFqWALeH04MMhZTCFnVAon7cx
	hTEPn/4acBhy0vk=; b=IbJSYpEx1JKd7DVp4wrdxwv5sepzjQ0TZ/OaDQX2cCVv
	p9BS2tgcRZCI0s5Al/a+I0/sDBX4jjMh3l3eqGlvTcXodbsy1pYnHce4yEjoKcpK
	8rP6wjp341afB426WeCEdRpQfemRak6aqbzCIFzgPrqsD/t/busK14HUB3nAXOR8
	RTeQ7Ha7pdYeoD3ROHXqbCqkXlBALYILyHzBDj1ZY5VN6J3+7CqHBC7npGppfCTm
	b4RuSZtsGTvLcpieQmvPzftb4R0fyvmxM4vbVw5d/wc4neYeaJwSO4Pzqn7d5iF4
	VDwbGN3uzbinvtNVeb+m+dwLTeJz8LU5oy+zZBX1KA==
X-ME-Sender: <xms:ypkGZxQP-6oksKzNshxR-1KsInThY8lFACNpdRmhhKv9uVxKXNwdKg>
    <xme:ypkGZ6x_1-LFPfOPw814vdWXMWt3I_aBwgWZaQECiSu4NUbY44EThskvx2A_7UKBy
    ss3DrO1kjjn0rnutQ>
X-ME-Received: <xmr:ypkGZ208ZgT_AWeLI9McmVas5H4JG8ziwP11reun8-fRjjTVMuXghUcRYsB-WaWILZaFSx1GSY6K4y9egtLZMz940gD8EonyQvFfOHg7Iu-jjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ypkGZ5AUMTnRgZURwXaNCjQglTl_6BgrsIban2Un-WAm2gGpZPQtxw>
    <xmx:ypkGZ6jlYoPnTurhNFBoOieWnjv_nhvVt4kof7FJo9mSYyDyKeWtqA>
    <xmx:ypkGZ9pUN7NbxTkusfkeRjRsNihi5B_hvtabSP5ik91_FGgPES3utw>
    <xmx:ypkGZ1iOYLxjpudvFIpD1oAqvODj24MXewdKqHbMOa7zbE5BK41O5w>
    <xmx:ypkGZ8ZgMcz5qeAgUgntu6ZqmYPu6ctuGLv_WLvJKevAqSvJM0RGituE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:57:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 112b8ce9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:56:10 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:57:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 22/24] t: allow overriding build dir
Message-ID: <b5cd5250b770508756af0a7c722c0c774ee04ac5.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

Our "test-lib.sh" assumes that our build directory is the parent
directory of "t/". While true when using our Makefile, it's not when
using build systems that support out-of-tree builds.

In commit ee9e66e4e7 (cmake: avoid editing t/test-lib.sh, 2022-10-18),
we have introduce support for overriding the GIT_BIULD_DIR by creating
the file "$GIT_BUILD_DIR/GIT-BUILD-DIR" with its contents pointing to
the location of the build directory. The intent was to stop modifying
"t/test-lib.sh" with the CMake build systems while allowing out-of-tree
builds. But "$GIT_BUILD_DIR" is somewhat misleadingly named, as it in
fact points to the _source_ directory. So while that commit solved part
of the problem for out-of-tree builds, CMake still has to write files
into the source tree.

Solve the second part of the problem, namely not having to write any
data into the source directory at all, by also supporting an environment
variable that allows us to point to a different build directory. This
allows us to perform properly self-contained out-of-tree builds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 677424ced06..096af9be6b1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,7 +35,7 @@ else
 	# needing to exist.
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
-GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
+GIT_BUILD_DIR="${GIT_BUILD_DIR:-${TEST_DIRECTORY%/t}}"
 if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
@@ -513,6 +513,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

