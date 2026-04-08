Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6242E06E6
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664085; cv=none; b=Ng2aC3/Nyb+kGwsP6GTnuoIjxLU3xptI18MqBCdrA21mHBAmtzMoMoTS2MtVd5va5RvA6K9WiG2wzW2xiK/5r/NQ6pfFLHdzWGKDpLf0XJP5vOp2r4LpQ8IiCr8o9YM0njYxKszsHA9jPQwbqeJxK4x36JRCGddUytU+vxoB5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664085; c=relaxed/simple;
	bh=+GhJJ+qnONiCpI3YGPB8uOTOYNhydHEV5ezEyIBycf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciUpp8b6L/nKudS1jCWFWYj6wf/IeOE3jxgj+JWMinamjUysQOfKmYLzelvxu7dxZeilUteYIEaK5+KuHkEOWO7JBtJX5vAmI5tifuTrE6zLLPBGoCM91v09xv2iyeJsruXNjtWmTk+QPSwNTSrYTlSMXFxi0quCE6N+qKglxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFof5ScG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFof5ScG"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so16872a12.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775664083; x=1776268883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FplesCmT3ATePXQcxAQEs7WUBqvH88lU1gBZ4xu8nk=;
        b=PFof5ScGg6A8CBjCo2k+mkfn4Q9VWEn8EkqGNVdxSSbrV9uQWTLfdwkqxCG0Gw1hGh
         h8y/gkNfICXcLJbuGogGfHO4z0ozWp4jpP90uEXM27fNzGMqUFRurEW4AnqLvLXanzUC
         6o9Bc7H+GEGO6YhpRvn9wRNDYDvNjSsDwJEyYjRXMdOd0ruoGk1VylooB/9K8Lf2ixv/
         W5339aXpw0zDfXck3HFbDmdcZtpJnYFEhUKEzxbEDl3JSrBtn3K1wVS2jWjYU2C0VAu1
         kFLuAkzZMqN2NJbh2QtvTrJua9da+vBM1E2bcqHj3WRzrrm1b73qJwlZnuI9Li1kxsbJ
         xGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775664083; x=1776268883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FplesCmT3ATePXQcxAQEs7WUBqvH88lU1gBZ4xu8nk=;
        b=F/knHqZ5mpbA3D9YbHvfu0nFVmQu6Z18T3s3YrfwEvZxOpN9NTv51cG6SW5wpCRY1G
         18qzM9TJVg92TlVZbqSsOrgECIsPgqqEg4lg0oIPRYK0bV9w44Ei7QKe+fk2ZQcT0eNM
         Vc7gI2bLbEIumbBSlNVQNrmDy/ZMoggzXIrPWqKRm1P3/HdIc4cJXxwGq0zjvrBoy558
         Z849vpi+X6YB75gbVD7i+xkd584/0KEDB3x+nN0abXhErVtrbeQGqgSATlvnCgYOwE2e
         Wt8MJtnNFFnGnUSHpHZMJZnE4/itIIGtf5nf5p+SsTCkkohsZW59fTu44owjzOFJj8gj
         t2ag==
X-Gm-Message-State: AOJu0YxzZcjZVrqbSJU6F/tPivZyUPCeV4YC4eG4PC1sCMrDaTPWPsN9
	J0MHa6Wbqbt3u3ipj5aVjH9zE4mOOf8hv8l8qicFqA1W2QHHxxH1cWW7
X-Gm-Gg: AeBDiev/rLMLWju5KZ1rUj6CBXKw6EW4UWvPHC8H/vSP11N5s/VGLTe5ZW+R6M+f8F4
	GBT/nkYzlkL4mCCOqTL83ov7WXCcrPSUfb0L7D2Ea8xxWVBP3RkxAvx5ruEzGNJAei+hjk0BK6j
	0lUsQlWvkoRv5H5jMKqBDpQkmmsRphiE2naBrCvnWeuRXF7ohBfXhPadpHjHVAhdNY+CxwSM5Ls
	grjNU/1zH9cEBudoA1DuzyV8KBICBnhU/VWdS0v2h7QV3ulEUl/0hRC88ArTFqCxv3hjooQMt1s
	SdjGwQctoCFHt0QQjWJJBLbPJNAxA2kdLNWn+IfHFnZZI7ieydEowNeLBSFlhbAvNhTgnxfnoWL
	ROmI9JzZGNYdSsrz0g6r1nxBqz17wZNSaytov3c/edtcfxI1CGPHdE5R8NoiTThpFIVVwTWJAU5
	jh1hZatHt6yx4o2qoel8pMZ29No4ldUoeh0gBqMK1otrLDFf0=
X-Received: by 2002:a17:90b:1dc6:b0:35d:a843:6b1f with SMTP id 98e67ed59e1d1-35de6899ce5mr20937356a91.11.1775664083104;
        Wed, 08 Apr 2026 09:01:23 -0700 (PDT)
Received: from Pushkar.localdomain ([49.37.115.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f27asm42822a91.10.2026.04.08.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:01:20 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	peff@peff.net
Subject: [PATCH] archive: document --prefix handling of absolute and parent paths
Date: Wed,  8 Apr 2026 16:00:06 +0000
Message-ID: <20260408160005.193621-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
In-Reply-To: <20260407162101.2285-1-pushkarkumarsingh1970@gmail.com>
References: <20260407162101.2285-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify that --prefix is used as given and is not normalized,
and may include leading slashes or parent directory components.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 Documentation/git-archive.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-archive.adoc b/Documentation/git-archive.adoc
index a0e3fe7996..086bade6d8 100644
--- a/Documentation/git-archive.adoc
+++ b/Documentation/git-archive.adoc
@@ -54,6 +54,11 @@ OPTIONS
 	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
 	rightmost value is used for all tracked files.  See below which
 	value gets used by `--add-file`.
++
+The <prefix> is used as given and is not normalized. It may
+include leading slashes or parent directory components (e.g.,
+`../`). Some archive consumers may treat such paths as
+potentially unsafe and adjust or warn during extraction.
 
 -o <file>::
 --output=<file>::
-- 
2.53.0.582.gca1db8a0f7

