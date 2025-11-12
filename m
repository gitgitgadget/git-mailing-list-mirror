Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125592EB873
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985001; cv=none; b=GcZtI0lWSXW1JTsKSO7fx7yc0hK85Jpl6P4MSWlyR1gQfLHdrEr0WKj20OCCQiOzR+F64JtQjUCn2jhn/s9TFr7vhMutwC+k73MpJ9dmJlCfkevwIk7dY+/Ha/ARVbTwL7CZ2UcyMnZm13gW9wcRnIrH2w7dOhgbEmphVvmvYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985001; c=relaxed/simple;
	bh=3GOHIkSPvM2lLirjS3UHDB+NQ831LudxbXV2KnMs8lc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K37IM+0zga1UUrckszo8pT6PMXZwZrOZZvT0z2rYYp2a2hT+sm5zKPitgLTmRZIxioThKawmx7eGfCRMudW06qSwY5V2BLJneq3R9OZ67cvNA8k9jbgn25utipDOpSYARP3MvhLWLkDOUFvwwLZ1NabSYAtD/8IRbruzpTXtM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W7a5NcgQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uaqpVA9S; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W7a5NcgQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uaqpVA9S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7980F7A00BF;
	Wed, 12 Nov 2025 17:03:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 12 Nov 2025 17:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984999; x=
	1763071399; bh=1kkQXCz3pKZwkaw7xepMfLBxejL0TDDqmUKJHWY7qog=; b=W
	7a5NcgQfmSHpl9OdkMIuXQS4CODNxjjlLAQRz5gkWSjoeIXXj+F5QSGyvSqvVY8g
	y8hmIuuTwiVbkkA3C/S5oJI8DGzeqUaAz+FI7EcOWKVlRTJxM5ugKtn4TP+MCHwq
	4/CdxkEEal0aKSE8ov+mkvYAsO6QgQl1TeryoQwPX6dgea8s2JDebnIhO/PVIuet
	Hcr7ysXot82/RQq0Y5z6Owd5T3jzpSYSgo0IPQR0OXLd0KtxMOWu+eJtXspaly1L
	FhuKuTO0j7nN2XDIlhthdjoxHrmSJOjdJD3JrWueGEGwLWzzJpbBv/obHzFn5dPT
	ffBdxsq3T6LFjIKiIvnsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984999; x=1763071399; bh=1kkQXCz3pKZwkaw7xepMfLBxejL0
	TDDqmUKJHWY7qog=; b=uaqpVA9SgO7DYu+ExAguHjWYhsrqhdIztl63EKb1aomu
	wAxorCpcJmbDKksgLJptepM7bnEw2JAuYgyAW+d52Gz1Xwn83bz6ugZn5zigtz4i
	3u3/llEsKHqYq6TasmXtVsESXJD/dbwtryP/I7M011Kfibc+eVHCgH4osGpUAT60
	tHNdw5Eo9G3l6GsngtSEii77X0Dp0HdpIegMnZg2pmbb0IffSHNq+qghO/ciJuv2
	LjSo4yxTzcw/SsAVDYcqpp/Qz0aPL0IqQEMJ8yTazTH3pbuB9I/iBu5rwmG1oErk
	O5H8PF9Yrjmv8wauuluyaJHi/N3XZlRZ5iMAE4PmIw==
X-ME-Sender: <xms:JwQVaeiWX0_TX_sBQiTCVTsaNzNqmXly2Xtd7Xrn2Lb3V8eKmYp7MQ>
    <xme:JwQVaVBQu9PiEFgHok_NKoTiUk4sjOAd2Vt55_kCm_L4ujY1AfXKliubu3WWFXQOB
    bB5VWKD8EbBLczkpjEU2nZd0yrSoV87kaV2RrAKXoFmb4t7I-yWTQ>
X-ME-Received: <xmr:JwQVaTsI8g5I7TYI8K-ugpTuM5nrInJB--2ai7iOJ8-3suMu_BaN0y01t-CceZoF8sjP7wplNPGzt3ntIgUANGn7oOFKXafmjwPa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:JwQVaSbMsLhaR1wV5NbvXDb3PF3XwxMxeviMmvm7obi0fPTQVV7TiQ>
    <xmx:JwQVaeWNf4uDERyceKAYkC1F0WPBhbf8JIy97N7JV1DczlxeIwyvEQ>
    <xmx:JwQVae4TfwF4lPwItXar9Hsw_rQoaGIUTDCl118y6qh0rYTcNxzaug>
    <xmx:JwQVaRgDAG6t9hK84hG2VqKlj1M6EVgnVnGHbwPLdohSE8KqUNhSXQ>
    <xmx:JwQVaR45EuLXHZiuIWsb2CLI0Dt5btXT_dUKiEvBQ7JxnqVylOAfsf1P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 11/12] diff: highlight and error out on incomplete lines
