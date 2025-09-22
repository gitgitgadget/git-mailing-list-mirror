Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8130AAD6
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546395; cv=none; b=PljixBT9PpZkxC7j5pgDwrOMUn88L2/A0+p4rF0LWW4//tC6wI94T9wuUvhL3jjwzcig+mEpz9vgz8gPxmkDt9aUReZZeHTUD44K+g4wSb50P501wRUBaa5NLraocZFxeSmlbGWpEMQCcvvpFf1n7QvyCHrs65PQDDKGcEpBZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546395; c=relaxed/simple;
	bh=OEnTn5NpigkyA6bdvUN/nNe3q32PCCsfc4aBgOM+wA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJQPhlv7hWkiRjxe0CusoLQjg3jMapX06m5eWSYK7MfUfO6F5iPunlSlAn7Wbxq/PpHtBRFgD5u9Y05ZdeOfsH8g/kERTTiA4j3UE0rWpieGegyYO4zbCGvhSqn3wg5gMEaZH6dvyoyGsCMaJZjYO17QFUZtVqCBhUi9p3LbHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iiXBKGtg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=odIAXzPV; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iiXBKGtg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odIAXzPV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C84141D00238;
	Mon, 22 Sep 2025 09:06:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 09:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758546392;
	 x=1758632792; bh=eRZeQ1m34r1MD2Zuk1z/rFHqMb4+vFfbu7Ee8q7P9eQ=; b=
	iiXBKGtg27hJU6OCkHbS4ofkRa9xoi3d/lLdlPHPb9v5c4p/mha1w82t09UtgeWP
	kHztCZJ7kZ1u8YkcwOt4k8RkD1Q9lxYnTxdeOQBkxJP4yEqYnTdw2T4O6CC35KlI
	4yDbBaNNoHcXumk7nkSN1RqcHWSP+eJfaTB8hlHwuZysbcbW0ki7eJtbkzMQ1fOF
	hwJg+yIKEMjQpV+BKYLKY+S3LsVxSY++6x5yZ0+67H7cdQW0Ao/IBf+7dOSwqoxW
	6dD1UP/9Iia1YH/ZbLKEqMHxLMKtbXKB9Y8NnDftE2sqPy5Hdivp0M/fJRK7s7SK
	gqyEbYrv2O1pDZJlztA2gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758546392; x=
	1758632792; bh=eRZeQ1m34r1MD2Zuk1z/rFHqMb4+vFfbu7Ee8q7P9eQ=; b=o
	dIAXzPVfS7Ihqk5e0amJOHJhHqZ8tA40nlXKhdLXbgEfPmo5UuxNs5jr08vb97T7
	0MUF3i4LKyxrviDN0cNVb3/oFtEICGg5N6ucOyvP32r5IWUMkN43um/O5gnuhEyU
	jlhM1/z10+7WvLf1xDgopzchPb1vS22cOwIedl6rhd9rrfbkmoy9jMzfy6zRLs1x
	FA9mkzuIzjFPHOnQ9p6rhWnvKtgDnGLyAaR67v9BC2Q3nJu7KEvRq8+kx7zSlHq2
	UfBr2THSsjB5uy7p4Dk3gotUyWg/Gkpv95keMTKBTpyZrlgV+S6VP2caIJ1q1Zdd
	1ZwEjP183abHZ7N5JiSZw==
X-ME-Sender: <xms:2EnRaLJRbHZBG8lsg_4zJxi-STwM2mHikXNmezmW-jLYvWY9lgs8aw>
    <xme:2EnRaJvChtdzG3dmHxX7XmHZh8ipiwxL80o1Uc8ZUXGskXqc-nqcsY-Fz0Ja5GpkG
    0dsmpDpPUObURX5iA>
X-ME-Received: <xmr:2EnRaAQsPIHQC-Nb3qZR5kGKRWlkFAGY4NYmpZLxCd0vmSSX5ySYUsfC4Mx9WKKp-OXd2krWyB8xmbC_BXRcV0IfWCJcMqjGW960kJGRaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2EnRaHOLG8-XykMzgfyv-vM3ttkwCFuXyRqpmrhFCe4HSN5V7xhH1A>
    <xmx:2EnRaNb_nYSI8n0BfdzxS1rwF_U4wnonP6tYSsHNnh7fnnIdP9QrPg>
    <xmx:2EnRaJxFU2CDBdUl1PEeMo0CDP31rHHxI3066ZyN9m38VWw7c7Ph9Q>
    <xmx:2EnRaAKy-2IBWmri9xda9gBYHHrZwIt25BqeQfo17HfbZ6NUace1Lw>
    <xmx:2EnRaM4GdRG3qRac69F-h32vq_dXspjfrBX1NVOs7D5zhzWMA77HDlgB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:06:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0dd1d24 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:06:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Sep 2025 15:06:20 +0200
Subject: [PATCH v4 3/5] builtin/config: do not die in `get_color()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pks-config-color-v4-3-28b7d2697eed@pks.im>
References: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
In-Reply-To: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

When trying to parse an invalid color via `get_color()` we die. We're
about to introduce another caller in a subsequent commit though that has
its own error handling, so dying is a bit drastic there. Furthermore,
the only caller that we already have right now already knows to handle
errors in other branches that don't call `get_color()`.

Convert the function to instead return an error code to improve its
flexibility.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 59fb113b07..afd48bfa51 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -547,24 +547,31 @@ static int git_get_color_config(const char *var, const char *value,
 	return 0;
 }
 
-static void get_color(const struct config_location_options *opts,
+static int get_color(const struct config_location_options *opts,
 		      const char *var, const char *def_color)
 {
 	struct get_color_config_data data = {
 		.get_color_slot = var,
 		.parsed_color[0] = '\0',
 	};
+	int ret;
 
 	config_with_options(git_get_color_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
 
 	if (!data.get_color_found && def_color) {
-		if (color_parse(def_color, data.parsed_color) < 0)
-			die(_("unable to parse default color value"));
+		if (color_parse(def_color, data.parsed_color) < 0) {
+			ret = error(_("unable to parse default color value"));
+			goto out;
+		}
 	}
 
+	ret = 0;
+
+out:
 	fputs(data.parsed_color, stdout);
+	return ret;
 }
 
 struct get_colorbool_config_data {
@@ -1390,7 +1397,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
-		get_color(&location_opts, argv[0], argv[1]);
+		ret = get_color(&location_opts, argv[0], argv[1]);
 	}
 	else if (actions == ACTION_GET_COLORBOOL) {
 		check_argc(argc, 1, 2);

-- 
2.51.0.536.g15c5d4f767.dirty

