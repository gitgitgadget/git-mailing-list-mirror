Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F851A9B40
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846704; cv=none; b=DKc7mwLSC/qvEI/Axrid9A+eST1gGLTqukyO8RMgHUWfbF+YRCCAAuSiulEOKwmSxMpo8/ktNVDN3yjMjSDf+Xw2B5zL3OdnKxFZ5spYSOcR7LctCuPRsxVd9I4O3oRA+sbsM6Zje/fDok9srDkd82bmCZ5XpqMD008VDvajPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846704; c=relaxed/simple;
	bh=m1UgWJQcypFY2C+R5YnF2W/FHkCEJYKvjoOXqDQ/huo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkDoLH1ncYWhVQq+8zJNJfI+tyXSeM2xLX3UeBcoaAZxkiRk3VXvyY3t4vNniV8zZ6pxJwPw1kuhV3ZtjtKx23FohHQIWbRfbH3dOVXHKtBG1EuiCyX9FrixTI8D3nsLlNJ2oBZhgSZlwqPlNsWda5XRlgfDwdEikrUq0Uo0QrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rz4u5MS4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKrfvcya; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rz4u5MS4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKrfvcya"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A859F1140152;
	Mon,  2 Jun 2025 02:45:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Jun 2025 02:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846701;
	 x=1748933101; bh=BU5ca1RBhzznm64U5umX179WrnueQxuUs0FtQDpMg4k=; b=
	Rz4u5MS4M9+z38nz8Befq8aPTe4s+mFuHUVxoweS+kvqCdikNcd0efKZsQhkE7LK
	BdU1P0VwREVYDYusBXqDgKQUTRrUxTfbo/Hh0UiklkixzoXFqomCql1B994SLyqn
	EVh7CsqHn8OYuz8H+VrYNQ0qfFukcVXd0KH1k0mNUrMyfatsfS6MyhtfGdciQM29
	meip9HoPQR6n1ZSjVIDCl1VaT2uIkoFoaekZUYkc//Uxi3jp8SniultFdPs6liQD
	8L3jkrwgCu5NG1V8wqC7rwWbkWCPf3rSx26kBXo5r6dQG7Pl6vvLf63QSdM3RUAc
	fLGGLDQqMbMv30GnbCGzyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846701; x=
	1748933101; bh=BU5ca1RBhzznm64U5umX179WrnueQxuUs0FtQDpMg4k=; b=A
	Krfvcyaa1vfshGCmMqj/HDum2lBwtSvhlLqxwgrV3+uC8Dh3JRAeQ+W4rbCANg73
	9Tm7xWPeZRBeZkbmlDQkwwvuV0yAnEtgejkOd7IoySBtmF74g3ZPN1EasCg8OiAm
	wCk8j6OP88mtkp1u0TWEHSC7RMW14MjyADNax4yqyPyTYO4kSyApdHe3hRHZBqt6
	EU6CPwcvD+391MnciisyFXTAqEv+B6S+tSUkUrvU3lGxvr+Law4MDRwnVeqFFLsZ
	Lx3McX7HD15bEEHWCg8fVLYTLDpviNPPt60TowpXeC7N/CIoTpCyMqEhxvj6GzHJ
	QJUlYqdSVwEsZiPY8fdZA==
X-ME-Sender: <xms:bUg9aL63JFhYPhdgrE8CnWhwsjkQB90qAUvf2IIagULEe_oSU_6xmQ>
    <xme:bUg9aA4M1fOEdXr6m3WK3MRveCmtcgHqej4a0S6YwI5-RX-R249VvAvCLgIVMu6-I
    jfgEaG43XX0iniwtQ>
X-ME-Received: <xmr:bUg9aCcO03Jx5IXbboAC4LWpa33FKddEGqsQ5lwvHMc8SpiioJu-vMj6mxRLmzTx4bjOWq1acEb1upCxDvCU0hfdKGgVIjeNptCAS-R6wBuEyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonh
    gvshdrphhluhhsrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomh
X-ME-Proxy: <xmx:bUg9aMJ8a6UtBTFFCH7__V3Cuey4CEpT8vVSwAVZqw8fbgSbNjvPKQ>
    <xmx:bUg9aPIu9nsuuRP0DKnIoR8zVPPMYgixxKyiwo3dcBEqNYgk3Yh21w>
    <xmx:bUg9aFwF_pnfhdJlEtRe6oMMgjn8xF_g71QFTGPwe4Dq2B_MCzma3w>
    <xmx:bUg9aLKBZvXI1e6UelHFoVRhcsZ70jfGu9t1hXvqiLMvbgcYUWLAAA>
    <xmx:bUg9aBewzMREiQA3O3OVEc5sH75MyV1mcBn3BfQ6XGnC3V6_mLPKDU7e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 37d5ce46 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:49 +0200
Subject: [PATCH v4 09/10] meson: introduce kwargs variable for tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-9-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
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
2.50.0.rc0.629.g846fc57c9e.dirty

