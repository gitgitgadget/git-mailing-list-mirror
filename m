Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43F26158B
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047073; cv=none; b=EPj3JEx1CNGA/FBxN0c1QmYsphidMqmxVb8qmEH3EFSVk4OvKwU8glLIvEsl+Xzcpuk3dTGaD08+n28xllbwzg/5KXhab/bucBvXqDqskpH2HBWS4zjX/bX5+DYB083kwhdUlkfn0yJaJNnP92Akk0Lr8krXKoxueub+o1jqcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047073; c=relaxed/simple;
	bh=V6rn5CqwGAKOchKqabumqohMXTEiunBVBgbOnK2QNW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubdLmze3BXtJjHJUipR8E9mUxgref27xyKGURfMd5uJSxjlvMzl+8BKOFLT5nZWH/sKo/a40y1atFqZ6AEjYQZup4bVjdk6eFAE+D0OAtHhi+klSKf3pwD9Wi4nB737NlTW8WdhcX5OCJrJBwUaigsMNwnKrgJ0MQvjJbFSelMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fk378WQr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TzLGmsPA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fk378WQr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzLGmsPA"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C99E9EC0254;
	Tue, 18 Aug 2026 05:57:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 18 Aug 2026 05:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787047070;
	 x=1787133470; bh=ShtCSGEikDm7cxz7VBNMJxjL8rNNN80d8665ms6wfJE=; b=
	fk378WQrLeAgxq3yJaLvKm+7dv7mw0z5i9okGzZmOaj4Hk1cG5ZFXXxTLDcV5EcT
	vDl6llPqmaOI1d6RSvOeA35Na3T8a9+YvyhXhWniasVPLzokD2Fzg6LhpPFabzsX
	AslYM4nYLvE5GF6OJW8tj2WNMleGVRATCVcLv98lnZHedP0kDFx7a3w2aYJa92D9
	yF/t3p0m4LlmNrEdSKIhhE2gwfAyXnUSfkV6e6uu2wbmpwWaDRhEbfd1Q+jAxBqL
	7QOxlOn34GU7k8ss2vXQzULJcW31CqE0adA8s1ZJK4zLPzliRyMM3GOgaei3+GfG
	NHz4vSz7kcPFaPUM7NmcFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787047070; x=
	1787133470; bh=ShtCSGEikDm7cxz7VBNMJxjL8rNNN80d8665ms6wfJE=; b=T
	zLGmsPAG3xg2q93vTaPx4gXS5U3E8lU9GyfOtGxvzo+0OekeU/dKY87zi5AKbgEC
	NbJ54trnB/GAKpQNlo71fu3YbQwLZphywykC84I+FmydzpNI343wJr2zPEtu6ff9
	7MvczDbFmrZkKWvqGRFbFNSNsz5F7wEgDGbJT3x7fqzBas6btx3LWQpoUIrzFlF4
	wLQ8Wtr6zQRh+ol0WXT2UEx+AEPHEW1soYV9kccLssiTRcwFWmK/+XZgLUfsWLrv
	89pmwBFFuu/t7wTKUitzD4rmUyB9aWMLVjie0mQ77lUD82+hzjUzH1IXdX5NTITQ
	TwDnul9txy+RFny9Ytfgw==
X-ME-Sender: <xms:niyEasyMNVCEJ0yT8Mp3MWV018VNHZvsF5jg8OQFNP2vmGC-h-CN5B0>
    <xme:niyEamTa78_tGXJM6aZDQze3PPCYRwf5YXRljhEfuBhA0wBb7OHwPbDhTm0vk9Opb
    ZryMATvmGGJdSQ7FfggymMuD5WrjS1ZxodCT7tVgT6HgEu1Q1UWi1Y>
