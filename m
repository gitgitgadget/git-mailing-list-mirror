Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1B4A5EB4
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849634; cv=none; b=StolIHLfq+p39uKsZvGUDoUgYUpJeYlyXgi79/t/Yg90TaeKDyTy+fD2aIaNmP4F5GPXSbj3gipiKgPiJmH/JHmCNdZxR1pzBrqKoskIue0rgSH2f3avV4DwFVBoX+nQbNop79WpUHqmiZUYvs7pp/faKFOhbZz/wXykNNxvxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849634; c=relaxed/simple;
	bh=l3z/z7NTvxnNvKybnePIABvh4na9PTTdVK/PJNTevuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o0Hfbl1f4efC1aKHmBCosA7ZlA4tGY7P5W6Hq6HX0v8jQXRa9LXgl/27KaWuXytPvEZTdtcar8XnBVkSOwu38UM1Zp9OPtC9KVBysmusYv8FvT1HHPDr7y0GHCBor2v7X0Gg7kQvt3isTWOh7xRBahD+K8yoFQJlCDAgtwLlFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V9aIlJJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mT1ylzi2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V9aIlJJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mT1ylzi2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C77F7A0111
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 06:13:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 01 Oct 2026 06:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790849623;
	 x=1790936023; bh=7NI22dDRzokG3pfxeTBLYnJhjbHeihTfKOMuXdqnknI=; b=
	V9aIlJJJPdsjpLR5j6jp3BiPXpg5mFwJhwFLjuV4D2UVGT5hzp9aGHjQXWYUlV8O
	RdXKnpq4g10f1C7pRrU3UWmp1Mg73Xa1nLHWZoPyjQrkbXqjPqN1FZqUZa19B24g
	IkaoWYcw+aWK5Byc+V/htXbKJbehef9tL5jlD40ZjKm9urK7BLJD7rIPX3brN09D
	EUc8KbnrZSn7H/epTB9cFj/zZG0/zFL53m2GHcpjoO6oxIqDUDxeHRxoWSwaKkvP
	kTSurPf+u1ehAtZX1sAtPSwX4UKLpioFa6oW/6VEPX3ZqQTEgGOMZoFP+65vXwl8
	UXXN5E/s9gp+zfoBv7DCRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790849623; x=
	1790936023; bh=7NI22dDRzokG3pfxeTBLYnJhjbHeihTfKOMuXdqnknI=; b=m
	T1ylzi2I3zrvAostwLwoMecPM0dV2LIkFJT7WZmy4uP/ZoBQkBE3Q+SOk71f31ud
	BusDiEXjEMNb0Tub3Q61qMxUxH0YPLlHME8Cp2hgrOsM6zHb7hh/iZWj2Q7Fd00y
	hE8WIB2yvfhLvXrgVl6iNJcFxVzI1kU9ByftaOJ12dvIQYb9n/GNE1KQ4k85QlXT
	ec6XmunQqRVjXto13IbDuvqaA6w7DxMrD24MX3Ch9T1cuFWOmaY4/tATsqAA9ARS
	AB0y+Hl6ehBMmp5xyEH1LGHnEEp0JbgDadEk/X4DSNNpfTxmYrMaixLPJRbVXddm
	Qb5dkiV8z9ey9n2SzULTw==
X-ME-Sender: <xms:VzK-as4D23UxMSlIuWqDoDRbJqdVPn8uJ_R6LNo57C8Uc6d9YqDVSA>
    <xme:VzK-ak3HM8CND-LIF_1Aksa3pNI3fXjLoA3YWAlXu1NqBgixgag0XI_vaWDNbI6y0
    gsypyeerXoAkslCvVz_KSnOxwerL7SFsZqJQ3IJnnacAhe3VzTsIbg>
