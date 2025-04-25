Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD4253941
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590298; cv=none; b=ZZV0XdX7lc51EN9MxiYocCLjSE8gw1RXaFv4sPWpPXIJ/uqPeG8/Y8jkZ1Cxv8TJBxIiJmB/qUEfnluGeNdl5i6gDcQtN3mIzSA2Lro6N2gvW6A1CIvWX94bLuKLSdmXW845wpVb1OJx4m/gTkzkEKEPCL5pHaj63x20V+plpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590298; c=relaxed/simple;
	bh=XCeLkpJ1Hu/KU6XN2EKr9R7qlZY13vZsV7SdsFtA4lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/qIYcHiAw0XIJWlo/XVnN07lHhkJOmLAu+ubRsqT7eAxmo5L+UTwQATe8LDDAtAS78YxUaoOGA23GaD8dDrxooehYNinkIpT52VLrjDdAh0PuGHqI/l+xtbi2DIy1zdeJJLZd+0ZR8dsBkiyDjJB1lAnSoXAmtD8uzcmXycqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TPMr1yoe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=irX+IKlx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TPMr1yoe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irX+IKlx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DB28111400BD;
	Fri, 25 Apr 2025 10:11:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 25 Apr 2025 10:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745590293;
	 x=1745676693; bh=7FTvnAZ27+w9SnofObSr/mJKfXH1ifqHBZIQ75V9qLA=; b=
	TPMr1yoe8qhuoexmBEWScIFPD4yPhi7nEDGLe8RVWSGhD1LpnzrBJBZgvV1N47yx
	/SI6Okpu5e+1nOiubKEfj0Vm0wB6F+YQcAJ16ADUsGVjGUlKLF9Ry1qELQCpcT/H
	1VG34xZglVPlDA9rx3epnFb15u/VepogWMAVUSBZ9/VV9zpYUeQo1bWiJ237EWeE
	o7m60bOeqKiFWvpsMGOxlwlxogIDzQrWO0m81Q23gzV0VFPOFDYeQd1oTgzvnnSt
	4zVGxjDFksTfNzR1Esc+49JNAH9BmQCU4/4zM+Ql6P7ClaOFskxysw94mlz30YXH
	gLTouj3eTp3eW/73/oh8og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745590293; x=
	1745676693; bh=7FTvnAZ27+w9SnofObSr/mJKfXH1ifqHBZIQ75V9qLA=; b=i
	rX+IKlxRh2GuBwvff0G41xF/6wmDShg/i72KAi5BgX8P0SXu2zN5KtJ8U/Xhotmx
	/fZmZvoUlZeYgqk0TFwmbufRGHNSQAMlYZevPrpNKCKNRcGvL2a54FBn/MR6H1oF
	56U09mi9Ey64m9mXA2l4R8MPQWn5UB+dvartfG5uavTFoqflicyXqa2CMHcFJgxz
	VKJ3OkinhaXkKRVFmAyE/UQRovXJqFn74Zi2FaDx6YrymPsQRe/UdYeU06EVHNYt
	hNiicE7s7+vYjgCk+FJoGQ8BXK+ioTyFCBKTXAgnsqWUqc1mi3gMXr6jo8BWz/AO
	DQt03bJIDimoj6DTitaHw==
X-ME-Sender: <xms:FZgLaJfZvXFnDiFwoTIrpeoVI3RQ__Ca9LdQ6jryjG6OCzxkoBEOig>
    <xme:FZgLaHNrfdB9F3gtfGzR_LeBUadtAhSXUM5am39g94Z0n-x4WEA7zvd0IPo1eZk3Z
    9DqL_Arm6Phv6v-rQ>
X-ME-Received: <xmr:FZgLaChqVDN1u0VydBquP--AXGvDS6PPmGet8B5wZbgG71jeGz0ObT4xOX9oaoAa32gPxED8vg43S0J0AL94i0U0Nfxb3yPllhY69yei>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiise
    hgvghnthhoohdrohhrghdprhgtphhtthhopehpshdrrhgvphhorhhtsehgmhigrdhnvght
X-ME-Proxy: <xmx:FZgLaC-PFITL8LrSF3PbkjVNQ1znm13nX2fpBoP7Bj_wvXnNqcemrw>
    <xmx:FZgLaFv1_LKha10EAMgamHCOa-l77BySYTRn2ANKMNsNCb9slTCvHA>
    <xmx:FZgLaBHW7hRfD4nLzZ9xPC1TJF_2JIXBQ0B56mwrTBWXZdR397KFmQ>
    <xmx:FZgLaMP8TQbjYR0oaXlm8i89uK454pMN_Z7xvJpmtByzrmm25tBwvQ>
    <xmx:FZgLaFN3qEfCi4-i0GlOvIWjYAaopBJBR4WXeX8h21nXYSFcB2t2_nX_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 10:11:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf87ecbd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 14:11:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 16:11:28 +0200
Subject: [PATCH v3 1/2] meson: report detected runtime executable paths
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-posix-shell-v3-1-01607a2e9334@pks.im>
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
In-Reply-To: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
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
index c47cb79af08..a180c66ee69 100644
--- a/meson.build
+++ b/meson.build
@@ -2080,3 +2080,9 @@ summary({
   'sha256': sha256_backend,
   'zlib': zlib_backend,
 }, section: 'Backends')
+
+summary({
+  'perl': target_perl,
+  'python': target_python,
+  'shell': target_shell,
+}, section: 'Runtime executable paths')

-- 
2.49.0.901.g37484f566f.dirty

