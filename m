Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DC27B515
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782242; cv=none; b=DS+LWBl+XErzuL7KmeTHRr7AY/Lghs8FmawtOyg02c2sa2BqSNS4tG351zyk0RarO8FbbEIwtn4SMuhTfCqRsmT1+CRXxAm5ddQhb0kZyoqeb//yD6C7jKJtAoWJA8IpnUS9a6K7aJQa8wq3FoJTBTTfKEMWMJCHBEYPyRfGaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782242; c=relaxed/simple;
	bh=y+GjOjvizlWMDHqluITOxjt74O6/sd5ZjhnCgNE0mKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPv7UGyk/6GfsRHCRCPKUJU8PHaUr8VVGx1kn7BuikQ+1t9T5l4n8fZqNFdWU+Dlua6ghkZcftcbv3yuBSi0TiWWQGi2vI270ohS4oLWxrLrzcDu8uOrkDNS3WIa8keSZgs+lxQ5Yu5e4rqR5w/bEHFoU8r9azUkBYuRFdATdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LCpkfSf0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRjFOmed; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LCpkfSf0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRjFOmed"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E342813801C9;
	Fri,  9 May 2025 05:17:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 09 May 2025 05:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782238;
	 x=1746868638; bh=rTahKTpVwGnVgK5+38cKRH3rwsvJrrk5uGBVEZHVgcA=; b=
	LCpkfSf0knO1Rev5W1rkAQfT8UVatI+5m5QMgeXv99bxUZsm7m/jTi+9y+J2DZxa
	tnowpm6+PnbIbAbYDJO6QII524bng21iPgvdgtsuABobBmK8CsIHcwrCHwpHc8mX
	joOZE4A/sezFQbbBddqksl1w4Ej0+YKKqI0UMLcXqjT5B4McPfKik0kYWtuBx3mO
	Qj4kaskMnr0JnTq70srtm4Y5SmflOc0vrfTRCTOVYFvIYiTZ9HQ8LFHelnNDTiae
	YQuyXOEhss2PWQG6ZkYanpbud8E1x9fh2tDZ0DgKIoe2Va81N04/hZDgxxfm4FjU
	FSUW0YVsDbn8Bky54WPnqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782238; x=
	1746868638; bh=rTahKTpVwGnVgK5+38cKRH3rwsvJrrk5uGBVEZHVgcA=; b=j
	RjFOmedvYUzQ1HxtbbFXL1a2HNRlQTvQaywEIPQvQJiGWQ16AtxSzgCkg5qKR21H
	KpEATRLc44mnm/gz5DKZnBeqlJGt+ceG5O66rbRHm0IdEP4PoYmHlyzXvdPeEo2s
	DbiTn1KBfSOBVzITJ45fBOZ9Odi67Qn3S8Uf8Bd5sBzhzXKFF0EdBzDHVYk2rfEn
	XcaizbJsPCAN4yyR8dfMvDjSJd46+3Qf92MPqMYv2CjgcqX21BfF8+Vrw6wOsUim
	pu5MfrQZJO9lgq7zrnqPQl8s9VuAVL39lFHBTlCsd3a+UwOCAcrEqgK06EaZq118
	j4n0AyFmVcx7akAJrCtNg==
X-ME-Sender: <xms:HsgdaO-1b8G4a08NnNcUYON7JrMr_B4egQXtymw-UzwrGW5tiFismQ>
    <xme:HsgdaOtMT_xs7_6DHeelDFysmYHO_rj0jVj7D-EUuOo7e_pl7lIRKhXxf65zsAqXv
    zNSex3YacCjK1RJHQ>
X-ME-Received: <xmr:HsgdaEA641Y3msigwuK8aWGG9QWQ8vFxTQidnvfD2XUHLDYI9EAwbD1E8uMH0zzaLxfl0Pmz2CpLV-3fD8uHAWL-uN5LGwmoJZn7176XxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefgfevtdevudefudetudfghfejgfelgeehheff
    lefggeffheeigedvgfefheeugfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesmhgrthhthhhivghu
    qdhmohihrdhfrhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:HsgdaGe5-JyQBOigzpcI86AXEqexlAYA34KPPz1PXXavoyV_pCHjxw>
    <xmx:HsgdaDM_scVX4c8k5fzeTP0YXYklIKO8S3PZvnQYR1KxZaKoJGUa2w>
    <xmx:HsgdaAlXKmlIBxOY79mQL2fG_4ULLg1i97rTCCrgXCaiC_pJW627OA>
    <xmx:HsgdaFu2Ik5xhRVYY8-ELaH6vTGUrv-ZEn3JdeqkNv_zdWsSkZdt1w>
    <xmx:HsgdaPFFnKQjj2-8OVLMpDx93x2PalXqhJM6gFvzgEBWbpOEVygbSa8S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 879255be (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 11:17:09 +0200
Subject: [PATCH v2 09/11] contrib: remove "emacs" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-9-14e20d95ec68@pks.im>
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
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
2.49.0.1077.gc0e912fd4c.dirty

