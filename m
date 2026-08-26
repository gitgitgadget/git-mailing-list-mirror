Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528536DA04
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787120; cv=none; b=RTU9poo3VGu/Pklr//RyekUfrF9dVtBao8I8f6+IKL6FQC6Llj6tDze0EvAJFUpERdaf8agAqZZ2FUKijRyUOJfiE5yP39y3SqofNga1eU2I5yVWMsrdqgJLb0LSynsHP3oOIDQTIyA0Z36MLgrgShIj1lazk+r1QamZI6E/hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787120; c=relaxed/simple;
	bh=43t82vPhX7sgsJB7ap4kga/gFKMZ3fyUyg6Nup1sH74=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbeTJYhz0QlxpJIScg4uFFA8r3xX/xBVmEjuSEQhQkcfktXHP6lKb6LCV5MkNllYThS/45ZxZBhPl4voDoN0fUnSRilDNjsTeEqQm2NsswQm9h9FIcdrv5KUPWb2WvazXRWFqVVZZ4YIlk084dl9VzkC5zMNjHYv1y+bWrlmdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c2Yy31en; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cehkmf2X; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c2Yy31en";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cehkmf2X"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 023987A0076;
	Wed, 26 Aug 2026 19:31:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Aug 2026 19:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787787117; x=
	1787873517; bh=Do2mjnX4TG4TUFLaNFFFAwO6nFbpExQCHNDp55zEpnY=; b=c
	2Yy31enW6NdBdtbY+n0jp0/1BVKPleucFdNPG26fgZMez+Mkw0rb38qm+c3rqLU1
	eu6iJ3CsZqOrLo9hHDZvrmL27qFWfEv4j/egL7A80WF9OyO2XupIx3raCFQwmYuV
	b57NV1ZVN0T7qYPthpZLjnwY0m7SCOqJJKMfyoV7+FXO0g0HlnzzEb/rR7KveBDK
	ZUBrIXIaW+8X3NSz4yNrc+jHBHQ4obzuGBYHmSNBIOZhF7ZAMw6aZWqdp3t1T3O9
	XstaqLua7siEAfo9fOvut2FPFYiPQeTWhSrqmAHsKNx+Fhw1BQJ/+1W7hVwsffu+
	53PD2gCDSCD6HtihvWoYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787787117; x=1787873517; bh=Do2mjnX4TG4TUFLaNFFFAwO6nFbp
	ExQCHNDp55zEpnY=; b=Cehkmf2XzlVzt3DJc9POOkz2BKMV2efGF+VGnhgu1Hf4
	siHUgx4uiW4BJAsnASD/Bcw5xuWe4xFDo2XbMtvUKO63NJkI0eSZDRLlGWgDqR3P
	w7cpM3oJ3mdVKXidSkLzB4tbNBP400EFq0IHxq7ebFo7TVDLpvFayyt65+N0L9zU
	HXNi2RPn8pPgIMtp0ZsQmrP7QSvRh0pFlPlo6GIDue1tgTMB2zxVGJFxtCCbDXj9
	tDMRlREo1d2+RvdcdgtFkHudclg+znIwQcLw2EqMerj7dJiM8jVk1EAVLrqyVY3H
	5TWLxUPjmXyRFjiwOlrBhxoFOsRlmQybKYBHsc41kg==
X-ME-Sender: <xms:bXePalaObJMjLgWNFtKCPzIkqTK2W0MkR8PoMrvBi7C7Lnd6o9LiJQ>
    <xme:bXePaiZ-9fAEHIvEfrj5CHaaOL4fMX7Xcb2zO0UeOvb-XSxFaTYWTz4Nhr_A3JVme
    1dceNmzGc9k88rUX4t-5a3PLkyMO_NF1W551znlNaqmXaSVcPkyQA>
X-ME-Received: <xmr:bXePalnQLZvXThx11N51a68zNUhXXzuXIpuHb0fCEQ1yXiYmmXWfmWev0J4BIP1WmNou1nBUnI4WBuWe2mj6ZnR9EZyBx2sBug>
X-ME-Proxy-Cause: dmFkZTFe042QUVWLPbrKp1OthgdcwEfYC5f22uPYdXnriy/XMwJatQPpkZUTA6AYOZ+Tpx
    G/iASQDWzYTGmx48T/rHdHSccTDsAiRJx1B2nrKXq1Pd7SGjwzoKwfuFvN/SedGRyck+Rl
    nuban0d6k6vHZjTFKpI8yFQsfo5COBD4GWbrVutBTRPm9v7Eghn/HOqsPDggcFviHWgR1j
    DpKfdcqXZMKCYes+AOgvvde9zLkxX7pa/WnfUFrZts+QZ9RrjLESYsfhG1ICLKfzIzqEO1
    lq9MU1qkmdfQz4wMcLdxFLUbqE6N2EzB0qYFFq09GINvqxIIz3+tDkU91OGr3zj9fBU8sZ
    +kYhcs50GZUWhdW+JyS6nLtOQR9jPs/aZX3EjN4CwRJdW4hBs+cDoBnzKddKEO59xVvucX
    4f7q1eswbGQmCgpB9DEn4/IvkUmqIBsZFXfUmF4pb2lMPPMf9HVcm/wxQ8GJdp8+UMni/k
    s3J8lnm/cOxoseGmk+U8sBmRjPqUoTRmsKiMfOltz2p8yKCd+xm8cy6eEuoi+TdiKg09Q5
    3d39OwteZuNdV+W8BkZOl1QVpIquuKMZarZk0lRgMGcK3C6I63sRlOClaIVoHC8dnWPDkX
    ThGBkTmPnGvWm6tNDvZAybTkOIpH6vqJQ7UXnE0bGKUwpkeWT/SoLaGkpaCA