X-ME-Received: <xmr:VzK-ahF1OVhE859UKsLEL8s_bvDwXNBi3uq1w9syRU5A0PlazIksB_NOeX4VwiEB3g0ILQ>
X-ME-Proxy-Cause: dmFkZTF0h35Mue9KHmP8mMGW4ZegWvlnVie16JZ/OUm/O4CJZ3hjyFnJDlEtSwqdPkGNj4
    YcSPAPsLVCPLDg5/1Nw7H0KdO0Ff3jIpzIAf4Pszwl75qMiABMJqxbODbWGF6c3siOaumk
    P1BEEb97x56OYefJOHgySdEogrsY5wMeRcIs064fiS8yalNUdFLxWg87tX3sygwlrYa/i6
    EI9jRTWudpfTsXkoNkGhS6YanrhXcU6LKvDlL1yE5C7cXJ1J+qoc2BJlMlhVtIgyz8UeV5
    fB/BrLFUPqcGt2QRcdYzu4CJ2vOXFJYuyFavPwoZGFtjhKVKj2r/T2CPTKmJVZd7oZ9bKZ
    75kbbz3ErwyqsjNirnScOnwsebImAOpw9bFOZLMCpws2HqGd6t5dg1uWNvwlC8dKqzIZob
    /OYAxJyIgSup1jfmpPqQwHNxle31R7/B0qfoofKumuNSqZCzKD3a3ZeGuikPtbzmjgouOi
    Hs72NJrx7nVOsL0XVIImpMGytOAHZXenqx/5Eo1b1Srx3GwEDcRpnoYZJ69rjVNsT3rlhP
    c1SXaVHQQ6dib5msGKaTDtowqC/yep5OcfymgsxnVfhvEtyZRVcTBM0XmdEDZf0krdP93E
    gpn4zpbrfRV6D6NTxGN4/eHRekT6N/wqclKR9SrPANk7DlPuTCdmeMMNPRcA
X-ME-Proxy: <xmx:VzK-amSfxUHf2HCzwlHoooHWNcHgFhx4qBOM_5V_DVOu1S_1jRFm3w>
    <xmx:VzK-agCrrdcMhfDg4G_rVW4AZEla_fXdImnP6HIRQRQKhu1fhnE-aw>
    <xmx:VzK-au27PkKzcneNzqbCVrofbFRX-PruPEMy1SdznrqtTQ9FDSEHyg>
    <xmx:VzK-amX7B2WgMEAmn0R6kr_owwr9FFtu-QGjgHyUBtwJ8hQd4Q-xZQ>
    <xmx:VzK-ataPsFkWc4FbppM41azisC4OzthSmir3vntsoIe_fIzcJ45cvrOZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Oct 2026 06:13:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9161bfab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Oct 2026 10:13:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 01 Oct 2026 12:13:29 +0200
Subject: [PATCH 2/3] parse-options: allow grouping subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-b4-pks-parse-options-subcommand-groups-v1-2-01eb2f4a4c32@pks.im>
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
In-Reply-To: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `OPT_GROUP()` macro can be used to create a new group. These groups
can only be used to group options though, they do not have any effect
when used in combination with subcommands. As our use of subcommands
grows though it can be quite useful to group these, as well.

