Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1A278170
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354586; cv=none; b=CWCCwD/CxIvoaQqw+v+Gxsikb8GMwq8Rvtwq/qEgfF44iuNkHpV++FU8yQO1A5kXzMaSEe6AvG+mIj8BxTTBbmUgYDMMigw7xSeyE/YsAoKkhbRXAfYXnNShLqOYtP831j+rA8bpAzkmt1zDW7mkbW2j/13MewbM4PrwmrjUoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354586; c=relaxed/simple;
	bh=hNuik4g+ARy+k+ig36RUuSqVdIyJcm0i8Qd2hwl/cxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkAalXx3WkWLMpqAnQuJvOv2N9+0gUNurrxHkaj0IUbJKGbSpU3mibcII+RHRNES3WyZS1c3+E89cmFGHu08jJqM73UnKyWOnvYxT7+XQDWTxE8BqiOXGfs4zBP9e3pVV7t6K6JrCBTIFsUkwSFYFsHXPiPAdYm2vllYkfYk/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HD0tYBiu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwUN8mwJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HD0tYBiu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwUN8mwJ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75B341140161;
	Tue, 27 May 2025 10:03:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 10:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354582;
	 x=1748440982; bh=aKsEk+R+/ypOwDh1papoOHiCsKdM5zqu1FJBCgQJBdo=; b=
	HD0tYBiuz01PPgkmg53HH8G6lY4ubBYmEApYK4ggZaJhwUP2NUdjw0B+4gBcVcxh
	mpChBFi+mCrW/DJLAnfTEFVyg6d9xkMF9SWyL22F7pzfXcFaggZiSub7G0KTjrz7
	VmC4cJGdIfugc4GK62vNn+zMw6CtC7mvMko4BdCsxrQyC7kU+cYdrv1dzmDVh1BS
	g69hlHIt8V40dp3i2MObKptYvtKeqndjt+9d5Ojn99XjkjaEMtoRMiHKhpQBEFA5
	Huce2mCCeoXQ9sZA/DaEg/Bhl0/v4E/wMYlil0evY5QtcrCD+bY9TUWAxoJCEbvI
	VnMcmKIZj/gJAyQ49328OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354582; x=
	1748440982; bh=aKsEk+R+/ypOwDh1papoOHiCsKdM5zqu1FJBCgQJBdo=; b=J
	wUN8mwJ6OL9B4/lVUaromCU2v7zYwT6CVv7FjYnvnP60F5BGIoujTHyb4l/CZsz9
	X1GxMKO5qMfQy/CNYs+dQ5WCOSiGQTkcwg2qwhcwm/GwRzMj4RqP5qLulHwBHyFx
	AEe/bb2ASi5HMQ128P1P7LRZyK1/gmern72NUQdWlPHpk5EqjhqxHUxaBH8ut6KG
	+bLYjRECybNzU8Qlj6kEEPD36x1gmo3jtRNWU18eFM3rqWBW4CGkv+J4psHgXC7q
	u/vjie1dBsOOgCWwM59fXJ6M3zqGmIQiH6KfzPVFsg+nYMse3tc0dBoluqjJwk9v
	fHXixCSWfVtHw/Ow3eIjg==
X-ME-Sender: <xms:FsY1aALsYaekEbOuAzSYxBQ_jTjSINX1Jjmt1-C2PPm8_fSPbW8gww>
    <xme:FsY1aAJlidT7M2tieKKFBeaDmQj0XNAt6aDyGfDavozcftmij2Vo2DGTTPknY0dIu
    Niy5krr0e41GFRosg>
