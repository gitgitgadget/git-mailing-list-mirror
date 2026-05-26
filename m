Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E73D3323
	for <git@vger.kernel.org>; Tue, 26 May 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814057; cv=none; b=SJGVA0loSfHGWmqDvkUpknLympaue5z4Feb7j2s0Tc8QW3zhNlPCLLnibYR5wilDNq5qKrBpdXLGRiSTNWBd5793loPBgKSKRgr9dhZ/nRBtX2EKLOE38WH7fmO7DKaVFr4s6CD2p012W9dn62Yj4LKpMXGyn8eIFzXlofRKrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814057; c=relaxed/simple;
	bh=voNlnXSBp+JK0dAZBRuPTvPsC1U6H//RrWN/TQJ49g0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A6mkq4GDw5L15mlKxc0/iy4JJ+0Ee9P7Rom0Qi45/MTwpMAyBA6uq1xHb+FLcBlq7wS9iCqsQR4f1leN/P2JFJPtgQRvwGNdr02h+pFZwjqbC94/gZtcyPpI7YbBt2jyBrht7STFDV3A2RMIcnYMAEr7vc/ERB0RVEgmbKbyl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXkDeHY5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXkDeHY5"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so118081926d6.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779814055; x=1780418855; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7p94JHbAuFWDJ8JXD7E9K9Z9gNZHluLmaeCyY1wAW+0=;
        b=IXkDeHY5ztPzd+aVVGuiv5Cr3jfPAhKX4Ji1XLquYbRUIEFeMWObUCGzam9Oeb4QQW
         dPZcn4hX5yJcbPH/DbrigHW/ikL/g/MAN9SZrGMecKIWyL4BCIxYbUjK59HexQhsugdg
         3wZDFWLD78tAfh5ktDhxpL9HAYdf2nB7bB1oFPw1/WkDT3AjxDARnp3BDerM5KoicLTj
         jF8DgqKuqDUjVKqweOVf702iP4NYliHqvMhGCSDCnwcHu4SapGE6kRf/xf9cL1cC/d9W
         7oUcjPUUV3WcNd9VYlb7v7UGVbw7aDMDgovLWFAZBhXrsUcKWDGvl5V4NPqwOVq7bnhm
         SbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814055; x=1780418855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7p94JHbAuFWDJ8JXD7E9K9Z9gNZHluLmaeCyY1wAW+0=;
        b=iNPW9bG+NI3CwT/d5c+PyUhbC5ZwU4L8Tv/OLbUH+XT8FTalsGcDoJCpR+Go6BD9ef
         bbEC9b/rh0tpQtlad1RSq7f4/PwrzoCT53QTDPu2ucUCEXpniHgu5ENs94VlpDtUnk4b
         64sxuFR5LESd2yIPgjGPqf9+d0QceQ/dOHV22/LFtcHBj0rZhRFs2KBZUueUDh914zPB
         +/+J3ReIUHyEibUV3CNsXdx38ghPYUjtOfuYyDAR8ay61mugOQlkHiOhg+WNap4qLAwM
         Ih1BpY9TrDpk8JQ+SAkAGW3ISkS4ii0goY7Y87naRk/TNWrKo5UJ+Hz7D5xB9sk2GtJ9
         fTIw==
X-Gm-Message-State: AOJu0YxDL+Z+3MXE4grCsDn/hCjP8pgdf4b/w6lIXfkM1TABp99o5mjU
	mIomS+1SgF+0Sv1FwIiBLen4U7eshD371lWEnhpZeyYBMM+kIP596lZIHdW0fg==
X-Gm-Gg: Acq92OEF/3hNxK5hBSIaMFFS4Wj/MLjCNVjC9ZjGzu0nax3msgKGiMINsJTd6bDMyyA
	cjwj5AxTb4eSCR0nQyMdBdYUKAJVBt1b8hqU8cbgRKohUfQIf06dQsuIzMJ9x2iDwOHDlqRJ0u1
	tkKoNgZc6aKP+gkL/3LN5bY6kYox6OdKP0yuZs/eOOcdWoonXbZf6Eu0E1wjwPhTZrsfWq0DaWT
	cWrLNDZVnbu/e04dQnEMWlncEuGMfPmRnusclJH5wTn8p8s4TchJulKmyekEH/oVi3COCqEvbaz
	d/EKYD4vJfsmgEHygM2fJVMM3XeweAHHOAnmq7mMxH9XPLSvTLcBW/6VMa7nsHBeunMRGy17KTC
	gBdZHycdzgcOllCFrGCiRbLb/m1N4XlE5mDVaHHY7a2X2SXF3hXhLcUaqjAe8ljihBSonvS992Y
	X1CL1J/ricT7o++UCAL12/XGA=
X-Received: by 2002:a05:6214:1cc8:b0:89c:4ea7:a70f with SMTP id 6a1803df08f44-8cc7b60afb6mr311196166d6.14.1779814055234;
        Tue, 26 May 2026 09:47:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131524esm144879816d6.40.2026.05.26.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:47:34 -0700 (PDT)
Message-Id: <69129f9ebd4396ebf01a63cf081cfa032931df87.1779814052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
References: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
From: "Evan Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 16:47:28 +0000
Subject: [PATCH 2/5] git-son: register in Makefile and meson build system
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
Cc: Evan Haque <evanhaque1@gmail.com>,
    Evan Haque <evanhaque1@gmail.com>

From: Evan Haque <evanhaque1@gmail.com>

Add git-son.sh to SCRIPT_SH in the Makefile and to the scripts_sh
array in meson.build so that the script is installed alongside the
other shell-based Git commands during "make install" and meson builds.

Also add /git-son to .gitignore so that the build artifact produced
from git-son.sh is not flagged as an untracked file.

Assisted-by: Claude Opus 4.6
Signed-off-by: Evan Haque <evanhaque1@gmail.com>
---
 .gitignore  | 1 +
 Makefile    | 1 +
 meson.build | 1 +
 3 files changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 4da58c6754..5f329179c8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -164,6 +164,7 @@
 /git-show-branch
 /git-show-index
 /git-show-ref
+/git-son
 /git-sparse-checkout
 /git-stage
 /git-stash
diff --git a/Makefile b/Makefile
index fb50c57e4f..4791f47af1 100644
--- a/Makefile
+++ b/Makefile
@@ -728,6 +728,7 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
+SCRIPT_SH += git-son.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
diff --git a/meson.build b/meson.build
index 052c81f288..538bd4025f 100644
--- a/meson.build
+++ b/meson.build
@@ -1973,6 +1973,7 @@ scripts_sh = [
   'git-mergetool.sh',
   'git-quiltimport.sh',
   'git-request-pull.sh',
+  'git-son.sh',
   'git-sh-i18n.sh',
   'git-sh-setup.sh',
   'git-submodule.sh',
-- 
gitgitgadget

