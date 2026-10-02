Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C918443C08
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928599; cv=none; b=SBy5tvkBP4Ivn2FP+Kq5328xe1Y1WL7yKwNFyapSlh0aUcKchhNv8S7RqUeuvP+sRuU+MNwCG86h4iJdhjpZCy/cDjFu3cpKNeMNL/n2Ii/1P3gdYJGAgN4N/tJlRGi+1JOz4aBzj8q5b2PT6HTXRPnpIjw8tJsVH7MqI4XGiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928599; c=relaxed/simple;
	bh=7+45NkmSTHRRTcZsk5g9hBhYab7KYlxlcJ+NQ7c0aeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvTLrhBVNfnF0+3Vj+PHbr8Jq6F6LSGOCXH1mG5unUWRbCGk3ZBzh6LtlKYLNhDDfLlAxfu3YUXYuB8JTuONqZi2kA4jzq079XXPfV5ZWArUPVBESqhS+nTJOY6Qdej6AmWvCYT8VuhrfgLzJ+NFWFz1eN424kxaQKLAkjQ1H6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JAJXnlSG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pkuh5hX7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JAJXnlSG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkuh5hX7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FFBAEC0298
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:09:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 02 Oct 2026 04:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790928596;
	 x=1791014996; bh=vzBjPag2I9neEi5E9rw8CJ4oek29/cKSyyWYKhsAHr0=; b=
	JAJXnlSGXX3ZqRdG6nuts/kT0KzZQcoYBoUh9t6auHqxzP4pLH+qMCw8uSf0Mfln
	ND+U+FyCUR7icN1Vh6M1Rg0JqqMSoD2nT8GbNIYEkWnsfXw2+ceJxw4GlU5Bbouz
	KgH/2Uy2OcWq3dbBagEiza8psbD9cBVjAeAAL4t0fKSoGR0d86ligVkjPt4vNM+H
	N+jZQ6zxnpbfB5PXngnTasx1MMPA1xkV0jEeF9bGc15vdpy3UcxbxDubUxvQtJJ/
	j/FJagLBHr/bFOLONNo7emZSH3LXK2af3IJCgV1fehz4MczRffpUlYXyqg7OmwLn
	cQEwm1J0sJwWMOVgxG9HoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790928596; x=
	1791014996; bh=vzBjPag2I9neEi5E9rw8CJ4oek29/cKSyyWYKhsAHr0=; b=p
	kuh5hX7Unv0gyjdp86WLYxbikfp8aSLRUETfbkyEBytvcIh6zqrmNghFl5yX+Yat
	yrFoad456PjfkYf1izbBzsPgM8wbPbnHQ8BdZdy9unwq88RjR0SE+vVe2dtBncfF
	KZ8N07wIO2HpTdqiydp+s+q/iaRXYh/oc4Q9/caCe2/VHhT9hYFYj7qoS/ivyzmm
	lZblHcgsizfudpv1fDwynRm7IXDsEkwqFoCGUSUQfdaqdeZReAvY+2J2JRPyXCjX
	cuwmcYTBe1QwEx/2z6inJCVH7U01QEswIPQ8JZ4bkXe1etq3JsT7s9GbJr46d/k3
	pfcM6UkmoIiQ56LBVn0cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790928596; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VRzQGcYK9F5TDt9Tait39JxsChG/ZyNpBLY+KTvj0wdxuXt
	NSRkh32Czs0lm81Ko+pQhxM8RAFTTZL6W/atbtq/A7qZkVroVXRLq40a98vKAaTm
	TjuVrHfLcgZZ0WXG8DfGfUyHCrnK+0Rkvd7/DjtN1jti5Geuj82p9nhSkX4g8y9y
	aMIQCdBsPyIQLDJPHb5EP9rPILCi0g7QmRr8kPQavdLlzu9vXVoKv3mnCt6UyGDq
	iDa2JITjXB/caJEkVkX31CUsCo+jOL7sXcFiiYyaPX51myFn5NacVdAm8VMs12fV
	yk/6TObrcrn6GnjhEdxzjchXvdg5k5L5kgYjLIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WOdJrhvstWct+0ksW0QyabgliCsmiEAWE7HYlO6tawg=:7+45NkmSTHRRTcZsk5g9hBhYab7KYlxlcJ+NQ7c0aeQ=;
