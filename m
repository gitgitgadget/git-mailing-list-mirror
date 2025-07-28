Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDA217F23
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734057; cv=none; b=BniEpt8p97dwYPPAGi7RxTbU321ArwogpIicVV0niTlT+uStcy7ZZR2espsZdiE0Tl0gLvP6fCpNaJTk+QF9TZIxc2RFaRdWc3fAY5kSyFcnepfsBlyBtizBBpI0Vs8Elm4a4fGb3ePCSPiZi47lYGzRMxb2r5hrIdnMcveu2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734057; c=relaxed/simple;
	bh=LGiGeIcC4yALE9lAVEAHnUamtwyZxR0G0UeisPBOSew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfueQJ3gVP+6MhEZG5nruwMhDZegGb71vajglLAniAwKvxnHbVzLdhwkIJPJrZth5NmUs+IXPRh2QAkHbOR1MUOlPbuXVRHdvIX4hb8KloQkDsBP7dcsu3ZBU+Gx9fp01NjeEOsr3sGsG/bpyxZ1slU8d5LVGWaeCS2Kso2/SiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAZWlJmL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAZWlJmL"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae35f36da9dso997914766b.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753734053; x=1754338853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTlxiUqRP+1tZtd5jZ2CiUmgjUNFUSE8ZIDkL6anHkE=;
        b=UAZWlJmLdN+QySykvxKp6XjmQEXuDGsQY82TUU2Cqc2UMCt+WWpmpptAas1oU3F35t
         R+3gtDcCfpejcZMI9l2meEOkF1nC9eeWEP2UyI+1cCfVLwHsogF5KaQvXamYNyDN9W8J
         HfslRz4+QOrVXfkZgYcTB2DiBv8l1JGCpkTwLwf0w60I6RbzSM6EPphUptF6s7Z6/HGy
         05TxooL9rdCrUcN5zUCs0MAOTbpl9ujgev2Deg8nX273tfB3Xqh5jKpb7FmYNxlVNLte
         mtvuqpk6tBWtJKqXa7zLAi5c0GKDgT1v1kHxo00MZlDiOeb2xGbbDTqbSV156x4GiClw
         g7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734053; x=1754338853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTlxiUqRP+1tZtd5jZ2CiUmgjUNFUSE8ZIDkL6anHkE=;
        b=KB3H1hOnK3bjjJWPD2oDKTKmG/vmqGr9NAUlk7+bl2bWHY2kWd2XuRjMZOFZq2yI4B
         +NLwKhfc6ok84x8b5jgjEMAdYDRZMSJ5IHOwZEGbUXAT8d0Smo6thN+IdvDSNjqiHSY/
         dR6fDOGQtOQVstsHnKf1VpGZH/rkKOSXjlPCwmyrhLNlqAnYxf/dLmbCZ4E5nymhBWv2
         Sh2Y+VjlhrOOzsa8CQxYGjbaDkluCVm2EhQIvp3Iwm3GzbtHWzAUZXpxOTNPkqHpX07t
         o02Og10byS2yw/p40SEtf0hHWQHZjXsaCDjr1Ob0L1Si0wROF92UWKs7lLuVO9dW/g9w
         kGTw==
X-Gm-Message-State: AOJu0Yzf921f+Xw+gJdNQi1yAfr2n8yUqMlJqFhwVP/KK/YrvPGL7Ezj
	euDLH6bjUnHl+Ahpf6j9a7RRkQg0koSvVliIK+wfxp9FInGkcpHKt0FZffrdg5Il
X-Gm-Gg: ASbGncsxCwvSxjNW1boXZiOW7W5qzim02Joy1bl1UPnEwNxFPe8AfL4zhdYuHj0Udq3
	3CoVnsyG+Fv5JA4Su3nkhSEw1seLw5yJs8Fewsj3sGnwX0arBy1N2AbgKouUQCnEyF5OsNYW4g2
	qMJslwHSkglHXDgBgywUlSGcETnaJo3mMntV5Pl5JuYrdtigPqofwX0+nR3rHSc/HHvHs4APK02
	npwSoZkFBv8oBq/2FWglbo1VY4W9a9KCy++EnYIN0bCvg/DR45Iiy7qFoke3agQvNbrZr4wrV5K
	VweNWR4tRe5jpCsHe+CFkTT9O1NPhk4C+SW23q5t/+RXcYZnGRR9/tDvT6O94YlYDtALEdzOSp3
	8mhvRMqb/m8h/GOPxSQxgRveHzCEZRwOhepEA6do=