Extend the parse-options interfaces to support this use case: the new
`OPT_SUBCOMMAND_H()` macro can be used to specify a subcommand that has
a description attached to it, and subcommands like these are now being
considered for `OPT_GROUP()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/technical/api-parse-options.adoc | 10 ++++-
 parse-options.c                                | 58 ++++++++++++++------------
 parse-options.h                                |  7 ++++
 t/helper/test-parse-options.c                  |  3 +-
 t/t0040-parse-options.sh                       | 16 +++++++
 5 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 95b7924e84..38dff82f72 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -243,6 +243,8 @@ with `flags` set to `0`.
 	Start an option group. `description` is a short string that
 	describes the group or an empty string.
 	Start the description with an upper-case letter.
+	Groups apply to options and subcommands defined with
+	`OPT_SUBCOMMAND_H()`.
 
 `OPT_HIDDEN_GROUP(description)`::
 	Like `OPT_GROUP()`, but the group header carries
@@ -362,7 +364,13 @@ with `flags` set to `0`.
 
 `OPT_SUBCOMMAND(long, &fn_ptr, subcommand_fn)`::
 	Define a subcommand.  `subcommand_fn` is put into `fn_ptr` when
-	this subcommand is used.
+	this subcommand is used. The subcommand is not listed in the
+	usage output.
+
+`OPT_SUBCOMMAND_H(long, &fn_ptr, subcommand_fn, description)`::
+	Like `OPT_SUBCOMMAND()`, but the subcommand is listed in the usage
+	output together with its `description`. This can be used together with
+	`OPT_GROUP()` to group together subcommands.
 
 The last element of the array must be `OPT_END()`.
 
diff --git a/parse-options.c b/parse-options.c
index 356eeff016..75f14b9767 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1414,7 +1414,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 		const char *cp, *np;
 		const char *positive_name = NULL;
 
-		if (opts->type == OPTION_SUBCOMMAND)
+		if (opts->type == OPTION_SUBCOMMAND && !opts->help)
 			continue;
 		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
 			continue;
@@ -1432,35 +1432,39 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 		}
 
 		pos = usage_indent(outfile);
-		if (opts->short_name) {
-			if (opts->flags & PARSE_OPT_NODASH)
-				pos += fprintf(outfile, "%c", opts->short_name);
-			else
-				pos += fprintf(outfile, "-%c", opts->short_name);
-		}
-		if (opts->long_name && opts->short_name)
-			pos += fprintf(outfile, ", ");
-		if (opts->long_name) {
-			const char *long_name = opts->long_name;
-			if ((opts->flags & PARSE_OPT_NONEG) ||
-			    skip_prefix(long_name, "no-", &positive_name))
-				pos += fprintf(outfile, "--%s", long_name);
-			else
-				pos += fprintf(outfile, "--[no-]%s", long_name);
-		}
+		if (opts->type == OPTION_SUBCOMMAND) {
+			pos += fprintf(outfile, "%s", opts->long_name);
+		} else {
+			if (opts->short_name) {
+				if (opts->flags & PARSE_OPT_NODASH)
+					pos += fprintf(outfile, "%c", opts->short_name);
+				else
+					pos += fprintf(outfile, "-%c", opts->short_name);
+			}
+			if (opts->long_name && opts->short_name)
+				pos += fprintf(outfile, ", ");
+			if (opts->long_name) {
+				const char *long_name = opts->long_name;
+				if ((opts->flags & PARSE_OPT_NONEG) ||
+				    skip_prefix(long_name, "no-", &positive_name))
+					pos += fprintf(outfile, "--%s", long_name);
+				else
+					pos += fprintf(outfile, "--[no-]%s", long_name);
+			}
 
-		if (opts->type == OPTION_NUMBER)
-			pos += utf8_fprintf(outfile, _("-NUM"));
+			if (opts->type == OPTION_NUMBER)
+				pos += utf8_fprintf(outfile, _("-NUM"));
 
-		if ((opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
-		    !(opts->flags & PARSE_OPT_NOARG))
-			pos += usage_argh(opts, outfile);
+			if ((opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
+			    !(opts->flags & PARSE_OPT_NOARG))
+				pos += usage_argh(opts, outfile);
 
-		if (opts->type == OPTION_ALIAS) {
-			usage_padding(outfile, pos);
-			fprintf_ln(outfile, _("alias of --%s"),
-				   (const char *)opts->value);
-			continue;
+			if (opts->type == OPTION_ALIAS) {
+				usage_padding(outfile, pos);
+				fprintf_ln(outfile, _("alias of --%s"),
+					   (const char *)opts->value);
+				continue;
+			}
 		}
 
 		for (cp = opts->help ? _(opts->help) : ""; *cp; cp = np) {
diff --git a/parse-options.h b/parse-options.h
index d7f896a933..5249404b46 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -401,6 +401,13 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
 	.subcommand_fn = (fn), \
 }
 #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
+#define OPT_SUBCOMMAND_H(l, v, fn, h) { \
+	.type = OPTION_SUBCOMMAND, \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.subcommand_fn = (fn), \
+}
 
 /*
  * parse_options() will filter out the processed options and leave the
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index fbafd67756..4a146bd016 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -352,8 +352,9 @@ static int parse_subcommand__cmd(int argc, const char **argv,
 	int opt = 0;
 	struct option options[] = {
 		OPT_GROUP("Subcommands"),
-		OPT_SUBCOMMAND("subcmd-one", &fn, subcmd_one),
+		OPT_SUBCOMMAND_H("subcmd-one", &fn, subcmd_one, "the first subcommand"),
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

