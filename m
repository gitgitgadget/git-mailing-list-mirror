Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C127FD51
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856413; cv=none; b=hV0qSoxzPV6F/zUgu5fJdZg7T2ulFyhC3A7fOauqr517pHtlUR6raqvnh+Ibit1kCbqWBY6oxLgVRu1t/SxhefigCdixoK8qZjalkAdwN3Gcn82yLwwNZ44wHV2LMPW0zidBJrPzq02To26fxA9OVrNR00BX9UhVW3THlKc/LsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856413; c=relaxed/simple;
	bh=A3nJ2ocdJ/y9nzrqzCuC82mSvVN4GagRTDiOH09QSko=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MQ8GtGyf9sMMlC2Vb6FNuHNKfaq06r17rAKbwyeSKrJmiEa1U9NdNihPEwJcnAFnuxsVh14VeP4QQZi72IIg7JOWXC9dqfX+aouCW74pPdQGNVrfN8pkSlnjFl0qmtiMRSQ0m0fW3g9ubSdsP77jE7hLzQXEMudhIy9eBX+5/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eph39hHD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eph39hHD"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3a8494c5so412739685a.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856411; x=1772461211; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DSJ0O9xN6/l4I5wxamK9qz5cRzaOCcno/GPB7FbK14=;
        b=eph39hHDbChO7nPBxjmlWhpfyxDiwRxOfzVuNa2ak6n2Eo//YbtOkdfZxe/04oHsbI
         oma3yL1Q/w43XxBlSuYCLpAlqrXS0ew4jkWLWI6GZM60ujZV5bCWjxIxrYNT5QYUar3J
         baprnGFlYxf5srfKY5o08Cm1huRtyhwxcR29/mNyV+wzQVYrRaTG+g45HqsCcQOREYqx
         GDjp0FbElxw30UVlmKAriG8gFShD4Kly/6GIYPW1x0e/0n+gGQnBymG0q3k0b7RYbej2
         Ui6706SAVKQMSAOLHbBsQHkz6JSrY3VMszYK5nsgp9wjSim5NwAKGNJrd0mdxVB1xipm
         xT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856411; x=1772461211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DSJ0O9xN6/l4I5wxamK9qz5cRzaOCcno/GPB7FbK14=;
        b=Ht8dHk12t6V/8RYU7Mx42fV1q31kc2juFRYxA+nhAr5Iwu1RoJyTGu4J2xACpiXvgP
         omD8ZST9URQcWU8Y6v48SNnDrq2G2Lj/hDEOyHMR+6wCbSxLPC/7tQhVfYYOwSqsq1sF
         wAxb7PcnW6D9JgpKvb2E8B8c+BG7ahqHbMAVOBBuLwax8M4ZSrKByPbRQCed6st4d5Vy
         NuDYaN24b0MoZX9QiCoVdEaq2u2xLqDsICH94y61Bt6mJBYhGZPJFqcVNGLC6NEte4Go
         d/Si5tJRPVOV5rFTQx6mNdm+iRh4VoOaWmk0WBFnyEsy+Aty+rfwuK9i7GyYIypmflYy
         8aEw==
X-Gm-Message-State: AOJu0YyIY3sYVMT/g2E02fgZUfj1o9arw7o1q68mZs4yroWxry8IMooC
	4yJS60GddB3vMsMpv3fj8In2smPMQyBgYiSYAVVyIYnp6Q7QibDSJ6TLBIKvDMlR
X-Gm-Gg: AZuq6aJWj+YaunAvV0CxvKN7DLGSaZYnnaVNPy6qSMx4dXC783BLJqJYJ4fMaC9KVoH
	tydQGzrDfZ1FWVDGpr5HwkzlpIj3EOB+VFBoE7o1qrPBMX+NQmAL51OwD4H3D3GadNIOXxb/umV
	NX5gxHSFo20syHP6DjIn5sMBmJ/gkX3SZeSLvKGA1K0I+BcY+6cQItmH8SQqoaudmOnkkd/GhaO
	QsUBGy3W6XP2TlSdSw36cqbfiOHJr7EEVq0T+wZAqmue/vJ+pQFMGs5SWj7iMkRpuntJqrt5Ke8
	JJsWrXnjWfnR0JXRUL40fPyXRN1DST1gpGgTnmrAVBZKavLoyvkmAnHcXHQRnRTPfHjs6lPm6ox
	6fCPWIllCa9ZlO/VRxwkQvPY9ruT4Gy+Hp7aNia5G4cJNaGp6wDXuR9z0vruMTyU7eA7MlOZRtM
	+wcs7JtnKlnqYQ+x7vf4b/ZPKFhA==
