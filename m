Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70561F12F2
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263860; cv=none; b=rz8eP70j4uwyf8QHuCBIbN5zU/nFPXKY552O8f3zhE9oY6hlW5JjOahnZ3IBJDkSiMwHZ9tdUTTEeqY1kVEAlC3LLCXgQkgnzgMpSsdoM3oYd7ObW4LuCwW6JmpHApF8T6wDmtlqtjjnfsi5Njp41KYZrWZyfIFpaaHQyiA8y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263860; c=relaxed/simple;
	bh=QO444lh6UAGvQI8NufzeyhxcB7Tn6BILaTBGCxPQnRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW1tFQzANGpZhp8bP2wkPWzYxgRuWOCa2F3+z1STex9GcYM19TYC10LKpfIwi2blCKpTlSPmLul0zvogYXQ4BPSAqDQRyu85avvWp61LrfWxBWLlTakI53pGN0noXXEjbF4IAUKfnmSdoeQCncEd7Gg2mfRjO64pCPu4CFIOVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+1v9FY9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+1v9FY9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f61b01630so54160295ad.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263858; x=1739868658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57U1MVJyFXhBLaUB6ZU7XT27Jt1zemFZbnQqBPCbRSA=;
        b=k+1v9FY9O4WSnPjBLkx0bfA5rUInHt5Kj5sVeG7RGyunGlbCkK7cG5AxS8d1OhUgBO
         skHDJeQLvOyLazqkjvITOlAMmTyGMNrk8T9U3XbSvJdL209odkEH/P/z4vLy/5Bpragz
         ypo3OUyKZz+9PmBDoh9VCY15PUuDS9j7gFGqVgaA5FL9Nk7KidaB4ZQ12P9S+bZk1d5Q
         hJFs/KvgkqAKiMwdcC4sqENcd4dkHgHVLUfH7yDc67tP2u9GWCSykufc0dLEX7rmZ3Pr
         VcnM88K8TP4RAnTAUTu2d5Ldr2ReDxWs4fFsM8weUUzZnDCzOVCeIl5PYh9nTZFvALJb
         hBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263858; x=1739868658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57U1MVJyFXhBLaUB6ZU7XT27Jt1zemFZbnQqBPCbRSA=;
        b=t0v20Z7SG5a05m00tj5wZ93Vz8dLBgxRdrPm/KruFo+RdTYdofKCyr9LkGkLJ6N4Bu
         iKo7RRu4LSd6CgVE+hZdP/uKDAETc7MYB2KZ/Dv3vMgG1eIHvmZLZDQi0d9uQ+XLOuLJ
         FRsLAyfkiMYM/8Hh0DOKBXrKIhCpniDI6vlVKZL0hrzs/p0p7d2NNnausjb3J1rjZvdu
         ppVvLLIArT17uvPrjjYyXrM9NbLzBflZLEL4T4g2XCo9q6QGe3BoIDRS0vIK/sxMAkvb
         KjCjlwxj1ev/UuFGXIEiIC0TcAG5Z5clQ9j+mPUywI7p+N48rVxNBl75zA/JFcP15EL7
         HjUA==
X-Forwarded-Encrypted: i=1; AJvYcCWCQEkzY54chdpYIlVgVudL6P820qaVrjCpuscmRGhFIyCvuh/+PFp06jQAJ5/G9iTdUZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjxlh00KlvMq2FD91JHQLwCmSKUzNzCitOh5TDFRPB84UUnZc
	dvtg7uKfjb+Sqk6Nf/0oLlIkTHQkLrUpdc6qYhebzbYpHQ0BSRIcz+FPXkO9
X-Gm-Gg: ASbGncuLMUYf0rPIu6epwMx95riXx0EnKIJ3lT+I6CFgW1wMSaqCeLEeckpVbFBvo4z
	A3v5gyh2SKCNkAoCLOjUK2b1bpodTyvXCN2f9kCtJLS4dLBAhp4CrrvnCf3iXFoJgrHiIcpdqeV
	bxeLzKH2H6ImlDSPQwbOmC+8e0DKtykHsPCmQHhRoHmpzmcgDGCddKlPsf2PmP9WLokN7fYYJnQ
	cl+cak9r7zQ0e9V7DLSjpIE7jBlRUotcnnYHp4sEAJ2J0/oNluq9Ri7DJcbK+tPS6hjJbuPJxDu
	wZ1PCq6n8cIqeobDZSPrALHi2PxDC9DerX9jqzg=
X-Google-Smtp-Source: AGHT+IEaD6UlQIfaEajaKF3dbo0j8jCe9T7FJF1v2+Vf+E3L+bnK+QUi5VRlJbqcGgtzfUodcAeecA==
X-Received: by 2002:a17:90b:4d08:b0:2fa:2252:f436 with SMTP id 98e67ed59e1d1-2faa07da202mr3874008a91.3.1739263857907;
        Tue, 11 Feb 2025 00:50:57 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:50:57 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 04/10] diff: short help: Add -G and --pickaxe-grep
Date: Tue, 11 Feb 2025 00:50:16 -0800
Message-ID: <20250211085028.3923875-5-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-G and --pickaxe-grep seems to be on par with -S and --pickaxe-all that
are already mentioned.
---
 diff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index 49ece3..787bb 100644
--- a/diff.h
+++ b/diff.h
@@ -606,9 +606,12 @@ void diffcore_fix_diff_index(void);
 "                try unchanged files as candidate for copy detection.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
+"  -G<regex>     find differences where patch contains the specified regex.\n" \
 "  -S<string>    find filepair who differ in the number of occurrences of string.\n" \
+"  --pickaxe-grep\n" \
+"                treat <string> as a regex in the -S argument.\n" \
 "  --pickaxe-all\n" \
-"                show all files diff when -S is used and hit is found.\n" \
+"                show all files diff when -G or -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
 
 int diff_queue_is_empty(struct diff_options *o);
-- 
2.45.2

