Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AE22CBF4
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611919; cv=none; b=crRgzTmx8RcJa6J009cyQHYGBi1k0krDlKIYU4zw+OuJWsrr+IVMJxTdAI7CasuWcrsiwhfvKwIFDNP9Sn6PUaLSeTemYJBz06ZOTJGxQp4PUXMGxl9ITdUeH5YXiwGI/nMMQqITNgBMVnJ6AX9i3Di0fGrs/w6k0LtL29pBYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611919; c=relaxed/simple;
	bh=ZZnC5qQ+gJs2WeOEM7butall9wTfdYO0pVecIso8uRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQ/VonwKMqu68dOLzIajx9OCMj4VLfNsAen3XiAHkMZFC2Y2h1xE/9PaIuxvCX5OmzmNP2daxE6camY0LzqAdeS7rbsEMWKt9LSsPlNwwNtssuWlbZE4iisXvA87wuQ9oqf7IGziJdFhiLPZKHOuFk8XF3Je3PRBVdHqUN6/R6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N25ZibKU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvtE7nYr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N25ZibKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvtE7nYr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A0671140172;
	Fri, 30 May 2025 09:31:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 09:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611917;
	 x=1748698317; bh=EPUFfkrI0rI8xJ/ojsSd1viRgTb1tJ9WG1v7ZkqkQr4=; b=
	N25ZibKUcTAV0sBNdISuL/7Z/0Qcby6NeGh8OAq1Qn/+e76+6LX4Qmm6A4IlyyZm
	pFCpKtJ7m33n30fFH5KV7vRguBaMbhT+Xl+vnuI1wclxKkegXj8H8f3IPqRvPXJ+
	v9t3Mh5lD0vqiKP4dmvBJyXG1ZyHc466RBrtxxpGxTT+TDBvOAmvYrf1Np82/hU9
	XCERIe+jqK9xp3oq5xq4BHTqMgEKQNdkoss/73YWnOegqL0NT/YO9J/42scnQqFT
	1W0dfYjq3RmkfOcOtaOPtjlLfz/4iFrNkRZw4NYNOzhY1PD1Jop5hnN8q720/qLY
	OBsLg5Y56oee42EqLFp9AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611917; x=
	1748698317; bh=EPUFfkrI0rI8xJ/ojsSd1viRgTb1tJ9WG1v7ZkqkQr4=; b=H
	vtE7nYrTt7vsgEDIDHtJmDEJeWiHmiXQVzd4lfEEVcVorLPtb3hOfD13qvbKmxv3
	E3ieug2oMf63+sMV/uGYxUpiNJFQL80BHZCrVPF0TxOSB0FeQCFdR7FML3Mkyy1Q
	Tk08zjbMMaZCH+ijENHDr7i7+omRtCuLhjOE7usA6ulMtvRQK56vvwaPQdn170ZK
	bSE8iBsQXBeWpawzgd+ukE/ly70fK3tYisYkB8TMXZNajrn8QfkPwRP7Jh+GUwih
	bUoy2Y2SSNQtuhiYkoGA/Ik9VEEenL4W1mocPfS4W3Nf7ACt5zvCqhHfPxvBUxvi
	MHC0HLvRDZkrpEZkBNaoA==
X-ME-Sender: <xms:TLM5aPhBANQLV-BYKqnxm-eoxab2VJ1PfCCQGEPc87WVMDvPAylEfw>
    <xme:TLM5aMAC96fsm05WcaukKdFsU-TnnT0rNnLnQm8UstuRB82ZLzx36w2nDsOeWO_S3
    enYR3KsTgqKMWPhTA>
X-ME-Received: <xmr:TLM5aPEDBXFMojeZlRemqrsQhr3mBBI3L55FWEmDyzVTxtY6mb_F99WKylYuNEBZeCK3Zi4D2h-PPHnTx1Yo2A03QOOLryhL9nLjrk_B1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosg
    hogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhush
    drtghomh
X-ME-Proxy: <xmx:TbM5aMSfvIXyvE6_pOcHXiLX4FHnyNaNqCV1s2QK7v2oYnWmkGkVtw>
    <xmx:TbM5aMzizeWAHh_im-holRD-vVtL4S6w4pa0sOxFM0-GMXlkWz27Xw>
    <xmx:TbM5aC51Y0-E6AWW_IcyjkNFHOMGFbLg7fHJGgY4SN7Soqt4m8Bmnw>
    <xmx:TbM5aBzKpYWz9y5-9XFR2LZqz02RHPHG1sYlXuJKaV1RuQHIMgugnQ>
    <xmx:TbM5aNFrj9Ye15l2ckoM6r_AQ38KD4otc8rgkv23a3xUG4OUNBVs457E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9889f5c4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:47 +0200
Subject: [PATCH v3 09/10] meson: introduce kwargs variable for tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-9-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

