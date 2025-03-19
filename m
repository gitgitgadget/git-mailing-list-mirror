Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF21991CD
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369110; cv=none; b=d1qWUtTnhSBmux5aPmnuu3BHoZXavS8bcKzgX22qS+erevl3OjIg9suJPmHSODhBWvy76B7qlLJvnBhFts2SK7S8SRxj3oT8Zk3KpLizgN8cEpwDKoWJ44wLMJwqbF8QUMiL2hN6Mxs8O+WbBEoQWQp+FgOQkZeXh1PWhfzWcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369110; c=relaxed/simple;
	bh=ZN4Fc891vezb4fHhCtGKxW+ds1kQv9SdD+KI7ux0BRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiGw5xCwFCj/6xCcm7ltrpC0vdtGZrqZ29ZcPJ8k3C5X/VkGI9DBkaSt3f4M0nDTTVCrqH6TQMmEd8Xfg1jKJQHE2XeuxxRYE2JKxmhfL+dfLL3ljnCot2KEWhaDT4HOXudb93kT0aCxGWs3r38IdXT4zAtsETHf+ezftZMvAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMK09jq3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMK09jq3"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bf1d48843so61769841fa.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369106; x=1742973906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9GI9SBf3YemZmUeOSNpHs+f1KiT1YsnXerp+OInJ0E=;
        b=TMK09jq3eoIvF3jcMAEdWAZwkVbeoG50Tv5x7SlndKCuMtgQP+6C8fbNwviZpij0Ri
         bH8dRijaPN9XcRYJIOKMD7zSnLXthmt54DZsrXyOBAxKANRFj9mhpNNK0lV/v09U3tqf
         PsEI5N2fozfBUkOV4xJxde6q9k+RpCTPRLoxqNR/RqoDSwYqkj9SLz6iOuzXFMM+ruus
         kUQAPfjSyfYuhKUP05LSJOhE07aFUosIMUWw4QGRay4UqeAtteacHEMd7YXNxe3a32mc
         3qNFiyHQnKsE+W5mJsH1KYUUJPCTMAHMqL+ZBx/1AcBf2AE1bNJqqcnOCG511Pg9avRW
         h/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369106; x=1742973906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9GI9SBf3YemZmUeOSNpHs+f1KiT1YsnXerp+OInJ0E=;
        b=DVJFUJJV9n8WRwg31aVLuV6+RpwEfN8SDkCg058p44ivrnPKp5uX6Mh5ASuCh/OgLv
         ZJ2wFAQ/xJVrSMtBMPtYTyeRISaMRXzuajvC35a4h6DIJF115gFjiauVkbJHgS5goYgL
         7nE8eSh5wLGyLY2Hek8KD2HDVrtrlotBhW20m0XG98hZnUymmti3kbvIx9qe2uBq3UPA
         hxrVYOZZAE9//CIcuzLEO7RUpdOiNFyspQeRX7YxSEG9rRrXwQFXd70RX6gqn0qcNt8P
         8dwaAEA0RbUq+ajwEVNwDK0HVRpZ3HKd0+aEGnUtBFaUl9KPgIgppxBu/rT54/c/te2F
         1M2Q==
X-Gm-Message-State: AOJu0YwB0D6IDriKYsWSMjcO/7tWxfJ35lx4KvcY7t1GI45M7EUdWtR7
	7Y1UkBUgi4IdGcW+thxBOMRVBADqZLbJxM/jdD+igQkzZDWuQfy2dHe2vA==
X-Gm-Gg: ASbGncsbwEdP/eF4GuomK7jurRZzTfIdY8Puy1xJ7j/UVzIM/sC4QKgQHzpelghLqOX
	XGD1em8sG/HdxzrAHg+XlvIHRfTN5Vn2zZ6eeckOwZTAAytSDQT0z7umEha+6GVKyXX6PF6dnYx
	rUUOkYBZ00wh+WudDZFPcudFNowaqYfM9R5voUBYKh479njo/UqLctcpCuVh1y8Trq7zEPsy1yY
	BGuqRVCyZ4M1srxjN1sm0/ezd1SDRznZ9Nq/eh/D/sJ6R0QCgjiwep87lDo8rRL86dnx8huZCTI
	RjCzTpUUXeZCNcjKo3RlemvQAEVI6f///or79robR4dg8u19d3w0CIddPV0F9Q==
X-Google-Smtp-Source: AGHT+IFyRtvUr3fGUNcDUM+jPIVCOo0SGY6BzhzlcT1ogwPwlB40n/qC1bd4IXLRe6XTd6Rd/cKlcQ==
X-Received: by 2002:a05:651c:2313:b0:30b:cd41:89c7 with SMTP id 38308e7fff4ca-30d6a3fa027mr6233861fa.22.1742369105900;
        Wed, 19 Mar 2025 00:25:05 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.25.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:25:04 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 1/8] pretty: tighten function signature to not take `void *`
Date: Wed, 19 Mar 2025 08:23:34 +0100
Message-ID: <192fc78dd869f28cb6ae91f3a26a05eb6b6a4bbf.1742367347.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec
In-Reply-To: <cover.1742367347.git.martin.agren@gmail.com>
References: <cover.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We take a `void *` and immediately cast it. Both callers already have
this pointer as the right type, so tighten the interface and stop
casting.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pretty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0bc8ad8a9a..a4e5fc5c50 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1437,9 +1437,8 @@ static void free_decoration_options(const struct decoration_options *opts)
 
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
-				void *context)
+				struct format_commit_context *c)
 {
-	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
 	struct commit_list *p;
-- 
2.49.0.472.ge94155a9ec