X-ME-Received: <xmr:FsY1aAsmeMA2sDsG9K7g9O-bPtRQOY1RDDa--02z2sKbD3yp2q88MME7baf4jeNI9-dCsr32BAaiCd_iuFIECY_g4OEN38eaLRgwhiPJj17NJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    gvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhies
    rhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:FsY1aNaAXcb7GNJWbMdNN9JKsLjad0s6z9LlfXXUT00DLxnOygGCKw>
    <xmx:FsY1aHbjGw0Xc7qRCL40S46MIuDfYc9Trgqpc6ojbzslTZQjYcEStg>
    <xmx:FsY1aJB56ih4SNSINs7ZmeXHKwxn1lZ6c5D3z4uJU1QXkczNSmwEbA>
    <xmx:FsY1aNazaniI-HWIl-teDxuBepzJMzQTA5UgcEWWyK5hNKsY9hxpfg>
    <xmx:FsY1aI8gNhXhy_j7ACT93tYWgIyg-fY0_AiwRXPeoDxKXHFG2SMl3yIx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:03:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f20605ff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:02:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:02:53 +0200
Subject: [PATCH v2 5/6] meson: introduce kwargs variable for tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pks-meson-tap-v2-5-ae360f77786e@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
In-Reply-To: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

Meson has the ability to create a kwargs dictionary that can then be
passed to any function call with the `kwargs:` positional argument. This
allows one to deduplicate common parameters that one wishes to pass to
several different function invocations.

Our tests already have one common parameter that we use everywhere,
"timeout", and we're about to add a second common parameter in the next
commit. Let's prepare for this by introducing `test_kwargs` so that we
can deduplicate these common arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/netrc/meson.build | 2 +-
 contrib/subtree/meson.build          | 2 +-
 meson.build                          | 4 ++++
 t/meson.build                        | 6 +++---
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
index 3d74547c8ae..16fa69e317e 100644
--- a/contrib/credential/netrc/meson.build
+++ b/contrib/credential/netrc/meson.build
@@ -17,6 +17,6 @@ if get_option('tests')
     workdir: meson.current_source_dir(),
     env: credential_netrc_testenv,
     depends: test_dependencies + bin_wrappers + [credential_netrc],
-    timeout: 0,
+    kwargs: test_kwargs,
   )
 endif
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 63714166a61..98dd8e0c8ea 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -21,7 +21,7 @@ if get_option('tests')
     env: subtree_test_environment,
     workdir: meson.current_source_dir() / 't',
     depends: test_dependencies + bin_wrappers + [ git_subtree ],
-    timeout: 0,
+    kwargs: test_kwargs,
   )
 endif
 
diff --git a/meson.build b/meson.build
index a1476e5b322..6fb898a21d1 100644
--- a/meson.build
+++ b/meson.build
@@ -2036,6 +2036,10 @@ subdir('templates')
 # can properly set up test dependencies. The bin-wrappers themselves are set up
 # at configuration time, so these are fine.
 if get_option('tests')
+  test_kwargs = {
+    'timeout': 0,
+  }
+
   subdir('t')
 endif
 
diff --git a/t/meson.build b/t/meson.build
index fcfc1c2c2ba..3fc8c6c2201 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -51,7 +51,7 @@ clar_unit_tests = executable('unit-tests',
   sources: clar_sources + clar_test_suites,
   dependencies: [libgit_commonmain],
 )
-test('unit-tests', clar_unit_tests)
+test('unit-tests', clar_unit_tests, kwargs: test_kwargs)
 
 unit_test_programs = [
   'unit-tests/t-reftable-basics.c',
@@ -76,7 +76,7 @@ foreach unit_test_program : unit_test_programs
   )
   test(unit_test_name, unit_test,
     workdir: meson.current_source_dir(),
-    timeout: 0,
+    kwargs: test_kwargs,
   )
 endforeach
 
@@ -1212,7 +1212,7 @@ foreach integration_test : integration_tests
     workdir: meson.current_source_dir(),
     env: test_environment,
     depends: test_dependencies + bin_wrappers,
-    timeout: 0,
+    kwargs: test_kwargs,
   )
 endforeach
 

-- 
2.49.0.1266.g31b7d2e469.dirty

