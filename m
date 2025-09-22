Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BC309EF2
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546387; cv=none; b=AbZacJ224xecDsqx2t0R30ObhKkrS+Wz118wE3tU3qdR4HPwHcxBWD64eIh9poGXrfVVeBp5tI38NCmFsJHiW0pZxYo43F6gUw48WXTNL1NrKKFq+vtAcJCQghyfTF8vB+/R+3GX5QF3KO4JygPofVCGIDbACuyiaV3JakfY4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546387; c=relaxed/simple;
	bh=RLUZDEdA+MpuyIfJV4MNJlDTpyj/zSyTr09e99CZ01I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=B+94EhfeWXsOIi/2EmVIaZrhjhwk2+xNkuG8eLmwcOKWBET3V3Ai07n5Q4RwtcuEC2AZIamRXVbGxZ1yFLDqPVXPE9d5IH+NW9EybfP2qp7f6Yv/1eEqZrJmg/xTULitx7zGe/ZWhwQuNuEE5orWEGPjTJsdR2cBvZeiEWSNuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UrU09nYU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=covpv7Cc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UrU09nYU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="covpv7Cc"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 603F41D000B8;
	Mon, 22 Sep 2025 09:06:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 22 Sep 2025 09:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758546384;
	 x=1758632784; bh=dKYQbDwr7cCrkbGaYPXRudc61MCgkBaSgujwG/Nd4JU=; b=
	UrU09nYUf0hWIWpVd8m7qVbb6zWY0Cwa9cpVpG4YFbkyhf9s1BYtwZw4hmGpzWZV
	ONA91hslXJ6n03nLjPOUNMGaVG5RMCfKLEIxVFOezZ2Elie/RXE2Z/IQEpJ6ljoE
	Kg+WMOd1nJfXtCvLUEzYTJ1LAtC+FzaU6WERQUlmSGJQ0DWAsWBNcftOx9aMfTpR
	n/SyZdpqp5z9/ryyCEnGKVkHV+h8haPyM3E21hJtBMhefg0HzmgqVqIic0nSRDmB
	h6aB3KBaFTpQNSMRr8Mki4FU4p1/HHM2xdgkidrCgBEeJJDEauuHVoDD9hYg9F4K
	F3FWi/789STgqQ5KosHK2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758546384; x=
	1758632784; bh=dKYQbDwr7cCrkbGaYPXRudc61MCgkBaSgujwG/Nd4JU=; b=c
	ovpv7CcjrXWe1y9fNwpGCllE1imQyxEmeSx+ws34KLnkFvXR4pzxt/58YLVmGN4m
	wJawoQ18ro3p8yAmgTjxkLZXjxSi7drSLGmBWyYdirQbPHtEDbUtsnAOhIM3IwvM
	jkrvM42evrpof9iFUboXh/pIMRat5uMz5ZFxzLaE0ro5FbAMos7CreCJJtM31ph/
	mvKs03r0TOP/Dm8fSo4EKjoz3Qx+e/MmAN3F+0jLrLJpLk57FBfjdk96nu2SBsXq
	sKBTFRwJ0w6J/kwtNup6iL5C6DcgRkvmkGqAYi9ww08wi6SIrYrLw/TzfKQvYAAJ
	jGV5PzgkkGGdXxpKUwb4Q==
X-ME-Sender: <xms:0EnRaO9XoausdbrdM0Ianp6YQWGT1GZL6IQeYkenQ_wlkFiMWccDzg>
    <xme:0EnRaJQ48cilgsJvIZ3D5Soh0oOu5NYKaSesp77ZTBkYX57zEY4O2EcUl-gFfRlmv
    y1uvhRGkg4B024K6g>
