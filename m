Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADC148827
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418814; cv=none; b=fm45OsSZ7Hq9vX4omuglAyaB2kvpv/+SaHET6c57smSTnRIQ57IKsKdHastq40pt5VQ48FUuwm9iSQ8npE1frjog3Q9crsmnKnX14sugWNoBEpdXdHuEIoq8VcWHtZMUP75e0I/vnZZJnxehom6oO5ACB2FLHPNgkrpqq7HVdMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418814; c=relaxed/simple;
	bh=e0mb0N/zjmaUTuXmxe7PVtWVhZHZ9wYsoTV85WZQGLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQZeV1+cgBzTSPTafw6w/+GpNhhludTjvk5/wFOC5yK5+0g/16nytZNK0Qv2YhPGo45lpggZg+H6nb6+7WEf2sWsJV8KQ0KZ5pfSMgJE5yUDhQ/bZsDfO9H4PVB+igJyygB1iU2CPVz53wVhm+igVMQy01olORN2Nbdg6LCAYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DECCTMiQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DECCTMiQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23636167afeso37075085ad.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418812; x=1752023612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDGzChazuW+VVq0iMY9fdRm0OYBcHte33LLOMQNzMdk=;
        b=DECCTMiQU2tskPVnz86Y9Q8+EUpyhIgDkHPw2evqBllxLLa0QpgrranQjqPbZCadua
         d/JHCt4vAZvXGSRjJHnTBG5oFKaap5UKf6qd7BQkKtb1S6qrD+DlESkCO+7d4ywm6jWH
         2JVrkMiGGk3ZzuNcyPNOFCY5gsLH5fhuG8icUS1q0WI9oYhRTqelNCV6p6Tgdx0MXd9s
         kqk94wyI3S8jf3QCGCOrs26qe3a5yE/ktc2P9nWNnGxonLYulow1Y0lvWMWtXKC90Mtj
         wbvS8AzkMQqtLBC/89LpsDQ+THkh3l3kr55v7hxxIKR7sff6mpV8QItEHc2qnK9zdcVr
         XNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418812; x=1752023612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDGzChazuW+VVq0iMY9fdRm0OYBcHte33LLOMQNzMdk=;
        b=GEfwaftIXoQAP/JsSb4n+CDeGz4zg7oj4QsoU3ls2aF2h8093tipkDqT9GJBirttT1
         s1mYNEjSkEukgR+71gE/gguRVY78cfl7v1VULo355qleO8wpTv+klKbJHBV059+pG589
         Eux+om3HVDC6DUGj896xwc+8HI8cj16I0t34lvCeGsglrr4aHKj80yfeeOq1Mwf8rkzD
         imP7rbwZCUgLQ9EmYOkv0n2qtlSYmlovqzLX7xGDbegUgf6U3ouuspKe9eUWXgcR7Jwj
         nAnVXQlN0jam/9bfFhze7s6qMm6YJb/yPiRAyTq7b3bvgs3bCsaXi14dZXzttDzcCu1V
         W3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5awibVilnD0fgvv3zNc4ZpWmrOS6m2uO48qBj1rCblAA7OYpzI9nNIAkQY7naFVx4co8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKvXzxgEL8PlAMHmqwqISxK3YxPEcCFVIylNxl7O8192wHqiK
	iMEu85ZNwRTnEUAbR9RInnbkGHvquTcec3Lbwa2swBmNxNlbzCd0a+Bn
X-Gm-Gg: ASbGncsaA2ZofVhvQpd9WKHq9CuLGzk+Cch6zImXE5o6YP6elqhUxUv7wIoG3Jjn54E
	C3cv5UX3FzJ2txsjtZCuvPWoBPm8F6wEUA1HFwSvlbWtVkCSAlNL33KYy60ROCnAv8ex2ckz8xv
	rAI17/KveLLYNerqqoGO6GXDL0ALznTwFDv09Zhgwnr9O2uXCGKhaNyQX0UI1vUSsuUXVhFob8w
	jgSRx6CPiBujgFYC71FxQjIVF1NERUP5KwVYlTQ7th96+GbAfkCDsr3Glj3VRwXT1YbkPIeEzhC
	4khDLlfUutebOQE2nw/sVsuVg9JMMAmEomoR5w7ov2sY/BG17YCRKJM0tuU=
X-Google-Smtp-Source: AGHT+IFIqk8Jwc/iNBwUvtbrpFSbpBJHOH4d+ONi4dr6rkmVy5mpLxUBNDL4daiC0GkA82QlQJI8EA==
X-Received: by 2002:a17:902:ce01:b0:235:60e:3704 with SMTP id d9443c01a7336-23c6e4ffca4mr16045745ad.12.1751418811796;
        Tue, 01 Jul 2025 18:13:31 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3af74fsm123208125ad.148.2025.07.01.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:13:31 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v4 2/3] refs: remove old refs_warn_dangling_symref
Date: Tue,  1 Jul 2025 18:12:14 -0700
Message-ID: <20250702011214.2835529-4-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.149.g1bab277d62
In-Reply-To: <20250702011214.2835529-2-phil.hord@gmail.com>
References: <20250702011214.2835529-2-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

The dangling warning function that takes a single ref to search for
is no longer used.  Remove it.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 refs.c | 17 +----------------
 refs.h |  2 --
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 651fb2d41299..07197c239e33 100644
--- a/refs.c
+++ b/refs.c
@@ -438,7 +438,6 @@ static int for_each_filter_refs(const char *refname, const char *referent,
 struct warn_if_dangling_data {
 	struct ref_store *refs;
 	FILE *fp;
-	const char *refname;
 	const struct string_list *refnames;
 	const char *msg_fmt;
 };
@@ -455,9 +454,7 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 
 	resolves_to = refs_resolve_ref_unsafe(d->refs, refname, 0, NULL, NULL);
 	if (!resolves_to
-	    || (d->refname
-		? strcmp(resolves_to, d->refname)
-		: !string_list_has_string(d->refnames, resolves_to))) {
+	    || !string_list_has_string(d->refnames, resolves_to)) {
 		return 0;
 	}
 
@@ -466,18 +463,6 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 	return 0;
 }
 
-void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
-			       const char *msg_fmt, const char *refname)
-{
-	struct warn_if_dangling_data data = {
-		.refs = refs,
-		.fp = fp,
-		.refname = refname,
-		.msg_fmt = msg_fmt,
-	};
-	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
-}
-
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 				const char *msg_fmt, const struct string_list *refnames)
 {
diff --git a/refs.h b/refs.h
index 46a6008e07f2..07f21824d480 100644
--- a/refs.h
+++ b/refs.h
@@ -452,8 +452,6 @@ static inline const char *has_glob_specials(const char *pattern)
 	return strpbrk(pattern, "?*[");
 }
 
-void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
-			       const char *msg_fmt, const char *refname);
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 				const char *msg_fmt, const struct string_list *refnames);
 
-- 
2.50.0.149.g1bab277d62

