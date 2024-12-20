Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889C204693
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697395; cv=none; b=KCH6RRmiCoAC6e8sO5FRMQXbgnRHBLoUhYGI+7bDdELDDoqpwC15A4WWF9D5LXt7OCcCyeZZQPxGyvwhWmiRGEq349wP+7s+rKUkh/4qUwWNDSjVsMZMCGJwDEm/W3pq1Qpx7S5shXTWGu0KjoeG03yD/zA3hnU6nilLOGdir9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697395; c=relaxed/simple;
	bh=SWtKVYqEH2dlesWv740OBSC1m8E0dSpAGnv/p18GXq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGmpZgIMzP7JcvdcHpiofWCmRytEXaRIRbyglEFQXdfGErawyBNl7RaLRVfw53K5AiyAZ7W354Xa3s0FjWcEy46CMCPl34hKfENkGa66mvoYkLF/W38DU7h2IAOnUT8tG2+o2WqJJ0IiKNwQIFHp+DC80cq6W1CZ3N56J6ETzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H4gMAhaF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/4LxeYu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H4gMAhaF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/4LxeYu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7A5E11401FE;
	Fri, 20 Dec 2024 07:23:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 07:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734697391;
	 x=1734783791; bh=Ahhl40NFQT1iU3EMsw4mAJe4U7EYMH0GfxAueUAzjj4=; b=
	H4gMAhaFVsgaDMXOdqxEnVKSVlHS9VjwO0Jdp89Tw0ePLvDeuPVDwnS5tkE3pttI
	2kLaQb+nHeXpdivJMmqXoqWTA7cowLZ/Cch8gkf4hqHwXOSvDzQRQWOD3jKXg9LU
	BrpXkK65M6cw101aVpxeHpX93BNt/ljlVd68UQ7QiUO6dJdbTnYNSpifr0Qat/41
	KMQjvji0ddbQOQKVOu7mzioBSq3AxLchv7GvrlIZGginwFPA+0NqVT9s5pqymzfy
	xrAwAr6YaCvmMKRTlAek2haayeY8+/Q3Ys8N3BfpBn8dcFDnxc5jgpBrRE9bYTAj
	dU/mm4Wt+7ynAh3BuYGoFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734697391; x=
	1734783791; bh=Ahhl40NFQT1iU3EMsw4mAJe4U7EYMH0GfxAueUAzjj4=; b=U
	/4LxeYuDkiHgpHBPsEHQ3SX2ix91zo4Sp8y3GQc4IDIS0nek/TZtkFMpc32SlF5X
	YPqZF73iPs3n+JxyYNN7vA/GkZlft2+COYJ4daZHDIjWa5W26hg9XlJBs5Q2jzmz
	JhZt4ASeLFizGimtoMauyZarBtbA+IMSfc5VmrQ4w5X/Ybup3GdTucRFuP2am6wi
	hIOGrE9Latv5/8IbI2h1ybs/0kGWUYFot/dCAMLiMk6mORE8t+O6UA723ULQE+Wz
	SFBDIhn379I0UJR8lU6aFuSYQECXGX3ST1u4WjB9bNb97cJiPeLJ9prh6cdo6QgA
	h0+/pUYzlFwfXQylX/0AA==
X-ME-Sender: <xms:r2FlZw9f3JC40k6J4l4UK07NJto-0EjQVFJot9MXo31gK-nIjCFBBQ>
    <xme:r2FlZ4sPBpfliBDcwHZWwDKL_NpPJkXjJ1-BvuUpHS0P4xOH_ByJju-kvVwR_VpxF
    ufwx2q7ilqtdPhGQA>
X-ME-Received: <xmr:r2FlZ2DYD5XMUoIPBwDUoIOoU-Jv5dMcE6d0pn4A5IfZAQfIpnQY2acdnSn-gE8Oy4rodZL78hkMzMeiG0esGQANBg9AjMu7udUhCKLHUAHvJ48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfeeivedtue
    fhudfhfedujeetieefvdelkeelffdtgeekueegjeejgfekueffhfeunecuffhomhgrihhn
    pegtohhnfhdrihhnpdhrtgdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:r2FlZwfNiLHuers38Cy-Poq9Lq4gJYHvbaHkMjQk-C56Vwo4EyJiYQ>
    <xmx:r2FlZ1NaK9CuauG-mBmIznAEBbVtwMLC22QXyosJHOwdiFmVYmmfRQ>
    <xmx:r2FlZ6mjBlWIx3HTcrrQqvjMs56TSJ0Rfi7iR1G-PuiZ8PeEpJ1r3w>
    <xmx:r2FlZ3sWRwu0wPWsFcuiQbH15REFPXk4kdKHZiLoz45Jd4kK-4gXGA>
    <xmx:r2FlZ6rZ2JR9fQfpDivKXG5uDbYiAf97c7jzP4PXcIhkmEYog84ob0wq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 07:23:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64358e6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 12:21:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 13:22:49 +0100
