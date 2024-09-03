Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522D1A3AA9
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354894; cv=none; b=A1psFEt3eHRauo6x1EARnhILZDvqddFIKdnOEsKFseOE3VhDFadUN7B8rHyLk6NF00BqOWEgZ7KB7tItrlSwyxFRPIGI7KuYSMBP2Xy3o1dzadVPmlsEVtWf9dzpL+4g2oxP/gtNDoKPx4xBwOzr+S9jwL3RQ3S2Az1BYcyWnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354894; c=relaxed/simple;
	bh=eB4UC0bgdMASHojoF191UVs+lqf7Rf6MI20f9mr6sAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlomXu8bap8rG4+0jk9dRwcE7x6O8l/PIyvggldlf854zVbXIrEWsmzNmoV90frQAX3o9DR4FPVRVqdvPMwNjT3DbnpjZclJqY+B6Ccvs5gWqPPqqb0HmE2YFU9DjJt2+s7W3AZr/YfrOIl7hrlt2eeFHG+7kDUE7aQKOGul6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=og7nQkNQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCQLlYi4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="og7nQkNQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCQLlYi4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C7FE138038C;
	Tue,  3 Sep 2024 05:14:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Sep 2024 05:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354892; x=1725441292; bh=QPyjDuWhrm
	km+ZsnKWZD+9wcElTU2nl+IcjDBLgAKRk=; b=og7nQkNQZouq2AcJCb/o99gb7f
	cP+MEF/acXBDsu7v7qjOpi68NwdaXFbrZwO3RwYe6Jt+1682boC99aDW24RLUdaX
	gbX7KC+ja+orVoSfzbeYm88RhoJAxYHolrqeCl2W7r3WrvgB1UxFlwDwsbdAu0Sm
	sLIo4k9dnKkPVYdi4B8q5xlP+GxeVMDlciSD2BueA9xGUUK6TnB6UcUaG/jDcR4v
	tEcpM9kfwryOXdVFE497xF99lysfgXnMMm9hXUQUu4ZyeOs/mmDjH9a79pwW7jnX
	XL4WIb1wHnTTXIM9vmBGt4+Zf3gIFc+TXa9RXNZY6z0bfBQRRNy+jgZNVQ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354892; x=1725441292; bh=QPyjDuWhrmkm+ZsnKWZD+9wcElTU
	2nl+IcjDBLgAKRk=; b=iCQLlYi4I6DfHnCt9ZDFZZQKm/WWl4Fm1z2iqC8ASwmj
	weXC66ZY4t/9JHxO6Gy65F6Nc3qXLkOXKNxopl2KOL85JN9GqCH+0hZZaXy0DRdx
	yPYnRpZOUWiilXs3/+VdPtzBLnFmdCOGcldt9XHlkrJX5ZPnCsj5WLShSpBCMJds
	x1sepQiLqjDLgKl8+ainO5bvzizLPl9hhEDYedo9w3OO6Fj4zaEVCLnwWoLc1KuA
	KwmXjHbUIaT90W8LnM7sNWgm1yAYpp6yboelCxAX0yFLm5YgX4i30bHLjQ70sPe7
	gF3EcOHkd9WImm7mp24XfkpyuMq5VxoBTItTgn6I8w==
X-ME-Sender: <xms:i9PWZmF-bcpK2NOJnR_5aDUiUTLSi4Gw_CPzSj218bQhSbL55b8wvQ>
    <xme:i9PWZnURjHeE0sKVcxRs0szj5jWui7sGDirt_7v8btsyj3XXag1lumZT6_6h3vE2p
    J-S4PotzwT4BpaBIQ>
X-ME-Received: <xmr:i9PWZgLljkMcF8FeX-_-AQiN-mFbeB4BILsPC4P_eMhzG6tW_ukdvYRE42PdzuqSNoiYWEX-xMLZgUsUgd6U_yeECNnF1IS0gggH9WJ4jlaa0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehsph
    gvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegv
    ugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:i9PWZgG6UkQspZ5Ob2w3TeKyKnVaudJL0aGsAum77M2UZMGOha-DCg>
    <xmx:i9PWZsXchf1YhLClBLTRhyHpvGFy9hspLYkYHhSu79EFlGoTJkcnnQ>
    <xmx:i9PWZjOa2hIRN2CFO66yp3oO_QxQlAjpvQvFXzM9OjxCiNfCFL-Ztw>
    <xmx:i9PWZj0LP0GjgZjhqMCbhiMzRi4CxeQU19TULgitfRm9cxwEpp8NbA>
    <xmx:jNPWZgRd_sMZCT5yTtmkDGuguKbvZc0Y2tiXEYik0gwmDbuN3LyyLZdp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:14:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6751d2e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:43 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:14:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 05/14] clar(win32): avoid compile error due to unused
 `fs_copy()`
Message-ID: <0b8a6ac5fedf95e3d5328bf1fef75710e26ee3c3.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

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
2.46.0.421.g159f2d50e7.dirty

