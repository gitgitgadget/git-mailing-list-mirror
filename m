Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5D4085D
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719178822; cv=none; b=ON6XdSZcyRH6Aq/oxgoPOnvNhBrgdQYt8mccZ5SpYXO9JOEYiiRxMhQAXST6x/fQbVQ1HCl0qeJ2e5YWizzgBef0lvvYvu69u/o9FT4HSQeBqj9B82UDj82h2+gvMOnpmBvnZbfHkRifHNvKVlljSYJBuKp3VhAufHJOK2h/Xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719178822; c=relaxed/simple;
	bh=m6ZnCD6rc76+PTCBlptsdX+w1zflkGzO+mId+28WAeY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=YqyRULRqtErJ/l5nvjcNF+yARbFRAZ1TdRPSL8J9/W44JWYcEpRD68PsUt7GQG+S7b27KldgHGmKIgCzppdwYcgzgZJRB/JrThi9TsnBhtx2o6zBMoSc1C53IxsDt9NsIJZP16e2Xrg9jN0xDGT+lmAyefF0vhfks0mBwdbXe8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3VYwrjP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3VYwrjP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36279cf6414so2848736f8f.3
        for <git@vger.kernel.org>; Sun, 23 Jun 2024 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719178819; x=1719783619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m2YZMtCy6/OzjpMevV9qqSyge6tZMjj4vUfIYvfXOw8=;
        b=Z3VYwrjPIiZQTDmND9YNHm3lCvumPCDRYfHChA2RGN6NnEg91veGd0WXSr0EcT+lCk
         Ue4NDMYx2P7baQX454bfQKEddj6m33/uAoLSj6beX9mxUQovpY/DgLTXlqay4RMuD7s5
         A3KZ+QlddTTvkhnlJns5jzKk3Cv3Idp7Ozr2WshTyHtRb92e/YVYFt/nPMZdb+al8nuj
         U8PxRwYhb5K7G1icU2igEyhZAD1ChqMD95i+udZS5l1www0VWDOIHY1fXcx+nRvUDhqB
         e8POgWnfupNe25+6vuuxioiRf++QBKnACd4LqjiL//83zgvWSrFVG0/9l3sbYKzBw5Yr
         X2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719178819; x=1719783619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2YZMtCy6/OzjpMevV9qqSyge6tZMjj4vUfIYvfXOw8=;
        b=GX/ESRAPLCBlC7tgn5NhcBzb3jrVvNGx14o/nQRBs3BbbP0RdiPMWVAzuEqJSH7zHU
         a1hDN9lzMbu+ueM3CR12HXvhUAGra8EqAOW85Ht8TnSOl/iRbg1n6lYH452W7yfrX8WO
         ptuCgHEWl5TVyc1QI4zNadKjd/5bfVRjFK0vEPW0rdVFcEtLBuAESQMaXy3/QFKjBhrp
         I5wpZUwCAbDO1WAxoa6DiKM7qlZC+5dDBntaC1GsYnOMT6P4aq2kD9Jk92zSASUAOSkF
         irAP8Jh96Vrim5I0Ckz9ROk6R4SJFTYK1Iv5zYoKQ0NLbuE62CkrrSa9ex5GluQeeb64
         KHnA==
X-Gm-Message-State: AOJu0YwIO4/5Rfqrm1b22YuD8ClaqBIPDvXjcQ+FPrOtUbt6GNz03Cws
	BoDSi0hr70TuGZdAaIU73XIxnRjaIsqkh+pD3AriQJ4H56rRv+LuY4OCSw==
X-Google-Smtp-Source: AGHT+IGbMJkUQfnNmT6akmJaPQFDTPSlK6v/B7pqx/yg7J96ruC1dXYtxdX25vKNNysalBZTEK3+hg==
X-Received: by 2002:a5d:43d2:0:b0:365:a3df:b114 with SMTP id ffacd0b85a97d-366e96442b1mr1345619f8f.61.1719178818464;
        Sun, 23 Jun 2024 14:40:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366eef51a14sm1837422f8f.83.2024.06.23.14.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:40:18 -0700 (PDT)
Message-Id: <pull.1736.git.git.1719178817386.gitgitgadget@gmail.com>
From: "Shane Sun via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 23 Jun 2024 21:40:17 +0000
Subject: [PATCH] doc: fix case error of eol attribute in example
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
Cc: Shane Sun <github@waterlemons2k.com>,
    Shane Sun <github@waterlemons2k.com>

From: Shane Sun <github@waterlemons2k.com>

The eol attribute only accepts "crlf" and "lf",
but the example incorrectly capitalizes "crlf".

References:

- https://git-scm.com/docs/gitattributes#_eol
- https://github.com/git/git/blob/v2.45.2/convert.c#L1278

Signed-off-by: Shane Sun <github@waterlemons2k.com>
---
    doc: fix case error of eol attribute in example

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1736%2FWaterLemons2k%2Ffix-case-error-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1736/WaterLemons2k/fix-case-error-v1
Pull-Request: https://github.com/git/git/pull/1736

 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 80cae17f37d..e6150595af8 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -374,7 +374,7 @@ explicitly define the line endings with `eol` if the `working-tree-encoding`
 attribute is used to avoid ambiguity.
 
 ------------------------
-*.ps1		text working-tree-encoding=UTF-16LE eol=CRLF
+*.ps1		text working-tree-encoding=UTF-16LE eol=crlf
 ------------------------
 
 You can get a list of all available encodings on your platform with the

base-commit: 9005149a4a77e2d3409c6127bf4fd1a0893c3495
-- 
gitgitgadget
