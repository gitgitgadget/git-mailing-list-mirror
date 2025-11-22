Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAC13959D
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 02:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763777642; cv=none; b=SWp86AsyHMJ2KeS15qSRZkRsKR1UgC2fwgvSvSQuqKgF0MqrfpuWSjORpMJ3aNw1a8VrLCEDI5L1tFq+dqwqO1aj3VCfwA+2Uce+HUixyo97PdmJ84JducdQFls51bx0K7+1I9Kxv+Ce39pRXtdPzbVaBT5L+H509VdPTM7v49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763777642; c=relaxed/simple;
	bh=vZHuyTh/olmfgN+V4i/5V0hr7UIEiVKyQ1Fm6sWJw1I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hZk2ldR51HEtoEhMNLj4yGbx3RhXsmOkjyrjwOhL+mIs4s3dT8I1nShoL3iLIMl86xWJ1wq8Tez/0nCwt6FOJxjZgfYZz6U+WAblVSQGdLelg/SSVFleJ823wDhCo47yygwLYQlMOvH0fsjCIi4N0kFDGIsPniGC1ASl0KVQ3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuRAHhdP; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuRAHhdP"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37b999d0c81so20457071fa.2
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 18:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763777638; x=1764382438; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vZHuyTh/olmfgN+V4i/5V0hr7UIEiVKyQ1Fm6sWJw1I=;
        b=NuRAHhdPFjrcN4w8rJsOPom8PgkljDXLTu59M3NIndVbId7tAT5TrPOkbCl5T7+h2v
         s6b2wPbqdtiqKahMp9JhuLIZ7Vb0/sZUWVCofLnq21fIKKpmFgmOgTUNuijsTL9UNn2A
         WMRN0HGTn0BO7IsGfbbaD6md5i97vsPmtlsj+YHRpIFgaLZ9Pc1tTwwhOKpsRDa3K/0e
         ydNYHA9cm4I7Pi2bMNH1ExQvYByFO8MFolWSxUiGc+e/S2rs9D5781GBu3ZUJhC3Z+N2
         APdxxddvg69J6d/ZX9qDndN8nLthbF/Bi/j2q1sVX6HFsDVcrQyso/sLYaH53wFgGIZd
         O11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763777638; x=1764382438;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZHuyTh/olmfgN+V4i/5V0hr7UIEiVKyQ1Fm6sWJw1I=;
        b=Njhz2dsazl91NsW1UybbAnT3+R4o1v/csNAMBvYTBfqNsNQwWO1NgWinxjFxWzzi3q
         25Y1E+aoPLCbxwwSnpvo6EyirvQsL9tgtX2dzxP+Uft2XgPdeXEJYL6k/lyGz77mUhQu
         x9V8pGcmKLeI/pXYqXxv3FstEwY4NCFcB7hhfmbYGlED38MnCe+Z3SPTV8ngCUN5qt1m
         x/m6APPvl0lL85sRnYQMc2d21g2LjNV6rPXdMNVkyrMIxG/hPfDySAYS8yt7LTvB4Cd4
         Aa3N1M1ZcVrSGwFdvJzUuMfJh9iQNp5/Us48bEybg73rjpuM2HZzsWDhFGr/db4A8fj9
         b0uw==
X-Gm-Message-State: AOJu0Ywfcsi94WdxKOoZsc2qXIaqMGCrLdZoUSudICS5CLe5s0mjGUKK
	I4qVLSyKdWarotkQUctUeFNScHWSTKKHM3rfWOHdZqn/izd2cKjSggDwvRkRGj+OYKQMvjRIKKV
	mIt1PtoTz8pu58VAR0Au1DiemrGwMqJSVt3X33rwqVA==
X-Gm-Gg: ASbGncsz50A7IEb4Yh4bPewcBXntiNjyheCgK4Ocy/RzTQZ3NbUavQyBW4QoW5eCZL3
	VVhmz55vjLFafjpGrtBmmTM/en9UhmApdOgsiACAa/xu9BuFYcvM6uxVEFyB8FMt8gCDOCIV8bC
	79lQxi5SlEOIP78h/cR32mKd010rYWxHZYko7KUM+Fq9Wa4m1Z/QWKrRQmHUwCAYGuDnHjvwcvq
	mLmMsv5/q1fxVZViiYgWXnVYeXQbGDDgcM7ij/T9Zb4p+vaGxBYiRlKHkMhJNAKMiyUj40=
X-Google-Smtp-Source: AGHT+IEECujNjzo2FuVl6Pt+nFlkjDCyLIaWYcuc4PpitgOCMrfuUMgtdG8ABQVSHMbnXqIpbbiKnKVZ93GgbJFGhtA=
X-Received: by 2002:a05:651c:408b:b0:36b:9ecc:cb36 with SMTP id
 38308e7fff4ca-37cd9253552mr11316431fa.23.1763777637786; Fri, 21 Nov 2025
 18:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alon Bar-Lev <alon.barlev@gmail.com>
Date: Sat, 22 Nov 2025 04:13:41 +0200
X-Gm-Features: AWmQ_bkdXlpSQIN7xlx0fBl0c_zjxb0Xk0Sk5aUPwfRh4KDIa-RhMEQDg0IdTTI
Message-ID: <CAOazyz31vWPgGAFv2AHGzXO3MBGnz-EVW_ndPNgERBvRdAFS6A@mail.gmail.com>
Subject: git submodule of reference with no branch
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I use Gerrit as a code review platform, there are some events in which
I would like to review a feature that touches two repositories, one is
a submodule of the other.

The git module reference is set correctly, but since the change is
under refs/changes/xxx and not under refs/heads/xxx, git cannot find
this reference when trying to check out the repository.

I could not find any option to either have an explicit reference
without a branch or somehow to tweak the configuration to search under
refs/changes instead of refs/heads.

I understand the branch concept makes sense when updating as usually
we are following a repository branch stream, however, I do not
understand what purpose does the branch serve during checkout. The
checkout should be possible based on the reference regardless of the
branch.

Does anyone have an idea if it is possible to have a submodule with a
reference only or tweak git to search a different hierarchy of refs?

Thanks,
Alon
