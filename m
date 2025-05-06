Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B40283121
	for <git@vger.kernel.org>; Tue,  6 May 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540771; cv=none; b=IYAEz4QnxOf2x6PPMpLHeK+/29w4Abjo1A7pfU7nk8wzBWa74CQMTsiwDZBwEDmALmXkCWXIzefXinICNHyGGKE2nkin0yMyxql9FgoB3Oox2dH8dQ32YrW0Oe5kx4swwLju+5z07BRkjBoi2y9ZbpjoJHXeeEcVvehh4Pzv8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540771; c=relaxed/simple;
	bh=J7N6s+OHIGmxHm+5MwY3z0VpZ9d7HDxMHqv1TgBKuTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkXHa32eW/yTUw4mO+gZ5Er6O1V5Tje8k8tS9vXzeHlsbrE0EBEp+ej+NEA6JNjSZLzZv+oGBi/rp2kWEPaPrIg+AUIS4XpS8TPTG/RT+SNDSxaunUoYdqilVT9SztikvfmNaVitUrJAlnrnN6NBzzGYGyboEeLVLPLOkYs0E3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IYFjx0GO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dC5gRcTU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IYFjx0GO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dC5gRcTU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2112A13801E4
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:12:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 10:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746540769;
	 x=1746627169; bh=1GN3qxlep1p1NLN8NSHDoOMgYy859ny920ML2v42VRI=; b=
	IYFjx0GOtT/M0kO3FZxXoE1wnKQ0fIPjGPlzVtI00vP/czjK9Nat/3feybDGFZJk
	Gc7zB4OqPCfjVCpNqxtuDC8jzn/mF864KpiKc6erV5aFAqS7WSCCnjdg2L8+95bo
	vVbT6FmOvQSWS4CtDdSzui+UtICqzfyS8vLZtuPbrC2gPm0Uul+hL3otKSAjbLsD
	wYIKAfzO77KTwe14laAtG0NqQ3INRaXezMjSYmVocMACONHi+HbTRnNuVH+BToSo
	hRFcebm6JilOcgtHStdeUCsBhaHYMY9ZHjlAtXTFUmP686JjoReBIJ/SnYyq69tM
	zqOnl8qreeTGj7WNdcx/xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746540769; x=
	1746627169; bh=1GN3qxlep1p1NLN8NSHDoOMgYy859ny920ML2v42VRI=; b=d
	C5gRcTUIMiyPMS9qWruVT3hL1PsmtaoJ2xMidk1woEB481cQ3YbhLY47nbXnPAwt
	/JVXS1NmG2v6HKQZyrXQk9XXsExrgHQQU8ymKOlEYEdBn8W9foN0G8t4E9iqn40m
	PP6Q/MDvUndKeGeGkoUixhrQvkBMkuYWtT5KgtJU/u15olaj+Nn+pId0ix6iNQuF
	jB4xzBSCGPA43Ta4NUjAu8CaSaI0MVFdrSSBsoNVKMNScG5o08Pf5Pv8/kUGQL2/
	aQ7oberADbQXctj7B00Ksz1l0k5mLthqP156pSXBf2nzNLsbiBwgZHtY+Q5wp133
	kSp6Obbg4CO1xvpdezwHw==
X-ME-Sender: <xms:4BgaaNZdn56VRG9fsJcI07hqL8Q9shNVKIoJAf-EYAsVUBLmqkN_Fw>
    <xme:4BgaaEZUZxVyGZOcDAZfAxvMw7FkXPvA-4RljHw4TTNwQeFPLdXWHPb-IC-efrGMi
    RxggK4djl5YyuOUiQ>
X-ME-Received: <xmr:4BgaaP8dnk6CWwVTEQUsZE2VPUiz5Dl3rivgSL1eH3Rs0IkmusxB3z-ezFFfPYnXO9GfdA6aKbtmUYusPLigx8x6WQI7jZhOKjSLjlCe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlh
    ihqddqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefoseht
    jeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpsh
    esphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefgfevtdevudefudetudfghfejgfel
    geehhefflefggeffheeigedvgfefheeugfenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4BgaaLpLPZY7383sI-rAfZJL4tRpsYZwVHaAlRSwfbX7cAaqDnCrzA>
    <xmx:4BgaaIoe3mFizsp1Z6V75KAnyHTW4Ra6JW0SgkokmW45UzfWoEp5dA>
    <xmx:4BgaaBSZIY-FedPTXxj3ndMhAX5SzXlOSx84HFMXQED0PZpujk62Nw>
    <xmx:4BgaaAq34wl9GEZNxOphK3GX04Jw8cXWe8SsQxK8x4U7LyzBmrt6MQ>
    <xmx:4RgaaP3OhM2-NFpkpbashmvP1K7yeuzmniV2jsY1siej8uqm23BCVEUh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 10:12:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7917a63 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 14:12:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 16:12:42 +0200
Subject: [PATCH 09/10] contrib: remove "emacs" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-contrib-spring-cleanup-v1-9-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.49.0.1045.g170613ef41.dirty

