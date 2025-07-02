Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C191228CBE
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449088; cv=none; b=ZZ50BrLP1Ld8oOokNhpFBSFjOVDlHaFYyIRDhhx3pLbUHNG4HMKw8imgggxEPHTq7DNOecwuv8P2DVwVTBIb5FPsGR14gthhzqnsXvlNrz8r54RWsHDcAwefAOXYc18D/gRqPk1MTu2syGhAsULAFzZGCZKIoMqHPkatBHSDkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449088; c=relaxed/simple;
	bh=oIDLFQSAVvXDoByaAa592kCpcrldGe2WLuCEZNu67Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqx5teqT1XRbxRMkbSXag3W6Qy1fZq7ZMwENBTcDiL8RhO7fyPJzJEJYnjaZOG+H3V7KXfqz7WAaTVDTBbOhBD+7eUL1RVwY1iymSQXRgEL1KrktqJ+z4RSZEEykOr0TGZzKlTg8+0oVZ+SKrO1WPoHCIxwP6J/sXStlY3XXrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F31RqRzA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F31RqRzA"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c3d06de3so5065270b3a.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751449086; x=1752053886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukc5pOkhNSAsjc6u86q/SG6bSA1YN4Kyg82vsqQsM7w=;
        b=F31RqRzAsLBnZS5+z74AHdKEnmBSSTEotNQS8s/ZK8ATPCfnDePDWDOWwlEp8bk2Y3
         HCxEtnqeYOzhsEWdwt99r+9R2o001LPuwPqBo8GGz7+jp8OI7H8S6Kes/puCtAAhpJFF
         8seyEugKg+PCjw5ZPw9xXY83l3lPsyKmS3oGU2D0ICmHxrgEVgejyw5gYpSJI2MImANp
         CyG4yFU94jdpC6/9KHVCcKsZapgRqTZcxpRB+wEbo9K06h0mSJY/YECnH962YH6jBOBF
         gvjwR2f2QVXciijTxSvtO2BM15RlNf9gKgr9w6V8wxoq09NeHLUZtTVFQuxYByr7H8h3
         pjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751449086; x=1752053886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukc5pOkhNSAsjc6u86q/SG6bSA1YN4Kyg82vsqQsM7w=;
        b=mHNkgywu+Fhlni1OrpxP3nh3kdL9N/AVytik9nh1Qot1ooF8q0EcD7eAHNQlMbgNtM
         wc+1EQh5jnKRZRJw2oJb5WZYr+Ugh6yQOPiPB2dCNChxIDu0420GMMrnm8B1k2CTeugM
         g5AmCgXNpxxnzlL5JaMGlYbDhMK0RcJMqUL2SjbUsdBr2Kv14p7C0IxCGHLyWeMx07Mt
         lpoFeczLNyWDnJN6pWcNIQ/RdoDIySdqjSGIf4gnPv4LJ/BEenvWmvQirIBbwrR0L9Lc
         kxsqMgUSlvu3kkgWwBGcJGCwv4sJX7qheIYPZVwhu9pnHdgVQAYHlZpSWlJ9AtrX9WOK
         iVHw==
X-Gm-Message-State: AOJu0YzOT/TvnYD72oeNKxj3P5SNrCgsudCQ0kHok6TFjDYxecS1uAa8
	MxB5WumdbbfpEG/vIlU8FDfbIPex4szibjMY5FhJ6HwG4DfmQNc5f5mq/kk+IQ==
X-Gm-Gg: ASbGncutF7zhpy1azxEn/VJzHrCIG7hs3mNP3JkgAB1YLU788hePW48DAXDIBXarSvr
	yXWuxSYrguK9Yd6EXiEsuJ20XqsGgXizL3A/c8haZ5xegJFRWBATXzTvKyPS4tPdv4vBJO/sO84
	DghooHUQ867jsl2IH7b/WkaKFexLVj1kqIBmFR0DiDTQUCk6a1igTn+xeJcEVtfwtpq4rQJJ7sg
	Fbidoyr1LAeFDljFlVf5Tyj0KuwCiKFqIAyjQIjw9zjDUjT192Wv8RB1lPdX7TYHKVUVFqqJXjj
	zjUSs+T9mG5ePydZlI0HKJZnlfQYxjxnA6IChdsWBwiBVvXjiJW+YZM9IVgC9xEnwtwiEVCM1Vr
	ECfrM+H29Gg0k33/t
X-Google-Smtp-Source: AGHT+IEWEUvGDd/FUVWuxR3/tjJWywBXp1Daw0j8Qx7oHyS8w1/kE4CYeIAAQ+mbvwOVpA5EpUuQXg==
X-Received: by 2002:a05:6a00:983:b0:740:9c57:3907 with SMTP id d2e1a72fcca58-74b51265c7fmr2986893b3a.19.1751449086350;
        Wed, 02 Jul 2025 02:38:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5579d28sm13501895b3a.107.2025.07.02.02.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:38:05 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: brad@comstyle.com,
	sandals@crustytoothpaste.net,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v4 0/2] config.mak.uname: update settings for FreeBSD
Date: Wed,  2 Jul 2025 02:37:34 -0700
Message-ID: <20250702093736.36074-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.147.gafe0d4ec5b
In-Reply-To: <xmqqv7p0bpdl.fsf_-_@gitster.g>
References: <xmqqv7p0bpdl.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Modernize config.mak.uname defaults for FreeBSD to prioritize using the
platform implementation of memmem().

Carlo Marcelo Arenas Belón (2):
  config.mak.uname: set NO_MEMMEM only for functional version
  build: retire NO_UINTMAX_T

 Makefile         |  5 -----
 config.mak.uname |  9 +++------
 configure.ac     |  8 --------
 meson.build      | 11 -----------
 4 files changed, 3 insertions(+), 30 deletions(-)

-- 
2.50.0.147.gafe0d4ec5b

