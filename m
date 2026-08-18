Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE4448D16
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047128; cv=none; b=Ed2fv+oo6ikv504GnHnjQUlNM/bh4SMFd9TvUPUM2bl66GSpEOx0enputbKSKQHWWqJ6GzuHgI//+vwWPm9hBy1gnC/kRqnf1u9WCo4hGaG/60UOQGIkQ1sUTY7JTuG8JFuWAKdUmk83JBjPyt3blAs1X0skmLPc/Tx7zStaTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047128; c=relaxed/simple;
	bh=rZMIiYScHk4B4MLd079TduX7/CrGUpMRddJnqsiwur4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm6T+MAPe2Z4CPzRt9JAnVHB+YtA9WgCNosfG5RAaIRxtdIOjwTqYmr1IcPveKlou6Bch2iJhue7Fri2X/1GrK9YjMxNErjiL1Zf2sZoraRG5SfI+TM4Po34iXWlkegnnTWuNA1DYldPOdlj4Q9lTp+3XO2FRWpjqUKPuLMmTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cCrlmsGW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Biq7jCc7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cCrlmsGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Biq7jCc7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DF1F1EC0271;
	Tue, 18 Aug 2026 05:58:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 18 Aug 2026 05:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787047125;
	 x=1787133525; bh=oexrzShbiZOpSoxQePSYjgd8Gm0sBsAXJHAZUyk2LzE=; b=
	cCrlmsGWw4pUFP/htrq/hRt5Hf5qYsWxna3iZYm/i8pUpkO3PBd+BxkVVgb/RUXI
	EmYeC3cEXK3Frn+DQ3BROV8oCMslSgh9pZnxotcFTsf0NjbqMv6MheEcaJBg6xJB
	1u1TyXAHFh2c6OcwF3F2cbFi42vIjPctw6TkSASLylrert0taJB+jmFgXeGAsufV
	PAt3uAw/3XvsH/zTsQPLNi5pm57sev84mX4GRGlIRxn4TrdVrlGpplXE6NLsS1jZ
	WeFZXHzVpU2QZg6ON/R3RcHjcPbpzNjvSi8KEhsHGmMPafkRD+nPqVzvRQDOmNzF
	HWjZSff8Ae0NXm07VUvpug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787047125; x=
	1787133525; bh=oexrzShbiZOpSoxQePSYjgd8Gm0sBsAXJHAZUyk2LzE=; b=B
	iq7jCc7HkemgMgGtyqmYO+Xj+88zLML5hHraEB8f6d0NzdBspK+v+ojOgNlBRsKk
	VWb3HugidKX6KasycoWAcA2jIJ8vcjAeZu5gjz+I4t/ACjl9k228D1nCNc61B1O+
	gLJN+lxM8U1fFsO1SkK0lPuEF+oidJqIbd38fQyrXp9ddtqOQ5pyz2mFV1YIqlci
	1pTdf6nexrMvGYKHVQ1or5/mtZLehvTDuyGjiVKItcOV1rT79abnnETXBRTAt9E9
	i/IJXqORp1WYRRUwWGdUyjQEbRCX9b19VnED/TK5qqx4pWdTDidsRL/vwa8+yWvS
	cJ376vJOiWowjJoXhzbrw==
X-ME-Sender: <xms:1SyEahBhDQhZoVwf_F2D8wUMorAbLC77umhR8p9YbdQ0RbR3uggSqFE>
    <xme:1SyEalhTOqaC-XcFaSVHwoV9xyw8hMw15x9rmqEeXhq18N1jZDhp1ZtuDJKF3BGMB
    rm1EHt7LqB5ned8n31GtyFICQgr6JKqJ1U8RgnrMn7o33xTW3k6F-c>