X-ME-Sender: <xms:02a_asVBk92VY_pfO9PSP6wnAMK6oujX-M0IqMrjIbSIZSpbop3R3w>
    <xme:02a_amme-fRAmmEjzNiPekrtSdWyBzhOnGhICTv9jRvNnXQfDDLF59Zhq6fdA0Agq
    gl8nEyMhW2lvRo9fVP3RFpBUoYPYA7GVMAOxKrtY_r23sschHN5krw>
X-ME-Received: <xmr:02a_auC-r90VHy0y7Eo6Ikznutx8G-k0i8MfKKht7MVrpojPMMRtPA>
X-ME-Proxy-Cause: dmFkZTFiMJY6nxeo/jMccWltefuWy3cn6ea2g2QEG1GiX35x9x/1PEpsdmiCp9WYU3/3FC
    Lx3VCC7/j/MUylhq2vuiqaR+GJ8hE0hokZMHSIHuglPDy3SbjyR/3TkBILfy/DQc59DsE1
    sB8ckp1UHUSsuIwN+wEyB1HK3rStTd58Z3hy2qtRjP/ZyR2YZlUMU/6p2g32GbbIIBicsN
    aC12Dxlhrh+GBIwDkzs/sMQkLkAVa3pXZbBl3RapTLNTG9qbmLmuuzy/ZWykXO0fBK39Uq
    hV9htYxMjcGJ/jENaybjN6cyLjDTx/JwSZSTeWrzgvI74DM2CsHvizQSY7NsUK2Zh8T7GC
    STxy0vGXbhPbhS5K8+56BXfV0t+F5+m/vsCA7DQ8/0fQLj74gC3hO/7aTcCz7zTQ/L2lgO
    aoDXHO/JOebjRKYu54X5//c3j77Zlz7jLCR+KinAiiBCOtvt+FMKjir2eVzO1IRD/vzTlb
    mSeds470Bn7voPiswH3gu0EDPP2oUxMUyu2+xRsOrgwmo/V1wLyywhdnCzN7qKuIIX/Cu1
    PWNBD6u7FfyT8p70DLHCwuBs5fReqolRbwffmAZ6Us+nlhx0h0MplXX6W8zJ3pz+dXx/EJ
    sBzsyHXEuM4xW7jQYsMiWinmmCsgxjrtO1svbMs6kBeMWxLHnNNmYeGTK1lg
X-ME-Proxy: <xmx:02a_amfOq6c_Gmp5uwZfT5FcFj84Xd9O5aNXFvDFd5vFpI_ZVRh5gQ>
    <xmx:1Ga_apLpUUJRDAKl_MOygTAQNX70_nLhHtNGFxdjD8Xf0WSZgP5ccQ>
    <xmx:1Ga_apeK6WCpsYbndlwqO7VSXCgHh-t0Hgl-s9Di3ltvwrFUuxCzFw>
    <xmx:1Ga_ag1fvKbPa9fi6bfMr2wrHEBwD9MfOK13t0msoWYkg_xNqzZkkw>
    <xmx:1Ga_anuWDSTlCrBKDqFPTwWNC6D7cMILMj5cqD5OWQ7IreQ5hgTkJRwK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 04:09:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6267a2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 08:09:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 10:09:47 +0200
Subject: [PATCH v2 2/4] parse-options: extract functions to print single
 option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-b4-pks-parse-options-subcommand-groups-v2-2-3299bee52dea@pks.im>
References: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
In-Reply-To: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The logic to print a single option has grown somewhat long. Extract the
logic into two functions to print a single option and a flag,
specifically. This refactoring makes a subsequent change easier to
implement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c | 169 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 94 insertions(+), 75 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8bb30ec116..fdcb29f2a1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1323,6 +1323,97 @@ static const struct option *find_option_by_long_name(const struct option *opts,
 	return NULL;
 }
 
