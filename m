Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6E25D55D
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755955384; cv=none; b=MkDmQN1cBEUhkzJfdFpDJFBhXJx3pvLN7emRuzxfY7I0uZ5h5m3f97iIAfD7g+I0GbJiqDBQywsaaomNEg8uUaXfUdfv1ikY9GK+fIg9MriGn+6DtB+xWqftZqhwssKSjSdf+3RKTlNbsKjwK+AqQu9yMW4s7rVN+2Dv0XcIwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755955384; c=relaxed/simple;
	bh=YhoVqad8t7VoNKUGjp7QXL30shYCG/rtar23fosDV4w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=sRZMZ6kyzGQY8e00b+Jg+vpS+YU6tAS9TUhluLI7q0I6oIO6wKLgGlsVhWaVBpt0fHBwEEaIHyIx30ZFeJi6eCnY9pVl83NKungkE12iJKEmxU2sRBZieDRWKoHSbjLC7tPQ+kpbf8pMIXdfKqta+Hug/o6oqCg/T1dmBhgrw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdhtDnvF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdhtDnvF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c763484ccdso244831f8f.0
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755955381; x=1756560181; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rThvs5b7M+o8S6DrEiB9D/WFJ6+bM/4UdQydABe8QL8=;
        b=KdhtDnvFatk4HUr/pzK1u4/WflvJ1Fu3Dx9C9jjcHDwtwo/fix5uw7oxaHu/x9VT38
         CGWaQ7OOghwkk/RXvM2sCbOy8GEJbRaUcuTQtAkecZi5XUFAxlHx/C7cURYHj0UcLTx3
         y2Af/R+X5TG8xEVNpvUIKEseoUhYGbvQ22Nivy9lFOPUpnTgcnnQfkfrJVkYtJZLDuhT
         5Hr3tTCJi1pGxUh2K27aez18Plq4RpN7nDJmFwDTWW/NojwDEdrhfLD9yMjg4HYSQ5sV
         VvGk4KxsrTs32gwzOjc7i6UKCIKzfSRhoykIB6ZWoH+1QcbPoY8hNxds/e4xjZyyBVqI
         aUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755955381; x=1756560181;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rThvs5b7M+o8S6DrEiB9D/WFJ6+bM/4UdQydABe8QL8=;
        b=Io5rf2w20g8rytMpbTLuzHNt5GEx1B9ABG1a6+VWblL58ZG6F4yJDGMzGDiobtSHtB
         hUPCgAhlAZL6l+oGtt3dhVWWJ2JkZNsTN4GdMAdSa/LA/P+thK734LBnktHnRSAzzCOe
         LgC6aOE4geNThirMm5Va3VHxr60KHhX6roz02QRsFxCY30kFnu140DZobgFOnFc7Mb9Q
         riFqxuX9y88ONJEs9tMKB2Ge4kadejAISWFiqrARYFvcX/vaXIUb4fJMZO3YUezrlJtJ
         oVM+ond96TGvO2qOjv/NjNnhTT1q5dhGkqt6FOaJ0BBZ1epUKWYQGUcl3TCKy2gep6Cr
         AZuw==
X-Gm-Message-State: AOJu0Yy0/kBXGL62uzlWtzdMVt6r7ozjfiF3uOf2ET8oGQg1rEGdzu8Y
	KgsjsAqiS4txpVuUJ+8TmNVW5qa2F3QGPyRH/JsS+zDfFWtzZBA048T0x84GKw==
X-Gm-Gg: ASbGncuuIY7rjtrl8YjzGPX8I9hBf3krGJP5Vljbfqo5s0788819st3mgWRT9JPAzBh
	0vUoS0oyTHGB3XCnX25anDPxLTDH/hsLmKpA1FgU1euqvZq6QFSstrdYXP2kIfQJ8sYxcvR7+Q/
	dc3VBLmzIniWf0ZseORweG+jns4Y6yo7YvahqUMxphfceVvM7yy6/MkdG08r/CYcSxst5mneQTc
	CoSFsZ0a92JSKks9Qo+ShVRIeN7HJ6Os5piuH9MC2Y5zOgQjJFMwjaH4nhnvCz4RwNZmtDv7yYL
	oFXm4BUyzM9wqCHDnoQikgJAgR/NTT+VwFj5UJeEe+9iNYWdxKhXjgEoPSMA1puOd9jywUVpIbu
	EhdG/lh9D3X0pTmHwkoTiZVAPmAM=
X-Google-Smtp-Source: AGHT+IH8qBlkdRhtWpCrtVDzRXiA1kTKWkR382Y3l9u8lIZEJngVHSTmSF5GsArlTaYMnhGRQuvSgg==
X-Received: by 2002:a05:6000:4383:b0:3c2:9d64:125f with SMTP id ffacd0b85a97d-3c5d51badf6mr6581925f8f.28.1755955380629;
        Sat, 23 Aug 2025 06:23:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711abd15asm3634634f8f.56.2025.08.23.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:23:00 -0700 (PDT)
Message-Id: <0db98c3478e5e2f1aadcf6d773cf6519af482630.1755955378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 13:22:57 +0000
Subject: [PATCH 2/2] progress: add a shutting down state to the SIGALRM
 handler
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>,
    Johannes Sixt <j6t@kdbg.org>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

In a previous commit, sigitimer() was replaced by alarm(), but to
keep the timer active, an extra call to `alarm(1)` was added to
the signal handler, opening a potential race condition whem the
timer is being cleared.

To avoid that, add an extra state to set during shutdown and
adjust the logic to flag the potential need to update progress
into the first bit instead.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 progress.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 71b305d1625d..49e58e094a3f 100644
--- a/progress.c
+++ b/progress.c
@@ -50,6 +50,11 @@ struct progress {
 	int split;
 };
 
+/*
+ * 0: no progress to report
+ * 1: potential update for progress to report
+ * 2: no more progress to report
+ */
 static volatile sig_atomic_t progress_update;
 
 /*
@@ -66,8 +71,10 @@ void progress_test_force_update(void)
 
 static void progress_interval(int signum UNUSED)
 {
-	progress_update = 1;
-	alarm(1);
+	if (progress_update != 2) {
+		alarm(1);
+		progress_update = 1;
+	}
 }
 
 static void set_progress_signal(void)
@@ -93,6 +100,7 @@ static void clear_progress_signal(void)
 	if (progress_testing)
 		return;
 
+	progress_update = 2;
 	alarm(0);
 	signal(SIGALRM, SIG_IGN);
 	progress_update = 0;
@@ -111,14 +119,14 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	int show_update = 0;
 	int last_count_len = counters_sb->len;
 
-	if (progress->delay && (!progress_update || --progress->delay))
+	if (progress->delay && (!(progress_update & 1) || --progress->delay))
 		return;
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
-		if (percent != progress->last_percent || progress_update) {
+		if (percent != progress->last_percent || (progress_update & 1)) {
 			progress->last_percent = percent;
 
 			strbuf_reset(counters_sb);
@@ -128,7 +136,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 				    tp);
 			show_update = 1;
 		}
-	} else if (progress_update) {
+	} else if (progress_update & 1) {
 		strbuf_reset(counters_sb);
 		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
 		show_update = 1;
@@ -239,7 +247,7 @@ void display_throughput(struct progress *progress, uint64_t total)
 	tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
 	throughput_string(&tp->display, total, rate);
-	if (progress->last_value != -1 && progress_update)
+	if (progress->last_value != -1 && (progress_update & 1))
 		display(progress, progress->last_value, NULL);
 }
 
-- 
gitgitgadget
