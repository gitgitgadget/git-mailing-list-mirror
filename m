Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C42F5316
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985000; cv=none; b=I7zvSPzm/2/bxg/ZrbbR9lSY1N2SAfDGLA3jJ8IdyFpBmXGxw+GfZrnmimtJesdH95U7TVmH4Yh+vZyZX1UNizpkbs67YAMscJBfIvB6NV92l0FKB6lbH54ekkc+S5u9cwa61gtf4Dae2ZrHkgruY+8VStSdks2Wsp9HIHpuTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985000; c=relaxed/simple;
	bh=9j5ajat9hco8z2QMsddictvuzysoapUHKJdQJvLrLJs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVDVkuhMvGWK/xE8z6Fc85a62h+8y4CpwN7blpzJxaAQ/Arwv9pXbWLdqHqILrLwxYquLcNc4QAnhaKdaLxfyc/blCPj6w8xPA/ezlPRZwSAaaXFaJHUbtbxLXj/6TFTmfzUIWRewBLyHpP+5RpDdRam412suoqjlSSoIIsz82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=id4s4Q/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdKc9xVp; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="id4s4Q/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdKc9xVp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BE5A81D000F7;
	Wed, 12 Nov 2025 17:03:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 17:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984997; x=
	1763071397; bh=OJI4ksRHJWt0CbW9Ov/3pm/8VwxO+RgER+uv2G1LZkk=; b=i
	d4s4Q/u9QMQrMq7Dsf2LgWnSj28O55D8dnQ5i/PvrRSO9/WZq0SA03JAz7qPTEe7
	HgyEDIVn1VlA0UdDaL19bXFaMOyEa6eZfTzKleottHeiYtDTUJ5GjfX/h8MPtoAF
	SysWqf+DmUIik9W7qB8FVZx/TSsrKDve8Idg1EuUFjf33dxmkBObFZOBYj2EGfL6
	QtjLYZVSl5msVueRQB1aPoeuqDS84xhdEcS5Q5MgxNA4V328hsqB9PrNkPnfKrNn
	ZN0zc00lRSrJwuh9M3XqNcCab+c/t+LL0vsfzFxZe1pxcqoH0ZcJODLhUb91wntn
	pxV9iY2v0KLowlV6JkHbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984997; x=1763071397; bh=OJI4ksRHJWt0CbW9Ov/3pm/8VwxO
	+RgER+uv2G1LZkk=; b=GdKc9xVp88V3pnhFJtiQTyDEemtCy0mIQWUhejS114SV
	A+4uIf/AovDtuCuqhU2TQLnCIqR4VjOoMbCWw7ePoi9e9iTcZg8TwYgY9QEl79yT
	+VwAJUHBQvIM8R4ugNo8D4I5b9TwKCsAV0AJALOkK2Eh96RuyHRf0aJDA6lHZ6fM
	KxV0BOAj1pRGTjj6rhUFfqEGC4mcuwts+nvacKVAbcpdaajKYpPstIcA8lp+RwSa
	BVGBhBUtAJgL2Yc/snP82LEcjQD9fzGH8H2gFkb8/rQbxz/NTuPWDTIGbGd3/RK8
	I3U8sUiNMVPKIwmOSqOr5I3X2D2DYG1rLgS3gFKbMQ==
X-ME-Sender: <xms:JQQVaTE9OuxYo7x7ucxShClgwJaqa-13Ytb5s3BU58CkMNfSsBS0UA>
    <xme:JQQVaWWzhacvs02N7Gj2FrFBmCET6Atn3scxzlJSqQ7-LifnMXoQSDmPcyXKbL6Cm
    ZeNbvOQDh3b7WRwhXm5AIFKzsgHJOxKtnnyiN5YYWd-noeHslxWBgo>
X-ME-Received: <xmr:JQQVaSwWf57LrFPN1EFAvD4LrpZI5R7Gmtev-e8OhOfkg_CCsFMQ1Rqp8Vn4_kL3Kfu7yS--pJrHadGEQ2uJSuQiHjK-eLAMdbQu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepheenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:JQQVacNBcmoF8W8BLpSJWetEhQMC8Gjzwffl5c3QO9Xa8yKEzEM1BQ>
    <xmx:JQQVab6vRZ1Fe5pt_v9RKUpkssMoL3DhIJiZgDHvKjPwrDoTfQgsNQ>
    <xmx:JQQVaVNzUPfc39iZ5Giq23-aqIMZplL9eT229mOzqrGsyGLZgkOIEA>
    <xmx:JQQVaRlf9ro918aVv4igR0RQPXkPEDcugE0HzAzV-QrtamlrQcoTMA>
    <xmx:JQQVaee30ox7nb1ziKi3XR9VsyNbooHV0nQFHEh9jMtzQ1anKO8dE2OJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 10/12] apply: check and fix incomplete lines
Date: Wed, 12 Nov 2025 14:02:56 -0800
Message-ID: <20251112220258.1009253-11-gitster@pobox.com>
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
2.52.0-rc2-441-g030905368a

