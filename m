Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D9373BFE
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791097; cv=none; b=kE0xjxQ57RtXnDPp258VLvfL+Jht9Pkw7X0lOvgbs6Zl5ryCwmWJAZ/3Wun4mOyxh1N32325NJ/7WqdsZH3XwrvR1nHFJzwfIrCmI3eABu5NXBckcKw8kDpENeWFzb8tRZwZp66+dacEYRkZvyXkyrm4RSpQlmDJW9mMYom9xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791097; c=relaxed/simple;
	bh=XdyqWrwP6mhRLo5ERTPuniqCtuDHT69ewMrNSMltoqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4JFeq1Cr6N9+Jn26AnG9iGvNVeyLX85iaapMVMzBMwhHDVr01i2m7QfsSw7C1OvzP6VmCj+1j9cndCOITcnP1NvuJMRmsy6xmr3SsiqiEaxGQ0zWrTYrax4lhLE2YKaVGmLdXmHsyjTDfTKdg2N8c2bE6XVSAmFNEOVgJpEL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6/0ukFS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6/0ukFS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4d870d54so842515f8f.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 00:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791791095; x=1792395895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3H5zKVRyF3Ds5wmGCjGJbSVhOmqbcyabiYj8+iBZaY=;
        b=U6/0ukFSps2sIdT2J0p6JcWHICnRE4X8Kp+T9nYycAWAQt0/MRQhD/Y4hoQSA3oRky
         QKaoIj5m9GaGibAfTwwV4rL3l6MQdS1YpibAjzZyBLD6Jk6hlEhpZvbfkDy3P1A2wtwT
         1961KjOb2TqgdjVuVhpnaGpkqrXymVrZd5+OHe2W8SE3oChrMTLaIIMyVnng9Rm5BvyW
         s0X3KwXezOZsM+vjONcoCthUL8znCF0A9PyzT3fn3fYOQ7WnAfuBe0gsnxKQ9FiAIlLs
         I/0meq6zQEUZVgZfqxnLEMFLf0meozK/N5+hknpoGUT+KL7pWXyW2eR23KaLlHUFE7HL
         47fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791791095; x=1792395895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y3H5zKVRyF3Ds5wmGCjGJbSVhOmqbcyabiYj8+iBZaY=;
        b=BmflNnI11PevbxTPyiW+Vr1UFS1YGoeEi5pkHKC078qD1rRfIIuyO0bnimsKjOuviq
         TYd6l10WFlyxSCeidfiT+A6WeitomsIXIKBT0rajFP+7UlT0Z/awbpBkrYjFYxVRR+Rn
         +yquvWRXRSwuP3Ewpd7Z/m1KC8DNkjK0N7VtooEYjsKjJh7tEv3H/zXtnBk6gUYEOFdQ
         m8vJ2JJNZ/d1tyxjMuxBAQD47Sea/XJY3jY0dIbc1QwD8jcy7+0d3pAbyMt23AcJvRf7
         rbGPzllsdvWGcqk1SGj7WqJohqALXneeuhah/mi9NFRrGxGAiuS9HGNULOZ/ndRuxo5D
         /iMQ==
X-Gm-Message-State: AFq9FYL2Dqa4OvR7/inVwsRTVRWuVVQT2Hnlnm2f5d8MJHQFFvV7wMRh
	kkeXIeksF79Lo91RuMdVfXdy6Zg0OIJuFPs81vBiEvQShxvBruxxq0O4pEu7Zg==
