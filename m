Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C32DCF74
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784978351; cv=none; b=Nmx5+5TVUTuc1r56hpkvBkJuPKIAEXIUYjgR+xkDcFJW9QQdmwpExPgkKx0AcxljllJ7O9Lw1TPtcJovNm8BzMhU7t0Yybf8tW5wOT6mDSX2T1bE9QM9SSj0MFoNJZ8cs3VOXwMtL1p/DuP0p0aqCu4DrL2Zr377evYt//efYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784978351; c=relaxed/simple;
	bh=im8Ot36qIn1PNYJwem6cg415Er45Z0hXkY4d+HQrLV8=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=JhEKaTut+fHN1R+erKg1FkR/Y+UPzBFM4uJbKgbQRRbOHHlfN1HtWLiU4hPBQHncg1B5aRbs2nVGyucu5IytmWpTCBbTG4jEo/yvgQOEKyQxDbv9Hv5Aih1EmDJy10Al4tAOBa2TuBP6U5KBayuPR/4eC6XTVUV/ekXaWq0gQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rb3LD0/L; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rb3LD0/L"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1142857a91.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784978350; x=1785583150; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rheHmFLSeE5+v50MiRUsjPspce46V7eGKKDWbHIu6yY=;
        b=rb3LD0/LCg3zllWOZcmKMz/ezHFdNCTXdz2nI4L1TtGxUJ39Zbth/cF9eOSe+wtJxv
         Y4bCaORtdc08l4noIFs0wXX1Yf4NgXIsjhckcIs8boDfQAHXl/vCCVgVZ4aWjnkAEsxG
         6pVoFmek1v6ROcmuOpwoJ2FGC5s+bvM5sVVIJSMVVE0thLlODOB26kntqJXpANl7dtKP
         qfZNo4pUsCVi/4Hscd/PSMEwgP/BwHChIrpLjSl7us2ohZb8FwD5SptRtICPupRu73to
         jJX9wV0RQSJG9hIlWdAcZQMNfGAbnOHe30WC1q/IIoqrn6+dJ69SUyTvm/K3sCu0al02
         FRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784978350; x=1785583150;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rheHmFLSeE5+v50MiRUsjPspce46V7eGKKDWbHIu6yY=;
        b=ggHQnBP6m8AaLyoedViLSsL+j3w6mcqLea7OgP7LO6hXYhvkZ5vzJURNHaSmjbLGq1
         9E0QFTVtvK2wPXVsnv1Nemj4CsRowtiSW7Xs1+xu2dLHytGUcujm6lJoHfYtq6plXXpO
         8de5RKoM05M6KGweip83odrDfUoH/FJPybp8tQx54jTTMDPlYJhimwdJlC7uCKP5f8R1
         1eW5+HEdv/Q1Lcm2TMwPKjjHRuKvaf+FVfxRnEOpwaYONEBWlAhpOekEFZFJZT0gQdR1
         ArHCIhZwoBDo4o9pNOLkluSAjfiTunxnpQIi2mKPaYcUFwb7/3b2Rif4Vi7ngEOLB7+/
         7Zgg==
X-Gm-Message-State: AOJu0Yx5ku6HVXsk0FXpq51VvU5KLTrNDEZi8qTAMqzrfh/rRi9h0+ku
	7B6VVeflVTZX2VplPFQt2TpAdR8uXXAxLUwCIhUYxV81kqkTJo+z5UxFiuwVWQ==
X-Gm-Gg: AR+sD12umiAFVHojqhy42wTjUw4XK0jAn5qonwoK+NupNbqnjvYDgRA1+u8kFhy6vj8
	7NgDB+RSHElEwtvMHbPGNLQwQI8xckEVFTpFMSue+XyxRuKGyMg8yVbkO8Ma7nzA03yDBE8HYgA
	HVy4GpntA6XsUQ49DL1Xw5q1qoifT5JumnASe/7sCfdiRJythoX9W0XsRSMAynxGFkitVyu41mf
	8i5XrciBSlWFmc4j7TIt9e65np6NsuuETTseaPe/E7W80Lu/ALZZp775yUwVf9EBxrrLnuqv0Va
	5TqbrxTi9umL2IC9SKNnBHV6DlTMgTaLXDU93D2XeLvovr85NoeNNaubjPtzMld4hezR9A17YWi
	mHth7cyOO5fhlLghVjdzqeM/NjuCTmolaME9RvApBpmUP9X2j9Rb6xJbrjY8d7tpbmK9fea8dCE
	Bjb3SRyiCP72vN3R0I7w==
X-Received: by 2002:a17:90b:554e:b0:387:e0bb:57ff with SMTP id 98e67ed59e1d1-38f296554a0mr1904049a91.38.1784978349833;
        Sat, 25 Jul 2026 04:19:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.193])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm56658722c88.15.2026.07.25.04.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:19:09 -0700 (PDT)
Message-Id: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
From: "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:19:05 +0000
Subject: [PATCH 0/2] worktree: Fix out of bounds read that causes data loss and reject invalid
 empty input in worktree add
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
Cc: Marc Branchaud <marcnarc@xiplink.com>,
    =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy <pclouds@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>

Passing an empty string to git worktree add (typically via an unset
variable, e.g. git worktree add "$UNSET_VAR" -b tb origin/main) can result
in BUG: How come '' becomes empty after sanitization? but it can also have
worse consequences: recursively deleting the current working directory,
including .git. The inconsistent behaviour is caused by worktree_basename
reading unrelated bytes from the memory before path and passing that back to
add_worktree, which can circumvent the check for the BUG call.

Matthias Aßhauer (2):
  worktree: don't read out of bounds
  worktree: reject empty string

 builtin/worktree.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2187%2Frimrul%2Fworktree-fix-oob-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2187/rimrul/worktree-fix-oob-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2187
-- 
gitgitgadget
