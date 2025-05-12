Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0325B684
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041614; cv=none; b=j10D1BSAwokkzlfAiK8Ll0502QfkIz+5iTMGTlVXWK21H4+2DWQkTbLyS8YgFEkoluF0EoIERkPOSd/ndCVf3qJS6v1l9fcEZIVlWBcgMPgca0r9bSfI8JP27kcILoOI1ET5VjAzO1ENB+1aPHX1Y1sWpjqE5HgvAve0dHUw3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041614; c=relaxed/simple;
	bh=/lyEpdAtJthoX1D37jZqpCDVTd9veCzR8ZD7QrFrACo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuXoht90oMjveWUdoOUU1DeLWqna02A9Wp9MRaG1O6y7cIHdSZsE2tChj2VmZX81s6FAiYd72mghxu72NT0ivFb67TdMelTFul3PD/TkZS0zXNkomIzuw6dQitxJnlcM28ONFF7cEKbq7Ga4giafR4exR2ETvDmk21MUEYV/ZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqIJ0GCk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1ed7pVu; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqIJ0GCk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1ed7pVu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E8A711140149;
	Mon, 12 May 2025 05:20:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 05:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747041611;
	 x=1747128011; bh=K7d0PJMSyJi42CLS5q3f0NQpBm7TlU9Y/8RcwWRTe+M=; b=
	IqIJ0GCkCsHe1Rc2wN9XEX7PGVuWTQesx4UyJT89ByoKkYt/lZ1d/71ZJxQctQ7W
	81V9rCaZFnWdI0gLG0MQ9xskokTBbO+aI5xNekURM0yXkUWuba7WVR3OFrWiHLr1
	eDQn6XqC/MgGyjPLGQUrBHWSrHUj7lzqgLCry17zu8vPCVEcnwWU5Zrg6QgFUiWl
	5O9PWdpbfO8/55uGlRn/G63Xao5Ewy4lVsxc+9lhINjhqN5qAQWqlDeD4PhkYfIT
	8ycYmabGsR3/KKCwutANTeikbZ5qh9xONPZqkyouN1qppC8qPuES4UsBDBrdg+qi
	UaaIF4US3CK4qC9jtIFakQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041611; x=
	1747128011; bh=K7d0PJMSyJi42CLS5q3f0NQpBm7TlU9Y/8RcwWRTe+M=; b=C
	1ed7pVudK7jz9kT6F7UX1+sS/ObeZxfHXBicjuSTMwssRqL2HTBJ94Mjrw+9w6DC
	rM5Vg7L1phUjCUHFuzU9juqs4k/+1Rrb9TVr5rAG8tH5bcPVnf19JKKfuW4Rt/nA
	84hvRsFdvyqT5jvZVut8hIzqMz3IJZ0uYhm7CHAOX4+nZtJsTYW2ednltEdjbmCn
	v0atjddEJCY0JpbWDNpHYq5WmfpLP4mmKce5gE2yAW0vglmcghbIboZJo5TUw7tz
	Ncp52S2IxoT9E3BZMqL0LG+JN5GKiE74F6lG60AUmG4dfaN5x6LtDuV+jpN3mupS
	sZzc1m9u7SgVAdaoqgyzw==
X-ME-Sender: <xms:S70haImIiAxkeMqHJqtlGIGGbT3grIFrDilWz44vWGcXDWkXCiKuhg>
    <xme:S70haH1UD_WS_UHKamRL5fiMyNzJaMCd17lCETieKj135rayiJCXLPg_8Fb7FYsaD
    IN0ViYxSVEa7pc5JA>
X-ME-Received: <xmr:S70haGqfC15txpelz-BY-AuJIZwU40EZNkX_iANp-01xujaEwry_xfHsORweRy0xscYJgAP5h6ws7K4mdB_47chZqGBLL5U1TK1xS6CtZAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefgfevtdevudefudetudfghfejgfelgeehheff
    lefggeffheeigedvgfefheeugfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesmhgr
    thhthhhivghuqdhmohihrdhfrh
