Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384F30CD92
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940788; cv=none; b=Vn3EPCxQ6l5alq7daMUD09yTcGvH89v5uu4YCV5ESLUFwRvL+M3eh9qfG1L8/+b3QGmT9w4AKnJEMssmSQ/djXfLwpVJlcDB7vWMovaXRnHX+5nV4qMdvT91CmLgQNnNjyHBpOfe308SMzGEdK08hmz2euNck3YoAmy408fueIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940788; c=relaxed/simple;
	bh=OLPnuE7nu4ADZxrS+fVcvW2P4VCOlWnlSTlG4UZLWec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1xYTArlubTbbq6074E+6i/9fIYA7zfgHBnl9sOgjaYniiYztQrPYknQNooh08/fCunYAf2E/O5+ezoPzxbKBwiN0EbFkF2V+aFtFVsFp8D+HCu2UDaPB1Q9yYhQs4Et8cepZfMhY9Qn6lp7kN4ocf3VIdVDYey8ihM1kerEi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c/3XXWDa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhWJ32vY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c/3XXWDa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhWJ32vY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B659EC0299;
	Mon, 15 Sep 2025 08:53:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 08:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757940785;
	 x=1758027185; bh=z5Hh+ZZnFYl4W70ggh0l0mRSOnR2zm/X376gykQiy64=; b=
	c/3XXWDa1dAMINIatLv19lq+qjhKHEhzQzL8wAPUGDnfiE5jZKW7VBgCaEl3nXNe
	7VHIZaZ/1w70qHCKQt93A0Mn6TzctCe3cIlmQ6d93vdd0Idpo2GuGNqMlH5nFFP5
	DUMo193qa+BxpuuQzDEvs1y1f3cIr9CjizkWZt68mxkXnPZ3fkLMqAisVIZiesBV
	YimXAPtd7egI6vl9kvMGWzxxQXzc8ujX7xfX4Odc0fMCl10rhj80ZqE5tM14xfvC
	sf7r+ZumQHY89yDy5A2u6uYfNlodjNs+8TDPJbUFW8HX5X6p5saLz1G/JOKz0MCH
	p60Xih+oS6kgsDXC9gJiew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757940785; x=
	1758027185; bh=z5Hh+ZZnFYl4W70ggh0l0mRSOnR2zm/X376gykQiy64=; b=Y
	hWJ32vYkUTSdXPHnCF0YobsddIujmT81uK9oYePdpuzJOh3/fsvzTwaXaNlzkvHM
	YtjSIbqCBrqva0t3AN1T4YroWYeUoWI9JZaY367AaAYGCxHsetEsB9STiQDJZRQf
	2PGZjJKPjaDHcOu/USH/gI/kE+gO6fSftzJa/vAD3O3k21YWba9ZFhItDlDeuRaK
	kApFIxDy9WHbTX2rpdFPCCuDvRhin3HsbAzgRX6JW6sV2KPLXGiLzWodK+zIWDB+
	YQNSBdH0HoS8B8YGSgaVfMFMYn4K0VFuepV+lP2k4PYvVOX3D0Z9zLyek8dFXKgJ
	O/QA4fSo873eCl1VDcl+A==
X-ME-Sender: <xms:MQzIaHxCi6z6BRL3X219m8J0SZLKqlegHwaVqqo_6LxCphv1A_G_Gg>
    <xme:MQzIaJ3EQNUVxIABSNsHrkEYHIyBIZzL4SssMnApXIeB00zI7369LTUT7a9uJ-7Bb
    pHvZcmOpas4LX-FQw>
X-ME-Received: <xmr:MQzIaN7SFD2rbUEyZziwY3heH3nwqIkswhaP4fuqKAw7aVrFKAU_MG4mNY7gDFoXIXIkqOUxj8mt07N7MJlw3cm1emiekh92UFsalMI9uPK6FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefhueegleehfeejkedtffehvdfhvdetfefgtdduffduveevteegueeutdekhfegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsiigvuggvrhdrug
    gvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MQzIaEVyOk2DufoPwkYbvgI_lNR-jRNmONwQ8sL7z-45lXmmHZtZAQ>
    <xmx:MQzIaEDzvuBawPDXJD2ucGm8G7kQ8Cz8H6tqj9470CG2EtzUD4AgBA>
    <xmx:MQzIaL4lxIZx0-OPjjgRxP4bnfcYlPm7dejaeD1ulcwt6J22Mkp5nQ>
    <xmx:MQzIaHyswUVCd1g88RvSqTLUoXBW-TYIULCTk8O2JS3wZjbhEPn1sg>
    <xmx:MQzIaNvgqJClkdRDJ2vzt7EIvEB8TWh4KjMdr6ghRmIjn2-SZHP7bIIM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 08:53:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 948a7974 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 12:53:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 14:52:51 +0200
Subject: [PATCH v2 4/5] builtin/config: special-case retrieving colors
 without a key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250915-pks-config-color-v2-4-e4290bd8d13c@pks.im>
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
In-Reply-To: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Our documentation for git-config(1) has a section where it explains how
to parse and use colors as Git would configure them. In order to get the
ANSI color escape sequence to reset the colors to normal we recommend
the following command:

    $ git config get --type=color --default="reset" ""

This command is not supposed to parse any configuration keys. Instead,
it is expected to parse the "reset" default value and turn it into a
proper ANSI color escape sequence.

It was reported though [1] that this command doesn't work:

    $ git config get --type=color --default="reset" ""
    error: key does not contain a section:

This error was introduced in 4e51389000 (builtin/config: introduce "get"
subcommand, 2024-05-06), where we introduced the "get" subcommand to
retrieve configuration values. The preimage of that commit used `git
config --get-color "" "reset"` instead, which still works.

This use case is really quite specific to parsing colors, as it wouldn't
make sense to give git-config(1) a default value and an empty config key
only to return that default value unmodified. But with `--type=color` we
don't return the value directly; we instead parse the value into an ANSI
escape sequence.

As such, we can easily special-case this one use case:

    - If the provided config key is empty;

    - the user is asking for a color code and the user; and

    - the user has provided a default value,

then we call `get_color()` directly. Do so to make the documented
command work as expected.

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
index 6d1015acfd..3cf5d17aba 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1083,11 +1083,22 @@ test_expect_success 'get --type=color' '
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
 	cat >expect <<\EOF &&
 [foo]

-- 
2.51.0.450.g87641ccf93.dirty

