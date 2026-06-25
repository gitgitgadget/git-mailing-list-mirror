Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A193E00A3
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389625; cv=none; b=EeFAoBC5S0vJF4XyZuPjL6AyEC2uaO647yCS2EUN2zK0I6NmERs1DSqEOLHQ5TKzJx0XrEw6plzNjUe76u6jNuZ2m62FIBUf+kp6Re8EP7zOVjldN5c2QCUy8k27HP/nFZzoquzuTw5Fe6BcR3eNbm6HZIzMKeIvy4Roq+biTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389625; c=relaxed/simple;
	bh=b7gNalSuJF43Y4YsBEM7zMOa/71ACe3qU5kaRssrKfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1PJl79WKj7Tak+Dtq+2F4/QYT8SXv7rF9mo6V4cIr8b3iLm9sHlEfjNxdP8XxpneZRX2nVorQ3IIiEoj8XphTo2LKo6rgNJK3VOoB1t1HkPbDJzS8dlo4Snb1N2QNhecaRyk/V2NIrYZqBLdyRMTT3I20i/HnzcdlfVv8Fn5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyDw81dz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyDw81dz"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso21697935e9.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389622; x=1782994422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMtvDjUAGbXSkW+gzeVh9sTqpJ+WmgpSzts/HpPMdaI=;
        b=PyDw81dzmZeuCYoSXBsrPhkxKLWI1Xw9X2aUx2SJ3mqbTdE2twj8Wquos+ZLYj48cK
         gyYtpxtNMiqEODRllWltYsu74MNiSdJzM6aoDmUVk9XqxUI7123LMYOeoxXqJP5TJsqr
         ezcVdZchUXjoih+YoLLgYxnGIDU5LBR3PyGjQJA+sXx3oaOV+xT9as5HisATgYcJHlJY
         /FXUt9KaDb7h667P4hbFdpLCjtZdC2BGRyZ2kc4TMfqVeckR0OrPxTQ6QjzikKpri5dL
         ap+cKG+JLaya98CFTq/Y4RTvPQepTCu4gfdnctJSwts7Cc3Tts8qYUHMUeWv+f0ok5ot
         bQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389622; x=1782994422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BMtvDjUAGbXSkW+gzeVh9sTqpJ+WmgpSzts/HpPMdaI=;
        b=ZCbrKxxb/+vMJAifCLNsn0TgVJmJPQdJLKeSPFByW4kpX7mFV7QQH4WlRUdP9Av7+z
         +4Y0PSe8kDrwm5Ku1J6VFkwSezSrfz8ZOsi5ic9RpPKOZhv909s8FmWSlc14cLAnRUyv
         HjbhiD93YTVJvCc9/B7+vSWjbeB1n0TddR2MYWWbtTL2PDu8g/+eizoogqhS15hITmwX
         q+6WN0/ZLm5nvUf6naZdsAOczt1wee/eU49wSXh0yekmcip+y2mIenVXuPIoxLIivkt0
         Rl+kuNkghG6a50ezosga2+2HclyFBVynEqi5vQOfuqxLVmnI5AS7bItK0ILzHzN+5Q4q
         c+TQ==
X-Gm-Message-State: AOJu0YzQ1IniqIgevJLVVRebPnMj+5qLBRuHPMZV1OnJERFchnCKiUOB
	Ab7EkeXf5CBAAEApFAYo1FSmA2QlWe+iZsWT9rN+rc50J7fMXCKD5ZqGtRKrvZnx
X-Gm-Gg: AfdE7clzn1jIf8YW6ZVI7tdHj6DJ2qswc0MNFOLqW5sb4IjfUb7BuiX7fWQFmmxLfgI
	v1uWhA/V3zxI0sdicqTFvTNk2qUX5tDnWFA4yQDnJTJXEmdFS/NQ8saYZLPAPeDbaGAEDsf2FOn
	LJLKohFyQHgztcb+IRQg0wMIyd8kswqYovLZVDpAdiMgEEiAeD6XHUd31ePcMUDveFAYnJSI/Ux
	TirMCLnIowvwOBLd3soOyxytLB8SAyM7Nty3VOmduzFY/bXrhwXJjoX1NZEGb6zMWj0QbHfrHxc
	nrVUVlZPXsPn9RbAYL2+CjkMYZt0KZdp7gMorwxLLHe/wRE4DUSVZ7wmj8tMYmCoSNwtSHjlUD7
	WFKIDlaEfJK3CP3WDlYk4of2Z46uIuTLp58tdrvOQyZIqrB4AM6TaYxiFvSGqh1DD6TqDtkEdFY
	UrqHFeh+hgyvFre2QWs5HIws74wK/Ji4BDdtsI3pULy/g24euw8bWRNXK38LGnmaNxflsImPuV3
	Vg0O8pVq5Lrj4g8CjFZlkoG2iaFp8hByOjCBOLE6gt53cGVEjwZxl21IP7ZTiZ1BGZEaB8NBSlK
	4mXBD8Oe027ay0yfhkdBQHQNouHkrvyQ34SfyuVywmst3w7RNtIBUee9jNvl4ddX5Fv6bIX/Ija
	ILUYnLp5ETw==
X-Received: by 2002:a05:600d:8497:20b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-492668414d1mr23788845e9.11.1782389622159;
        Thu, 25 Jun 2026 05:13:42 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:41 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v14 02/13] git-compat-util: add strtoul_szt() with error handling
Date: Thu, 25 Jun 2026 14:13:24 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-2-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

We already have strtoul_ui() and similar functions that provide proper
error handling using strtoul from the standard library. However,
there isn't currently a variant that returns an unsigned long.

This variant is needed in a subsequent commit to enable returning an
size_t with proper error handling.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 git-compat-util.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8809776407..7f417f1acf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }
 
+/*
+ * Convert a string to a size_t using the standard library's strtoul, with
+ * additional error handling to ensure robustness.
+ */
+static inline int strtoul_szt(char const *s, int base, size_t *result)
+{
+	unsigned long ul;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (strchr(s, '-'))
+		return -1;
+	ul = strtoul(s, &p, base);
+	if (errno || *p || p == s)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 static inline int strtol_i(char const *s, int base, int *result)
 {
 	long ul;

-- 
2.54.0