X-ME-Received: <xmr:0EnRaAkdGqEg0RU4nf0YXMv4i7FGLrzxIFAT8jqajOcQCi9KTIzIUVNil9Gfbu2JWQkfCFtauPOEF2-OPBaDLKCL1jJTsHmC9PEzqHMdiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0EnRaJSowU2fS7qG9JlV1BYSaaCUNJikBSHCVtiCZR2-0pzDMfQWPg>
    <xmx:0EnRaOMM8CdYIr_GY7h_PGuH7h-hKQcF8aU2FFM1-r9tvflNoQ5MwA>
    <xmx:0EnRaCWC-O9bFfjz_n15mxkk3ZGXP80hyy-W79Jct0GrQJEk_7gLsA>
    <xmx:0EnRaFeOBZ39g3iNvGa8w1OGpgBAcXSAn7rFRj54daQRtqNxd3AFbg>
    <xmx:0EnRaOpvRmhkWG2jo0uUQSgNBaoGSTS98tmX2tNsYM-a6g6myxGif0BR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:06:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8aa1864e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:06:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/5] builtin/config: bug fixes for "get" subcommand with
 "--type=color"
Date: Mon, 22 Sep 2025 15:06:17 +0200
Message-Id: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMlJ0WgC/33NTQ6CMBAF4KuQrq3pD4XWlfcwLko7QKNS0ppGQ
 7i7hYXBhLiavMl8byYUITiI6FRMKEBy0fkhh/JQINProQPsbM6IESaIohSPt4iNH1rX5XH3AYN
 opGaUg1QCZTYGaN1rrbxcc+5dfPrwXj8kumz/lCWKCea6NrWybSUaes4nR/dAS1NiWy12NMsaS
 qZIY6Wl3PxovtVyR/OsiQRdUWk0sOqr53n+AHYRp+kpAQAA
X-Change-ID: 20250911-pks-config-color-e5b8a213e895
In-Reply-To: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series contains two bug fixes for `git config get
--type=color`:

  - We restore the behaviour where we can now parse colors without a
    config key.

  - We stop spawning the pager when the user requests to print ANSI
    color escape sequences.

Furthermore, the patch series does some lighter refactorings of t1300.
That test file still has its fair share of issues, but at least it looks
a bit less dirty now.

Changes in v2:
  - Improve commit messages.
  - Use "\EOF" and "-EOF" in more cases.
  - Move a style fixup from the first commit into the second commit.
  - Link to v1: https://lore.kernel.org/r/20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im

Changes in v3:
  - Provide additional context as part of the commit message for the
    commit that stops setting up the pager with `--type=color`.
  - Link to v2: https://lore.kernel.org/r/20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im

Changes in v4:
  - Fix a commit message grammar bug.
  - Link to v3: https://lore.kernel.org/r/20250918-pks-config-color-v3-0-08ea618cae26@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t1300: write test expectations in the test's body
      t1300: small style fixups
      builtin/config: do not die in `get_color()`
      builtin/config: special-case retrieving colors without a key
      builtin/config: do not spawn pager when printing color codes

 builtin/config.c  |  20 +++-
 t/t1300-config.sh | 349 +++++++++++++++++++++++++++---------------------------
 2 files changed, 187 insertions(+), 182 deletions(-)

Range-diff versus v3:

1:  e62108edc8 = 1:  8d873d65de t1300: write test expectations in the test's body
2:  deef91062a = 2:  39eeb35d43 t1300: small style fixups
3:  58940b2cf9 = 3:  ee22438222 builtin/config: do not die in `get_color()`
4:  288d51d1c0 ! 4:  44b1d54527 builtin/config: special-case retrieving colors without a key
    @@ Commit message
     
             - If the provided config key is empty;
     
    -        - the user is asking for a color code and the user; and
    +        - the user is asking for a color code; and
     
             - the user has provided a default value,
     
5:  9a3adf8795 = 5:  b4d72c21f5 builtin/config: do not spawn pager when printing color codes

---
base-commit: ab427cd991100e94792fce124b0934135abdea4b
change-id: 20250911-pks-config-color-e5b8a213e895

