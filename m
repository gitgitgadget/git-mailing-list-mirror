Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488E2E36F8
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378274; cv=none; b=M/fwM/yEulXYH7U5poVnakl6fhONgCvj5Ft2d7pl5KUPfj+1ksV45ooqO3I6ky02vMmJSk4Oq26mCg574Te4n4Ofuk2Jz9i3AYV9Zm6UBXwW9wpRlKnpBK0Ste62A9C9PI9oyJsN370cmeg1LZnTnXMMsmpWvVXxkGjPGA0vB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378274; c=relaxed/simple;
	bh=BXtq0uPSbgdJDVotFYOVIvJ8kEi2VikdzF2HE7upZ9Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSQXECFb42QHzof7OOkq6F00KfsHfxoNU9pxqTauBMpPlaYLymh0cZy+oXC9Intx/fW6LukfJ58SsXFIJ/x1j4gTFOaM1nurpMbjggi51biwSaoWyoIgUOlY3qbjK9FZkwZbIVtimSTyYc1ClZY7bEzDTLzHSa15bZAM+3VfDx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kfn3dHxX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJ8Dhzs0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kfn3dHxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJ8Dhzs0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B82BB7A0027;
	Wed,  5 Nov 2025 16:31:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 05 Nov 2025 16:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378271; x=
	1762464671; bh=AyMQSC7wos9EazIsQhqw3zVyG6d52Hq1ZsXHaUkY5gU=; b=k
	fn3dHxXP14Gzk8N3kgr5J5nH4zQnxR7CNBzXthLT9rUDTBAjkMvtpY4CPuzNZ8ZV
	xxrpjFN4hmNf5VMeVX2O+sabiEvNhPlOI0Z2zjqLJMYMhtd1rg/NzVpTAXzUu84q
	jPFnXt/2eSUQ0ZawI0r26uGZPeonUiFiWNlvQATt+6Rb0sbkEsVZyCFN0O6StN/M
	ItZx3MPI7XjCRQOjUrADuQbNeweFtlSi+vzhN+S0HE0uTk+rYbb6YZcn6PRO4wOq
	iLIFuRzWADCtp/sY/6fJm9dTBCCcGGB+EcbMOhX2YjHjgeOdhXg+ZI0V6GDdMgJe
	Jj9NCzannmsvKBVzx+YlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378271; x=1762464671; bh=AyMQSC7wos9EazIsQhqw3zVyG6d5
	2Hq1ZsXHaUkY5gU=; b=LJ8Dhzs0pLiczI8Ysiz5MN2WMPEvZTfSrb17EX5nA2Zw
	tRjhL18ReGfAo5klO4YWS+O4IfH0LeA4h2b5ytr/JSuVahKjyvGuT01GrJd0xm3a
	NLHh90TLL+yzJmRUj4DLqZbgF4+nKwlEeeeb1pW8Nq7MPdgkRloNtIc6b1HxQ+EJ
	Z+WFk0HhOuGmpJANPiRe5Hg4wFNnoT5Nel+5vQUVhXJgYJ9lUFEBv8S68azhejYr
	z1BTxcN0SvIMPlDZK+LOffFzwwEBTHdx8hPWrkUuBNmeK+3aIt+c9/3iXhs+wJVZ
	bES85sz0ksxE7REm3+qrBmuuckRlvsNkUDLVZtWizg==
X-ME-Sender: <xms:H8ILaZe2vIVILTQBke3QakDDNNC62XExLmgGI-blzy7puO3qi8U_Yw>
    <xme:H8ILadMHLZvp4D_L_MFm1kRnmo-C9683QL7Wk-pTs10Ap_lVsCanQf5C0Pm6M9AUG
    40wS1iuehwxSZivr4hwyfOmdSuW4yq7wfQiidyDr0mY_pxCcq6jhg>
X-ME-Received: <xmr:H8ILaQLdAOyuwjx2n2VgReSQOEBroYFAqZE3gtasIYvzj5rzBtyac_R_7IQHpD9KJlR46LeGe7YUiOFzabhMu3YY0M5nNsOcUDVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:H8ILaeEuoOTPrDvyo577Q3GEfj7mnK8cTkrTRe64E6FNpsW7r708jA>
    <xmx:H8ILaYSZhIF0N1mg4jy3eU1WYhwF9bvyrpIDbw4MWB_IAPa3bKfRZQ>
    <xmx:H8ILaaHgqeJowpoVKlbHu58D-5hvDOIaHhIncTUuMiigl83TXMDJOQ>
    <xmx:H8ILaU_9JbD1yUymW_wP4tEqNICHzfu1GdgR8_h60YWmwnGBr-ZGUQ>
    <xmx:H8ILaU3ce_iF4Ua7lKMAZM77_8IVxBHup83RivylPS8He_iZZeFc9Rs0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 10/12] apply: check and fix incomplete lines
