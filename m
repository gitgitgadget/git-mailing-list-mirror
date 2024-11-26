Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B7192B96
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603397; cv=none; b=AEU3ojBWpXUF/HUXWhyoFGnPjR5EA6UCm5y4c/VhRSSYnvTf4fyen+7aOhS2x0M3STg5i2Raiu51ivnhFdT6qwC28Qs3bfSjDCHdyJ/bFqp/s3c83LnzLHWCDjHQvPBbuBVTM8/KfekBqzWopGOIDd3MqVfgHaU/9KEwVeDGvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603397; c=relaxed/simple;
	bh=TcZnBRzW8ug0Ms+nJ4aZxM5qOe0YNDVDDbsX31N/3ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRPDm6mjBlPcxWPaDm7KbOclbMbTLg0p5c1lFBC7SaswN7B2yFe9HWndBk1KmkheZctQ6uyn1cac6E7zL5JwuIbvd6pygIZHcoMSKv7wtpnb6uUI/RZR5C0XoFlqtOlb9zEJbIjgOc97GaKsND/rZZl1mMo7gYl/cLDZVV0qtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CLgMuQz6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dluf6Icu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CLgMuQz6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dluf6Icu"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B63F1140195;
	Tue, 26 Nov 2024 01:43:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 26 Nov 2024 01:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603395;
	 x=1732689795; bh=Msflp6uCQEerTTNcabEtzkLfRmj3FmMpoD+7j9+/N/g=; b=
	CLgMuQz6p+g6rV5Bj7RU80eXIUE5O/efm1O+MEVtHuVvrClP2L7i3v7WBpfSLjRd
	3D2C2GdfpknUpNKWMfnA+MIChER+Rcx5+jmEpOr8StrGunydrnpOAWkxUXj12f70
	UWnp9S6zI10qBMKdoyeAI7YX6pPFnt2OFeMNMuStSYC7lvCowxTG5cS1eeIpyT09
	uCl6dRhU3qXX+Ov+TeLsQoZd7D1j2dI3kWtNOAs8HODoTEewKogEbOossLrvCQFB
	CRQU5zd2/OOik2J4kpvtv3HuPfSVnm+E3YSz75jkbNHLj+9FR8Kwa0dvPDSI6oF8
	7dsRiNgmG7j99VakND+Abw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603395; x=
	1732689795; bh=Msflp6uCQEerTTNcabEtzkLfRmj3FmMpoD+7j9+/N/g=; b=D
	luf6IcuPpZEVuVWT49zEBKoE8Sy0hQaKvSSoLe0oMRKVfj2sMvaNbsZW01iYLS1r
	LV7dWN/Udu8y6BAsfn+tii8muno60kSyGphXQl27/AY66bUxIooi3+7w81UufEo3
	kmSrnYkjziL5GhYTmWxMX3YKTKpMRKOOqZmG6D1BkKIav4PXwEJvMB8dBXdd87Z/
	O5EoNZ1UPMArs8NvdCQ79CPEfyEaOuas0UgguHoarhC2YLsSF8yaipdziFS8I8mZ
	02Obaq4fmpp3MDPzso3Rh2qj0BOAyA7ChOb+M9QUCqMvoAwUtE/jtQQCrr9Jk2Ui
	UpRJXsRXci1yGEs7uewjA==
X-ME-Sender: <xms:Am5FZ8aC3VHJq0E1DL8I3phjLrvyVIR30vTQ-thHwszZc8zwkFZsgQ>
    <xme:Am5FZ3auTGn6o90ScY0hBIP5t9eOnVZ-XHOMJeln7qKjlI1o7H3qRZIHZVL8R-7LJ
    q11Uxri52gPuQTFuA>
X-ME-Received: <xmr:Am5FZ2-kjNr2RBdcH5546rMpFsm4-TUPBhv6q-Toghpg2wnaL6kUX-nRmTZBXtJgdR8WFpB2KSAKy1Kqo3OfXctfujCNj7DzU8z45yZ8nsrje5K1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Am5FZ2op1YZipbjUdRH0FbKhxbYSBSdQ__SvxOpRmF95_2kA3_y5EA>
    <xmx:A25FZ3qi80HpHx4-njT6UhhaaLpZT7xlcwmy3CX-6fMClNwBlDhB_w>
    <xmx:A25FZ0RmFA5_l8jBTZGbcqwk0SNY654cvsnwg6NhQT-4dqmiKyrrSA>
    <xmx:A25FZ3o03gOkjkhC1X7x4X5D4yNfxgmn_g04AHfKzto7DBoNAsg_RQ>
    <xmx:A25FZ2XQoWXChkug2ZDKlwlWoH-amfBZSicFGChxCBwy6vmKW1jDb6xV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 154b1dfe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:42:59 +0100
Subject: [PATCH v4 08/10] reftable/stack: add mechanism to notify callers
 on reload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-8-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Reftable stacks are reloaded in two cases:

  - When calling `reftable_stack_reload()`, if the stat-cache tells us
    that the stack has been modified.

  - When committing a reftable addition.

While callers can figure out the second case, they do not have a
mechanism to figure out whether `reftable_stack_reload()` led to an
actual reload of the on-disk data. All they can do is thus to assume
that data is always being reloaded in that case.

Improve the situation by introducing a new `on_reload()` callback to the
reftable options. If provided, the function will be invoked every time
the stack has indeed been reloaded. This allows callers to invalidate
data that depends on the current stack data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h | 9 +++++++++
 reftable/stack.c           | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index c85ef5a5bd14595d75f99457fef4407040e197c5..5f9afa620bb00de66c311765fb0ae8c6f56401ae 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -68,6 +68,15 @@ struct reftable_write_options {
 	 * fsync(3P) when unset.
 	 */
 	int (*fsync)(int fd);
+
+	/*
+	 * Callback function to execute whenever the stack is being reloaded.
+	 * This can be used e.g. to discard cached information that relies on
+	 * the old stack's data. The payload data will be passed as argument to
+	 * the callback.
+	 */
+	void (*on_reload)(void *payload);
+	void *on_reload_payload;
 };
 
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index d97b64a40d4ad05cfd9e6f33e8ba1e713281ef6d..5384ca9de0d1f064aebcb09308a74cc397b37463 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -548,6 +548,10 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		close(fd);
 	free_names(names);
 	free_names(names_after);
+
+	if (st->opts.on_reload)
+		st->opts.on_reload(st->opts.on_reload_payload);
+
 	return err;
 }
 

-- 
2.47.0.366.gd4f858ca17.dirty

