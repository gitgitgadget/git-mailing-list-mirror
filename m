Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389641DB352
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254277; cv=none; b=XeZUnaYgjH0MnU317d5PqY0sWeccmiEcJZx3iWZWDuMx6tThs5Le6zCtYeY67Rb8LKVONOWeAZ8qa0EfGnakar05E1ZEp2kMH0oChFIG92cwK89bxb+a0jiTSb8MWut9NBwN721KDWwOt5cr0PIQkIHL1A3EROoRRmqD3OPCryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254277; c=relaxed/simple;
	bh=t3nveKlHQUXkKx+AYO6N0cXMy1XnhScQ6x1+IawjVmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMlo+I6VbxvkxI1JXRPboX5ooNeXp0+VxqI6mMCA7h7YLbQnowBzwGw1Z7eZwdrWUSbqASSzDEFPOnYAaT24UA/b0USBUtXF77/cEA/bgevoN3INQETAgmDtJ1mBTxEG/IwfsnZD/Lg1pkdd2GJ3QefsU1t5R2IX9SrDb/4arOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TLk52F5F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9nEu0rJ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TLk52F5F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9nEu0rJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 623C811400CE;
	Fri, 18 Oct 2024 08:24:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 18 Oct 2024 08:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254275; x=1729340675; bh=u5RFz/em+5
	upzfhdJcuopNexa4SHMjV3+xA4lmg3JiE=; b=TLk52F5Fafx8i8au4Uk8DTBuaV
	TA06PDI6IYsyumKqptDLiqYIY+q6SyFR5aVEc9H6Br2qtsXLgazJtiSc7btEaHr/
	FqBAPSDSw8P62EAF07koBJmJBSniNomvk38Y4WwvTg07qs5lXyIswoleKQGtzcij
	VdVzbjuRz+c8ktuxOkA+qtPNnWY/GhHH2wVljgm/hobQxJTeU2UjCAWqPJVUchIo
	zfQNdHZMdHmqEsjl8OVpyIluXEnKF88OF0+7xf7HrLK7T/kXlcUGZ9moSTJRbAb1
	lYUDvR3FN3kz02H+0SrcUi85eHNlFpOV3s0F2E6FGj8MOqHk14SEpbwOXtvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254275; x=1729340675; bh=u5RFz/em+5upzfhdJcuopNexa4SH
	MjV3+xA4lmg3JiE=; b=d9nEu0rJNWOTdtKMeMjDrO7efC2jdY37IILsw+yBecYl
	PoZIv7cnt9zx7WDfFMuiA5YmTFgHbRqJ+TGWjVg+nKBl9DHUiGihGaQfUA6RqxRt
	zRHtJ62iZ26r4xn/rQV18faoM9KToZAnMrs+Q5DkhDYnSo7LndsYhq8RbwOdIK3S
	WiQXRTpc9uaP1XX+lAB6CH0RB6k4T9dlm0pi+qsCBJE32B9arx3A1HtKCBCB2YS8
	xbv74ZiQHaE5+iupyrO8XBt+d1ne+Pe1yWGQxWeEePA8s+GZjgf5UZIMm/VFI43o
	PlFpkziXFS+h/W7QgjZh3zfDLaaGd6cIUeGBsC8fJg==
X-ME-Sender: <xms:glMSZ2QvBXRDyn4_Bi-Eh4Wnbu-VG7FZbGa_UuJwA-knM_KjVy9R_g>
    <xme:glMSZ7wh7775g53LH3Zco74cxe3pX7nwKkKdyXB7xfZxDSpvrCyzqXwb9HHTx6xoL
    DKoHDdebr_U-trRpQ>
X-ME-Received: <xmr:glMSZz2d0DyDx9_5NXaoDUou_-vOqEBCyhuyqS4sCjl6Nbfy4HbYrroeU66EPMJMkFZv5oxaDYZD83aPGX4C9P1L2I7jQ9e-wXpytqG5agtB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhs
    rgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:g1MSZyAtN3F-afrMFJIbCGroXfRIZzHgXmoc-hE4nTnryWgVsN4IEg>
    <xmx:g1MSZ_i6zFz3M9iC_CDZM9GtrokNanziqjdpft4msOMWcRKVvL9nuQ>
    <xmx:g1MSZ-oHrWBvaqFCwJZZH-aWJ-PXMvhBuvc1N9LG9tJy8HeUkK7SJw>
    <xmx:g1MSZygsHkkoWAYftISY_myOmGrf1odgytPBINiDDtF5NzMv99ZD8w>
    <xmx:g1MSZ6U1bSQAptLFfwk7_pG60f7BVdpvPKUZJSoHKBBdKmsHoo9pMlic>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb76b85c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:23:12 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:24:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 13/15] t: allow overriding build dir
Message-ID: <542b01515e186203ea12b0a69fc1dcb619df2f73.1729254070.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729254070.git.ps@pks.im>

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
2.47.0.72.gef8ce8f3d4.dirty

