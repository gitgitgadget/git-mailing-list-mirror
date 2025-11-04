Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28C13B5AE
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266989; cv=none; b=FfHJdHSHWOfWUqfIYGn2JD0eB6GUdmvtMFY+rzgfxBXeP0aMVDUFc5B0D73d0bf3d/7366BEI0vLKFaM24G1JS7pKrDvfBR4WLIalVgnBS4UvIa5Uiv2FLAh9l8Aspedd69VGVBl4p04BhmhC0+LVsoB9AAbIkEjHI9dbjZ8nVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266989; c=relaxed/simple;
	bh=8//vfwG9vr/dAsMFnrf4NEo5vGGgONpk1doHjiaAlcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ohchMRKeUJkiEW5TslxYWKb86tTfD4r4k9qWjMIYt5VHzoU4ZrI6JzKdSHhNTPpAAMjyD5kQ9YOceSTeRE4MKIbZpQuY5gDyZnOB5vXkMSeozgaUZnonaxXQJ52VfLDa0feB9KMVyutL8rV4pkUl5kxlKhQ92fm7oxWeCuBvM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mqD5uyQa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuEP5NMX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mqD5uyQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuEP5NMX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A4E01D003D6;
	Tue,  4 Nov 2025 09:36:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Nov 2025 09:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1762266986; x=1762353386; bh=ZGwyAPyWHb
	FV3pCSLy0l6h0e1v6xwaSFFYqYJ5egeAM=; b=mqD5uyQamEvcg+r6QwbjZ7fLnT
	ipY//ooAh0FPX+RJcsJ7W3nYG7LS8B1n5y6/JkMW/d5VADdbFdaluAbIH+QjR5yD
	khOxB3F+3bHfr021uaGmjIvWt58bFkXwxcmPe1sZdg3ozeCJat/+rv3e3/Nk4xT1
	M0eg/4Bol+XAPHryO/8bDWpP21nggAaWrl77z91Fm8qNMQ0kh1X2LfvObfVUrp6B
	LWB+wh7P7uyemAvoxgXuHet4MaiZm32kxBjGq/noOfptpsj3R5l6FrPHoZymyS8Z
	KGONwww7KHol1WSBY+xIRCxXKr3gKLlEiif6WuL3LB4lh6VWPN0oucviM7lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762266986; x=1762353386; bh=ZGwyAPyWHbFV3pCSLy0l6h0e1v6x
	waSFFYqYJ5egeAM=; b=JuEP5NMXrV6lcVz9gM+oBtOvij4PvY6UBAXeIkJBXr8e
	9qdlFG/WHyGOg9c7eruX7XzKw48xZsaV2OU1eeFqKlP/p7LN9f+O+ykMfwZkThtL
	MyaR8PbPggNRX31jrkZekvnpSN9At9h9IapmPrv+ERgTcINcKeYsipm1vazLOcIj
	iPIkPoBnqzh7G8/ON1Y2slD64kRSerKtXawSqwbuuesGFPVzZNVTcgVM3E4TvBlP
	B2CwJCPMIKQ9hM6/JYW5hM7c4VtWKIGKsYcIvxeD3nBfdSzOAfXb/m8y4MqLpo0X
	sp0Lfy1PN47A54SVaj7GqZUANk0wputsyJ9i8u5ffg==
X-ME-Sender: <xms:aQ8KadkjIMCjsU6fSPHdCoGTXjGiitXtuIWkpZrOFiyTSO7aRa-HnQ>
    <xme:aQ8KaQQxwpnzwbgoA4ENBgufLoko2pNGjq47IrY49Lpx0K5q7JMhU6j0b37VZqg1n
    P-oAWuitGhm8or_JxJ4JCFMYIoq6cZjtAImhzRSiwmJTH7yL2pd>