X-Gm-Gg: AYBFou1vhLuxJp39LFdtZQ88PQM0QtN77I7ZsBoEp2jJUUDlHx/ZnaH7qXLtDzq2iN/
	lcxtuOSPHVWH5x3DcJ/20KfOz2U9Sd/r34Iek0lqky/mpR1Tqs+nh078+Wc7E1CmkzsRr8u9dNc
	k/aDLPeVp6vsuGC/QFv4qXopIVZrU9ZoAEopYxWNK0/g4tC+VXbHzRQTAVd4RuFJSLgVkcr+FTw
	tvOeC/jQoHZlX+4J2CrSBc+6HR/5VNYao0PWEB3hadLU18s2WqM1KmI9K+drIlCeqohK3oKxKaz
	8ATMcRNsTbvbw2KA+dzHNSDNeTuSs3ttbrYzgRGBL/LXzbl+MbBRkxj92ALniY5JspwOXRtRbrv
	W5bJUU9vxQHyHe1t6ybbOXdO9GD+VCvrZ0RKvWb26fyGoxqZQTNdSWKwI/6s1F8jIttC6mVYAc5
	bY8Sqs/Gy/w4frr4/a37g340ekTsRWHQ0RP5ZnG1Kyx0jSTdLY+TqqAc3D8wg84OF5isermz2Jx
	JLg5JCUMiojE22wNtpyOQTNOW8TWYA81Xoq7XD6J4oUeSETdKhBOV1dpNdwqym+cezEqEoLwgvO
	BofGip0o1AidLnjtXpG8tPq1PUgQrt8wC3kOAqmLJl4ldAaV1+zp9KsdpscwlvFMSoJj5XXvgIb
	QqrXv/LASLYBT9lX/2l8=
X-Received: by 2002:adf:e013:0:20b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48dba7b3fefmr10485708f8f.8.1791791094443;
        Mon, 12 Oct 2026 00:44:54 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db99b800asm17680723f8f.22.2026.10.12.00.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:44:53 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 2/4] parse-options: extract lookup_long_opt() from parse_long_opt()
Date: Mon, 12 Oct 2026 09:44:11 +0200
Message-ID: <20261012074413.337183-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092
In-Reply-To: <20261012074413.337183-1-christian.couder@gmail.com>
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, an early scan of the command line will need to
look up long options the same way parse_options() does, including
unambiguous abbreviations and negated forms, but without any side
effect: it must neither set option values nor call die() or error().

parse_long_opt() can't be used for that, as it does both the look up
and the actions that follow it: it calls get_value() on the option it
finds, die()s when abbreviations are disallowed, and error()s on an
ambiguous abbreviation.

Let's extract a new lookup_long_opt() helper from parse_long_opt() to
perform only the look up part, and let parse_long_opt() act on what
lookup_long_opt() returns.

There is no behavior change intended. In particular an exact match is
still preferred to any abbreviation, abbreviations are still rejected
when disallowed only if there is no exact match, and the ambiguity
error message is unchanged.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c | 105 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 81 insertions(+), 24 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d7cbb5a343..a98b958423 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -516,16 +516,46 @@ static void register_abbrev(struct parse_opt_ctx_t *p,
 	abbrev->flags = flags;
 }
 
