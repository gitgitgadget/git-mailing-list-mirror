Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E71D27B6
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798370; cv=none; b=WeKEg4Q/DeX0v82PyTvSg1Jtn7sVCRwjNQ4/geNRfDHy+hlOXwo9C0sMbjNAGeO6T+GmE2utTqNqJ/C7UGlSjXjhKrpnseEMGBxt+j9gwy2ymSfEcomTYg3n8TdqRukTvEF9TIfTe7naU/IXV3WLL33+XBCDzHNMWDJxCf/s1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798370; c=relaxed/simple;
	bh=lJzslbVpRLej3RVQgk+Ivo2r4i59ZXpIJJ0sbobeQTc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RqCkPJ9+SDV/ePAzf4I+Nb+dk9vE2p/5in9cj9E6+epDFUxeozeU+haIpWnlG6NFhMi6kONhjhOyPp/fTsWQR9XBke5a7AOsCwd5WVtJUWfGISgDc0F8QAnCF5ftTsAzEo9p3BiZkBommHwSvuf00dcWKaZlLVSpVk8ICNia+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TGlmPUcg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BU7IsHnc; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TGlmPUcg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BU7IsHnc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AA287A0618;
	Tue, 29 Jul 2025 10:12:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1753798367; x=1753884767; bh=J9I5656YSz
	DDU0PtzFmDwivGg0KqAi4Xd7F3q8OoCuU=; b=TGlmPUcg6CWYd7PdXMJ0iTZMJw
	t8JoFozXV5KqyssIix/CnmcyTq04H+vaSUetIKp0bxLC71J/0iQLbcG9yphBuxT1
	v/pPH+qF0UtXVub5PEA/pBgYNIRsncVhBW8GX1yYO+ZqE/BVRj6Yv55VCeeHDM+D
	GImDovBTycds45QHLg0BHvALpm4tR7TXzdJihQF6nI9eE0kuwEE/iqLee8hTRt53
	mFy8y/Pvruxav0gL+iVusRs9uEo2Jc6Vu9YUcFbjint7+DiJF4dWK8bqCrwozaR4
	6Hf8BoDndTSUAGKzB87zqhuMGNxZFYLBOI/M3YrlFf9HwIYiiTK+VPv0u0UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753798367; x=1753884767; bh=J9I5656YSzDDU0PtzFmDwivGg0Kq
	Ai4Xd7F3q8OoCuU=; b=BU7IsHncByS7PZdhKKm8rtpQ34AjIk32eJrDupz900gl
	38hlAkZJIQGZcKB6npXAUP/mTH+cOUrSIXm6B3S3fNsAYwY6haMyWFK8LX3kH3gx
	cMH2IkthrN/HwR0pCNAxEnXm9BCtrbmOy7bbkRipY/16cZkRf8nXb/39i1fcFHr0
	FOzzU4FYatYP8l2DoL2FA3MM+51l9xFg3kZg9aT8xmfxXBZXiIuzQd0Z9qMIJrLO
	uQrBhDpM1iFZG85YWEYigsUpbR2pb0+Nc1sZKPICJjHYIKaFP1pzMHxIUcrz8XLq
	+wwbV45YVR5gJBd59Y5XX3JNbcNuc+L8pybC6UWGXQ==
X-ME-Sender: <xms:39aIaEjT7N5P4_-fWSabjuYgxkz_LpURJY05mIKmXvoLYXxGS8w-YA>
    <xme:39aIaNObURsMMDSEs7Yaikts4ZMSJAjNpXaJ10g7vjQyo62zLNtQ8FVzSV5k4v_4f
    Eh7tD3RfcZ35-aQQQ>
X-ME-Received: <xmr:39aIaN4zHbxPR7A_-IRvb0_XHfnk8MMNGMpewzeQVfGs8DIY6XKuN4iubguWAZ4IQ11I4B4WRyo42kzhPQjstms2RHCGInnI_2mIxKmDeHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:39aIaD0Hd5N8KYVwBor01RhmxMKHcwnrG0sSatqmLy_dIYDH3MufcA>
    <xmx:39aIaGbOAuo4v2mEvEtYT9CnyE0nMMWFrm3sbOL9jWK2SDDjjD91eA>
    <xmx:39aIaDA4Pr79lX5raVWvqc6ZKxrMFXe74HW9SqdkcXpxSFTaaY6O7Q>
    <xmx:39aIaA8ECwUiHJ3LsJCNQgNTxBXdIPusxTDj7VCc0yiWrxTa8XXv4Q>
    <xmx:39aIaO_O03LbNflXFFKdo65xLovAFQPB7u-QuIGrLjq6V4RBrTqWLMIy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 10:12:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ba92b7b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 14:12:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] midx: stop deduplicating info redundant with their
 sources
Date: Tue, 29 Jul 2025 16:12:39 +0200
Message-Id: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfWiGgC/x2NywrCMBAAf6Xs2YWYWnz8inho96GLmoSslULpv
 xs8DgwzK7hUE4dLt0KVr7nl1GC/64AeY7oLGjeGGOIQjvGM0wHL0/FtvCALz+VlNH4EPc+Vmp0
 0o5L2FE6T8tBDK5Uqasv/cr1t2w8eioMCdQAAAA==
X-Change-ID: 20250729-b4-pks-midx-deduplicate-source-info-fcf3c08bfd53
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is a follow up to the recent patch series that started
to move the MIDX into its object source. It refactors the MIDX subsystem
so that we always read and write them via an ODB source. This ultimately
allows us to store a pointer to  the owning ODB source in the MIDX and
thus dedup some redundant information.

This series is built on top of e813a0200a7 (The fifteenth batch,
2025-07-28) with ps/object-store-midx at ec865d94d46 (midx: remove
now-unused linked list of multi-pack indices, 2025-07-15) merged into
it.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      odb: store locality in object database sources
      odb: allow `odb_find_source()` to fail
      odb: return newly created in-memory sources
      midx: drop redundant `struct repository` parameter
      midx: load multi-pack indices via their source
      midx: write multi-pack indices via their source
      midx: stop duplicating info redundant with its owning source
      midx: compute paths via their source

 builtin/commit-graph.c      |   4 ++
 builtin/multi-pack-index.c  |  31 +++++++---
 builtin/pack-objects.c      |   2 +-
 builtin/repack.c            |   7 ++-
 midx-write.c                | 116 +++++++++++++++++--------------------
 midx.c                      | 135 +++++++++++++++++++++-----------------------
 midx.h                      |  42 ++++++--------
 odb.c                       |  40 +++++++------
 odb.h                       |  16 ++++--
 pack-bitmap.c               |  15 +++--
 pack-revindex.c             |  14 ++---
 packfile.c                  |  13 ++---
 repository.c                |   1 +
 t/helper/test-read-midx.c   |  31 +++++-----
 t/t5319-multi-pack-index.sh |   8 +--
 15 files changed, 243 insertions(+), 232 deletions(-)


---
base-commit: ee2fd3d4b224c8145eeff04101ea6075560973e1
change-id: 20250729-b4-pks-midx-deduplicate-source-info-fcf3c08bfd53