X-ME-Received: <xmr:1SyEaqOCH4dPEfcJCZhMvCh9AbnWuRuVFFEK3hkObicmi2V5LAeNmJa-1vRgGQo2vpXmMZ09dobQYoa6UnuP6sxUWdEuu9Mjdysh5n8>
X-ME-Proxy-Cause: dmFkZTFlvgAFv64nHdwnu1/4gI3X4PB12ymqvtb3q6flWXK6z0+d/GdTFIgYlB29MTaors
    CNVfW3Hd8oh8+4DBNoV/4D2EbI3NviHjWQFPw3WvgY05wl1C6+059LKT/MKIeZ978jLdrX
    gcEosVRIi2ogCYiCrFLr0WbcleZ7lc4MqwvFIzILh4kJ+d5mMQZp07zgU2JCuLXQ6XRwwf
    DSXLf+Vxsl2xQUIRu7yRsdCwCtH5jEPUh27pjKG27J4/at0NXCRe4sXHMt8a616ITl98GM
    /OshJU7HHZkDBd6loA769mMiV5J+mcNWy7Jeok3INQBaA02Pd5egZHd237ZivsK6IQ7tsG
    VnB1S8DRCMDDsz/rV8PNHXniPc+3iXWW9D4mKZPf3IlIg3eFOK+2i5WX/7a814q1obDIu0
    oe+E+c9zVS/HEFnDoOJLIIh+DWmIqYiVvBIAn8WNi7h6XFvqdZwW+X55czVAO8D0dk6oT5
    14bnc5F7kf9G8SoE03MQkXZvXIKCASGrZ2irzCTfITDXLzAop8zrkgb9naLSbNEbS6viyc
    gBs7cWnPjvvbgDVc5siNZMRsjeV7pMWKEBSUtuOaTJyQqAb7z+fM4pngH88wxV7sI1p8AP
    4eVxTOpVDQ/38Wf2ztW332m3ZOEcWw4YyrdL1M2ngXLmQQJfx05VG+VnU3Kg
X-ME-Proxy: <xmx:1SyEam5a58fTQgEP4LGkSZm_j8cEoXV4K8mZkTGX3F7Pi-LluRX9CA>
    <xmx:1SyEao3S7qNQzMPIsnnMP46SsRbqwYs0__RFF1qb493TnB_MAcJQLg>
    <xmx:1SyEanY_bludmEdvR0LV9gpBxT3JEBIlpnpUlEVUOHZr6byrpyZz1Q>
    <xmx:1SyEagC8UauTHtpb_NlJCtLZ2wCeNhpd2w_O0Ig-fEpPbnHANAyhjA>
    <xmx:1SyEakY3eDykaYFzV-L-wzCj0tcDozp5pNA1oNCLe-7mOlnNHktJVB4L>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 05:58:45 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 3/5] format-rev: factor option variables into a struct
Date: Tue, 18 Aug 2026 11:57:32 +0200
Message-ID: <V2_factor_opts_into_struct.bd6@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz> <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We will in two commits add three more options to this command.
Let’s prepare for that by moving option variables into a struct
so that we get less local variables.

This allows us to inline `format_nul_data` into this new
structure. Let’s also rename `stdin_mode_arg` to `stdin_mode`.
(We couldn’t use `stdin_mode` before because of the enumeration
with the same name.)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Designated initializers: https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/

 builtin/name-rev.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index d6686bbdbb9..c8cb2f2d520 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -772,16 +772,19 @@ int cmd_name_rev(int argc,
 	return 0;
 }
 
