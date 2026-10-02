Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF141F5D4
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928601; cv=none; b=IOgYLXO0LwXFh19krInxTLN7/qhUpbTFM0v10STl6/EQjYlSSTtaGxocl1nSbtxvO55gYmzHrH+JwaeWeHJMxASsNbRAwdwCZSZiovkuTTpfWOBh2VP5Smk7w5CLlEYsgK3CDJnRxy64TC6mGQmBwyhbqsSJj2/FRdkGZrOxkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928601; c=relaxed/simple;
	bh=ByTxTwAmFZEUkPv8GjqlhZ0v3ayua7Sedfu704tbGTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoJbnQJIC9ekbhobIQXmjEc6BX+aCxFZbq1+WZMBcF95AZdHgdmCuYWeX96eiWkYlU/QluFxUCfF9+HcaGlAmzGqSp0QoPDuxwRges/Jy8JsM1+iElFxumhvNL2z1PKUYa1M4/8h9+TEJXDg4pf59dd4RUUck8GSgweqTei667s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FRRrvD3V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJArLk+Q; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FRRrvD3V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJArLk+Q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C69CE14000BD
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:09:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 04:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790928597;
	 x=1791014997; bh=KBats6fFuHlxE7M0XcizH0lEHL2RoppdV1CLVX4fGzE=; b=
	FRRrvD3V2I0lUi8b6RZR5vaQ+oEM1GjqqvzaA71dF4GfnyvtnDwH+FeBMTUY8HYo
	+LBClwZ8kAWVCMHiWcRh9o2ywxY/DqU9DlG8RKzqi0Kjah1YHtYPzP3KtUPwjadJ
	4YBvb6mZMkJPxNP5X10vQUFFMSRAZSi1Puhdo2qkpoRqMWdqzHFxLQEJuhZ9P2rq
	M9AHiiXtv9LJs35NpCIGEpsDU1oXk/q9DqB1GCCJVhEn/2q5LaGeTib236MkKvtu
	Ok9DUC8+E6lXl34/hjbnp8Ze/8NinlFRL8eFtNNqAMp9UoCvFxhdT9k4ETONj6Kw
	rk1ytxk/WnVves3np22b1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790928597; x=
	1791014997; bh=KBats6fFuHlxE7M0XcizH0lEHL2RoppdV1CLVX4fGzE=; b=Q
	JArLk+Qm2qzRbDp2CdQBUiZpksDp/uKjQtUDb9sbGY4rKZYolRv0nRRZDDSXowZv
	cvdlGP/5Mp3ao3Nxr9UE9IiJN5zeNwmDfKMfklRSxDi/GFxZ8o+AwmMG+ELC6MX8
	nep8GlF6D846TYhRSQQw6CD7PWSoTlTsbowJVoYULY//tn/ZGymDWRYt2xg+GNBP
	aOWVRgv2LPlhUbbPUeODrFTIKsqO75nGi9JyRNczvC8DLIyoc+4zDejlUYWwy/m4
	wqE4bOBWw3MU6NnfbwlQ3CaQr+cuY59S8DiB1Nm2LD6jum9yctSPNLoVptfyl4Ge
	zUpQMBj+irnyRYPCcIwhg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790928597; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TUKoHenmkFVB15O+QSOwwgUOtWIPxZcun3PMf7DODu44Snh
	KNRXJ5XE+oybMDUQe05k35Y4I2h/Ku93EPMqodQkmQv49IHfn4LPxm9xoY+2k1+F
	gMNJQwA78CZLXPX5ckcdW8MQ/zhS5WY1Wo0lmEdqv9wDmVA4Jalq7eCjIybyJ0CJ
	mdbSQExINPW5I0FpVeJ2PoLj3zXnJNkqVYqJV7cu3QUf5kxCM0a6xaqq79XkjPyT
	R5IBVYQX7ENS8sgxedtDSEnJO+fg1rwA3C1UrbJ0k5OImNKpilXxUMsSt7WX/1Sq
	t0ymPH3IqCj9ZCXIkQzPNi0xFa1PYST9njD3kew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZiW09SDBlziFpjZcGS/TlucSCY6YHM7QNMghMbvAHjE=:ByTxTwAmFZEUkPv8GjqlhZ0v3ayua7Sedfu704tbGTU=;
X-ME-Sender: <xms:1Wa_aiXbCarEGW8j-20MkfVm9SJlVF_6aEy0xsY3czON1zOGiPzUnA>
    <xme:1Wa_akksxTXoOvbYNkfzYXBYO6rbNQ-bZg5Ra8iIIzCHW4t9enoTFyRS845kXCRLe
    Lf2JvQPF-PZn8KCD9dkSdbHgF6ayywD0UXonnYsdW67VH2u1oqN9Q>
