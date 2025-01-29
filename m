Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A519C543
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134734; cv=none; b=TJRF//XRCTAiCW/WtlFNN8CuG1OiBXUtlWgTicaCs11bK7cIXm6swE4jOFSEbkJ6v5sZWNqNsXuzyTyH3rey/rD7H563LkS8O1P/9JTge8BVIK9aA3WuWcJB9/K2oawO7rL5DVCRNRiLMtCykd0sO0Iw5Ad9fyEEhcO6QYVQwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134734; c=relaxed/simple;
	bh=BrxBjTLPzkGFIyJSC672QcWajo/q7kuw7dmBNePl/mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROAAMoe70AeqfaXhpV2RI6MQbK5jDk46t/AWKHJ35OXN53CietchSzktZaGx0688XwMqGKdqw8EXZf9/BMmfJQ0Xbj230E6EN9IZ+Ne+EI/Fajkpwp6sMzm4g6OcfnG9iKbfqkOG8cxPRdXn4kdP2da7BlK1Ogzhwj0UzTJ0zfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ux2unMfR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CMfdfYFg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ux2unMfR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CMfdfYFg"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B598E1140109
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jan 2025 02:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134731;
	 x=1738221131; bh=kuhCG1nvNWYsHBYL2GwZaed2ri+bQg3c+cVuu4LJlG0=; b=
	Ux2unMfRL2WhPIvpm3GH1nT/FvkTgY3EwBNi3pKL5kEs/v0bjyVfxnLruQRZDi/P
	Xpngi99TLM1r5Wiu05UYzh6vO4ijPb8u1Vi7IQhTr/Lwitrry47gagFjACLHCqpg
	UxBzrNV3imouV23QKoOmU/dBe9LWggzLrOuLCxEmeGyGpuMRCf9KA9qUCAka+1Fp
	MjW+IduFHS6CnyeFGOaxu41UotpdpqfloNwvVoW8aB84r+rs9P5wqJ2r9/nH3wHT
	VZX42iTEU9qFdovZjelD86wtJb4CPZmgTu99nLpPPINMSLd2PFaYthlmGX+TgI6d
	d06Q6u2kPY96U0qTeB043g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134731; x=
	1738221131; bh=kuhCG1nvNWYsHBYL2GwZaed2ri+bQg3c+cVuu4LJlG0=; b=C
	MfdfYFggltk8x69uW9UG0O1JT4aJiVwcG0o5VtjpVdUlKcDs8VMFyPag0cuUSzJJ
	J+K8Ggv0a7pEmaXt+AZGap0rGfCL1sgAjbWGtp0oeQSEvKlZXdIQYzud2OtxXnum
	V6zhxxXQif5npwetCZCAMH2ZpZcSECwVpBsEXs57zJrVOJcc6jGqpTodUk3Ckow9
	PF8bb2yoHz31uw7kRX91K7ak3ba1P+B+Q+waU5XXuIki8+VLv4uUIopMkzfXeS+e
	PAvveQaW9U2i3k0ktG2ypTi8ELCxcRJWpUBGL4S99fmG3eLeq/rJlXBq88vjCAPI
	zKeYe/bqJ/QaEPsModm5Q==
X-ME-Sender: <xms:y9SZZz6GN-da3q2736NEj6E6IjWBe3KVD-5umMSwj6t4kMtFrC6Vxw>
    <xme:y9SZZ474XSI0F-EnYz_4TfZKjjh8cZbK-tVllFQpdl9JEgHCODG-rHGf9HNC5fSfY
    a8nwCuaRPdX6ZVRfA>
X-ME-Received: <xmr:y9SZZ6fAmk2atwHE29juYA0F-A05ZwNMfXL4tP-SrxaIChOUt1fENJoPjiyffnwGCmaLeRHgG9TGVrZ1dEcI-yEgmvlpgjGVnGaiqNpoGRCxYxGH6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:y9SZZ0J90cSZusFSW-ccRRA-4f0BGJACH33k8yZHGepEHS42bx74tw>
    <xmx:y9SZZ3Jl1_SztCLGSQhdFT4DbKjbQsogqeZ1AhhNZC42a4KeIW90ZQ>
    <xmx:y9SZZ9w52abIA0VPVdKwYrvrBMa8UvKsXgnkOW1iagM4TR_3ssaBXg>
    <xmx:y9SZZzLc5sXrbvFENiABQ3bD6OSPvmToGlB4HjAl0zkz5MSFMOV9_g>
    <xmx:y9SZZ9gurq_ct_iqlvndHuEGUFqoL1jqNC6GBvpsuV0q-o82GiP9J9wu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f118c72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:12:01 +0100
Subject: [PATCH 08/11] meson: simplify setup of PATH environment variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-8-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We're setting up the PATH environment variable such that a set of
necessary build tools can be found at build time. Make this step a bit
less repetitive by only looping through the set of found programs once.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 48eb068fd8..e3829f2365 100644
--- a/meson.build
+++ b/meson.build
@@ -181,22 +181,21 @@ if host_machine.system() == 'windows'
   program_path += [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
 endif
 
+cat = find_program('cat', dirs: program_path)
 cygpath = find_program('cygpath', dirs: program_path, required: false)
 diff = find_program('diff', dirs: program_path)
+git = find_program('git', dirs: program_path, required: false)
+grep = find_program('grep', dirs: program_path)
+sed = find_program('sed', dirs: program_path)
 shell = find_program('sh', dirs: program_path)
 tar = find_program('tar', dirs: program_path)
 
 script_environment = environment()
-foreach tool : ['cat', 'grep', 'sed']
-  program = find_program(tool, dirs: program_path)
-  script_environment.prepend('PATH', fs.parent(program.full_path()))
+foreach program : [cat, cygpath, diff, git, grep, sed, shell, tar]
+  if program.found()
+    script_environment.prepend('PATH', fs.parent(program.full_path()))
+  endif
 endforeach
-
-git = find_program('git', dirs: program_path, required: false)
-if git.found()
-  script_environment.prepend('PATH', fs.parent(git.full_path()))
-endif
-
 if get_option('sane_tool_path') != ''
   script_environment.prepend('PATH', get_option('sane_tool_path'))
 endif

-- 
2.48.1.362.g079036d154.dirty

