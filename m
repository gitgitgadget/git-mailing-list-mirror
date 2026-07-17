Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DD348C5E
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304417; cv=none; b=GEvDVNDYFozgPnDMLHf+bUqlR8p2ASMFI/z5DgAgKStvKvLxj6sLKgPpqYMP9/87xWXjKRqyCjR8e1jvKqIj5hHEMA7P5tEN1I3g8cgd1IbF4ebxgoGbWMEGJeCzWgnWHxK8PXogqPpvbaC5wcTXadETClItacWlgP7wbopTcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304417; c=relaxed/simple;
	bh=02Q5UgXvKPkPysGqIvOhiFkKZAdKwjcf03QX5jBTtGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZwKtjRk5ajHE4nkq6BQK51GPxGb3Q/k7pDf1CU5dgQQrbZWKF9RCQzDZItUSSCMMpK4NVCKsD9FdTxIZR0bA5ZFN5SVaFapd+cATooUDbl8BpVi3HbuHrxdDik2vReCz8iq6/Soe7i4Rnkq6D3/dym5nemLgGzF+ttc2fR+4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMiDww+T; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMiDww+T"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so54755855e9.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784304414; x=1784909214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grbe/FMAMSOoDbElNLoO0nn3E8V71rkDbYAVIEurMoU=;
        b=MMiDww+T6BXABGFQE76O9NUQaeJfOi1Q6VvhrWePgJMw886PGa7KDfMNsyM3F85yyp
         4fVfn6MNJPu7Q5uGY7r2r4oTnx1QqOBnrk8BwNXCwFU0w81yGemMb26Wc3qmgQv6R3iD
         x10AfWY569S0w5Q5vN1uJYtGtscrceOH1Thp3Hwf8ft10+aenEo3mPzIj1HT5k+QIYXF
         dBr7tcUucG0cKyAvDdpgj6MQ8nQGsJdnl/XTaLdOHtzSX2aS8D2xHbqsPx1ocD391Ffh
         9NmjormcBtNILq6k7uU5cXIkUJ1PhlogJX0XJeVpGWwyZHsI6tDq65oZvi2sdqx3vXkf
         777w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784304414; x=1784909214;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=grbe/FMAMSOoDbElNLoO0nn3E8V71rkDbYAVIEurMoU=;
        b=j6KS5zXpDikUa3RS7g/52sABzs8al400jHYYHVSGAXiCQwQiwIqRxfdMEOZdwWYm2/
         HywcGDyn2we6T9sh1OBWne+R/RsLGm/DQ/owLqUgKO6hgAU4owTTrv8Ud1M0EiJC3h5K
         386WSJehJEEzlYRYNVDP4LJ6wSzyRZkIO86+TDHLC2MOm2KsCkvD4yEz8yzyYvRHv8OT
         zRQ3RLHJB0ov+iV5m5zaTtuHQJdyKBxHZOlSs5ZZoTcpXeVEzqjQWxrNPIaJ4qkzQz8a
         f49iwF0XnrNG7ok1arhRpD0V+6QfEbfDO3j6aOs4Myys+BzpARhXz61zH2vYPZy6jFXF
         BpKA==
X-Gm-Message-State: AOJu0YyK81FsBhHwA3vox4y0K1EgDROy+qg+AcOnwPeeyMWQYAxfaxOd
	Mzpg8F0Ic2kemxKwHZIQk+WQkVjWBaAecUxwX9EO/TzriIZ0VL97LzIKpYNL6w==
X-Gm-Gg: AfdE7ckIgp72YhGSV02OQumZM6Y+lxzi02PtF5ii5A0gkiJU99/P2s4BOIkcqw5kQ9n
	Y8+cKBugpuCaHSAwJ6srbub3VwCeXhxjSYmSQ0SZqdbMLVDxsYMANmlXV7A+CBPt5TWDsPPPGYn
	patDtC/LOk/AuBG5wHbYi6dfSFE8KErDoOKGvVlPG5BMY95MiLl9koeUcYAsCMdT27ZJfJ/mXNJ
	7rJiD2Ub8bWl+RTK+zTD09q7ukTiiUC0zl+hjSEmrnfYNL1htnyh2DQfyTxG9B1FPDIrXpt31vE
	t6ytKJEExNy2zcavZ/zWaqIIxFQNQyrQhpul4gY3eNtoZVnviH87wNq4yDDmrkE8afyq8EydG9/
	AImTPqzUWit1l1HSIaXtDQwp6aB5y3mL8ijIGJR65znFdY/5R2JFJ0guapL+grHa5G7+uolXdoz
	pPdwEXEg==
X-Received: by 2002:a05:600c:b99:b0:495:4cba:e288 with SMTP id 5b1f17b1804b1-4954cbae4cdmr20943135e9.15.1784304414026;
        Fri, 17 Jul 2026 09:06:54 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm5177588f8f.10.2026.07.17.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:06:53 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/2] rebase: a couple of fixup fixes
Date: Fri, 17 Jul 2026 17:06:35 +0100
Message-ID: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix a couple of small bugs in the way skipped "fixup"
and "squash" commands are handled. A skipped command can lead to
an incorrect commit count in the template message which is fixed in
patch 1. It can also mean we fail to open the editor after a "fixup
-c" command which is fixed in patch 2

base-commit: d35c5399e3e54ac277bb391fc2f6be3e816d312b
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-fixup-fixes-part-1%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/d35c5399e...7c8075ff2
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-fixup-fixes-part-1/v1


Phillip Wood (2):
  rebase -i: fix counting of fixups after rebase --skip
  rebase: remember fixup -c after skipping fixup/squash

 sequencer.c                     | 31 ++++++++++++++++++----
 t/t3418-rebase-continue.sh      | 36 ++++++++++++++++++++++---
 t/t3437-rebase-fixup-options.sh | 47 +++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 9 deletions(-)

-- 
2.54.0.200.gfd8d68259e3