X-ME-Received: <xmr:1Wa_akBnUmAzfv2BCrpqOyNo0gfiJv9LQMV0o0z_13X7KU3R4EEvHQ>
X-ME-Proxy-Cause: dmFkZTFiMJY6nxeo/jMccWltefuWy3cn6ea2g2QEG1GiX35x9x/1PEpsdmiCp9WYU3/3FC
    Lx3VCC7/j/MUylhq2vuiqaR+GJ8hE0hokZMHSIHuglPDy3SbjyR/3TkBILfy/DQc59DsE1
    sB8ckp1UHUSsuIwN+wEyB1HK3rStTd58Z3hy2qtRjP/ZyR2YZlUMU/6p2g32GbbIIBicsN
    aC12Dxlhrh+GBIwDkzs/sMQkLkAVa3pXZbBl3RapTLNTG9qbmLmuuzy/ZWykXO0fBK39Uq
    hV9htYxMjcGJ/jENaybjN6cyLjDTx/JwSZSTeWrzgvI74DM2CsHvizQSY7NsUK2Zh8T7m+
    lumTIpv5d/zid8yPUX7ns0keTwA5K3hAJlSsCjqJmiJY5ib9pWvVmd2H6rsIBH2e1FrYpR
    dsOPYWoer6a9RCklTU/IKOYoYX4DVam/aLsIUkuh5lGtoZtdSknSzQyCqGaMFCZ0ddOyWG
    pgMnMgq7kqeWitMkYtjaTpcZlzgu02dKFtNXvWFCqPkGsh2rR0z/XdkdRd6FLrkG3q8StP
    SRPMe2Vs1VbfyU4+RqrHO6o3upVI1XKDiSrTgCPYPQVltjBpd3KgjxXW+NjjRag4in/Tcd
    rqegfbFkwA3Adp4PPPUN/AxtCL2F0XxxNVMlnkIAlEtemPcEhjwJBpV0E21w
X-ME-Proxy: <xmx:1Wa_ake_s-KO7IFJyDwe1kxoHFf35ziV2wU1g7Q9kzRRz-ecrjCIMA>
    <xmx:1Wa_avK4nNUt2CFV75qALLo_5dxOKN71rXIbjm0tpFsPle3wytEphw>
    <xmx:1Wa_ancWlLr_C3RBTkXsisREqWCc4ht6FsSEoXk1_8_C8oWHoC-sDA>
    <xmx:1Wa_am0thUDghyJJqW_uDPugvqcSEZKZf20h4Xb9sxhZW4PdC7NQLA>
    <xmx:1Wa_attfrC1sWMMErCdZlHvyi99yu-gMe470jiCTWK5EJAEyDQiv_9Q2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 04:09:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb3658c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 08:09:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 10:09:48 +0200
Subject: [PATCH v2 3/4] parse-options: allow grouping subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-b4-pks-parse-options-subcommand-groups-v2-3-3299bee52dea@pks.im>
References: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
In-Reply-To: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `OPT_GROUP()` macro can be used to create a new group. These groups
can only be used to group options though, they do not have any effect
when used in combination with subcommands. As our use of subcommands
grows though it can be quite useful to group these, as well.

Extend `OPT_SUBCOMMAND_F()` to take an optional help string. If given,
such subcommands will be considered as part of `OPT_GROUP()` and printed
with that help string.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/technical/api-parse-options.adoc |  4 +++-
 builtin/remote.c                               |  2 +-
 builtin/stash.c                                |  2 +-
 parse-options.c                                |  7 +++++--
 parse-options.h                                |  5 +++--
 t/helper/test-parse-options.c                  |  3 ++-
 t/t0040-parse-options.sh                       | 16 ++++++++++++++++
 7 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 95b7924e84..6dfea34220 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -243,6 +243,7 @@ with `flags` set to `0`.
 	Start an option group. `description` is a short string that
 	describes the group or an empty string.
 	Start the description with an upper-case letter.
+	Groups apply to options and subcommands that have a help string.
 
 `OPT_HIDDEN_GROUP(description)`::
 	Like `OPT_GROUP()`, but the group header carries
@@ -362,7 +363,8 @@ with `flags` set to `0`.
 
 `OPT_SUBCOMMAND(long, &fn_ptr, subcommand_fn)`::
 	Define a subcommand.  `subcommand_fn` is put into `fn_ptr` when
