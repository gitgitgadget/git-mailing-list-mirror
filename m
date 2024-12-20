Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8D02236E8
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723893; cv=none; b=Uc+8gJemhoiKJoAp2Xjt07Rshcf564z3m3KOLuRAgKgqaLCLjxODTXBC+e7s7fWPUv9fO/2bf/ztxBuo3ziRi8EMg5GlE4isZJACVYRrFNAz7zSQCrnI0eTkV//Dy39ioq8Q0XChhJAWwCtcuaCh3dehAeEkdj6Ay9/205fG32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723893; c=relaxed/simple;
	bh=SWtKVYqEH2dlesWv740OBSC1m8E0dSpAGnv/p18GXq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvAfRrLDTUoFBi/fhGT6SR+cXf55D/0MARc4Vs5yFpCqcmZ4usst6zTKXBeTl9dWlInkZDVHwa5xsRyFl72535d8yhBkqWRtSHKQGncWA32AB2in6NMV+RulJNljpC99fYWAApGt2yxsRxjlWLNryX/T2iXMOUE1NUqPXwmIPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aq0TAz/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSeSACnh; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aq0TAz/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSeSACnh"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A08E9254014E;
	Fri, 20 Dec 2024 14:44:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 14:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734723890;
	 x=1734810290; bh=Ahhl40NFQT1iU3EMsw4mAJe4U7EYMH0GfxAueUAzjj4=; b=
	aq0TAz/OByFH+XTgwyQOLjcbQ9yBHwySXOrrnzgJfepQ9FPOLQ0llxFdNeaggrQG
	DAG3kqpgXnYKt9K8NIelFV6QJteAW9C1aXNaRaFdvhUiyUKfvabWEPUQzVjAt4lO
	ziKsmxM6t5/7dlih5WfcMY/6ZL/aY1dMIk3jKsiwcpZA6q0RfY0qomg4oHhfL9xF
	OZ3gdaZvyDkzCxLSDM1OCetTcYy5RQphqXYK2mqdtODpwgcX6Ifw78f18yQX6dTk
	yR49jEcqYhrI7WmAFiTmp6+ChxDogxHoV+xOELKQDwKsdCDhfHdlzNX8bLKg9wd0
	zrlQVNS+vD3abHQ281Nghg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734723890; x=
	1734810290; bh=Ahhl40NFQT1iU3EMsw4mAJe4U7EYMH0GfxAueUAzjj4=; b=K
	SeSACnhF3cjo5nqekrP4VUbNI2qW8DOJjbXflBm7aq2twT5YZna4MKbhY3e9Wx8H
	+HIi6LcwRNRbU+ld79rvbOFMwJ4oIXPD94n+DFf3IlWcZ71WNw82y4+vrOWgjilN
	wMJwnSvjcx/LCttQN6oTxxwEXB/T1o0OfjoWDCBbYDP5FLxxLSTPw1qQPKFKyrrc
	3r9OKLww1WaoenvrtwzH5Gl6lCCZSUKxaV6WLCG2mp6omIbq4fq2kf97urL9KJ4d
	xwvf/68M26N+OTjFpckjbY5Ob60tZTu8IULEbEDovpAmb2R5LFMZHQ8AGPQnAN65
	Du6JorEdgacPWw0DlwWiw==
X-ME-Sender: <xms:MsllZ5Z3wvlMIDVbkLT1WUtpRIESvLpEumxigLXio2vHcETqumsfsQ>
    <xme:MsllZwbLe6ngb9XX6E4KCTvbsDbWhhrxVwxPwfzfJ6imeiQ2zc6K-XnRJQxfPyEQV
    oMgRZFfsVeMvEfzMQ>
X-ME-Received: <xmr:MsllZ78tBbcTTyyZlipWz7b1-lZhESAMoMipGtvOEVMxk9Ep_5FQRS0f6ErQiI76RJ63zGZpJbC0qugUiGC7tRuk3RjRHeWGhlBNE_6HzRXBLvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefieevtd
    euhfduhfefudejteeifedvleeklefftdegkeeugeejjefgkeeufffhueenucffohhmrghi
    nheptghonhhfrdhinhdprhgtrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhogh
    hlvgdrtghomh
X-ME-Proxy: <xmx:MsllZ3qARad-en3y5O0q2MVSxA_s72SWuho27GHDVAjePRt_d4z8OA>
    <xmx:MsllZ0oUwSIUE_FwsxEmHZxRe5tRHJjg6yROVx3b5Rq_zWxC8vF94Q>
    <xmx:MsllZ9S7jqXGTPCbuhHHZGw7f_1tXvTWQhDK6n6qrKN9NSN7WepQIg>
    <xmx:MsllZ8oClCxx5ocW8o_VuNaPVMN4OzHqdPHuySXoq0Yto9hxrlrvGg>
    <xmx:MsllZ9lg897P501L0p1O06Z4Rpph8WYa49U-UJ3-Aa-zdtq7Uwxna31u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:44:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab576976 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:42:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 20:44:26 +0100
Subject: [PATCH v3 6/6] meson: add options to override build information
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v3-6-1fd79b52a5fb@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
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

