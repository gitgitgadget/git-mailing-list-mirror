Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784518C31
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134731; cv=none; b=sF8l6YhT2LBy43AfT25Bh6aDRggwiW68hLWQ/rjOPK8Bl3OdHSXPMRTL0tfrXfYyXGHuurCsnsk1rrid7650rU1v9d5dN9rfbjwrZnDkMB9pA7DJ+qQ0ag9p1are0VPeOXH3lUUsHEWSTpvsRRb5nsVHPs/wDr0B9SnTbNL3IwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134731; c=relaxed/simple;
	bh=2Knu3S+O53htEaO4TMh02RiHENOxqoHagCT//mQBOFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyqJE6MxSDeuoWA9Uwk5TXdRvMlboWxnh3lnYqPvoWjsHzPaSj6xgdG1yBJHdDeXFohOtcj1JEqGLg5NbMOgKGD+4v8cCBjMlsc6hhXU/S9/M3O0GVRBFSeZkX36pWUMq4JX7nTP5Vf3Ql5bZw9j3qAe0Fzj3/wMLUQYdprb3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W8mD4S5P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OEA0hHqI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W8mD4S5P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OEA0hHqI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 389531380B20
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 29 Jan 2025 02:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134728;
	 x=1738221128; bh=D1ZHHE1wbuSCh1xpVDG5TngVv7olViukOwV1BjUYwaI=; b=
	W8mD4S5Pmx7kSFSUKAYEmbCLwimx2PNit00GmH7QERat8Rh8v3KsmMejTMP64JhB
	EQPF50kBHNO6QjmTPIh7asZfU52+8AigIlz00JU/K2QgnMH35GhJmh/5xzf8FxPu
	LaG+AKMgVbLvhjt8SNM8sWyZOQuPDdxlNj4sGZYg5XsJ97u1Y3H1F5jqzLIbDka1
	9J03D6n88sTmJBIy6wAUtVw6GQNhBcwc7VoS4I2fzLRxQ4611PuOA7y4JpY3EDV7
	CLtp8sJxBLknZKOzmsKjG01vGLjEtACzGn9LNf7FdQEuZCtaAovMpyj5vEA79Auh
	GEywNcOW/v5/vbebkJ1sPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134728; x=
	1738221128; bh=D1ZHHE1wbuSCh1xpVDG5TngVv7olViukOwV1BjUYwaI=; b=O
	EA0hHqIzpQgCPLGCLeebrZCLVjqkBD8DsUzLD1aFmRCAz44zuMmwG7PDr1uyaRwW
	iFNgwWBWKKFFc/kUPv8G2xijQ8OTZd0uEdqqovs6fc5VSdGtWORdCJ8HwPFInjwA
	18iQ99qFlr8Jz7TCdZNdNiLhYMNGfRsWmfsfCpVeO84vUxmgCKKOpy4iTLbJqlIB
	6FNGPhMH5qAPNTDTAHn9Vt5hPN5WkAeqPfY7Qn7FVuZIHa2VXZ8iqjCv5lpMhPxi
	MfTCRQARKTzXCN/1nJfrDG4LiCU9WLrXemsIHLpVtqs43a4Nk5C/v/fnAPS9pq5x
	U0fubD8pxI/DBHqldWkDg==
X-ME-Sender: <xms:yNSZZ9w0m7Bm-iiMmCCEUHKRptCmDocPELJX1V4IWBmMUu50FHZK1Q>
    <xme:yNSZZ9RFWW4mM-eqHyNEiYMNFwA8C4hMmP9RLcuUM8LR3CJ5CRmCrzndsYNphCOZP
    IFkynYh1XNyGtzj9Q>
X-ME-Received: <xmr:yNSZZ3WLj1_YnrOdfZ7y6Qj1-sZlfyUm-g7m8ck3AiWHGKxplWRy8JNniKtgi0dYDfEz3y48-g04x_hzm_1IqF1HzwTmmUwNx--bJk7IOu-SSC3b7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yNSZZ_jqKPLmxqh2skDiHrxulG-pcY009W8Ip7RW98l5Czy6zDOhdQ>
    <xmx:yNSZZ_Cfasd6969dc0TYiqSpwQ-A8Nv6inlCYhDJwpPFfqDngi4MQQ>
    <xmx:yNSZZ4JVPsZcanlualeqEsjZbSOdDzkTQD0mLmQkAFGbnmv_omRRyg>
    <xmx:yNSZZ-DF0msttPLJ-nUSOgEC_Kkc6x1a9bmZNOQ4sq1ygA7Yp_9jqA>
    <xmx:yNSZZ05dZbpPg9dXN6oeGoiAUazunaBpTHXhIWL_2nAzbKcRdvPpvlGW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b17f72b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:11:55 +0100
Subject: [PATCH 02/11] meson: inline the static 'git' library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-2-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When setting up `libgit.a` we first create the static library itself,
and then declare it as part of a dependency such that compile arguments,
include directories and transitive dependencies get propagated to the
users of that library. As such, the static library isn't expected to be
used by anything but the declared dependency.

Inline the static library so that we don't even use a separate variable
for it. This avoids any kind of confusion that may arise and clarifies
how the library is supposed to be used.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index fd83df8c42..84d100fd25 100644
--- a/meson.build
+++ b/meson.build
@@ -1521,17 +1521,15 @@ libgit_version_library = static_library('git-version',
   include_directories: libgit_include_directories,
 )
 
-libgit_library = static_library('git',
-  sources: libgit_sources,
-  c_args: libgit_c_args,
-  link_with: libgit_version_library,
-  dependencies: libgit_dependencies,
-  include_directories: libgit_include_directories,
-)
-
 libgit = declare_dependency(
+  link_with: static_library('git',
+    sources: libgit_sources,
+    c_args: libgit_c_args,
+    link_with: libgit_version_library,
+    dependencies: libgit_dependencies,
+    include_directories: libgit_include_directories,
+  ),
   compile_args: libgit_c_args,
-  link_with: libgit_library,
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,
 )

-- 
2.48.1.362.g079036d154.dirty

