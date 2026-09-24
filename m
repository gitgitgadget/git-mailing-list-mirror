Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772774B337D
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280125; cv=none; b=QZ6rMw/3HRiSLJVFpj5Ztuh2z+Lr33WwFyXObPsw1CTYbxWPQc3kG2DCe7IoQiMdb4HrZv01YL+iyTH22c7eemjWJ0l0rG/nhVLyggKmPJJP6wBpXAK07b6JYZ4e75iDT1MUqkC8MxxnWxqeBmwu5min5fVyzm8evUBXXm4fQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280125; c=relaxed/simple;
	bh=uigROy0QuvosDRebXqHsJeHk+vjz5eIh/3cpE26mArs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZWkbc3FayPB7pxt6OruGuagAKmOTbBl85eChI3Z39d6Pzni/dqk+zLcfjjCcFeJ1QID+z0tYgIympEhhX2iSQss1Vsumt4pMKMShA4IEJyrC2Vyr1Mfh9uhmXKvhVR92qbxwSTl8Q0shRYp7YvmHDIIUW8UkJARP4em75V3o7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqICBHjT; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqICBHjT"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso109301c88.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280121; x=1790884921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dK/34v6th/YupG6bOyeQHyuBfgOC9wBdyc4skoSQF/E=;
        b=cqICBHjTF5S+9ZATEocQSfSJTpG8wlBarm2zDv8lpPX67Ri4VT6Rg2IIEShBtqNN+R
         ScD4gPGoKZCUych4D6x9j5wTvyTLKNAuiwa0qUD9RK+I2vdWkuuQb8U3aicvnQr77xKp
         pNAqDdcrh2s/6ppm4JvOVdpB9KO1bklXGiSrfPVXJDxsYDBm3yy07lANXNYjcSaj9g56
         vAEYyykhZMwNWq+KinTqVKTT8YfI9UF6ztbN+tSdniR5CtdYO1201z0fjCkPqi+lIjGw
         QBPVJhJwngIAaayXiUQlYray+RSwz/pcRb4iZqZRSF6bbiPbQIl9bvqBFy8LAIfoy41y
         MZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280121; x=1790884921;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dK/34v6th/YupG6bOyeQHyuBfgOC9wBdyc4skoSQF/E=;
        b=ox1vPiX6aixJIUHJevsmUKFcLBllGRzSF5N7OHwQus3rSz0tHqqeJU+8Lcbe3R4H1a
         VWabFSkuBbBfJTznSluQCtrLWewrphxBeLDuSMJEEyrH/nmkxJDltY1vw9HfHETPq4jS
         4/1FvCiBkWwtj8yiwSCNca317C8AitTlP9mteBnVs5OHrlxbDuiGRUjll0y5v4RYCNMs
         wpw8YUzGsrv8Aey6/jqlkWWZkwWxhNKYge/z8cNMAq/T3mqV1mTSVBHAWpwU75oab60T
         YlaPmk6UJ3MMsL4tqFM0HMNtWsjAKXRBuuS0WRiSphLxxyESzoxeNijyT0MNOnulpcYp
         wZXA==
X-Gm-Message-State: AFuF++nP2KvnoMQ4oz8xXdjQc372gfOKGd9C7zap1iVQC/GMQ2HiCjYP
	4sM6f6lrc0EpzF/+XwAAU5nzzsCk3CPNxsMUdmC+gj4ObvAQLWsDe5ViAWRHNivF
X-Gm-Gg: AYBFou3rjvkbJyr1mZABtet9ItsNElACQlzqRDFpeOdg9QDeyqcFKk5uuiMsAGAbbU0
	7ghdK2VTOVLlzvOr0hjlUBBwYSWkoPcU/97CfcY1pdTqKPXDm2AMnCD9odoBkIAVdpRPNKz7dB8
	emH29V0OeNiUyy7y24u0O58RgGqS1NtKB8GZuXrBrxIykyw3akRkRFtp3AyKx0RAFo9LGYn5XQl
	8uCkw0pRq6Tv/ABrdhxPFJqWnlw8wgWV1JX5rl7raFihQ1pKJvOFhAExD3q9gEXb9oX3Eq2IFU0
	RRkcdq/KD19FFGxPnzPVGEWpIZWzf7vlcEO6N3uO65vKqoXT9kxvRzlx/ZAnhSE2GPQipYmUID8
	bFcIeNK8FCLCaPXOAlj3l+6HWFAlJUwPwBETXpm9K3lm5WGacG/7g908nFAdCogaMWDzB12IQr9
	FavLjwZYeiLIQcNaXUV1acmk1eEEViT9LZUIKQ1O0JLTTpzv7saNHXrYRu7r5FuSo49Xq76xlWt
	g==
X-Received: by 2002:a05:701b:2815:b0:143:72b1:9004 with SMTP id a92af1059eb24-14503fe0e46mr2913437c88.45.1790280118782;
        Thu, 24 Sep 2026 13:01:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad400be8sm728109c88.10.2026.09.24.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:01:58 -0700 (PDT)
Message-Id: <19a4d93181c6868c71875c6dae581c3cfa6ddef2.1790280113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
	<pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 20:01:51 +0000
Subject: [PATCH v2 2/4] ci(gitlab,windows): preserve exclusions during
 dependency setup
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Creating .git/info/exclude as a file with `New-Item` and `-Force`
truncates existing contents.

When install-dependencies.ps1 follows install-sdk.ps1, this discards
the latter's /git-sdk exclusion and causes ci/lib.sh to reject SDK
files as unignored build artifacts.

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.ps1 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
index 8c68fb0cfc..f6868dc670 100755
--- a/ci/install-dependencies.ps1
+++ b/ci/install-dependencies.ps1
@@ -12,7 +12,9 @@ $RustVersion = '1.96.0'
 
 New-Item -Path $DownloadDirectory -ItemType Directory -Force | Out-Null
 New-Item -Path .git/info -ItemType Directory -Force | Out-Null
-New-Item -Path .git/info/exclude -ItemType File -Force | Out-Null
+if (-not (Test-Path .git/info/exclude)) {
+    New-Item -Path .git/info/exclude -ItemType File | Out-Null
+}
 Add-Content -Path .git/info/exclude -Value "/$DownloadDirectory"
 
 function Get-Installer {
-- 
gitgitgadget

