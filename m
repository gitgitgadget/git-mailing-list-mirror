Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F620C8E6
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658099; cv=none; b=apNYzLBN0It/z1KNeDzb4QoQYKi1HU++55BNXAckWttG6Ap1FVx4ExWQ5Ox/SGedqv5SyXW90b/L9zMRnRLRUcAlnEI7OowwlhjxpDfYbNjJViJGcGHqfBDs8rgXQBoLR9+UIjwjfqzn0bioAQdneuWlSvYVqhdvagtEfrYwxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658099; c=relaxed/simple;
	bh=RZy0M5hsVuwIQa4vVmLcXUpqN1tlJXVjhNPIbkKKINQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qo6rRo4ZspxfNekZi56Xc//sMeBO+0saQiQFtv/0BKIaOsTBsO0DPQANhgNU/puL4ughgsAengMN8UvmkdWdhpOlZSznY9SvILQwi1oGNwHIucMgmbh3qkyKJhBR/tWu4ViBpbFSeSrHDC0M3db/xnhgucvLux/8+d7oawY/1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM1ryhpE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM1ryhpE"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-598eaafa587so422219e87.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 16:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767658096; x=1768262896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrcokWsoKvHzQUTGFmApdlE+dSW9/MmwedPw+HvZG9g=;
        b=fM1ryhpEpqB/Z0eU1J+t8bjREZzalx7sCRdUz9kIU7kqYEFlDYaEsP6mFg/upZxxC5
         QeA1YsSIWYpvOqI+Ibj/Ti3rB/FH2N2aQ96ydfiuDjWAan69HKCBJluLadt0y3KnKG1s
         ljeNJbfJT7HUS2YRQhJ2fnf8YmrrQakx/VOnwBIGPu5zONUOiD/Q+ka1VS6XyiWKGhXn
         z1M/0Msgfj1hV3cehShW3T7tbtt3ET0Z56lllqe9hBxlXT4gkM+Pbnzmf4YGsmAltb55
         LE3SdedOZXolFbt5AvSth1jyQ74Eiyqyni3ogCeTa5NQlnKF0eeYIjTdRML8naz77Ko1
         vM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767658096; x=1768262896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrcokWsoKvHzQUTGFmApdlE+dSW9/MmwedPw+HvZG9g=;
        b=IwcQyw5uxREThRuKHlEDuZEiGjF9YqcLbShwk9IecCFM/9b9/B6+reLZ6Z0B09R2ar
         UQynC6v6wAYEyRgiCxDSs1R5ewkgRLKyvc4TgOKR7FYRy8BCytRqjoaFF65jqdVJ/+o9
         ebz2tahTsvIkmALLbWe56ZEUI0oTacnCfikBlLHLL7RhezkXGw6+mQuSJKqJEKDrJrDl
         fYL2xgKJ8cj6ZNfXoxskvtjyPjdY0tFAnneEKY3qQQSk4o6clgFfz0W64D13SffYQ7G9
         4mNTnDjrJgK32/Q4lPNDUhYmzgtALlVxsZ9e+gNn/3hwNhbOZC7lAQgt3wvRKOUAWtc1
         QrwA==
X-Gm-Message-State: AOJu0YxX+iF4sR9QohgrtsV5Sa8WvsJlNSoNMh/ydb4Weaj5QqdGMgtm
	//m6xIv5G4q3ufY1lQ8P3y5p90FBRxKcrwaLp15q5CydDsoeaZX2cZao
X-Gm-Gg: AY/fxX7urEsnC5V3GEtPk7QdfbQAjFOUvMiF+0lYBueEtfkRS2Mawp6yeBTQcBsC3Tp
	4ZHvAEyjUIQ/NK9HJXR0v+8liK0/4pNI8YtV+ZDIkKw6tC3i3KLkA8CTSEKDukcMccc8CoF3P+O
	aXqZFZBWey3a5+29DR3j9m5SdR9APUeB9y4Yd603eIR9IulF0xfedVdSK1yGY9zVzpLTQhptObi
	3OlljaO7BucmseOvo/0pqIU5PLoeElceGVuvJ91a7uHKvPd2jZALT2uJL2/0kGL20uIi7/4t5m6
	9tGaFMMScxzrZ/m5ZxBogsDt+OCFiXn/6Rrqg0nKcyRgGqiHj0Kb8FfOyVYILrRSGDTQo0fnJWK
	yHYyP9IPTBv9RYVvA8cUegS+QvwoD59E6ZDnWzAkvgTuIgJGgiDKUMl8WoDKNSPDrQNhL1Haa4q
	K8KjZyyowqSYb/HrP+awW8AKu0qNDv1+fRBvC+QA0gIZ2G8LUGpKcg5ThPrBmaAqsCIkIZ4Wg=
X-Google-Smtp-Source: AGHT+IFA0qC8qvnnqZHHuh6PdiClWIPdfFx6L3CXdYrXio35LmBY5H4idQvPcCVPGZ6enppzXAU/iw==
X-Received: by 2002:ac2:4e09:0:b0:59b:41fe:d5f0 with SMTP id 2adb3069b0e04-59b652bf4efmr487237e87.39.1767658095895;
        Mon, 05 Jan 2026 16:08:15 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea814sm159575e87.12.2026.01.05.16.08.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Jan 2026 16:08:15 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: ABQ
Date: Tue,  6 Jan 2026 01:08:14 +0100
Message-Id: <20260106000814.58893-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqq5x9flndb.fsf@gitster.g>
References: <xmqq5x9flndb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note that this change also makes tests fail on the 'master' branch, so not
an issue introdued by my code:

```
diff --git a/remote.c b/remote.c
index 59b3715120..f84f2747b2 100644
--- a/remote.c
+++ b/remote.c
@@ -2265,7 +2265,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
-	} else if (!sti) {
+	} else if (!ours && !theirs) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			base);
```

If you have the time, it might be interesting to run
'./t6040-tracking-info.sh' and to see what happens for the different cases.

It's failing for the ABQ cases, maybe because of this:

```
	if (abf == AHEAD_BEHIND_QUICK)
		return 1;
```

I would argue this is getting outside of the scope of push branch
comparison, so maybe better to do this as a follow-up? What do you say?


Harald
