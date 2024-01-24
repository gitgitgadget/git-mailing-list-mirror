Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD877F3A
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105068; cv=none; b=XESRZOELgb5k4tXl3rmy+b+sem3vsgY00Hl1xIxinr5Swn1zpUPptHVH71g2Yt9YDl/vKoEOeQxyQaMBsLKozqcJUzad0bgjq3ws/4+Kz5L1ghdGy9KQRPJ1JMzRXz8A+xWsTcVpLzO8YjhFl8+ZPwfXZOAQHbSiwoV/TlRr/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105068; c=relaxed/simple;
	bh=0OR7ZzRWwmews3BsDt3xYh/2C1pctUzwquCpH6ir+M8=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=r9+8oRKmTjaaag2Cua6OCnGtQv1tO/gVxd8XagkVWMO3Odv7NZw1OjPGgCFFgxwSXX+gcN4OZqOyv3KPdeh1FzAU1CvNooF9aMt7uazgedKMCRq3fSAddWfa4QgYaJZ5cut+VJ+hUA2ujQHBg2bVJknfa8GSCWkaz/EuNDsDgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6vODgT7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6vODgT7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so65282685e9.1
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706105065; x=1706709865; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4FNxjTUj2X9qBm6LvQ6lXfEE6tzBT/MK1IGsaGXjC8Q=;
        b=a6vODgT7fxMUxe/AAPkYfO1kS4G4cfS7Jianb+6ZMHrmA2/N9uvAgl/GXutp2ybzAR
         UGek4VYoEXccSmkNFqin4gGk2wM4yvSPLM2K6zZ3+MUKhV+9AJ3ZY/L836faFFCLdBdx
         QeVVMghoWiWGeGFarrqoSy+KAbAyrXXm1c0JV6mZLiQtZd0ZPcbmm847w8WP97T0ZLT8
         ZAYdM/mD+x8b7j2QUnkYWPHB8EpUPDHmrpbtgoiFS221zgCXVBIkLa79tIiud1tOIb2Y
         mTU3W9+cBu7ZLl95svyU48YSWDyLfHYSrN1aXiIIY0QV2s07XWYC8hnYAfjh6nsezRuA
         U7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105065; x=1706709865;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FNxjTUj2X9qBm6LvQ6lXfEE6tzBT/MK1IGsaGXjC8Q=;
        b=ER8UFlnV7eDSbzi0kySQ7Y6se54T9HQLO0RacySLqjMK227EeL5dqiPsAwwa9OHzhb
         8l0203UoNrxAbwtUm2z6PpSeNo/Nn0HClUOUm4FqogmCMjWgkz2YJfd6kJG35qmtfErt
         zJ9CJ4pgL4RGxpg/7EDIEQyIgKGqzEHQpX/mHqXDbnlfoWgUtzEJkOeq0z/fuEaTV4+o
         pbFt/KeM28t7RmGhA2PYPjANVUiav/fWZTUzD3RmbgYTCSKnHZC4+rEu/EogBndyHaNB
         tDuVkJ/E4L7XSWuiofhyJ+b4SyEqfivqsthkV/BmN9FzJhbJQFyP4HXyl4qwxfH5BBWv
         ajIw==
X-Gm-Message-State: AOJu0YxWp04vd0l8keDJNcgwlFBLsAOcQ0tIskX+XZHF1/aTK8kTWKiK
	WAeMGVzB4QWRsJhq/79fc6v+ChNVNEI+57vqQvRtw8A2t425ODOzys94f+MM
X-Google-Smtp-Source: AGHT+IGovJhiJQXOkByteMl5kGc23LunWgRpfIIDvprHSayWDzxGytprSSVvMZAsytA9OSJeneQpJg==
X-Received: by 2002:a05:600c:299:b0:40e:43ab:d83c with SMTP id 25-20020a05600c029900b0040e43abd83cmr784705wmk.108.1706105065079;
        Wed, 24 Jan 2024 06:04:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040e7306f655sm35490919wmo.22.2024.01.24.06.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:04:24 -0800 (PST)
Message-ID: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
From: "Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 14:04:22 +0000
Subject: [PATCH 0/2] [GSoC][RFC/Patch] FIX: use utf8_strnwidth for line_prefix in diff.c
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
Cc: Md Isfarul Haque <isfarul.876@gmail.com>

This patch adresses diff.c:2721 and proposes the fix using a new function.

Md Isfarul Haque (2):
  FIX: use utf8_strnwidth for line_prefix in diff.c
  FIX memory leak in one branch

 diff.c | 19 +++++++++++++++++--
 diff.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)


base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1653%2FInnocentZero%2Fdiff_needswork-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1653/InnocentZero/diff_needswork-v1
Pull-Request: https://github.com/git/git/pull/1653
-- 
gitgitgadget
