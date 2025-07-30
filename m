Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA32DE6EA
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893842; cv=none; b=Cqx3nAIe2MVnVS4ZraHiOQNNBkjiq6BeJ36YFbl7We7/e5dbwh7dYZ+FIB/TZVWV8lrDA5EI5JfnIA+7Mvlw56Pya63gQ2OpDOa/iKeCMSbZ4L97ozLAhOCNck5ut0L2ndx19STquHAXF+FDj1rXqlxUux+MdtSMUNSQpGJzq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893842; c=relaxed/simple;
	bh=mAqnCew4MMLXhZ3KYIW731koiBNmNtQrnGtmcoE+vyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DO2eCgCrZ/saUdWECDQDEthrltxzFf2830VHufScO2ddRG6dJH8Nx19VZpqGO2RDMefT/f66Zq2Fv54IDa6acHVK7EiEIkxq86kSXfGeTC/xgG5XBwHA2nlmPw1MF864O7wbHhMP8YkpFsbwJ/9ROM8NsDdT7J/s158RVopI/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEUF57xa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEUF57xa"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7494999de5cso2549b3a.3
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893840; x=1754498640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5DupHam4hjxGmz8bMh+NG42jNihqArWjeCJhCq8hEg=;
        b=HEUF57xavJrfegBB0skO3Wnv9evy942UwCGjBAaykZvQ8VATydZtR4lMDnDn/pN4lf
         35gjXJHNCW/kxQ4XzjWKFBzKu9NPPafsiHkdATqIkkgp4XY2IUc58ID0RpWCo9yhMdDM
         nM57LY32qYrK3zOqlTbQFLzXf0WcIHyCe3jBtWXXGkBVFt8FFauKPqJyFKaK8bq5ft8e
         rNmI/AOpe9I3MhYr0NvDVsC3r0cuNzACI0926eEDAKPqzhEhg979OT+gGnhzi46NOYU3
         HEQ/GjEyzCqJ5XgCaywbLpxl9+cqf0sS9zv7zWLAGihBNQPr9jnXvf6HBtV8KqHnr+CY
         /k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893840; x=1754498640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5DupHam4hjxGmz8bMh+NG42jNihqArWjeCJhCq8hEg=;
        b=DLQIU1JiW2COD+r2/9mAzwdwU/HsruiPzLNLWDVHSw2EwtClHg6M2NR6LNacR6oIcU
         BOq4HGUJq/GHdv2R0aiu85EBioxwA2Yuaawqw/mk3HlSiCEGhii/XtcRVQSH6Et141nA
         jcC/vio1bGfQ9Ri2bYd5mTJnlZeVEuHWZXLttBNzOGwN6hhlEdWI2RVZ/ZTTjt/5PpGv
         gwdmZDyugvtfp2PbLaFFQZqOKweFqmhVr0ulEOYWIIE0q45cVeDxvOcRD3vU/A6+ltQD
         fVqp4f/qyySNXFPz/lRKEX1DTh55pqyrdp4CEsjJV4yryada/WXP7TwibEMVUPTAQhjL
         Tj5g==
X-Gm-Message-State: AOJu0YwIQ/3Bsy/VeGcn13qDlqtMoBfEnDOrcBpe6ZfYYSqI8d+atYWY
	CZ/OmnMTJDjMrGInMtd2lPTZpqBkuSHcQX3+gT796DcS9qI/Z707j9g9ANUoDA==
X-Gm-Gg: ASbGnctxTp2LR6sDuIKPIxm1YOfvuWNbXQGBY1hUoR2QS8911myJFd2wymJSU8Rvv/K
	I+jIVkkLCsQML3oTRex57vqakIbzCfbbdGXPq7H7pxqq4gr/PZuFMgsdLnuXDe9yVSBtWdvQVwi
	NMflcjKRV+i71Hfr0wdtWgWpeA5Z/uZxVLPos/Eq6h/Ql03WteLUd89SC9Di7APVfQSVmwZ+Aje
	ZOuDQcJaxxlyo8Keobqn35/Pa4oknbtvvO/qd5r8ENy3eDsSKffu+yvqrwkIVYta9NXd66yhIW+
	z9mnWfIhbym9+9tRKD2lv2ySVh1W+Oc0dqQlW2leKRvyrfJMoYqfk26bM0WWElmurZjSmW+aeXm
	wjO5+W2kDWrRmv55VcAjeIkgr0Qt7Gz8FYB8aE2gPsApfAGpKqeXOqfOFkPFC2FRY81GFJxrt85
	Bgr2ZijYs=
X-Google-Smtp-Source: AGHT+IHLUSecszyx+N/nufeXq0iyPxDtqAqWuwMBSHEyIqn4ZFMpueMk4kIfo8q9MEEtJGhf8JIIHw==
X-Received: by 2002:a05:6a20:a125:b0:23d:ac50:3342 with SMTP id adf61e73a8af0-23dc0e91dbemr6526378637.38.1753893839836;
        Wed, 30 Jul 2025 09:43:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58b95esm9671536a12.16.2025.07.30.09.43.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Jul 2025 09:43:59 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH 1/5] git-gui: remove uname_O in Makefile
Date: Wed, 30 Jul 2025 09:40:48 -0700
Message-ID: <20250730164052.15371-2-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.g795bb014d8
In-Reply-To: <20250730164052.15371-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Last used in ae49066 (git gui Makefile - remove Cygwin modifications,
2023-06-26), and unused since.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 315888f..a87dc06 100644
--- a/Makefile
+++ b/Makefile
@@ -11,7 +11,6 @@ GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN . $@
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
 uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 
 SCRIPT_SH = git-gui.sh
-- 
2.50.1.475.g795bb014d8