Subject: [PATCH v2 5/5] meson: add options to override build information
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v2-5-f1457a5e8c38@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

We inject various different kinds of build information into build
artifacts, like the version string or the commit from which Git was
built. Add options to let users explicitly override this information
with Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build |  1 +
 meson.build               | 13 +++++++++++++
 meson_options.txt         | 10 ++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index f2426ccaa30c29bd60b850eb0a9a4ab77c66a629..fca3eab1f1360a5fdeda89c1766ab8cdb3267b89 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -219,6 +219,7 @@ asciidoc_conf = custom_target(
   input: meson.current_source_dir() / 'asciidoc.conf.in',
   output: 'asciidoc.conf',
   depends: [git_version_file],
+  env: version_gen_environment,
 )
 
 asciidoc_common_options = [
diff --git a/meson.build b/meson.build
index 0dccebcdf16b07650d943e53643f0e09e2975cc9..be32d60e841a3055ed2bdf6fd449a48b66d94cd0 100644
--- a/meson.build
+++ b/meson.build
@@ -201,6 +201,16 @@ if get_option('sane_tool_path') != ''
   script_environment.prepend('PATH', get_option('sane_tool_path'))
 endif
 
+# The environment used by GIT-VERSION-GEN. Note that we explicitly override
+# environment variables that might be set by the user. This is by design so
+# that we always use whatever Meson has configured instead of what is present
+# in the environment.
+version_gen_environment = script_environment
+version_gen_environment.set('GIT_BUILT_FROM_COMMIT', get_option('built_from_commit'))
+version_gen_environment.set('GIT_DATE', get_option('build_date'))
+version_gen_environment.set('GIT_USER_AGENT', get_option('user_agent'))
+version_gen_environment.set('GIT_VERSION', get_option('version'))
+
 compiler = meson.get_compiler('c')
 
 libgit_sources = [
@@ -1485,6 +1495,7 @@ git_version_file = custom_target(
   ],
   input: meson.current_source_dir() / 'GIT-VERSION-FILE.in',
   output: 'GIT-VERSION-FILE',
+  env: version_gen_environment,
   build_always_stale: true,
 )
 
@@ -1501,6 +1512,7 @@ version_def_h = custom_target(
   # Depend on GIT-VERSION-FILE so that we don't always try to rebuild this
   # target for the same commit.
   depends: [git_version_file],
+  env: version_gen_environment,
 )
 
 # Build a separate library for "version.c" so that we do not have to rebuild
@@ -1544,6 +1556,7 @@ if host_machine.system() == 'windows'
     input: meson.current_source_dir() / 'git.rc.in',
     output: 'git.rc',
     depends: [git_version_file],
+    env: version_gen_environment,
   )
 
   common_main_sources += import('windows').compile_resources(git_rc,
diff --git a/meson_options.txt b/meson_options.txt
index 32a72139bae870745d9131cc9086a4594826be91..8ead1349550807420bdb95e55298ea4f3f2ea9d0 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -16,6 +16,16 @@ option('runtime_prefix', type: 'boolean', value: false,
 option('sane_tool_path', type: 'string', value: '',
   description: 'A colon-separated list of paths to prepend to PATH if your tools in /usr/bin are broken.')
 
+# Build information compiled into Git and other parts like documentation.
+option('build_date', type: 'string', value: '',
+  description: 'Build date reported by our documentation.')
+option('built_from_commit', type: 'string', value: '',
+  description: 'Commit that Git was built from reported by git-version(1).')
+option('user_agent', type: 'string', value: '',
+  description: 'User agent reported to remote servers.')
+option('version', type: 'string', value: '',
+  description: 'Version string reported by git-version(1) and other tools.')
+
 # Features supported by Git.
 option('curl', type: 'feature', value: 'enabled',
   description: 'Build helpers used to access remotes with the HTTP transport.')

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

