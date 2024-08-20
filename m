Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C531917CC
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162551; cv=none; b=Yrn+8w7M7Rtyughj/FOrTrvzCrkGQTZB4wl/Jx1/N1wQtMc4g5AFNV9EsSsvQ3i6sNjzAlP6pR1bYYaOhFmw32EJvAaQTEA75BTLaq985LCtHZTaJMQcLhAaNYQgd5qB3cGUrx81Ph/G5dBsGkDIfM3jNVeLUnKRRe/BYPocs5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162551; c=relaxed/simple;
	bh=bFsHUm29ptRRahQgZw2GHCO3E6tIsOZh7+xMUbiI0fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDgMNXlmg/0KKDiqAjZk2yiF0hueuFZp9a2u0zwnVwzmx8VoYMC4BW5y7RP1gKmd9hT/AmQ/vPm93E7gZvMsDGTGcEVfyy+HQ5l3d+lZs6wjfx+HoE+B1GbW+HYfbK6PTAedsiIDF6iNzz/7WnehlilfWfQerFf/4mfVZzwGeAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D2RAordZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qI7Kjq4l; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D2RAordZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qI7Kjq4l"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E2323138CCB5;
	Tue, 20 Aug 2024 10:02:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162548; x=1724248948; bh=TmvRvI5gTH
	6oJ7J7mN4J0XgeGKC+wk3uk2brYymumTg=; b=D2RAordZwVb+uvDvW15yc/P7y/
	pYN8I9TYPfAeprAwMOuzweTKqOJkKwNXLPNquNlfPCEcUHw5+RJYzhGSP1BAj/+T
	//maWMtN3A5Oxmst+o0HgVRq0QDbMxM++uWSrEUOA5UNC0Dqc1w8FfTG4F6XahYj
	O9tn8aDKxhdgStfXBD+N+MWn1B6CNmdnINkMbpIGfOi0LQcfx8JRegPBGN/ThjwN
	ESMR1rrc6ViPc73497cwkIJorE8OekEuO2OHqv8F4W7V5MKIJW0iA5BherK0hq8a
	8pAIfry2fevprYl3li7/tT2rBUSUCrp64DJGy7CFLPE9MvNczWsx4tCtmUdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162548; x=1724248948; bh=TmvRvI5gTH6oJ7J7mN4J0XgeGKC+
	wk3uk2brYymumTg=; b=qI7Kjq4lYqLP35yJDEr06wr9rr+42POE5MHoIqk6hab6
	6Q3LPxvCa+jsdV2kU+Ul/TRct4+VtgabTiT4JdDbG7hFDX+PPlHRi1c5PAYo8coj
	P/HmRebgWCyzZDcaoTsbfA6jpdY2LHbII6fd8PSyY4nRRBtyCsIYiRnF5OsVdSSk
	Fx92adSeeYkQ4hp0twMuFqXfTk1T53CmwgcCXanVbRu8g9ij5c9PprX/S07bPflg
	r3Fsi4tgxDwfmJCEj7e8hqhELK/HeKZKtzLRXxHMOl9POGgAfp/JEXcLXMuP4MSh
	3r+tFMrq+iDfB0rt/ivFCdkhWtkl+7VvPeW5CJ5TKw==
X-ME-Sender: <xms:9KHEZpDpDFoR_KSLCGqLZA0PFHWIGCJOOjVXwkjt_mwrUFwEl04sgQ>
    <xme:9KHEZnjuDGqZnIa1sC4mxKBTdXQ5QnT2FVmkTtkTngXTkG715_9kqauoeUCXoHB17
    WJoeEBjN1TDxdWoiA>
X-ME-Received: <xmr:9KHEZkmxwaPOhDm6E9YOKXKIWBg-B0aGWaad0hSxeIIWYlxg7EaT0e_g1skDNtuHxKtjnaRkx0SvkraD-ZLYck6nozu9XbvQoX3KbYieT8gut2JfLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepsh
    hpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthho
    pegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9KHEZjx-78AGzLrZf5q1ZBFx3WQApXh0QS5J4eOF9T1QyEvFGP_9zg>
    <xmx:9KHEZuRr9vQYweWku76BDrA-S5CFBirV0ggO3FtY5E9dnNhBgSgHbQ>
    <xmx:9KHEZmZk8WBeSG34e27l0Txghh7UcBTMqBDhpeTOZIy3Kvi1Gaqk3A>
    <xmx:9KHEZvT0oJtqKMu0zbD-RPW_aPVXRD7D_24B-2dWaSBwwUS_y_q7fw>
    <xmx:9KHEZv-lEKzIrjmHv4is36Vig0NQFFpUPOtQ7x19GI8nnPiZaOAHy7L6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd831209 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:01:55 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 05/13] clar(win32): avoid compile error due to unused
 `fs_copy()`
Message-ID: <f88b3421a095ba43d9fe2609f45eae4a0d44ad0e.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When CLAR_FIXTURE_PATH is unset, the `fs_copy()` function seems not to
be used. But it is declared as `static`, and GCC does not like that,
complaining that it should not be declared/defined to begin with.

We could mark this function as (potentially) unused by following the
`MAYBE_UNUSED` pattern from Git's `git-compat-util.h`. However, this is
a GCC-only construct that is not understood by Visual C. Besides, `clar`
does not use that pattern at all.

Instead, let's use the `((void)SYMBOL);` pattern that `clar` already
uses elsewhere; This avoids the compile error by sorta kinda make the
function used after a fashion.

Note: GCC 14.x (which Git for Windows' SDK already uses) is able to
figure out that this function is unused even though there are recursive
calls between `fs_copy()` and `fs_copydir_helper()`; Earlier GCC
versions do not detect that, and therefore the issue has been hidden
from the regular Linux CI builds (where GCC 14.x is not yet used). That
is the reason why this change is only made in the Windows-specific
portion of `t/unit-tests/clar/clar/fs.h`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/unit-tests/clar/clar/fs.h b/t/unit-tests/clar/clar/fs.h
index 3e39890bd3e..8b206179fc4 100644
--- a/t/unit-tests/clar/clar/fs.h
+++ b/t/unit-tests/clar/clar/fs.h
@@ -297,6 +297,8 @@ cl_fs_cleanup(void)
 {
 #ifdef CLAR_FIXTURE_PATH
 	fs_rm(fixture_path(_clar_path, "*"));
+#else
+	((void)fs_copy); /* unused */
 #endif
 }
 
-- 
2.46.0.164.g477ce5ccd6.dirty

