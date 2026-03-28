Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1E3446C9
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728205; cv=none; b=Jbr4xmwByNET/79SSqrlUvm3AK2H578084YqL++q/SQ4A1c1bdqkAs1A9H52b4MvoP4S0bqS1aYkNMDM4yW0nNuCpjzVYxEnVqheka7HfQSaND+CRdpLGYeiXF0f8+c7WgjiMuxmomwK67pxFBkkeMUnYoc8vAQ+e3Q8NogTkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728205; c=relaxed/simple;
	bh=DQxNf3W6YcjfdEndU8KaGsfTDAwYrL9oC4FPtbFAsV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAnPJygQNiVdsIEmQW5rfNmfLW7XcLyLlnaGlAeDOuLJLyY3MSI30u91VOWStqH/3o6if9FFlDhwjWMRKSMX6ZcbF7S1IiCUjgAvYWr8EN6mWk4vqHpaUywIjSTBAUqplN2nXjSBEVE2UCJhqyannvuLg6O37IlV/xpgwELLr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad0f0T5m; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad0f0T5m"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2209503a91.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728203; x=1775333003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRiYsh231BM5OeBW4THFwguvSmsfTsCGgcKRGmdxXOo=;
        b=Ad0f0T5mY2TWbDFPY2Ruwj4SaBWLRK1Ul+lsnU22ekKbGdmvcwVIeWZ5DbyetWuDmK
         pw3zrc8WL7ncwUNpz0UDnAG9kxWHEozJInB5ORRsfHZspquorFRd/3jxaHez64yvB25C
         NGDCJAMseiDIgZd9pePbWl8FE0fFxUkA7cykbZhBLqUpglivPTsNg/6DBdHNXrjyNdbG
         G24aZvFWgH59TsT4PxxDKQ7rgUbLhPbDGV5Xf1oonlYDCaRFluwO92kx9P+YMS+3IGRJ
         hC73d+f5wdtRZB+GfCbhNg2GeXCE/D3Zh/qsa30TmiyhX6+ba3re+ujz5MdmzT2G1IT+
         sTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728203; x=1775333003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRiYsh231BM5OeBW4THFwguvSmsfTsCGgcKRGmdxXOo=;
        b=Gc3Lfy307s90P+gvZyEaKSAiV6q7bI3kNn4hoHXO7rQw5g/MGFB1OAOIkdEFTj0VTy
         jDqVpFeIBhexzJaDAyXrMslv9sLKcBhpdysuYJiAGqmyY3XUkcs6EyVHTGw6uNR58KDj
         QQ8c+CaXye8VTOvBl1ldVbFiElnG18YZyEEEwvt7RITOAfRh+HWEBrdryloxycp1haS2
         X7GVFdKFtGNrZVOUs5xJb50rIBcsfog98FTotu+9WO+ilsXMPa2uHg/i10duT+nUfV5Y
         95f9vHmzhCbCpdV9Z1nxND7YRW3xF2lVCOA4OcLNSRh7dqHLRUhhWEM7aKzpjQXUccCC
         dlhA==
X-Gm-Message-State: AOJu0Yw+61UqrNFR+W5vRb1LUVUKx+x90RP1P21e31m9Jn0ipEqVSBCV
	rVkdwkYgvobEcVEZreaY6FHUs3vno+JBLU8RMwkZ7IdyjxXwi8VaGqebdYAzLob3
X-Gm-Gg: ATEYQzzveP/QVVKNYVuKC4k2jnuymb81mQU8NR7099M8imeFtY6lJ5kmB1bcOfgc1d2
	my6YUilFQfIhpMcRRb8tpPnX+0XiO3aEybc3qt30H4mDF28YXZpxY6Fv9VkEFoMvEwijfHvz9en
	5Om8FbwrH24dpbeIPLeT22dymjSx7IiN7sGutLu4tsKzENDjoCGRDy32BtFPMy7p6J7zGLUcrlC
	LFhEIDRFbq+4EWLmza9joYG4yELDyZS9zUiFiGpovNvx54UGu86FBWETi7V4myVNSGws9lOsEe1
	TDlbOoqRRBFDh3cVVOCVo9XkswpzDBOXs9Bb4ePCT9HdvS3UieTiGdcukQ2LNAJ9IwBMxa74gJy
	+OGsV+IDxTkr9sr9DBZ64itzyXbPfE32WFf91HWqSx/YshrJsAuYkTUL23/Vy733hUWwhLXFq8+
	A1q0LfBgYLeShdkAdTYIGKAGa3l2OEFQwMphhdWtgJZY3qxXi3PMMj7113wY54mEr0FoLecZNpu
	G+fQLgQGw==
X-Received: by 2002:a17:90b:3506:b0:35d:9c32:6219 with SMTP id 98e67ed59e1d1-35d9c3265b8mr1481245a91.9.1774728203232;
        Sat, 28 Mar 2026 13:03:23 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:22 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 11/16] t3903: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:50 +0900
Message-ID: <20260328200255.247759-12-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t3903-stash.sh to redirect git-cmds output to a temporary
file instead of piping it directly to not hide the exit code
of git commands behind pipes, as a crash in git might go
unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t3903-stash.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..b67cf23fbb 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -962,7 +962,8 @@ test_expect_success 'store updates stash ref and reflog' '
 	test_path_is_missing bazzy &&
 	git stash store -m quuxery $STASH_ID &&
 	test $(git rev-parse stash) = $STASH_ID &&
-	git reflog --format=%H stash| grep $STASH_ID &&
+	git reflog --format=%H stash >actual &&
+	test_grep "$STASH_ID" actual &&
 	git stash pop &&
 	grep quux bazzy
 '
@@ -976,7 +977,7 @@ test_expect_success 'handle stash specification with spaces' '
 	echo cow >file &&
 	git stash &&
 	git stash apply "stash@{$stamp}" &&
-	grep pig file
+	test_grep pig file
 '
 
 test_expect_success 'setup stash with index and worktree changes' '
-- 
2.43.0