-struct format_nul_data {
+struct format_rev_data {
+	const char *format;
+	const char *stdin_mode;
 	bool nul_input;
 	bool nul_output;
+	struct string_list notes;
 };
 
 static int format_nul_cb(const struct option *option,
 			 const char *arg,
 			 int unset)
 {
-	struct format_nul_data *data = option->value;
+	struct format_rev_data *data = option->value;
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 	data->nul_input = 1;
@@ -813,31 +816,30 @@ int cmd_format_rev(int argc,
 		   const char *prefix,
 		   struct repository *repo UNUSED)
 {
-	const char *format = NULL;
+	struct format_rev_data data = {
+		.notes = STRING_LIST_INIT_NODUP,
+	};
 	enum stdin_mode stdin_mode;
-	const char *stdin_mode_arg = NULL;
-	struct format_nul_data nul_data = { 0, 0 };
 	char output_terminator;
 	strbuf_getline_fn getline_fn;
 	struct display_notes_opt format_notes_opt;
 	struct rev_info format_rev = REV_INFO_INIT;
 	struct pretty_format format_pp = { 0 };
-	struct string_list notes = STRING_LIST_INIT_NODUP;
 	struct strbuf scratch_buf = STRBUF_INIT;
 	struct command cmd;
 	struct option opts[] = {
-		OPT_STRING(0, "format", &format, N_("format"),
+		OPT_STRING(0, "format", &data.format, N_("format"),
 			   N_("pretty format to use")),
-		OPT_STRING(0, "stdin-mode", &stdin_mode_arg, N_("stdin-mode"),
+		OPT_STRING(0, "stdin-mode", &data.stdin_mode, N_("stdin-mode"),
 			   N_("how revs are processed")),
-		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
+		OPT_STRING_LIST(0, "notes", &data.notes, N_("notes"),
 				N_("display notes for pretty format")),
-		OPT_CALLBACK_F('z', "null", &nul_data, N_("z"),
+		OPT_CALLBACK_F('z', "null", &data, N_("z"),
 			       N_("use NUL for input and output termination"),
 			       PARSE_OPT_NOARG | PARSE_OPT_NONEG, format_nul_cb),
-		OPT_BOOL(0, "null-input", &nul_data.nul_input,
+		OPT_BOOL(0, "null-input", &data.nul_input,
 			 N_("use NUL for input termination")),
-		OPT_BOOL(0, "null-output", &nul_data.nul_output,
+		OPT_BOOL(0, "null-output", &data.nul_output,
 			 N_("use NUL for output termination")),
 		OPT_END(),
 	};
@@ -849,18 +851,18 @@ int cmd_format_rev(int argc,
 		usage_with_options(format_rev_usage, opts);
 	}
 
-	if (!format)
+	if (!data.format)
 		die(_("'%s' is required"), "--format");
-	if (!stdin_mode_arg)
+	if (!data.stdin_mode)
 		die(_("'%s' is required"), "--stdin-mode");
 
-	getline_fn = nul_data.nul_input ? strbuf_getline_nul : strbuf_getline_lf;
-	output_terminator = nul_data.nul_output ? '\0' : '\n';
+	getline_fn = data.nul_input ? strbuf_getline_nul : strbuf_getline_lf;
+	output_terminator = data.nul_output ? '\0' : '\n';
 
 	init_display_notes(&format_notes_opt);
-	stdin_mode = parse_stdin_mode(stdin_mode_arg);
+	stdin_mode = parse_stdin_mode(data.stdin_mode);
 
-	get_commit_format(format, &format_rev);
+	get_commit_format(data.format, &format_rev);
 	format_pp.ctx.rev = &format_rev;
 	format_pp.ctx.fmt = format_rev.commit_format;
 	format_pp.ctx.abbrev = format_rev.abbrev;
@@ -868,13 +870,13 @@ int cmd_format_rev(int argc,
 	format_pp.ctx.date_mode = format_rev.date_mode;
 	format_pp.ctx.color = GIT_COLOR_AUTO;
 
-	userformat_find_requirements(format,
+	userformat_find_requirements(data.format,
 				     &format_pp.want);
 	if (format_pp.want.notes) {
 		int ignore_show_notes = 0;
 		struct string_list_item *n;
 
-		for_each_string_list_item(n, &notes)
+		for_each_string_list_item(n, &data.notes)
 			enable_ref_display_notes(&format_notes_opt,
 						 &ignore_show_notes,
 						 n->string);
@@ -934,7 +936,7 @@ int cmd_format_rev(int argc,
 	}
 
 	strbuf_release(&scratch_buf);
-	string_list_clear(&notes, 0);
+	string_list_clear(&data.notes, 0);
 	release_display_notes(&format_notes_opt);
 	return 0;
 }
-- 
2.55.0.13.g85d2d65e389

