Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BA32A82E
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597114; cv=none; b=jxmD+qr49QHMcJEgd3PE55lPb1KC+peIqiFGE+UNnWswbhda4vEUmFCF/0rzA2yXQH2Av9oFItvlCzesQ101RzKrxxsW7v0Vr6bVRYZ7uK1ByUGKfbjWYgrbJZCEgaH2VKrD8TUP6ET3XP9ZrO7LeRhdNxakgcSlmHg9RJB2O88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597114; c=relaxed/simple;
	bh=aTBdZASlNifImEzpvOAbzQNVc8/Nmz+yGhZBuBm8xcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NfDYeeZj2bl6U4Zma68SX4WI37OvqNoMldeNbWUvvL51T6sp/8g+WzRyL9ZQAcCc5Y8pDeKu8kGiKdPL8VIFjua0dFgPgyLFU97hJSsrV+mAJWKCaQSLM37smzzRSXpnTZnMg10R0TP5C+tFMsoTbvWamDFOLhN6rHo9pd69QKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M5CH8quo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AitB2pJT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M5CH8quo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AitB2pJT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87FA514000CC;
	Thu, 11 Sep 2025 09:25:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 11 Sep 2025 09:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757597111;
	 x=1757683511; bh=31ESb8OV3lXmaGIJcMYbnddkKJ6j8K2xyzRJdLNPUEk=; b=
	M5CH8quoe6Bz2uyAxVeuE0DzrUvpvLxGrEGux9hAOvk8ZkN26jLAO1bX65NM0ES6
	7FTNCO+dVCiGyatxXLh+7+nASCO5Pp1tOAikKpjsYjfPlOXK0MJlJNffP5fbTiAY
	6NAmNeX08mBL2RgoRucD3h5MM7zHSAeE0w+gP0H7ZgXzv8f1vNHYn1qKbyfI2o2O
	gYBqc/jOO5+3mwrIEIDSR8zBVkERF0fUc4Jp/RCsGQSCyGRKEqKGgoDITjDpdvtV
	FBpvpnrfD7iiePmOjeHXMDpiePob48/f1zzPtqTeGairksr6+X/Ip5EWwPfMp5fT
	83UhywzBPYn3kSSccVJJhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757597111; x=
	1757683511; bh=31ESb8OV3lXmaGIJcMYbnddkKJ6j8K2xyzRJdLNPUEk=; b=A
	itB2pJT8zOI1dv9xKsaoN6oyrt/W0Cihoo7c4F4kM+qXSfPp227lyKQ8D+nwQrIE
	NIzPqFmie37sVMjyaWuDT+RN/CkRiksW0+pwmYGt3pry+vIgWVJvo7KBbvzj7ZPi
	8TIRupR7ooW0wWfo8Wl/MdOXhd0Pw7wVy9txzc+QSHmAR5JS0iceAo3uISE2O0ss
	vQwBGZ2/YuLaAMs8a8PBDTXu+n1CUsaMVaHmMsFaoCgQeVJvCkuBodS9AG/+Bk3a
	UKIvErXXOpRy8cehBOuTExFDNvEIEGV9NclRaTEM/4Y4xMmrWCKqTCbsmx/BDNA+
	KDvn3oxkGos0DkCxekj0Q==
X-ME-Sender: <xms:t83CaCB5LncrjKjrkSKsb6K1n_TIwZq93YQWJJIVzaWJPHzybhRfMw>
    <xme:t83CaPxamh1Ih01TBtA4iraREd-hUHmkdyQZdUGG1j7SpDwMHJ8K1sEDHmVEFTukc
    YbonvM_16LgxWeGVw>
