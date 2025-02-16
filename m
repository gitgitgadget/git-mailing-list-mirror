Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A02B672
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690973; cv=none; b=lY8z+uhtwDD1MdZcIqtpU0Zgi/v7jrJQnz+RkMyxVXHxmzX7agaclEg5rWOq2sm7JDP17UaipRc4L3ijCuUZ/TeWLN271QCc/zqLC9HK7jEKBQkWNpzukFuGfLjQXBd/xrzTpWWOZsqQwQ3m+O/B+SQOOMZXTfhBd72KDgHFj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690973; c=relaxed/simple;
	bh=rciC0SW+Yr/5yaagmpTvLXzLbX5cm7lphEzEdlDe4ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZQqS9Jko/NEX80NNy8kXakIU+rr5XTn0anohYFYKDJRI9OMrCaIqKEGr5Dc5QVIWzIY+3+n1gRGN8VCS3Vg69REQdz0CdBF6/kU4Jf+gifu7oDNos7amGkCqOnbZi1m9Cqmu+qNdWwzNARa3V94vfsGIRcQL9t68HDCu4s2DhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnnEZKfR; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnnEZKfR"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso4847209a91.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 23:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739690971; x=1740295771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4CbWcd74Z6/kZLn+u1JJGKCW0TTt5p5nuDEp2pphoc=;
        b=hnnEZKfRaZg3rRduGiI+NLYitE7adnDgVmUdjxhIB0oB5ICcprO8QWvgvOwE3QHl0D
         5KFsb1X86aiSDa+kg6f32w9J0rZtVAhDhnl1I006OfLlXkM2AV++saHVITotlAgeZdZ3
         vKRXKlK5mUcxaOemia4n6IUqbJrq9g/a2h1CZTvodl6vyzEXywhsnvLk4XtFKP1TKtfy
         o8m8T5spWmRUAjdIniUcylssvtG0qImMbshQFXfmConNMSmHZMqptqP+/SEtp5cZJ+BV
         yDlnZmkA9Dmjs5AyiUcffryqTahjBcHnvR95rFZONTGUbtyHjt8jUQ5la58DAiVroHYL
         tvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690971; x=1740295771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4CbWcd74Z6/kZLn+u1JJGKCW0TTt5p5nuDEp2pphoc=;
        b=buETUkeyVbZ4pFFGS0n5NqHMg0zpyxglRcivDjFCjol+VeJR3EI9gWjIpDTXCV4MWa
         IPvBquLTGyC8Jh5lShyA7ZK8EtiNSex1fOEdvAqEkM8N2z8tcsrvBpksuD24C4I0wGAW
         3XaOhk2uxseRaI3GSMUCpPfbsXk+8s2K7go4wHhrhJrjYMjKNRL6UWjBaLI2EIFbTlfK
         j3T+ADuBD07IEhbmhAd4VOeG63JUEqeyQRALdnwg7gdyZk4x+3Beph2aHF9N0i0fC7ZB
         8ig+c1Shcd4jXYkGX0bmsrmmxj0XUHcpCEXujrfK1YvhxWVI4r0226pjGMVmR08ZEzji
         FEOw==
X-Gm-Message-State: AOJu0YxFJ9hm0jJk8BWDxBZ6pH0OUi0OYKPfLm2crur/hsyGb8+HqsKK
	+wApgvzTrMV+SglJwsMPNVc7E7caTbAlhG3j/vVg4+Qs2X9ddMWYDtf7Cl58SdeuwlgGa94=
X-Gm-Gg: ASbGnctM0PVyrbHS6niSQHeUDLb51vIiniURguc3Y41iZg/4QZhXHfoE6pP7aoDm/tb
	hbmQXZQcyLJyOqOK8F/6Y1f0E7MMWLar4NBSeM6z3VPJhBev6ujUaYV9q/QbOgHaHIaO66sTQQN
	FOwCIwcx5VNfV0eaVxc7yVAON60vOCsyZewYMaTHcJDFbqxVf5blaFmCe+N+vGW3SFJX4OibxNj
	JcBbbv0VbwxgaRYtZNlQuhlRl12PQuDS6zQHwqt6iGjqHRbdJP/OaWvyX2Qq4KzbVvgAIAfJbu+
	RpUhatEiF1lgJoOeBW2TBF8CoQPrmmz0dXahHgmG0ae8Ng48HJqFnBenV3CUYQivVbBnJuUa+gs
	5S+NroVnWd8M1cOUlKU/zascrjcGFcyN3fw==
X-Google-Smtp-Source: AGHT+IEJ2XA5Up3Bq5p2tPnGmonZ5YhDnbdHjpIiDq+T+iCo8ccDX+0CNeFpy45GttFNmBfaMhuOiQ==
X-Received: by 2002:a17:90b:3842:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2fc40d13ea8mr8586866a91.4.1739690971038;
        Sat, 15 Feb 2025 23:29:31 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-166-75-244.ap-east-1.compute.amazonaws.com. [18.166.75.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327a9d68sm4483243a91.1.2025.02.15.23.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:29:29 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [PATCH v3 3/6] apply: do a typecast to eliminate warnings
Date: Sun, 16 Feb 2025 07:28:40 +0000
Message-ID: <20250216072843.72385-4-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216072843.72385-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250216072843.72385-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git_hdr_len` is an `int` variable that can be negative and is used to
compare against a `len` of `size_t`, which will trigger
-Wsign-comparison warnings

Cast `git_hdr_len` to `size_t` after an above-zero check.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 4aa47a22b9..ac3e599bdf 100644
--- a/apply.c
+++ b/apply.c
@@ -1592,7 +1592,7 @@ static int find_header(struct apply_state *state,
 								size, patch);
 			if (git_hdr_len < 0)
 				return -128;
-			if (git_hdr_len <= len)
+			if ((size_t) git_hdr_len <= len)
 				continue;
 			*hdrsize = git_hdr_len;
 			return offset;
-- 
2.43.0

