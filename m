Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42D3C0C
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181407; cv=none; b=NWsjwRHEsmi8C5Dit2fEeLzxxSFcTccOT3L7kotjCp9jmi83GKaIkRTcQScoIr+BF9AlzWpBHwu1HkdDzUmzCzEAQIH7Vq2yw+ZbS1YGgaJy4xwhVQvN4KhTT/kd+rg4Ri6tZe7pOiQL+oJiEmhm0Vyp/5EYYyhLAxI8gjgxjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181407; c=relaxed/simple;
	bh=d619OPAzI8Hsuw0GkUmxWuSyAkp+MEcYOg8eCc3UrFY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VOQG7wsrpN83l5nEdOEQv0vm0jZjXbMX+vA+PEbScHXbdsybXT++/TA5ivAqgllxIKNVd6b4Y9FBBBP5MagU9PjS0+ymQYtApP0NkL1av+RkABzYqX6Ei58LW9XPNjbQVu8rfiqMQhSW+IHUQuD7dHUOYBSVOkD0wIEhWwnriQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/YqsN/9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/YqsN/9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43690d4605dso16835985e9.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181403; x=1743786203; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=11d/wEEBiDE6H9IOJrnr/jWz5HTFO/Kv7yXxFro+044=;
        b=O/YqsN/9pZn/r8Wb0XtC/X0hm5NsMQVfURwQeMsJXtcB2hhn9AxrqttboZsJ+pS8jQ
         rB6VH9pjZj5ItYvAIExMAIsl+3mB3W507HB/n0u7BHHkFFx+s6OPEAYDaPjF51uTqwMH
         Vqe7dInzoFdr1ZDaMPgln4vpYUQq2WmLfTqsUjJsxvom9z1ed8FOeN1ajhTCCGGAPKib
         6PDoRES85FPV8y3uv1l14+ahU3Xn6sjj/Z2eKe3zzDjg1JqemKuxjg20S95PGN8GqAlY
         IPbxy956YNrBc15y97bHW6JZtCu3S6cw00+jgxDR3zYkLPX468isRDkaoGLs5hojb7/s
         8Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181403; x=1743786203;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11d/wEEBiDE6H9IOJrnr/jWz5HTFO/Kv7yXxFro+044=;
        b=izgTmeQZFu7YkI50gnFnr0YAizNP5naOU/UiyqiGXh35eeHiBvWFTRLuR8wSxgFqiS
         sx3vix/BPUXI3Uo7ydj7FIIzXX0t48ECwQfQ1oD6oHblFfVAwIuUw+yAJ9RlWo2kWhaL
         pCcvuJU8BSh0B0tfGIE1jcQjxn+8wxqyYcfUP/QFF7ph2KO2HHcJ0TqBW0vptMWbDpS3
         dBtJfXsJed2p9UCpMfmZyp0Bmwe3g1X6D1oIHo6sKiy2tHvfDMMGvuHgQgS3XUmTZ0nX
         cd92QV4ncoBvwMJ60rX2TilEVfm34iJRqr6G+rFzq65YsC8qa4h4ZCXcXp1VAE7f56iE
         YLBw==
X-Gm-Message-State: AOJu0YyQqS07s2cycXHRy9NxHY1pjODNHh4jUSxqzTxhj/HtTliCdsfm
	uohKxHEomWiDcn0EYuLC6GgRHMXWXzilt4ototLnsnWfhQwl/BWhtSBZ9g==
X-Gm-Gg: ASbGncsY6mcF4Q0eRr7aKt7OqyGrPeK3LGS6lTdMB3alcig5+Wo5Eq+z0/aKtAdJRRJ
	kxdzylGVgb/tRWJm7e+VWGiuPlrY5zqpRiUVa5ImpyjVXJr9ihsWqkqP9SUzTHrfyh//25spMcu
	+cdwVHqJwjhRQ4rFwNyV+YMXra3D9YVkpPIH46gf/9pIpm+tI403OrJS1oIKWF7JYRYP8Fpieb0
	8HWlvg7ljD6T4EASNq8RX2RUfrc0UD565n/H3O2Dv6gg637SzE9s8wY0PlC1axfmeeHLOVP/BL9
	1dXPJjoux6aefxLN4zZk7Vyg0W0PitjgG6lHtBfOCfwY4w==
X-Google-Smtp-Source: AGHT+IGnS+yU68JqsxItj4VOjnxBR7hRafm0Dhh0OBUCvbQPRjcu/9QSa5gipWjSa5j4TPxWh36L0A==
X-Received: by 2002:a05:600c:3b9d:b0:43d:7588:6699 with SMTP id 5b1f17b1804b1-43db6221b07mr2633135e9.7.1743181402732;
        Fri, 28 Mar 2025 10:03:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f5f56sm78986365e9.26.2025.03.28.10.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:03:22 -0700 (PDT)
Message-Id: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Mar 2025 17:03:18 +0000
Subject: [PATCH 0/3] rebase -r: a bugfix and two status-related improvements
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Philippe Blain <levraiphilippeblain@gmail.com>

Hi,

this series started as only 3/3, which I wrote when I noticed that 'git
status' suggested 'git commit' instead of 'git rebase --continue' to
conclude a merge, and doing that I lost the original authorship of the merge
commit.

2/3 is a small improvement I noticed along the way, and while testing these
I discovered the bug which I fix in 1/3. I guess 1/3 could go in a different
series, if we prefer, but for simplicity I'm submitting them together.

Philippe Blain (3):
  rebase -r: do create merge commit after empty resolution
  wt-status: also abbreviate 'merge' and 'fixup -C' lines during rebase
  wt-status: suggest 'git rebase --continue' to conclude 'merge'
    instruction

 sequencer.c                |  3 +-
 t/t3418-rebase-continue.sh | 24 ++++++++++++
 t/t7512-status-help.sh     | 75 ++++++++++++++++++++++++++++++++++++++
 wt-status.c                | 49 ++++++++++++++++++-------
 wt-status.h                |  1 +
 5 files changed, 138 insertions(+), 14 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1897%2Fphil-blain%2Fstatus-abbreviate-merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1897/phil-blain/status-abbreviate-merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1897
-- 
gitgitgadget