X-ME-Proxy: <xmx:bXePauz0l6MzqdliVnPvKiUEmQQgnpy-InFlCihH3nnNLeXRUjIxbw>
    <xmx:bXePajPOFYk2HN7EuNDSXk8znUCMEHNRBeODg481IyaDmuC7KA8yeQ>
    <xmx:bXePaiSJJuRZmUBjRJsbVsRlOYWViUx7L1k6rGf3HNVjCMhIaTJsRA>
    <xmx:bXePahZvY0Ti3ohQRNyL8WUwn5XNVdebD8rHXYS200m1vGrwyn_g2A>
    <xmx:bXePaox_xQyhzkr-PWjJ0Yu91_bjd9IzTOaQ43s5zDpygT9OO4sKyeb2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 19:31:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] die_for_incompatible_opts(): accept more than four options
Date: Wed, 26 Aug 2026 16:31:52 -0700
Message-ID: <20260826233152.1703497-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-862-g3c6f97f7b9
In-Reply-To: <20260826233152.1703497-1-gitster@pobox.com>
References: <20260826233152.1703497-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce die_for_incompatible_opts(), which takes an arbitrary
and unbounded number of <option-name, option-set> pairs and
complains when two or more of these options are set at the same time.

Reimplement die_for_incompatible_opt4() and others in terms of this
function.

To avoid allocation costs, the implementation reports only the first
four mutually incompatible options used.

This behavior is deliberate.  If a set of ten options were mutually
exclusive and a user specified seven of them at once, they would be
told that the first four cannot be used together.  If the user then
tries the remaining three, the same error for the remaining three
would be reported.  It is dubious that there is any practical
downside to not reporting all seven incompatible options at once,
especially given that there are other three mutually incompatible
options that the user will not be told about with this message
anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 26 ++++++++++++++------------
 parse-options.h | 15 +++++++++++----
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b56bc7e419..163842837c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1535,26 +1535,28 @@ void NORETURN usage_msg_optf(const char * const fmt,
 	usage_msg_opt(msg.buf, usagestr, options);
 }
 
-void die_for_incompatible_opt4(const char *opt1_name, int opt1,
-			       const char *opt2_name, int opt2,
-			       const char *opt3_name, int opt3,
-			       const char *opt4_name, int opt4)
+void die_for_incompatible_opts(const char *opt1_name, int opt1, ...)
 {
-	int count = 0;
+	unsigned count = 0;
 	const char *options[4];
+	va_list ap;
+
+	va_start(ap, opt1);
 
 	if (opt1)
 		options[count++] = opt1_name;
-	if (opt2)
-		options[count++] = opt2_name;
-	if (opt3)
-		options[count++] = opt3_name;
-	if (opt4)
-		options[count++] = opt4_name;
+	while (count < ARRAY_SIZE(options)) {
+		const char *name = va_arg(ap, const char *);
+		if (!name)
+			break;
+		if (va_arg(ap, int))
+			options[count++] = name;
+	}
+
 	switch (count) {
 	case 4:
 		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
-		    opt1_name, opt2_name, opt3_name, opt4_name);
+		    options[0], options[1], options[2], options[3]);
 		break;
 	case 3:
 		die(_("options '%s', '%s', and '%s' cannot be used together"),
diff --git a/parse-options.h b/parse-options.h
index 888949ab61..79e4de9b32 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -441,11 +441,18 @@ void NORETURN usage_msg_optf(const char *fmt,
 			     const char * const *usagestr,
 			     const struct option *options, ...);
 
-void die_for_incompatible_opt4(const char *opt1_name, int opt1,
-			       const char *opt2_name, int opt2,
-			       const char *opt3_name, int opt3,
-			       const char *opt4_name, int opt4);
+void die_for_incompatible_opts(const char *opt1_name, int opt1, ...);
 
+static inline void die_for_incompatible_opt4(const char *opt1_name, int opt1,
+					     const char *opt2_name, int opt2,
+					     const char *opt3_name, int opt3,
+					     const char *opt4_name, int opt4)
+{
+	die_for_incompatible_opts(opt1_name, opt1,
+				  opt2_name, opt2,
+				  opt3_name, opt3,
+				  opt4_name, opt4, NULL);
+}
 
 static inline void die_for_incompatible_opt3(const char *opt1_name, int opt1,
 					     const char *opt2_name, int opt2,
-- 
2.55.0-862-g3c6f97f7b9