+static int usage_print_flag(const struct option *opt,
+			    FILE *outfile,
+			    const char **positive_name)
+{
+	int off = 0;
+
+	if (opt->short_name) {
+		if (opt->flags & PARSE_OPT_NODASH)
+			off += fprintf(outfile, "%c", opt->short_name);
+		else
+			off += fprintf(outfile, "-%c", opt->short_name);
+	}
+	if (opt->long_name && opt->short_name)
+		off += fprintf(outfile, ", ");
+	if (opt->long_name) {
+		const char *long_name = opt->long_name;
+		if ((opt->flags & PARSE_OPT_NONEG) ||
+		    skip_prefix(long_name, "no-", positive_name))
+			off += fprintf(outfile, "--%s", long_name);
+		else
+			off += fprintf(outfile, "--[no-]%s", long_name);
+	}
+
+	if (opt->type == OPTION_NUMBER)
+		off += utf8_fprintf(outfile, _("-NUM"));
+
+	if ((opt->flags & PARSE_OPT_LITERAL_ARGHELP) ||
+	    !(opt->flags & PARSE_OPT_NOARG))
+		off += usage_argh(opt, outfile);
+
+	return off;
+}
+
+static void usage_print_option(const struct option *opt,
+			       const struct option *all_opts,
+			       int full,
+			       int *need_newline,
+			       FILE *outfile)
+{
+	const char *positive_name = NULL;
+	const char *cp, *np;
+	size_t pos;
+
+	if (opt->type == OPTION_SUBCOMMAND)
+		return;
+	if (!full && (opt->flags & PARSE_OPT_HIDDEN))
+		return;
+	if (opt->type == OPTION_GROUP) {
+		fputc('\n', outfile);
+		*need_newline = 0;
+		if (*opt->help)
+			fprintf(outfile, "%s\n", _(opt->help));
+		return;
+	}
+
+	if (*need_newline) {
+		fputc('\n', outfile);
+		*need_newline = 0;
+	}
+
+	pos = usage_indent(outfile);
+	pos += usage_print_flag(opt, outfile, &positive_name);
+
+	if (opt->type == OPTION_ALIAS) {
+		usage_padding(outfile, pos);
+		fprintf_ln(outfile, _("alias of --%s"),
+			   (const char *)opt->value);
+		return;
+	}
+
+	for (cp = opt->help ? _(opt->help) : ""; *cp; cp = np) {
+		np = strchrnul(cp, '\n');
+		if (*np)
+			np++;
+		usage_padding(outfile, pos);
+		fwrite(cp, 1, np - cp, outfile);
+		pos = 0;
+	}
+	fputc('\n', outfile);
+
+	if (positive_name) {
+		if (find_option_by_long_name(all_opts, positive_name))
+			return;
+		pos = usage_indent(outfile);
+		pos += fprintf(outfile, "--%s", positive_name);
+		usage_padding(outfile, pos);
+		fprintf_ln(outfile, _("opposite of --no-%s"),
+			   positive_name);
+	}
+}
+
 static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 							 const char * const *usagestr,
 							 const struct option *opts,
@@ -1408,81 +1499,9 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 	}
 
 	need_newline = 1;
-
-	for (; opts->type != OPTION_END; opts++) {
-		size_t pos;
-		const char *cp, *np;
-		const char *positive_name = NULL;
-
-		if (opts->type == OPTION_SUBCOMMAND)
-			continue;
-		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
-			continue;
-		if (opts->type == OPTION_GROUP) {
-			fputc('\n', outfile);
-			need_newline = 0;
-			if (*opts->help)
-				fprintf(outfile, "%s\n", _(opts->help));
-			continue;
-		}
-
-		if (need_newline) {
-			fputc('\n', outfile);
-			need_newline = 0;
-		}
-
-		pos = usage_indent(outfile);
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
-
-		if (opts->type == OPTION_NUMBER)
-			pos += utf8_fprintf(outfile, _("-NUM"));
-
-		if ((opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
-		    !(opts->flags & PARSE_OPT_NOARG))
-			pos += usage_argh(opts, outfile);
-
-		if (opts->type == OPTION_ALIAS) {
-			usage_padding(outfile, pos);
-			fprintf_ln(outfile, _("alias of --%s"),
-				   (const char *)opts->value);
-			continue;
-		}
-
-		for (cp = opts->help ? _(opts->help) : ""; *cp; cp = np) {
-			np = strchrnul(cp, '\n');
-			if (*np)
-				np++;
-			usage_padding(outfile, pos);
-			fwrite(cp, 1, np - cp, outfile);
-			pos = 0;
-		}
-		fputc('\n', outfile);
-
-		if (positive_name) {
-			if (find_option_by_long_name(all_opts, positive_name))
-				continue;
-			pos = usage_indent(outfile);
-			pos += fprintf(outfile, "--%s", positive_name);
-			usage_padding(outfile, pos);
-			fprintf_ln(outfile, _("opposite of --no-%s"),
-				   positive_name);
-		}
-	}
+	for (; opts->type != OPTION_END; opts++)
+		usage_print_option(opts, all_opts, full,
+				   &need_newline, outfile);
 	fputc('\n', outfile);
 
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)

-- 
2.56.0.353.g0856645cf6.dirty

