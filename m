Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8A145341
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886322; cv=none; b=hNC05a0RiN0qBDZB+lkrqESHyiPDPtSVnldyZlNes21+QrKXPt8nsNUlu3dcjLZP1c1pI4Y+2NZNcf+IQRsoElZfqPY3sllZnxfelU3uMLZRbjkkhiPNxW4rww24QN8h7nRHr9Xv89vwJqsDjZS/kjeU1HO84sbLdS9Z/7uCot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886322; c=relaxed/simple;
	bh=v5cFP/l3ohHlRW+YDzwCx2qAzTjSelHHl422Ay9C6Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtM9hQ0VQQty9cKbrhLj21LIMlRP889pBGs2KQWDkgZRbEew341HTSFbhK4sBoH5QrzDHbWUpSHGFj8wPxnMCNIk3pj4gfF/XD9QTr/j4U95jvVOHCTssTSkiZP7NUYsBYx2G7/Y3GlEi+HcDktmBYrLVRYZF34Ub1XRgiYJXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Int1TvN3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Int1TvN3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d94323d547so18356875ad.3
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886320; x=1707491120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aWdcMNGKXtmp1ffuqi+yrMcCiMuFXpy4pp5pS2IZ6o=;
        b=Int1TvN3LUGQiPLa0mUK8AoL6at/59mnfF5vZbBEmsZK+8X8am1V/DevbhK2NdOjcj
         c25v4RBKkFHKkDMPxtzT1f30xBe4tqRJkQUgaYD4TOYsbOoXEHymnissZE3H7JyEO8/U
         Z4kp3uyLYhoBBtk96pUfi3QGI1nsLPjqvLUoiuSapRU+9+/9AYGeyUwXwM/zK1O0Mkzh
         lvVk8PwXODAF/KPB+1IhjpPV9JEAu5lQNkbQ7gOPh7tLFBUzgqQNF4bv2Px/d+ulqE7X
         lsIFUqLLkffncV7clj0oYUuI1B/eqdR6PC5CpPE2Vcgd13L9FyxheS0h6i78lQgt7uAm
         +SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886320; x=1707491120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aWdcMNGKXtmp1ffuqi+yrMcCiMuFXpy4pp5pS2IZ6o=;
        b=dB0Jt4Gx64jWJL404K6vlqHrQMXQiDa3ZSVUGZUQyf8lLERzyqoVv7O5pUqeKxWIpE
         SMHjs0b+xdKvvGVqAhI5Rsd/9yKGPeQDvPjVpJ7vmX2AZbhmKi3Y8lMJCEm5cBL5fO2Q
         EtIQ0bqUh3ZW6nd+KPAH/bBG8LGgYnMvL0oiexfuCDu6hWoAFnCGNw7lBaQiVgk4oklg
         uK+VzwjF83My4FBfMDFwcmW5JJGN8KORJH0mg8sOPiUWX0cdmnLZazw/k9uiqCDzDo+/
         pVgLmZEehE/QWGrZVDj2ksk6vsRr27McqgxCppHyn7KD6n6RDoW+7F1VCVS4oDg68viY
         xevA==
X-Gm-Message-State: AOJu0YzHq61c4KlyByDdVXyGu+Vb6qz8mQLAlF0O949E81mVX+csvnSb
	JE466oaR6EJ8mQNifv9NX6QG+BMc3/ZQkr1HbyTYQJyxF+spzt0/IZh2BJQDa/4=
X-Google-Smtp-Source: AGHT+IGlasCMMtQdmvLNUIRzB9sZOHR8W7CoUHDBe9qSqjcdR+3M0h5I0sId+KuXALGBTyXfwuHGvA==
X-Received: by 2002:a17:902:d386:b0:1d9:427a:99b with SMTP id e6-20020a170902d38600b001d9427a099bmr2295995pld.32.1706886319504;
        Fri, 02 Feb 2024 07:05:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlspvIYj+TPPhCBkVUdr4uhaAT7idz1WoNxUgzk84FMnMb051cwMMKbRDqmJqa6/Bt17vJM/9Ewm52ce6/BiLMrVXbBMPAV1WCD7k9cE8cEKwONA0=
Received: from localhost.localdomain ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d9620dd3fdsm1685423pls.206.2024.02.02.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:05:19 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 1/2] add-patch: remove non-relevant NEEDSWORK comment
Date: Fri,  2 Feb 2024 20:33:49 +0530
Message-ID: <20240202150434.11256-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202150434.11256-1-shyamthakkar001@gmail.com>
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240202150434.11256-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment suggested to compare commit objects instead of string
comparison to 'HEAD' for supporting more ways of saying 'HEAD' (e.g.
'@'). However, this approach has unintended behavior of also counting a
non-checked out branch pointing to same commit as HEAD, as HEAD. This
would cause confusion to the user.

Junio described it best as[1]:

"Users may consider 'HEAD' and '@' the same and
may want them to behave the same way, but the user, when explicitly
naming '$branch', means they want to "check contents out of that
OTHER thing named '$branch', not the current branch"; it may or
may not happen to be pointing at the same commit as HEAD, but if
the user meant to say "check contents out of the current commit,
(partially) reverting the local changes I have", the user would have
said HEAD.  After all, the user may not even be immediately aware
that '$branch' happens to point at the same commit as HEAD."

[1]: https://lore.kernel.org/git/xmqqmssohu69.fsf@gitster.g/

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-patch.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 79eda168eb..68f525b35c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1729,14 +1729,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
-		/*
-		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
-		 * compare the commit objects instead so that other ways of
-		 * saying the same thing (such as "@") are also handled
-		 * appropriately.
-		 *
-		 * This applies to the cases below too.
-		 */
 		if (!revision || !strcmp(revision, "HEAD"))
 			s.mode = &patch_mode_reset_head;
 		else
-- 
2.43.0

