Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCD71B3B
	for <git@vger.kernel.org>; Tue,  7 May 2024 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715117795; cv=none; b=izY3cvTD/urYM47MO4fUSv2B3+sH4k7x1jga87IpBFw6ShQmcGVbJaXBWx1VQbEQavD9sX1PhRBDm4eFvVL23guRyMTn+FlcKmdISgCTZAjgwudawgP3IeIP10JxVuteBh9azvxndcwWu6LlAhAW7Mw5St1lBBvwacSZjkYjmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715117795; c=relaxed/simple;
	bh=0GN+Kar9bzrTxaO6jByFwODEu9oIIaLdX0jhLgUiybg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fWEMzgyoxPqYizaUNi7X1gcM8gXIfqr1mXE7ejOmGXrnXR+93mGaMJR4Ph8NazW+QgK2Ph+rtEWwStxd9xAkHyZfpAOic9LdtV1OFY1NeUiA6lZX5cuAruMg0fNFzy/PG1FxXjVu/hb8nGyAiC1Qojp0jXZw/kGgkax8T4dhkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhUQxYGS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhUQxYGS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41adf155cffso24917435e9.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715117792; x=1715722592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v2+dLidRhiwoGFgYFkormVnepYDLtKJIhny2prnac94=;
        b=WhUQxYGSCANqvF4Jae58myqiGZ0QKIVkm3DJKcCfUg992gWO8+Fn/+hQOCobuUNOY5
         9nfffHGBaSYxRoUOEHmP3m4pfyN2RRqFHgIZ9qfIZX92a9uaAJhKKCOX8jU7TrDyJ3p+
         P7jVuf/qKnRl83TqLErqgruQfxmSbvHhzQR/Nsk1xxW/sIe8owXqT73CTQ3cSrFOlXkl
         5iRY0w7et1vsDDaOByMEDWsL/mPq/1oKbNUD1eef6dS9m/gz904AtedGg+hq95UPWFbl
         q/vv46Ym/boPGJqRFr9WAw4LvpardbK09Ie7gf1fHHCq4QNysqRrnQyD+4RODJ6XALRX
         z8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715117792; x=1715722592;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2+dLidRhiwoGFgYFkormVnepYDLtKJIhny2prnac94=;
        b=YFoGgJFfduIZ7Ebwn7KdNbNTq+g+D2BuapF+m/KCc+8JMBCKwfzw6SVMlRp9chgHg5
         gvWSSu3g4tmfgVrNIw2Pe/BVaSFh0PDWuz4vmvaOCd4PKa/SPZIytmzeHZTRYEbvzTvB
         fKtmSvHsS0tM3XeaeUEWhj+xGOLBCt+Fs9OfI50xeSBN/CUhp8bgMuoD/tXvtvWcGff1
         x/bWr7xmwUyeYn1GD5s0FPjR9rsD4X5lZDGOT7as+nUA50bg0t3PBbUO1qNLOY0kb2rw
         9iwBBNy89UONDTu10iy1XYSnVHCNjpIIAyKWDo+HzEOsA0iT4IaWjNHEsN0V+5aEV2rK
         G9Yg==
X-Gm-Message-State: AOJu0YxyROZJLGqoexBErCTF0ZbHpg6pl4QEnYVrLcg0ovNRIcifPpcU
	rmaYuq7FDLOV4CSwh7yJ1Heu4pH1QlKJ3AiBaI7ajYbEWznRHnx4P0AVZQ==
X-Google-Smtp-Source: AGHT+IH4bucmokHNOxsiBEqU4YcA3sUfkw11yhBAvHwjcr6pH8D+ZvXGEC+29hZBcc0bvg2AqnyvMg==
X-Received: by 2002:a05:600c:35c3:b0:41e:c9ad:c729 with SMTP id 5b1f17b1804b1-41f721b0486mr6977555e9.28.1715117791571;
        Tue, 07 May 2024 14:36:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b0041892857924sm20848778wmq.36.2024.05.07.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 14:36:30 -0700 (PDT)
Message-Id: <pull.1728.git.1715117789985.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 May 2024 21:36:29 +0000
Subject: [PATCH] Documentation/git-merge-tree.txt: document -X
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add an entry in the 'merge-tree' builtin documentation for
-X/--strategy-option (added in 6a4c9e7b32 (merge-tree: add -X strategy
option, 2023-09-24)). The same option is documented for 'merge', 'rebase',
'revert', etc. in their respective Documentation/ files, so let's do the
same for 'merge-tree'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
    Documentation/git-merge-tree.txt: document -X

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1728%2Fvdye%2Fvdye%2Fmerge-tree-strategy-option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1728/vdye/vdye/merge-tree-strategy-option-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1728

 Documentation/git-merge-tree.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index dd388fa21d5..84cb2edf6d0 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -72,6 +72,11 @@ OPTIONS
 As the merge-base is provided directly, <branch1> and <branch2> do not need
 to specify commits; trees are enough.
 
+-X<option>::
+--strategy-option=<option>::
+	Pass the merge strategy-specific option through to the merge strategy.
+	See linkgit:git-merge[1] for details.
+
 [[OUTPUT]]
 OUTPUT
 ------

base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
-- 
gitgitgadget
