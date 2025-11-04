Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE323EA95
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222193; cv=none; b=R4iLsnUsvSyaZYKk02oTSytUbigOdsqTP7Uc1SnjFS5yuAGtMt9UpasQkCsryhMSELlZ6hpFtYFHBWfKCumL5QLnJBy21bblZ7/paKbeuIDGAU3kBz3LombFi5x4BLqP1oDAZ56EYkbpMBgfbVB5eFuB7oBHO3tDUQe8eVjpzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222193; c=relaxed/simple;
	bh=i4ZbMxJx0ixKOqjvxJpA+qBGWfFIWMTUJtwiWDF5wJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORLB5gfzWo4ytAOuS2MxmHKbJchSzreQqzfViaiIyF1uJEkLn3xiVOMM5xpV+I0qVGbgmwn5I+KV9kWhyWOFhue7d5t5QmYz5JQ+JRwxgB8X3vTtGeMSKV0c07fGejYppo7xj3GS82JR/KFSsXwFahme/mejbw9a7nUaOGwYklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gPCV7G6v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PyHk1b8v; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gPCV7G6v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PyHk1b8v"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54DBC7A03F4;
	Mon,  3 Nov 2025 21:09:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 21:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222190; x=
	1762308590; bh=/0RjpB2cnczpxLgEKW4TcQilbBOQA+EGK9Jd6GY9K3g=; b=g
	PCV7G6vYHFufSydzKwAyB6JVHK49i4HgWRMPCi9nMlund6nKse9egOK1oOJNvRo3
	d0Zm6qgCAwNJxfU2aJThXRN3cKGvpL7mOv2HQheB/FPSfC8yE+Q6oNwOyuKoSEe1
	x4wXUG89KvkJKbgasI97G7kP675U/4XwXIPfbXw+A0eBsXOAtUcH5VSyYfR4DC7X
	VotFEJYCmjRSl+xGxKDpK7ryOdLVHELh0U8R9jLBX4VGEAADDMcCeeHtenvIcquK
	1YOzRPjDT5EP0UvyatSHspVJfhhWBApB9X4idRffPH/1U2cFt0BoIgJXblXq2NNA
	tSCG4axWPwg5ImN/FyBog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222190; x=1762308590; bh=/0RjpB2cnczpxLgEKW4TcQilbBOQ
	A+EGK9Jd6GY9K3g=; b=PyHk1b8vObsAnELarusBoUvIYdS3fIzIXt+yu6kv1Ay1
	BzTonGRyG04E4M2EO4e1kmMCx69Lgn4MdFwgUfmNhz7JFzLVHCZi7d7XsKjpt6vc
	Rb/PlCOMHbmV4odwko7gB8Jb2YhP+S/xB6WZO6fiAcKbnciQXT7/1eOBlehlYUw+
	1u2ZfBN0aOEzRioSygqW7exkLfA0RZ22uJAiATe2XOj6lyHE9hbXHJ1FKvf5XJlZ
	ZNSWZLfUVHTKq0hI8YLDFQfeVAMdjwI4eCJ9l7stTgSr1ZneyUMj/Z6IkPLll2Wf
	KlSOnwgfruiWYJpYNQXjNduKIpWZQ+8cTBNZAaO1XA==
X-ME-Sender: <xms:bmAJab0k8Ce-oilu4jybMgLl1-WhxcUrox556jFzT_hYmdd-KgWECQ>
    <xme:bmAJaQESEV_K_2wdXQ1cMSZHKuNhc67W7wLOpp6ZNVR067AHHjSypU8SoqeApYavQ
    lwmYGumzku1AbrnCbPZin6ZwcrgTVe-WeSm0kVegjAbKoEDBb3Ahw>
X-ME-Received: <xmr:bmAJaZiGpnuXwjizsAxfqOgye2hXPsFR4WEX-r_DXpcb_0IMiJUiJnMtah_ggzF8YcUwHLm-ZogChlmXzDKjqxoDVcXpt7OnwKE7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:bmAJab8nzk7aoADVLR7l7Uxj-1htW6Fa-ra6wJww228BMsGbUytZbw>
    <xmx:bmAJaQoEV_UzYsfJMRIdKsVGzEF2Z_65LbxLU1R5kKz8RFTAQMp5VA>
    <xmx:bmAJaa-ffaa85f5gRuWVLu7yJgosodcnxwow9MfVTQR6aNa0sQvN3g>
    <xmx:bmAJaUXq3JOtmq36WqHYQNoVnB-cmbS07P4JuMBqpNfgwnybbGWMMw>
    <xmx:bmAJaXNVL64CW_36HV1MKkwfAFzpEcOYR7mnF-uRif1hN_SLK1GGhsqH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 11/12] diff: highlight and error out on incomplete lines
