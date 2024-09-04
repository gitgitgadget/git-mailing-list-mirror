Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D31DB949
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459422; cv=none; b=oy2K8KVTsAaQLXZD2u6ZpUpm9rKc73g5NYfrhhxMQnqSBgWDr6uXC4hF1esll7INTlMh0Vmzwx5OGpmAxlotHOeyIXDF4OsKtvb+e1Kykv7zGkSMrFAmlUYb7HYfgNZ7h8neBRm62HP3BtnPXC6n538b3soMpFlbSMwqtE7I5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459422; c=relaxed/simple;
	bh=h/uniCf6fEZAwW2Xl8i/bwZRZoJ1B9IlJgkQCEfhsEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsVnDLMGJsd4y8XKHcTRhHW2S7gpcTubrPyxk3+jAUVN7SrPpoyJRPxvyJkClJI6jPjeG9TDojGp+SaTj51fbOb/n0hH1VCd2RWMFCX+giFKoWX2pdi1/5W+yS7BFlC8psjyEJnOC8MTg+1dz0GRnkPFu2CSLlGlqLXfy5I/ytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J+xWHyQy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iw9R1aWe; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+xWHyQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iw9R1aWe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D9651380255;
	Wed,  4 Sep 2024 10:17:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Sep 2024 10:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459420; x=1725545820; bh=/eIlmLscTE
	fSRdv4SLHfn6GkCXwtdMq4SxEZuKjnQ6A=; b=J+xWHyQymLZfUXGpdh44KSiXxy
	qX7G74rRdugaOSyiml8QrSWVPtguxmjy1+7CA4FrrkUNrgwGAniVhG3X8g0D7u3k
	sz6m6QVWqYyHsF6XExCuMzfWxdSEPInS19PGXG6XYD9BS/7i2DdUnVfMRK5lkLa4
	NhAaqenD6PyD3e9wuCYByZohNlzRFTGLla7imy5VSBTvtguzxg3OkmkNJCDAdw7N
	lgz4NkwSsXeqyNtBEptNjtt7ET2lBU8SyWkM6L6GDWyVR5/7N8SL/MwDNhbQD3sZ
	iDy2SBoL2n0Cw/t0fIRuu4DPcaxMo+DwzbemzvdSoFKpjSe2PmRnQRC4Rqlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459420; x=1725545820; bh=/eIlmLscTEfSRdv4SLHfn6GkCXwt
	dMq4SxEZuKjnQ6A=; b=iw9R1aWeodY0gBtoEdZ8ik00+fwqnIUQBXz907k65fes
	PVryfv50rllRdE6/aS+UkTRzkaVKqA9kRMeHULjMO6EJigeO0rT2buzNcJ0aJa1P
	izn6ihoO2YLaED+0DHTgGZLqRrasg+2wXu3nNpEXRae2auTu8cXSH43Sjzy6TCP6
	jaRWlLv1xJ/TS+o/tUlY+602Nq00cCRAfqRZ6K1NDVQBbtPRyoKpvKI8QUkK7vU9
	t49M/JSkD6iTh59vA6oCo7AdKLBM9CoF6gVWlLUR38IAzEwNxQItPO4SPxuibyib
	3NgF6bC8RyZmc1ACp2YVGFA/Thulg655U7PQl/BVig==
X-ME-Sender: <xms:3GvYZq38IqjaQYJN7TqaUASWZ2M4tpgvIhsmBMF_2k6UqprAIOWVIg>
    <xme:3GvYZtEfW0MFMfHLEVT6FHAY7RaH5xZ8SwbDOAMREJBB11msymKByqoDlKY6iFYAW
    CHhr98L7sHaq8iymQ>
X-ME-Received: <xmr:3GvYZi6qbhaJWzsEZeoLTbuvIc-2RoyBAFbshbjtpYaayt5yjegDxVWGlwq6xQEd3eegJFgfwAMcGm1lRWNrXRcjTFd1D0_fA2z35Q9jn3V-gZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvg
    hthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheprhhssg
    gvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:3GvYZr01TwVuIB3r-KRL_KcE25-cVJPEY8BNreWchO6Xlr63T8yU_Q>
    <xmx:3GvYZtFzgRkp2Mts1niPnLiYnEY0G6Nk1pAqTI9GKs2TfSH8YUZdlg>
    <xmx:3GvYZk-yvq1abx8h_4cJHEYeeWZvELKh25jbgbgzAfIjKgXKONKQIg>
    <xmx:3GvYZil31qO-YCLOFcBK4RnfYNRFlUrHrmEcHnoIwhdDeOGRtUDlig>
    <xmx:3GvYZsA_QU5wg_kttTCb4geKJkDtP5ta9sPktSqycQc5KAFJFjZuCuPR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:16:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2fc3c2e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:16:49 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:16:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 05/14] clar(win32): avoid compile error due to unused
 `fs_copy()`
Message-ID: <0b8a6ac5fedf95e3d5328bf1fef75710e26ee3c3.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

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
2.46.0.519.g2e7b89e038.dirty

