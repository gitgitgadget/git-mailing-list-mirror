Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DF309DDF
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546397; cv=none; b=r2m3yD9p5M8FddHc1vFFNgMMPihOv/MrXcrFFo0so0FgqEWRuUjxqkdvfaJQHByH54NQz5cqh18v7PLDCFUZrAC0lhmcfZ7Hnt9a368YNtT5lD+VC2h+cfIDpgJ/1T3qZDJDuzD4RFiOMsOOt8cT+AVMV01PqOBKqEQdGoSWe/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546397; c=relaxed/simple;
	bh=bkT9CRqfAlRS/wdHbgIf7n4ofkmQ6qVxTupHASv0cSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YABEb55YDyqZ9BZarZTKvh5tYR0Ta5XRGpESU+YwuOHTN8gb8FmeM9ry24hIBYlHlv3EKotGBM/WdP3Qd04Gw+lUm745GbItio8OeNDsYctcHDBxNG1bAcHHfHlzkO76hUAGNL9+JX9yXmkIcET+h90ANLdrQ0S44qSzOcmmG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q1fSKIv5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=feVKGNjl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q1fSKIv5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="feVKGNjl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 397B81D000B8;
	Mon, 22 Sep 2025 09:06:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 09:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758546395;
	 x=1758632795; bh=4NQTWnOkYOsDEhHrdjtlNz8qFjihZ7I/Qeqb+f5Xv/A=; b=
	q1fSKIv5yxWbl5GJ0iiLif3oBUZ/c/nyg90Kfz0PvfADrsHxlclddSkviW/+JKzi
	g47tRwspqTJKC76HSY1R5AXtiyn/BKE5fXecWo3EZgd73/5ns2sQh2OvmU6OvopP
	/CLJyTWiOgq4Ix4T4Q/MzDzDx8phfR8S8qXq6mh4yTAmjjR+smbK+sAjoxNTBUJ9
	9C7zacWSjkF8dBqtPXda4CTKznuOjdooKXUoosbFcirB0XU508mkd0m7+NTyM7GP
	urM9kjpq65RcLQhorW9k8yNQm0E4AZA/UzQe2kB6p5xl4GuSfM/b+4+6vevVo61Z
	2Z5NSUcjTDKA7r3jaKIh+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758546395; x=
	1758632795; bh=4NQTWnOkYOsDEhHrdjtlNz8qFjihZ7I/Qeqb+f5Xv/A=; b=f
	eVKGNjlzec/8mNNbXaCUCKaawfrxcsbF4id5bgknjiCAigACa0Sm+W9/tXW8UZL/
	RAyg4WyzCvt/qewk+62e+Xc9DDu4Wst7pv4JyfeZhLXrknGFBDIUyy9c1xO/pfJe
	BzcaMFSs3vvqlWzyms4PBLBI7euBBw0COe6B6cxrdtl+C1Zcp+xuglgxbZ31fK9Z
	DSQ+OaxBdnxMOqLYsuAV4lWryieVJGl7b4mheZCr7MNzT3AlGtDEqVxZMFUPyow+
	3BFOY4E6HDl+Wl4VfOJJYqg5QnF3pQ+Q5cfrYn1/Kn389PUNCqktHpNGH8CmCgPm
	0rPxi04nX+LyC9T4hLuQw==
X-ME-Sender: <xms:2knRaCd7bCVfbDdkEzJ3joSGwolighMIOjuw4J-CdHIEm7MGqVtbNQ>
    <xme:2knRaGyHsy0WXWYIjbwguWlHAJEQJblWk7UmDUBrvLcoqfpYCAoqCuvBdaThdsapC
    EAdom8Ig72UJ8R1Dw>
X-ME-Received: <xmr:2knRaAG_yxngPcA7e21IhsznSITQqavTz_fHLNsdCq3CgGxr-HJxY4bEs1x5FNRcZ3NHGjT-4vTLCb7TwyYzIKr_5LvQ9L_liNBDpPsFzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefhueegleehfeejkedtffehvdfhvdetfefgtdduffduveevteegueeutdekhfegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2knRaCxviKlftIAN3o9ZC85jUQZwKjkkj6tRUlmCDqoNeE1I2XbsIw>
    <xmx:2knRaJsrH7ZSTVfE0d8-NqeXp2xXAiLmv81l_eC8OXeH01jN2ef5CQ>
    <xmx:2knRaH3mQbEwPvcD4uK5lVjHsnuvyd9N66SwOqGkJPIq_RyU2f3mqQ>
    <xmx:2knRaM9XjKrP5K3yzmSiILJQWr0k1A-SeIUYBP1DOaeN7vlN8Mavxw>
    <xmx:20nRaAtY_tYjQSbvDq3ZB99K5x91ldKOJTKLFcaNMf3BeJhUleqkGgQ_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:06:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb9c3138 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:06:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Sep 2025 15:06:21 +0200
Subject: [PATCH v4 4/5] builtin/config: special-case retrieving colors
 without a key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-pks-config-color-v4-4-28b7d2697eed@pks.im>
References: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
In-Reply-To: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
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

    - the user is asking for a color code; and

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
2.51.0.536.g15c5d4f767.dirty