Date: Mon,  3 Nov 2025 18:09:27 -0800
Message-ID: <20251104020928.582199-12-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0
In-Reply-To: <20251104020928.582199-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach "git diff" to highlight "\ No newline at end of file" message
as a whitespace error when incomplete-line whitespace error class is
in effect.  Thanks to the previous refactoring of complete rewrite
code path, we can do this at a single place.

Unlike whitespace errors in the payload where we need to annotate in
line, possibly using colors, the line that has whitespace problems,
we have a dedicated line already that can serve as the error
message, so paint it as a whitespace error message.

Also teach "git diff --check" to notice incomplete lines as
whitespace errors and report when incomplete-line whitespace error
class is in effect.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     | 29 ++++++++++++++++--
 t/t4015-diff-whitespace.sh | 63 +++++++++++++++++++++++++++++++++++---
 2 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 8d03146aaa..965b97f7f0 100644
--- a/diff.c
+++ b/diff.c
@@ -1370,7 +1370,11 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		emit_line(o, "", "", line, len);
 		break;
 	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
-		set = diff_get_color_opt(o, DIFF_CONTEXT);
+		if ((flags & WS_INCOMPLETE_LINE) &&
+		    (flags & o->ws_error_highlight))
+			set = diff_get_color_opt(o, DIFF_WHITESPACE);
+		else
+			set = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		emit_line(o, set, reset, line, len);
 		break;
@@ -1666,8 +1670,14 @@ static void emit_context_line(struct emit_callback *ecbdata,
 static void emit_incomplete_line(struct emit_callback *ecbdata,
 				 const char *line, int len)
 {
+	int last_line_kind = ecbdata->last_line_kind;
+	unsigned flags = (last_line_kind == '+'
+			  ? WSEH_NEW
+			  : last_line_kind == '-'
+			  ? WSEH_OLD
+			  : WSEH_CONTEXT) | ecbdata->ws_rule;
 	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
-			 line, len, 0);
+			 line, len, flags);
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -3257,6 +3267,7 @@ struct checkdiff_t {
 	struct diff_options *o;
 	unsigned ws_rule;
 	unsigned status;
+	int last_line_kind;
 };
 
 static int is_conflict_marker(const char *line, int marker_size, unsigned long len)
@@ -3295,6 +3306,7 @@ static void checkdiff_consume_hunk(void *priv,
 static int checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
+	int last_line_kind;
 	int marker_size = data->conflict_marker_size;
 	const char *ws = diff_get_color(data->o->use_color, DIFF_WHITESPACE);
 	const char *reset = diff_get_color(data->o->use_color, DIFF_RESET);
@@ -3305,6 +3317,8 @@ static int checkdiff_consume(void *priv, char *line, unsigned long len)
 	assert(data->o);
 	line_prefix = diff_line_prefix(data->o);
 
+	last_line_kind = data->last_line_kind;
+	data->last_line_kind = line[0];
 	if (line[0] == '+') {
 		unsigned bad;
 		data->lineno++;
@@ -3327,6 +3341,17 @@ static int checkdiff_consume(void *priv, char *line, unsigned long len)
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
 		data->lineno++;
+	} else if (line[0] == '\\') {
+		/* no newline at the end of the line */
+		if ((data->ws_rule & WS_INCOMPLETE_LINE) &&
+		    (last_line_kind == '+')) {
+			unsigned bad = WS_INCOMPLETE_LINE;
+			data->status |= bad;
+			err = whitespace_error_string(bad);
+			fprintf(data->o->file, "%s%s:%d: %s.\n",
+				line_prefix, data->filename, data->lineno, err);
+			free(err);
+		}
 	}
 	return 0;
 }
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 9de7f73f42..138730cbce 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -43,6 +43,49 @@ do
 	'
 done
 
