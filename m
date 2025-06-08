Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC41BA3F
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749344850; cv=none; b=K4IpurkAhh5GXx1N9BL+PRG3hR8+q4S+X3ICtNkhg5BiQnwAq3MBwHPF6nYJ8ARJI5SV4zmFLL91WPMQEP2tS6rprTTnMepK7kJy7yhba33uPm3fTPFKNHyS0pipZZP8rRLDQeeOLj5i5YotIK0Kz+kbnCJHYIgfBlyawXpNeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749344850; c=relaxed/simple;
	bh=HZCtj5x8Cnj0trNcHNWCs2iy59MyI6M7rPh1XMKZ49Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvyL9LnYvT2EQl5vuHsKXPCsNJIdI9C+zqpR+AkC6a2WYpTw2KINzzAE79S1jycjCCKcw5M0bbqODDR/QY0aRkiEkA9lClOtqqaHwlQQg30oJYZwgvf+7pkipqm6DK5GyPrrWkO06Nd1nZ6XxuSp93o7VtEogw8dwb5CVGNt2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8hZ6iJ+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8hZ6iJ+"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c3d06de3so3726358b3a.0
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749344848; x=1749949648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8Sje4kcRlDVtpvVdwo+SRD/iOkcpO3sc6PUGmP98tI=;
        b=I8hZ6iJ+cLCwVdJCGZ5hew1XTDdB5luuNuNN1GvzXpuphRy/E2b7PHTX3hkVFB9RN2
         vJyUooTIJWz4Tz8wvhk6BIoE8ew3Zbf/ALbdinHcFlI2GwLz+McnKfvjbdaOi1gaamyO
         jgE0ihK1k0VqiB1gbdT7QVCnJHdTOWJFK/UDmL6a/MOkOu12WbCAfxVTqzfU0j2Z4r+d
         RGUBWtXDvgNeJwlU/Ooe9vRZFSB8UA7yiIL9QWctSPKEp1B00x7n1SC27CMHLwmTT9gD
         Ctoe1w5n8Xvln81rWfC/k9Vlci0NhtkDRcbm7oCXSAHZoZFhqPOyk1Bm2Z/ZYoIgXwc5
         Wf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749344848; x=1749949648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8Sje4kcRlDVtpvVdwo+SRD/iOkcpO3sc6PUGmP98tI=;
        b=b0XCrRkB4pvqr+WC9vxNfOkdqbtqOuYZixOKotOED+lfGG+MUZbfGtjZKrlxFTRFS0
         DZKVY8O283A/qg4+zzXogFc5jtLxG7YdM7APiBMBCxVJg4crJZywMtjDy6eBdbo+b5Cd
         dJJuQY6lj/GIc/SKFhBG7MHOc5Cd0fqoiuIWUn0GHM7g25jDNYtFjuTWpIWhpz+fGgN0
         AvyNpV2/1aGK+bTfH6qhqCV+nUYwpJQSymFMVCJPZ58mTUDQB4kATAf8z7g7BCFy2K+G
         711lrQ/ao2bC+fy2zRHSxDeKSQsZxFrsXxU9qQr7W6vT9rcvKV8yaAdIpalYDtMymJ6L
         7Xmw==
X-Gm-Message-State: AOJu0YwpTTqCPKkVtRQgc2IZcB/YlfxQ2drE9xKhDH80sjb7zDTFPABj
	I6LKOXDKKsXefAOrHTk+x7pQAVDMoWYAyab1O7cRNed9HmF1BPVseuTcNb5X9dXnCuU=
X-Gm-Gg: ASbGncv3PTTTTWvXEGva3xMEQfkEMVNpSJ9xoiCjOo/LRemAfGcc3fTpYn/yRG07SYh
	CTkF0OJevyn5MJzD1uvAi4lDySfFA9mI2uYHat8zTu4OFZx2mc8qK4AriRLNzVgBH9M9x1YmdY3
	F4V8uo4NWcspzrk8EHrfWmnzG6lDQDbJsmNTuN4Q3Uts9KTIrusOWkdtFV+g++qZV+a46lJdu+Y
	sVMNubNgBgPZvlb0vu+VH7qmfQx0RDxVqd3FF90tAgLXJrSt5+okgoeMmAnoWQp5KxBKfB4/oSJ
	6drBWv83L41vwjmfRcgqJdsGxt1uhOI0ruPm07WT/I9pGjhguLwnvTdN/bO2U9cASzVVfX3YgbQ
	shl0=
X-Google-Smtp-Source: AGHT+IFScaDQiWsOIaDRawvLi1/jnZfBWkXsjusZy8wiWjQjbUfZQDLkpd9EdCWJzvYNowmUWjyn9A==
X-Received: by 2002:a05:6a21:b95:b0:20b:a75e:fa32 with SMTP id adf61e73a8af0-21ee699ae8fmr12538158637.40.1749344848347;
        Sat, 07 Jun 2025 18:07:28 -0700 (PDT)
Received: from thinku.localdomain ([2409:40c2:103a:88af:d97c:9fa4:c832:49bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0836bdsm3451716b3a.93.2025.06.07.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 18:07:28 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 0/2] builtin/prune: remove dependency on global variables and 'the_repository'
Date: Sun,  8 Jun 2025 06:36:33 +0530
Message-ID: <cover.1749343601.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aim of this patch series is to remove the definition '#define USE_THE_REPOSITORY_VARIABLE' 
from "builtin/prune.c" by removing global variables and the global 'the_repository'.

This patch series contains two patches:

1 - Move the global variable 'repository_format_precious_objects' into 'struct repository' 
and update all affected code paths accordingly.

2 - Remove the dependency of 'the_repository' in "builtin/prunce.c", allowing the removal of 
the definition.

Ayush Chandekar (2):
  repository: move 'repository_format_precious_objects' to repo scope
  builtin/prune: stop depending on 'the_repository'

 builtin/gc.c     |  2 +-
 builtin/prune.c  | 25 ++++++++++++-------------
 builtin/repack.c |  2 +-
 environment.c    |  1 -
 environment.h    |  2 --
 repository.c     |  1 +
 repository.h     |  1 +
 setup.c          |  5 ++++-
 8 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.49.0

