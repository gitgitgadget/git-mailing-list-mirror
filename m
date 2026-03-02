Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0BE3112BD
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481692; cv=none; b=mOQSqnPRUc8S2fVaebczmPHx2WyPNPex1J8I91xynmZUJRa7ow0yqTorZIySawjt4qxsjSAYUrrTCb7Zc+VbKpBUoKWqXJOyBNxHw0GIqVRz8f/I39jPdnYK5GMoKchvjmILIwgtIDblDI8/Ky23L196xQlKNS191HQLyrSUUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481692; c=relaxed/simple;
	bh=7TJmEU09q6o9ZCY8HIpJWc5f0fYGSHifFnqjXd3Shx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnAK2u/kayib40jQRG9GgzivGEcyKypRyaPhnjMR6E4oVdZCHVWddZwSp/kCD7SUY7F7otp6tfnWT2NrHNayC2vkqAn6CqxvjRVdr4NnCO1vdWRcOdyKA66UWkfXbMYCngESvjIuyz7IFcnOYkP1DsVsD+IL6yN7U3n6JjPA1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwCcMvge; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwCcMvge"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48372efa020so42328005e9.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 12:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772481689; x=1773086489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzULlE63LFxZBQoSsZXHWwuhbFzQmDJQhb9f4JifcSo=;
        b=mwCcMvgej0WeRy3vqFu91AQUdKcGgBdft7LQIhGMhSQ0dgaLybM3oq/jCxOT5hGmaL
         TP89Usxc+iGHpzRP7GUCro1QSMV7shxRpq2wRm0AqJVF/a07c/vvUkhMiZEb3C4VPYiE
         0cHJLg6P5CVFXjvgdcG2yPstozD6BHSUTDRnLOUPpPUdo+FvSBTPlkKbGZjoedK22ZYi
         2CuODjJvSsDgZnsn55ENjxzu+UvZTHqKTcsx50Tvr0lpW5khYvkY5r7n7waIhg5y2y9g
         KeYHOAjcSVq+DrwJiURRig99nTRKhrVswOP4FxvK1gNNdCcsJTdV7Z8gIBiCfuWYPp55
         eSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481689; x=1773086489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AzULlE63LFxZBQoSsZXHWwuhbFzQmDJQhb9f4JifcSo=;
        b=Wbm5Rr4B6vbyWLatRPWj1hURAimd3RMPn0zVclxFgd8w2h8AMAunDfhlACnY1GOcFI
         /Lep0JQ4LS4iRop3SO3uYmuf3S0Vb+6iYoFFmKHETFF3UJ/zS2+K7fSwDNliP8Naqxrt
         6O1aWzEn1IBWmNRcW0lgQ406VQwLyti6MUb5LKfZ8dE7mN9SKiBbz+GSxW+gLmh9KL5T
         WF7NO/CYHkKTnt+wix3GoPm3CEF4twRqQdkzgDIHnIlIf7i+HsH3RMYcma1PIgtQhHZg
         74t2j/joK6waEKMnBBlv6e8T36FH79zr0zmuYO/g1PKtL0nlLpzYnk6/lAmED6EBfE1b
         whZw==
X-Gm-Message-State: AOJu0YwYd8olsy3pXifL1A+guuNCa9if1nSpvKY/qjx5s3v6dpztUa+r
	YF44NM7FTd3A1UrTrHWnW6ftxqssyckM82CtvbxAPk4Pcm6oKPTjr1B2zxI7lpr7
X-Gm-Gg: ATEYQzzRuCrl4jmx7NXbwnIdIhXGexbOSgcviyyWNVhxaqt80y+xUrUgCXRkYvZuEh1
	7YfpSm/m92rYj+JMryZ3emDtjWm0Sj4hLZEFfCVALGXEuwS5XdM94gzMlzNTPGNtJb2yM94UCxx
	XnK+CIeSJ/6qJwWSy3PN6voTUQ28lwJsWA/JErPdOeB8p0uIq8HkM0Ee0GtRmgHLipQMxC/c9qX
	3WVOnOMHrCKIwz0TI5eXnDQ1lgLaV6aWS5MSk/IJZ3YT0syaV9a+kJeN50SPE3TtaVBhnfcWWwT
	1ZF7BGRzLv4z2mojYdojkpbkpzfKje57EIFlaRZQKYEq9WCy+jYlLogQCtRf0ePwKXHUes0aKQq
	JFG7QVNsbfmNxKVSoRiXBkanee3oKR1WpuUcREh3I9g/v1n8W8u2oIzSyoC0XSrCxi8io/+fczw
	ZhrwSIKgegyLRoaOCokKOFoFNHKPqMEc2dVVnXCwz3riGn8vv1S0SD5Gam99R+888wUgDqLLGRf
	sNrcBGEDw==
X-Received: by 2002:a05:600c:828c:b0:483:8f0f:36fe with SMTP id 5b1f17b1804b1-483c9bb0c9fmr228337155e9.1.1772481689130;
        Mon, 02 Mar 2026 12:01:29 -0800 (PST)
Received: from localhost.localdomain ([105.113.67.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126547absm446875e9.7.2026.03.02.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:01:28 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH v2 5/5] sequencer: use oidmap_clear_with_free() for string_entry cleanup
Date: Mon,  2 Mar 2026 21:00:17 +0100
Message-ID: <20260302200018.75731-6-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302200018.75731-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
 <20260302200018.75731-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

Switch cleanup of the string_entry oidmap to
oidmap_clear_with_free() and introduce a free_string_entry()
helper to properly free each allocated struct string_entry.

This aligns with the ongoing migration to use the callback-based
oidmap cleanup API.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 sequencer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a3eb39bb25..75ef2ace4f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5654,6 +5654,12 @@ struct string_entry {
 	char string[FLEX_ARRAY];
 };
 
+static void free_string_entry(void *e)
+{
+	struct string_entry *entry = container_of(e, struct string_entry, entry);
+	free(entry);
+}
+
 struct label_state {
 	struct oidmap commit2label;
 	struct hashmap labels;
@@ -6044,8 +6050,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	oidset_clear(&interesting);
 	oidset_clear(&child_seen);
 	oidset_clear(&shown);
-	oidmap_clear(&commit2todo, 1);
-	oidmap_clear(&state.commit2label, 1);
+	oidmap_clear_with_free(&commit2todo, free_string_entry);
+	oidmap_clear_with_free(&state.commit2label, free_string_entry);
 	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
 	strbuf_release(&state.buf);
 
-- 
2.43.0

