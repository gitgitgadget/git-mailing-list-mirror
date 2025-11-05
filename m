Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273EB2E54B2
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378275; cv=none; b=SKjeI2+l9Zy+vdXcAnE+7A4x17d4sC3p4tTjvrCmSSuvfwAJp1FFDYGSV5sTP10DS+IIz2Cbs8+2L6RghPkGWYz/LFLiuhgwsaWSxR7Uny9kZlzEUzsLT/vcs5QT/aQt2+ptaMmgaiCBXGwVes+V62PX1ZEIaT1wB3EVSwkfE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378275; c=relaxed/simple;
	bh=pqGS1yTPn1mgdVDAaLlewGGgpUsFDugPK6+2dLwSM/o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMApDwFzky+EtDktrhAUW/Kg/LlAdXDs5eGd5qSo0pfFKgQVVvrCzpM/qQMiejo/ca/3GHpqoGCguUL0SEKzFIr/9Wu61yAr1ASadZ4HVyhW+Bns06v2U/wNOxI/fxcI+/wykp9JBk7j9XJ3KYMSr3isl1R05+1Dz5QvnAKKgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Drv1t6HA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SxtpoEpw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Drv1t6HA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SxtpoEpw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75B5C7A009D;
	Wed,  5 Nov 2025 16:31:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 16:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378273; x=
	1762464673; bh=Ydr5WwYD0SNlionukj5ubRNm7UmInwVaBOg7rZS7Xh0=; b=D
	rv1t6HAqN+CljCfJhEfOxTm/hOa3k+Z1luLgSZyChPNmWU/3nZywwjZRBQecpCj9
	5D94ECvj0XEoAPfJKbpvzxQYI0toiS8sG1ufowBzHoBtn76NzhiGDxlJb408toFJ
	d3B5WI4CviVKnHG92OK4gsQN8j7JuJKewpZdxfZ+sHPBGQwxKy/DEiH1xwuEOYOR
	E0CrdHWTDOWOGYG1hY3lOLoyxHPkKMAAbOaZwEcQPxH1O0nP6grPjUtuacnzceYQ
	J5Og7y/nz4erxAm/E5YHSez9Q4b0btcA8zlCAsDzZahDiwuvl0JlXyIUU+O+6XHT
	oBbUEZdsKJUmomJyPNNgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378273; x=1762464673; bh=Ydr5WwYD0SNlionukj5ubRNm7UmI
	nwVaBOg7rZS7Xh0=; b=SxtpoEpwRye4UkoUtdMRF5IudaW5HZ2BQS56iOtRJFXw
	WDqSmpCo4fO9s9mGO3kBV6o5eZ4kfkaNJ4psNCwfCEpKxD1X6pMdTvmhMkW5VFpA
	dez1lntTiroP/7Gx/R1PtMqrjqwQUWTWQ/gS1QbxUX7r94HJWTfTFZkHNDV4Yw7b
	zrWz9FoMu8t9FVONY7BY+jR9eqBUQZM2PO5EMZBV7cBQC3IQMx5twtHo2bfgxWgn
	pQsHIooJy5dM1faFz2VkvHtk3dIZxo4YzCizazdWckP53mFHlOzEP5Q/jqB+H68g
	ERyVlWVjjXXP03YGSll70tGxLEX3+EhBDiAlQmgqmQ==
X-ME-Sender: <xms:IcILado7l3AxGh4LK2do6N7VLiYwpGYNHFUglzu0wjTdDBwDWodq3g>
    <xme:IcILaVr3teHQt-LSeT6mXQegWHVWOLT97fybQfUMc4VhW6aedBcFh_WbXhBwi9WmM
    SgdX2TDKIIhxyJ9Tl1v9Mu2estrL7px9EPzcF5ik3m8dLvl9u9KVw>
X-ME-Received: <xmr:IcILaX0j9t27Si3MXQsOQ6sC2FdMusqYzT8RNWrQft1bIkutLQvkjhAxqu-jNatN4woqfE1A80Fxt6gV1Ny_kTBCgRDPRnFpz9YT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepheenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:IcILaUCzxerjv6ue-kWthGkQ5nh-EISFsQGf3w5duJpY7LJp65tYLw>
    <xmx:IcILafdP_z2EZAXeEyOlP3r_6PsXQADQL7DKkaAfiIF3vEzdb-dL8g>
    <xmx:IcILaZjh2E4ZY4WU50ILBJTj57IDvuo9wuCX8KGZ8IU8V-LfHWaTGg>
    <xmx:IcILaXpQuxCwIJ9iG8sLqJZxtepkB99rR0UrtVMT-tp1MLOXwOnSmA>
    <xmx:IcILaRA_CaC238RBF4po2A6yat8plgbEulqxpym_LNbVFpMyKH4lq3RD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 11/12] diff: highlight and error out on incomplete lines
Date: Wed,  5 Nov 2025 13:30:51 -0800
Message-ID: <20251105213052.1499224-12-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0-105-gc08128fbb6
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
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
2.52.0-rc0-105-gc08128fbb6

