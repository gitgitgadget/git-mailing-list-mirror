Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687232A839
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597111; cv=none; b=RqBofOgDi9kZvpJ2itFsRcoWHjizsw9xrRkGqSm/DkZc3h4GIUOseMQf2k5kiZA+9Z2Op1yIb0gXqYht5yBB64jSN/WKO+hjShkwGwcOCv728sIZqYUv/cLIrFJljPbI2zbRKTLda58gD4fJkheJpzZCnUXX218LKgL6labtCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597111; c=relaxed/simple;
	bh=f6ks4VsRETSG+D3HfcBfjAlubIeH860CRg9me12MmIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjBdusOwrm133jO+hXTFemLMEBUvf2kfLNbMB46hCI/jV1hZnJLEcBXCmXNRfAWmqByLlDQ+3pkn2sw4TFBvV1LgrM7dP6zZXhiNPPrPRvcCj3TyeHE82lHLgjsphlzDFEjYhoJY9CVjKMnV0BF3SRrbfhrdKpmMfMO7OwQAclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sS+ZoG8u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AalpGAFY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sS+ZoG8u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AalpGAFY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CC2614000CE;
	Thu, 11 Sep 2025 09:25:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 11 Sep 2025 09:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757597108;
	 x=1757683508; bh=eJ8a6zUBLrivoVN3h43aPEJbRhJig7yfdhLEx9mjzL4=; b=
	sS+ZoG8u8yFhOBpFNCW0ilsov7iMLXRwx8f+rkQ2Z39HoncNVL0NdK5BY6c6F6TV
	nNMcmB+1QL4KqdYK3qHKyKtGMRoX1Tw5vRuhLw7JFjERliNUPtuwmskBlwWL1ihC
	ORlDoCMHI2KzR6Usr2hWLAFfAgouq7k6hO4rXgZeXB4Qk2VfnUClJ/6bUgZwGDci
	bZ9gmDrjlFL2eAFJzbXhNsoosYdyO6cBWFntgx5TYGuvYvoPaCsOoG/WBa3JawyT
	Bw6l9zUpAVjydymup7ryvO/kiOlVIdf1FoYutN2s/2c92mMlalJph2iVUJIocYb9
	7NmpWoDnKwHHkMX43EFO/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757597108; x=
	1757683508; bh=eJ8a6zUBLrivoVN3h43aPEJbRhJig7yfdhLEx9mjzL4=; b=A
	alpGAFY60rMyKT9kkkqnjXYjN+q8A63R6msRr0pmT0YsQzzY8zY9LnBiXqX60iJ5
	RcVDBmvTeb2yf8+jlPj2r3zMiwqJU4oLCovrmHU8/A4Xu6STZ5Jpfwc0GyAo8miK
	HdnOPqO8SR4NE/i6RJjCWQDKv2UFASe13rOE8jxPOltHLTCKPWA+6xaMp2RVZ092
	z/aRf2aVaNWqRh6pOgV8J16w1gOrGidhSlVA+eSeycfFjkXa2tWj+WF68r0T+OQy
	jFdXMX4s8Qv0yUkdbjHVAXp9khoHMemSawwjwgbykxIl+JnkmLH9OKic3Nf+J9YV
	3PDBJcCVoEOFuC15ciU8Q==
X-ME-Sender: <xms:tM3CaO38R8k_nVrSHWXYu3vwLhxd93ZKRCHx8W-TzL2uaL4xlf5KYA>
    <xme:tM3CaEWn3UVa2nvqHB76oLmVA0yzogBJHyWPHmolEAL4z9iT5HCZxkhIv0G_9uCJQ
    GgvN2kwqVHvu2S35w>
X-ME-Received: <xmr:tM3CaAW6DtYKLpNHE_iUFlYa9CWh9zmc5QrGvs5oixjrBcunTW_8TuCF-JupUBpCxHjVs7zZJcdiV4R6NXA2uByWTsCMbnHHnUDW_Ubyeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tM3CaLctY5ws62igzoHlCYBbzi6pHj8pnOFzBjh_NbOuScWfx43nfA>
    <xmx:tM3CaBVikpLjwoRaNi7Hpk7w9FvKv9-8qV_dvm1uCYQKQtzAXk54kQ>
    <xmx:tM3CaMeqofspZm168bHIX5T63pua1YWzSjtacKstpOn-N-F4arkNSQ>
    <xmx:tM3CaFNB58eWW0iCbtrbmCles1m-CXJSOjunYdVjQMEf1wzp5kWIgA>
    <xmx:tM3CaA8EDZkuc_EQL_yKdXOKhFQ7kRtPOW4VR1qrOq_ve5VIxVe81IrD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 09:25:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57fbdf56 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 13:25:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Sep 2025 15:24:56 +0200
Subject: [PATCH 3/5] builtin/config: do not die in `get_color()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-pks-config-color-v1-3-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
In-Reply-To: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.51.0.450.g87641ccf93.dirty

