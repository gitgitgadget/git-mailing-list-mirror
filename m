Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC1274FF5
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853836; cv=none; b=PnyRBaMDiBukBoEjizu+O7V8fZKDYh9Lod60AuaLtjUeyFM+8LtFDRcVcZu2TXKbaKS0ukJ9I6FrMWsK+CnaD5JP4xDZaxCEJAcuCtMuv6KpGhmBt21/sAqacitxxLnsrWdsKjjC5RBZetqqmfJU7ljDpgN2E12COPrWHX0MYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853836; c=relaxed/simple;
	bh=MWMzI9KbwFG6kj1uf995ubQQTHp8OkHnain/Kl1/mh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSDZfRFh48wcr+IQVNNEcnJgy6/r42Jgx8w8rZGb9XDtCovSu5A3YD74YHc6MB/f+pNDiVMAtSP5FBLKdTNd3uKPLZ4UIJ7HXlLPLUdT9EWlMJtJ+hknIJyz5ycqSViWxbCigoyF2nVuCfTUND+qfQWkkknvLT4IdOg3KLC5IgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YGiIhChv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFCbi4M9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YGiIhChv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFCbi4M9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB39B7A00E5;
	Thu,  8 Jan 2026 01:30:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 01:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767853833;
	 x=1767940233; bh=x/eJ5A2pwj0cMF4kACeZ/McswtSuj4EYHiT0TK45T6U=; b=
	YGiIhChvNTjl8yNS0P9de9/mAS1VcFge6YZlmoI97FU7tILcJYUl1NjRYHi8xn70
	R5kzxjk81L5oI6euiL6Jb4gtKgANUgiu5kDXt9NtxsOrF04fA6UJ49pXNHFqNOWx
	NBSjh6TPTC350DtlRgmRZbuAPUMx+Jk3YjY/URaAfCwJj5MQUuAbRsPv6QMeio8R
	OywJgzU50RBeNmkfgEo/YP5pO9SpZefDRty3DgNm7/7nzi3h/1FyPeoqx68uOJog
	p+NMRrOsmNCr3Bx0Xqrf5Mcf8Xn1B5+4ZH3Li7oLQzVrC9lTngQXRGfk0Sjr6jbI
	jnJsYKJCQfiYFXSQRDbE6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767853833; x=
	1767940233; bh=x/eJ5A2pwj0cMF4kACeZ/McswtSuj4EYHiT0TK45T6U=; b=o
	FCbi4M9Jv8JlXWaWNz3R+oQCkBKSRUjBS71M//Q0VB0sXNfgWNqIXJdpcu5cCLAz
	KreRY3kG0LNNS7fpdgvhKTYe93j1OrJHwjLJOMFDrG4I4ABAnvAdJ5cK3ptSk/ZJ
	zAjg8tCUDaXasdIb56eGYS6j4XJRlxIaMpOHMBCSf9rr129Hr1z/R9II08ed335c
	QuvpuiGI1BHsA6IP4t0ZaMkWgqc+58Pn2lXoZxHvXowqKsrvVO7uMtjMZM93f5xh
	H/RgBNeDcX5bR9kowLxqYmp9yRfFKlwarbJAG++EvqNp2Q+sHxORva8f/P9pQ5pe
	c+y71aN6bmWlQNUpSCilg==
X-ME-Sender: <xms:CU9facWx2DK9SPXqBgUy-EQsdfOEa01GGi9AJQ8HzQAjfGuwLCA25wY>
    <xme:CU9faWlOKuYMQrdbDSeH6WJZnKlL8o3WaDV0m1V5U-7qYDAIVgO28C5axdsz0eLva
    LiqAUZqyxzq0m891FVlM5gy3W3nDAr1x3C19BGkUJdGltBjhSMXHDA>
X-ME-Received: <xmr:CU9faeCuio1kHijAZrlVnnJT-p16KYhXUpcBrDoUsZspNgS6YN22awmZETWN7NwFXThqo4PD-JuqhmBwiRnn-VMHXVAidpKVgO7amWYaCIW91PI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:CU9faWf-g3uakZD4tjk65f_HAhHsyZJxGWD0_Y0tkYtsDf5Mqc43TQ>
    <xmx:CU9faZJZfvAoxsGSNXpjzpyTCLo7WzZn_QEWvzoh2nrbDgxIzHpV3g>
    <xmx:CU9faZc6dbZWa_hFWtEW8QaRFRGgaozCUIcOgzMY_-4G4JUR9EtIhw>
    <xmx:CU9faQ1PVtPgu_KmNCQZV6e71Pou9vUDdx7otCKErJP1EMdVNcKTXA>
    <xmx:CU9faXsGyziti_tx3w8OhOh6lQHwrjSKyV7jxpS473KVosolhrtKdTNI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:30:32 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 6/6] doc: patch-id: --verbatim locks in --stable
Date: Thu,  8 Jan 2026 07:28:20 +0100
Message-ID: <--verbatim_and_--stable.1b1@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <CV_doc_patch-id_3.1ab@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The default `--unstable` is a legacy format that predates `--stable`.
That’s why 2871f4d4 (builtin: patch-id: add --verbatim as a command mode,
2022-10-24) made `--verbatim` lock in[1] `--stable`:

    Users of --unstable mainly care about compatibility with old git
    versions, which unstripping the whitespace would break. Thus there
    isn't a usecase for the combination of --verbatim and --unstable,
    and we don't expose this so as to not add maintainence burden.

† 1: imply `--stable`, disallow `--unstable

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 61498def317..013e1a61906 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -32,7 +32,7 @@ OPTIONS
 
 `--verbatim`::
 	Calculate the patch ID of the input as it is given, do not strip
-	any whitespace.
+	any whitespace. Implies `--stable` and forbids `--unstable`.
 +
 This is the default if `patchid.verbatim` is `true`.
 
-- 
2.52.0.421.gc32ead4fc78