X-ME-Received: <xmr:niyEar_KzkcA5VCdlWyt1Ch65IG7feelh8LEjl4ZYFQCMIqiMzhgykA1L76y2Kw84R-w6GtjCnc7MXiTULDvgu48m7n7Oz5UYEyraGY>
X-ME-Proxy-Cause: dmFkZTGz99n9Ru15PZqXiXbMtIXV0tRymH1SYCnZvUIaD7G20z3oFe1nVvDPYFmWad6SlX
    x4Ces8fRG9ev+FlPkzGdjCfTcSLEnL1CW4XKcbUf+Nnrhhbm+/OHtAhP398uAUxLKqSODN
    c1rQI+dpD4mGBk2D/zx3ZnDxKt2FKzDYYm9dna4V8hNo1bwLXltn2eKCAe3bjliTvcjjSw
    25kCIsbJg40lCbBv/X5JerPyVdYPhsba5rgPQFmhQIVyfiVVHBa7N2Nd+CQ3olJuCfcdfR
    tcg/aY/HWl8jnMoycJHERZvR+OKilmWLpbUGozeMsCWlQC4yuB7SfqrsO9SHc/xNn+9RaI
    cXQREFdU3EwzjhQsDxuo58VwllQRHj43gNeb4FWthDf3iitGWBsC9GDsobxYkfu0ZmKLcZ
    1a4Y80xX8CPzMZHENcW+DXUkfLEmgt4JAGoxJPKRDlvq2gPZXbL9Xr4acRMMjXsNUZ3dgu
    UJUfNtlZScuT2CPrd/IgyDIq5nVf4XmAi7rHYaRiJAupQq1jKHd/+JyMbuNM+bT93rg/cz
    aUjlQb+V5fAiXMIrCi1CaOU10jPuE1LeuXGFU8vHT7iemD3Lia40ORdXbnmTNAumoKMc3D
    vsS5AZGdDgmYnxoelzoLLevT8VmXtwbDRtHVmtR71qTDmRCS7+gYI8XU0OCQ
X-ME-Proxy: <xmx:niyEalo2Ig9Gpa5PIM7zVjBRa-yKo6CHgnkN4jFZRMAzClbv5dPayg>
    <xmx:niyEagl-JD_c8bBm4dWsDW_SQH2TD9N_dCNp4OFpWNEWhPm0MzGx5Q>
    <xmx:niyEakKrqUchbFbEEtIwr6Dw6uMVJbVmbLalL6Q2J-24Cl0JNN_8iw>
    <xmx:niyEatzph-u6IoyL8U3dGSdrj14zrSbnY2yDuM5IaGO5OKV3va2URw>
    <xmx:niyEagLxLJHKRorsg0fLii6DiNUdt4HsnJpI22NfONY4PS7dk88yw7N6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 05:57:49 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
Date: Tue, 18 Aug 2026 11:57:29 +0200
Message-ID: <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
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

Topic name (applied): kh/format-rev-more-options

Topic summary: Add three more options for controlling the formatting. Also
do some minor refactoring and text fixes as preparatory steps.

§ Changes in v2

See the patch notes for details.

• Use designated initializer syntax. That’s more readable since you pair
  the field with the value and you can omit zero-value fields.

  https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
• Fix useless `BUG` placements https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
• Add preliminary patch “place BUG calls first in callback” for existing
  `BUG` statement placement
  • Based on the previous point
• Patch “learn --abbrev, --color, and --date”: test a few more options

[1/5] format-rev: use lower case for opts description
[2/5] format-rev: place BUG calls first in callback
[3/5] format-rev: factor option variables into a struct
[4/5] doc: rev-list-options.adoc: factor out --date alts
[5/5] format-rev: learn --abbrev, --color, and --date

 Documentation/git-format-rev.adoc             | 44 ++++++++-
 .../rev-list-option-date-alternatives.adoc    | 55 +++++++++++
 Documentation/rev-list-options.adoc           | 56 +----------
 builtin/name-rev.c                            | 92 ++++++++++++-------
 t/t6120-describe.sh                           | 58 ++++++++++++
 5 files changed, 212 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/rev-list-option-date-alternatives.adoc

Interdiff against v1:
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 0c9014ca594..fa20a2774be 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -788,10 +788,10 @@ static int format_nul_cb(const struct option *option,
 			 int unset)
 {
 	struct format_rev_data *data = option->value;
-	data->nul_input = 1;
-	data->nul_output = 1;
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
+	data->nul_input = 1;
+	data->nul_output = 1;
 	return 0;
 }
 
@@ -800,9 +800,9 @@ static int date_cb(const struct option *option,
 		   int unset)
 {
 	struct rev_info *data = option->value;
+	BUG_ON_OPT_NEG(unset);
 	parse_date_format(arg, &data->date_mode);
 	data->date_mode_explicit = 1;
-	BUG_ON_OPT_NEG(unset);
 	return 0;
 }
 
