Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042114968FE
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641905; cv=none; b=CZJvgPQiwP/FyD+4hPOlxQGAxPdDoITcOTZHYthCkPfc31JJeG+Hr0FrDg1Y/nTJqd0H5ncGCRR5Ux+7vaeCdqQNxjY1LSwWVD69iXj+AxX0Qj095A0xM0G8ZZjfQHe+ejixEkYiX3uKD+uHsPntyxWHQhCEzl5dW0+2H9FjidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641905; c=relaxed/simple;
	bh=tTleSldvzLwMMzIceCnQ1qZlh5qXhLZ52/rIYPe0Lxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFr1+VXfkENzX8a2RarLQTOvDLA7ihB2G2+6ASlPxYgHWj2ZwgaUpO1HGdKL4HG6lLTEuCUfqV/6xu7ZnCkFkdaIzX8hJsb6cQ/ln9ZN9J49VmQUrX0uenFXfw6viv+/VGcTKmQKY73vbPwdNegm5SxuHRSpx/XHb9WYjJvS1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ljDLbhAX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b4J1avQX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ljDLbhAX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b4J1avQX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BF4CEC029C;
	Thu, 13 Aug 2026 13:25:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 13 Aug 2026 13:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786641903;
	 x=1786728303; bh=8emq/qhmz5dUAlbqgfMR81xMpcm1AeMjxc/tRc21+h8=; b=
	ljDLbhAXCjxdFaUe+7TK6H0SgdJopBUIe2OLCmrvf7ivdV0gQL0+ZbiOuNgIbRge
	JTeu8pJGBByrgVZcD5kiPFlbreA6ROauMHnRQ3wwdOKPGDKuZlFWhSsd6x73TFQh
	XntK/S2MvaXgQ5AcyO+zwxS9VWE6JXbDFT0YoXY6Aus87AOnL/TjTYLJ9eDmhFi7
	yT5llTgjalItBG5wA/uM9L3+MI8a4H1HDDluv5NJ6DH/P88qdaJielaNiovj44TC
	bCVdC1gFggKwtXMMYTTJTya1GIg0+5eV0xqkSJpZoide3WlGqQD7HwqsndwUGCwd
	eTn+x2iqB5m9oXjqdti/vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786641903; x=
	1786728303; bh=8emq/qhmz5dUAlbqgfMR81xMpcm1AeMjxc/tRc21+h8=; b=b
	4J1avQXbU+Ten5ELAMHAhIXz/d+FgOdCgXkOtOlMA8v9T8nKSVQTtdv618AHyQYy
	UlcP/98pZ0ElN1z2On/6wQxF5BMd1Ubn4W8qzxSiEO5LbHUbc7UQLdccZLAlpDQX
	OcOUCp4OBX/D40kkwVpJfxqShQYDUgAzyynYeM7Zdr1sg2JdBG9uBbVETd87daV6
	60/23AW3+dF7Rgn5JPgtBoNumjvcrMDu4VJC884X+3US9f5SeMR1jNPw4DxzHXj0
	YeLlwabIaAmidtr1wUpXWt8A6uVDF4pH8DVAYa7XUAEvaudcqPdFuFrT5n6I8WBH
	lBY9M8tWSnHgPEA97YWXw==
X-ME-Sender: <xms:7v19amWh0lhlo1-xfGCz72jb1jIT2tiBfeQBrGwKUGTBOexEqgMEX3M>
    <xme:7v19aokVX0bjltih_1iD_drotFV_HAQzSBt7puPPvwts1FHx-OXIPqZ7kTWAnCw8-
    XV9oY_oTZKwLYTXhaPQhK0tGrsBq6K1UOJJAUvw-E8e_wlf98rWGw>
X-ME-Received: <xmr:7v19aoA3akAmtQI8r6DomiSW1ZyxMJcMraS6260azu3Ty03sYWTFS8NVPNJTB3kMcYu7cUEpJZcOrG4Tj9NzmWn6SPHH_8ibez0ksp34zUCeXrwSUMoeCb0>
X-ME-Proxy-Cause: dmFkZTFlLEnl4DiPP/BvbxYXNZ4tHmpzxc/fXXgC2VzYZDbSGPqZch59bSi5yJiV3I/Xa3
    Uh9fWl/tqRqH56pShqG4/KP7VcgnDG67DZrPQAK97TOg877tAOTYR0TRgtsPXlN6Ye2cpl
    OFWl5IawygMpof2HZCxHp3g+STmZBrPl5Es1tD0wSiku7qHJ9k5EB60D7Y6nD3WaGEvKTQ
    wVKin9w6gV2T40wfBetwJAQgvWyL1uYjQHVi6XZa52z2L/iaAucHPTrNhe0RWArqsmCHzo
    fLVfccA6wOoPwKK7yxx4AQl2eH2sqVQOBOTkfrz2qx9gR6GTxbx7mhTcxKofHVLS62qAZa
    WvBg0Zrr/olifIovfCawtq7254K5VqxMPVzJX8nLrb8mwk2CzxPoJshyk84e5KguunjfQ4
    AnJUzEr3uHhzJGg390N/bIw9wOZb5ttRQLb4oYTmV4cowZDT4PX0PK6vndT1RCLso8rxPZ
    597HuKOxyWp925wIOK6nOzVqacNtl4aeIK8O2Y5S85JRfPC/mF3HQmhDN7E3ymelIcyIAJ
    0lBmBNyFYqyeTIs2+rEoJKOXiq5A+/oP80hYRQABL0Wgc74W6pVxZR+2jJvHPc/218yk+s
    2aadKPdbyTXvrR4sPYfrPBMo+NGJ37yOuPkv2toMWBno0aQ5c0aX216LDyng
X-ME-Proxy: <xmx:7v19aofq8CyTsLV7bNZGilvYTH8Nw3J4HWqV1oUtiQAv3VpZga1xrg>
    <xmx:7v19ajKjg8UFMmiN-3S8RORUwDSJT2pVfAoLsJlzhTLsinUcSnxmKQ>
    <xmx:7v19ardTW8k3eggQeryoi_cAyKeUxkGpIaCNY-OgzbbBJ0gdlIxTYg>
    <xmx:7v19aq3BYYNCefU5cEKGVX77smH-SyqwRiknUXxqB1gIf40OSLRjtg>
    <xmx:7_19ahtGlfn89CcykaDsKQDOprnJ8dfe-ekTbFtP1T67Snt8CAKKrU_I>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:25:01 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/4] format-rev: factor option variables into a struct
Date: Thu, 13 Aug 2026 19:23:58 +0200
Message-ID: <factor_opts_into_struct.b82@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_format-rev_three_more_opts.b80@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
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
 builtin/name-rev.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 254c88199fd..7d824aa1c5d 100644
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
 	data->nul_input = 1;
 	data->nul_output = 1;
 	BUG_ON_OPT_NEG(unset);
@@ -813,31 +816,30 @@ int cmd_format_rev(int argc,
 		   const char *prefix,
 		   struct repository *repo UNUSED)
 {
-	const char *format = NULL;
+	struct format_rev_data data = {
+		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP
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
2.54.0.22.g9e26862b904