-static enum parse_opt_result parse_long_opt(
-	struct parse_opt_ctx_t *p, const char *arg,
-	const struct option *options)
+enum long_opt_lookup {
+	LONG_OPT_EXACT,      /* exact match found */
+	LONG_OPT_ABBREV,     /* unambiguous abbreviation found */
+	LONG_OPT_AMBIGUOUS,  /* more than one candidate abbreviation */
+	LONG_OPT_UNKNOWN,    /* nothing matches */
+};
+
+/*
+ * Look up the long option named by `arg` (without its leading "--")
+ * without acting on it. (Neither prints nor dies.)
+ *
+ * Return value:
+ * - On LONG_OPT_EXACT, `found` is the exact matching option and its flags
+ *   (including OPT_UNSET for a negated form), and `stuck` points after
+ *   the '=' or is NULL.
+ * - On LONG_OPT_ABBREV, `found` is the unambiguous abbreviation, same as
+ *   above for its flags and `stuck`.
+ * - On LONG_OPT_AMBIGUOUS, `found` and `other` are two candidates of an
+ *   ambiguous abbreviation.
+ * - On LONG_OPT_UNKNOWN, nothing matches, no result.
+ *
+ * `other` is only meaningful for LONG_OPT_AMBIGUOUS.
+ */
+static enum long_opt_lookup lookup_long_opt(struct parse_opt_ctx_t *p,
+					    const char *arg,
+					    const struct option *options,
+					    struct parsed_option *found,
+					    struct parsed_option *other,
+					    const char **stuck)
 {
+	enum opt_parsed flags = OPT_LONG;
 	const char *arg_end = strchrnul(arg, '=');
 	const char *arg_start = arg;
-	enum opt_parsed flags = OPT_LONG;
 	int arg_starts_with_no_no = 0;
-	struct parsed_option abbrev = { .option = NULL, .flags = OPT_LONG };
-	struct parsed_option ambiguous = { .option = NULL, .flags = OPT_LONG };
+
+	found->option = NULL;
+	found->flags = OPT_LONG;
+	other->option = NULL;
+	other->flags = OPT_LONG;
+	*stuck = NULL;
 
 	if (skip_prefix(arg_start, "no-", &arg_start)) {
 		if (skip_prefix(arg_start, "no-", &arg_start))
@@ -554,43 +584,70 @@ static enum parse_opt_result parse_long_opt(
 
 		if (skip_prefix(arg_start, long_name, &rest)) {
 			if (*rest == '=')
-				p->opt = rest + 1;
+				*stuck = rest + 1;
 			else if (*rest)
 				continue;
-			return get_value(p, options, flags ^ opt_flags);
+			found->option = options;
+			found->flags = flags ^ opt_flags;
+			return LONG_OPT_EXACT;
 		}
 
 		/* abbreviated? */
 		if (!strncmp(long_name, arg_start, arg_end - arg_start))
 			register_abbrev(p, options, flags ^ opt_flags,
-					&abbrev, &ambiguous);
+					found, other);
 
 		/* negated and abbreviated very much? */
 		if (allow_unset && starts_with("no-", arg))
 			register_abbrev(p, options, OPT_UNSET ^ opt_flags,
-					&abbrev, &ambiguous);
+					found, other);
 	}
 
-	if (disallow_abbreviated_options && (ambiguous.option || abbrev.option))
+	if (other->option)
+		return LONG_OPT_AMBIGUOUS;
+
+	if (found->option) {
+		if (*arg_end)
+			*stuck = arg_end + 1;
+		return LONG_OPT_ABBREV;
+	}
+
+	return LONG_OPT_UNKNOWN;
+}
+
+static enum parse_opt_result parse_long_opt(struct parse_opt_ctx_t *p,
+					    const char *arg,
+					    const struct option *options)
+{
+	struct parsed_option found;
+	struct parsed_option other;
+	const char *stuck;
+	enum long_opt_lookup result = lookup_long_opt(p, arg, options,
+						      &found, &other, &stuck);
+
+	if (result == LONG_OPT_UNKNOWN)
+		return PARSE_OPT_UNKNOWN;
+
+	if (disallow_abbreviated_options &&
+	    (result == LONG_OPT_ABBREV || result == LONG_OPT_AMBIGUOUS)) {
+		const char *arg_end = strchrnul(arg, '=');
 		die("disallowed abbreviated or ambiguous option '%.*s'",
 		    (int)(arg_end - arg), arg);
+	}
 
-	if (ambiguous.option) {
-		error(_("ambiguous option: %s "
-			"(could be --%s%s or --%s%s)"),
-			arg,
-			(ambiguous.flags & OPT_UNSET) ?  "no-" : "",
-			ambiguous.option->long_name,
-			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
-			abbrev.option->long_name);
+	if (result == LONG_OPT_AMBIGUOUS) {
+		error(_("ambiguous option: %s (could be --%s%s or --%s%s)"), arg,
+		      (other.flags & OPT_UNSET) ? "no-" : "", other.option->long_name,
+		      (found.flags & OPT_UNSET) ? "no-" : "", found.option->long_name);
 		return PARSE_OPT_HELP_ERROR;
 	}
-	if (abbrev.option) {
-		if (*arg_end)
-			p->opt = arg_end + 1;
-		return get_value(p, abbrev.option, abbrev.flags);
+
+	if (result == LONG_OPT_ABBREV || result == LONG_OPT_EXACT) {
+		p->opt = stuck;
+		return get_value(p, found.option, found.flags);
 	}
-	return PARSE_OPT_UNKNOWN;
+
+	BUG("unknown enum long_opt_lookup value '%d'", result);
 }
 
 static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
-- 
2.56.0.116.g6de20f6092

