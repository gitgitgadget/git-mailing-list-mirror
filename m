Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B0379975
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770506; cv=none; b=GrVtIfqn19Tc5QagSlFmo+MG7mJ6DsmDrQLTQwgavXV3/BfZqypIb5OP0QOEgb/wjHHFdOZcgDPcSJSVFxdC1It5IFPjahlXM8CRv7c8VW0mM4uiHuzDomy9UUwPqN2qXl5YtlXSXKkiUu8/fLjULAo0ZfGEyVDC+aUClTriOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770506; c=relaxed/simple;
	bh=YUSp6CBckBpcHakDy6SoPH1xOazvPHpFy6F6zABJKi8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7464ZCZg7W6hiFXb6cBxyNddjTnk8HYExpTUl5NX4eKsoJHv9UevVmlWNRCAwoyfunmT4Km/I4vYtIy9MMXcEKMe0ChpYmlxXn83uCVvj31qXvZSMoedMSChv6GN1QthckdwaLnXN9sbr83IrHswY2k4JcY0e1dxOuvcS0k/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AGJXXHBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FDw1FcLs; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AGJXXHBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FDw1FcLs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E6007A01E9;
	Tue, 17 Mar 2026 14:01:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 14:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1773770499; x=1773856899; bh=mG3tb6U4wLDhFSGT4CCGgD/BuGd9cfwf
	Gs/QXcGyWno=; b=AGJXXHBM51wtSop3pyREBGmf/igJDR0VWFfEjx/+Aw9shFOu
	9ZeDQNtSfEFfxl/0cSmh2SObU5jOB8bWTqjZWNNQS3VZqDJoaAmPZ7d6PbEm8ouJ
	yguuAvzAtXFid8lLd6HSEQF+MJmEroCWwAihwvzJidlnZk2O/3OltrV0rjdMBA+a
	z6DFNm1y06JA5r2nZ/rgGF+TL8dUvNt1ZKJPlZVpywaKvrTfUxOs7o5V4neqeERg
	O3y246fIljmLewlV2bTDh+wCKZTyy35Q6XNB0Xk9dHKTuhpt1Sz3/XBtZlFfS+xS
	sNIY3GpZ1JFuKkl8uqaBQOnpTINrE/pF9BC3Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773770499; x=
	1773856899; bh=mG3tb6U4wLDhFSGT4CCGgD/BuGd9cfwfGs/QXcGyWno=; b=F
	Dw1FcLsM92QTnmpsRYu97K/eFmbOb42jThv9pVY3QF4avb4e642t7Z4QuPfi3frC
	8em7bwVzYAvEPJA45reVxe5qef89TdLC8uoj1ZZUoH5ekwC+Ax36gsuQdglz9bqE
	xJoFzLge471vvTqd3QwXMsvPYOVuCOLLHQ6Epo3rtOc8m5IFUYeoBQaplfslbOZp
	ta0hVX9/2i1sZ8/ggFhwOn9+6gemkCeeJxZuDc+XFTGRAjeZO+7qfZmf1yV2FGOc
	c0c+brrRD909B16ceyJZyqbY/k4pWDrQg5nVoMHM6fXK8t5kN63mA9ySB8/IlIhT
	ajeWLnWyhrUGonalbFBrw==
X-ME-Sender: <xms:A5e5adVCUqOLCxhUhqgF6v9SG6U369kMMVjTejEXZLroRHP1BZnYHA>
    <xme:A5e5aTlyAZ1pv4vu0GIxmoU85MkICUGkQVTmg0_A3cndMfrdVn0JL8LwrGafLdp8d
    _goflD16aURqCdcCjRnzND4uLloQiBYcSDQjyohq3HXaq7S7Q-wUg>
X-ME-Received: <xmr:A5e5aXDOERX36RkzDYsfwZhMixNdY9iUsow2mthKgbBSofLo9lK77jZ0y0YfTCzgTDoazZyjWmSjGjhDzbekYbwQG54G3sc-oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:A5e5abfOJ48g_DpM72Jhpq7yKUR6HxAaK2ZmbABBT6ndQZUd70262g>
    <xmx:A5e5aaLrJeSESrPwZwxHE4KhjNITvHRnlNKh9p2rMKdi1BwwWXAFlA>
    <xmx:A5e5aWfLyIjSIzlGujfAaT5Sy9QsfYS2lCBuiYQprjb4JGGpYOLhmg>
    <xmx:A5e5aZ3XxVTO1gwHX1ppyvRl_-VADbXXoiYGP4mLiulqTLb8g3IUIg>
    <xmx:A5e5aYtfMlE8xq_oxsRmnzBdymPUnfnbj3tkQ2j2uS0jxIccbci1Q3lc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 14:01:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] apply: fix new-style empty context line triggering
 incomplete-line check
Date: Tue, 17 Mar 2026 11:01:38 -0700
Message-ID: <xmqqldfql4hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A new-style unified context diff represents an empty context line
with an empty line (instead of a line with a single SP on it).  The
code to check whitespace errors in an incoming patch is designed to
omit the first byte of a line (typically SP, "-", or "+") and pass the
remainder of the line to the whitespace checker.

Usually we do not pass a context line to the whitespace error checker,
but when we are correcting errors, we do.  This "remove the first
byte and send the remainder" strategy of checking a line ended up
sending a zero-length string to the whitespace checker when seeing a
new-style empty context line, which caused the whitespace checker to
say "ah, you do not even have a newline at the end!", leading to an
"incomplete line" in the middle of the patch!

Fix this by pretending that we got a traditional empty context line
when we drive the whitespace checker.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c                  | 12 ++++++++++--
 t/t4124-apply-ws-rule.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index f01204d15b..e88e5c77e3 100644
--- a/apply.c
+++ b/apply.c
@@ -1796,8 +1796,16 @@ static int parse_fragment(struct apply_state *state,
 			trailing++;
 			check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
-			    state->ws_error_action == correct_ws_error)
-				check_whitespace(state, line, len, patch->ws_rule);
+			    state->ws_error_action == correct_ws_error) {
+				const char *test_line = line;
+				int test_len = len;
+				if (*line == '\n') {
+					test_line = " \n";
+					test_len = 2;
+				}
+				check_whitespace(state, test_line, test_len,
+						 patch->ws_rule);
+			}
 			break;
 		case '-':
 			if (!state->apply_in_reverse)
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 29ea7d4268..8573e12f46 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -561,6 +561,22 @@ test_expect_success 'check incomplete lines (setup)' '
 	git config core.whitespace incomplete-line
 '
 
+test_expect_success 'no incomplete context line (not an error)' '
+	test_when_finished "rm -f sample*-i patch patch-new target" &&
+	(test_write_lines 1 2 3 "" 4 5 ) >sample-i &&
+	(test_write_lines 1 2 3 "" 0 5 ) >sample2-i &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample2-i >target &&
+	git diff-files -p target >patch &&
+	sed -e "s/^ $//" <patch >patch-new &&
+
+	cat sample-i >target &&
+	git apply --whitespace=fix <patch-new 2>error &&
+	test_cmp sample2-i target &&
+	test_must_be_empty error
+'
+
 test_expect_success 'incomplete context line (not an error)' '
 	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
 	(test_write_lines 1 2 3 0 5 && printf 6) >sample2-i &&
-- 
2.53.0-769-g8689fa97fd