+test_expect_success "incomplete line in both pre- and post-image context" '
+	(echo foo && echo baz | tr -d "\012") >x &&
+	git add x &&
+	(echo bar && echo baz | tr -d "\012") >x &&
+	git diff x &&
+	git -c core.whitespace=incomplete diff --check x &&
+	git diff -R x &&
+	git -c core.whitespace=incomplete diff -R --check x
+'
+
+test_expect_success "incomplete lines on both pre- and post-image" '
+	# The interpretation taken here is "since you are toucing
+	# the line anyway, you would better fix the incomplete line
+	# while you are at it."  but this is debatable.
+	echo foo | tr -d "\012" >x &&
+	git add x &&
+	echo bar | tr -d "\012" >x &&
+	git diff x &&
+	test_must_fail git -c core.whitespace=incomplete diff --check x &&
+	git diff -R x &&
+	test_must_fail git -c core.whitespace=incomplete diff -R --check x
+'
+
+test_expect_success "fix incomplete line in pre-image" '
+	echo foo | tr -d "\012" >x &&
+	git add x &&
+	echo bar >x &&
+	git diff x &&
+	git -c core.whitespace=incomplete diff --check x &&
+	git diff -R x &&
+	test_must_fail git -c core.whitespace=incomplete diff -R --check x
+'
+
+test_expect_success "new incomplete line in post-image" '
+	echo foo >x &&
+	git add x &&
+	echo bar | tr -d "\012" >x &&
+	git diff x &&
+	test_must_fail git -c core.whitespace=incomplete diff --check x &&
+	git diff -R x &&
+	git -c core.whitespace=incomplete diff -R --check x
+'
+
 test_expect_success "Ray Lehtiniemi's example" '
 	cat <<-\EOF >x &&
 	do {
@@ -1040,7 +1083,8 @@ test_expect_success 'ws-error-highlight test setup' '
 	{
 		echo "0. blank-at-eol " &&
 		echo "1. still-blank-at-eol " &&
-		echo "2. and a new line "
+		echo "2. and a new line " &&
+		printf "3. and more"
 	} >x &&
 	new_hash_x=$(git hash-object x) &&
 	after=$(git rev-parse --short "$new_hash_x") &&
@@ -1050,11 +1094,13 @@ test_expect_success 'ws-error-highlight test setup' '
 	<BOLD>index $before..$after 100644<RESET>
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
-	<CYAN>@@ -1,2 +1,3 @@<RESET>
+	<CYAN>@@ -1,2 +1,4 @@<RESET>
 	 0. blank-at-eol <RESET>
 	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
 	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
 	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
+	<GREEN>+<RESET><GREEN>3. and more<RESET>
+	<BLUE>\ No newline at end of file<RESET>
 	EOF
 
 	cat >expect.all <<-EOF &&
@@ -1062,11 +1108,13 @@ test_expect_success 'ws-error-highlight test setup' '
 	<BOLD>index $before..$after 100644<RESET>
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
-	<CYAN>@@ -1,2 +1,3 @@<RESET>
+	<CYAN>@@ -1,2 +1,4 @@<RESET>
 	 <RESET>0. blank-at-eol<RESET><BLUE> <RESET>
 	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
 	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
 	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
+	<GREEN>+<RESET><GREEN>3. and more<RESET>
+	<BLUE>\ No newline at end of file<RESET>
 	EOF
 
 	cat >expect.none <<-EOF
@@ -1074,16 +1122,19 @@ test_expect_success 'ws-error-highlight test setup' '
 	<BOLD>index $before..$after 100644<RESET>
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
-	<CYAN>@@ -1,2 +1,3 @@<RESET>
+	<CYAN>@@ -1,2 +1,4 @@<RESET>
 	 0. blank-at-eol <RESET>
 	<RED>-1. blank-at-eol <RESET>
 	<GREEN>+1. still-blank-at-eol <RESET>
 	<GREEN>+2. and a new line <RESET>
+	<GREEN>+3. and more<RESET>
+	\ No newline at end of file<RESET>
 	EOF
 
 '
 
 test_expect_success 'test --ws-error-highlight option' '
+	git config core.whitespace blank-at-eol,incomplete-line &&
 
 	git diff --color --ws-error-highlight=default,old >current.raw &&
 	test_decode_color <current.raw >current &&
@@ -1100,6 +1151,7 @@ test_expect_success 'test --ws-error-highlight option' '
 '
 
 test_expect_success 'test diff.wsErrorHighlight config' '
+	git config core.whitespace blank-at-eol,incomplete-line &&
 
 	git -c diff.wsErrorHighlight=default,old diff --color >current.raw &&
 	test_decode_color <current.raw >current &&
@@ -1116,6 +1168,7 @@ test_expect_success 'test diff.wsErrorHighlight config' '
 '
 
 test_expect_success 'option overrides diff.wsErrorHighlight' '
+	git config core.whitespace blank-at-eol,incomplete-line &&
 
 	git -c diff.wsErrorHighlight=none \
 		diff --color --ws-error-highlight=default,old >current.raw &&
@@ -1135,6 +1188,8 @@ test_expect_success 'option overrides diff.wsErrorHighlight' '
 '
 
 test_expect_success 'detect moved code, complete file' '
+	git config core.whitespace blank-at-eol &&
+
 	git reset --hard &&
 	cat <<-\EOF >test.c &&
 	#include<stdio.h>
-- 
2.52.0-rc0

