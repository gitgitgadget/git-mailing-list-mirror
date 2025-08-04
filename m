Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA43B241668
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300777; cv=none; b=rvGteDciV4RU9uKHGb4rFNh8IVXF6m94QkXV3sa0zpNkqA/cc4vQjL0VuA6AK/S+fennijGHw7mMVP6YsPHLF55H3ktijB16u91UbJW8X0irWosCnNPZ2FYpf7aBAsfJ3V6AuXyxN7pnig9ra2Y6gB9jbH5/cWy7AotsizEqnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300777; c=relaxed/simple;
	bh=Nwq/Tt8IP7hnctWQacq0jJgm4t0x40gOguV+IboQOfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tg8ZAnwnPAGy13RDUXI02vi3+KtFIuaian9hNrcGn0M5+HfX9cRYmaQx/ZX2C4nwFm8yiQZ0OEfmC1gVBXjxWyidjYctuLDhFPdMpVeFHYyHJo+jIvLMB3quqCzuMly00RItw9N+P+vFisPU0YFCFSLR59+TdqmdnXQzyUNMESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CLv3A+4Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UigOb+Ax; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CLv3A+4Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UigOb+Ax"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9062B1D000F6;
	Mon,  4 Aug 2025 05:46:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 04 Aug 2025 05:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300774;
	 x=1754387174; bh=abf+4AMlBh1x9QnvcmSEf2vSHrDuf2cozL83rWfXQEk=; b=
	CLv3A+4Y9fHq2ZAHakHHTPJb581XW+9yPgkSlnNEILKHPrU78xIQRGzRWP7JVGgp
	4CRMHU0tVsr3xWOGsh5WaKyv4Wn0i1fidjVqL6Emt09Q0/DpTQs4qiDp/Ao+l5+I
	k5IHkFZHVrL3Og+Mx8aIMx541AfafmBuUaOhgVt0HlRfcPmWM5zZXoZsgxPnTDPt
	jo/nudLhpIRwDT3oxjP7mvSFwJNrqFrCDRozUtSY2CmhAN+NtHtnwZdgZZUMF/DP
	lcJeF1VdNYyQM12t3/Ttjrho9RkKr752XTpVsI1VRDfxgKuSQE9Ew5YlwTfl6dI6
	TZLCWCRQS+4pNYLBZVV8oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300774; x=
	1754387174; bh=abf+4AMlBh1x9QnvcmSEf2vSHrDuf2cozL83rWfXQEk=; b=U
	igOb+Ax5v7TiQgQ/BTVI+eAZ9MbsV8FJnYocTNhLDgW+797gyQSLSAClDFJC1BfP
	YZt0igbeOwROYAqPRmcJ5b6i2roGDFB3bify8sE/enN4NRa11eR6Xlv/BgD9w8gs
	/UqGx3pgbqGl6dz8CcYNN9xor2BaKfE9JngnYmIH4xe83iDpPbRtvISQKeS37xIM
	V2eD2skk+V+WO0SSl0MUyQph63kNtuFGNO6ZEXOhpKwCK8FBt/ANSqv+2qDYpvTe
	XWlJEFJsBfXP7N80pKFFTAsaGV6/BbP1C67KE572AI+MQcDue2YikwB8F8kreP6f
	ZU7QjQ6owgUbyroboJG3g==
X-ME-Sender: <xms:ZYGQaKNECll5mP5cmIKgq-X5_txmKCSamQJ_16GGenl43JIN7yOH5Q>
    <xme:ZYGQaF2Aa0qNLsF_aZtw0BMQvkxYD_TDDRJQ8_d2f6QDl7SWlcdhRStn-HL2dqQ7l
    dSDMGPpCc7e4DL_iA>
X-ME-Received: <xmr:ZYGQaBDrYU6mwAw7-FZBA4aVfVGyBe4lPiMiMO3CL7besQr1q4IrBKkerrH60_MxKTci5D3jxG3VvdL-3V83wBSPfZ2xR14E80y148Mywc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZYGQaKKlIW26RaKQtoNO2kd516Qvyjul_sXG4ZMjc3nK9xr2rXWhIw>
    <xmx:ZYGQaCnIHPEkwMyvHuLbTYvx8UYG0lqYYWo3kvcMw44qScpix7d0yw>
    <xmx:ZYGQaLYL6WFIPFHoPt_mBjKEKY2EI6lEI56ak2pzQPsnjbxlu0izVA>
    <xmx:ZYGQaG9nUyhjxpD6VS9rGwAgXgspo-pctqYUJhapxHRKcYBi_8I2JA>
    <xmx:ZoGQaPT4iRCChyBxs0XeicpoyUoj4LeQ5UAfBKLUwMR4g8EW-fHn1kOr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d311387c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:01 +0200
Subject: [PATCH v4 1/9] Documentation/git-reflog: convert to use synopsis
 type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-1-13213fef7200@pks.im>
References: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
In-Reply-To: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

With 974cdca345c (doc: introduce a synopsis typesetting, 2024-09-24) we
have introduced a new synopsis type that simplifies the rules for
typesetting a command's synopsis. Convert the git-reflog(1)
documentation to use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 412f06b8fe..707a9b39ed 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -8,16 +8,16 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
-[verse]
-'git reflog' [show] [<log-options>] [<ref>]
-'git reflog list'
-'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
+[synopsis]
+git reflog [show] [<log-options>] [<ref>]
+git reflog list
+git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
-'git reflog delete' [--rewrite] [--updateref]
+git reflog delete [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
-'git reflog drop' [--all [--single-worktree] | <refs>...]
-'git reflog exists' <ref>
+git reflog drop [--all [--single-worktree] | <refs>...]
+git reflog exists <ref>
 
 DESCRIPTION
 -----------

-- 
2.50.1.723.g3e08bea96f.dirty

