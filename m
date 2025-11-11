Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD80DDC5
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819502; cv=none; b=IJsx6zcFCpSv0lfEEwdWthBsGIhPFc2AYMGcq4Mijxl+o2fI7s6QSNL7VHWDZ9IBPiOm11c2aHJu63LkoWZ+EePG9/JwVkUmefUQ8NmN4uEuVX7DDpXhVpZKBnZngJer/vvH8cEQqJdNGqOXMvW5zDLA6955ylEAPH+F+d9K7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819502; c=relaxed/simple;
	bh=zjX9sYWYuapQJHbTBld+1Nec/a9chcwjpnhyYqpYm2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsiWe3JdO6lyMa0aY4zOGYdKsAytzuJUNExLgHhUnsQLfUZOv3Q4kx6N/ixOeO114psdh97f8WGEYEnf8JqVeupBm4/Ucx9IWqQ3iRuM8jMQm3DLbxtiLNjmK6T0p/RZP7FN5LEg6bJtTjOFbfZSYf4xzATeNs7FosNv3EGK5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VgH4aSvR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKSyJQfW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VgH4aSvR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKSyJQfW"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 736161D00151;
	Mon, 10 Nov 2025 19:04:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 10 Nov 2025 19:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819499; x=
	1762905899; bh=HSGK+DzPI4AlWZrsxiRnjcsGcs57xFDnmYdwewFXrwU=; b=V
	gH4aSvRtSwEt59FYU+5d3kXFCmKqD2+ol112bnldo0c54FEQetIFM3Kmjy12EseM
	CynfyRT5Ox+AnWOZfbO5vR2dn8l7W9gSWjg/sTOQbHKF9Q2sPZGeVBWfwN565izf
	yj4+1B3EaKVvgq5StJ7D9hcA5p/Jp+nyms2+E5dtGeIDB+doen3X1SY8qih8LYEK
	3thb0/plc7zBNTB4OIZ5Rh5F4Jdk2G4sKK5CYsCZJqsendnp9n+K52ffUXWA8AHw
	iFasyMSQHKq/0QVGLLsbwC1MZ9lR8twkIC23XWvn2O09cjE+rVEbGsRdv7qkJDy5
	4E3bUoaM9TVmfG7AYd7Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819499; x=1762905899; bh=HSGK+DzPI4AlWZrsxiRnjcsGcs57
	xFDnmYdwewFXrwU=; b=HKSyJQfWILYqpW6jYK0Sc5VPu2QbQanflX/fGGityrbA
	4tMRO8wgnIZhG4tVoXak29LH+txJA1FGW/Qv900JIF+PTS7fesDb0SIKjRVhediP
	AFqAIFf8NVjyYePVGnVeNymNJtAoKudvN+AvlRUayK6JqmPphFyuuOCXDqvqzPOW
	slvHPOtY3e8UbTlH7uBgDmX4wFwMc2Wel62MSFY084JjHj06mH4WWJIQTVcNgjEN
	Tmd5a4cf5lPoj48LCgTAkjFo4nmet3J4ULiCWdjR6yKsEZLIZBhi6VZjOpOG5U6A
	amq/jf/vcXka89X+3PJQiSvQDbAwu5ruT6xLHHPdOg==
X-ME-Sender: <xms:q30Sadqgh4GE6a0iAPc_kr-HSziWaKdwkSMwFFPc-fijbBWOy1bv_A>
    <xme:q30SaVr4zi7YbLN4jmYznw3NYEeE6nLYpYO0tUXbim0TPlvxLlEZHjBG7d9LJ4eGQ
    -mf2M4LzJo-6b-QPN-LO18I4uOuvQw1ADgK73jNUtaQzxwyv31Z>
X-ME-Received: <xmr:q30SaX2QgRReF_EkHEwa3ArzcrKKdu3SFqNBckCl4rPxGC9Jxv2SFue4Fk6ONCbm1cKtwtD3-bqcLRB2-sasnhKVKgFY_5wXFDFZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:q30SaUAcEeQThJqZ9cPWPa4txKZM2BKWQObz-yo-WMwy8EQ7vvHjag>
    <xmx:q30SafcEce8jgQfEGwX1Ph_xNVltYdGMEBEGD5Xz3ym9hUttxYXF8Q>
    <xmx:q30SaZjy4ODSDrfvmQPUVyHiPM3CwkIA_mtXz5P7vd4mRWk64XYQiw>
    <xmx:q30SaXqNcCkK8PQsiZ5yJGKWx7VDNepHF5obazEcNQ5G9ww-NTynJg>
    <xmx:q30SaRAkEHJ-El4C2qJAgV7nzHM0cNZ7Ki_BCXXhyPq7s8mZdN4YT9UM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:04:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 03/12] diff: correct suppress_blank_empty hack
Date: Mon, 10 Nov 2025 16:04:42 -0800
Message-ID: <20251111000451.2243195-4-gitster@pobox.com>
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

The suppress-blank-empty feature abused the CONTEXT_INCOMPLETE
symbol that was meant to be used only for "\ No newline at the end
of file" code path.

The intent of the feature was to turn a context line we receive from
xdiff machinery (which always uses ' ' for context lines, even an
empty one) and spit it out as a truly empty line.

Perform such a conversion very locally at where a line from xdiff
that begins with ' ' is handled for output; there are many checks
before the control reaches such place that checks the first letter
of the diff output line to see if it is a context line, and having
to check for '\n' and treat it as a special case is error prone.

In order to catch similar hacks in the future, make sure the code
path that is meant for "\ No newline" case checks the first byte is
indeed a backslash.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 9a24a0791c..b9ef8550cc 100644
--- a/diff.c
+++ b/diff.c
@@ -1321,6 +1321,11 @@ static void emit_line_ws_markup(struct diff_options *o,
 	const char *ws = NULL;
 	int sign = o->output_indicators[sign_index];
 
+	if (diff_suppress_blank_empty &&
+	    sign_index == OUTPUT_INDICATOR_CONTEXT &&
+	    len == 1 && line[0] == '\n')
+		sign = 0;
+
 	if (o->ws_error_highlight & ws_rule) {
 		ws = diff_get_color_opt(o, DIFF_WHITESPACE);
 		if (!*ws)
@@ -1498,15 +1503,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	case DIFF_SYMBOL_WORDS:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		/*
-		 * Skip the prefix character, if any.  With
-		 * diff_suppress_blank_empty, there may be
-		 * none.
-		 */
-		if (line[0] != '\n') {
-			line++;
-			len--;
-		}
+
+		/* Skip the prefix character */
+		line++; len--;
 		emit_line(o, context, reset, line, len);
 		break;
 	case DIFF_SYMBOL_FILEPAIR_PLUS:
@@ -2375,12 +2374,6 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
-	if (diff_suppress_blank_empty
-	    && len == 2 && line[0] == ' ' && line[1] == '\n') {
-		line[0] = '\n';
-		len = 1;
-	}
-
 	if (line[0] == '@') {
 		if (ecbdata->diff_words)
 			diff_words_flush(ecbdata);
@@ -2431,12 +2424,14 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->lno_in_preimage++;
 		emit_context_line(ecbdata, line + 1, len - 1);
 		break;
-	default:
+	case '\\':
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
 		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 				 line, len, 0);
 		break;
+	default:
+		BUG("fn_out_consume: unknown line '%s'", line);
 	}
 	return 0;
 }
-- 
2.52.0-rc1-455-g30608eb744

