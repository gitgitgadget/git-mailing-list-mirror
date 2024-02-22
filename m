Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990215699B
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624258; cv=none; b=HEuJ2cO13TMFgo4A8j8zjsN6/Wl26mhsnXXsIJnG5ENV+3BTIsPnnkPkh8e7aF2CyW3EbmVvnMJHuQAacb6QT1irVT5Qq82G6syjZ3jix8r43+UCPHbNrUWYhwcuixH7yJpqrcmRrKll3O0AsvzL+Q59fKLhuTDoGhJFE+qgSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624258; c=relaxed/simple;
	bh=IGK2J09KwOcR3j0euRR2qmy7KO+Y30PMzKJiHH1rYKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fwG8EFVJz/d5nDVZ4VeTrM1WzN4/TM6iETD+9boWsCCceWmW/0ifwRwH/nRreeoF+p9CcZje/HRDvTFDRAS+QrJz5cDustTzAtFozkqhHVDHPjG6LGWYXXQ0AY3bQDn46JYrTP8QZS3FlSvK3h6edlpD5aUtM9SijHyJ6zzUD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4nURy+I; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4nURy+I"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso2665187276.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708624255; x=1709229055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5t49plORErTEVRKSRx3LM93zvsNzgmw/bsy9yiHOVwk=;
        b=y4nURy+I9M35bCPY9dLW8KUVOVyop5hVzFHeDyRfFkn9rJxMP4YMi3Frfwxlh8poLl
         ft8AtG+3eacEhfzWOhUyzSEnUK5IhkUE9fYcuZu1yNMq2Uzt1fHmrQwj/iBUXLwBYh03
         jDF89fd33iNGwQ/1OKHBXOXSWC8gl4SpK/uKv4+x9FrRijl4K8yi1ddh2MuhSVRPGfqx
         4FDmj8DaFTr/t3AYl5AhPgyZWXtInbj1C/5nRnKffgnLo7bZCjwoX6TqIfrryrFbR+Tu
         ChLjneHN1fjK84sOwVRl2lrIjEPh/O4lov5cAGIHHQQOeUDzwMuNeR1fViVwaBckovPx
         zQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624255; x=1709229055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5t49plORErTEVRKSRx3LM93zvsNzgmw/bsy9yiHOVwk=;
        b=m8mWPxnJYzeZmoIZw32i166mGkYsG4p0b7kxtZ3q8zJCOK66ZagReuXzeF2hrRQqGe
         xkCy9P0iSaeyGPzCZFNo/IZwFkKS6uQXAi4joMM7pkkl2SJ775yYlLLO9phNSM+o6X8x
         BxaORU7hqRGhZ50ecAGFpZKVTFb6R870u8nP/6vX0rr5OfmEZQE9XivShA1Puk0SrFSd
         RbXJWhltFQq4iVQEXCoqTAxeYZ0KUXnAsf6krmFUQ45linbuBehV2byjXBMgHph68Lts
         YZqrmVzd4tgIGQMX9Sj7AWhY7qqBeWsyPajGdpvWCeBC9yoGemMuROUl4TLNbufHTzRQ
         /JAA==
X-Gm-Message-State: AOJu0YxvRUTjl8j2u6JXmxmrALLsM/3Hptq7zj/hl29TAe3Kn9j4+XuT
	BfXZyj4iAza8SAqqehAnukCKlmuqaNsM7kUgjk001QVohYYpKKmLms5fo1YG9Y+wHXqtX4TCTbT
	t8Evkik47XP2aDYDJb0aQ9/nSttiyA9GL5gkRSXFXHKABPKSrs1KajP55kdewkFvV5HS3E7E9/0
	pcKZrR0KuRRQMfN6NA9CcOVA6afoUkgqqNcOMDCKUgdiq2
X-Google-Smtp-Source: AGHT+IFYs6wU92ByPLqf2u8KLfdJjsRyn5g9ccKV50/JVXrvkQHXIU2L1ndBv3KjpK2T0ymPkYhlYerPVh0Q2Gs=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:1891:b0:dc6:e20f:80cb with SMTP
 id cj17-20020a056902189100b00dc6e20f80cbmr165495ybb.3.1708624255439; Thu, 22
 Feb 2024 09:50:55 -0800 (PST)
Date: Thu, 22 Feb 2024 17:50:31 +0000
In-Reply-To: <cover.1696021277.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222175033.1489723-2-calvinwan@google.com>
Subject: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, Calvin Wan <calvinwan@google.com>, 
	phillip.wood123@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

From: Jonathan Tan <jonathantanmy@google.com>

pager.h uses uintmax_t but does not include stdint.h. Therefore, add
this include statement.

This was discovered when writing a stub pager.c file.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 pager.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pager.h b/pager.h
index b77433026d..015bca95e3 100644
--- a/pager.h
+++ b/pager.h
@@ -1,6 +1,8 @@
 #ifndef PAGER_H
 #define PAGER_H
 
+#include <stdint.h>
+
 struct child_process;
 
 const char *git_pager(int stdout_is_tty);
-- 
2.44.0.rc0.258.g7320e95886-goog

