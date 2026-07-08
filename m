Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979539D6F6
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555183; cv=none; b=KU4dtxpUtP+IzsBR36JcsEfaDBtpBhRm24dGS902WOmczdwj3eNsY0fQVsAOKWhO6AKuRDdOUY8W/LDv6ducv77SOgZFHHbtawHJQT+hiqTQQxQ7aF1SgHMDi18McbE6kdiCeoFY1CQH5UlrwG5DhMeM6jDmm3Cp8vw7z9p3Wa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555183; c=relaxed/simple;
	bh=vMUHgGr2pTME2XTSEGDSDrpgc6g5k9PzEwT/eWh8gxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoGwuQWBQexQtGKpP45EN20SabYdxbR+wMONOY2hoqHaJXeeJ9FgFapMoeogDl+QJRHSt9HYy95UYUvK2QgO6jKw9xlGyoKmOfq9fcvP+EL3J0tGCidDiInOc8cxuwy5Px8FmcLvN+7oelySu6aztEuprDwhp5yNudEN0uh5gyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWlF8cVo; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWlF8cVo"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44c9f8c9c4aso425556fac.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555180; x=1784159980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kqg9sL0H/xd73ZPc5wnr7FL+RaqqdWCJkO1eBYZa84A=;
        b=dWlF8cVo0cJLUValwF9GeIiOBtAulQLsbYCkN5hVFvazeEI6ywC+wu7U+1hmcCN9eO
         JrxJqUgfIY8qjw/zZWldwS4LdMMc9/Nd+ha72aV5dCKS701xaHU/g3c67rVIgDV6aH0U
         zS+IpVoWWMMGM/b+wJhpvugyS45H/BfAHfELl4NDiSatm7so7pcEd1EfZ12ztWaZVete
         v2paZTgfkDiLdkYoYPY70usUVX2TwnpskyijBgqjb/96BpjPAmz+xMK8nf6+YuzGEeCC
         5c/KDJLV2N6Zskwii+ZoL6HZmblkbJeP38/RhORO0ScCKn45p5k8FlpHaP8/zBfgV0y/
         lfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555180; x=1784159980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kqg9sL0H/xd73ZPc5wnr7FL+RaqqdWCJkO1eBYZa84A=;
        b=tG6nMsZi7hRD57R7JUizpa53l/PF8VTt0DdxB6GmnOJK6tu9nb3TDVMb954hc6cayK
         1CvHUEwG7XnM4Ge5x9zJEUPPrkFtN/VVvXH89qbiMCv9ft9RSaEnOWSwN8jnmcAdLGRV
         QcwSgiI42I1DW6eMP18bZL45EGIODcaNpvfuDxd1f2Q7+8+i2+jngpn0OBxz8yFl4MYu
         EYmdEcLBaAF4QZVKs+rBNeZb7LyURzHEIbS+MPtjRH4igJGDt/mNw1NP27PORcF4ewJl
         bWs6Eqv4w/X6UXw3iCo44xbEa1urMBqmZySy3xDk1MiQg3NUEBjI/Q/7hqOcJ9W+xOLm
         XUXg==
X-Gm-Message-State: AOJu0YwbXmpXslcY31lY5kXW47MjqTKFIp75tpwBSne2GgIdbrnNeo7b
	CsCObeHKKpwbSN7w4VwqawYWr2SA0vbt93WCdgrZUFSpDnIB32MnP5zQzYDm1A==
X-Gm-Gg: AfdE7clIp50FVLnAutAmnoRU4FbjrAH9qiMg7nAWnRwI1jMb73EGGi835nzxUb1GJQf
	7JgOfM6r+x85pmr4W77a3Lga00CHKFruunA4PGvcep5ecIvUc1bKq55JRwVShtHelsaJHtolAAn
	fGT0KnDXh6ueh5H+hLjKfAY4yd/QbKoOQWCZ8nJcoHy2I1jeSLGOrcERRVgGVHEmSqKDR/rC+VL
	HuWGYbKJtJTmYDYvr7uiTQzuJzr+AaOA9lTWwTMUqrt1KYoiLBSTFPjwJ5LwJXmMIfIbbip21uM
	IqdbyVh8mTSyvUPgEiAMy1x9k/xtdv5hPh4vxntOk1wI26Uesa36WIAOydkXQJdUxnDLFD6WMKY
	aBP0bvfBsbP7PEMSbXLWm6WV91Jb+X2/X0SWaa1B+kHVVj6JF1x0DiC6X5w5WAoqbaTe2dPgJL+
	q08BiamjKH2wU8CrHFCpdT
X-Received: by 2002:a05:6870:c245:b0:417:2b13:f2cd with SMTP id 586e51a60fabf-4516380753bmr3072380fac.10.1783555179626;
        Wed, 08 Jul 2026 16:59:39 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:39 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 10/11] builtin/receive-pack: drop redundant tmpdir env
Date: Wed,  8 Jul 2026 18:59:24 -0500
Message-ID: <20260708235925.3992097-11-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing the connectivity checks for a shallow ref in
`update_shallow_ref()`, the child process environment variables are
populated via `tmp_objdir_env()`. This is unnecessary though as
`update_shallow_ref()` is only reached after `tmp_objdir_migrate()` has
been performed which means there is no longer a temporary directory that
needs to be shared with child processes.

Drop the call to `tmp_objdir_env()` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 19eb6a1b61..50bc05c70c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1363,7 +1363,6 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		    !delayed_reachability_test(si, i))
 			oid_array_append(&extra, &si->shallow->oid[i]);
 
-	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
 		rollback_shallow_file(the_repository, &shallow_lock);
-- 
2.55.0.122.gf85a7e6620

