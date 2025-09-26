Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E52F360D
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882779; cv=none; b=qkESFeCo4GKXpKcSTU1sYeaeLp7ii6N68/tNYZzv21r6sM+EX71C+4j9a4Xgbx2wh700tHBZer8pNF9h2YQ6xyP8hBLjCKTZR8vLwQ9a2cLhTkg/8bs1P3K+24EwaTSiRiPnkHZuy2P3OuNztflzlswKOy58Qg3y0o+d6n/WAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882779; c=relaxed/simple;
	bh=4p6aUTFqSpx5RdpJ+d9x95GV5N4ptMARpju0po/ePyc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kTPVPU8trfdrvt7vwTLFaFBw/4VHBDEWQTAZFqYXw/GCTT9q86ipv2K0n0SlxwrY30kF2ez0dzFOPnJmnmSXuoR31NXMMjIyNcEe0RWiF6QdnfYfET5z+SlLYMEkj10P9ZlK5TPS+JJQiykPe+jb/ueA/ICoy7ZW4EkTFGy5LyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwHVwv5d; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwHVwv5d"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-85630d17586so263880785a.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758882776; x=1759487576; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIiBBC/LIsoKEvJcKwMPjUQVper/Asrx0m5LUg9E9is=;
        b=GwHVwv5d2XnlVscAyO4sBS6wRGcmR0Fw7qSrsIZsGZEMU/FcobkLckpeiJiYw785VP
         bspUv9SkbPhx4SqeK5sUJpd8Rb0Dsafs4nt+gJac4JTg5r0OPuSTdl7rYgGxLDCWGVzF
         55wnfs9gymn+kmkDUNY2mh3XQQY8NJvh4NFIHjuQo5GyJmDBurpC3m/3LqYMflCTFOHD
         UFIBtZ0ntS4ISPBpCBJfn7f6jXiIsBCMAXVWMqVDWUmAcpwcYCJ2J9TsO2VVguMQeslO
         KcMILCy/XijPEhNja0i4Int1VimZVsrZz943adfii9bsvyckvWEAFrH3iYHTpXd3g2Tr
         c/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882776; x=1759487576;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIiBBC/LIsoKEvJcKwMPjUQVper/Asrx0m5LUg9E9is=;
        b=SCAznLq+aabaNwv02s6rFQgeMQbP3sivCwOzK4d85bYezOF/XYx/p4m502I9MWJi40
         d5GsSBKPoUxjeJizY3CWmt+fEKvLtCHf4GKBnNi4Fp75hUxfnl3NsjWdGPXH97E6LGDL
         wxUzApz/+LzFZW8a/89d1yHcSK3uaWVuEXWKt95vZoGVvIW0yePAvvmSy6mwesSiCQrz
         40757t1aQwDy8ffylXe6bA47Fl4qGBg3A4tVNPfgH23Jm4kmNRC6MKiVnW8NCh/ue62h
         3JL60KLn3RD+IfgXtyC+NYVqSXNq+PbWgwdv0MFzNI+Z/UPX6NFNpHeFHVNuHo6P4PNU
         AKHg==
X-Gm-Message-State: AOJu0YzM/0B3P+ha7DyX4PDOF3qtUa5D5U4Fszp8bU/vbcujBPd+rcD0
	E0UpRyi90o4rvMlMU7uH07gG2toM+iPESZclACdwxnkkOkdFjmTWaQjLK6+KSg==
X-Gm-Gg: ASbGnctBTwdLa+mXYKbBlpslEnzrrZODYEoh8eOY3kqPSQgAqMnE4Jc8/dDGLyO/LyO
	Os0wts92xq3uWoinPck1IT0UluKAjt/Gy5HQwyyEuCJEm+BQnPCj8wKw7sT5fneUZ58k01M9Bya
	JjW+iFJSOAGjrNImSfJDsI2Bt1bkf7kQ788hzFTxJdk+NE2Su/vth6FcS+vuCRQHsCG/z8+au7I
	+4NgPKMCR7RWYhZA2QGuLh4VTHHH6X+kkPM5oYLVXyAmk7jAJccl4AUjTWcjbcwFNipZtYqZq+b
	KamwouDEH3jh+bdFgqLCXLQfQx8ogtwGFFMUS4h0lHpGmLdWtb6EjtHVL9nPZEyH1eZR1EEgSY6
	4j5Po5S35zu6CaJ8Py/UZd0LkeUesy5Nf
X-Google-Smtp-Source: AGHT+IHnTpgAz1EOykXIV6aXJWgKk0lpA180baSMZb1VfxZhFIqf2SUTT8+jMNpnrHOPu2WbWZsabQ==
X-Received: by 2002:a05:620a:458c:b0:85a:2def:2ff4 with SMTP id af79cd13be357-85aed401a3bmr751332785a.79.1758882775639;
        Fri, 26 Sep 2025 03:32:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11cd5e0fsm23998291cf.50.2025.09.26.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:32:54 -0700 (PDT)
Message-Id: <114eb9c8ecfbc5be33edf697ffc05fed6444beb7.1758882772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1974.v2.git.1758882772.gitgitgadget@gmail.com>
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
	<pull.1974.v2.git.1758882772.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 10:32:50 +0000
Subject: [PATCH v2 1/3] http: offer to cast `size_t` to `curl_off_t` safely
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

With this move, `gettext.h` must be `#include`d in `http.h` to allow the
error message to remain translatable.

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

