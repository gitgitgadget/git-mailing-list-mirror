Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C261C3C1F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446437; cv=none; b=oYvkVWSDG9JOMsoZwKl2PbCWEbUBuMbC0ETic1swwNRKjIgUXckHm1nqmDJVNGiZ8KqPSp+ocZqqwUTNL2zgr237ugVTDkxbvz5NmXaChO+IQOwiiYfbW9ZPJMRHbzIyFtjNUvMqFbTpP95OzLgjoW2PTmEm3eBkbV+/M8K0PFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446437; c=relaxed/simple;
	bh=lDoS2UngAyAhoJ59zmjSlI9PxCa9bOhGXXWp/8TF4TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dd5UzyGTgeL96LkPQcbya1XRI8RT12elj7KvPfqFRYQeGj0EyVVRsYDJIVUGn1Bao491qfPsGKoUYwE4sF95TVBUor+R/mvNfjbGgRnuEW0nFJaV1X0bBT1hR3ZNAtBPpULIu5ncXxnPsYpHMXLahytzgbQkvYEFvw0xo4hi1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OjUqDwRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kcnqgz2M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OjUqDwRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kcnqgz2M"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 963141400098;
	Wed, 18 Feb 2026 15:27:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Feb 2026 15:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771446435;
	 x=1771532835; bh=eAj4KA4/exZ+w+ei21Pu9KqQN9BzJCSZ+SjCA5YgHKw=; b=
	OjUqDwRPavnz5pRYNvAl34CxgVueQi5K9fUjVv+QNLNJn7EbARwN9LXp5/fzDL6i
	TlE42vIDvys3r+DEkNrfhmM+X2wU/0aCGJK6aghSBngT4StMpNef+nmrLbQKUSK1
	soBcqs9jumZrbmkyem7QBmLp7ccmTevbwJjUgkuUBpjWgLdmboxaEqxJ7MfJavEN
	1vlIBgkNkaTa8bpAedG8aDVlRmXoVD8Si+l8sTOkkgKwSqH5DLGeKhhLhSQExneC
	Rx8xRoFHyNMkuTExQiu5HdGB9ncU+L7PV+KRcdzZpuOL7BUqB0RJPF7qXLEHbApG
	bCU+ll/0L8+yHYKdXX7/DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771446435; x=
	1771532835; bh=eAj4KA4/exZ+w+ei21Pu9KqQN9BzJCSZ+SjCA5YgHKw=; b=K
	cnqgz2M8bz/io8i08a+AEC7D3JNNNkFgn2220Kc43lHB57eQi6rGFVsefy0ywZlr
	kQr0GYXahzAQeR33UinTQdvYY0g4aGBwh+lKnyiuZoubm6JsE0JuA5OMbQK9fNLu
	uo2ZBNjb4ue+U0CILQZrY3F1JzG2sdHtOtrhgWba3fQZRmbZmwI6lHR4Uk7kKxwj
	Kn9Qd91q1ol8svmh1jzQr93hdI/8zg8xoR+oCcbe4sYh4zzqavBvWjIAITcbbOhr
	/n0Lx5B73uAR6Kd01falrKKiT1YFVy1e62O5E3mih+ZcZMCbne7nF4qhCluC5zhg
	nQu3FQPSfBqaoWIV+t6qQ==
X-ME-Sender: <xms:oyCWaT-58n1FP5On6P8lAdngTJtxXTSigLZF_6_1I2pV9nYo3dwxmKo>
    <xme:oyCWaXJxrcx7805lM3kzTQJgcdy9CnG7Z_DwzyttSSLrPN_yuk_eR2XQ6Eew_raWQ
    Xt-FFcElAzB0sw87CWBlteJVVz-F3txn6ukulTst88yng9GbnHK2Gw>
X-ME-Received: <xmr:oyCWaebBW5_dHNaHxt1p5Zb7P-x1l_oFI1vTmw3BWVS4GicktXHMMMOHnbACnY7_YHo1rA17oLGvwixEe54OKUZcj6mD3PCjps2EJ70tVBvYBWRLMh25jQbNKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:oyCWaZK2GGcnW2S8V9elDJTDUt_9t5DAyz84NVy_2yiRNtWV2THYRA>
    <xmx:oyCWacBjhm6E5dKYFF4m8-P0d3dGyAkzec5NGcSGi8-Ty56XN9IZYg>
    <xmx:oyCWaep5aEw9fk0QPFladPmlApBGSYZdCMnptemibn2LpDGmrZ7S6g>
    <xmx:oyCWaXgujyP1bOhT8qo-vgWhqB0zjBXT-J7mzlZgEFq4hb5_AY2upg>
    <xmx:oyCWaf7uVDsC3CkCG1Xp33GevvuGR0mEV66AuFJH1vH38JZnTsYDNZlE>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 15:27:14 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	peff@peff.net
Subject: [PATCH 2/2] doc: diff-options.adoc: show format.noprefix for format-patch
Date: Wed, 18 Feb 2026 21:26:18 +0100
Message-ID: <format.noprefix_and_--default-prefix.39e@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <CV_format.noprefix_boolean.39c@msgid.xyz>
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1) uses `format.noprefix` and ignores `diff.noprefix`.

The configuration variable `format.prefix` was added as an “escape
hatch” because “it’s unlikely that anybody really wants format.
noprefix=true in the first place.”[1] Based on that there doesn’t
seem to be a need to widely advertise this configuration variable.

But in any case: the documentation for this option should not claim
that it overrides a config that is always ignored.

† 1: 8d5213de (format-patch: add format.noprefix option, 2023-03-09)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    `--default-prefix` does override `format.noprefix`. See test `format-patch
    --default-prefix overrides format.noprefix`.

 Documentation/diff-options.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 9cdad6f72a0..8f632d5fe1a 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -860,7 +860,9 @@ endif::git-format-patch[]
 
 `--default-prefix`::
 	Use the default source and destination prefixes ("a/" and "b/").
-	This overrides configuration variables such as `diff.noprefix`,
+	This overrides configuration variables such as
+ifndef::git-format-patch[`diff.noprefix`,]
+ifdef::git-format-patch[`format.noprefix`,]
 	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
 	(see linkgit:git-config[1]).
 
-- 
2.53.0.26.g2afa8602a26

