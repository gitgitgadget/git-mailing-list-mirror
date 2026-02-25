Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDB2ED154
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044634; cv=none; b=YC0cjzbXDiY5ql9TiK+E/al3wBdjj9LiH1clKmt1iB/wzqQh/SMM9E1o94QM6pnNgr15tsQaDVLp3AAun/CB72QoyxfRXKwEEi79nJmqIN9fcKpESuazfHZPmorViPpiXSEoox2WtCCO4c4jxrRXhoqKk7ijXszVj6QFT5C98g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044634; c=relaxed/simple;
	bh=VwXn94Inui7JD0HuhLToIRT4y7BXDqkw26L9epAIE3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvOoVNi+d4J9w2vnQ6Hv3/rfVh1NDbngKUIKKZtikHPxxWEgX6NWdleuRPieUdkwZFuvrCwu3BI9U/ngTqWZ0HtTvhcKd5ng8eRt0bISKgq3Oxcy4XjD7Z1NsQhpxQfnoCnHw1eNwHDV6/fs41M4NIm4hvts+2+DQrU7lA5kn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpRX0J3T; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpRX0J3T"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5674f3e80edso870150e0c.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044632; x=1772649432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stmOIs91mzJ9z3kpV4IR831k/l+kBAwTn+uqcqS+3JQ=;
        b=fpRX0J3TDFGFJJn118ihph+Q1+JkO0i0V3LsKkhqcl0eelLqdx8sfoytDJYJXZy8Uh
         9ITv53/3c/CW2ifupTMxdbJyamjZP+n9cIahbOMoaEWZOGmXoYoGug455VWIMdlX8/R5
         TbuNka4Gk2AMJj8K3fdLVxG8IslkTzWNef+3iqSY1WkFAvbXft6Lg7VUylw3BwIB8OWl
         +8zI288/y3EfbFXozFRV/knVe73LWjZQLVV+DgdJx8M5QFuFsOqJpV+7AIkzo7GyQnwH
         Zruj0Zzlz1GMWIAFGjWlvttTSKkLW/nCfWFxNCEbDRGRaCckZ4IBhBKenBQggW9oCJik
         hVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044632; x=1772649432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=stmOIs91mzJ9z3kpV4IR831k/l+kBAwTn+uqcqS+3JQ=;
        b=MjEt7zvYOgR9NJNb1Nk/t6l+aulfKmpFQJA5WCpq2BgBmf5ospwDqUBxh/qdlQZSpg
         iw+NllslY0MX2dyFvxuRlyb6VK3OFsYqs+ifpmHlAvANM/STmtcnxSKynAR9nTm/q7AM
         GZt2mk2QjlT/NLVlkXVw37KOBtm9w/bD9V04SZv4R8FaIQhPmEWH9Hx5aAzwfjpxTNsX
         jx5nvdhWoWGe8OJTYhvPGe/xp40epLWVEn92olf9fbdMd+/kFLU43tVWpdDpCg238hnd
         3VR63RjfbR9G0ZAIZ4UVuGSIF/f+yUWfXSjE81i4nf/ZFkQRlzAgu+rZ3m4G33r2d6tc
         FiAg==
X-Gm-Message-State: AOJu0YzWICP5bUA1pXRE7zvz+qETa2lSM2ZQlSyEe4sgx7z4BSlGJfu3
	t7mSjJedNDL8uTKYeBjSj/o2G+JM7qiFiTWIFENL188funMgY22PX/AgmKs9tw==
X-Gm-Gg: ATEYQzwSNsDE8Vv78pGcvnOheLXs+GZ7L5vL0VBLF2n7rbjSdYi4vQMBnJNKg/gD2+Y
	UHgJKmrBI2Flu1PspRLmFut28GdMnizDv2rM0Ih9aDUzgjNM27Xm8PTassAE+O0kXbCiOwrmxU8
	9qtV1I+Kn9T4yxBXQt1ewJ2nHFZqQGVL2PorfSqrCAEFvdyVJWlDto91vGZoVB+DOvzj8V0j3RM
	tZPQDr0MU3Bj10wrQUWLSDgDuxPPl/Qx6pwE1a/tLsBL4/OSn4Ua6xqwOEJyCMeyT7mrtLYXsw5
	xe7OLFaaEbw2vOI2udC5QCMHsKgF6OE3TjFWxp4VlsnzNW3HTPzLuSrB8VK5tQL/HFI4z0dIob6
	153nwcEXn0SvgG0if0/tEoT8nh+AS56wTki9/E7n0ddNxSYyvzV7ig4JHaJXnKl4vYzSMt4rHaF
	YfD1qARYy22VggPME7/1BvUStQO2wiiEMIsg20RbSgqv1jsV4bqd+oz14Qs5oUKeXBzUmAxx4=
X-Received: by 2002:a05:6102:e13:b0:5f9:39a6:3c13 with SMTP id ada2fe7eead31-5ff1cfc9d0amr8354137.19.1772044631670;
        Wed, 25 Feb 2026 10:37:11 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.37.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:37:11 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 5/8] t1900: rename t1900-repo to t1900-repo-info
Date: Wed, 25 Feb 2026 13:32:14 -0300
Message-ID: <20260225183559.79303-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the commit bbb2b93348 (builtin/repo: introduce structure subcommand,
2025-10-21), t1901 specifically tests git-repo-structure. Rename
t1900-repo to t1900-repo-info to clarify that it focus solely on
git-repo-info subcommand.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 t/meson.build                           | 2 +-
 t/{t1900-repo.sh => t1900-repo-info.sh} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename t/{t1900-repo.sh => t1900-repo-info.sh} (100%)

diff --git a/t/meson.build b/t/meson.build
index f80e366cff..9867762bac 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -240,7 +240,7 @@ integration_tests = [
   't1700-split-index.sh',
   't1701-racy-split-index.sh',
   't1800-hook.sh',
-  't1900-repo.sh',
+  't1900-repo-info.sh',
   't1901-repo-structure.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
diff --git a/t/t1900-repo.sh b/t/t1900-repo-info.sh
similarity index 100%
rename from t/t1900-repo.sh
rename to t/t1900-repo-info.sh
-- 
2.50.1 (Apple Git-155)

