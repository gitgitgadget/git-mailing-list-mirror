Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A437E2E2
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218225; cv=none; b=YS2/ch0J7Yu3q4Jx6MnVNyg+IzRbLyDUsoWTMQ80vjTwprf854k/zo0yOIPkMsMnIw/tACeCGk0BtlAg+AJLo7kvzFKpsGA9F+A8ufa+iCZkdsLr6glBgIO6nLEEJ9NZZYTVFoXuFQLlYejl/6ZM4O74axsvNm9hRsX2O66wzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218225; c=relaxed/simple;
	bh=I+8Kd3URrtigFcHycvmzgpzdAWoxJBf59Qrb7TvbbHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAJG8929j+zdfSuOHGGG6TT46iVnywCUzaOSKFbNe0FcU8angutBS5uGR5KWRGf/CvqhjucYaJdPGEbhdyl0K3aUadFN/MaHnxE8fvwZawggB//uey1ngY8FD/8kyy5FjsSZgxInwiJP70XRTmEYpoDpxQ4orbOLjvZII50hckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM0NYAEy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM0NYAEy"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82ce09b61beso863544b3a.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775218223; x=1775823023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=MM0NYAEyu6uZDkvFnf8jp5PN61wiRAa3zUbHI91NdcSZsD5rueHcFCjSN1IzdSlW1+
         sLVzexSNET62ueaUazc/s6cyViiqUITYcPW1kpnIEb0maipOfu8k+DCkRocmmEYxWm4Z
         sFlYHhAGZJXVuMqCrdMM74P/icHsyFDggJduCU/h+gybYc4twz9kPKKueA7JqT1WWmBG
         H2O1ZpJ+QadV6wlgFrHOJxz13gGYfy+KuiA/Mqi/sD05+UHXCqL4tQMpIRM2Uzu4yAxK
         mii+qZDMZ2IXrMFVchU8BoFg829vewWjSIHjcjw9KCUvEwT/Ljrmze1j0KMQxb60oNsz
         p89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218223; x=1775823023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=WT9DsBG5fkwGuTIVvqzZ+/yN0bbF928No9TPeUWiJ0eicbo9zZ6eUqYnB8y+J9RR9h
         InWtsOf7jgE5QzCYE/zBx3no8HBgb1/UoanGgc5gqVsIS/xqYoilD/jitz9D1MFmE7uv
         Jy8lA4WpmmAqc7Pt06Pph4zII3+3tm0rjgvHn3bq6emtWBK2Kgs2uEGO2t6K+SANSHpx
         aIrnnEQAG4/gYoFu7TXWj2A25gWj0DhJMZMTMurbLWlXCh8bIRf+LYVhbk8CuoQyUG7c
         QH4tVhOWbiflUurTJyCHTrGf0p7VJp2KAdxmbBz9VuXKJOTLwUS3pNj4GxO8l8LDDKIH
         eFTg==
X-Gm-Message-State: AOJu0Yx4XcZQgp7PbVvPgg9da+s3RCC0cDVB/lryixc2p1dNkZtK2h+b
	dG0s/HoKJp4nJLQ+z3xFvLZOAS9GdnKUtT8xZMCvZGulsPPTAeDvus1w7KJkmg==
X-Gm-Gg: AeBDieu5d23jO+DpE10ESct2ceWaespbgofGBtDsCUvvZltmmCPi1l4bR+5s1crn+sF
	a/7dvZmxqfZ5KrQnNMYR6mGL5c6VZVoWkcCczWxgqopFqu+9EfmiNpQn8HKW3GSlWhhkMAxHl5s
	B++Fu2hKrwqw+Eqs6nmSIZtEpdr4Uirjz6XvBZNPgnD4RP4oPGpP9s1wCgX5Eac/Auxrw/y/qig
	vwLSIQ6WBdRUtDSBv2/QAa0ayq2Qb8YkS0Zj6vAu29Fqci32NszF4gwlI16EDI4wsjicgfT9Mtz
	cZSxRIQhUGhhdER4bP+GIw17snxDdDf5KbKE5Y5dIDVRL+17gfnt2Ls/V6bePCuMDy6OrOXYLaA
	4dZ/017v0AYmRbvfIitJ0O9PFd0ovAPUq8WFYmMGPkTOr03IKHW0WtvTxBPpr3dAGbQTZH2/58u
	QnK/C8t0TY3v8jI9Zmx4Z5dgAOMwBabJZULo6CVlz4M3c=
X-Received: by 2002:a05:6a00:10d5:b0:82c:6cf7:5b69 with SMTP id d2e1a72fcca58-82d0db5377bmr2683310b3a.35.1775218223330;
        Fri, 03 Apr 2026 05:10:23 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:1cd6:212e:a788:cbbb:a39d:2c2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41b8dsm5390775b3a.34.2026.04.03.05.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:10:22 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	a3205153416@gmail.com,
	bkkaracay@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v4 3/3] refs/reftable-backend: drop uses of the_repository
Date: Fri,  3 Apr 2026 17:39:00 +0530
Message-ID: <20260403120938.1142533-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_be_init() and reftable_be_create_on_disk() use the_repository even
though a repository instance is already available, either directly or via
struct ref_store.

Replace these uses with the appropriate local repository instance (repo or
ref_store->repo) to avoid relying on global state.

Note that USE_THE_REPOSITORY_VARIABLE cannot be removed yet, as
is_bare_repository() is still there in the file.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs/reftable-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b124404663..7c8a992fcb 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -404,13 +404,13 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	default:
 		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
 	}
-	refs->write_options.default_permissions = calc_shared_perm(the_repository, 0666 & ~mask);
+	refs->write_options.default_permissions = calc_shared_perm(repo, 0666 & ~mask);
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
 	refs->write_options.fsync = reftable_be_fsync;
 
-	repo_config(the_repository, reftable_be_config, &refs->write_options);
+	repo_config(repo, reftable_be_config, &refs->write_options);
 
 	/*
 	 * It is somewhat unfortunate that we have to mirror the default block
@@ -492,7 +492,7 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
-	safe_create_dir(the_repository, sb.buf, 1);
+	safe_create_dir(ref_store->repo, sb.buf, 1);
 	strbuf_reset(&sb);
 
 	strbuf_release(&sb);
-- 
2.53.0

