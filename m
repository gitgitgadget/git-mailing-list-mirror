Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C11A0B06
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485795; cv=none; b=HePIcNzOV7tpq16vd1oWU4pcWfbN38Xv4Zuf6woXXSwI3fnKUy5TSnNyI9Bfuo8gFjIssC1mjDeNSSOQR4HO/valNVOBheUb5EqgDxivnAw1F3WjAm1p+GoeBOaEE1zMuBw1RSDy0ulozbjq+afTVaW8ybWBrvVwVUaSOa1TvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485795; c=relaxed/simple;
	bh=FIU6hs/7BWhk3WVAj7yqlxmTbbCbqvKNlEvvZ8Xwzzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/1HQ3syizLHWeSkTX1g0lDkbP6YutWcQASuGVNfmhSNrJo/Oz2dpeqGiaHjGNv7fmikDmMpELk+vdglkoKwANJHhaQ2GekjkqmvBF+FP1bFFfF87T1yC0I1lOAaCx2oubkMrsanRljZPELyt7cU05S/qjIUlklXc4NQ470my3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hpf+zMbf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WpfSVRHq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hpf+zMbf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WpfSVRHq"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CE0F1140147;
	Wed,  9 Oct 2024 10:56:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 09 Oct 2024 10:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485793; x=1728572193; bh=khpVWHkxvO
	utWAYBmfmq/uTvD1WiaW8XVFJ9mTz+fTc=; b=hpf+zMbfummRMDVr+dg8+wbAq6
	Apc+lFaCF5RJAhmfx7qwBkb95O6i6crKZjl1iTOILRgrnATyUn+AbcNixKZrA/L8
	rCbb6u7vzKpyiy4FUea8p+hFh8dlrEqli5hCGbtukGIPk9c608jsEEWUcprR0u5F
	/kg0UIgFZCtHUt4Llv1YMfxjQj/dSn0dnukdDaeuz7QKOZ/q6XP2RuiMRJhdTiTs
	Rdf+Q/y12iH1yRdWQQn5hLDeDO+epp5qpmZJQW3eDLfDZeVetZL+K9UT5QAMYDQv
	dE747bWOs9A2ats4W2ZF/HJeHeOjdXoEwVRKrm7i2j5NObW+OnncAlUL6I/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485793; x=1728572193; bh=khpVWHkxvOutWAYBmfmq/uTvD1Wi
	aW8XVFJ9mTz+fTc=; b=WpfSVRHqZj35GIzgqySm4+2Ff95fuYVfl4mk8ZlS8tY0
	u8nE04hMxRv7jgXitqCI/6bqYYNMt0ct4YdUhohOpYSnv6y5eHTAooxTGFqRY76U
	LVNM3WdYDWGuNwpxfk+TBpTvszXgTs2AEH9vW6PW949hQAioDiYYGNX35GwN1xEw
	BPrxDy98SMFAi1U633XtdqZ3pyvWmLm0CE12kKfstp9gmgDS0YwdqH8BvhoL5Qv1
	MuUp7VbM5SLvU7SHTQnM5rw3oKZtPensO+/fOt5ZR0Xpoxibzr4Cb0AtiOMrOOqZ
	HK64z4U8lZqPJApGJOGCXi65NtMH1HxSdszScFtpcA==
X-ME-Sender: <xms:oZkGZ41gsZ2vyFsk18m9n4mN_aBWMtOf7l_TMqQLPgfjNG5yZmpGsw>
    <xme:oZkGZzHmNhGEtheU37qvM-HdUxB8je2iBIRrk80tar2t2IolqsB_X5J0fOpvPmHjd
    7_sNtl3TxC_MiIvoQ>
X-ME-Received: <xmr:oZkGZw5hvFFi7sHHSDpICHB8y_AY24UbLbp-DMxaukbHiwU7a8rg9CJHi9nYQSf6dEvHW0CojVaKqBoXKxa2baspYgh4RyJ0jxXiqzDVLsA6Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oZkGZx1TM-61au1BgTPGzn6Cn97XoJZol0BpmxVg0dtLvdEUzI-b8A>
    <xmx:oZkGZ7E1homUYc2k-puylrt0HWuGTXBqWkEd0u3RMY4EeDYomafKBQ>
    <xmx:oZkGZ69-dKDIbq-v86peBUCWwiQRJ5LqhAPBvw15ouNFI2ybq4se5w>
    <xmx:oZkGZwm8XPncixy9v3Z4kDx0l3sce52uEwCVMrGJjxI9riTBirnR0w>
    <xmx:oZkGZ8PpSctiLH06TeenTUKJ9k9SLOMct44-w3BfDx8zkK_m_oPpEJz9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e24731ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:29 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 08/24] t7300: work around platform-specific behaviour
 with long paths on MinGW
Message-ID: <48ce19d876f23bfc4e8601c1bcfe69ef7da407c7.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

Windows by default has a restriction in place to only allow paths up to
260 characters. This restriction can nowadays be lifted by setting a
registry key, but is still active by default.

In t7300 we have one test that exercises the behaviour of git-clean(1)
with such long paths. Interestingly enough, this test fails on my system
that uses Windows 10 with mingw-w64 installed via MSYS2: instead of
observing ENAMETOOLONG, we observe ENOENT. This behaviour is consistent
across multiple different environments I have tried.

I cannot say why exactly we observe a different error here, but I would
not be surprised if this was either dependent on the Windows version,
the version of MinGW, the current working directory of Git or any kind
of combination of these.

Work around the issue by handling both errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7300-clean.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0aae0dee670..12ab25296b0 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -747,7 +747,7 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_must_fail git clean -xdf 2>.git/err &&
 	# grepping for a strerror string is unportable but it is OK here with
 	# MINGW prereq
-	test_grep "too long" .git/err
+	test_grep -e "too long" -e "No such file or directory" .git/err
 '
 
 test_expect_success 'clean untracked paths by pathspec' '
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

