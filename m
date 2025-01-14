Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928DD234D06
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855782; cv=none; b=reTbs/vZCY2pkHVq68WLOrawdGpvY4ShL+DCvkQi8ZJP0/fgRIDB11Az4BI1ziwndCnMiQnVOBiS0nqyUSYmIWdlW2Y9Id3pZnHv62CjolGMEkoE3L4EBrnc9Kq8RIcUxT4hA6Q4vg+aoknbJlaioLymOkhVTCqKWchuYaCd5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855782; c=relaxed/simple;
	bh=RD6bTeRH5E3wcZBW8RgUXCoeI6kiPL96q6m7+XSF6gI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YAKVRXw9KQDK4PU6gpcJAvj245GRdpy5bm9ra7qplbFNNW18HHx3u8yPdlCr4ARsz2METgNgQjvA9tbXFZ4vm6xQ95VFnn7PISum/BnUbeU8jejgJ0EjXkBxeBYMBTEra545nAZ9eI1b5kxNe8Hgv1CoDW3XF0gqnBkBy+B3TvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZtOR58+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WTsT4gF7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZtOR58+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WTsT4gF7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AC93713801E6;
	Tue, 14 Jan 2025 06:56:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 14 Jan 2025 06:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855779;
	 x=1736942179; bh=nD6R+tffNb7lmYo3DhjiI2mOrsxqwiBgIyG2+6zR69E=; b=
	ZtOR58+IMxqa+HoRM1C0ysBriwaULT7K9ipa6RF0cTJ3A8R+8MVPwpv+59+IKJkK
	VnuuXeYH7WYy87RnuIv3QheHaygwsqgqk9KQGvnezpWU5t1klQdrkQS8AvauNaiR
	S4qhpLoaVH7oFBCPOb7VZEGcSrDEMq3RWnbsCtt2Od16lfG4ZCf53hPYkZ6PQl0s
	dksUyHiq8rFkUlo7/1soWhaIt1mQyiEspCvJbowgoq/8CrxqbaOAMpBEOeBvHRyu
	AQ1qU9UBL3qAQd6X254f1GVj2lmTokmOKBPZM0dc7tOdV5eqGHefhQybDjSjytC5
	kPsG5oKMvlKvobw0dL04hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855779; x=
	1736942179; bh=nD6R+tffNb7lmYo3DhjiI2mOrsxqwiBgIyG2+6zR69E=; b=W
	TsT4gF7GNXE9Q02yGh2iPEiJDyiGIfgSYm7rjWN84+aQdtgaiKeSZexLDpDJc/Z0
	SehkRXy7bqoSOth5vOl9ZrZE5ixAd21eZhiuBum9+B9G9KLNDnmbOuaB1MooDGMq
	wA1IxRKl1pJUTmgEHKiXPF4NxDntUDnaBHB2pyVz9NmZfGD1lys7UKBbsXOcgRrC
	1szTpLKt9Z7l2uuUUXlVkeB7FPqlM+B6G0CM7Pa+eAvT/UXpm7RuuZqLHE7c+Nx2
	x7Y7dzaBDIAR7+Ft4Gr+1TsqkGiDyE7nVxkL3PwoVYSYVllwJ9IXhtIhsAySRGgL
	emmq6V+8yOsyG1I7laJ6g==
X-ME-Sender: <xms:41CGZxhhZjJoifmV1fwGjng8q5wqN0iaSLicgxvvaCXmxPI1_R3lMg>
    <xme:41CGZ2AD6QpOoCdHgGttPjM7crtQoi6hyW-YMRDKXx_pALVsU5t1iULr0_-5Gre3y
    Fmg2qmeBllp9nEPdA>
X-ME-Received: <xmr:41CGZxEIH1JdpujrpB-9p2wxSeHqLKPE1WyEGBNN5dtLmaeQKVL3o9TA7g4nX8JLx3nGU5ejx8r42TkBCpBZhC_AGAnT-prmE4YNhyvb6JPUZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgt
    hhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegvvhgrnhdrmhgrrhhtih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:41CGZ2QhBUuDkM1T0c95-NISWZgUX_J05oFSE14SpkFEqSVwKBvRqw>
    <xmx:41CGZ-zTokngVUrK1jzcKTmT6T1oL8HsFiuy90Ze7cVc_MqUGs-97A>
    <xmx:41CGZ87fMCvIhw7QPGQeU4K3I65JnyZbA6isM56BaFFUSfhYajv2wg>
    <xmx:41CGZzzwZ7U0ET-j5hh1gwuPT1rOTdIoy9SRv1Qr2J71gCVNiQ1VXw>
    <xmx:41CGZ1oVlK4D-AXqSiecXFLpPmZAmD8lGLslAXn2MSckyhLCxPyNJ6kc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb714708 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:13 +0100
Subject: [PATCH v2 03/11] meson: populate project version via
 GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-3-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

The Git version for Meson is currently wired up manually. It can thus
grow (and alread has grown) stale quite easily, as having multiple
sources of truth is never a good idea. This issue is mostly of cosmetic
nature as we don't use the project version anywhere, and instead use the
GIT-VERSION-GEN script to propagate the correct version into our build.
But it is somewhat puzzling when `meson setup` announces to build an old
Git release.

There are a couple of alternatives for how to solve this:

  - We can keep the version undefined, but this makes Meson output
    "undefined" for the version, as well.

  - We can use GIT-VERSION-GEN to generate the version for us. At the
    point of configuring the project we haven't yet figured out host
    details though, and thus we didn't yet set up the shell environment.
    While not an issue for Unix-based systems, this would be an issue in
    Windows, where the shell typically gets provided via Git for Windows
    and thus requires some special setup.

  - We can pull the default version out of GIT-VERSION-GEN and move it
    into its own file. This likely requires some adjustments for scripts
    that bump the version, but allows Meson to read the version from
    that file trivially.

Pick the second option and use GIT-VERSION-GEN as it gives us the most
accurate version. In order to fix the bootstrapping issue on Windows
systems we simply set the version to 'unknown' in case no shell was
found. As the version is only of cosmetic value this isn't really much
of an issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 7361eb2eaad422e7a6c6ed95d275615836c21cdb..213998986e8942cee080fc5b9b675860cf429ecc 100644
--- a/meson.build
+++ b/meson.build
@@ -170,7 +170,14 @@
 
 project('git', 'c',
   meson_version: '>=0.61.0',
-  version: 'v2.47.GIT',
+  # The version is only of cosmetic nature, so if we cannot find a shell yet we
+  # simply don't set up a version at all. This may be the case for example on
+  # Windows systems, where we first have to bootstrap the host environment.
+  version: find_program('sh', required: false).found() ? run_command(
+    'GIT-VERSION-GEN', meson.current_source_dir(), '--format=@GIT_VERSION@',
+    capture: true,
+    check: true,
+  ).stdout().strip() : 'unknown',
 )
 
 fs = import('fs')

-- 
2.48.0.257.gd3603152ad.dirty

