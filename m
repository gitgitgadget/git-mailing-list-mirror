Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34122D73BF
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176077; cv=none; b=etbhEKrkBofwKVERDB+xdApmcW/2ue5p7ZFKtm1YoX4eJq+EBLbXDDyLTuWmqUU5T0CIBCy1CXit4R/6KNxJVEoICYGxwtpXEL99anMQ0PuCepNRViDpSIE8OsHYjbtR5FDGBk9nEnL5Ajw/8y6YeVZLJDxo1onjB20SPRQY59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176077; c=relaxed/simple;
	bh=G9T6twEsD+iHM5VApfxTYZ6oHC2sCn6Aiby7sTDjtoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfealqjZ71u2om2/gK/hIJGjULfLg206xEloGrnAe3BlUpTx6IhCF8PUir8m9x4Vp334zbpXQe4Vhmw8oxcHX5e5gmz2xH2ysRwHKPGCxzHj14ZxBJXCxgCbFTXpn4dcO3EhlJG6PDz55IgOgc4j11vf9WnHG/TSuBBXLp6NWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hA8+9JAx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jv5k3zrD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hA8+9JAx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jv5k3zrD"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2ED5F1400273;
	Thu, 18 Sep 2025 02:14:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 02:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758176075;
	 x=1758262475; bh=QsJL9JTCgrTqxIYOM+mAMRlnDqLTRsDljiH+kdfg45E=; b=
	hA8+9JAxEEueZCxwonj3eVq7keYlVcLTp2rBSovtPUm1hl07cgHjGr7k/5UHFVMO
	U3E3+qix1TispRW78Y7eS0islR+VXkQpYfGUkF7IahHdlF6qdz3yt4+AEBnvQxoD
	BDez/hW90oZAxL/zH7oULvsr5pQtcV0fHI71fotM1bauHqstacEKTj43/wMaFUYi
	4PBrAHA1tn5J2A8zqDcD+IaFQB1DCRr5lIa7d/UbBJQJzGL3Qgi9cLQ6onorwem4
	EDnRzjwloDm2Bv5iKnSnHsZuX6DvSkmwfQWS3PmJrpO9/xWbI3bUMheMusb1WrKX
	tPEF3KO2dZy5OUZpv9CUYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758176075; x=
	1758262475; bh=QsJL9JTCgrTqxIYOM+mAMRlnDqLTRsDljiH+kdfg45E=; b=j
	v5k3zrDKZzO5i3W0M6WmIT6X+SL0HAvpy4KFk3tsP4m5/XS5yMmmOnG4fkcKdaZ2
	963Wr6qJFXEmciOpiJ7hMcuKpY2AyXPFLLZsXq6Xi4qmJuYNQ/DnWUbYHhga6xeq
	ihUdQ0kwIVfa/0BucimtuaJIzK0GlY2Pr9/OyPjEN9+wtafAHXeJ+nK06o9ZZ0Yl
	CehDEvSYaH7uHI7a/DuEAryl2NeuvGJ7zlsu+5hTiRLY9lGWT9ZmG5zGGON6gSiQ
	WnZ882WeGTYMej4Eo2fJ6X3heOE2YE71ripjDPYPD+i/A8ctLiIEmlVjWATToIRa
	vGKzIqLWvuTYyltCGnQBQ==
X-ME-Sender: <xms:SqPLaP4aF8BrDG2ybsegdXpzTULLr9W-LJvjL77daUiFazlCVyRtxg>
    <xme:SqPLaPe_KCCTTW1kF7jiXujTKknnJiqVfjjkRR985N22_K1I5fOaOPZvPqOcGGSYR
    y9eiHD0JUqHqfDnJg>
X-ME-Received: <xmr:SqPLaDC0pVCu37HUURupMWuvr-t5OQbgRUzaIkQ4VSAP8SM3ZaWKAOlWjiVRSyaJIX4vRJze2_A4CAlonUgTiwbZunSjN_Af9HT1i3HdOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:S6PLaC8O8p_NQNOZIE97bX-MVUXc6T4NCo-hZbootKR5NpFyQ1uL2g>
    <xmx:S6PLaOKRuLZ0UpSyi-NnxiXqR40KWmThjmtQcViY_VVc_1tYgcIXRA>
    <xmx:S6PLaLg86p9atewaVqCoadVPViODQPfN8Lx651b9-yuSoPjrt_BnzA>
    <xmx:S6PLaO4QFi40qQKIe8RSbFuM45wmhFpSaCfzS4SeLqkhRvxAtReiTA>
    <xmx:S6PLaPr9XTWn0zIFP4OcgYbxhTDxa-ko1tN4KBEB6Gu6He73UhD4a1sA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 02:14:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62529e27 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 06:14:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Sep 2025 08:14:21 +0200
Subject: [PATCH v3 3/5] builtin/config: do not die in `get_color()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pks-config-color-v3-3-08ea618cae26@pks.im>
References: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
In-Reply-To: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
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
2.51.0.534.gc79095c0ca.dirty

