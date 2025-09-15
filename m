Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72013307AC5
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940785; cv=none; b=mQFfwDH09nuqIOdWI7GOenmjDAzyNx82KGZwnfYZh8youOQi21oujdcwTPkuVq+77gBc8CwnzupvdG6HiksQXXG3aHaXirkLe+Tk8REW3aDlg4tr0WHrluUWC4u//R7o2QXGOUJ/Jr7UMcz/RnDmscus/iFvS64xx3kRnfnMNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940785; c=relaxed/simple;
	bh=f6ks4VsRETSG+D3HfcBfjAlubIeH860CRg9me12MmIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A0c9g7TE8ywZJ7RhK/0iEsjIF3CeBl6oXs4+pEtmoEmMC3J6AhSQRXBYwcagFwjZ+i1e3j3Rd3Mr8afcsRZGBfu1ZXpaqzUCGFFxMaFw/vOuJ1IWNbnkcaPxp9sGGM/a2vV/G1TDPmpV8kEaYDd14rROf/6qkSt59NkGzMfU5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SWS/j0Ry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxlexGGk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SWS/j0Ry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxlexGGk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7EA341400199;
	Mon, 15 Sep 2025 08:53:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 15 Sep 2025 08:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757940782;
	 x=1758027182; bh=eJ8a6zUBLrivoVN3h43aPEJbRhJig7yfdhLEx9mjzL4=; b=
	SWS/j0Ryhtl0dOJaWdtxo9eKSh6AiqF2rVn2DmvmlMcq8/uRBy1iG08ZqqdNBwwW
	dZCU+MzvvMfTxdvzgMVx0zPkLOOdCtFYj2RfCWvH6Eia83vUvkN+YzaSIkMB870C
	VJ/7qk6SoxSy9SuT2xgbgmKLDxBkwlN9gtmK+VGrHye/M79EGk8CEL3f7H6UhrxY
	ynNy/X1Kzoq4MaEyKsGoHDextqEWXa1s+cZU8IB7pU7AJSDf5L6VTRGB8L8ejOZA
	QbR8PLuNXtGBHPRLoQy5YotH4Gp4V/+5GslyTVoJOIte5mTtLO5UYkcnpLt3d0l/
	c6hZOpTRHvjfdQ5vwq65cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757940782; x=
	1758027182; bh=eJ8a6zUBLrivoVN3h43aPEJbRhJig7yfdhLEx9mjzL4=; b=X
	xlexGGkjgCzkVK/U7Gtpz5pUHY4ZB9xyu6vRpbY70Aqet3vxgDnv5PQ/TPM6/tsP
	0MHcsjPdKaXmyjcyumDEC4gebmHcWsHQWomk2hBkMkJx6ZkjOOkQJ3sEVRQipjWw
	AN2S1btlRMI87sxqXXf6l1qNWQ7f/AtpU6UL/lLmiBGyr6YNJQHoANd7JOzfkD/4
	WY14cZ9f0YwCPWeUg7zaUsoIltVnT/6rPP2iik+c8sAjqc8rVUM36WsbPe+T3zzz
	Bv2x1j7+ucykeYOmAj43RsE4LrPpt+inw/vJXIY7VPnVkL+uK6y+7gWlqeuwbnZR
	cJeWzv9RnRLmRVkFAM76w==
X-ME-Sender: <xms:LgzIaPBaPgpQ3iR6fuB8Txv7ARWbzwVrR0gTOURewKBMDBFanq92ZQ>
    <xme:LgzIaAFmasWw7pPHwrN5EiXd-aGx-jwD8bfn7775Lhgd58o7v2fZgrecTAW3hSstS
    bep-b2zAMJUZnvJjg>
X-ME-Received: <xmr:LgzIaHJi_mUiua3Vv04W9wDIdmCcqN04PHq6T5SBAe-ZHXym7oNZwn5QiC5iqBpw6Evsm2wIeU1Hf8OHnPuuc2_LZ5_ogsp8hNd-qkdvDDg4EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LgzIaEmMG0Rpr0tlsuTRGLwveMW-wYkMlGZRsZAD7AZDYFFhH5g40w>
    <xmx:LgzIaPSepq-3x68uMiEqqafx-Oc_3UDSYdGKTQLMmfXsqj7EVi-k6w>
    <xmx:LgzIaGL5myWRrXNv1fYQwmfhjCGUACTQuIjAU_ra8VUYeKAgsfbk3Q>
    <xmx:LgzIaFAh_CKoU_rvdGOmJbgY1uT1ICB6qOZsjzHEtsEChEi0PalE0g>
    <xmx:LgzIaN8nqZ1yNMZH3uvWg2UnS1raFAL9Sa04AGjcVYPsGOX9eG35fr0z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 08:53:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61c39c88 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 12:53:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 14:52:50 +0200
Subject: [PATCH v2 3/5] builtin/config: do not die in `get_color()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pks-config-color-v2-3-e4290bd8d13c@pks.im>
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
In-Reply-To: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
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
2.51.0.450.g87641ccf93.dirty