Date: Wed,  5 Nov 2025 13:30:50 -0800
Message-ID: <20251105213052.1499224-11-gitster@pobox.com>
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

The final line of a file that lacks the terminating newline at its
end is called an incomplete line.  In general they are frowned upon
for many reasons (imagine concatenating two files with "cat A B" and
what happens when A ends in an incomplete line, for example), and
text-oriented tools often mishandle such a line.

Implement checks in "git apply" for incomplete lines, which is off
by default for backward compatibility's sake, so that "git apply
--whitespace={fix,warn,error}" can notice, warn against, and fix
them.

As one of the new test shows, if you modify contents on an
incomplete line in the original and leave the resulting line
incomplete, it is still considered a whitespace error, the reasoning
being that "you'd better fix it while at it if you are making a
change on an incomplete line anyway", which may controversial.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c                  |  13 ++-
 t/t4124-apply-ws-rule.sh | 187 +++++++++++++++++++++++++++++++++++++++
 ws.c                     |  14 +++
 3 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 2b0f8bdab5..c9fb45247d 100644
--- a/apply.c
+++ b/apply.c
@@ -1640,6 +1640,14 @@ static void record_ws_error(struct apply_state *state,
 	    state->squelch_whitespace_errors < state->whitespace_error)
 		return;
 
+	/*
+	 * line[len] for an incomplete line points at the "\n" at the end
+	 * of patch input line, so "%.*s" would drop the last letter on line;
+	 * compensate for it.
+	 */
+	if (result & WS_INCOMPLETE_LINE)
+		len++;
+
 	err = whitespace_error_string(result);
 	if (state->apply_verbosity > verbosity_silent)
 		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
@@ -1794,7 +1802,10 @@ static int parse_fragment(struct apply_state *state,
 		}
 
 		/* eat the "\\ No newline..." as well, if exists */
-		len += skip_len;
+		if (skip_len) {
+			len += skip_len;
+			state->linenr++;
+		}
 	}
 	if (oldlines || newlines)
 		return -1;
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 485c7d2d12..115a0f8579 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -556,4 +556,191 @@ test_expect_success 'whitespace check skipped for excluded paths' '
 	git apply --include=used --stat --whitespace=error <patch
 '
 
