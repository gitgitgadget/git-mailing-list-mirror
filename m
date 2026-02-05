Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A36288B8
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308667; cv=none; b=I3MlgSEgeccaVOJtm42Q9fYTvgjcIPhcZT9GJpxFysr6T7DD7yEJUzoNM8hvIArLrHLRfFtesupb+izEUIYPW7vwWG6vjtZChFvzbfH44Sxa3g9Htgqd+kIeqwNj/dVDaO9/eIkCIkdBi/u25xyYEvdElCcRWAcRXiwnQGyDybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308667; c=relaxed/simple;
	bh=imE+gZPkp4MAIR2E3y0b19Xenw1KCU0xwM97dSCQ0Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otiQulFrqBD9ie5wYj1WstWmCggFt4aMIuECRA6HyyRMjVPDbjFI1OnE3il0H48ryNB9j+nf0wkxeQQeSS849jn+Yn/V8QZUWYAobOXnrMedmOZt+PF/F+V1xMtJGB1K7FZ0W5IKxbJFBuIfCExyqSNXh/7wiRwZV5JQY2/Ovwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U89Fwf0f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbCDo9a0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U89Fwf0f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbCDo9a0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53A0C140019B;
	Thu,  5 Feb 2026 11:24:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 11:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770308666;
	 x=1770395066; bh=vIZ0yUUVwvE4SlFUX91+fACiTBChgx/DetLqRK86zU8=; b=
	U89Fwf0foVvlPTWjXUE4czztRtgLb7QE9PJwlESKi1kJHs/AZKVt74fqirnJaoMA
	3glj83lfGi1GowxspTW6/hdPQeOIX5DHCTD9Ct3ni25RMZ+k3TO5DJ/psqf+n+zo
	HejVPcFbSUVYzp7ETf6LpWql8toeEt9omOg927ajL7P/4isH68bOxIarFZCcdMRe
	7cmsaacKOzYeiO9whxK1DUnsf7Zrb35pYNioY6c41MKa0jVlVn0xEZf7J+JsYyIh
	UWEGh9fbmAeFMOxnoytlvDvlIC7rqe7pU0grVaL82X5+pasCBQXV8ID1qcjYpW1/
	nIB7y3QBtTmMQ8bS2cFnZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770308666; x=
	1770395066; bh=vIZ0yUUVwvE4SlFUX91+fACiTBChgx/DetLqRK86zU8=; b=A
	bCDo9a0W2NXaGGlHcr5OyCbCCCaD+zJWczrNo7pyt1KP7Hz7/S12O+vNskFomBOP
	plyy/zRkG2y68vGJ0nS4dPIYYl4DK5AXzpGrxklj5GsOW37noKSzlODb2JsOOMXV
	IUAkSykIG3GcBG+gVgB15iG4UG0SBLwZhpDuKnVgnIUdnkFuCFncV3EXxlCaRSnM
	AMW+FrfN5aqZ3xI2/XBFYi7kIav8Z0xrxTmzfnsDjYV5bM2Kf3CKtCOpXJNE4bxg
	KWc6QittTmZvWOERVSQH8gmkZfMzBm47BUHjiVc6sq8tdrxumcWx801fShHpHiT2
	xM75sXuoUb8cpmu+RbuPw==
X-ME-Sender: <xms:OsSEaREPDP8ZN7DBDJa5WuMGmWPi_KV37Kr2M7Yd-XWs3tJXgvG9sX0>
    <xme:OsSEadVwhnIg_-GJL8o_NMh9SVdP9sIzQmMMpEsqbRirAk2_ljXZ0m4dgrNo1YYTL
    xx78nSs-L7YqPc8It23XS_Zh9WD1UdbF6DopAf6appxMKAz9HIMMg>
X-ME-Received: <xmr:OsSEaYJ247SFtSIe-8BAIBhPxTcVG3rzaJiFRJWCT25yB4gsWelvrCuqvJyj5AKNa3wXgVxyproS3-XB5IUgKBZ3lS0o0_BUMHY9juw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgt
    vghplhestggvphhlrdgvuhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:OsSEaV9PSjbibR134hYuZSg2csZxR8jY5Z6CwsfQ2TxYUonjpHZ2SA>
    <xmx:OsSEaTJbyBv12NUzIl3sP3cwv0cbLr9D_mP9HNW5BZ5g-rWeNDR6Lw>
    <xmx:OsSEaSkO7JLV5rRQngFLD3sxJMLRCC2tktICN40P4k5wp98n37M23Q>
    <xmx:OsSEafPw8cbwUwaBcgzavjKsRn_PwRR4rNjsxGK8wSyvGQLtfM5DnQ>
    <xmx:OsSEaexTGNSts3AKD0ASTJ9w-booD6_ns0yCQc3q9MFrCS8Gshfrzjc8>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 11:24:25 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>,
	ps@pks.im,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3] doc: send-email: correct --no-signed-off-by-cc misspelling
Date: Thu,  5 Feb 2026 17:24:01 +0100
Message-ID: <V3_--no-signed-off-by-cc.260@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <20250218085913.1381537-1-mcepl@cepl.eu>
References: <20250218085913.1381537-1-mcepl@cepl.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matěj Cepl <mcepl@cepl.eu>

I don’t think there is an option --signed-off-cc (without -by)
for git send-email.

Signed-off-by: Matěj Cepl <mcepl@cepl.eu>
[kh: rebased and changed subject to house style]
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    I left the rest of the commit message alone because I think it is okay.

 Documentation/git-send-email.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index ebe8853e9f5..44ae2ed5bff 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -435,7 +435,7 @@ Automating
 +
 Default is the value of `sendemail.suppressCc` configuration value; if
 that is unspecified, default to `self` if `--suppress-from` is
-specified, as well as `body` if `--no-signed-off-cc` is specified.
+specified, as well as `body` if `--no-signed-off-by-cc` is specified.
 
 --suppress-from::
 --no-suppress-from::

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.26.g2afa8602a26

