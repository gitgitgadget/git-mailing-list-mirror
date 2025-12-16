Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43934D92F
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885592; cv=none; b=trVMAstYqAmVU87PeTG9YNr5QuFzkOXgdk+Mz3xVaocKb0yABCbXvW1hzcsw7roY4Pszn13KUQP4ZEhg9gZkyZ1D3oIUwouYcDkWjTnNoQtwuQM8ezzAj5GOD4tZPaL3a+EEr2YsvjunuMjFy+fuyjhklVk31HtrYXgBMpbamuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885592; c=relaxed/simple;
	bh=O6EElKeKhS/+ysBMW1WfpuWyFSwKhNdEdQuMPUOF9X8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UC+XTozpvOOpXUpd4Bax88kNvFVFp+JsgAn987ARPpIxQaioH+KOcrVduODxZCRg8y4zgbHHpBbYgtqk3x8pO6EISDKGa4gO0b668df759BIJK35Srxk/tslzc6tT+1iqWVe4aCDr+AqnLnyq/JYFyk7ttf9vWJN8jODJiGAnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjwF6LMa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjwF6LMa"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b80fed1505so4421404b3a.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885590; x=1766490390; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v95A+ZphT0efPuJgA2huEtwXQ34whmACedkSr3ysbY=;
        b=ZjwF6LMax0ggWYNXimpW5lhdtEePICay5QKlZlbP5SjX3vki5Pg4rPcZjRQyHQTXny
         e3uUiu/g87eSDujnTrqrkLb84XrYI30yR5N41suwgcj6AByFnzfHiaciByUPZRcYpJjF
         ZIl915GxWW7uJTkeWFdOyE7iHj/qpFxeNiGJbfq49L1/sP+V/4HNHPCU/+57cqSvwkIm
         5IEbv4TZcjJBmThBFDAlyYGUIfqMaE1GUOgijbvnxR4FuNZa+S06RWO58zsd7v8gL+QS
         4+sfjo1/NaghNtN7e8Aw0U6mUdGMz3FkhnJRi0OmA0ylJGMqxPYHCj7DVNTr5fOlgBQZ
         eMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885590; x=1766490390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v95A+ZphT0efPuJgA2huEtwXQ34whmACedkSr3ysbY=;
        b=GVLD+oSwdymr6dpmVlU2PaWd3BoleUPGV5kbe3Slh10zA5oCO7v6uMbo+byhhoPL2s
         8jvTa+S7zfPHPEx5NjshdlkMHpnGRR9p4qyf5h8vSsuckHx6bAmja92jNi+vdIGr2bie
         FJbSVjHKJ0HqphmDDcMyYfy1s3g5wtXn/QnMc4h/1a+BMAMdRz+jTpbTyCg1UsoYUsAx
         +qnFJVSYKI/CMnxobkrm40Wu8SXV+mgW5xifrGf5FXVOkFmZiv8htUIdPsVEBkwG5yAY
         CzFBTQ6FuK3/s3StTV5eIKaiHxAseWbL/KHpWrLbDa4CdjPRtURPLY9xva4h/W0I60Z3
         D4rg==
X-Gm-Message-State: AOJu0YzxS+DYO09S7UAyV3bMenndTFCDXXU3NhjN7J8s0Oe5xs21vvy/
	YX6b2kvAZ2CCzqlT21gPrfRgf1b982ym1gLVmSqOlzJcJ+ni5zNUqDt4MpNyyw==
X-Gm-Gg: AY/fxX4W/W5VTdudRcPQqtCqymoQWMBn6wyudwHac/9xTUwV9FhHtgAStfVhuLfGrQV
	r4+91ajAFWgICXs19Pvvw75Dg0CyJjfNDZPZr0e2IgISv9Llbm/TVOX0XbNcyKez5gHUrrcE3+F
	YQJ3rRNiJPRtNrtL9xVWi9KkuCypktHwM2V7ErQZq7+PFvs/OoJ58cJsFkZRdjoC5yvBOGiT1v1
	TPqerjMRnVLaMeogIMem7BHGAO82q62LXmz0PMhRbqFgWheyLhaDTQe00yO3UvAPfEsmxjMHJ6E
	9LcOQq79yA3kcnHSfiMQNlT0xhWlc1o4Niph5AzS2vrMJaxaCtKdzNutdG5PAzUXka6zp6Vn8l+
	eAby51k2ZxJ7ThI9u02aMLUd9tvfo6AWcuOHxThRRlOPKjUj9cbZBKGpbCx2kAFerB+vVYO/mtg
	SvxZNYoyqOAYNE
X-Google-Smtp-Source: AGHT+IGuQZ9C3StqHjH3/04ZYmXp+BahtPMXsIKNJYSXQWy/36ALUJVRIBVkY2BOc3+7WsRZY3oYcQ==
X-Received: by 2002:a05:7022:b90c:b0:11e:3e9:3e9a with SMTP id a92af1059eb24-11f34c705ffmr8524640c88.50.1765885589806;
        Tue, 16 Dec 2025 03:46:29 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ffac2sm54301705c88.11.2025.12.16.03.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:29 -0800 (PST)
Message-Id: <03ff6d756d323616b16089b92afeb9a2617518f5.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:15 +0000
Subject: [PATCH v3 08/10] t1305: skip symlink tests that do not apply to
 Windows
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows, the gitdir is canonicalized so that even when the
gitdir is specified via a symbolic link, the `gitdir:` conditional
include will only match the real directory path.

Unfortunately, t1305 codifies a different behavior in two test cases,
which are hereby skipped on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1305-config-include.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 8ff2b0c232..6e51f892f3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -286,7 +286,7 @@ test_expect_success SYMLINKS 'conditional include, relative path with symlinks'
 	)
 '
 
-test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
+test_expect_success SYMLINKS,!MINGW 'conditional include, gitdir matching symlink' '
 	ln -s foo bar &&
 	(
 		cd bar &&
@@ -298,7 +298,7 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
 	)
 '
 
-test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icase' '
+test_expect_success SYMLINKS,!MINGW 'conditional include, gitdir matching symlink, icase' '
 	(
 		cd bar &&
 		echo "[includeIf \"gitdir/i:BAR/\"]path=bar8" >>.git/config &&
-- 
gitgitgadget

