Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3132566D3
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457364; cv=none; b=CzLJhkCKGmoDdjBVVWYppEgYM8r6z7+zYc2LsnoPypAdSSJNhq1UIN3TUDI83vStPF4usBlkA3Q3WqKlzKcizJa9xcmpaEVvwzqoCyt6sjlwS1oCHnHuq42ij55b0fHIESG3tmtmm4ufcSZfc1vlHpKpiuDfTqEhUM6qJPSroSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457364; c=relaxed/simple;
	bh=oKxs1mKaiVH/aAOM+tu61Br9iNqTuf6ZXU5HajbpfAk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PaF7BY4XqsO3TKjfMooUztBQF88QD2df/WKR5+EI4WmDXp7gyasopLLMQzLVYMUYFyTh7Drl2I3j+6SFeVX6dRVbJll9EZF7Q6TYELhzxAN5rb4SOkyVRj8OqpRLPq04CTDqMq2fM0Ij0e0qHUKDXn3ut+XrhZ4CqO9SrAaUkC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7aVmL9c; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7aVmL9c"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42485372dc6so17884635ab.0
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758457361; x=1759062161; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtmTbVlblzPNiI5KGdgTld7TtRxl+rhhbndg/Gxj1gQ=;
        b=Q7aVmL9c33e68C7Zt41TwaWeTIAt1TZQjY5nYTvp4IJQ4T3Yec/5lYmlASgP7SJ2uU
         vTpZzZxbw4EAPOzs/QbExHyV23hpaa7JlvHTnI62yl7puZqvtHAKUfrEsYzLHnKi6RfG
         XlNjW6ehABEcVkLcHvtWO2c5WtsquT3ua4NqjpYOnsU1RKwcp6mgA0ubR6qVcAjiyxEn
         pMW0N/6VwOiMhmoNmRCZ6I6IJW2a+DAcSZpbVbMTua67e1Gr3FPmBD5YYVET8swtew9Y
         PE96yAGShNu456T/O81KfDitqgyL87i11jO3Sf6agrDWsxZ4PivLjyYwM3GYZEe1Kigb
         +7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758457361; x=1759062161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtmTbVlblzPNiI5KGdgTld7TtRxl+rhhbndg/Gxj1gQ=;
        b=Ax6Z8svqEASer02WZaQ37IryXP1/fAdIlxS1VWMWh0AwMOACt0RshU8/LzMqVnggim
         Fw65naeyhf+4SYqMF21Vxo0GRSJD3mkh1GgRpsRxS3uDoVlfQGvdOvPAzk4BIQGQB8Dd
         MJRf8WFIfws1e8/Jobz5rQ2XVPTc9nAxRC2KFlsAYMk4IgobrKjCdHNoo2XOgMIcAEBz
         TEww/mkqmG5LqaOnov55hmryIwpKpMS+oWq5EVKetRS1RMxyJf4GVAFVnr5m2R2Yc1Pn
         TP4EyjLQbnLsJ0cEIbAmXtGYKLNcRZkPzKoq03APQtRuFrhn7LZZ4SzEJKjkiStCANJz
         kV5Q==
X-Gm-Message-State: AOJu0Yz/TjQHu1ZlmalfkA2QZJfmniTi/otP8id+zx8FXmXPu/HlCejI
	I7RnWaepS6c90st2BxPLLODMkCv6EtwHIZcJsF0MYU6cemxVaz2k5g6ExXbYrpuq
X-Gm-Gg: ASbGncu+66nXZKexnpKTc+Q5Dh1ZMSPOP8XvxcGux/W5R+glmXDHdcJ6fEBk/KSQGAr
	OYizOJg3Rfaw5nSU/pJ8T2ojRO5Xxt/YokFA5PejLb3Yw2HTMzDhjeOiNIFYZ1wdg27UFT2tBLQ
	TwiMTAYXrBJ4ScjWsshDWkmcAQBss//Q9X0DEThoG1rggEL58pD2Uqf1ydPTag7wUVqZqB4hnNj
	9d/XK8jg/RmTP8mSmWwT6j/B9gpHMcROJaeiVNrnK+TCg6Kux0YP1PwV0CdQVpYW/URZkBGNpB2
	a/eHWsIOoeq2wZeu4tGO8gGmSqLStKQ56BLywvXnBo8S+QS16p4bab0HrukHCbkUgAFbT9fzCqJ
	+0sdjnlTWouY1q2USD2BwYpTh
