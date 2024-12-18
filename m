Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30D5695
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489864; cv=none; b=TLKuX9kotqXQJbbvDgExAPz6qIEtYieAQXaol3xHi9MJnhxIZRLB3GxPPfHAmDOU3H0Tj9PIISJbkw6GgAr4eCFK+d1VFOqiCaXBbWf84kenQPrknSVjD8xKizNhorDiTzcll86TCbHXNN9L2JEvc4xfu8bxYuqz2Ik1lghbRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489864; c=relaxed/simple;
	bh=pO58dLCFlgsGghpJKtP54Zzlkm0bvTBARDhNs6RRFWk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GnHda/Tz8N+v8Z7/Fa3vov5OGgjpUx7EGRD1tg86M/wpmoaOzYHfqxF6nDgmP0rBZhmXnBOvrX4AJcUWI4u9jD9TPYM2JMMv3R6LqCTif2+oIZ0DjW5bTweK1TFffL+3h2qFEoQHPdUIynyQQRKt/8nRjAhF3jCiyoV53qJExrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRcJw6kE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRcJw6kE"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436249df846so41650705e9.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 18:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734489861; x=1735094661; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DMsvPWRt7ynS8qnKj1FdZqki37b7DRIlYeuNtFZDGI=;
        b=VRcJw6kE5Ay+FjkNKO7T8MkoyBUTw3V2ULqHtKkuF2kwRXKcfg6zzvvYlY+IXuDpkD
         lJC60wP7EKJbntohtQwlXv6WT3cLqITjBrlgjnLJHzkQIKC52KDqyg2QhNzBCVvP2ctn
         Rb78eFKKfJXV79ymlvi+du1M1ap9NhwYyRoWyUox/banqg1GCJ55Z9axui+ERSZ5177f
         1GPGXvuhXtKVf0kqiX/gLeqdt6CBUqyOgDoq/thPS1ep70D2pK5mfHQzSgkmnk32W/wd
         +g1cJsRRDrcXbKWwP7vSlKcNjPyouJb4UxglzeabE6A7OitVDvay9xjDUaOHXcd239k1
         BYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734489861; x=1735094661;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DMsvPWRt7ynS8qnKj1FdZqki37b7DRIlYeuNtFZDGI=;
        b=RaSVGlhfjnbIVKkWB/Fe6OSs3ntVVySIQbNkS9SOtGRBZGHKTavLLHOUTjfcMbIS2F
         yG3TrYKz99BWeYDMkqwDYVDD/1Ga/aSz6E7UaKky+J1y1oykPwz+wSxnhxL7KTfYZA04
         Opm6ObepH4XPCyJcqEB1qE2rLHEjLYR6DkBHyVYKMvIE4uK+pzflmbvQJhO0flrw+8nv
         qGRb1+LQmWgDDKHyU1NADDfAIHEwogR1DAMSs3pTWx7JzIa0TdRdjJ7mZHARFD/i4SIu
         fH9j9l5vhkiIHYyoh80rPiimgxuyLtdZ3lo78HvZ+CkEeDTjU0NvXjGX63FY5Pn//D09
         m9RA==
X-Gm-Message-State: AOJu0Yw2bgcNOK6ZoPe2g6RaaZPiiiSkAbi3aDXTEZiYVego9UMDws7H
	sru9rHytl8Xt1oICQ4c/t9B+lQ0hgOKk1umPdAN5PpoOB1tFiYuygOog0w==
X-Gm-Gg: ASbGncuYJX6H/OZUx+5fyBVWlpFtLSKnnjooUjT/NQJVOwccbVdSagmc9I1COD3QwIg
	+2pBViRbfn3fzELQ074GokefyBuGxxsYZ3dKaB5fjJXc1ul29UWnAeKpG+bK/ZDt1Y1lw5gCMa5
	kn1zjevKaHQ449t/L77vAaEP0H+dFebuxPBukHkR21j1vgdSdSs+JBJ/EUcGsaC7Xt1K/bdFoTJ
	wErTfZMnkLk6KUAAP+kx8NYbcXxSE4RCR49UnIOIHS86UF/SWhgEHfrbA==
X-Google-Smtp-Source: AGHT+IHlVdFLeFY8pZF0zS/+VtJTkh5Vwf5A2YnvHRuwWmnEsPcikIkFj4/21d1BV3u3TTUWJFixbQ==
X-Received: by 2002:a05:600c:468e:b0:434:a525:7257 with SMTP id 5b1f17b1804b1-436553f30c7mr6198915e9.21.1734489860741;
        Tue, 17 Dec 2024 18:44:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060905sm12767999f8f.99.2024.12.17.18.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 18:44:20 -0800 (PST)
Message-Id: <pull.1432.v4.git.git.1734489859673.gitgitgadget@gmail.com>
In-Reply-To: <pull.1432.v3.git.git.1734483016515.gitgitgadget@gmail.com>
References: <pull.1432.v3.git.git.1734483016515.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 02:44:19 +0000
Subject: [PATCH v4] git: replace greater-than and less-than checks with one
 not equal check
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

(version < 2 || version > 2) looks silly
considering this is an integer.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: replace greater-than and less-than checks with one not equal check
    
    (version < 2 || version > 2) looks silly considering this is an integer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1432%2FAreaZR%2Fversion-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1432/AreaZR/version-v4
Pull-Request: https://github.com/git/git/pull/1432

Range-diff vs v3:

 1:  322d04519d5 = 1:  503f6635522 git: replace greater-than and less-than checks with one not equal check


 builtin/show-index.c | 2 +-
 packfile.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index f164c01bbea..5fb71a1c425 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -44,7 +44,7 @@ int cmd_show_index(int argc,
 		die("unable to read header");
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(top_index[1]);
-		if (version < 2 || version > 2)
+		if (version != 2)
 			die("unknown index version");
 		if (fread(top_index, 256 * 4, 1, stdin) != 1)
 			die("unable to read index");
diff --git a/packfile.c b/packfile.c
index 9c4bd81a8c7..de0662b2353 100644
--- a/packfile.c
+++ b/packfile.c
@@ -114,7 +114,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2)
+		if (version != 2)
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
 				     " (try upgrading GIT to a newer version)",

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
