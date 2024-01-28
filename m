Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479E2E62A
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465946; cv=none; b=Nmxig4vIj6ZhNPqj4T8xVNc1GQwSyaxiwl/PaEPrDOho5x5OBBl6SFOchlJOjqL37EK8vk072az6UiWmNln08aolvXY7jvuSELGrGXY7sSFyYujF/iMUnDXBYGH1+Wm515x5mngBlWv18+MvPqzSWDuJeTCAEDbqdNc+2wiLids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465946; c=relaxed/simple;
	bh=LlaJPwTX2oaVaXlBjMhuJms7pBXM0nUJdornr6hsSLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGGuoaMVLSWXJLM0vN2syc6EMfS7hwP/zMD4Yx/aRd6AkLueoAsCSqJuwzpO0gDMLgwI51AqS+xgde0fyLVuj5gZ76pokrOdp6vOqJo/W8JchjvI29ZNZusZJumJq2fl7iuFFpYnwKPEbbxAtQ9k3BLfpQFJGEQyWSuiyRCu1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isGTAhI9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isGTAhI9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2906855ac5fso726997a91.3
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 10:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706465944; x=1707070744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEYou9fKxutk3G1At3KVf9X3y2lA3V3FTjiPY1iL3gU=;
        b=isGTAhI9XMzIc6FW0qtw3LS1aNn5mcxNQ2zkhoFpeDE4eY3nVOtGmeikvbk+0MD0eZ
         5HBpmMk2Cpdy7GXQ3Z1ONTboFJFhD0f8QgLZS0k4vbdyDhU1AoUJdoGXmONNKJ2h/xiB
         VWZ5wWNBwmyTTM9SVhrvptai9bKG0eiKtoMLAOen6DOzmNIp8LsZkedzzc8x24rm7sX+
         rbL12NWdHQEVlnZKCpeko7srcjeljNJib/0mudCW3hyvTqYSGWp9oKYp7ehU5l7M9KbJ
         +6nGI+g/7nZYguSHQtIeBfZJ4txyeC7oFzhJVEGjUUQuF4m5+2tf5op8TyHNjeLTOQng
         OUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706465944; x=1707070744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEYou9fKxutk3G1At3KVf9X3y2lA3V3FTjiPY1iL3gU=;
        b=M5oStKjx9ucnRpiFbPRF+rSQ56tV6d3Xq6W4eo0nGAtGs9RYO9ECgQgvoOPG/sASLb
         2O0R0XsNyDOvxJoUysvfKxM3KAHO+cwZ+YjnCtE2v22bgBGa49snL4v8jnquHIiG3bZh
         xL1evM7+Q0xL/Nw/KcoU1ypJ9k0P12rA91ZhCSwUL91u25zOIkNE7QcsZdR2hFBiN9Kd
         wtnq+O1fvk3okzxXd+pfej5uOYl+v7lC2OQTz1mo9llSttYJeZRulIBW1O4eK4xr8SE4
         hyPYXkdpVciiIrQmvS/9dq+CqXRQE2uK+/GIqKbbGgrbvhhmNxtYnL/0q2mgNjlFL5Jc
         vESA==
X-Gm-Message-State: AOJu0Yz4z2uekMB2DYLbhxXRwUtaDqRpdl7uIsG6HO+RlVsenSg0vPxc
	KR1Scv+N86bdFWCOfnsz5F0s57f1GiR4O/0bps2oSsaeaesgY90EY49EGmclJnf3cw==
X-Google-Smtp-Source: AGHT+IEVjuA2DB1zwdQ1GRBkUVOkywDlWWH8GbdXBd2y00aSjs8ocXEfQFVuer21I2JrutnpEGUivQ==
X-Received: by 2002:a17:902:ee41:b0:1d8:8aba:4b03 with SMTP id 1-20020a170902ee4100b001d88aba4b03mr1361694plo.20.1706465944320;
        Sun, 28 Jan 2024 10:19:04 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8b574c9f1sm2447026plb.305.2024.01.28.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 10:19:03 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [GSOC][RFC PATCH 0/2] add-patch: compare object id
Date: Sun, 28 Jan 2024 23:41:21 +0530
Message-ID: <20240128181202.986753-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is RFC as this contains a partial behavior change.
The first patch introduces a new function to compare object id instead
of revision strings. The second patch removes the special case for HEAD
in builtin/checkout.c.

This patch series enables for HEAD to be specified in any form and
removes need to be kept a literal string 'HEAD'. Consequently, this
removes the need to keep a special case for HEAD in callers of
run_add_p() (as in builtin/checkout.c).

Additional context:
https://lore.kernel.org/git/xmqqsgat7ttf.fsf@gitster.c.googlers.com/

Ghanshyam Thakkar (2):
  add-patch: compare object id instead of literal string
  checkout: remove HEAD special case

 add-patch.c               | 28 +++++++++++++++-------
 builtin/checkout.c        |  9 ++++---
 t/t2016-checkout-patch.sh | 50 +++++++++++++++++++++++----------------
 t/t2071-restore-patch.sh  | 21 ++++++++++------
 t/t7105-reset-patch.sh    | 14 +++++++++++
 5 files changed, 81 insertions(+), 41 deletions(-)

-- 
2.43.0

