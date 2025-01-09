Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2C21421B
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736403697; cv=none; b=tCLEQn0O5z+vGmcD7Qp0YQHYQtJ6j2G6//5w2gaCGNUbu/YU13oJcwYMwlTl6Ka4/kqv7U+O2KO1ydudnNtI9Hlv26rUMXtqsMq1kK9W/P+e1pFNHJU8/JRGNqOffQFCOt9IOv65ae+PLWNJwbOgLjNrXxuTWzi315NZwhwpl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736403697; c=relaxed/simple;
	bh=5FZu4FuaGmo30dJ87I1a1J+X/OhCP8BTq96v5Oi5l+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BfWHY8gePun00R4UIEKFl233bttIarVRBL+LEXAfqqp50Zx2BDMLbdhekCf1DFyJy78F+OWGKKvUO7p6AvGKsp9tbeVuj10YsKnHpGjKz+c4bDPUeYqyBXyiFdSrrmWPNToHJQoMJI89ENDpnXmWWo5Gt6jOGn9kbpaPtjHgafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HCVYTr8F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1Iw/Yto; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HCVYTr8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1Iw/Yto"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 809E22540183;
	Thu,  9 Jan 2025 01:21:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jan 2025 01:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736403694; x=1736490094; bh=Kj+bkp1hW2
	wwz1Lk//jX4X5JAAYDg7R4iZThz0nd8D4=; b=HCVYTr8F5mskV0vf0X50Isw41L
	AHOcTsZdLzjFcPZLSCC+TIFR+proHODCKrQUk5MmhqDNYXFDaP/+udwFEgdWfSmy
	o53KJ1N9gdp4WClDPXf4k2ng+EZ2//gjb/2vBs9Q2CGbXgGJ5mquAD9VWaBdzv0I
	lD2Vk94VIy5gRSdRg757tFlzpY63K57COuswwPUTa324gYAaW/ttU3cTdiV38Vds
	54BS9rtEFn4SoK7oolLR641t5ZT/9Xc4N2Gq6LPznybjh26axOnpwpitJrKLywNB
	+fXw2Xmlecwi3VQTdRnCUp5Py+5sHSoZgYvMoy4LYMpH83Xb4VZKvPaQNIHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736403694; x=1736490094; bh=Kj+bkp1hW2wwz1Lk//jX4X5JAAYD
	g7R4iZThz0nd8D4=; b=K1Iw/Yto4MzefUyH0p909p0bXTpOuW/ceG8ezefoIfgU
	jXqZmBwcyNxT/f1qWouFDzhehETEd498TwkuHdcR4wRoIUy0dR7RP6b9+aq2tEgD
	JAZ9Fb4Uq99ChWbYqvEdUeJXBMM4NLPBNt/NRoEOiqTn7YFxFD+G8RxJOSPHpOiM
	Cg2Pobo3OmtzrVLjD8Enzl9rBlWUQnh1AKX1tRGhJITTRLgH2851lbtn0YAu5eG2
	9QdLpl9WjC1cFEssu0wsKIEmHHUBIqNCEaPHxI8qeU7NRA8DjPObJ96ZSgb+TUj7
	qs9bURtC29GcooRbPK6zdaJccywnRKmh1DJeU/PlBg==
X-ME-Sender: <xms:7mp_Z1Yyv8FraM_N0jXyijiuLnfogIRK6dExRwV6WBN3zjvmi0Nykw>
    <xme:7mp_Z8bO34ijAQgUQ7wRAGW38n6iVPrXSu6JUSnz8mKFElDIG6r6O4OwnpQdfzz8u
    rJQbn2IRngOI3FVig>
X-ME-Received: <xmr:7mp_Z39G-aTgzKQfJUrdGT1Cz1vQ48T7pShpAjEWumWugELk0dKeQm3Iq5Gh6umhQGkwBn9jDGaIcVeP9JxpLN4vS3Wh7od9-OTjQjG2ioMAKayw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeigfeitdffffdvvdeuheehjeehheeludduhfehkeekgeeg
    gfeuffehveegteejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7mp_ZzqKcJdHFIbAV8QWxS3lx7Fj7rsh1MB2ADLGzixTJqBb2RzFDA>
    <xmx:7mp_Zwq71oxdkAetCUcxYASkxJH_rUEjVgHWktXHGfOiPUTOdhojCg>
    <xmx:7mp_Z5Q7l331UYF9c5wO9XicgXgmtvBIq4W1it1c8hoF1SlC7qGBiw>
    <xmx:7mp_Z4rn-A-NwqNfaqcoeUA3DfToDuPN_fFScKwTzHLfREgbEocx-g>
    <xmx:7mp_Z31fFoGJZsGiDllzyg4B9wXA6Y4gvK-_biCByUHtspWdVU1FN4PE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 01:21:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b941f593 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 06:21:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jan 2025 07:21:30 +0100
Subject: [PATCH] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
X-B4-Tracking: v=1; b=H4sIAOpqf2cC/x3NTQ6CQAxA4auQrm0yQ+RHr2JclFKYBhzJdDQmh
 Ls7Yflt3tvBJKkY3KsdknzV9B0L/KUCDhRnQR2LoXZ147y74XDFbTEcVnoJ5vSJTFkwkAVcJc4
 5IPddw8RtO3YeSmdLMunvfDyex/EH6AX2v3MAAAA=
X-Change-ID: 20250109-b4-pks-blame-truncate-hash-length-c875cac66d71
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

In 6411a0a896 (builtin/blame: fix type of `length` variable when
emitting object ID, 2024-12-06) we have fixed the type of the `length`
variable. In order to avoid a cast from `size_t` to `int` in the call to
printf(3p) with the "%.*s" formatter we have converted the code to
instead use fwrite(3p), which accepts the length as a `size_t`.

It was reported though that this makes us read over the end of the OID
array when the provided `--abbrev=` length exceeds the length of the
object ID. This is because fwrite(3p) of course doesn't stop when it
sees a NUL byte, where as printf(3p) does.

Fix the bug by reverting back to printf(3p) and culling the provided
length to `GIT_MAX_HEXSZ` to keep it from overflowing when cast to an
`int`.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
This fixes the issue reported in [1]. Thanks!

Patrick

[1]: <4d812802-afbc-4635-7a19-73896fcda625@gmx.de>
---
 builtin/blame.c  | 4 +++-
 t/t8002-blame.sh | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 867032e4c16878ffd56df8a73162b89ca4bd2694..ad91fe9e97f90625dd2708fbd44bf2dd24a337a6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -475,6 +475,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 		char ch;
 		size_t length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
 			the_hash_algo->hexsz : (size_t) abbrev;
+		if (length > GIT_MAX_HEXSZ)
+			length = GIT_MAX_HEXSZ;
 
 		if (opt & OUTPUT_COLOR_LINE) {
 			if (cnt > 0) {
@@ -505,7 +507,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			length--;
 			putchar('?');
 		}
-		fwrite(hex, 1, length, stdout);
+		printf("%.*s", (int)length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..fcaba8c11f7ede084e069eefd292f337e8396cb4 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --abbrev with full length' '
 	check_abbrev $hexsz --no-abbrev
 '
 
+test_expect_success 'blame --abbrev gets truncated' '
+	check_abbrev 9000 --abbrev=$hexsz HEAD
+'
+
 test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git blame --exclude-promisor-objects one
 '

---
base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
change-id: 20250109-b4-pks-blame-truncate-hash-length-c875cac66d71