+test_expect_success 'check incomplete lines (setup)' '
+	rm -f .gitattributes &&
+	git config core.whitespace incomplete-line
+'
+
+test_expect_success 'incomplete context line (not an error)' '
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	(test_write_lines 1 2 3 0 5 && printf 6) >sample2-i &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample2-i >target &&
+	git diff-files -p target >patch &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error <patch &&
+	test_cmp sample2-i target &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error --check <patch 2>error &&
+	test_cmp sample-i target &&
+	test_must_be_empty error &&
+
+	cat sample2-i >target &&
+	git apply --whitespace=error -R <patch &&
+	test_cmp sample-i target &&
+
+	cat sample2-i >target &&
+	git apply -R --whitespace=error --check <patch 2>error &&
+	test_cmp sample2-i target &&
+	test_must_be_empty error
+'
+
+test_expect_success 'last line made incomplete (error)' '
+	test_write_lines 1 2 3 4 5 6 >sample &&
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	cat sample >target &&
+	git add target &&
+	cat sample-i >target &&
+	git diff-files -p target >patch &&
+
+	cat sample >target &&
+	test_must_fail git apply --whitespace=error <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample >target &&
+	test_must_fail git apply --whitespace=error --check <patch 2>actual &&
+	test_cmp sample target &&
+	cat >expect <<-\EOF &&
+	<stdin>:10: no newline at the end of file.
+	6
+	error: 1 line adds whitespace errors.
+	EOF
+	test_cmp expect actual &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error -R <patch &&
+	test_cmp sample target &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error --check -R <patch 2>error &&
+	test_cmp sample-i target &&
+	test_must_be_empty error &&
+
+	cat sample >target &&
+	git apply --whitespace=fix <patch &&
+	test_cmp sample target
+'
+
+test_expect_success 'incomplete line removed at the end (not an error)' '
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	test_write_lines 1 2 3 4 5 6 >sample &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample >target &&
+	git diff-files -p target >patch &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error <patch &&
+	test_cmp sample target &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error --check <patch 2>error &&
+	test_cmp sample-i target &&
+	test_must_be_empty error &&
+
+	cat sample >target &&
+	test_must_fail git apply --whitespace=error -R <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample >target &&
+	test_must_fail git apply --whitespace=error --check -R <patch 2>actual &&
+	test_cmp sample target &&
+	cat >expect <<-\EOF &&
+	<stdin>:9: no newline at the end of file.
+	6
+	error: 1 line adds whitespace errors.
+	EOF
+	test_cmp expect actual &&
+
+	cat sample >target &&
+	git apply --whitespace=fix -R <patch &&
+	test_cmp sample target
+'
+
+test_expect_success 'incomplete line corrected at the end (not an error)' '
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	test_write_lines 1 2 3 4 5 7 >sample3 &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample3 >target &&
+	git diff-files -p target >patch &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error <patch &&
+	test_cmp sample3 target &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error --check <patch 2>error &&
+	test_cmp sample-i target &&
+	test_must_be_empty error &&
+
+	cat sample3 >target &&
+	test_must_fail git apply --whitespace=error -R <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample3 >target &&
+	test_must_fail git apply --whitespace=error -R --check <patch 2>actual &&
+	test_cmp sample3 target &&
+	cat >expect <<-\EOF &&
+	<stdin>:9: no newline at the end of file.
+	6
+	error: 1 line adds whitespace errors.
+	EOF
+	test_cmp expect actual &&
+
+	cat sample3 >target &&
+	git apply --whitespace=fix -R <patch &&
+	test_cmp sample target
+'
+
+test_expect_success 'incomplete line modified at the end (error)' '
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	(test_write_lines 1 2 3 4 5 && printf 7) >sample3-i &&
+	test_write_lines 1 2 3 4 5 6 >sample &&
+	test_write_lines 1 2 3 4 5 7 >sample3 &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample3-i >target &&
+	git diff-files -p target >patch &&
+
+	cat sample-i >target &&
+	test_must_fail git apply --whitespace=error <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample-i >target &&
+	test_must_fail git apply --whitespace=error --check <patch 2>actual &&
+	test_cmp sample-i target &&
+	cat >expect <<-\EOF &&
+	<stdin>:11: no newline at the end of file.
+	7
+	error: 1 line adds whitespace errors.
+	EOF
+	test_cmp expect actual &&
+
+	cat sample3-i >target &&
+	test_must_fail git apply --whitespace=error -R <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample3-i >target &&
+	test_must_fail git apply --whitespace=error --check -R <patch 2>actual &&
+	test_cmp sample3-i target &&
+	cat >expect <<-\EOF &&
+	<stdin>:9: no newline at the end of file.
+	6
+	error: 1 line adds whitespace errors.
+	EOF
+	test_cmp expect actual &&
+
+	cat sample-i >target &&
+	git apply --whitespace=fix <patch &&
+	test_cmp sample3 target &&
+
+	cat sample3-i >target &&
+	git apply --whitespace=fix -R <patch &&
+	test_cmp sample target
+'
+
 test_done
diff --git a/ws.c b/ws.c
index 34a7b4fad2..6cc2466c0c 100644
--- a/ws.c
+++ b/ws.c
@@ -186,6 +186,9 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 	if (trailing_whitespace == -1)
 		trailing_whitespace = len;
 
+	if (!trailing_newline && (ws_rule & WS_INCOMPLETE_LINE))
+		result |= WS_INCOMPLETE_LINE;
+
 	/* Check indentation */
 	for (i = 0; i < trailing_whitespace; i++) {
 		if (line[i] == ' ')
@@ -297,6 +300,17 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 	int last_space_in_indent = -1;
 	int need_fix_leading_space = 0;
 
+	/*
+	 * Remembering that we need to add '\n' at the end
+	 * is sufficient to fix an incomplete line.
+	 */
+	if (ws_rule & WS_INCOMPLETE_LINE) {
+		if (0 < len && src[len - 1] != '\n') {
+			fixed = 1;
+			add_nl_to_tail = 1;
+		}
+	}
+
 	/*
 	 * Strip trailing whitespace
 	 */
-- 
2.52.0-rc0-105-gc08128fbb6