X-ME-Received: <xmr:aQ8KaRB_5ssih-rU76IlUiSwQaPUa5Z9VJtym95CdUIi9lcYHGChcEjdIwYlEOqrMW-vik1HnqoqoYG8y2RBEjFBwdO2jE6y0R78QC7zNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhhe
    ekkeeggefgueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:aQ8KaXT91tInYCU9qofSrgL-yPWZrfwR9WsMcJ2ZYnSqDMHnmBeBCQ>
    <xmx:aQ8KafqdkZZrpErwFW0nOkiWTrXv9TcKvaeknw8OidAWicqNrRawlg>
    <xmx:aQ8KaZxg-GiEMQMjnZGyzMZkJc5_HVmhUm8GydDOShOJpnVZxXs1Ng>
    <xmx:aQ8KaUJUMJ47CjVgzxcgQz3ehdgMmxV4vWb-VB-fEbzdQzShRyIASw>
    <xmx:ag8KadCfLea9-N4vx4AKhoP7QQeqC_iGK8NLrjmL2RZd089_GoYbOAiF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 09:36:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eeab81c2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 4 Nov 2025 14:36:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Nov 2025 15:36:13 +0100
Subject: [PATCH] ref-filter: fix stale parsed objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
X-B4-Tracking: v=1; b=H4sIAFwPCmkC/x2MSwqAMAwFryJZG2htreJVxIWfqEHR0qoI4t0Nr
 oaBee+BSIEpQpU8EOjiyPsmotME+rndJkIexCFTWa61sthZ9EvEQCOOvB4UBPfpUdlSaVM450w
 OsvZS8P0/1837foRlxnRpAAAA
X-Change-ID: 20251104-b4-pks-ref-filter-fixup-048013766635
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In 054f5f457e (ref-filter: parse objects on demand, 2025-10-23) we have
started to skip parsing some objects in case we don't need to access
their values in the first place. This was done by introducing a new
member `struct expand_data::maybe_object` that gets populated on demand
via `get_or_parse_object()`.

This has led to a regression though where the object now gets reused
because we don't reset it properly. The `oi` structure is declared in
global scope, and there is no single place where we reset it before
invoking `get_object()`. The consequence is that the `maybe_object`
member doesn't get reset across calls, so subsequent calls will end up
reusing the same object.

This is only an issue for a subset of retrieved values, as not all of
the infrastructure ends up calling `get_or_parse_object()`. So the
effect is limited, which is probably why the issue wasn't detected
earlier.

Fix the issue by resetting `maybe_object` in `get_object()`.

Reported-by: Junio C Hamano <gitster@pobox.com>
Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
As reported by Junio in <xmqqo6pjt2wn.fsf@gitster.g>. This applies
directly on top of ps/ref-peeled-tags at 054f5f457e (ref-filter: parse
objects on demand, 2025-10-23)

Thanks!

Patrick
---
 ref-filter.c   |  2 ++
 t/t7004-tag.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 7cfcd5c355..d8667c569a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2367,6 +2367,8 @@ static int get_object(struct ref_array_item *ref, int deref,
 	int eaten = 0;
 	int ret;
 
+	oi->maybe_object = NULL;
+
 	if (oi->info.contentp) {
 		/* We need to know that to use parse_object_buffer properly */
 		oi->info.sizep = &oi->size;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 10835631ca..d1388cfdf4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2332,4 +2332,24 @@ test_expect_success 'If tag cannot be created then tag message file is not unlin
 	test_path_exists .git/TAG_EDITMSG
 '
 
+test_expect_success 'annotated tag version sort' '
+	git tag -a -m "sample 1.0" vsample-1.0 &&
+	git tag -a -m "sample 2.0" vsample-2.0 &&
+	git tag -a -m "sample 10.0" vsample-10.0 &&
+	cat >expect <<-EOF &&
+	vsample-1.0
+	vsample-2.0
+	vsample-10.0
+	EOF
+
+	git tag --list --sort=version:tag vsample-\* >actual &&
+	test_cmp expect actual &&
+
+	# Ensure that we also handle this case alright in the case we have the
+	# peeled values cached e.g. via the packed-refs file.
+	git pack-refs --all &&
+	git tag --list --sort=version:tag vsample-\* &&
+	test_cmp expect actual
+'
+
 test_done

---
base-commit: 0b2c6cbdc7ac42a10094102781112b122cbc2b88
change-id: 20251104-b4-pks-ref-filter-fixup-048013766635

