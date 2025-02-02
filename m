Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6E15ECD7
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738499333; cv=none; b=FlCq8omvCyILKV10LfKencN8vvEztRJu4Jfyvs9oOrR9h1n1EwnyG9lTF1HkFI8X5X8vleXp/p5X0+Emy979GpFmNlPgm/z/4BLzN9AVVAvZXcPTixA8BNeN0zx8YcT19Vsrehktnjbk4Q2QaZknSONyWtQ6kIN9klijceRLhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738499333; c=relaxed/simple;
	bh=QNnq+x7/bNwy9jYI/CSPe/Qwt82s2jdhoqCK5xFI5bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhO/KnsBwajVhFkj5Td7FEPBzGoMhE7xMmT/XGyaU8QV2+e65LhfEZEUHP09by06+TdZp1AkagLAc4iisur37SSxlzx0n0s3dRZRQxhw+XRBnuzCBVwNc+WRgaZDW8LLDKDLM8ojQfitE0JnpJRQfZtgrB6UtvKqMVFCxe3HX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1en4qyd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1en4qyd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so4445057a91.2
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 04:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738499332; x=1739104132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNnq+x7/bNwy9jYI/CSPe/Qwt82s2jdhoqCK5xFI5bE=;
        b=b1en4qydT0mRLl3pjkZt2fq5dEhGe5XWbdIevZl6RCTdNSHugiln/ZB0zhYgoy7Z9v
         MGWSg71c6eau9Ix1wrqlyO9wEcN/7Su9JMXO+pyECuMvYAkIF+7DREMnC+c9+kMdrLxB
         yF7gTdnlDPARPnCjuXT385VxsVRYxrhJA1DQS9U5cFdLS9m9octBulSpEMyZCLUdQK/P
         Q95guQt1CJHRH64oM6w6YGfzQPisWMRejXGO1maGy9Wg0+7ydkYkCvzqVB+6m7UdCpii
         P+BQm+ha275Hi+jhQw7pj9gGYiyHulk2+DOxbx8VaeB63tNSkUQVhFYioj/ZpWP/xZfu
         ZLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738499332; x=1739104132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNnq+x7/bNwy9jYI/CSPe/Qwt82s2jdhoqCK5xFI5bE=;
        b=IacWVFm5Jo/JqexYOcZlEKFl8bHQORQuw0xWSykJV6EQ4gvuhdrLjcHYk2ZGvqhDCq
         kyqFH32ZVwYI75ym3mMDgXlQLVeOlozqM/CsqhUhHpbnygbs+i8+y/qn9XJgdcwgqwGM
         vSOYrJEmkgISixzk8e7lh6EwrYLiVxr2IdY+W9cRom/jI0B/SiTqjjq/hj5lJ5yZW+jW
         zqPEAxg5AFLrCF0DjCc2XW7+kRgPGphCv/4jmvfbcJf2mnanIXapDOwxjFpOJb9WdxJm
         R+L1e22gUHRiVfOpQ5HUTe2G3vGaqlD6CXIrjyWFGNtDy8pFjhk6OwOpjRQZem2S8vp1
         fPyQ==
X-Gm-Message-State: AOJu0Yz76AiyeevAx3fqMF0bLM2KuavDdApk63XHyYmHDieynt3xjf/a
	vk9elu0rg0OeQgEflfoPkU1z90638NnchiXkybngyFJ5F8M0eYV/wtnjmDDgMWRXTQ==
X-Gm-Gg: ASbGncvmv7kgSy0U4e7s5d0eeQbsjtEt05PuuTuub8FM9Rf/aL1aIdaO0q8bqUbrXDu
	UHKZmJ4ZPtMIsG8B0/coDrfnluex896wbQ+6QRo5QcN6EynZBcLvogcM0pxsEZjWRyuepqW8dPz
	9OyV9a/FO5fQD/VJiuiKDDuIS8tivJ257FgVa1jdAuoTAzw1+nQTUbt0UBc9n1K2vjs8fu+lAoU
	eMxBAUz9TPbu3wHE/rtm/bv6X4lKAiLpz88qEUbksck5aC+b1MXnlB9PyWfX29jFdFy+HYDQrZe
	2Q4YLJB7SRAJD9a+jYG2o1hl/UHiLHIK
X-Google-Smtp-Source: AGHT+IEPjKoeEN5FH4ZQH/q7PKWHfhFnRSPGonUIiz+RdSY15nPN56VvJ+ZMYLeDecOGK1yN7UOyQQ==
X-Received: by 2002:a17:90b:2f0e:b0:2ee:f687:6ad5 with SMTP id 98e67ed59e1d1-2f83abab725mr28973261a91.2.1738499331739;
        Sun, 02 Feb 2025 04:28:51 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd0ce4dsm9310860a91.27.2025.02.02.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 04:28:51 -0800 (PST)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: me@ttaylorr.com
Cc: git@vger.kernel.org,
	peff@peff.net
Subject: Re: [PATCH] rev-list: skip bitmap traversal for --left-right
Date: Sun,  2 Feb 2025 17:58:37 +0530
Message-ID: <20250202122837.335101-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <ZykTwaWaveGGvapw@nand.local>
References: <ZykTwaWaveGGvapw@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,
I found this issue quite interesting. Would you like to discuss a bit more,
maybe about how to implement it?

I am looking forward to solving this.

Regards,
Ayush
