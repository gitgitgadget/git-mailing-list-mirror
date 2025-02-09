Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C557288DB
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088787; cv=none; b=YZOlzjNiQcqpXxK4jALNkGKeFluZom151Fd4/7ZTn/DKs7L5noorm5HXwj6org+tHzmq19fiPaqSlD1kiuXcT0kzGpn/mPnEfHxBLiOWGbrOCXnx3Xtpqf/qMGWlBV5M5m3EfCMQI6kDZq+x09g14D1+EPAb2WBnNts3F/cb4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088787; c=relaxed/simple;
	bh=wgofJdopnAMzbK8Q78ccaYTrtOyWymWPfVjfbTlF698=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJMfiN1K8hjznIU0gGULs3Xnoo0iP4sCoMQCOHI4zwyikcnOp/D4N+RayEptW/ySNyOvcFEEC+LMHaa8T7Ui3sD1iCu4YpAyjU3E17hILpB5VNvZxMw/hD0KoVrNZVai3w0CXdIR7FO3xZJE8QrfIw12APySHoE7L3s311uHDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNw5JjjC; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNw5JjjC"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so4720409a91.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739088785; x=1739693585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA3FSq8KPwplF5jdhKBd2Empuz41L4QKvdcdu6Sb/RY=;
        b=KNw5JjjC2AWCyRy4+17NVOcjaG2T4eTCesAOZ4b7usILB3zuVdjgiyRu6FhTUiZDHf
         qH27GFn2YU8F8UUk+67DLB3iWoEeYnY1MXHeK3UiwJy1VQjJrndYWaPmE6YqrP4Hsj2z
         zPUZqDkj6gxsw7xO3PZ13Q3Q8teEWuPnhhtNwelzz75ZHgxr2xdeP3T1eVZNi7ZqqEy3
         DryV3gKrxD6MUu2mUWcmrO2sq6HrvU7nvVUg0cfghx+ck7XIczfm1USWeSUNN0wR5+qu
         OPscMKhkYL4RufgofNx4/ofq5Jpp5JbuNesFCSkvRzYCA9Vnnbt9sGBRNnl2uV9d9ho+
         qsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739088785; x=1739693585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA3FSq8KPwplF5jdhKBd2Empuz41L4QKvdcdu6Sb/RY=;
        b=XfUJJ8BElEXoonJ//fBFHUCzZmKuTEF9v7rqt9zXnAD6of0o1dJD4Jo5RsC4OeiXow
         IxqnUF9QLr2F3mW+gkALz8dmWeMD6CFenQa1E0mBxAenMAPT0K7psOxwY/4L2k4wchcA
         FWtRJmJ7SsKFCAVw36PNKmpSeTLUFXDNIhdw7Z7Yx71F+EW/Fz19pHdO7JsKHyutExw8
         JuRmxi+cCBVs87jzb/TIloMMRB9ow5BiP3pq+w8B6GTfCcMqZiHVATXxumyMeCdIpRhI
         0tVmGDTFVpvxq6iXEE3ZxK9PZGqrCWz9UT++se0ue8mhSPIh1SbquDnMTOBkq/M/DB4U
         mLYg==
X-Gm-Message-State: AOJu0Yxl+QQj+CYUATGDsf1Ry9YIrrAesnYbiUi+sqAggOEP+dZrzo1C
	rUrAzrcSECK6kNb8LDODRsPGx5PiIqfhxRuzGWE0w5JlfwNKXVHS
X-Gm-Gg: ASbGncs1eTWT7WgPBDu+Qz1R6mQn2picdXOuWbL7tGqO5KsmGcsUxtauHyHtEumWCzs
	2dFp1dBhHNyK9MXke3qE6zUgXVa49VzaliX0iuRgKEf9Xqt9Il5uK/5VeLBa2XgBgHfVd1xby1t
	7GFDl2tY26YdbDVirNAgv+mUK8BDm7q96vOjG8Wb+CUOkIBwNrNrehA3oDDo70ZASAZQFZNcHb/
	8lAs0fepEpuITOebT4JqK6U1VxsF7jF40Ee+uy2uD6R/bpNBQ46MclacYdysJr9KB4I0z9nwqag
	wzLkgrgRCKE1zMRLAZdAlaebBqzLl/w4I3sfSsHPayPosqP4cKhSIw==
X-Google-Smtp-Source: AGHT+IFek0yXF5agbNQGmWPq+nm8XCHV86D2H1kwWnJ9EEVoRsaQWNPagU1Pr7uDiqEQoqIK1eoacA==
X-Received: by 2002:a05:6a00:91d1:b0:730:76a1:392c with SMTP id d2e1a72fcca58-73076a14371mr6825086b3a.9.1739088785569;
        Sun, 09 Feb 2025 00:13:05 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([103.116.72.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730889e0c5fsm466308b3a.119.2025.02.09.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:13:05 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im
Subject: [GSOC][PATCH v2 0/6] apply: address -Wsign-comparison warnings
Date: Sun,  9 Feb 2025 08:12:10 +0000
Message-ID: <20250209081216.241350-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several -Wsign-comparison warnings in "apply.c", which can be
classified into the following three types:

  1. comparing a length of `size_t` type with a `ptrdiff_t` value

  2. comparing a length of `size_t` type with a length of `int` type

  3. comparing a loop counter `i` of `int` type with an unsigned loop
  bound

Fix these warnings following one basic principle: do not touch the
relevant logics and keep the behaviors of the code. Adopt three
different strategies for each of the above three types:

  1. cast the `ptrdiff_t` values to `size_t` type

  2. try to change the type of the `int` length to `size_t` (may fall 
  back to Strategy 1 if the variable is not guaranteed to be unsigned)

  3. use a loop counter `i` of `size_t` type

Zejun Zhao (6):
  apply: change fields in `apply_state` to unsigned
  apply: change some variables from `int` to `size_t`
  apply: do a typecast to eliminate warnings
  apply: cast some ptrdiff_t's to size_t's
  apply: use `size_t` loop counters
  apply: enable -Wsign-comparison checks

 apply.c | 69 +++++++++++++++++++++++++++------------------------------
 apply.h |  4 ++--
 2 files changed, 35 insertions(+), 38 deletions(-)


base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
-- 
2.43.0