@@ -830,8 +830,9 @@ int cmd_format_rev(int argc,
 		   struct repository *repo UNUSED)
 {
 	struct format_rev_data data = {
-		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP,
-		REV_INFO_INIT, GIT_COLOR_AUTO
+		.notes = STRING_LIST_INIT_NODUP,
+		.rev = REV_INFO_INIT,
+		.color = GIT_COLOR_AUTO,
 	};
 	enum stdin_mode stdin_mode;
 	char output_terminator;
@@ -953,6 +954,7 @@ int cmd_format_rev(int argc,
 		BUG("uncovered case: %d", stdin_mode);
 	}
 
+	date_mode_release(&data.rev.date_mode);
 	strbuf_release(&scratch_buf);
 	string_list_clear(&data.notes, 0);
 	release_display_notes(&format_notes_opt);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2621edb5937..a15da979abf 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -1026,9 +1026,9 @@ format_rev_cmp_log () {
 	first
 	EOF
 	git -C repo-format log --stdin --no-walk \
-		"$opts" --format="$format" >expect <input &&
-	git -C repo-format format-rev "$opts" \
-		--stdin-mode=revs --format="$format" >actual <input &&
+		--format="$format" "$opts" >expect <input &&
+	git -C repo-format format-rev --stdin-mode=revs \
+		--format="$format" "$opts" >actual <input &&
 	test_cmp expect actual
 }
 
@@ -1037,9 +1037,9 @@ format_rev_err_cmp_log () {
 	format=reference
 	# No input since we ought to fail while parsing options
 	test_must_fail git -C repo-format log --stdin --no-walk \
-		"$opts" --format="$format" 2>expect &&
-	test_must_fail git -C repo-format format-rev "$opts" \
-		--stdin-mode=revs --format="$format" 2>actual &&
+		--format="$format" "$opts" 2>expect &&
+	test_must_fail git -C repo-format format-rev \
+		--stdin-mode=revs --format="$format" "$opts" 2>actual &&
 	test_cmp expect actual
 }
 
@@ -1051,6 +1051,7 @@ test_expect_success 'format-rev --color' '
 '
 
 test_expect_success 'format-rev --abbrev' '
+	format_rev_cmp_log --abbrev &&
 	format_rev_cmp_log --abbrev=31 &&
 	format_rev_cmp_log --no-abbrev
 '
@@ -1058,7 +1059,20 @@ test_expect_success 'format-rev --abbrev' '
 test_expect_success 'format-rev --date' '
 	format_rev_cmp_log --date=relative &&
 	format_rev_cmp_log --date=iso-strict &&
-	format_rev_err_cmp_log --date=not-valid
+	# This also tests the only case where we need to release
+	# the data for the parsed format
+	format_rev_cmp_log --date="format:%c" &&
+	format_rev_err_cmp_log --date=not-valid &&
+	# Test --date (no arg) next
+	# We cannot compare the output to git-log(1)
+	# because that command uses a slightly different
+	# error message (different library)
+	cat >expect <<-EOF &&
+	error: option \`date${SQ} requires a value
+	EOF
+	test_must_fail git -C repo-format format-rev \
+		--stdin-mode=revs --format="$format" --date 2>actual &&
+	test_cmp expect actual
 '
 
 test_done
Range-diff against v1:
1:  eb84b1b6341 = 1:  eb84b1b6341 format-rev: use lower case for opts description
-:  ----------- > 2:  2cb12e3ce48 format-rev: place BUG calls first in callback
2:  278eb852121 ! 3:  0b653b1d218 format-rev: factor option variables into a struct
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
      {
     -	struct format_nul_data *data = option->value;
     +	struct format_rev_data *data = option->value;
    - 	data->nul_input = 1;
    - 	data->nul_output = 1;
      	BUG_ON_OPT_NEG(unset);
    + 	BUG_ON_OPT_ARG(arg);
    + 	data->nul_input = 1;
     @@ builtin/name-rev.c: int cmd_format_rev(int argc,
      		   const char *prefix,
      		   struct repository *repo UNUSED)
      {
     -	const char *format = NULL;
     +	struct format_rev_data data = {
    -+		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP
    ++		.notes = STRING_LIST_INIT_NODUP,
     +	};
      	enum stdin_mode stdin_mode;
     -	const char *stdin_mode_arg = NULL;
3:  cb2cc772b31 = 4:  7556bf04462 doc: rev-list-options.adoc: factor out --date alts
4:  e6d3e14c692 ! 5:  d1bcad06e24 format-rev: learn --abbrev, --color, and --date
    @@ builtin/name-rev.c: static int format_nul_cb(const struct option *option,
     +		   int unset)
     +{
     +	struct rev_info *data = option->value;
    ++	BUG_ON_OPT_NEG(unset);
     +	parse_date_format(arg, &data->date_mode);
     +	data->date_mode_explicit = 1;
    -+	BUG_ON_OPT_NEG(unset);
     +	return 0;
     +}
     +
    @@ builtin/name-rev.c: static enum stdin_mode parse_stdin_mode(const char *stdin_mo
      };
      
     @@ builtin/name-rev.c: int cmd_format_rev(int argc,
    - 		   struct repository *repo UNUSED)
      {
      	struct format_rev_data data = {
    --		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP
    -+		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP,
    -+		REV_INFO_INIT, GIT_COLOR_AUTO
    + 		.notes = STRING_LIST_INIT_NODUP,
    ++		.rev = REV_INFO_INIT,
    ++		.color = GIT_COLOR_AUTO,
      	};
      	enum stdin_mode stdin_mode;
      	char output_terminator;
    @@ builtin/name-rev.c: int cmd_format_rev(int argc,
      
      	userformat_find_requirements(data.format,
      				     &format_pp.want);
    +@@ builtin/name-rev.c: int cmd_format_rev(int argc,
    + 		BUG("uncovered case: %d", stdin_mode);
    + 	}
    + 
    ++	date_mode_release(&data.rev.date_mode);
    + 	strbuf_release(&scratch_buf);
    + 	string_list_clear(&data.notes, 0);
    + 	release_display_notes(&format_notes_opt);
     
      ## t/t6120-describe.sh ##
     @@ t/t6120-describe.sh: do
    @@ t/t6120-describe.sh: do
     +	first
     +	EOF
     +	git -C repo-format log --stdin --no-walk \
    -+		"$opts" --format="$format" >expect <input &&
    -+	git -C repo-format format-rev "$opts" \
    -+		--stdin-mode=revs --format="$format" >actual <input &&
    ++		--format="$format" "$opts" >expect <input &&
    ++	git -C repo-format format-rev --stdin-mode=revs \
    ++		--format="$format" "$opts" >actual <input &&
     +	test_cmp expect actual
     +}
     +
    @@ t/t6120-describe.sh: do
     +	format=reference
     +	# No input since we ought to fail while parsing options
     +	test_must_fail git -C repo-format log --stdin --no-walk \
    -+		"$opts" --format="$format" 2>expect &&
    -+	test_must_fail git -C repo-format format-rev "$opts" \
    -+		--stdin-mode=revs --format="$format" 2>actual &&
    ++		--format="$format" "$opts" 2>expect &&
    ++	test_must_fail git -C repo-format format-rev \
    ++		--stdin-mode=revs --format="$format" "$opts" 2>actual &&
     +	test_cmp expect actual
     +}
     +
    @@ t/t6120-describe.sh: do
     +'
     +
     +test_expect_success 'format-rev --abbrev' '
    ++	format_rev_cmp_log --abbrev &&
     +	format_rev_cmp_log --abbrev=31 &&
     +	format_rev_cmp_log --no-abbrev
     +'
    @@ t/t6120-describe.sh: do
     +test_expect_success 'format-rev --date' '
     +	format_rev_cmp_log --date=relative &&
     +	format_rev_cmp_log --date=iso-strict &&
    -+	format_rev_err_cmp_log --date=not-valid
    ++	# This also tests the only case where we need to release
    ++	# the data for the parsed format
    ++	format_rev_cmp_log --date="format:%c" &&
    ++	format_rev_err_cmp_log --date=not-valid &&
    ++	# Test --date (no arg) next
    ++	# We cannot compare the output to git-log(1)
    ++	# because that command uses a slightly different
    ++	# error message (different library)
    ++	cat >expect <<-EOF &&
    ++	error: option \`date${SQ} requires a value
    ++	EOF
    ++	test_must_fail git -C repo-format format-rev \
    ++		--stdin-mode=revs --format="$format" --date 2>actual &&
    ++	test_cmp expect actual
     +'
     +
      test_done

base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
2.55.0.13.g85d2d65e389

