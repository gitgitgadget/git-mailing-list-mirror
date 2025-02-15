Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3AEB672
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634704; cv=none; b=qm3tNTdKuh5Vb7QSZlATVoa7uKkV7PMCrHuVsFZULWjoOAIGyIc0GR/WEFbNMmbPSLaiogxivXnNOmkXb4vGxd9VjofA7bjANSg7dYYDnMTo0WJiKwsnwdf0v0QGHol7l4U0i491RSVF2XgvcXecAQWZGPVt5ZQYJnRur6rGBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634704; c=relaxed/simple;
	bh=fB80ASbecHtp4fGMlEVSHuxVoWUEiTfhiT/c1rpUQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2RhgkNwer3eLO3B/uXsVz2rG8jfUL0kmbqSkSrjCdt5dLXYSrQQBhiMWtKLehrS/9JmntP/LeiexQd2dJoUe0OTqnk8zhC8HDuqu483mwwkw4P8SgX44BJ5AevXQkZpZnuQb1kPnLO32EO0BJebOiya/JIMg2kDHjjBk+0nyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+fKuThb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+fKuThb"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2210d92292eso9572705ad.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 07:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739634701; x=1740239501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUev6MBsFEBj9LcEfo26+7FRqWVh8ngUTgpXCvWBZ7M=;
        b=N+fKuThbyTICzXBQZ0tWbbZ0MxVXrgzDwsXmWTifvW/6YcJOIRTQfC+ruC+CFvKlV9
         kE5T/c5edFQPFW3bREyHhEX0UwObT4FzGUMzhLXoHJZ+tJiFFkw/ucxbFQABqEwXn2Az
         rpHKGceSrc3iDRjAIyAisUSVx4ppZ6D3l2HjkVlS3Rk9ytCeIca8Greg8VwERDq2lpB6
         yhkhfTORZsGRLaAS195hMk51YRa13l4KPd7DZIe2UXWnNydrsxum9f7W6kZvAgIzcb5z
         TggxPH+wmDxY6xHvc/cst0VsL/qt7c0me0Q9rNk0uQgomaRxFtb5cTtG3Vzi8wGzPcMl
         ckPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739634701; x=1740239501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUev6MBsFEBj9LcEfo26+7FRqWVh8ngUTgpXCvWBZ7M=;
        b=G+vkkTD0CJ1ezOGtRzx1mELhO0jgXfSL1Fx2d+/yaOrfB1EWiRvOd7wIX3IJg3vZJg
         0/gW8ho1UMp8jCX7EcAkU3AFomRS+y8ExdRJAUStzsTHjeblG0dLbdwvPbdQBHafpOY4
         sMijjKch1hcE8SxxQjZj2gfCZR635GycYoH1CJztvizsDKaLaV+XYOyMwwdA+htmh86C
         OT7dmN2zeliNpUyC1PKHcYtswNKrl4VGwzPV8mR8yRM8OAut0SFb6ijtVqmUBHTjP0Zg
         H0fhBaRg6onyLcj1ri+E3VezYau7TPEwCNG0VwO3cBmcXmPfNSyAQZMW/y9Mm6Xs623o
         dOPg==
X-Forwarded-Encrypted: i=1; AJvYcCU0kF3RCMSZvjNwU+8pcp+LICOX1gN954wzTOXSPePMQmvprJVOGJN2doQ/uVFEQsoiXu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBJaorAt/mW0Xhh/Bq60Iu9J6MM2sNJ8aOgKQMlc1w+VzEZBi
	7KkM87x+jqhQBHn1CKQR38miZzCpGHOUIa8EkI8IRVK/R3PoEOmNpEH3gx4t
X-Gm-Gg: ASbGncsXr2jt0GlOzvMQZgalA5ApH9iXHG7cqtwIdm4e9VSGtVFConwXZQ4yksxQE3T
	IZeiDhNE8ZSxxrM9BFKwaEgktwgcSPbL+fhkrnZeM24H53NJCpUttS7n5BDpTVsKlawPDFTA9Uw
	87c0DEb2UjnAEWqFXHPOEdMf8LPJ7LZ0gmcjKiI0WyEfxSwKKIwAZalVFEavXx78Krk7JhiyOKS
	P5lPmqYYwuhGfq+cBNmLZs6xBZ2lA1AAbQf6QOvaS0iv+rWZcaBVi7Q9YDK87KMCDUWa3oiEYD9
	+j018yIjaH05aKJX3CF7vurxpu8A8eXNwaOINYVr
X-Google-Smtp-Source: AGHT+IGthXiP+iEMxSwjr/OaiNpvMIrlwNHl7Oxh2zjY5rsHZqtaftAV1JoTb0+SUagToJEFoiXWEQ==
X-Received: by 2002:a17:902:f54e:b0:220:d1c3:24d1 with SMTP id d9443c01a7336-221040d69d0mr57076955ad.46.1739634700832;
        Sat, 15 Feb 2025 07:51:40 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559089asm45024285ad.241.2025.02.15.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:51:40 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 1/6] version: replace manual ASCII checks with isprint() for clarity
Date: Sat, 15 Feb 2025 21:20:47 +0530
Message-ID: <20250215155130.1756934-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
References: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
 <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the isprint() function checks for printable characters, let's
replace the existing hardcoded ASCII checks with it. However, since
the original checks also handled spaces, we need to account for spaces
explicitly in the new check.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 version.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/version.c b/version.c
index 4d763ab48d..6cfbb8ca56 100644
--- a/version.c
+++ b/version.c
@@ -2,6 +2,7 @@
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
+#include "sane-ctype.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -29,7 +30,7 @@ const char *git_user_agent_sanitized(void)
 		strbuf_addstr(&buf, git_user_agent());
 		strbuf_trim(&buf);
 		for (size_t i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
+			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
 				buf.buf[i] = '.';
 		}
 		agent = buf.buf;
-- 
2.48.1

