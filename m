Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37602F3B
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743151127; cv=none; b=HV4csRgnLerC3h0GvLLF6ml9SGtwNLgntK/dG7EblP6SgL3f9qv4LXXvSaF1msNDcbx8jRLhiN3hPiGowxpOKz7ad2AfBAgnpr3o56cszmRuM0NBcQ0G1ZGqOa7jPNMEXDeap+67tHP9BzX6puX8yQtA/klLwJj1gu+VZObrlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743151127; c=relaxed/simple;
	bh=5Mu06hpIjSOFoD0Fvv6Mmgz6JA7srrOjenIZRqIxNTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i1wvg1b2DCLZVLJdslSQOqCv5xxFNeJM1hJ7xz++MTeLFOmXEDft8DjnooEgzh/yikkdqCbBm62a/Wn3vSzXxclQf5odTqSFvW2ZgUUFSNEc1wXfEG8OVVFRKXeMyRIuem1CIBZ+wbJexqyQD7NbGW2DsJyMk1xu2aeZ7noY6HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DaSmwbMO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o0j/kLmB; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DaSmwbMO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o0j/kLmB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A0062540111;
	Fri, 28 Mar 2025 04:38:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 28 Mar 2025 04:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1743151124; x=1743237524; bh=C1N6m6hNPM
	0peETgnEPnA9tPWP7Z7tB1Zl7siLtLybY=; b=DaSmwbMODLvmKRTwwS5lN/zlaO
	aRf7vcZR5Vk5EQLHt9Xdyb4RGi84x3OdyCTKldYSu5dWn1RnHiQu4GnL2aBjw0Qk
	ZYL2dwEldh++8L0gS8Qx+ovxmaxxvzktfDhFh8ZbbZ4qVeHekSdXpOL5ZsfsDPrl
	qZbNxoQjCovI0oXvU/9BLi2PxDuNu8gla7Tw3c2fKLWHbgvSeyDuZQcAbwHL4zGH
	1bpy0PfQhEjAwGXh101cbCdbhmq96mosJ12xDkGNWKGSglSKibrhUupuhL7FJSEO
	n3jkdITOK/Ly6yWx2Fhf17W9p+1fLliNt5da7bfPtoWk9zgYz7CH3EH6Zo7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743151124; x=1743237524; bh=C1N6m6hNPM0peETgnEPnA9tPWP7Z
	7tB1Zl7siLtLybY=; b=o0j/kLmB+h9Sx1FaYBt9VvP2D33np2vLXKcV+5/Fk+12
	AyS2/YhFRPXj5Rj7J7wjNPk+L+ikcuDe1YBzf3bzlFx+bFTIyDxn2Rc+VD5+707m
	wBQYpEpe+NLT5YAVWKBXuPkm3tElN8WAIOyVlOH+uiQ7P/SikLdDbw2Wd77vliSG
	XeDQ1aL0y66i0xS0IVPr24xtPSaR1Oq2PkwRxgeIFAAX9glyTCfyjHDshLqSJGJl
	r1IYvY7G0VXYAV8vkVJlxukvRi4/3M+PxNORD5yZDU5KnFDp7A5dTTtf+bKz9kW8
	LQGifY/qzd5+RD0II+AwVTXDejNDkzKmlw43hMv0Mw==
X-ME-Sender: <xms:FGDmZ3vVMVDE2GshJkOX_Uwc0G6k03tTpX6gabRxOEKlDEBrlKd9Jg>
    <xme:FGDmZ4eDXqridwPasbZiAgc5bSDVH5u90GS_8Swkp6azYKN9C5N3e2IE5oTsTFbRb
    1mYkQN_InzytBsYQw>
X-ME-Received: <xmr:FGDmZ6yiPb5FdErsAWah2hX05SVxYv6V0NaYRAomii7EL0X_yaiGZZfQGBJpWxxNfVMfmROhXV4bJdB7uPjIsQA2UlXoMpRnTWks2EhXOjL00jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueeh
    gfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtghesuggvsghirghnrdhorhhgpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    shgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnh
    htohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FGDmZ2M32MP67AxEXt34A560O6gejaNbg5Z_9sWwa0RbTtcjZ1E2PQ>
    <xmx:FGDmZ39LWspzb3XDDOsZI6k-YFdVQmQ7zrmcNpN7eYB83VCghC1fEw>
    <xmx:FGDmZ2XbQISSxLdK-GLJwOIVk-g-TXxqWLlXDIEstR_iXKyLPcY12w>
    <xmx:FGDmZ4e5c96yyGgxyTNSkm78kAZmsbLAosvt-K_NEOYpYyd-HfSG6g>
    <xmx:FGDmZ3yPe0cQUWeR6fvrjfmykdr62PmwOskw4fmUCwmSBEjiE4GoyeOB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 04:38:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c1eac9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 08:38:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] Collection of build fixes
Date: Fri, 28 Mar 2025 09:38:34 +0100
Message-Id: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAApg5mcC/x2MSQqAMAwAvyI5G6h1xa+Ih7ZGDRaVRkUQ/27xO
 AwzDwgFJoE2eSDQxcLbGiFLE3CzWSdCHiKDVrpUuW7QFrgvgm7zntyB9mQ/4Mg3CdrSVI5UU9l
 aQxzsgX4R+65/3w8wlC64bAAAAA==
X-Change-ID: 20250328-b4-pks-collect-build-fixes-b5a6ce086b72
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Hi,

this small patch series collects various different smallish fixes for
issues with the build systems. The intent here is to bundle all of them
into a single series to make it a bit easier for Junio to keep track of
them.

More specifically, this series:

  - Fixes an issue with handling "-Dcurl=auto" that I spotted recently.

  - Replaces Sam's "sj/meson-test-environ-fix" [1] with an alternative
    solution. The branch is currently in "seen".

  - Picks up Eli's patch from [2] to fix building docs when all optional
    Perl features have been disabled. The fix has not yet been picked up
    by Junio.

  - Picks up and massages Thorsten's patch from [3] to fix generation of
    "gitweb.js". The fix has not yet been picked up by Junio.

Please let me know if any of you are unhappy with the way I have given
credit. I'm totally happy to change authorship or adjust trailers.

Thanks!

Patrick

[1]: <310a34bace801d288e369c6a01a8d04ffc4c3c06.1741975367.git.sam@gentoo.org>
[2]: <20250316060605.166364-1-eschwartz@gentoo.org>
[3]: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>

---
Eli Schwartz (1):
      meson: require Perl when building docs

Patrick Steinhardt (3):
      meson: fix handling of '-Dcurl=auto'
      gitweb: fix generation of "gitweb.js"
      meson: respect 'tests' build option in contrib

 contrib/credential/netrc/meson.build | 22 ++++++++++++----------
 contrib/subtree/meson.build          | 20 +++++++++++---------
 gitweb/Makefile                      |  2 +-
 meson.build                          |  4 ++--
 4 files changed, 26 insertions(+), 22 deletions(-)


---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250328-b4-pks-collect-build-fixes-b5a6ce086b72