Date: Wed, 12 Nov 2025 14:02:57 -0800
Message-ID: <20251112220258.1009253-12-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
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
 diff.c                     | 29 +++++++++++++++--
 t/t4015-diff-whitespace.sh | 67 +++++++++++++++++++++++++++++++++++---
 2 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 1b27b15f84..7b7cd50dc2 100644
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
 static void emit_incomplete_line_marker(struct emit_callback *ecbdata,
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
@@ -3254,6 +3264,7 @@ struct checkdiff_t {
 	struct diff_options *o;
 	unsigned ws_rule;
 	unsigned status;
+	int last_line_kind;
 };
 
 static int is_conflict_marker(const char *line, int marker_size, unsigned long len)
@@ -3292,6 +3303,7 @@ static void checkdiff_consume_hunk(void *priv,
 static int checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
+	int last_line_kind;
 	int marker_size = data->conflict_marker_size;
 	const char *ws = diff_get_color(data->o->use_color, DIFF_WHITESPACE);
 	const char *reset = diff_get_color(data->o->use_color, DIFF_RESET);
@@ -3302,6 +3314,8 @@ static int checkdiff_consume(void *priv, char *line, unsigned long len)
 	assert(data->o);
 	line_prefix = diff_line_prefix(data->o);
 
+	last_line_kind = data->last_line_kind;
+	data->last_line_kind = line[0];
 	if (line[0] == '+') {
 		unsigned bad;
 		data->lineno++;
@@ -3324,6 +3338,17 @@ static int checkdiff_consume(void *priv, char *line, unsigned long len)
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
index 9de7f73f42..3c8eb02e4f 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -43,6 +43,53 @@ do
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
+	# The interpretation taken here is "since you are touching
+	# the line anyway, you would better fix the incomplete line
+	# while you are at it."  but this is debatable.
+	echo foo | tr -d "\012" >x &&
+	git add x &&
+	echo bar | tr -d "\012" >x &&
+	git diff x &&
+	test_must_fail git -c core.whitespace=incomplete diff --check x >error &&
+	test_grep "no newline at the end of file" error &&
+	git diff -R x &&
+	test_must_fail git -c core.whitespace=incomplete diff -R --check x >error &&
+	test_grep "no newline at the end of file" error
+'
+
+test_expect_success "fix incomplete line in pre-image" '
+	echo foo | tr -d "\012" >x &&
+	git add x &&
+	echo bar >x &&
+	git diff x &&
+	git -c core.whitespace=incomplete diff --check x &&
+	git diff -R x &&
+	test_must_fail git -c core.whitespace=incomplete diff -R --check x >error &&
+	test_grep "no newline at the end of file" error
+'
+
+test_expect_success "new incomplete line in post-image" '
+	echo foo >x &&
+	git add x &&
+	echo bar | tr -d "\012" >x &&
+	git diff x &&
+	test_must_fail git -c core.whitespace=incomplete diff --check x >error &&
+	test_grep "no newline at the end of file" error &&
+	git diff -R x &&
+	git -c core.whitespace=incomplete diff -R --check x
+'
+
 test_expect_success "Ray Lehtiniemi's example" '
 	cat <<-\EOF >x &&
 	do {
@@ -1040,7 +1087,8 @@ test_expect_success 'ws-error-highlight test setup' '
 	{
 		echo "0. blank-at-eol " &&
 		echo "1. still-blank-at-eol " &&
-		echo "2. and a new line "
+		echo "2. and a new line " &&
+		printf "3. and more"
 	} >x &&
 	new_hash_x=$(git hash-object x) &&
 	after=$(git rev-parse --short "$new_hash_x") &&
@@ -1050,11 +1098,13 @@ test_expect_success 'ws-error-highlight test setup' '
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
@@ -1062,11 +1112,13 @@ test_expect_success 'ws-error-highlight test setup' '
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
@@ -1074,16 +1126,19 @@ test_expect_success 'ws-error-highlight test setup' '
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
@@ -1100,6 +1155,7 @@ test_expect_success 'test --ws-error-highlight option' '
 '
 
 test_expect_success 'test diff.wsErrorHighlight config' '
+	git config core.whitespace blank-at-eol,incomplete-line &&
 
 	git -c diff.wsErrorHighlight=default,old diff --color >current.raw &&
 	test_decode_color <current.raw >current &&
@@ -1116,6 +1172,7 @@ test_expect_success 'test diff.wsErrorHighlight config' '
 '
 
 test_expect_success 'option overrides diff.wsErrorHighlight' '
+	git config core.whitespace blank-at-eol,incomplete-line &&
 
 	git -c diff.wsErrorHighlight=none \
 		diff --color --ws-error-highlight=default,old >current.raw &&
@@ -1135,6 +1192,8 @@ test_expect_success 'option overrides diff.wsErrorHighlight' '
 '
 
 test_expect_success 'detect moved code, complete file' '
+	git config core.whitespace blank-at-eol &&
+
 	git reset --hard &&
 	cat <<-\EOF >test.c &&
 	#include<stdio.h>
-- 
2.52.0-rc2-441-g030905368a

