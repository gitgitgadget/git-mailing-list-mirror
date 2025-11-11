Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C97EEBA
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819514; cv=none; b=N/3h6ig6l8brs2vL8Pe6aeVK0VK5IQ389M4DIUU8PwSIoeJuxCXG/fdr/8u0rOnz4ZYJ3QrsyN3ccYXP1Fbiwin+agOTn3Cwi4T9PQIcPdZLpbsH1C3eYvVGU9Qdxpk58gPnIdcki62i7q2JJwIY4VtUpJJ9y0Wcca2ZSPQy4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819514; c=relaxed/simple;
	bh=xVuErZxsTVxaj9qxQmrAA8yJEc9b6qVO8Iaj+qsGhus=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPwc8oW46r4IRLnI8UczOKaSwZ1ByNJjVRxhxnZCaSoc3sBKp4L0N3PIupMPHTZ0wqRdNSZ2ZRIrqBAy41enHjpI9V6NbBIG9fpoBdOeCaBAZct1NcZw8Rvtx75BUE0SjSSBl/CGAu4AWKiQchJERWg8YRnAD0eIfO5nf/RkJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bTiw+mVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZPOWPMU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bTiw+mVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZPOWPMU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C5761D0012F;
	Mon, 10 Nov 2025 19:05:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 19:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819511; x=
	1762905911; bh=7r8KcoXJtVZCe8ABSxlGngDoT6FpVZc5JZ5ATJ0XW7Q=; b=b
	Tiw+mVALWDSRdNH/z/tnd5VdFdvzC+2X7HAlt5nnRN9ymmpsGjGoZ3Jhq++vtKql
	/WUdFaHIDuj92Qlaja8gbjO+SEkVpjIRvTLfY76M+cLIMpXT1wYGkuX2ChY24cs9
	AyvNI3+1cICUTpDg3zuI/I05k2OqFISffGR901b05lToRAs7gOXob7Jr2yDgoQ9u
	dnLy2deK3x7TLyvYJgA8rtBcvJvVlfPEbV1jCCE76QiqAT8kh0BLv9MWO4wQZKeJ
	Q2iaFeg5kWpVqfTAVMGgY2Ldv16qmWRyLaDNhrl3H1yIoQQP5B4WyOdLrrslwIRo
	z6JPrRsCgFTSZ6nRVIi6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819511; x=1762905911; bh=7r8KcoXJtVZCe8ABSxlGngDoT6Fp
	VZc5JZ5ATJ0XW7Q=; b=MZPOWPMUyeC4KmIQyJYjjMd80Nd/1AaHOi9Z7eAlqROH
	cpThxtUAXB3MAD2psIDO+njDkkffofhOFKD0rpGATGOFYi32H2mcF6nFFdJhhUGU
	Z0fj2aaZxKw98eFRa8xdLruxrroFMJX35XFXxo7SYkQ2oBLxfM3BIKH7BQr8dpfd
	G0xvO6OpJrfrT9UkB9xj5KUHyacXRJVjsZZGpgnbuF+AM5IJgnM26+a+S9/fP9nt
	ETq0VkYSXw3O0FLHRmcthZflyokZZ97QCtyqyV8FFSXuhngU1kd8XWifJ6OvYtvw
	qxmjbkCo5xHVHmWaQia2c/LR7JYbfBYgmCi1UtuNJQ==
X-ME-Sender: <xms:t30SaWnPtN5haJr8rSrr3jbLjVsDOu4SalCTWpyrGOPtBNPDBAZV3g>
    <xme:t30SaT1FtGAiIArmuH3HSCcP5W_hyJB5E3krsqXgwN57ATH_xim0rPVenhPXReuKt
    1E9TuySIanqlppayJVCNH1n3SPu21TIFhhjl6zvBFF7MpOjvM7Z0g>
X-ME-Received: <xmr:t30SaSQ_exFe3aBFfdQRvAu9Ki7m5m0tmjEUOoAJMxVmvTFCZGjeW4Tl8nRyU7ktxi_A5OHHFOIOCot0Vg0oiwmsl-pqJ7odUlQT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:t30SaVuDPsF4cYIWETQpm6fzn888Xu6-AP4XxhLO9mVZM0Cw_F9hUA>
    <xmx:t30SaXYtTF2IjP_FwGg8Ex7G-tRq0C8P2GyatVSUfCTugN_qN2YkGQ>
    <xmx:t30SaatKpwTKtVWoETOtFDWkTvSldHRHvGjgMuvxeIReRSmWVyuWFQ>
    <xmx:t30SaZEfiUM0tmusYLwqPtEFXEUqKylmk5qCyvsjnRiUxe-DJoUPGw>
    <xmx:t30SaR_G2t1Koo1uwoK07LwgWNqhIeEZ2h-aAwgcohY9PIiAe-3lLOPX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 10/12] apply: check and fix incomplete lines
Date: Mon, 10 Nov 2025 16:04:49 -0800
Message-ID: <20251111000451.2243195-11-gitster@pobox.com>
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
2.52.0-rc1-455-g30608eb744

