Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647612690C0
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186323; cv=none; b=J8LpTWzVXH3g0lLx5gM0dDGY78IOiHoO9drmQCBWR+29Cb8v95zhuvycg0yHD9PBxcKvvsiisCM+rHS7Y/3z6cVwLIYiJueq5agO4umMRia+WsSr+j14zH3AnTJZy+Bqjicf3BUvdzqx9KtIissyZTvJnFoa+f21MNvGXkRU868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186323; c=relaxed/simple;
	bh=KD2RtFcwUeJkXktSOj6HvbXoWGmLF6gGN+QXt6P1/jc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=hzAJe1MD25zxtan9Bw4DMied9piWeYHbt8c7O4U/Hh6BR8KaKN2UqZbtIHZHB4FYjk7wVAqhdNrrH59v/AE3TajqdW0wxv6jDuAgX2AONBp1i4fvPD5Cu0fMvCEIDgnkYvfAzugL5bg+eYgYrpbRo4hl44JmOjq1FviFOwWfTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQofSdfn; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQofSdfn"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6b0500e06so2690847eec.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 12:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771186321; x=1771791121; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wu+WJEVcS+59yiwWCWqOgegceD0+jNFFCR6539Uxlo=;
        b=nQofSdfn6u1RoABdLyB35ZpHQ76B8nlDVCl9UiS7hrwCXILfWiOJbNhyjXCH3dkgQz
         SgflEMr2qDKUWksLOj1FaPaAYn42m4Mg2eu2kcPZhWe0qcDMJek24LBQ8Ol14Z8V89xt
         3nDtPIH89+gwXtZzuYHYtSmM1P+IFeX3FwuBgl1OXa1AREt6lAk+324Obju+4WRL20J+
         7B9qAPTc0O1t2s4/Cq5mQ4maudK18MvQ6wKER0g5s3J58y44xsZmHqG9ooUXOI2RBWbl
         TjpcFs6EThJTwg5aIUBEu/Mwn5I/yxYtMDECq522jEJrT3ABFhhRwCd5pK2V3JBII1ny
         ZQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771186321; x=1771791121;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Wu+WJEVcS+59yiwWCWqOgegceD0+jNFFCR6539Uxlo=;
        b=hqB2Zbu6JlwpFki5JaPI/8CmlPqddl9m2YpD2FfG94LPQBNmrH+bqG4VYrzkigBxVE
         QqML0GIgkaCPlvKzlMfBDh4Mkhgh3H1PE6E9H7wREIfq7BzplzVMOiiEkIdJhG0FyOO6
         GoJ8u2Du6fxGqeoxpuJnky6wrH2HjlhtPsIZiHfoQA/e8mO/hcesshSl39AUVzENphm1
         Dv94r4LAigmhxxjFN9UdzmvgjDwL7WjHo7+x6Dn5un0Q+Z1aH2ZeyV+Tqod0yMWNtMWx
         ZwUUNBMgCYJurxLr4U2hcn+Qg2dXe6kxkFAyU+FSbEBkRqa1StObKZXKCUHMg9MNd1oo
         y3hQ==
X-Gm-Message-State: AOJu0YytXAvBk8Bl5wLUuIyQQHzfQvgKSaFEPOhXa3y8xKb+dtg62cxb
	17BKHoZ1nj1WU2pZ6zBnKpzk0yVDK4JFK8Gklk8X5Mz9D3sAUaCope8Ta1ngmA==
X-Gm-Gg: AZuq6aJ8aDTnBGKRRkJUbROW5K+xpyDbJFEv7y9vFsXVfcWncbXYR4GEZGbqfIZr/j3
	5fm88IJdfXr59HL16VYkJCLdawPb38A+BH8qSGTPMpo+ozSuMS1Zzyguw98NjnZOO2/kvqXUXKy
	fmvGN6ARzdvO+dCmtvLBuOS3AneVWcu9T3Iz3h42p9bSPnd6E7P1qURpkrXy32dDc6D/qwpqkgF
	RzQFIAvpXzYrK25bOSHgMgAkPSIPVKo+YZowPIxHrO1WgN7Bna1+KY9tv+nHKCzOpFz0B76IVGF
	xfJBNQ5LXaHqSCnH/0kM93aECstJq8rp+SOva9G/5uCh56vdPowq3Qw9YIIgm0d6F4G43U6Nn/o
	2YPcYDfk1Su3X4iq7s/pBoxl4xyISoN7xvHp+x4Aq+GHzRQBgJgBVXcXo/DRHgixcbUy2KJhwUX
	xaE39U+Lags2I2FP+E5NYms0o4gZyh3PdXNbRFLA==
X-Received: by 2002:a05:7022:6286:b0:11a:126f:ee78 with SMTP id a92af1059eb24-1273982b202mr4216086c88.34.1771186321007;
        Sun, 15 Feb 2026 12:12:01 -0800 (PST)
Received: from [127.0.0.1] ([172.182.224.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b62274sm8553035c88.3.2026.02.15.12.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 12:12:00 -0800 (PST)
Message-Id: <f8a8d077cd7203663406bf656287ed7e0d6e6d90.1771186316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v5.git.git.1771186316.gitgitgadget@gmail.com>
References: <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
	<pull.2121.v5.git.git.1771186316.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Feb 2026 20:11:55 +0000
Subject: [PATCH v5 1/2] shallow: free local object_array allocations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

The local object_array 'stack' in get_shallow_commits() function
does not free its dynamic elements before the function returns.
As a result elements remain allocated and their reference forgotten.

Also note, that test 'fetching deepen beyond merged branch' added by
'shallow: handling fetch relative-deepen' patch fails without this
correction in linux-leaks and linux-reftable-leaks test runs.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 shallow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..497a25836b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -198,6 +198,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		}
 	}
 	deep_clear_commit_depth(&depths, free_depth_in_slab);
+	object_array_clear(&stack);
 
 	return result;
 }
-- 
gitgitgadget

