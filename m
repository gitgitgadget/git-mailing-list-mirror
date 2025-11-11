Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C060B8A
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819516; cv=none; b=mw4y2fYTUl68cHrHrhPJHCXAJN5eVavV6gebi1wrmKUZCsWXFirzy0wpC5ElbLB0cFygpebX8uV3kPtCE8qcQLaLTWl4EpbMi5ElCOxmngCowoHPoOhkp5H9b5AM03pOJIBdRqHM9ohC0vqu1bglAq4oXz7WIC9mTatdJXb4v/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819516; c=relaxed/simple;
	bh=A9mkqpXF5DjAFgaZTODzzA+duBiHq+kuUBvHqDwmSEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzdmUr3mDIpqlst88ErfCbj7q1T3SBY5j1xl4LFHVD+IFpVYqNwoffKydvb7wZ50l+U0TKPOk4PWb3NAiNbwIAhYxOSMcL6G1jyL7r7UCAFxLMPtuJ5YNuWC0zfiiQBu175kO/LHFWFPQ/ZMnFHrsUtWCpTAGKk0hPmaft2VVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dSNZAvJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cMXInCCg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dSNZAvJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cMXInCCg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B958D7A019F;
	Mon, 10 Nov 2025 19:05:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 19:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819513; x=
	1762905913; bh=7zbDaCBYpruCTDtJmB1HUfX1skPnRgD+W+pWt0EJBbg=; b=d
	SNZAvJ7aOaZ48QNA/Ufzqlfl9lKEjfELBsmuYfu7emIgXPVoLq0Mag/9OWce2iVE
	EcUwWDRbz37GF+Nc9+mSdjv45rw3FNg8TY59yxm/rMaDgA1ewCBGssJwgkBcg1x7
	MNZBL6JtUivxFTw5KjBeAj3WphN0MNGLrzs3SAEmmu6tArQ9xPOZzLfwShh3Tt8W
	nZNaKrq6HdyBui2eaq89HlYBcBQ5xwWMXTF8vzI9gjgL0cIHdnNRsAabbJeQh2Nm
	A7dsExgGKXCKI3wiLlOqqUXdwR8vjKQgBOALaWPLEG2bWsFdT8LefellbEz/zpKJ
	2r76/b2mRftzwFp8/UywA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819513; x=1762905913; bh=7zbDaCBYpruCTDtJmB1HUfX1skPn
	RgD+W+pWt0EJBbg=; b=cMXInCCgAwv43M5qdGtWJRMp0b2NbRJBXCKc6QunpvwF
	T72rrHhyqfBO7xNHzs53ah/kzp+BIoiquKSCOBz7QojRE/L5sfUQSsbHdFhuNdNn
	C6q9K3gT48WscLWF1ZNplucxJx+8iWMijCL2reMbhBi+bkatinzKQXZ7aaEjQqdc
	d7E5IeJ6GIfuh2Z5+sa2RwMkhN3dOFicqkTAzkc24ZglUGoJrkr0Ij81g3Eya6S5
	axpHTYoJtobsKnQRPgS6n7KiVDRhAWJV3AWYzQOGXLiQB2CDAthTMQAe3v7bbU8J
	IKsPUxiLftX8cboECSw4kZNrUezB8/nseuSp/lpQKA==
X-ME-Sender: <xms:uX0SaQDfJKysXxRYnXDXhbsSe_UOUlywzn4nvlr9lkV_Z-Gc6Z1oGw>
    <xme:uX0SaYiSoNgvU1aLnnB9_ASbeUZq7ZeaWZXtEqyM54INMxF4ZFtVuFarIptbYqM2v
    3wD37NFBbj_roAJnHnSa2fPqhimdfks3bGsHzJmaUMZYjQBRsve>
X-ME-Received: <xmr:uX0SaROKrbmZFfnc3QMAfIAiIgQtuZDQp1jof5hkeE7B5XRy7AD3drwRbxy9m93fdyq3n91rD1O7MCc_qT262RFjeze4zPxht4WM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepheenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:uX0SaR4lT-T8SoZqFqRk_oIgPBDDl-cD1S77J2Avg0GBYqKq-LdLIQ>
    <xmx:uX0SaX0_enZwZQNVFKccAj1exsMLO2SstIUbjRP05c1t7Gh_AQ9DDw>
    <xmx:uX0SaaZB69FFjiSeRIa4KhAUWeJpOhABMKRCvaDdVRYzKztXWrLHSw>
    <xmx:uX0SaXDKwhKeCz3Ow8ApybBsc_5ZZ8D9VeesCop6J-nKxCEJt9utxQ>
    <xmx:uX0SaTZtVblfcH39VP9zQQ09p4B6CTZbJT0oqvAh_mWg2M8CJzaZ8X9P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 11/12] diff: highlight and error out on incomplete lines
Date: Mon, 10 Nov 2025 16:04:50 -0800
Message-ID: <20251111000451.2243195-12-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111000451.2243195-1-gitster@pobox.com>
References: <20251105213052.1499224-1-gitster@pobox.com>
 <20251111000451.2243195-1-gitster@pobox.com>
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
index 64cf1f139f..e12931c5e7 100644
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
@@ -3259,6 +3269,7 @@ struct checkdiff_t {
 	struct diff_options *o;
 	unsigned ws_rule;
 	unsigned status;
+	int last_line_kind;
 };
 
 static int is_conflict_marker(const char *line, int marker_size, unsigned long len)
@@ -3297,6 +3308,7 @@ static void checkdiff_consume_hunk(void *priv,
 static int checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
+	int last_line_kind;
 	int marker_size = data->conflict_marker_size;
 	const char *ws = diff_get_color(data->o->use_color, DIFF_WHITESPACE);
 	const char *reset = diff_get_color(data->o->use_color, DIFF_RESET);
@@ -3307,6 +3319,8 @@ static int checkdiff_consume(void *priv, char *line, unsigned long len)
 	assert(data->o);
 	line_prefix = diff_line_prefix(data->o);
 
+	last_line_kind = data->last_line_kind;
+	data->last_line_kind = line[0];
 	if (line[0] == '+') {
 		unsigned bad;
 		data->lineno++;
@@ -3329,6 +3343,17 @@ static int checkdiff_consume(void *priv, char *line, unsigned long len)
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
2.52.0-rc1-455-g30608eb744

