Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D8142915
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054908; cv=none; b=fYti2JOfdQJQKZwdZUw2fiRWmHYr99qNOC0MCvRwAjMYQHUVI05bnY/ShSM27yF/nudt2VEULhYnr9mP/LFjc7Q7m8ctI1t51HQIXpWtJBOujbGXkNqx1uMdxuBWHmlhWlSlXIYp5CKAEQKZBn166VC4fUXVWFxzBKDUIDaAX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054908; c=relaxed/simple;
	bh=sY/a2lB+pTHNyT+ewo0Gd08rVrB/lccEpzDLhyNBoOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DIy1G7Nzqgb/iN+FxvdfHVCDFvxWA0rdHCBMA0wO3Rql3VExC5Qlw49OIMXDHbsdYe8tpTgR3b/VB5mkDFeJeye5/v63s7heVUwmtNKRb7d18ciZQSR+CAiPAHNy9khTeFxH7GWQwF42BYTKpMdgIioh/I2Rmojx/L9zGFWiUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zxky6WxV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zxky6WxV"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66619cb2d3eso2953387b3.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723054905; x=1723659705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hKnSfTd9nkbmSeMIrIDIRJtybACw09d26hyfkET1DI=;
        b=Zxky6WxVcm9Azl08Te1iLpqCW6G/R7HdUqlz/NeISn9C78wKdJbmcFYbRRhnbWIE/T
         gw6NcoVkUOIHdx/17s1SqmS0lSybP59LprZE0ju5yIJeHzuuj7XdcVLysqmeILaKKXud
         bzeJvFVU2e4RqOF3AuVFG0aGMPEH4EBwVjdln+ZwaoKWxvTzvdE3Uz/zY8JsvkjH2zrv
         PDqEe58W6EnmEaEwmHYB7RDddGsSrmcQpCOiJIl8dDYYJN54+TfQ0XnY8cNdLOvNHrhk
         p3YKJAY1crjAGKl7BbywvyX1vpPzs3nMRn8nUHNRzTletT7+xZlfApE3L+ds3H2oU8jK
         gJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054905; x=1723659705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hKnSfTd9nkbmSeMIrIDIRJtybACw09d26hyfkET1DI=;
        b=bpVnJM+1KJju+DysSkqSXcP3ig8ampa7SNUDYgUro9jJCCzpsxVWGQ9fSd89uRSRLE
         H6pqXUoUmZ+sjgRShN0UkaSytimsFhM7vmfTOeEVurokzx7uIM5hvsVgaa1t4DqAN5zP
         er0mZLEGnN1QqH6NdLukmhxm3sTMRJxGnYk0tmiR53EnDaD+P5KKR3hgt8ok8yEehrox
         0mrBZZ6p4BxxfLskqzy5eftbDoKMoPmLKcTUNGm8OavGbqYk44ZoofEm6ClDoAD4S8Vo
         koVGWpoJmqQpSDO3qW6M47O0SqmumwrF59/4pPy2rvUwFI2j+SFhSZ8QFzEvcJhVJkxX
         PeWg==
X-Gm-Message-State: AOJu0YxYFKcAAnFwfgma4sVBWlIZ84CMjzQKDVAbMy/i33kS4312yVHJ
	qtUn4fT7KXi1beHRYncIJ2ATMgwAMeXcvzjBL6lf9W7EX/YMkrFUDp6gfh5H2XdpVTYL8dPc+Ki
	UTjB6DiYzUyu4urFDE5z5loU8VXiSB8NMJPAGlj7LGohUXywoXWY3mGAWNUOmqNeZ0X6Tsx4UaL
	b+Ml0Y8LtivyQMDQEKB79bKfXkJVD2feiElM1dnAk=
X-Google-Smtp-Source: AGHT+IEdWtQzock56n6ERxexdAw1Ifhy/OkYRNjr7DudFEsP8SpcktPpszna47/4hCxeBwAkV4vyhHDqsspdLA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
 (user=steadmon job=sendgmr) by 2002:a05:6902:2b02:b0:e03:5b06:6db2 with SMTP
 id 3f1490d57ef6-e0bde2efa5emr34260276.3.1723054904363; Wed, 07 Aug 2024
 11:21:44 -0700 (PDT)
Date: Wed,  7 Aug 2024 11:21:30 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <c8befb680e938cff5c89af82a12dbf8406f9e917.1723054623.git.steadmon@google.com>
Subject: [RFC PATCH 5/6] config: add git_configset_alloc
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

Add git_configset_alloc so that non-C external consumers can use
configset functions without redefining config_set.

Co-authored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 config.c | 5 +++++
 config.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/config.c b/config.c
index 6421894614..fcfe7fcf46 100644
--- a/config.c
+++ b/config.c
@@ -2324,6 +2324,11 @@ static int config_set_element_cmp(const void *cmp_data UNUSED,
 	return strcmp(e1->key, e2->key);
 }
 
+struct config_set *git_configset_alloc(void)
+{
+	return xmalloc(sizeof(struct config_set));
+}
+
 void git_configset_init(struct config_set *set)
 {
 	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
diff --git a/config.h b/config.h
index 54b47dec9e..abb4415b80 100644
--- a/config.h
+++ b/config.h
@@ -472,6 +472,11 @@ struct config_set {
 	struct configset_list list;
 };
 
+/**
+ * Alloc a config_set
+ */
+struct config_set *git_configset_alloc(void);
+
 /**
  * Initializes the config_set `cs`.
  */
-- 
2.46.0.rc2.264.g509ed76dc8-goog

