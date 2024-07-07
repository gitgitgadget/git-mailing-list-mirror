Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384644A24
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720318773; cv=none; b=aaeETrmDMPRsODSu+uqIWn/Wyzn95uiFVZDPtsA+EZ2m3sW2EkHuhFbIsuQEdKOMMKiTNkgSnTkLnpfUoGwNsAi7x5V//2wSsR3sw+QUn4G5lu04iQ0r4BiN8bYDqKjxBi75baHM3bQVkBf6kfI5SB/EZU/HKBIxAdeq2Ur+6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720318773; c=relaxed/simple;
	bh=VYqiYRNemk+a6pAZhRTxKZdKqeIa56MG+uNEvkIwxBo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LeXU5vwL7EscQs3f6lAHJlba/1zTlET0UlYEYMBl1bs0XLI4i665KlZL5hjf3dtWCZ/fNRtxn2SfxRd+QdzWOumaGtZAN40ULhteSbJB7K49JPbuCga+SVP8bZeVooTMZeDCaUOAIMQoyA7IhxOWQVuht1uHJeRhqWjvm2rEuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTNBjmzh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTNBjmzh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367a3d1a378so1700652f8f.1
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 19:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720318770; x=1720923570; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRaZpb5aN4G0/VcE0/rEgyB4CFYzE1yDJqn7pLzEm4A=;
        b=GTNBjmzhQop3YTWWbqllv63Mil54FApYQRyiJmDDvd2EYJ3jQSFQZPgYMbQr5qxTc2
         Ya/i/2aFpCxw3FcgUUiROj021s+0FM4d2gSqMxbwnpIo9Xus3FpPxZL2qAOm79pZDwYM
         CYfsyQdlAfQHkbFE79i1FROz8YJwdqE6tsFrIvaWhmXNw7cJRmIiFth86vICNJu7gZyW
         yXb/ZlvdEMUGW7jbu3g6/PELyqy5beEPyjsyzuGk3poAt4wXK9h1LuvVe3aR4i6NXc/j
         +Vy6d+lYDX4LxdHHv5DXNVhcf/knR2nMpvWTAZZbimXVgOV3S0ML7LcL99UYhHr8SZ6s
         jKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720318770; x=1720923570;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRaZpb5aN4G0/VcE0/rEgyB4CFYzE1yDJqn7pLzEm4A=;
        b=FvxZzB6tWgwUSnGy2PhaLA+kArceqKSCsETOjlt1/4cyrGD90X0HzZQozizcbO5FRx
         /AWq4uAWJSPN8yoAYpxDBMqVyiDFAAN7KfQEAJBOPP58ho013R6PEEIIPWE6ZxO7CAzZ
         KNx6GFO4p5vwwpxRusVpiDXvjrroyuayruIeCL+1Nu7SNMCPyjx0a4HViF+Vvj1sAM9R
         2WiX9gSTTLUj3GGJug1xZ3Oj9YCbdGcHn4C7wK8NHkGNmus+TJBssZrJl1xTIdvk+CLN
         6uAeXOwJSCvq63xx8iTL1pHR6fsF9dJSYGvC/zJcz/WXPeaZ50Lj8SnXm3Vyz8BneksQ
         d2qA==
X-Gm-Message-State: AOJu0YzkBQ8FwBY1RwaqyX9JnlvW336AxntOL2Fts7gsP7m68ap7bXYe
	vOUzbDYnYHufKQn2nVUjCtYdM7R5xU1gUifbQuROKU6FSYG/p2Z9yrWnNA==
X-Google-Smtp-Source: AGHT+IH/dmrvQrYREHIj6m/176rpi62+0UhVqdCynFA3SdqJC24G7Ttu15PrvsWgNot+xnrRufvtkw==
X-Received: by 2002:a5d:4b0b:0:b0:367:8e68:4472 with SMTP id ffacd0b85a97d-3679dd3182bmr7451268f8f.34.1720318769603;
        Sat, 06 Jul 2024 19:19:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fefc01dsm11062104f8f.26.2024.07.06.19.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 19:19:29 -0700 (PDT)
Message-Id: <pull.1757.v3.git.1720318768439.gitgitgadget@gmail.com>
In-Reply-To: <pull.1757.v2.git.1720259599119.gitgitgadget@gmail.com>
References: <pull.1757.v2.git.1720259599119.gitgitgadget@gmail.com>
From: "Rikita Ishikawa via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Jul 2024 02:19:28 +0000
Subject: [PATCH v3] doc: fix the max number of git show-branches shown
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
    wonda-tea-coffee <lagrange.resolvent@gmail.com>

From: wonda-tea-coffee <lagrange.resolvent@gmail.com>

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1757%2Fwonda-tea-coffee%2Fupdate-git-show-branch-description-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1757/wonda-tea-coffee/update-git-show-branch-description-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1757

Range-diff vs v2:

 1:  6fc335807d2 = 1:  c1e236d843c doc: fix the max number of git show-branches shown


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
