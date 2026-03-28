Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151F2FFDEA
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707161; cv=none; b=eVw8iwAfsqtOzUUpAC56Z3BqyUsFbvvgCb3Kv6GRizkOUMVBDdAZD8AZblA/hyjschvrjwryHYDPWgmZBQw/1PwVKyvZKok5w/oNQM6unIIs//5U2TOlm/XWC1lHZrk7bcqN+/pnzM+w0iFXUY8GUenp2RO0tBGEixZeR3ZQ3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707161; c=relaxed/simple;
	bh=I+8Kd3URrtigFcHycvmzgpzdAWoxJBf59Qrb7TvbbHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1bhjGLc4iSaizVbLzkIA3GqzkR9wQgYxXsps7Oiu3LFv/+1j6d0MKKkpvVmVucijEQRlxmukWfZsNUNu7gu0zmeyadpSBoMTR2gWjkP9GdtdXLDtpo62xdX8EVsQIpSSm/6v/hDDFEtht1FRuSJCJV/hXp8Rmfp9FV73iUDzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYqgWmR9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYqgWmR9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab46931cf1so30457345ad.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774707159; x=1775311959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=QYqgWmR9FZS07k+OosPZmRW5RrRR9kDyi7C0jX7zSmyVVd+8NjFUz9+Fjf7Mm9vTny
         /BZkJgg32BaUwp59/lQR0bvqu4cy3Lzr+hRlxHiTmH7js4tyCTg9B21i4sL2NEGGiXYp
         jXDcYBM8w3Op+sdZAGxbZCge9mdkznMM9tbSQCyqmNhlSFUPXsWdDpEL63hib4MW7G2I
         sFlVklpPX9CExyrP069QyrOA1EtKpuwF1Uf3EmbBWloivZRZGPk6Jxfkmy82G5oJrUow
         1ufNlobirTB0LjEM/Yi9fQgJ0sD8vU7nm268nbRmrF4Ab9Vk1fCzPiz6uAwxiUKeXxwe
         YxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774707159; x=1775311959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=ciV2OocCdiaSA2DMS5ZYVoBGbqEqlx/vXFjIVyyX0UZAvGRsOcci2iDWPCKbbrEZB/
         RJUSQYjdZgLig22go8aYeomrJkQn7nxuSySQ5F4FUH2hWA6cZBbLX3XV0BklLeJRSXTL
         MfQCn7bmxrfqbcpPQTff2wLvoJRo/KbViWPUAKYF8TNETlrpPWs6phvjRXdIq1stEvhC
         hzVirTCYtUIRzi+jfEoph4TQv2VlXbzkcGsOd3LrBY2urrmSoSNSAPqB9jiEAakz4Hue
         VELzDrm5/OBeKCI9K4RiCk9QB+EVUuWEXIbDPIRT5UBaPUfyv0rpCeaCQGkeswgJWC8x
         Ze3w==
X-Gm-Message-State: AOJu0YxqjzCSnv80l1hi8EfWneph9eMH3y4jMF14wZrrhPEUoYKIpdxw
	cqB9sVLFtae0fr1j2t5r7Ba6MJ9xZqHJIXZhbpB5GkzlHrDK2XOzPVZoLu6NwQ==
X-Gm-Gg: ATEYQzy7HO/t+nvvhH/Ae+UzS+nT2qKkhf0NomisIMySjm0dvMquYQhpiizUSCA/ekt
	AafmjB2Pd3u3K0ohAPzNE1dUjzM3zrm3jnikLYqfOGXcaiSPwihybGhWq9ajJ5+EwVU0Lm1QvUu
	mFUtE26GBTPNYX0uAlE4+nlCIa/QHGlveOrc1bgxA9QD9wMlyRDpi787buh69QRGsZufW1bOwPN
	WK3SWfnuYTUjCgz9f5mE45uvo5LN41gj6B0qSESDrH7x7xeHsCrSTxmLzCqHnewyZjOjgyg8m0t
	++qehf3fVBu/5/Kmh7sIi1SztT4VyenwfFZ50nWRyORH9K//XkkYunLjvEjIt49s3lT3kziChMi
	s25xQPwljJXT5K/pjoa/dHwN+h7NdnQz7rLUOlov524ASOsJBlEA0HLMhKa2mQDYxCATlUpK81o
	Hn2khJoa5+/ykNhu6IHFivuWeaxihf+utc192ltSnN4w==
X-Received: by 2002:a17:902:f64e:b0:2b0:c2d9:2714 with SMTP id d9443c01a7336-2b0c481429emr91976935ad.4.1774707158841;
        Sat, 28 Mar 2026 07:12:38 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:1b3c:5de4:c8b:1b79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm33173855ad.67.2026.03.28.07.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:12:38 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2 4/5] refs/reftable-backend: drop uses of the_repository
Date: Sat, 28 Mar 2026 19:39:35 +0530
Message-ID: <20260328141146.1095115-5-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
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

