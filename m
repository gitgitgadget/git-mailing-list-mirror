Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C71A83F4
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568656; cv=none; b=sL/B/6Ks4iUfA6SJHEMd4JcWwvojYzkDO7b13kmBmLGNPg0g604BlGRSjGMrkJ8aUIufe6tlDLl7oBZqwlhQYKbLctSFpFngt9tCUDHlX1Y08PJ1gME8n6uGLKUI6OZe0IZxnWuYaEwOv34eB4jOF3FiwG0dq436XpFDEQp8vrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568656; c=relaxed/simple;
	bh=oh0m9/n/RvWK9r0x0bbS/MBlHGS+dpSxiBkK/9mruPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+erYcCVd3OYkZR9RtejRQ5ekJtJk1M6C/IOUL58LzhNZOxbJUC0CjvFYzmWBKQIrWBs8R2JQNa+MRG7h+DKMFJNmsg+ABwOwHTD6WWVDuq4rBnW9aQUaACNofzcUPJAFyMnsRSf0SXZs0/V7amoub9s7vGm2e619njhYjU06ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q4/c7zEF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r1ZcxQZ5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q4/c7zEF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r1ZcxQZ5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B6971140145;
	Mon, 30 Dec 2024 09:24:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Dec 2024 09:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568653;
	 x=1735655053; bh=WlG1DfzNXUxMrZLsv6zMS4fn0/sdbPaYLpRqXucurlY=; b=
	Q4/c7zEFMcZVp+4rH1gEfRRGqqwYqBxT5NKFKYwr7atR7j5sI8TrtayOh3EF0cFU
	mzF6pCM8MQUyPjFAdPPgbuOAvYsE7Ho4jpQwgf1YlFn1cHK5qiWzTJHImLKpPeIb
	+gy/IsKdAZL3RQ3ZEOdz2TCO9h6Kbx4z06LkIrJcB8pX4i/oY69967P5uyKSSTd5
	6H8SpSi4ZJP7keKEjQus8JuGc7MgPLB8CMLhc7MTWfVE0ihzuJc/6NAFNjIvLKRR
	CiI3Rbel8Fhv/YVSCcaCeVqiXb8GDe4QPMhrfthEeHSlRU8xh+D2VRQbWJU3XrwD
	Ru/TfW6S2uYKJJJpi8gFRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568653; x=
	1735655053; bh=WlG1DfzNXUxMrZLsv6zMS4fn0/sdbPaYLpRqXucurlY=; b=r
	1ZcxQZ58cSWD314X8Dbwq6gi0XPUk8k4Ydui39J439lV4qdDKQ4tb3gfElr+22ns
	v7vp/K7sl3CjUZ/YX2PBd6gw9nT34LgTZwK5nBMY558AGZlg+VcOXEW6pQYwpbFK
	Lbi8vw4CnjbxQqj5TRXZcegsRkENcXCQ93dQrAgLZ8XK/euZxi/JGNoj6VbvpmsJ
	tMHbyOYxmtRjduYSwlEGMxIshBok/A1I1OEd20fUCQJYfw4h893bOW7Qo4lH1cZx
	Im9Mhc9h9FHv58Rk7EEh4rufgnKbH9iA3uchwx0NlUH2bVQ9mFRtefe8ca0efaqR
	RNVMaHfnh68NlrkwPdvqA==
X-ME-Sender: <xms:DK1yZ-DmtFFwNtmTducHUiWkU3Mr9u61fBqS-GoIR1R-z639dtgSXA>
    <xme:DK1yZ4ip6a_7CNtbEUcpS6zUe5F6XAcdUdf_8EFSCbXmuPcCrOFiLnKN60OGJG30d
    tomrY4LbajpgoowVA>
X-ME-Received: <xmr:DK1yZxm3jQU8GN0ZEaO_EVaOmr0rvJUu1QJRbWBycpyPvkou97TDPGGSENsNkTksx0VcMo5JocHZaEpsmCuW6mpnHtHFe7Sv7uK_qR4G7aM-Dxo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:DK1yZ8zXxm0u3aISxXctbRuddCw4NiHeUHEGgx107Dg_V2Eukcf7Pg>
    <xmx:DK1yZzTu3ndGlcmUQPCRmgyJi0rDrWQ9a5E-fRPvTrTXoUNMaVej4A>
    <xmx:DK1yZ3bAxIQk4hg48ty1OuSnS5rtWWoRpoUvulnCdEl690td5YquEg>
    <xmx:DK1yZ8SHFYALfsNMWAuMoeWBG_FzoeVrgtp-NSnG7t3LaJ7yvyahgg>
    <xmx:Da1yZ9d-nFGZhRNeZOY2fvJ_iR60uRocFSIW5ICoA423CjaOs3QxAY0A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cbeb5ace (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:04 +0100
Subject: [PATCH 04/10] meson: consistenlty spell 'CommonCrypto'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-4-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The 'CommonCrypto' backend can be specified as HTTPS and SHA1 backends,
but the value that one needs to use is inconsistent across those two
build options. Unify it to 'CommonCrypto'.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 2 +-
 meson_options.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 0064eb64f546a6349a8694ce251bd352febda6fe..9da58dafe0f1023cc72f4ea3eff5515c9d479099 100644
--- a/meson.build
+++ b/meson.build
@@ -1367,7 +1367,7 @@ if sha1_backend == 'sha1dc'
     'sha1dc/sha1.c',
     'sha1dc/ubc_check.c',
   ]
-elif sha1_backend == 'common-crypto'
+elif sha1_backend == 'CommonCrypto'
   libgit_c_args += '-DCOMMON_DIGEST_FOR_OPENSSL'
   libgit_c_args += '-DSHA1_APPLE'
   # Apple CommonCrypto requires chunking
diff --git a/meson_options.txt b/meson_options.txt
index 4be7eab39939178ae2ffde1ff9e78f83a1b482b2..a7f308d217f29ef301848e63623a49207ef83125 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -49,7 +49,7 @@ option('regex', type: 'feature', value: 'auto',
 # Backends.
 option('https_backend', type: 'combo', value: 'auto', choices: ['auto', 'openssl', 'CommonCrypto', 'none'],
   description: 'The HTTPS backend to use when connecting to remotes.')
-option('sha1_backend', type: 'combo', choices: ['openssl', 'block', 'sha1dc', 'common-crypto'], value: 'sha1dc',
+option('sha1_backend', type: 'combo', choices: ['openssl', 'block', 'sha1dc', 'CommonCrypto'], value: 'sha1dc',
   description: 'The backend used for hashing objects with the SHA1 object format')
 option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
   description: 'The backend used for hashing objects with the SHA256 object format')

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

