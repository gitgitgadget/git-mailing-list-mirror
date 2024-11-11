Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED741990D3
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321544; cv=none; b=nWaRiW6Ht0hQVhpv0mVX0xDr9kSUHBDRkO6w1U8m81u66J4/oHlGNI9NQnXstwKztvNOZa09WBjzcDwv8h7v/lmWVcBjabOW/AFZxH7arsfAVlPvhSdQz8WPFXIZjTH0KRUdncZoUlb7zr9BQtoX+zvBxzCL3xo2s75etJQB95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321544; c=relaxed/simple;
	bh=t9s1f0P09X2ttec0jm6oxbKXUe5LWBtKDDbBgKwg1i4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghRP1KBqAJdWdKT3CI7pGPmEIzxKTBA4ZY3FOfQXIm6VSSEffqkXle+hXNy2O9eopoxvZHQKxrW+kImJkjefOx31rDAWlcnzGYHfHADg2HIIUIAXmJNG3/po68HQEjepizo87fErwPtnnCdq/som4EW9+/qY0EfDPeDBRAgejAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z24WEcOi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A7eTxjRB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z24WEcOi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A7eTxjRB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5666114010D;
	Mon, 11 Nov 2024 05:39:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 05:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321541;
	 x=1731407941; bh=87cCTadsVY17WX2PtQfwqBdGRivChSdHz6wilPPlcYk=; b=
	Z24WEcOi8JeHPJUE4KXz7eV+4vGPzQ1Bw0CCJJyZ28Gu/0dWQcEiscuSij4byYI5
	RrPvdNw9u38HSVLV2UyNChvhyR4JnVFJtZHRqJJI9HY9YY9VeqRssMR+U/x3C4vS
	C94WghCpCivm1eyXHWE1Hd/JLt68JgtB3Ybokh1ZerLjimFS44k4Q843qKyWTleT
	pMlRdbKM4MhBL2x2ntypznoq3DuBJd+mlRTmyMcs15LNzWhTs3nLJevH7i3CbW5c
	HtJEmNOhZHOlr8IlfDnJ0TXoupbuxGBTopYWWtbpBt8COm1BDSJc6tPE8hyVANLT
	eXfz4wFgnNE2Gjp6pXsE1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321541; x=
	1731407941; bh=87cCTadsVY17WX2PtQfwqBdGRivChSdHz6wilPPlcYk=; b=A
	7eTxjRBdfUhEryMSIJPY2VHBdQiZHfIXMWQTRXsKo+cPrrFm0R+tQp7r7n8GNHA+
	68z2Ak/yGyP1rk0bihu23zEIGSvvnnvoipeRRKGPjJDApcNRwJK6YRFY9EAbpCTt
	HDXel3GyZV/Ncl9HtbFPSeJHbn0/5mftW88fColCcECd+rdKdqdQIRaSFV6quJ9R
	WwqTKKCPO/rGjhQbKjmQIAXXwOi9DhlhC2tcUoWK9k2YwIRM2lgubvLfX9QtQao8
	I4yDhzFbnJqd6Vp/MZIjMHW2XoaktRf1K4tP+6veoAqSUhnywMZkZzD0lHFnOrAR
	TFQxJm4P6fChoSD5wvQhA==
X-ME-Sender: <xms:xd4xZ-55RgZHER_nIzFmHyqbzMh8gK324o_Q4siWowbN6QgsX4Ophw>
    <xme:xd4xZ37a6xAxmI9iy5WKkxRzcGIuVvO-Kp5IgORPBDGhstkPrIXzHZIcgm1hy-PFf
    nzLBkuMW8VVdCdKzA>
X-ME-Received: <xmr:xd4xZ9eTQcJc3eX7UVWnWaZSsnV3EfAWiUG1jxho-6AJO5xIK8ZCr94C1xs8EW0er2zU-pkQcfb23DPXEjUazTorTuJ-Fgge-lpkgbGNuAnqHz8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:xd4xZ7KI1qHxypZzWTahAnJJw2vdGKoJC7VSlKJtv7wl6bk-fIOOgA>
    <xmx:xd4xZyLkg0NWnVXDEZjjFj7avziMzvlYpr9HepbW1vgopmSueqD1oQ>
    <xmx:xd4xZ8xKXYqNO3neN6Fnjt1txH0xRDybGVjEvKJAQImg0UH97gox9g>
    <xmx:xd4xZ2KymQnsOEKmYqVVTRrwTTi2xS8JeoVXOK8gOith2OtDgZsI3A>
    <xmx:xd4xZ5WTZnJ2PQjcSqfxlmgZ07dQLQyP86b5hzxIR_TYosmiGps1YzNe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54485041 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:46 +0100
Subject: [PATCH v2 17/27] builtin/help: fix leaks in `check_git_cmd()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-17-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

The `check_git_cmd()` function is declared to return a string constant.
And while it sometimes does return a constant, it may also return an
allocated string in two cases:

  - When handling aliases. This case is already marked with `UNLEAK()`
    to work around the leak.

  - When handling unknown commands in case "help.autocorrect" is
    enabled. This one is not marked with `UNLEAK()`.

The function only has a single caller, so let's fix its return type to
be non-constant, consistently return an allocated string and free it at
its callsite to plug the leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/help.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 4a5a0790704b402e6f989118a0f90b52eb49dae1..6a72d991a84d9f14ecb8a711a012ed544450ca1c 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -551,12 +551,12 @@ static void show_html_page(const char *page)
 	open_html(page_path.buf);
 }
 
-static const char *check_git_cmd(const char* cmd)
+static char *check_git_cmd(const char *cmd)
 {
 	char *alias;
 
 	if (is_git_command(cmd))
-		return cmd;
+		return xstrdup(cmd);
 
 	alias = alias_lookup(cmd);
 	if (alias) {
@@ -589,14 +589,13 @@ static const char *check_git_cmd(const char* cmd)
 			die(_("bad alias.%s string: %s"), cmd,
 			    split_cmdline_strerror(count));
 		free(argv);
-		UNLEAK(alias);
 		return alias;
 	}
 
 	if (exclude_guides)
 		return help_unknown_cmd(cmd);
 
-	return cmd;
+	return xstrdup(cmd);
 }
 
 static void no_help_format(const char *opt_mode, enum help_format fmt)
@@ -642,6 +641,7 @@ int cmd_help(int argc,
 {
 	int nongit;
 	enum help_format parsed_help_format;
+	char *command = NULL;
 	const char *page;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
@@ -713,9 +713,9 @@ int cmd_help(int argc,
 	if (help_format == HELP_FORMAT_NONE)
 		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
 
-	argv[0] = check_git_cmd(argv[0]);
+	command = check_git_cmd(argv[0]);
 
-	page = cmd_to_page(argv[0]);
+	page = cmd_to_page(command);
 	switch (help_format) {
 	case HELP_FORMAT_NONE:
 	case HELP_FORMAT_MAN:
@@ -729,5 +729,6 @@ int cmd_help(int argc,
 		break;
 	}
 
+	free(command);
 	return 0;
 }

-- 
2.47.0.229.g8f8d6eee53.dirty

