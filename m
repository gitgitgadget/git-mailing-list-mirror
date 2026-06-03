Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B642346777
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477493; cv=none; b=S05awWbF8pgjLI4WfyWWdZkLsk+/3dM5Mns7cRp8ahy+KYVLRymIUnk1D3TiNZpmVgSflzDRNUtTg1Iao7YCkFB/zIhr4y0Nk3LKh7YiUmFjKkUxSYFyolxxXqNckRm09agTlg0ZKr0bZKTqmCBryhE38srOaw8ya3BN7YQPqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477493; c=relaxed/simple;
	bh=smpKIB0hbMSDTMvTOQXx8JOTmTRTkVIz12bB9FEWbMA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dWM9UT8eHAtD2++foFpHt+ulWyRMnYgEpkqb9HSLLEPrDoNJInytawhuT/PSNeQPBAMsOz/SiL/cH43JOmPtFO8gIGI/gcR5pNkDPPBS2RvmCDhCw2Och3P8KgsYPmGUniQg0N90Qdj2Oy2UGjU+PKyjXN3qmDUpJFGtlP/NLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTvDpexx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTvDpexx"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-915906a4becso37537885a.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780477491; x=1781082291; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m1jk+GXj5yypnYlW/7qNb7biG3Hr0PJZL5gVrZnGQmE=;
        b=pTvDpexxIf8xoJZ0nouDcA0HHBsAUb3PugYgNuJWpAgI0unO7jGtUVdb7K31y0EfMC
         jy9WxqjpuDuhxIZLjuPWarNZSvDy6ibB0jMIsTV1sXCgsGz4jwq+BHadUUi3lR+5FAM1
         lFpu4s60lf4BQPOcwVa7qxTOLrQEXqOF56RO0HAZqqVYDOJvN6Y04RS+4FDKQu5pseel
         mKHD9YuIk5RKLpj8lNj4ddF0BEPVzxFbxMIIyeOsRc+yEnV0qOXN0a+VCIV/zwmw9wSK
         fyk6Veu1G2Nnbb623BdG+p5nhmFaFX5O9MzFnElAqxAijsDRIJGRJFtYQvUB+g9G2Z2D
         cljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477491; x=1781082291;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1jk+GXj5yypnYlW/7qNb7biG3Hr0PJZL5gVrZnGQmE=;
        b=lCUEV29uV0YRGiLZCy85XWVvDsTgS6QvxmRZ20L5epcwFBV4IJwHda3jS+VXuloULr
         6gyYxt+YO8VTVerF+reZZIEE1InyQrbCW8gsuHrYAg7e3Iczn84Apj6/KN+6x5eoWL9n
         FrCOXQ+Qm8rbw0uxiG4XPoCMkWp2HSXbhWNXL+PFjoEe1zvPptW/NC+OYgeYj4R0N5fx
         twboIrG+pXlx1nPXzxM1+4Trj5o+tgO4ceVPVXyw4fH6eh9SKvcFV1v7GM20spnxGmh+
         WAJu2+z5WLularHau6DnjVPd5d+6RiJsHGNA/dZFu/o/96KYupHHw7wf5+xL2Drd+bod
         uUQw==
X-Gm-Message-State: AOJu0YzHrrTReWAd34kRrm5oV6pQOsTnqaLizBWFwHs42A/Zb8/BCK3Z
	ZO6/Jw2r3l68fwzzY9PZ34C4v0AvvEJ2BPHcVbktXQ0eIdUuXNBydNsOercWGQ==
X-Gm-Gg: Acq92OFB//d/nhHZYuDT3VDvnOPoV0jvl4oVEb2bugX+FmxTnffYGTYAXm15+aZYYE7
	MbESUjTEmhp9If/8eC82hyOvGo9Vum74FLpAo5uVXv9l+H8Z7HbS8EHFNiiBuStMDKPqD5ohnv+
	B0i0ffk8u04geZRnxnoMLFeIC+dZQ0/03D1I167xnW+ORMN53sB7XxGS5SSi/fAc2pQ9a5Xuou2
	ROWbMLJysfgZTXru+EkYU2PWFtNpagOfcVVQEKFEmhde4dJgpLrVIohwB1iaI9T/q05LKbeh0Nk
	O4ooSy9Q6Vh+AiGzVabtKo0xK29zsJKhMfQ8p2JE9m0NWuhwUuC3ma/LYxGP7OaErPhZHH1pB5J
	qUKDaPcLAn0SGGRqxTEEQ5xp9J+TIW9u9PjlqCCqPSV0nwZ02gAXuSF7B+TmSkLsOlHxozLNXjT
	DYI9jLUxAQUaYQW0/4zvNj4aviG23v2npPQKiZ
X-Received: by 2002:a05:620a:8397:b0:915:5930:94e6 with SMTP id af79cd13be357-9158a828e23mr453275985a.51.1780477491122;
        Wed, 03 Jun 2026 02:04:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.198.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21d2c1sm198886685a.11.2026.06.03.02.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:04:50 -0700 (PDT)
Message-Id: <pull.2318.git.git.1780477489662.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 09:04:49 +0000
Subject: [PATCH] git-gui: silence install recipes under "make -s"
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The split install/uninstall recipes embed "echo" calls that fire
even under "make -s", so install still prints "DEST /path" and
"INSTALL 644 about.tcl" banners. The existing "-s" block only
clears QUIET_GEN.

Wrap the whole "ifndef V" block in the canonical "-s" guard from
shared.mak, and drop the now-redundant narrow block.

Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
---
    git-gui: silence install recipes under "make -s"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2318%2FHaraldNordgren%2Fgit-gui-respect-silent-flag-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2318/HaraldNordgren/git-gui-respect-silent-flag-v1
Pull-Request: https://github.com/git/git/pull/2318

 git-gui/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index ca01068810..d33204e875 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -64,6 +64,7 @@ REMOVE_F0  = $(RM_RF) # space is required here
 REMOVE_F1  =
 CLEAN_DST  = true
 
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
 ifndef V
 	QUIET          = @
 	QUIET_GEN      = $(QUIET)echo '   ' GEN '$@' &&
@@ -89,6 +90,7 @@ ifndef V
 	REMOVE_F0 = dst=
 	REMOVE_F1 = && echo '   ' REMOVE `basename "$$dst"` && $(RM_RF) "$$dst"
 endif
+endif
 
 TCLTK_PATH ?= wish
 ifeq (./,$(dir $(TCLTK_PATH)))
@@ -97,10 +99,6 @@ else
 	TCL_PATH ?= $(dir $(TCLTK_PATH))$(notdir $(subst wish,tclsh,$(TCLTK_PATH)))
 endif
 
-ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)
-QUIET_GEN =
-endif
-
 -include config.mak
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))

base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
-- 
gitgitgadget
