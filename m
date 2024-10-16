Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E511D1E7A
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066399; cv=none; b=YvHHJ1XGx6gqqh7Tg0K8Iif07h27P8a9SoPtZTlW/25xuLDZdzO/OMWAGb0GzBCLXNjcmhqa10q3UTPMbWAJr97zJDqvJZeBk/TK6xh+UMWYwaly7sIMIoQlRRML9jUyAAZAPayEAAND7C6gYfQY1CBxhD0wM6NrYSwo0oeY3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066399; c=relaxed/simple;
	bh=by8igO0q7de+8Pr4v/o3o+r6WtjlLD0Y7USo0Ulpkbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+ctIBeKfl20io9feMyL0YLUHtepwEYxegJ880f9ovwcVGqdg3X7T7nm6DNoqmqCh4mHwrqe9dKqQcZyOAzImI48BJY17mbukV2JSFe/+ieoHoPoRX//goHHa+r8JyaS/erE33lidkua3yjOEk6VPRaZJznfhCaTiDbL8hEDAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bo044EVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvtFw9T6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bo044EVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvtFw9T6"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 859DB13800F9;
	Wed, 16 Oct 2024 04:13:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 16 Oct 2024 04:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066395; x=1729152795; bh=ptVDxD4kjQ
	9TY5IlxMJteqiioPQyfYws8mLwL4HXbUY=; b=bo044EVKdmi8pcWKbOF+G4ph96
	lcQeUvXkI2PZtgSlCokrIYtV0+y6lTLG4h680GgWkQ2yOTp4kQ47kK3BPWMltXus
	BGwEop1VZf5pzKVLF8/vUgA8YMiscuQxZEgZ1l7zAmWAGNydeegXeeaww8huAWoT
	VV8nUaVXAPJJaVhKtRqM68N8BvAcROguoPnRhYrGPzQjn4vDcYtWLqvID6tXm9Dn
	mrqsTgv8YtfPXwLZmaZei+3tBE4poRCoNniqmvdxclOIogCHWQotBvp4LTDA8/jk
	I/om228dxIlDHgpblbO6uLg1G/EkqjX1cVJ9GwC+T+48jmt/72Fqco60NoFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066395; x=1729152795; bh=ptVDxD4kjQ9TY5IlxMJteqiioPQy
	fYws8mLwL4HXbUY=; b=HvtFw9T6/HXQemHa7OQG/u/BUxpNr+ASkJ9e4xOZSd1y
	LpqEht4mTu9IC+trkoojF4Q1yiER31FmYsFQdBzNT9i8MXTP5DFLWmZ5o4LF67qP
	OzP9sdi2NpNFrCf0F8zq/LN7QomLZROp/AyUp9JLpL4YOke1XgxXfXg3YN9G2qX/
	XUFev8yb+mJDqcsx44wK8qybpKaoMGXsatBtb3Qt1iAeYWterUfitNlGbiUFwDg3
	J4zybKO+ObHX/XDbmWqmn/WPMMFksfeOoqwVPCyzBJLpRxJuVb+0K1HjRtYNCpWV
	HnMLZb6hKot6qDVFKXSGU3vmX0MG5y333oxif3b70g==
X-ME-Sender: <xms:m3UPZ-yO7zrvqDKLePUqHZNRk6MwwMa0vBti4Obt0D8GIOC4Md6s1A>
    <xme:m3UPZ6T-7QNaeRFEP1juqHXC8utodMemP9nUVfm8FoIzI-cwdilgc-FmNKSz44hEI
    wbf3jd3CGBAWF283g>
X-ME-Received: <xmr:m3UPZwUcrW3MIKZfAFozenLkD9fj5xRB3jEFNFtnoegUqfsB4Z4S358pRebSS1ukpk-qtJ5oLGQxJr_dYlklGXg6f-ED5r4mY0u4uRxfRdFBWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:m3UPZ0jYYKmmGqpnIseFhUXYYqOWlwCtHVBZYCRKS45CLIVzmAsgMQ>
    <xmx:m3UPZwCLMC_UyXig9OkzDd-MsjkqN6MqWQ3jJ4HWMqsgsaPg0s2oAA>
    <xmx:m3UPZ1LLc1kZGzPPAUpukkXN7JBVubzAaGD1ZdNJ_MSHYXZZgUFz1Q>
    <xmx:m3UPZ3DPLh2WP4-OwJa3uK4dEttRxe3-L3ljZ39nscZvbRYvjgqlXw>
    <xmx:m3UPZzOJt6mahvH5-FP-svGyUZ0iK_ULDBBthn_-K9e9-pKDNIxIsxBd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:13:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ad8d2f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:11:57 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:13:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/10] t7300: work around platform-specific behaviour with
 long paths on MinGW
Message-ID: <ee67336621c9792352b71cecc72e97ad68e094d2.1729060405.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729060405.git.ps@pks.im>

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
2.47.0.72.gef8ce8f3d4.dirty

