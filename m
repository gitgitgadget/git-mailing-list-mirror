Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7F34EEED
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311205; cv=none; b=oJYqVWFf5+NlzDnx/j0GaWns+2sxTSrPAWYRtJRwsuBO2SPBz2X8iURLo2zFeJ7RvNnGnWZT0BWpQ7kh5OPc8jYGSLa33yuJVOcllJpDmtTSNd8NVBUhovHuLDNiSRYxyhx/imSY6l0YWVFVX4QV/XDkxyi2HSoHd4+BM3/JDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311205; c=relaxed/simple;
	bh=I+8Kd3URrtigFcHycvmzgpzdAWoxJBf59Qrb7TvbbHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFDyIy8ndRf+f/zte2YQmV9lUV5BD39Oua/iKrIE3siOe7YZGpBjQzAJFL4/kWGTsCPZi/pb4NuT+UuSmVAqOoN7j7VU2VOHchyQ4RvoFaS8jK1LWS63CO7nebn0s1Ezq6+zBf8M14x5YrOTYW9LkSDBNxOiDoAI7m/fW7IeLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDMKJvRq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDMKJvRq"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76c60c7502so979576a12.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775311203; x=1775916003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=nDMKJvRq/Ajsj6Al2xkudJtYKUC3CEFdJky9uiAc5PI5UXYoJEa/dRH3f8nC8LIrDK
         O/IogjME1qpTQCfHKAKqLuu2lAB9fk0s8InWLgAPd+l3kyJYo8NfLSHc8TYZ1Y4BjI8r
         lZ/dB/UZOntpa0L6BkKBmfui/WfGwzQ4DFIl3oPrPMsWskjXw4BcBbaTnLGAO9cA18hV
         tvIoV68sjrne684T0PzCE9mLTv7JjW/BF/RS8VzvjA+Usi+YDiBKN+Zg39lxVsfa4MQ5
         eglJA8tmZkLnnE1X9qeZ97h1z8YsAVXqR+/c/owXSpHN0yYDm1lyFCbhzVSzalOjJbf7
         BAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775311203; x=1775916003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=spi2kkoeqjdCAySKUjXzvKoi2CRrZ/hlpeLEMPbbjA9ci2gpnryRKu/jysAf5tpb58
         0SVWWOqirtsGpS/pCghddyeJS7l8xk57/N2XRbFrEHm3QH6yGBpwFFwzvXhGWcPyAUDV
         e3zsn4cT9Z82D8zMSKx9Wff0b436o4MmTWKnh9IkFZoScIn2xIZloXfToeW3yXbQ7Znt
         Btr/zcHqhYvHQjEMbQBUyZijWWfEEO+HaqCHNE0eaX8vo8oZbTbd7C4UcOoV/9IRs2st
         XA/HR/hpCNGA78R2l+bmEeLWWHrPWEkdLtFAbRNgdXyeenUwh2rDElYpCzpkEjWQ9xEi
         9Ljw==
X-Gm-Message-State: AOJu0YxSiTwI37/NsSV7sfELdz/SWPebBGEJ1iRxyYeonelL3/yDQqvK
	Bmw0A5qpa43WTXk2fmoHOXNJFpz5EvtIQ/Cl2ASzQbybEQk8yrlO37PJBWylKQ==
X-Gm-Gg: AeBDieuqFt7Fn9k4fydfPQaRUjiCnNOekGULjs9nNaOfDSaeeTKWpnDNa+fi/+AObd3
	5hin4aHv2pHo9OLVm4pROITlGDXkDOv4eJHiPka11St/WrV44UCIvcMEJwdr37UnDxYRa7l8Hlz
	kjr61wRKPHBqIwQ/exCKsgUcjKDgPihWUKK/dvr0BfPjgPcdyhlc2+YFpMRVoQWXnzZCG8ZgZ2B
	oyUaZO0XYWhWV159uLAGQ0SVbk+V0vabHTl4vtpfzLgQcedTEnbNOChcRZLdNxRdw+eOWHxcOAw
	b6ejib/iEZiXTVkvMOjDuJ6iio0LspFlBeIhKy1hX9b2DHi8S7o6NxMznS5dq50HR3T4gprMhdf
	nq4kwAuDnDR0k3bNKNTdPjQJuD7k5LsOoRrbbYtcTETPmXK9OdAjhShQeR9jjGxaTRew0OIiDIt
	AvW0EXbwxKj3pbKa63OXk0b592ErPU6j3rUAS3NkQKm3w=
X-Received: by 2002:a05:6a20:4b1c:b0:39b:9faf:c7b4 with SMTP id adf61e73a8af0-39f16ebd227mr6856714637.4.1775311202907;
        Sat, 04 Apr 2026 07:00:02 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:aff7:7421:f350:c0a6:bb03])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491fe0sm7071805a12.11.2026.04.04.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 07:00:02 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	a3205153416@gmail.com,
	bkkaracay@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v5 3/3] refs/reftable-backend: drop uses of the_repository
Date: Sat,  4 Apr 2026 19:28:40 +0530
Message-ID: <20260404135914.61195-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
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

