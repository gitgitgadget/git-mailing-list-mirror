Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD013A5E8B
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562793; cv=none; b=KcpnDdFNTQmWcDQERUXifSg9Scat05F3/IwXGa28SjQBKagQg2QnqVXrrfhz8EvThqw+/oTlkeQF/PEa4r+n4MTa1VFHGEEz5K1Xp3Qssj1ftpYLnQBpQJadGLBhnTJjvfG1QSfOEboKjeYP2LIhLy2cuTFIHCtOLel4xrNwtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562793; c=relaxed/simple;
	bh=f76t/2Vq3kOIcyXPbd5oE3hWAs+7d1ip78MeEViGWfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsUgNRqlYNRmNW6LT/jwZ+nDaC9p1kF/NMZRMxTu2ivbBARitKwbMIYrz28f0qfwBI9zXknIw0XsokpcmXuQJLJoVZ75vRO0bliJI2BlYs2UMVf3+Ag6sVxJ//arBqd24e5dV6QysKxo2Rq7XZOUhUrrf0RY6unNQ4kDSOoQipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJrCWYcK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJrCWYcK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso28977155e9.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562789; x=1776167589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHRYY933WTubcI2g34cvndNJ/y2KZrJa6C1zbFPnBbM=;
        b=FJrCWYcKa/XLfYrD84d76TQ+R7K5vJknQRqokJ1ZvpQVxi9vQRyGpEXvlhI364Dj0c
         qwwgI1cd0bYiAzVw1WoPJh6KkiVnDEUCyPW9FYMIScJ0jtN8WVCl6Z0qZNK5H5pU7o0i
         T6Z2eoNHHBY9UfyLEM3OUpNHqNVr3l7QYxQFEd/sLOUWE8Cf3TFvSDGd6OBpggNi8EWz
         gFiSLIQ1/sEZjXIDyVHrjX2K538z69bF1xWCEDlIQDccAfe6bn2rQgrPWF+SmRHzVSnn
         x9TH7bU2bkWaIL3YvVJBvBOoeMjWcURjINO5EMWXt9J8ViJBDPhdxYxixqW71fnx5zPY
         rtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562789; x=1776167589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHRYY933WTubcI2g34cvndNJ/y2KZrJa6C1zbFPnBbM=;
        b=mLbLC+DJezoK3EJ7M2aocV6xN9TVXKPFc25IDmtcmHPHFjJ6C2RgMgBWZItbqUnGcf
         YGOQ6xjyBq8BVnPXbjbnSph45lS6kx2u3nKbHiNHLdt5bhJMY5lu8/R30/oUqpDgadkm
         GITGeCak5BbG6JuUDowkp5bhbuEehy84AW0LGM81lRcQd75QScveeCH/9aZsn/g0fL1q
         5hAWOjWdpK81F97DqeQ96TsyEzMTwkwcje11hWU00q6/OlK26Qkhi9BirsBeJT/CKrYK
         Vp62/ThLPwyA9wcY8wA0+DYBRgGAKlBZwHPOOZCnxKYcQcpZISNNc/iYG+eTU1nsbzPw
         J6dA==
X-Gm-Message-State: AOJu0YwLVMWpj2HdRqEZE0fpR7/iuCfk5ItlAPfK0TT0D/vulz5U/gRk
	ELnuaSVx5zRHQieW22HjTU4lWGnaIQ78DyyXw3IfkJfgM+ZjttMI9xjctWzF+w==
X-Gm-Gg: AeBDiev6WXuXkUxArPAPDUzgXnEOafTf7/s4mAUesRggW3jqGAyTlfq24FW/wrAFwui
	ATz5BCy1kWSc0NpyHpFCVTfN12gQ8+fVxMP4wggIe0JfrkoaibIR2CKrJU0NZQ1ZVWVIANedoEr
	wwesDrdG1ltcjIALg/joV1IbLdpr6Sf5ewoBWJ5uZY2Kb88SRVaPxj07FFD9jIf6InefYVcaRly
	bwI0ZI/Rql9hg45vCXQoAab5MppXWyH/nB6TA2oaBbn+viAtOh+SKS7MbFCk7OnRg65docqDoc8
	T0cnZifKb6iMJaaRo+Pvqhr/fY2QNaJrsfvlJZ15DPuDSIbFyXUro7u/6O6PPv8bfUYPsU07m7l
	Og20wQh7rPKVGSv+hxp13EiuS/bEI1BqRewM+TjahkFm4EaZrGQs6I6UKGKX86Opa1AdjKBy+0J
	QK2SWrSxFLgWvVC0NpAvk67Z9RCmqxLaIDWjHxftx+R5YLfWc+/E14tRFKeBvSPYPAG0t1331TD
	04/luK4G+HBQUBsfdol6O+PSOGowgTCozOLVsk=
X-Received: by 2002:a05:600c:8b52:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-4889978140bmr258368095e9.18.1775562789490;
        Tue, 07 Apr 2026 04:53:09 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:08 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 07/10] promisor-remote: refactor accept_from_server()
Date: Tue,  7 Apr 2026 13:52:40 +0200
Message-ID: <20260407115243.358642-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In future commits, we are going to add more logic to
filter_promisor_remote() which is already doing a lot of things.

Let's alleviate that by moving the logic that checks and validates the
value of the `promisor.acceptFromServer` config variable into its own
accept_from_server() helper function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index d60518f19c..8d80ef6040 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -862,20 +862,12 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
 	return reload_config;
 }
 
-static void filter_promisor_remote(struct repository *repo,
-				   struct strvec *accepted,
-				   const char *info)
+static enum accept_promisor accept_from_server(struct repository *repo)
 {
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
-	struct string_list config_info = STRING_LIST_INIT_NODUP;
-	struct string_list remote_info = STRING_LIST_INIT_DUP;
-	struct store_info *store_info = NULL;
-	struct string_list_item *item;
-	bool reload_config = false;
-	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
 
-	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
+	if (!repo_config_get_string_tmp(repo, "promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
 		else if (!strcasecmp("KnownUrl", accept_str))
@@ -889,6 +881,21 @@ static void filter_promisor_remote(struct repository *repo,
 				accept_str, "promisor.acceptfromserver");
 	}
 
+	return accept;
+}
+
+static void filter_promisor_remote(struct repository *repo,
+				   struct strvec *accepted,
+				   const char *info)
+{
+	struct string_list config_info = STRING_LIST_INIT_NODUP;
+	struct string_list remote_info = STRING_LIST_INIT_DUP;
+	struct store_info *store_info = NULL;
+	struct string_list_item *item;
+	bool reload_config = false;
+	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
+	enum accept_promisor accept = accept_from_server(repo);
+
 	if (accept == ACCEPT_NONE)
 		return;
 
-- 
2.54.0.rc0.114.g05d466edb8

