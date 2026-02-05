Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C52C11E7
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313159; cv=none; b=o7OZDj+mPmV6Z2OigdjuSF7JFzlSmYyKep77GzH9MSAc47Rqk6axyhJ3DYSpHHatVe/bjF/ScBJEF0hxQnhlSx22FPDd5445d568Jrzm9y4DIxRQ+beFPCGaP3tLurGB24r14XmUUy6jK3vLH3OU11EOztcmDMlOOdzlChG19rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313159; c=relaxed/simple;
	bh=6exerLFlryIlyDtm7Prz+fSh3lNTMUvWvLyooOHrkMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipQ+jJ67FGaTy+0bbUAh/SwDAG5SwEUmF4jUmW2gmoejdZjR7q6kot1JRjuvkpTAPoL8n0j2rAJPo6SRkf7YcNRMPqUJd1rbOK945kLSdsVhIYwzZ1shvWTXIVnNhluIThGjHnDn1eanLzAj4EiKKNPR8XpFSLtOFbIHyd+oEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoDnTauv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoDnTauv"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so686978b3a.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313159; x=1770917959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPol9RF5/xcHG1DCPAmcs1IK8NTnwkOLuA8bUhFqDv4=;
        b=LoDnTauvL1W2BYUU/5g+NxoPtNJ/dtcIl+0jjxOmPBsHg27AzQ2zPS13TZMozGCT5j
         LA2VoOn8LpdTMTuwEXBPeck2mhzZFWxht906bE0GI7uqYAs6Q+0YfR0lX1xh8l9C2U+M
         jIiGBvWxhuTDaqhNpgGWlJO5qD3d7yMHaUE5Vc77BTe+dYwb2H5ikQTj0wk8xDMr9X7A
         2D7Rg912pJm1GWtrhZRliboEz9s/xIHncYoOtXRHv9yc4QFiJbnzJMlwqFd5OE63oAcj
         mRlxkRyn2PzsPs76c0nZ4kJCxq/2r69YPcdGZGdhU5VsryJQHEcj1+Ero3iLRJP9mHHr
         zxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313159; x=1770917959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPol9RF5/xcHG1DCPAmcs1IK8NTnwkOLuA8bUhFqDv4=;
        b=KG73R4K7MLzYUJvJ3FCuarUoaL8aItQi4bUbLlJQ6k9bT43r7od6BtqtNKmSM5RV5Y
         VoDMFHxrRyc8/DV13BbFvbdDPt94t62TDUb0UnKKMw9gyv0D7QxLifdjf9RcOgS518G/
         XuAWs7/Cm5LITSwSpuguN6OA73FJDIQglf1I+e2yVlS3GctEXgYXLYfdBe/QmMeWAceg
         /LVKmldCsRiPFVskOgvcxrCpksHrbOkkydAXnauzPZSrLsWHQgYFLkXuGYuPoW4648Og
         M1+zsYZ7mflA1TxIMD4r6VByo1wW2rAcvS4OZV6/WmuO5OnSl3tFK0qric/Gnwi+zzA5
         ITAw==
X-Gm-Message-State: AOJu0YynNtJS7FEuxkJf+zlLbAQKX23l5dJ0HFwALxy9XL/tubS2DWRS
	jtQhBQoYD+Cye7hNaKLLo+ZGUl1gFfUJOnEJl0MItkXsrXiC9rD/0JLERRSUpw==
X-Gm-Gg: AZuq6aKDwNjmSDFv1++peknWByQHxglhLICWS9Z3L7uj9sPPv0clc79VEX6uWEPwFKH
	UUlok1rgUr4Df1p0NqnMaHyx9anwfUDhQlrrhOucHq6VqZd6q/jhoXJ0wRPU3BE/r9n1Hcw3Ci1
	5+HT5IzMNhPnUQVVMEqGmWT+kzuGDZ+pkqHwJ/YLL7kFC7xZBiD3v69poYlEZzNAZ5faiW8uoxj
	ArnuYHNdMahezGBNRFvGwwtevqLkxZ8DLIg5TBihUeYrAUrbSb/n2dEzfSyfY87dGx9hs9cmZS3
	sP6jWVm1u8/4E1YoekRK5SvFAV8JSzxW6U4/eMzZceS9mDXEYXaOTUyD2xygg3Dkb3si/ISsmJs
	YCreoCKEQhp6AgIsW7GMYMrlua5rGZQCbNdrF+Xw2GfFVbIwSEwlb6GUwoNFekvntwsPImXVzHF
	BkUjBTwq+KoUpgdLnfJBm0YJtaCbyujx6EthyBP5mSBuGWFj61CHTVewSdIQ==
X-Received: by 2002:a05:6a21:38c:b0:361:63eb:d024 with SMTP id adf61e73a8af0-393acff54e6mr145502637.23.1770313158612;
        Thu, 05 Feb 2026 09:39:18 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:92cd:6412:7a93:e84e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb526610sm57298a12.13.2026.02.05.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:39:18 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 0/3] wt-status: reduce reliance on global state
Date: Thu,  5 Feb 2026 23:09:03 +0530
Message-ID: <20260205173909.61406-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <16274976-17c0-499b-8225-de2d783ed343@gmail.com>
References: <16274976-17c0-499b-8225-de2d783ed343@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 05/02/2026 10:27, Shreyansh Paliwal wrote:
> > I forgot to include the changes in the version.
> > 
> > Changes in V2,
> > - Explained the changes and the reason more elaborately in commit message.
> > - Passed struct repository instead of accessing struct worktree in
> >     wt_status_check_rebase() and shifted this change to patch 2/3 instead of 1/3.
> > - Added information about leftover globals in the cover.
> 
> As well as describing the changes it is very helpful to include a range-diff to
> show what's changed - see the --range-diff option to "git format-patch". I've
> pasted the range-diff between V1 and V2 below

Thanks, I will keep this in mind.
