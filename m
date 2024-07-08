Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8C3FB94
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444085; cv=none; b=T1lGF69pWEceH7vjQp40y/RGakDd//BRPbB920AiV5d/cSTAoXJ+0qwSTk01mpKtshPLwlxEvNanaWC6OZ0nmPeQHXzRHZM2jI9XF9fF0rzfqO5PPIkZCvXyGAQumnmHG094rHatHzJwnfSiONCrTZuW6vGmG8f/nUZKW2teXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444085; c=relaxed/simple;
	bh=c3i1kyfiiZwi8mZlLC1iTdCTCXvAB9yS9S4SAt7Y7dk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aE30GVwN3Vk6y+wUXso35bjbmr3NXqyeFXLjrt874B9tnLH1TWolt0BtPVpySFg9CjIJA0zrLsDXlWIP+H4eVRcM2ab6soxxDpKGzXdGD1BrtS6WSu6T2BL/DYGKKhfrIhbEjVRG7zAKDaoobq4q1gdNi8WWOHZeaejYCSaidQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5E+m97x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5E+m97x"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so9693165e9.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720444081; x=1721048881; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBusxxIbnCSMsaFaUhLjikW/DK0t+/cYMNzUyZYAIAQ=;
        b=d5E+m97xK6n4gGzT7W9hpU2bwLEunbxa6IDGMsk3fZJ5zYqErlhfWbou1VrBV9uWSB
         tPr3u4vheVA4anlmUCW/NXPg7JOvZe1t3JaWK9DdAE3uHbAFOHYD0Bol8QJG7jXGuH1I
         TdfIgw2arQkR2hkYj48BvcY7343IRuMRuIpDge28kRkT4gSSXl4sOif4Rk8H/dfmkT3E
         Ji0NfnrOg249TTSGw/3K01fDY6ndmFdem2R1y8DyRRVfFbuI4QbM4YH8uji1g2YwiwPW
         rv5UGeixUSTlz3LttbEQvJhYOHPNwjS1oEsefLVat3YKlviK/Hncb1coDQL0EnkgmaAk
         4KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720444081; x=1721048881;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBusxxIbnCSMsaFaUhLjikW/DK0t+/cYMNzUyZYAIAQ=;
        b=vHl7c9abkxRS9ZWQC62qYPfXCwOjeQKt5u0kjchRSADPQVO/FnO/VOvrXS65kK6WMK
         G6zaTdw015NM4H/7yIa8mFiWGa/3M0gW5r5HhoVIOEvUCOWeiIWvw0TQ9hELMM+g/Jmx
         gxx4Z32rRVxcND3jBAHBseZpDrag1tU11gKJPgM9hn0VIQMDZr7rLKZcrYFfcz2ohBwq
         1KZMj4Rn7C6aEu5PHNLEHGxkI3pzUMRyBYDDtz+r0TwmdwWg/i1P7yY4+F1NNcnUpfdn
         Jkakf7pFx9oifVXWfvuGXzxp5XuiAUeja4+H12exz3pAp2/tjPLnySB3Y/LT0yzCf/wl
         2rqA==
X-Gm-Message-State: AOJu0YwGM725QC5XYBW1ZFeTuHXNQSBwtG0nDDOG9+YUNHCUC5IQGjab
	ceh4WWKmWNAe7vI/6JZmfk7xVagoe0CYnuPagSfzbo++KMYg9B/hs/NOvA==
X-Google-Smtp-Source: AGHT+IFp5wqV1BXWj4csG0yiF6qwrWOpmJ8n9n3gtKcfXZrMv+VvHiq5UZhIVg0j/nZ+1pDT4qbSEQ==
X-Received: by 2002:a05:600c:4f14:b0:426:5f06:5462 with SMTP id 5b1f17b1804b1-4265f06546amr47202705e9.37.1720444081257;
        Mon, 08 Jul 2024 06:08:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266a38f5a5sm37059415e9.43.2024.07.08.06.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:08:00 -0700 (PDT)
Message-Id: <pull.1757.v5.git.1720444080034.gitgitgadget@gmail.com>
In-Reply-To: <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com>
References: <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com>
From: "Rikita Ishikawa via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jul 2024 13:07:59 +0000
Subject: [PATCH v5] doc: fix the max number of git show-branches shown
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

    #define REV_SHIFT        2
    #define MAX_REVS        (FLAG_BITS - REV_SHIFT)

FLAG_BITS is currently 28, so 26 is the correct
number.

Signed-off-by: Rikita Ishikawa <lagrange.resolvent@gmail.com>
---
    doc: fix the max number of git show-branches shown
    
    Changes since v1:
    
     * Explain in the commit message why "26" is the correct number.
     * No change (to rename GitHub and re-send).
     * Change the author of the commit.
     * Fixed code block in commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1757%2Fwonda-tea-coffee%2Fupdate-git-show-branch-description-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1757/wonda-tea-coffee/update-git-show-branch-description-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1757

Range-diff vs v4:

 1:  76ab2f17015 ! 1:  7c0af41794f doc: fix the max number of git show-branches shown
     @@ Commit message
          The number to be displayed is calculated by the
          following defined in object.h.
      
     -    ```
     -      #define REV_SHIFT        2
     -      #define MAX_REVS        (FLAG_BITS - REV_SHIFT)
     -    ```
     +        #define REV_SHIFT        2
     +        #define MAX_REVS        (FLAG_BITS - REV_SHIFT)
      
          FLAG_BITS is currently 28, so 26 is the correct
          number.


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
