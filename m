Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9B79CD
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720319316; cv=none; b=R/xaV4K54nfJQ8c88RS1+oOwOFRdbz1XG0x+13wYkPLRKpApc+ICXor5ssZz4aIHIWvvcaCRcmsGX0yTp2qK6bz875Cn25foRcA6AvN/lwvcZ8Yb42tlGYYxi1+bDgC2LGtvzwECRJIhClJu8q2Cin8XypysCUTjRszXIl797ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720319316; c=relaxed/simple;
	bh=4dNISms0/YuWN48VOGqAqvj1wo5xVo5zfojV6sdNn9c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aENEpRGFTw+EOHTikU4jea3gHGDxuZ51Pe3f5C/oN4zY601H70W5H52Je+gVlPM03lJPYgT8rq4rOgvC0PcT2ctefFFM/QiDL2Bnc3BExw67GCSSXSYdaeSPmdjFScnqM95RX32hTwE7ws6k8nvKT5CNwoDrvS3Hpk8+o3ntGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEJA0lX2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEJA0lX2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367a2c2e41aso1245292f8f.2
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 19:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720319313; x=1720924113; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTbwThNhspmGSYmzqtTYMOIUnHrBqfaBUZWNSbozp0s=;
        b=cEJA0lX2IRx9yHsUtc5VnzhfdmvW+YgWnxuECrEqAN1Rd92aF8bMGLuZaowtrEaLL5
         3zG3vPYIszpjrqRp4CkDfSNTkt7MsGKMlBVJLPS8+1/dTCKmDg7rJ61TGhDsXM+mpX7S
         nZ5KvuIe6YqhxCbZ0RKO4z4pDLP8bx06V3sepnuEnjN03pSQs+GmFARtDM+ldFZwS5gE
         1cvwkSzPDdkfvsB6DeusywwiGz3aR52bzNGClmZFE5IEkKW2wKQcfLeKGlWF7yKsWu0s
         3CyRKqnvaz3+awBQscCGkoN76ZR7soMLamOaa3S/0EaQEfC0T3B8CemTw5MBAxXYt32m
         L4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720319313; x=1720924113;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTbwThNhspmGSYmzqtTYMOIUnHrBqfaBUZWNSbozp0s=;
        b=J/2UajHcOBfCODJZ4hCZ7jiMoRpSdK11rmch0nG/iXSUhUfAYbAzI4myrqZm1675iA
         a5vY9IQfkvsJmqHQVBkGIByW0H1sf+fJwr3ImZwCUBlf6laZhaSiwqvrpBmfUlEvihrp
         fdZucDhcF3lfZ7jyZk+wdhKLK8fv024RB365hrAUx6uS5Q29vdq4D/uS1cy3ZMJ7da6j
         80TLaAPIfRKLeu6Up6PxMr3+rj+iqe7p516qPGZ4U8t0GNf/KGR3c7Ti+A8C1R9v3MTJ
         LLB843Mt/qaHyOv+eI6Fyyo/v6Aa2c9A6NMpxmAwN6Z6OuiRgbhpjTrI+yUGDns0mbqr
         /uNg==
X-Gm-Message-State: AOJu0Yydra1UedhUrjA5njv6N4mgghJK2JZ1audSYGjnkPFbqF5fHle+
	9NnsPR3dNz8e+gew5cHJT1RRQXhj6j/VFkTi9dcHfY4xkcBAwdTOGxYKbw==
X-Google-Smtp-Source: AGHT+IEeUrqGqBX6x7IX3I+U/HJNee/OGFRhLct9UJrpXxtIBnBxnckzhuTwrrF5tjXQpiiOUtua8A==
X-Received: by 2002:a5d:44cc:0:b0:367:9d82:8370 with SMTP id ffacd0b85a97d-3679dd67c73mr5799063f8f.45.1720319312366;
        Sat, 06 Jul 2024 19:28:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679976da15sm8130412f8f.94.2024.07.06.19.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 19:28:32 -0700 (PDT)
Message-Id: <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com>
In-Reply-To: <pull.1757.v3.git.1720318768439.gitgitgadget@gmail.com>
References: <pull.1757.v3.git.1720318768439.gitgitgadget@gmail.com>
From: "Rikita Ishikawa via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Jul 2024 02:28:31 +0000
Subject: [PATCH v4] doc: fix the max number of git show-branches shown
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
Cc: Jeff King <peff@peff.net>,
    Rikita Ishikawa <lagrange.resolvent@gmail.com>,
    Rikita Ishikawa <lagrange.resolvent@gmail.com>

From: Rikita Ishikawa <lagrange.resolvent@gmail.com>

The number to be displayed is calculated by the
following defined in object.h.

```
  #define REV_SHIFT        2
  #define MAX_REVS        (FLAG_BITS - REV_SHIFT)
```

FLAG_BITS is currently 28, so 26 is the correct
number.

Signed-off-by: Rikita Ishikawa <lagrange.resolvent@gmail.com>
---
    doc: fix the max number of git show-branches shown
    
    Changes since v1:
    
     * Explain in the commit message why "26" is the correct number.
     * No change (to rename GitHub and re-send).
     * Change the author of the commit.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1757%2Fwonda-tea-coffee%2Fupdate-git-show-branch-description-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1757/wonda-tea-coffee/update-git-show-branch-description-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1757

Range-diff vs v3:

 1:  c1e236d843c ! 1:  76ab2f17015 doc: fix the max number of git show-branches shown
     @@
       ## Metadata ##
     -Author: wonda-tea-coffee <lagrange.resolvent@gmail.com>
     +Author: Rikita Ishikawa <lagrange.resolvent@gmail.com>
      
       ## Commit message ##
          doc: fix the max number of git show-branches shown


 Documentation/git-show-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index c771c897707..bc31d8b6d33 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -22,7 +22,7 @@ Shows the commit ancestry graph starting from the commits named
 with <rev>s or <glob>s (or all refs under refs/heads
 and/or refs/tags) semi-visually.
 
-It cannot show more than 29 branches and commits at a time.
+It cannot show more than 26 branches and commits at a time.
 
 It uses `showbranch.default` multi-valued configuration items if
 no <rev> or <glob> is given on the command line.

base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
-- 
gitgitgadget