X-Google-Smtp-Source: AGHT+IGRw8li0EjpLO9Ec4WsX0232uBbrsUnoA5uI9lFZv6xrg5hGPs3nOKk1WF1eIk2WHLiO8rraA==
X-Received: by 2002:a05:6e02:17cf:b0:424:80f2:29b with SMTP id e9e14a558f8ab-424818f7eebmr168070215ab.4.1758457361091;
        Sun, 21 Sep 2025 05:22:41 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.35.114])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d55460864sm4505808173.66.2025.09.21.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 05:22:40 -0700 (PDT)
Message-Id: <7caaec91020687f09764bbd50477c3fe889fcfed.1758457356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Sep 2025 12:22:34 +0000
Subject: [PATCH 1/3] http: offer to cast `size_t` to `curl_off_t` safely
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This commit moves the `xcurl_off_t()` function, which validates that a
given value fits within the `curl_off_t` data type and then casts it, to
a more central place so that it can be used outside of `remote-curl.c`,
too.

At the same time, this function is renamed to conform better with the
naming convention of the helper functions that safely cast from one data
type to another which has been well established in `git-compat-util.h`.

With this move, the error message can unfortunately no longer be renamed
because the `_(...)` function is not available at the time of
definition.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.h        | 10 ++++++++++
 remote-curl.c | 14 +++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/http.h b/http.h
index 36202139f4..0a36dbd294 100644
--- a/http.h
+++ b/http.h
@@ -8,6 +8,7 @@ struct packed_git;
 #include <curl/curl.h>
 #include <curl/easy.h>
 
+#include "gettext.h"
 #include "strbuf.h"
 #include "remote.h"
 
@@ -95,6 +96,15 @@ static inline int missing__target(int code, int result)
 
 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
 
+static inline curl_off_t cast_size_t_to_curl_off_t(size_t a)
+{
+	uintmax_t size = a;
+	if (size > maximum_signed_value_of_type(curl_off_t))
+		die(_("number too large to represent as curl_off_t "
+		      "on this platform: %"PRIuMAX), (uintmax_t)a);
+	return (curl_off_t)a;
+}
+
 /*
  * Normalize curl results to handle CURL_FAILONERROR (or lack thereof). Failing
  * http codes have their "result" converted to CURLE_HTTP_RETURNED_ERROR, and
diff --git a/remote-curl.c b/remote-curl.c
index 84f4694780..69f919454a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -894,14 +894,6 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	return err;
 }
 
-static curl_off_t xcurl_off_t(size_t len)
-{
-	uintmax_t size = len;
-	if (size > maximum_signed_value_of_type(curl_off_t))
-		die(_("cannot handle pushes this big"));
-	return (curl_off_t)size;
-}
-
 /*
  * If flush_received is true, do not attempt to read any more; just use what's
  * in rpc->buf.
@@ -999,7 +991,7 @@ retry:
 		 * and we just need to send it.
 		 */
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
-		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, xcurl_off_t(gzip_size));
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, cast_size_t_to_curl_off_t(gzip_size));
 
 	} else if (use_gzip && 1024 < rpc->len) {
 		/* The client backend isn't giving us compressed data so
@@ -1030,7 +1022,7 @@ retry:
 
 		headers = curl_slist_append(headers, "Content-Encoding: gzip");
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
-		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, xcurl_off_t(gzip_size));
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, cast_size_t_to_curl_off_t(gzip_size));
 
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (gzip %lu to %lu bytes)\n",
@@ -1043,7 +1035,7 @@ retry:
 		 * more normal Content-Length approach.
 		 */
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, rpc->buf);
-		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, xcurl_off_t(rpc->len));
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, cast_size_t_to_curl_off_t(rpc->len));
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (%lu bytes)\n",
 				rpc->service_name, (unsigned long)rpc->len);
-- 
gitgitgadget