-	this subcommand is used.
+	this subcommand is used. The subcommand is not listed in the
+	usage output.
 
 The last element of the array must be `OPT_END()`.
 
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba..fb7e5b114f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1940,7 +1940,7 @@ int cmd_remote(int argc,
 		OPT__VERBOSE(&verbose, N_("be verbose; must be placed before a subcommand")),
 		OPT_SUBCOMMAND("add", &fn, add),
 		OPT_SUBCOMMAND("rename", &fn, mv),
-		OPT_SUBCOMMAND_F("rm", &fn, rm, PARSE_OPT_NOCOMPLETE),
+		OPT_SUBCOMMAND_F("rm", &fn, rm, NULL, PARSE_OPT_NOCOMPLETE),
 		OPT_SUBCOMMAND("remove", &fn, rm),
 		OPT_SUBCOMMAND("set-head", &fn, set_head),
 		OPT_SUBCOMMAND("set-branches", &fn, set_branches),
diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..8d606ee11d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -2475,7 +2475,7 @@ int cmd_stash(int argc,
 		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
 		OPT_SUBCOMMAND("export", &fn, export_stash),
 		OPT_SUBCOMMAND("import", &fn, import_stash),
-		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
+		OPT_SUBCOMMAND_F("save", &fn, save_stash, NULL, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 	const char **args_copy;
diff --git a/parse-options.c b/parse-options.c
index fdcb29f2a1..2b59932d2c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1366,7 +1366,7 @@ static void usage_print_option(const struct option *opt,
 	const char *cp, *np;
 	size_t pos;
 
-	if (opt->type == OPTION_SUBCOMMAND)
+	if (opt->type == OPTION_SUBCOMMAND && !opt->help)
 		return;
 	if (!full && (opt->flags & PARSE_OPT_HIDDEN))
 		return;
@@ -1384,7 +1384,10 @@ static void usage_print_option(const struct option *opt,
 	}
 
 	pos = usage_indent(outfile);
-	pos += usage_print_flag(opt, outfile, &positive_name);
+	if (opt->type == OPTION_SUBCOMMAND)
+		pos += fprintf(outfile, "%s", opt->long_name);
+	else
+		pos += usage_print_flag(opt, outfile, &positive_name);
 
 	if (opt->type == OPTION_ALIAS) {
 		usage_padding(outfile, pos);
diff --git a/parse-options.h b/parse-options.h
index d7f896a933..99c12c77cb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -393,14 +393,15 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
 	.value = (char *)(source_long_name), \
 }
 
-#define OPT_SUBCOMMAND_F(l, v, fn, f) { \
+#define OPT_SUBCOMMAND_F(l, v, fn, h, f) { \
 	.type = OPTION_SUBCOMMAND, \
 	.long_name = (l), \
 	.value = (v), \
+	.help = (h), \
 	.flags = (f), \
 	.subcommand_fn = (fn), \
 }
-#define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
+#define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), NULL, 0)
 
 /*
  * parse_options() will filter out the processed options and leave the
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index fbafd67756..950db78673 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -352,8 +352,9 @@ static int parse_subcommand__cmd(int argc, const char **argv,
 	int opt = 0;
 	struct option options[] = {
 		OPT_GROUP("Subcommands"),
-		OPT_SUBCOMMAND("subcmd-one", &fn, subcmd_one),
+		OPT_SUBCOMMAND_F("subcmd-one", &fn, subcmd_one, "the first subcommand", 0),
 		OPT_SUBCOMMAND("subcmd-two", &fn, subcmd_two),
+		OPT_GROUP("Options"),
 		OPT_INTEGER('o', "opt", &opt, "an integer option"),
 		OPT_END()
 	};
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 449fff4d34..ec55bb1414 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -629,6 +629,22 @@ test_expect_success 'KEEP_UNKNOWN_OPT | NO_INTERNAL_HELP works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'subcommand - usage lists subcommands with help text under their group' '
+	test-tool parse-subcommand cmd -h >actual &&
+	cat >expect <<-\EOF &&
+	usage: <...> cmd subcmd-one
+	   or: <...> cmd subcmd-two
+
+	Subcommands
+	    subcmd-one            the first subcommand
+
+	Options
+	    -o, --[no-]opt <n>    an integer option
+
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'subcommand - no subcommand shows error and usage' '
 	test_expect_code 129 test-tool parse-subcommand cmd 2>err &&
 	test_grep "^error: need a subcommand" err &&

-- 
2.56.0.353.g0856645cf6.dirty