X-ME-Received: <xmr:t83CaPCokZlMkN6H0CPoO-SB3_JywqAOWAaMOs6-ic5AbTNMDKnU6zpe3COHmPZKpNkmQtI4o1__lcIOZ-sDGAF4iExBDAGTBDGyiB0P9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:t83CaMYJboihB5r44nseVoeLI9eDx87vLQcXCAlbeDBZi26lir7sNw>
    <xmx:t83CaHiOu7R94HPmaJhFA4Iz6trQEfDOjVtfm4ZzygSROLUrHyp1ww>
    <xmx:t83CaO6CTkrjOEhQ0416YgSbNHGvozw00GRdP5hrFmIHEAIGnbHVaQ>
    <xmx:t83CaO5TpqfHwGHknWzHOKhV9sxZ5pIUoK7mZUUoQdSP5J_f_j49Qw>
    <xmx:t83CaIbiM6Ro5Gl2BaWVQZNhcxyrzB-ERMqBdwptaE7ILgSL5zTYvRC1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 09:25:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a8cbc7b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 13:25:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Sep 2025 15:24:57 +0200
Subject: [PATCH 4/5] builtin/config: special-case retrieving colors without
 a key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-pks-config-color-v1-4-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
In-Reply-To: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Our documentation for git-config(1) has a section where it explains how
to parse and use colors as Git would configure them. In order to get the
ANSI color escape sequence to reset the colors to normal we recommend
the following command:

    $ git config get --type=color --default="reset" ""

What this command is supposed to do is to not parse any configuration
key at all. Instead, it is expected to parse the "reset" default value
and turn it into a proper ANSI color escape sequence.

It was reported though [1] that this command doesn't work:

    $ git config get --type=color --default="reset" ""
    error: key does not contain a section:

This error was introduced with 4e51389000 (builtin/config: introduce
"get" subcommand, 2024-05-06), where we introduced the new "get"
subcommand to retrieve configuration values. The preimage of that commit
used `git config --get-color "" "reset"` instead, which still works
nowadays.

This use case is really quite specific to parsing colors, as it wouldn't
make sense to give git-config(1) a default value and an empty config key
only to return that default value unmodified. But with `--type=color` we
don't return the value directly, but we instead parse the value into an
ANSI escape sequence.

As such, we can easily special-case this one use case: if the provided
config key is empty, the user is asking for a color code and the user
has provided a value, then we call `get_color()` directly. Do so to
make the documented command work as expected.

[1]: <aI+oQvQgnNtC6DVw@szeder.dev>

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  |  2 ++
 t/t1300-config.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index afd48bfa51..f50c11df57 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -923,6 +923,8 @@ static int cmd_config_get(int argc, const char **argv, const char *prefix,
 
 	if (url)
 		ret = get_urlmatch(&location_opts, &display_opts, argv[0], url);
+	else if (display_opts.type == TYPE_COLOR && !strlen(argv[0]) && display_opts.default_value)
+		ret = get_color(&location_opts, "", display_opts.default_value);
 	else
 		ret = get_value(&location_opts, &display_opts, argv[0], value_pattern,
 				get_value_flags, flags);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9c405e9532..40f170cf40 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1084,11 +1084,22 @@ test_expect_success 'get --type=color' '
 	rm .git/config &&
 	git config ${mode_set} foo.color "red" &&
 	git config --get --type=color foo.color >actual.raw &&
+	git config get --type=color foo.color >actual-subcommand.raw &&
+	test_cmp actual.raw actual-subcommand.raw &&
 	test_decode_color <actual.raw >actual &&
 	echo "<RED>" >expect &&
 	test_cmp expect actual
 '
 
+test_expect_success 'get --type=color with default value only' '
+	git config --get-color "" "red" >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	echo "<RED>" >expect &&
+	test_cmp expect actual &&
+	git config get --type=color --default="red" "" >actual-subcommand.raw &&
+	test_cmp actual.raw actual-subcommand.raw
+'
+
 test_expect_success 'set --type=color' '
 	cat >expect <<EOF &&
 [foo]

-- 
2.51.0.450.g87641ccf93.dirty

