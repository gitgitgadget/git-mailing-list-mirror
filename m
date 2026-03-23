Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6972FFDDE
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253149; cv=none; b=dnAIT19oOK0o54ADEvri+l73LJAp6yRrxshs3nJ5I5MdbWdkwc+fKctI0qLlFOyXbGUouvRK6AS7YIecPB99pA/LTnoT2zkYGxZ5E18Bp1S1R0StUagU4iZ14ifC+v0509nB1t4NSyY6AU1M5eqCn17geImTwReBpfnTShYNGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253149; c=relaxed/simple;
	bh=tVID8X+QCpY/tjqJTksk/zsY6itzyO+u+XqpM3bwyjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4bM88y4Z8GHSuGhvwEhWkt4r0IITBrXP1xQB9LZOyA+nqw13V177CVYrmYqyRF1Esje4S29YOCaw1fze1UrIW8y08VlnQftD6CszL7jj8uE1EmLX7XQ0gk5cPmCMrViyD5P4Uw3mmt6NaJfcAOxKLpSYtR72H6XrSlpCjzm24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmB0SVaG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmB0SVaG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b2965d4bso1685205f8f.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253146; x=1774857946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWqiVrBFVlgZOVjL/CXbswMRD4CFcjOeXWmQX56gnTk=;
        b=GmB0SVaGQ384Yjl9FTjaOXd0X/mnp0Kvhn/DhKRY6GBOPvowa8CdGA65YVTgg1sY8M
         QceFzl5sQuAl8Un0szhj+U5YuGg8kJLrC3o6b/2WgCOtibce/phOa70IxhHeqWPQX2zv
         6S/NU206wV2Vjdb5yJtBnZMkuG9J0Be0jz8AKs3ibPL6T5l+mVk1wAmNEQDjsQh6v8xR
         z1y7ApTKVdronD7hszSy5jISKM1E0/+6tKA1nOX8Ge2pTu4izHZyZ22mtnwANCGGKwrp
         2t8UsRwlGk77Mq5uqf3dmAlN0tsy+1Gs24b0m958SlUfCZTRiv7P/7+Wdue8AjffwGeV
         lGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253146; x=1774857946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RWqiVrBFVlgZOVjL/CXbswMRD4CFcjOeXWmQX56gnTk=;
        b=P+9rCuPqy454460MIxnEntMI8TfIzXlYjyeEJBlNX+aC4mAKDXjR2mliIwM7BEWazh
         V4HoE8NjseteDDe+WV8uXHWVwhpm7q8hcC/Rl4UBKHRjcvQzuS9F9+iKCgCqibyooK4j
         Wh0MBBfqQAqbJf8VVp3IOwDQDsCsktw+hnidoavEAs2XN8leAWCZ6JA+IDQ6hIa0d4iX
         KE7/13GKksJdQLZNpu0uDK2W3Ug3pu5sMfbaBcHdTWZURJTYqv+H6OQx/5HrAtGss3wE
         6xNAk2oEeOfpX5Y5FSm2MS+LJ+d06aEATnluh5JTEoE3zq49UnVKrqmgzuTyhDfLMmHA
         1lUg==
X-Gm-Message-State: AOJu0Yw5fRrWHUDdu60OQ4XkEYD1JaNfAJTAhnyh5GZlUqv7Vx3LLn3b
	oVrJEt5r5pJTEkqWUOwjQ4/Kz5CQDpI+FB1hY/vN49z7plVqWeNLLLukxRh9jA==
X-Gm-Gg: ATEYQzwhdy1EfIFYpU9F80rODexsD7f89QY41Dn65Kq1wbpi58qF9tGTh+Ka7+qDoE0
	/tS0qSoAGKsmHVWgOgtkY87mn37BR+xIvmMDCNqlz3oGgZssLsKxg+rcuR632EdaAwgZ8P/x+AI
	PRpgm2SbB/4LEZvGJ/OSHYBjnnE7ORkpMGuh/NQXce8RajgX8tH8RjdWPefYn2/0ASVTFbzF9X3
	LjG4VkFdZ8ozJb2XyLlknsp3s+sMPni1TZ5dEWPR9+Gap1+fw+mkcv4mFAYg8UwJKaGnKobPoIm
	uypZkC0sSt2BFKX2zmydPaO2UqmKubY9Vdu60sMe69Pl4T4In91oDQZJGWOt8tc7wj/iujpRpuF
	sHKRy6Pb/Y+TtUaDmNGkANrVnAb3g+/EFz6EuVoNprmsT763pxg7rQpFd2iH74i+8G2keSsLSLs
	xHQXq3Q5n/AkxXwyXgvCc5wTwzctR5F3wSWsrOXRMZC4CfHt6U9EkusUmhTgcHeTqTBxMnfUvuA
	+wN85dP22TSu/DgLWuCfZoUiM5y8YqOimSeS5s=
X-Received: by 2002:a05:6000:2c06:b0:439:d74f:2109 with SMTP id ffacd0b85a97d-43b64291911mr17134311f8f.49.1774253145656;
        Mon, 23 Mar 2026 01:05:45 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:45 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/16] promisor-remote: refactor has_control_char()
Date: Mon, 23 Mar 2026 09:05:08 +0100
Message-ID: <20260323080520.887550-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to check if some strings contain
control character, so let's refactor the logic to do that in a new
has_control_char() helper function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index f5c4d41155..eda38223b9 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -632,6 +632,14 @@ static int all_fields_match(struct promisor_info *advertised,
 	return 1;
 }
 
+static bool has_control_char(const char *s)
+{
+	for (const char *c = s; *c; c++)
+		if (iscntrl(*c))
+			return true;
+	return false;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *config_info)
@@ -762,18 +770,14 @@ static bool valid_filter(const char *filter, const char *remote_name)
 	return !res;
 }
 
-/* Check that a token doesn't contain any control character */
 static bool valid_token(const char *token, const char *remote_name)
 {
-	const char *c = token;
-
-	for (; *c; c++)
-		if (iscntrl(*c)) {
-			warning(_("invalid token '%s' for remote '%s' "
-				  "will not be stored"),
-				token, remote_name);
-			return false;
-		}
+	if (has_control_char(token)) {
+		warning(_("invalid token '%s' for remote '%s' "
+			  "will not be stored"),
+			token, remote_name);
+		return false;
+	}
 
 	return true;
 }
-- 
2.53.0.625.g20f70b52bb

