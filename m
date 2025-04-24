Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0F19CC37
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501910; cv=none; b=o40jvybBGDtbtWwS2BnaHJfpU0Y7lY98vmWU192zOFX/hA/L5QtjQGlw7Qi0E6/bXFEKwGVDc3d+yeJzde9CtUPIM3qazvGtyDZ4Z4JSKMuhCVJCyPgHMaUr6/s+zhUejVhjt4FfITpc6O+/Rbn2oZ8E5Rss5OPNY1SAHXi9wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501910; c=relaxed/simple;
	bh=a+1ZiJztQSTrb6cTlIVvG6C3Fr3eXknQ2TRyRqa7Bok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OI8fNewqkpvYquxxji1KNdxSYCIbxoiGnwwoa5PzYGA5hvDvu3VXnxbAN6Km6uiKAAIPzb3Y2BDpxgWNR3iFuFECG6HwbhhucyJbRLZBF7UOjrWxdl3yL4eeDZz2u6zarHv9VXQndY4+mWiCk5vLTCemPL74Xju8ietl6+u2fcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HEd85on/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHnVS+8I; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HEd85on/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHnVS+8I"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D8DC0114025D;
	Thu, 24 Apr 2025 09:38:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 24 Apr 2025 09:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745501905;
	 x=1745588305; bh=RXMIWr278UNBcVXi40mGlp8C8D99NDjPgTer11UGU1U=; b=
	HEd85on/8NM3laIlOSahZ2itxvE676qyWeIVtkVSuRvLTPtvxsZIfYvsMYdJlsWw
	+Ff1YUsN/Wk4nU3PqEFG92xtrXUEYxkigOzMjXE+b7mBbeDwxFWzLhT4GFU39gJq
	qf6fn9SY0mZ/3lu09wdOPwi71+7CX6j8aw5hDgORO3MhdYjhhr2/8TQd0IhW9PbM
	7BgLOuLS8GkaHQXhPFtj6r5NAr+3aro1ma7yaSJiqR3LSKHT6xEkOH6VtypWo0Oy
	ETv5vOA4NE4VTIEBbNsbQk8zL7o/zzAF1K+dOqLlnnA2pBg5fZ2uH9JR28DwyFbY
	ItuM9muGlU7yqyKdE9h+1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745501905; x=
	1745588305; bh=RXMIWr278UNBcVXi40mGlp8C8D99NDjPgTer11UGU1U=; b=M
	HnVS+8IG6VClxKPo2A6n8UER3CA++uEpxJptV2FI2TwHQ7MMx/mUnKnlcDyu+tfZ
	8N/KG8mfMUBy1Pwk5ixVLwXXPgDAxNLElrD6xrgSkA6HBvVYJDq9Qp622qPxxGYj
	nxw/q0HrN8YEuAYiMxIdB+hPcW7Le+GtQZN+niOd9ulBzmiY/KnTIq4XEpEl+a7f
	UC65n/LavSK0CBa9RSXvEXbjzJ0pREpoAYchtFwVhPr4WGDvWOAmeKgMzItfNy/G
	vPrAGvLsVP8sXQGcwJPz3/YplLhB27/soDaHnofbBVVKZqJFTXUzhnR8A1fkz0Yt
	5eOrZM4c/LTBN5rvFRgTw==
X-ME-Sender: <xms:0T4KaGHUi9l_c2Gl4T6TMyzDvtzM9hOYz9_TRSRs2ixZEMp8sjXGZw>
    <xme:0T4KaHWvunDPv1MPdguHsTgItOYsK-PtVW0Xugu3_we6FW1cTchPQoMg0mOGgkfdP
    HqTOYHUVowSenoIvQ>
X-ME-Received: <xmr:0T4KaAIrXOZrHXsIDxFEB0qsyGvtLBr6U-hEp_YYpPzE9IAeonpLmPKMrr385I_4gzqPvgI5AFJDBhwIkR0RW8ybRrsoZ7mpiJCDEYoL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshdrrhgvphhorhhtse
    hgmhigrdhnvght
X-ME-Proxy: <xmx:0T4KaAGInYr4WL6oscC6-zb7JoHUAhNFnxcGsfUd282oyCg5Nx_bOw>
    <xmx:0T4KaMWScwjtS4CjqJe4PACqdf8gtmj8nULCMaLMxGzMvYLtCp_Fow>
    <xmx:0T4KaDMYlRP-vyXj_UBtSqg9Fd5_Bn_RpZk0o1uJotMpOuJGX55I0g>
    <xmx:0T4KaD2x2kXJQYdIQvyd63JUoZytSopW0cUnO3LD3dJMl7EwUtPRAg>
    <xmx:0T4KaPq8hC0xGSFIrCPj_gkkn9hIrvmCYBbGRUoTpQNvvgfr4L-4qaID>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 09:38:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 512d5105 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Apr 2025 13:38:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Apr 2025 15:38:14 +0200
Subject: [PATCH 1/2] meson: report detected runtime executable paths
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pks-meson-posix-shell-v1-1-45e06ee4b6ad@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
In-Reply-To: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>
X-Mailer: b4 0.14.2

Git needs to know about a couple of executable paths to pick at runtime.
This includes the system shell, but may also optionally include the Perl
and Python interpreters. Meson detects the location of these paths
automatically via `find_program()`, which does a lookup via the `PATH`
environment variable. As such, it may not be immediately obvious to the
developer which paths have been autodetected.

Improve this by exposing runtime executable paths at setup time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index c47cb79af08..8f04534c7ff 100644
--- a/meson.build
+++ b/meson.build
@@ -2080,3 +2080,9 @@ summary({
   'sha256': sha256_backend,
   'zlib': zlib_backend,
 }, section: 'Backends')
+
+summary({
+  'perl': target_perl.found() ? target_perl.full_path() : 'none',
+  'python': target_python.found() ? target_python.full_path() : 'none',
+  'shell': target_shell.full_path(),
+}, section: 'Runtime executable paths')

-- 
2.49.0.901.g37484f566f.dirty

