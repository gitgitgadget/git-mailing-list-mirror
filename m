Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B493BE169
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636319; cv=none; b=u974da222P9dgmnhnD4GQqIn8Xku96DiOUnGS7+QfTfrCFU0hLMby4vakCET+0JJS3pxwCTGF90a7D1D73nWE5UIJCv+Difx8L1m4eyvvtaeRFWPux9i28PEnBqPcfPg4Ui7HVw/S1QILf4NLOFQOy524L1dyd6Tfdc2TLBlA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636319; c=relaxed/simple;
	bh=XWzG6mLQeIu52fduQOhwFjqdHimrF6nwjn9Wdf+VfJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qpc16RY7Vczj03kf0lil0ebabR2t7MVZgdupzoKurWZ9dVfms0CnN1UWRwne8G5ajaZMBk5SxdQN9kVHduolc1YJFXNH+GxPYKT29IqnP1YKPhFglBBatDuMVplLDac6cQ29x8IwGQqp/KS3r4h25Vj4xC9u48yTg66Dnr2B+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9TX6whx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9TX6whx"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab39b111b9so33050905ad.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772636317; x=1773241117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWzG6mLQeIu52fduQOhwFjqdHimrF6nwjn9Wdf+VfJY=;
        b=H9TX6whx8UEwb/4ffRj9P3AKL1eWSuo8Hm/bJ6VkZiAbKkpXRDLisBsrGLG1hl1Mzr
         FPcYxayp9dh/xgVjDbA5zLO7/e3wC7y+5K8Zwnvv5/sRVQbbrtYcD6Oe5vdKtONlJJ5Y
         TpKaTOAkczhruC9RDKUqXjnHpTCDsiwlsiQaH9HAUA9gER1EsccCmagT7xB8PT1Y6hVf
         tQ3EJ7RWcWcHQ0tc0GblnvAIyEV8xhOCb5T2v2BOvx1Dog7X1Ph8dmSjl4ea4mbbf3z4
         YlmSE/icmxzAAn0pcstT4YHjHo2DUHKIMxNeQq9FVv83GXBomog8wY2yOCsTMmRrmT5V
         mfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636317; x=1773241117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XWzG6mLQeIu52fduQOhwFjqdHimrF6nwjn9Wdf+VfJY=;
        b=SeSurN6Gi06Jj+kA/ZRsRfqJBYUfirZ/ArFPk6sionpRLkCAzi7L0qHeImUN6bMzlv
         JahvnWtMHH1vT84myjtxCAOZDYr44nIC7X8/idmi2GdzoUwC5mdbacpdGFKWFeDKuQP4
         SRkT4CMZDwgWIg7EFiaZcrWa4h2OEw+1A5h9p3oaGtbuYpdmpp5MuBdErmK6ioSJKj6b
         KbdVwSIs/2PrOpQkAAySUBMOduxNk1j1/aVbkGQ85i9tUoqkGMzhF7ORfa7gpUofHtPW
         0cKUKeplTXUKkbJCmLX4FUPv0x0cIqQ/0VnUNQ7TRC/okKdMoHTjBWwiYddc2+fH4Lv4
         Q2PQ==
X-Gm-Message-State: AOJu0YwrduDRLtEmKon3Hc3oSWv2IHEfOrYjJqIjf6Yel4ZHhgVXtazv
	oM0qTh30GI43LB2y/ph8c7ai4AWjdI0kSpLPju9xOG02LGjgwHZETQ0l1wOdsA==
X-Gm-Gg: ATEYQzzFlEZgGpSXmH4lkCuJTqawTOO8SD89TeVVRM0gSbauQLXWVtiti25yDd7fN5Q
	H5sFE2athL4rV6HtTcYFlcNf/JKQsn1hKNIqBp0srnyEXgVyDQYqkTMdvULNQPcHxAc66BQiwO3
	EGrAZWzY34iaZ2W5RWBumKFo+teKAs2DMUHLNTCcCuy3RxDr3PNtBwP0uvEIC16dq8MSjoaQHGl
	nDBNB+8IytPWeI0tWIlrOUzSIhC+mt7vnOncI4ZLIXrqA7D8sss9h1ED3B4f7NSecY2OLnemcq5
	OKZaAbs3D1YuzyFEhlmHclU2PvCmvd3nrveqPUcCYu5fE+K8d0bwBzULMyiMoWPxsurmDVk4dE+
	qtTKLR9cTb/8sBVJkzrJRJr9cirznP8BEsMSiNWXYKKT1ShhmAN6mXhdT433rKgzCjnjJqIKI+9
	ulDAjKATE2gxeGSQ00nICiJdyVRQ8mKDtoCW/0reHNfHxShfz4i1kLQw==
X-Received: by 2002:a17:902:da4d:b0:2aa:ea8e:f118 with SMTP id d9443c01a7336-2ae6aa04daamr19501485ad.3.1772636316973;
        Wed, 04 Mar 2026 06:58:36 -0800 (PST)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:1153:29eb:2351:3074])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5043971esm86218835ad.3.2026.03.04.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:58:36 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com
Subject: =?UTF-8?q?Re=3A=20=5BGSOC=5D=20Discuss=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Wed,  4 Mar 2026 20:27:11 +0530
Message-ID: <20260304145823.189440-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224161932.33080-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260224161932.33080-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Karthik,

Following up on this, I recently sent a patch on `editor_program` [1],
but the discussion hasn’t reached a clear conclusion yet. I would really
appreciate your thoughts and feedback on it including what you think
would be the most appropriate way forward.

Thanks,
Shreyansh

[1]- https://lore.kernel.org/git/20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com/