X-Google-Smtp-Source: AGHT+IHJ8l0w1Mj+tp2CV1FmEB55HKAA26lM2FsfBspw81wuzQ82/M4+y5qUbiJNLb0QKUAmXCFAfQ==
X-Received: by 2002:a17:907:7205:b0:ae8:fd2d:44b8 with SMTP id a640c23a62f3a-af618bd8210mr1444988966b.29.1753734052611;
        Mon, 28 Jul 2025 13:20:52 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9706:c2d9:b21a:2042])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62ab9sm475376266b.86.2025.07.28.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:20:52 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 28 Jul 2025 22:20:46 +0200
Subject: [PATCH v2 1/5] ref-cache: use 'size_t' instead of int for length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-kn-small-cleanups-v2-1-d3021c8bf471@gmail.com>
References: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
In-Reply-To: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=LGiGeIcC4yALE9lAVEAHnUamtwyZxR0G0UeisPBOSew=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiH26LOeZ8PiQGIi3abVVgCM1wo8QpGQdk3z
 b1Av9x5N3ErX4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoh9uiAAoJED7VnySO
 Rox/ze4MAIAKinQc67EA+/lbK/BpM5lSnxTux/68d56B6e7F37i7neJ5ncOseFKQq2UHvGdkvp6
 Oh8InaOFrflu9n35pA9KRMXFaw8WPmiLnN4S2jOHNIe1p5KMsc/kKc7alFbaHnGJKypDWMig0Jf
 px8av4gRQWmlEEW+7RYfD4kOMCX8CT1dghY7wIqCjvLDKK9cUa9RHjMBCO6hxolAC7/tdlX5LDH
 HA2vnlG0eZ5Bg3LihGFBq7essp2+yu0b4NjL/C8OiAeDjrSRpCDIiky6c41CV4SNDUwu4rHF/ye
 0mmb7lbdQM8AvUB8sjXxvmzSl7ulc0ZgVVN4wLlQuMX6bX7c6K/qXNf/exJUHBOrgYbBt35w3g1
 rI07If73Nr/wm5lLSIy+z9iPnVYeQ7yTyGezYGNb5yegkHrZhf9txCoLo+bI3eYUQxMSKOuEvtl
 TZciy/uiABca+kkFWWShBFU2XLvqz1Gm6cQ10PY+ncKGmnXv71a1DH1uQJsAft+4Y0DpQRxsGp8
 Vo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 090eb5336c (refs: selectively set prefix in the seek
functions, 2025-07-15) modified the ref-cache iterator to support
seeking to a specified marker without setting the prefix.

The commit adds and uses an integer 'len' to capture the length of the
seek marker to compare with the entries of a given directory. Since the
type of the variable is 'int', this is met with a typecast of converting
a `strlen` to 'int' so it can be assigned to the 'len' variable.

This is whole operation is a bit wrong:
1. Since the 'len' variable is eventually used in a 'strncmp', it should
have been of type 'size_t'.
2. This also truncates the value provided from 'strlen' to an int, which
could cause a large refname to produce a negative number.

Let's do the correct thing here and simply use 'size_t' for `len`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/ref-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 1d95b56d40..8df7ae43e5 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -498,13 +498,14 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 		 * indexing to each level as needed.
 		 */
 		do {
-			int len, idx;
+			int idx;
+			size_t len;
 			int cmp = 0;
 
 			sort_ref_dir(dir);
 
 			slash = strchr(slash, '/');
-			len = slash ? slash - refname : (int)strlen(refname);
+			len = slash ? (size_t)(slash - refname) : strlen(refname);
 
 			for (idx = 0; idx < dir->nr; idx++) {
 				cmp = strncmp(refname, dir->entries[idx]->name, len);

-- 
2.50.0

