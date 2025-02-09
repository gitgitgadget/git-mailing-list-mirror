Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FD140E30
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088812; cv=none; b=HS6hI7EX4wzitFcudpblCCriqX0BGm0KjskOof8LLXhbtsVuVwi4sW2er3mzraSL7dk4MeyhPStd/9b7P7TUmSVuOyweVGT/itfjPml/kn0UCVY4H1qvcVlWLVGCTHILm8E5hHma3L8QcBHxXozRAWdvWJTtruUrQVM9aYg+M2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088812; c=relaxed/simple;
	bh=NJikPuKNwISHQeQ3TVoqZqfYSY+3kUl9QJo01SgTVK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHcErYe8DTK387JP/gwyWMwzZlbyuSLqo6ZYVKfoRTU8lU+JaAxAOL9YK3YWt1Qmsy730seaKxyHb8nDA3YJvN4K+jh40SFKlcluJKOG3+OJ1B9+AYtV8SYg9vv4qwMmpxVz8YGtzkhHkJ0gvNHkppwW3BksutvP8Fmjf0/IK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a//D6gez; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a//D6gez"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21f0444b478so48909585ad.0
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 00:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739088810; x=1739693610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybgQA1cqc06IGa1m/tubJjRRf6SHIAoi4J+F/FjZuao=;
        b=a//D6gezGCcNPYaJ2LQx9b/6540rxrq5wvj2bmGz9Vz2w/ziGPAtGlUNdw6qB8UeDp
         oCnzb0EJc1effKceK5MZGpdGFC5068YPX2NTBe6KLldVLvmHd9ZM5xSr6bNvqgHFFFpF
         3BhAy7+hkrdFip/s+HSAtUmeXeMCmEQJiKQ9uZoEKcNpNjR5l/j4f20QLRf8eIETOKXE
         aTAXw/J8PEzWoEbDGSkBBZb61Z/mpgrKPEC13D9Deaek/bFdTkQLlH/Brr6Col1H0ogc
         TlI/y4f8smccNmE6UJaH4s3H8Sp+smKfsHfLjrb9s8+5gep8/Qo4t7D1qJ4/YQVteikp
         7NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739088810; x=1739693610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybgQA1cqc06IGa1m/tubJjRRf6SHIAoi4J+F/FjZuao=;
        b=ODLwVKntju0EQKRIb8g8Hgt9Ng0sWCCA6c/Ah5PqPHntbgSAN5gVmwqq595TkIW5zI
         ulK59mPdwgOgRLCQEgDUYCdPUvFavBhDMNdGh/Bu4n6jU8wGWOdqoDx1NT2aPnAv7+2Z
         lb6hfdPl+qKyJDgVW5AATDyj5R5q9MwzsmK0p3MmnT66w198OUQ/9VbvgSLhPD2GqJR2
         1Bl/+JygXDRR2kbRmDT4yXsIu7GOlIsvCrGwV2A0BbW0ayCbPNQ3EScndBuDAqld9HnK
         dr3MHxYyc87WVSDWEUD9ms+WdOpW1MMo/8UY40n0L+Ltm5R+c00Q8Ji4WVAhHBb0C5iQ
         lKxg==
X-Gm-Message-State: AOJu0YyRJlz1+GqsciZqFL6v5K3NU8UeyhMFs6gpaOkMo0yW/ziGq0Ms
	gvBcKjX3JUVHZuqUcbCHlTml9fLibmva9KE1Y8kc97t6A21WZo/R
X-Gm-Gg: ASbGncuAVbUG0JFM4X7mu48z3ZKtrdGJ5KogrumPed1hZh2LA088V+iBgDUckJ0eZdp
	KyXNUTVkC3yqowV6dbVF5Ll0zhmLc8j8JD4rUxesmWrRf3UgbvWXUxPDU2oeovuoHcGYZbJ/REj
	txawveFtP996iuV/VK5AtwcpxoBxxREuY66O5VrNtcRcS5y5mYfEYWPSQDrQ5y15UuJOUkS8UBc
	KKDuBH98yQtp24VDi68NpqDbYaxgdtl3st3TZWSYm9PNXyrfeI2o1uO+INkA0yRW0lbhCEA3//Z
	FpbNuDCVvX6aNxMmYg4K4AWSKJjwzowN8dN2hHcedBs233282tJUIA==
X-Google-Smtp-Source: AGHT+IHIXFEdkowixH8dvDFK7PUaYjcO2ITWGlv0M8fdacxi8tlRpMMMcVP/P0h/Cql7ZJTgqhFpCA==
X-Received: by 2002:a05:6a20:6f87:b0:1e1:a75a:c452 with SMTP id adf61e73a8af0-1ee03a8dc54mr15211467637.19.1739088810163;
        Sun, 09 Feb 2025 00:13:30 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([103.116.72.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730889e0c5fsm466308b3a.119.2025.02.09.00.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:13:29 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im
Subject: [GSOC][PATCH v2 1/6] apply: change fields in `apply_state` to unsigned
Date: Sun,  9 Feb 2025 08:12:11 +0000
Message-ID: <20250209081216.241350-2-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209081216.241350-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`.max_change` and `.max_len` of `apply_state` are only used as unsigned
integers. Misuse of `int` type would cause -Wsign-comparison warnings.

Fix this by

  - change `.max_change`'s type to `unsigned` since it's just a counter

  - change `.max_len`'s type to `size_t` since it's a length

  - change the types of relevant variables in function `show_stats`

Note that `printf`'s format string requires us to do some typecast
(from `size_t` to `int`) on `max` in function `show_stats`. This is
safe because we already set a upper bound of `50` for `max` before the
cast.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 9 +++++----
 apply.h | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index 4a7b6120ac..831b338155 100644
--- a/apply.c
+++ b/apply.c
@@ -2238,7 +2238,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 {
 	struct strbuf qname = STRBUF_INIT;
 	char *cp = patch->new_name ? patch->new_name : patch->old_name;
-	int max, add, del;
+	size_t max;
+	unsigned add, del;
 
 	quote_c_style(cp, &qname, NULL, 0);
 
@@ -2257,12 +2258,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 	}
 
 	if (patch->is_binary) {
-		printf(" %-*s |  Bin\n", max, qname.buf);
+		printf(" %-*s |  Bin\n", (int) max, qname.buf);
 		strbuf_release(&qname);
 		return;
 	}
 
-	printf(" %-*s |", max, qname.buf);
+	printf(" %-*s |", (int) max, qname.buf);
 	strbuf_release(&qname);
 
 	/*
@@ -2273,7 +2274,7 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 	del = patch->lines_deleted;
 
 	if (state->max_change > 0) {
-		int total = ((add + del) * max + state->max_change / 2) / state->max_change;
+		unsigned total = ((add + del) * max + state->max_change / 2) / state->max_change;
 		add = (add * max + state->max_change / 2) / state->max_change;
 		del = total - add;
 	}
diff --git a/apply.h b/apply.h
index 90e887ec0e..f7f369d44f 100644
--- a/apply.h
+++ b/apply.h
@@ -90,8 +90,8 @@ struct apply_state {
 	 * we've seen, and the longest filename. That allows us to do simple
 	 * scaling.
 	 */
-	int max_change;
-	int max_len;
+	unsigned max_change;
+	size_t max_len;
 
 	/*
 	 * Records filenames that have been touched, in order to handle
-- 
2.43.0

