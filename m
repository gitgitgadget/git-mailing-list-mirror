Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF7282F0C
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789819939; cv=none; b=Jj+7wr/kplt9sC+eiHOaQm9874Rk/u9XJBQQ4ZjRRfBMIySn3SeuG931yifrNORp/n3aCCf6MbKLY1NHSdvPei55/ybwRnxt+hHZKJ1XYQoMGPguMAo2lnl8E9fzF99iMIB/2Um/1vY7qiXhkN5FE06uz+jILUHbsG+l3FKXIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789819939; c=relaxed/simple;
	bh=gwrSvtRGbH/F34+aePfUjDtcIo7PUUd/Cbr+Dyyfeok=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=l56wqHTT48Pm3ENMvBM6YB2pUKrcJamErgMoDSxAojtDcBLS70j/+rADgON5+6JYA0n3+IykpcFPIe0cDTMA/EoXbGxxzrZY7QRqopGcynwcpUE4qt+7Lf06RyEmTpjawboww/HXNlF8N9piaosPlYaPXATvZ80fQ+/xtUQLEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDh2famd; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDh2famd"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7fcb425fb68so885967a34.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789819935; x=1790424735; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DVZiWY7OwvJ71RjuXJtmm1Nwbc7Z3FQZ8xCpE9wd7CA=;
        b=YDh2famdhgaTf0Ov6Xlr5lZHAZjBZwjpzBwQYep7Jacs3MKtjTbCYhvvG20+y0jWik
         ZSeZyVq5QHlbJMFpI7tXyYdKsEI0KjWj1y5Ro37Y54YbQNFRGsc8eVeajOm5cw1K0Qmk
         5iTcHKKtUOCCvUNul42+U9q2GlZZdLjKX5xmCQJX1aJ9FYQBLyPSPBY/EO5uWbT12MwA
         5uiDHn2+h1fKwbLskuDkvnkyqtDE6v3Sm8dGXgk5E09dlFv7WdlPFVVybOIJr59B187s
         1hN1+f0GAkclml1lGAFxqLx2kux9CnqOa97CL21w+4UR28bKJ0Dcrq0YFFVieVinHD4M
         Uorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789819935; x=1790424735;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DVZiWY7OwvJ71RjuXJtmm1Nwbc7Z3FQZ8xCpE9wd7CA=;
        b=cBojGUi4o5bJW6p7uVsv78KrpFK9LwGpWFey/JJbtskdgL5dMwvSenN32KgpNrlX76
         YbsPNUc4We/ZpWclhOg/aqwvx+Gdjnl8s0u4anKwRnr9AX2QzuLucRt6QZcQXUZhHkwj
         grYcSK3yhsUAgWIVFwKWhp1mq2fg+Bt8eJxGnhil0kMIO5xFe7mBzfJqHDgH+k+U8nOu
         MHe4o6e5xN9WuvLOewl/ULQ0OM0MmTuOfB3IvwyeOGxygyQr6/kdlfJIryffaQyCWk/s
         n19S0al6i7uXQZeXyRnryNeAmtrCt5A7Rw49sWpYI/xQLIN+u24lRC6L+DTdDhxXxuvI
         Peyw==
X-Gm-Message-State: AFuF++ndi7hEPr5DZe2EFOlmoWoEAfKmDnN3EXoVZ7xtPOV2Rr5CS2mD
	V28XC2SEjwfkqpwXk0AS44Y2oglvRKg1gMUq3DZCIHe0lB9d+H+h2qzYMCviMw==
X-Gm-Gg: AYBFou2khWAWeNF5UZ/ZUd8d4fVqmK+zzrCX8C3D0rWk4ttIqOn95y2HsvoHPUgnzBf
	9f2XEOeTARO/iqStjPDwVfKiWaZ6YcqS4d4AJzOJPqXgBUac42shkeIqpYS4bz1SNIKxZNL81xk
	Hsk7MZUPJosQXb8CLVkYok9rt7sfEpABLEK8adY0HuI8votiKdJ1N68pKoNJuQm6YNAiIf8hVQS
	5kz57betZzDmSi2lEbnNFdDARtZKe8YRtiV7w3R+hlKGQHVMG/aUA4Yrc4KMYAqwPffKOKVucl7
	bX1IgE+7bhucYh3k1LJcB2Oxlafov02DmISZ4xi8lKb7lUUREx8b8jVLqB1FuipjLCEcRsYg2pG
	lYTNG/GPlOySqqcsSvwoTzR77zoqemKLaWgelv31sSu/QaHgXB0C1RqMRzsNcXhc40vDOeTZraX
	JNuVsu01v0z9+4SAImFBN4W05zk7/sefOfvkkxZprp5XaTjDbyLlubcyd3WWtpas/BMAQUcG4UP
	yfVtXcLq2qXlA==
X-Received: by 2002:a05:6830:6614:b0:7fc:ae19:17ec with SMTP id 46e09a7af769-80de33eca91mr6359901a34.29.1789819935454;
        Sat, 19 Sep 2026 05:12:15 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.141.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8107881f9f5sm2113739a34.0.2026.09.19.05.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:12:13 -0700 (PDT)
Message-Id: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Sep 2026 12:12:09 +0000
Subject: [PATCH 0/4] gitlab-ci: fix the cargo invocation in the Windows job
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

In https://lore.kernel.org/git/xmqq8q4zosri.fsf@gitster.g/, Junio mentioned
that the GitLab CI seems broken since I enabled Rust in the Windows-based CI
jobs. This patch series should fix it (lightly tested, but I don't have a
whole lot of build minutes on GitLab).

Johannes Schindelin (4):
  ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
  ci(gitlab,windows): preserve exclusions during dependency setup
  ci(gitlab,windows): fix Rust setup for GitLab's MinGW build
  ci(gitlab,windows): provide GNU Rust's host-linker support

 .gitlab-ci.yml              |  5 ++++-
 ci/install-dependencies.ps1 | 22 ++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)


base-commit: d38352cd43ab9745686d697872408bc3249a153f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2233%2Fdscho%2Ffix-cargo-in-windows-gitlab-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2233/dscho/fix-cargo-in-windows-gitlab-ci-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2233
-- 
gitgitgadget