X-ME-Proxy: <xmx:S70haEmIx6K2h7AXoyjbNScCILQ_JsULetMkq0M3YSCnRdPyfGNfVA>
    <xmx:S70haG1h9sDutGPnAlZQrotrx5z5shciLXVXg1psUzU8szW9t3D8VA>
    <xmx:S70haLsF0lsbbt0fYnEKKiF5aVelUG2_cIxi5uJtrRz9fuzi2pmgwg>
    <xmx:S70haCUElK7BLXoprzf_ynkQI8B0Ii7b9UdkJkPArU4P4HZKCbQgKw>
    <xmx:S70haO0SPA1bHezW5wyPgPho4BUDu_YDUFMP2E-himsFBw-chMygd7Sj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:20:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8976722c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:20:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 May 2025 11:19:59 +0200
Subject: [PATCH v3 09/11] contrib: remove "emacs" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-pks-contrib-spring-cleanup-v3-9-32e151b0bfb0@pks.im>
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

While the "emacs/" directory still exists, all of its code has been
replaced with stubs in 6d5ed4836db (git{,-blame}.el: remove old
bitrotting Emacs code, 2018-04-11). Instead, the recommendation is to
use Emacs' own vc-annotate mode.

Remove the code altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/emacs/README       | 33 ---------------------------------
 contrib/emacs/git-blame.el |  6 ------
 contrib/emacs/git.el       |  6 ------
 3 files changed, 45 deletions(-)

diff --git a/contrib/emacs/README b/contrib/emacs/README
deleted file mode 100644
index 977a16f1e33..00000000000
--- a/contrib/emacs/README
+++ /dev/null
@@ -1,33 +0,0 @@
-This directory used to contain various modules for Emacs support.
-
-These were added shortly after Git was first released. Since then
-Emacs's own support for Git got better than what was offered by these
-modes. There are also popular 3rd-party Git modes such as Magit which
-offer replacements for these.
-
-The following modules were available, and can be dug up from the Git
-history:
-
-* git.el:
-
-  Wrapper for "git status" that provided access to other git commands.
-
-  Modern alternatives to this include Magit, and VC mode that ships
-  with Emacs.
-
-* git-blame.el:
-
-  A wrapper for "git blame" written before Emacs's own vc-annotate
-  mode learned to invoke git-blame, which can be done via C-x v g.
-
-* vc-git.el:
-
-  This file used to contain the VC-mode backend for git, but it is no
-  longer distributed with git. It is now maintained as part of Emacs
-  and included in standard Emacs distributions starting from version
-  22.2.
-
-  If you have an earlier Emacs version, upgrading to Emacs 22 is
-  recommended, since the VC mode in older Emacs is not generic enough
-  to be able to support git in a reasonable manner, and no attempt has
-  been made to backport vc-git.el.
diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
deleted file mode 100644
index 6a8a2b8ff19..00000000000
--- a/contrib/emacs/git-blame.el
+++ /dev/null
@@ -1,6 +0,0 @@
-(error "git-blame.el no longer ships with git. It's recommended
-to replace its use with Emacs's own vc-annotate. See
-contrib/emacs/README in git's
-sources (https://github.com/git/git/blob/master/contrib/emacs/README)
-for more info on suggested alternatives and for why this
-happened.")
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
deleted file mode 100644
index 03f926281fb..00000000000
--- a/contrib/emacs/git.el
+++ /dev/null
@@ -1,6 +0,0 @@
-(error "git.el no longer ships with git. It's recommended to
-replace its use with Magit, or simply delete references to git.el
-in your initialization file(s). See contrib/emacs/README in git's
-sources (https://github.com/git/git/blob/master/contrib/emacs/README)
-for suggested alternatives and for why this happened. Emacs's own
-VC mode and Magit are viable alternatives.")

-- 
2.49.0.1101.gccaa498523.dirty

