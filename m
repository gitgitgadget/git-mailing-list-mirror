Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839C2C15AC
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779503; cv=none; b=Fy0C8d2/4WZ81YFeslC6NqK8cbfP3qXob4j3sKBSlD3dGOvmVLj15YVhNAFgCdEa0bvu97e/LIUC08GAB0HSLnakr5ljkYDdA5NE1FJ1z8M1NXDvyysXmHQjIDgBp05Z4dnHZpTIdCgiowF5KXrhs3wKRSqTZipgqr85+N0skhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779503; c=relaxed/simple;
	bh=oiHn+xh9pIhd2i78ZlGT07EhBnYARhgUcp0FA7EM0uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P60VcEpI6819dZO82wcsbCbyp0iC2yiDakHxEnPfACvCFZ/2HwMgEu2coiwrlSmCSegw7uWKz7Y5IipLPRxq8dAvUczXSSwbjHWBVmTvk96uUnD67S5FpsWZB1/dtoJAGgtt6rRHTEw6CiHizMuOqCddxY8oNoWiMzSmbH5UPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSH1rMPI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSH1rMPI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad21f437eeso23509425ad.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774779501; x=1775384301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMWyzz2p3i469ydikqT1J3g8iglgnOf/wC2IbYVs7ns=;
        b=gSH1rMPIzENkgNs50racf1N6TubGzzM+uM+bNBwT8247v41pnX1iWHdSY+BN9jm4LD
         C/Oeqvn2P4dRbUzSes7i5UBsNw20y2Uo9QNhemJWV4i4uBEw1+PtNHXBV2wFe+oysye7
         n16JBdlwxYRLRLTJfThUiW77aWO/MfRwZt4Q4CEuqNXP/RbUMuP7FDx2TSMBDn//ieJ+
         JCZepV2gmWP/rMVTayiSHfA2oixhiOVry6d3ZJ5G2ynaViJ6DbVHhBoeEVthve6hCUCV
         Uvit1skTncPpxGm+o3vEJr5BFOJxVQqwUhI8l4NEBwgQEl2vH2DIfMRTLo9f4XoRH1dW
         6kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774779501; x=1775384301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMWyzz2p3i469ydikqT1J3g8iglgnOf/wC2IbYVs7ns=;
        b=bdyIejQ3yMjKRrvA0lhXu5mjwc+CR7X1/af3Dx4Rvt6u00V1G9IsaSu/9QSWx/9lK0
         ynE3oLcELRbArhhbbWcmg4dNhVP/OJ+qFXJmqFoMkI7yvlUqg5hjzLKmeAY5hJBh5ceU
         aYAmpAoPQTm66XxXLW6Lk4bcgAYWJBEcfZSTNrpSM/gGkXxVJqDeV2gu6BUaFE967j4h
         UtjR88BKWVrENAbw036q2dGjgRIPE2fXE+9NTJwH5iPo67xMY0VM2p9RGegn2qVLOtbn
         FVvmW/29b+sXDb8tkij+Vpp0/8OVEUUOUmb89G1ryxOvB4LrprR/tKzokIPs4WzwPw3J
         VKSw==
X-Gm-Message-State: AOJu0YywjZxFWGyARJvU6RMcCB4ul4fsGJ8Ie4FZXdHwpVp5C+CQlL8D
	jbFAudYguhWZ4PIqetfcSB21L8lR+sECVkju5JCLvhBowq8UyxHmdB57Glfn7g==
X-Gm-Gg: ATEYQzyhgY/8asaGTTudFRYDwweg3hKfQ0K3IcLbTJ9DxwTXLezk6jwngFOf69+XF/O
	HZKvSgVeqweVCH8j936971UYdJrVpXkBELLEMZaI4ozyH38kdwNV1E3++dUPH/WHi7Ftmarmj8V
	UzriCCtZEPzq+wgl2RMuGdfnwlEuSKvhvQZIzfa3yNkM45l5LtMXFEd4OtP1BF0ZkUG9Q8IQ+Ia
	vRJouJEVNNJ5oDwPz1t35SZc/vsA/b/0bZ0rUeMXkSASQnRg7oYNdunh/kOs4o6yGp4C4QwVRLL
	H2mZzOiDYArnKihMxsEwLi3cfjhL6oTsAhHi5ypiIOG9T/Rf0A9OtNeeMOpEVVKPfyQ2q+uYSGi
	O/W58OO/yI6hZRfKPhs3ipr61OI4J3Qzz4E8IYQiskrbkYLRbJ0f4msNvA9aVHc59A1jOmFeFdN
	GUX/sIeHvjCNJaUzub3ZB6Q233IUHBB6x+50h0iDij26Q=
X-Received: by 2002:a17:902:f689:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2b0ce57c93cmr85458655ad.14.1774779501199;
        Sun, 29 Mar 2026 03:18:21 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6fcd:e3ea:7ddd:8d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242679bb3sm46199185ad.30.2026.03.29.03.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 03:18:20 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 5/5] refs/packed-backend: use ref_store->repo instead of the_repository
Date: Sun, 29 Mar 2026 15:46:43 +0530
Message-ID: <20260329101725.1092900-6-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In refs/packed-backend.c, repo_config_get_int() is called using the global
the_repository, even though a repository instance is available via struct
ref_store.

Replace the use of the_repository with ref_store->repo to make the code
explicitly repository-aware. With no remaining users of the_repository in
this file, drop the USE_THE_REPOSITORY_VARIABLE macro.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs/packed-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 23ed62984b..ebc10dab4d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
@@ -1223,7 +1222,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	static int timeout_value = 1000;
 
 	if (!timeout_configured) {
-		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
+		repo_config_get_int(ref_store->repo, "core.packedrefstimeout", &timeout_value);
 		timeout_configured = 1;
 	}
 
-- 
2.53.0