X-Received: by 2002:a05:620a:25c6:b0:8cb:4113:2526 with SMTP id af79cd13be357-8cb8ca9e284mr1017685585a.71.1771856409679;
        Mon, 23 Feb 2026 06:20:09 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d060846sm691943085a.14.2026.02.23.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:20:09 -0800 (PST)
Message-Id: <973703e9ddedb67daa946208ef7edb9eb50425a7.1771856405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
	<pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:20:04 +0000
Subject: [PATCH v5 3/4] remote-curl: introduce show_http_message_fatal()
 helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Several code paths in remote-curl.c follow the same pattern of calling
show_http_message() to display server error messages followed by die()
to terminate with an error. This duplication makes the code more verbose
and harder to maintain.

Introduce a new show_http_message_fatal() helper function that combines
these two operations. This function:

1. Displays any HTTP error message from the server via show_http_message()
2. Calls die() with the provided error message
3. Returns NORETURN to help the compiler with control flow analysis

Refactor existing call sites in remote-curl.c to use this new helper,
reducing code duplication and improving readability. This pattern will
also be used by upcoming HTTP 429 rate limiting support.

Suggested-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 remote-curl.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..21c96f2ca9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -367,23 +367,25 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
-static int show_http_message(struct strbuf *type, struct strbuf *charset,
-			     struct strbuf *msg)
+static NORETURN void show_http_message_fatal(struct strbuf *type, struct strbuf *charset,
+				    struct strbuf *msg, const char *fmt, ...)
 {
 	const char *p, *eol;
+	va_list ap;
+	report_fn die_message_routine = get_die_message_routine();
 
 	/*
 	 * We only show text/plain parts, as other types are likely
 	 * to be ugly to look at on the user's terminal.
 	 */
 	if (strcmp(type->buf, "text/plain"))
-		return -1;
+		goto out;
 	if (charset->len)
 		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
 
 	strbuf_trim(msg);
 	if (!msg->len)
-		return -1;
+		goto out;
 
 	p = msg->buf;
 	do {
@@ -391,7 +393,16 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
 		p = eol + 1;
 	} while(*eol);
-	return 0;
+
+out:
+	strbuf_release(type);
+	strbuf_release(charset);
+	strbuf_release(msg);
+
+	va_start(ap, fmt);
+	die_message_routine(fmt, ap);
+	va_end(ap);
+	exit(128);
 }
 
 static int get_protocol_http_header(enum protocol_version version,
@@ -518,21 +529,21 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	case HTTP_OK:
 		break;
 	case HTTP_MISSING_TARGET:
-		show_http_message(&type, &charset, &buffer);
-		die(_("repository '%s' not found"),
-		    transport_anonymize_url(url.buf));
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("repository '%s' not found"),
+					transport_anonymize_url(url.buf));
 	case HTTP_NOAUTH:
-		show_http_message(&type, &charset, &buffer);
-		die(_("Authentication failed for '%s'"),
-		    transport_anonymize_url(url.buf));
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("Authentication failed for '%s'"),
+					transport_anonymize_url(url.buf));
 	case HTTP_NOMATCHPUBLICKEY:
-		show_http_message(&type, &charset, &buffer);
-		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
-		    transport_anonymize_url(url.buf), curl_errorstr);
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
+					transport_anonymize_url(url.buf), curl_errorstr);
 	default:
-		show_http_message(&type, &charset, &buffer);
-		die(_("unable to access '%s': %s"),
-		    transport_anonymize_url(url.buf), curl_errorstr);
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("unable to access '%s': %s"),
+					transport_anonymize_url(url.buf), curl_errorstr);
 	}
 
 	if (options.verbosity && !starts_with(refs_url.buf, url.buf)) {
-- 
gitgitgadget

