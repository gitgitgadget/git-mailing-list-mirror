Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E053DA7C6
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044628; cv=none; b=H3ER6+u7GIYBnmdpTQhYKpqmyJuOCHl2dCdXK9NwWqtxPolDCaFHuLfzpyJndw6zYShDcrVp8924e/b6P4x+nCJwVJtPF7Nqrfnt9v2nJW/4PEQfK9RQaD/cONrZO+vy5UnwEK/ZYRPCQI1tXHYkr+jgVyw6vsjpVchxmoK3buc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044628; c=relaxed/simple;
	bh=x8rTtbszX+y5SnctRaF05aY+ccEbHPmS3djNtBbz9xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HliOIs/13kgAsyZcBkUmXBH1lI7WnjmeIbcTrMgoSYuRpWE1tfZPY2ZHEpjIYXvvs6v38Xer5nZhTjKz4nuMZX93ZtT8qyUXTnh/ueg9b3EM16qjJ8zCSHwkQ5qu6t+66dpwkSvmA1mMTE1VNmLJCk3uvh14oFzxVMCUYMRpzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwtFN3lv; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwtFN3lv"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ff1703cb9eso164554137.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044626; x=1772649426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z9f0UvDhCeLLG2Ae6MEDVoFJdawK3rnfl7ggCMhQi0=;
        b=VwtFN3lv6A8OzYcJpPoMYlReyVyGIiXwj3tYOQc7yLeJ3emx5oD9c+tJj+TU2kjwx1
         nQaahPfSkXu1+rpD1fgFXYGPxDMmbH+2KfaWLfajOinGc+jEzcU/eTH7ReUFrdm9Rmk+
         olOIeFsdRKT2rTfuhenVvIgnZNQ1onLZlVmYnQJVgKb5soFk9G7gcseqfk7T/wgsq6RP
         KKGKqxOjt1ZyMnjfg/nEdulbkwn5Fe7pYiURqT708RijC1wlycZel0S8l8VJD3hiPaik
         ghBDKP/p8yt/nCS4hVaeMOGEopJ7zbXSV1aTLAIY0G3HXTtH6ijcmlEqr7J4WCHzJpgV
         67+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044626; x=1772649426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Z9f0UvDhCeLLG2Ae6MEDVoFJdawK3rnfl7ggCMhQi0=;
        b=kL8reKkYSGZszHYANsHQ1jn+JDGFTFc5EKSl7shDwlddA0jI/C5HIGwgmNIBrFlvIR
         qjo4MgNj2g3KxIjzciABxW52/7oS7mW0dqT57TOdlQHrKQ0X09f9vVJNB+7T7TRF8DgR
         UnziMa07tg6EnOFeCPEdfGCKQS2kw5LZwqGUXgbWmp75avazul5axgFO7mJM0s88E80K
         EHpeBWgjI0C27Vi2lZThPNYmVMLhO2lYvu8RdatxjoCjy1N0E9J/rN5Iu+xc9D0Rhjxq
         hkWQHGY6KQ1SXskZDVyJ9s8xSyhk1aPmA/pCjZZwt3E1IORt5ssFnFetE72xMvNvk8Qa
         YVfg==
X-Gm-Message-State: AOJu0YxMxC0U1RnVY8kgnz3aRCZC18HT1R3nZzJ9tzVbsjINNDMXv0BL
	R3qNpHaUs25JSfd4XYFd+6UqMeH/0jSIrNOl3Yr+jjEig+U8B6dvMosrFRKx4A==
X-Gm-Gg: ATEYQzxzJ/XJi4zAKy3RWg2BdkkABBgajlxoun9/EkQZcsu2Zxb3h8gm2BlX00eiT9f
	4LmvgDEy0yyML6S8La09na8leNTBzhV7XKw8X7vM82S8qaB+ixfxXd9ONz8Iqyme7sS6j+MFCxz
	mIcue+fGggc7SnMfVPUa1Dro93D1XtKBJ0J1ct5KoIZUtmMvzGx1bGNW61Buiz2A2bHjy9zLAKQ
	4q/L88TwhZDIB/+82gql5MdYAubHggnmxt93kvfrsGT6nc0KO7QvR6YezCiq0DmY60jMLGL5B98
	f8TdiER2Yy72m/wW688FIic0T4O8yCNWU/vOWVklljuhKYT0jck/fYz6mkR4z22dly0SeN0J2o3
	vjmqaAC4GNDX+rLLSQTwIcrj2/01gpSxxnD9Vqe5a8t2yYqF5P0a+dKp5NxuZtohKqg2A+P9zDX
	ZkqmXoWZXQEUNVdnwOXThhgURH7v3BlYC1Bfg4RaTCH1cXWgLo4ckF6klZNbaV
X-Received: by 2002:a05:6102:c04:b0:5ef:ac78:3c71 with SMTP id ada2fe7eead31-5feb2f03598mr5370657137.14.1772044625648;
        Wed, 25 Feb 2026 10:37:05 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.37.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:37:05 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 3/8] repo: replace get_value_fn_for_key by get_repo_info_field
Date: Wed, 25 Feb 2026 13:32:12 -0300
Message-ID: <20260225183559.79303-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the function `get_value_fn_for_key`, which returns a function that
retrieves a value for a certain repo info key. Introduce `get_repo_info_field`
instead, which returns a struct field.

This refactor makes the structure of the function print_fields more consistent
to the function print_all_fields, improving its readability.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index aa9a154cd2..c60a41ba7b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -78,14 +78,15 @@ static int repo_info_field_cmp(const void *va, const void *vb)
 	return strcmp(a->key, b->key);
 }
 
-static get_value_fn *get_value_fn_for_key(const char *key)
+static const struct field *get_repo_info_field(const char *key)
 {
 	const struct field search_key = { key, NULL };
 	const struct field *found = bsearch(&search_key, repo_info_field,
 					    ARRAY_SIZE(repo_info_field),
 					    sizeof(*found),
 					    repo_info_field_cmp);
-	return found ? found->get_value : NULL;
+
+	return found;
 }
 
 static void print_field(enum output_format format, const char *key,
@@ -113,18 +114,16 @@ static int print_fields(int argc, const char **argv,
 	struct strbuf valbuf = STRBUF_INIT;
 
 	for (int i = 0; i < argc; i++) {
-		get_value_fn *get_value;
 		const char *key = argv[i];
+		const struct field *field = get_repo_info_field(key);
 
-		get_value = get_value_fn_for_key(key);
-
-		if (!get_value) {
+		if (!field) {
 			ret = error(_("key '%s' not found"), key);
 			continue;
 		}
 
 		strbuf_reset(&valbuf);
-		get_value(repo, &valbuf);
+		field->get_value(repo, &valbuf);
 		print_field(format, key, valbuf.buf);
 	}
 
-- 
2.50.1 (Apple Git-155)

