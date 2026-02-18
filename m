Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8E32D0C2
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423761; cv=none; b=RGeTl9iwUngqMX7MgD4AeKXPpD46PCVflHGYBuHtQyb/hM36L/VBQ5Cb7YB5NwSTOCgGQWGqHhqnj33iQJ0Sy0YV2aS11mhKGvRIQJe6pEkq4XA21XLd130Lu77KOdgLz71QbH+BEJBnJIWF2PNhWM8EpvlnsLVFZC4fj8hmaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423761; c=relaxed/simple;
	bh=A3nJ2ocdJ/y9nzrqzCuC82mSvVN4GagRTDiOH09QSko=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L1047tc+ZWtwGloOJZ8wmhjU7fY9Ys1RRM+lnY1+upRq095oAp4L72kdHg8/h6BA/nwNE5AeK4vqt+KKCQtpqCvRmtFpu+5gM/7X3ByTpg4r4z4eS44uTuTRpxyvqQYEoXkkzMRspJ9hh/riW6NaIhKJ0Vrj1AssaMFeUhbQt/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGES1XF4; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGES1XF4"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b785801c93so630272eec.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771423759; x=1772028559; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DSJ0O9xN6/l4I5wxamK9qz5cRzaOCcno/GPB7FbK14=;
        b=lGES1XF4D8qUL36CA1L1cdE94mtL6jxj46uiIx68rR2VaHFYgCMDKzlOQA4ZmsPziz
         eEnOuOa27Ap0YcO7VpR5F+FIP4ekxustmt+u3gOvRT8YjclFsYDRwbmTIBL38MPZ11tI
         gKt1dJLCZsE1wlNaxZQZ6AC91i5LkyVphCRIb1oG1rquRIq/ajmz9wlDxYpf/Y+AgCw3
         XGbqvxVRjCwnANmMD+SlLOlEhQVPg63wgo0/6ePnOJ1pfXQ/oOFmPdCi6ItBZuqI4zkK
         lxeh3QpKgCDV+sZ58txlR1p8i8QWn5eC3rzpyEfLAddGdXc0iV5iRuZEknowvPAae4Z0
         YC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423759; x=1772028559;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DSJ0O9xN6/l4I5wxamK9qz5cRzaOCcno/GPB7FbK14=;
        b=d3IfFc8RsYVgylzR6FDLI2CRJuJ1cxEz+hitGW8l6p6TJCNMyAxFIEWxtSNNCcIQat
         EJEmttA5BFB6dRhEo3dnbWSb02FxYqn6A3nC4TAhNvHkL48vtSXcll6I3IhbTWlVFuEp
         OzEWVRn1cpiWUge0DLYCwxRvM3AM3le3VIhOhJ5+zCR60WtCi2XNkvYwVXqPGYWp85KF
         sJuvf3fzrX7Wwinh9trpF5NvMv6gYV6Zsf41CxbM2IK8nxqmuNJRWQvHxjaqwacf5B3V
         MbMNbfWDKugBZlduBRMJ6WnHgFW2d9g98Q/TELjz7++YDrPedh5kEW1EawiWo1axTXBB
         EoVA==
X-Gm-Message-State: AOJu0YwguyH0LoJIIXmMnojJweJlFOWQH7Bf/2svSAdY+1P+cr3MXQya
	iAByX71dE43/2Ya3xF9O8SDI6V4tJ1cDYO72Yr9O1FWhx7tDUNVD6SS6kThTLZAN
X-Gm-Gg: AZuq6aIim5Q8TOh99xHM02M3cR4lC89ZRAlUscIgMFSIjfde7SuORyLxtR4gt4pTSWP
	pH9P/HCl7qCr4cb6SVj7K2EH+/1OTPhaWABQJIC+Nghu7SQDcng+2dKByCnYbZCzCQhk3sIYEeF
	VfheSkphP2ULpZkqMxMjLUm8gmObEYwNqSVtwVF75gAHTC0fRVknNb5+1WPTODYTso3YbpEDSTe
	HyySnfD7ubWs6NuADLp348on7BYRe+vV5WhQTccrmH11ji1QldBcvop4GHRqVKPJSznNB/UPFGI
	Q+l5YriANRVu+UT9A+d+VUawAK0kQS6ItMmFUxhy7LMCs/2MKA9ocCEX9VSTY8W2X6SWnrWv/NG
	Enw3OlX/Q/hEw+X4o5zPi2ggabt2r7XjhfFI4sGm3roT9lB/VPCaqOJ0j8S0chNNf67TsfBDjO7
	31o2jVAB8akdDl+pFe0jPq9mQZkw==
X-Received: by 2002:a05:7301:d1a:b0:2ab:ecd0:5221 with SMTP id 5a478bee46e88-2bac9805318mr6732822eec.42.1771423758267;
        Wed, 18 Feb 2026 06:09:18 -0800 (PST)
Received: from [127.0.0.1] ([52.159.225.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb555b6esm18903990eec.8.2026.02.18.06.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:09:17 -0800 (PST)
Message-Id: <3a39dc9e39d68b9543d97980b6c68d73d1a168df.1771423748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
References: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
	<pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 14:09:07 +0000
Subject: [PATCH v4 4/5] remote-curl: introduce show_http_message_fatal()
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

