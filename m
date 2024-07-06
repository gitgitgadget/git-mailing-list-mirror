Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48293481DB
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720259604; cv=none; b=CkJgHii9vmcshAlcqv44eJ0EmI9MuajxrP8AUkeKklfwxYuUxsDnt2nJsLz7mzd7/Yj/i4S3jG65is5d7a+BbIiMx7c0Av+ot7yyEj1Vkk70Uav6FLda9hTuCQnNC8yKtQLH4ORXdKb2J6yO3F3ijXusJKNUEU34bmbUEdlOD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720259604; c=relaxed/simple;
	bh=tR9Vcvi0xvGJ8s9R1/CrvV58aQyaDHkDko37/IABRgM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D57AjEHwLMe3YfKOmaswK34SHvS+NjpmynuL9u1B9KxTQ6Js/n/idnazTY2WRc2I1ps+q3+vSWwQeO/bRDIukzbh+HA5C7xRB5tEJCGSXMUaVQ0ACgAkrLXd07QKkYpV2rZbkLP7GRr1bne8/CbWeSVpxVDJihY051yZpDR7clw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMVftCiy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMVftCiy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367990aaef3so1602216f8f.0
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 02:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720259601; x=1720864401; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkP0siNCEA4BAuUQmMbb/BhWZRFlysV1X/xMvGeR28Y=;
        b=FMVftCiyr+nS+oyRQijkWoH2bkGck32NuAWe2pSVDOW+v8svvESb6PNT8TB/ftTCgb
         7STtU5i77YhPgy6jgAZJsU2dChhTbuynzrhZbmr79h2sqEdyarxqp8p2usN3gaiXazUi
         MIn3DGkio+xsUMe7ux4BimuvWlf7GjR4x1AHInML8GZui2UYxaRNk1P3i6G6UQ9Gw8gd
         WmcmclUaghb080x1Z9U9VK4ckLJMKwVOzemV0fULxJoTCRetDI61YhQBBL+SeKrzs5sj
         POwe6Hol/rECY833Se/pwg1cuc03Udwt0ejDombrKc5vcgAtC/R2REgqZfCcflY5wXsn
         oHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720259601; x=1720864401;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkP0siNCEA4BAuUQmMbb/BhWZRFlysV1X/xMvGeR28Y=;
        b=Zxm5r8VDHqrpz4fAFRaPEUmW9MJIJY4RDvia8/Mg2WAP/p3lDOgY+d89SZihcjuEVx
         hEMKygILtIQ3RdTFZSDvdFeYgUgv7hHh4h/Q4eW8TnRBe9kUzx/ijvWx171/yNCWxf+u
         0SMFG4QC8XNYpEDmRunA+QNOWo1JunwrCLpbdCbZ+Y/N1eXspO0zknz6wYW7qk7tjiNF
         JpyBbIqONFqI4qG6JGT9VR3DASbOx+DEtwaKGA1E4VKnlDrprTCfVLkzT4nfflZpi6PI
         pRjYsD7YPMt/5BWYA7VcNBD3RDlsLlv2W/2LXw3qAfKaqM+6G/2Xt/79rBZWrqmUS/Ii
         id2Q==
X-Gm-Message-State: AOJu0YzivaLznNZd+ILONycZIThIB74fnzZc4zsVFU9TT7ec7n9BjlDV
	57JC5Mv6L51TOLFRpwj72jQHRWxT4hyn2MIgD7hX0KPuux1+L8WezyK3Sw==
X-Google-Smtp-Source: AGHT+IGv0tUop3YjbOSNzhkoK7n1amWMhCq0KJ09VZT4bPsVsTNR7tzNVPu4qMhlvhcHD8YnMseJ/A==
X-Received: by 2002:a05:6000:d89:b0:35f:276c:f3ad with SMTP id ffacd0b85a97d-3679dd34e29mr4416847f8f.40.1720259600778;
        Sat, 06 Jul 2024 02:53:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a2ee695csm4856352f8f.98.2024.07.06.02.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 02:53:20 -0700 (PDT)
Message-Id: <pull.1757.v2.git.1720259599119.gitgitgadget@gmail.com>
In-Reply-To: <pull.1757.git.1720046185710.gitgitgadget@gmail.com>
References: <pull.1757.git.1720046185710.gitgitgadget@gmail.com>
From: "wonda-tea-coffee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Jul 2024 09:53:18 +0000
Subject: [PATCH v2] doc: fix the max number of git show-branches shown
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
    wonda-tea-coffee <lagrange.resolvent@gmail.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1757%2Fwonda-tea-coffee%2Fupdate-git-show-branch-description-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1757/wonda-tea-coffee/update-git-show-branch-description-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1757

Range-diff vs v1:

 1:  b809d610a36 ! 1:  6fc335807d2 doc: fix the max number of git show-branches shown
     @@ Metadata
       ## Commit message ##
          doc: fix the max number of git show-branches shown
      
     -    Contrary to the number listed in the current document,
     -    only 26 are actually shown.
     +    The number to be displayed is calculated by the
     +    following defined in object.h.
      
     -    Signed-off-by: wonda-tea-coffee <lagrange.resolvent@gmail.com>
     +    ```
     +      #define REV_SHIFT        2
     +      #define MAX_REVS        (FLAG_BITS - REV_SHIFT)
     +    ```
     +
     +    FLAG_BITS is currently 28, so 26 is the correct
     +    number.
     +
     +    Signed-off-by: Rikita Ishikawa <lagrange.resolvent@gmail.com>
      
       ## Documentation/git-show-branch.txt ##
      @@ Documentation/git-show-branch.txt: Shows the commit ancestry graph starting from the commits named


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
