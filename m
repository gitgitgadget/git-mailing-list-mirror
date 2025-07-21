Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654B27FB22
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098927; cv=none; b=obvLPaXamFc75Q+TN+GQJxfWlQ2ZD1fbqMwQnMNIe0d9jtXqnxicQeixhMi7zuRDfVw5vsGVYT9YtwU0o6cO8C01b0FMMdXQMWwTrx7fSa5HEbjzwaxSjIo2dVLo12Yd+cXEsS7G10Bd3OWINNkzTfDkvMfl+WaA/qcS36peiYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098927; c=relaxed/simple;
	bh=8aD+6K/hTtOp98bqnXpdP0hQNlfUijVGdQTnG3eHt6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKwv/0ye555AuKQ1qjbiAqRYTg0mAiTkDvNsPmYmgIcOm0fyfzb3CG5rtawYP7zzfWR6bkIRBBqUIxk4d9lJ1c4l2aN7TqB+bky6pr0Y0l4yrRhALJxswO4gYDZhB6tsclOGvFvtuGr3uJSjpm0nC/mJL3Q2q6jP0+r6egvGa90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvCI9dij; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvCI9dij"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31c84b8052so4641424a12.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753098925; x=1753703725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L8HjHNclbEBk0+y+tYNwhbMs4RDIayjqzVgLc26PAM=;
        b=bvCI9dijd7JU60ilugv+BqbYqiG6Ye/APoMJV7hiNBmmEd0zfARfFEMFajlG2oPSq3
         K36ndwRsKo6K6+Vjdd/bAvDKQHv09CGP9sxFU4uAZWASlhE/m9zX1PJoiIQp0TaazAiX
         mb2GT3DF4rDhzDN9Dpwn765zmT/hXCVjoCMs1ygIHgVxXgKLOxOchiQchDeAsl8XQcgZ
         8kT+D/xZ/We9wCHkWmTiEzlO2aUUq/axU5aNoFyIJxLrv5rJt8ILM35v2Olm9vnn1BrE
         m30EivsZyWhcPi/zXRvXQqWaVqg/tiL4zNFZR8H10MFGL5sXT2biIjX77Hlp0spNTPfe
         rxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098925; x=1753703725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L8HjHNclbEBk0+y+tYNwhbMs4RDIayjqzVgLc26PAM=;
        b=P6ze0L11ypLUfwwderWyWa95SOiRKOLf6c/9EtklaKFXicM2/4h9YqyFIvWgNc9nFS
         qcKTxhbGN5BovlTKV28xChplxS3xL5XftMDK2gxLdqcpJm7OGgfwzD2Er13ad4scVc6x
         AvOZuFQBaLHgcugbWL2/WchM9qIW336xl4TMA4Jqk4YGmb+ar/nUBcN8EDPRla4xa2Wg
         wxyFTVsSEWo/weIZE57b2Nf5y2+ZOMgBMXOHOrEgma6OnzqFT44c2TL6jMmfj6X/5KGc
         Jk2+TPzlGotjX4Ojfq+Gd+b6bQE1TF8i1JAyvsKLLVvImDhO+RY+NiSqkIQtP/0uLeU4
         z1rg==
X-Gm-Message-State: AOJu0YxsIQBxTs9Bul9E63Wix3GLm46jSz6c+4ImuBxIifXaKVc4D0nz
	091XTrXSY+31JXc0ILskzLtuYLtrsPKOyMEPTCYz+F8gJG9XFtepHK+HeCFxTLoQN/w=
X-Gm-Gg: ASbGncsDvxnXFdC/7+S5B3vKnB/QPPTFqoVc5+AB7EhipsTNI4UW2pYpEfttiMVzuKU
	Hpr6rUwcpsX8PadWs40wYFtMLPtoP8lcTPuovPjzqg8r0/0+2IASg5pPiiI18zZxd9pEGhQP8E1
	+epKRMv3i0akulKtVHbcSGcHwvyFvUeaVBv5FRMnNYrCSLNnhld/2MBn7g5FdQt6AjWlFyo30hz
	MxuTdDDYLDbQrTc9l3o0SjrYJ9BayHg5BOCMbzkG7s1Tcs5Eg8Sz3liKW3wWIzKWY8Tve40GKP1
	E028bJ5xD0eX5WsOSctW6sanmpVQ3f6BAMZvgwnnDu6M77IyIhSpj65/iURYJunK3w7IY6Dd611
	APIx6l1woWZNMSgPkC1yw48aGuzJfTOrbmzBvM3tjeteLxuU=
X-Google-Smtp-Source: AGHT+IG1mNVmnhMOJCd505fcxI6vNUHO38IKXQNJUT9s/eFvJu/ZVvTU4wrsLRzhgluSBzwusCrtbw==
X-Received: by 2002:a05:6a20:9188:b0:233:f0c6:a8a4 with SMTP id adf61e73a8af0-2390dc51bc4mr31909941637.31.1753098925264;
        Mon, 21 Jul 2025 04:55:25 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ffbce6esm5135940a12.72.2025.07.21.04.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:55:24 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com
Subject: [PATCH v4 0/2] refactor t1517 to focus on help output outside a repository 
Date: Mon, 21 Jul 2025 17:25:17 +0530
Message-ID: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <xmqqcya63cqx.fsf@gitster.g>
References: <xmqqcya63cqx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors t1517-outside-repo.sh to focus on testing
`git subcmd -h` outside a Git repository. It does two things:

  1. Moves the existing `update-server-info -h` test to t5200, since it
     tests behavior *inside* a repo and belongs with other update-server-info
     tests.
  
  2. Introduces a loop in t1517 that automatically verifies `-h` output
     for all main Git subcommands when run outside a repository, using
     the `nongit` helper and `git --list-cmds=main`.

This makes t1517 easier to maintain and ensures that new commands are
automatically covered for this class of behavior.


Changes since v3:
  - Changes the approach from having the t1517 to test
  both help outside and inside repo to just having inside repo.

Usman Akinyemi (2):
  t/t1517: automate `git subcmd -h` tests outside a repository
  t5200: move `update-server-info -h` test from t1517

 t/t1517-outside-repo.sh       | 28 ++++++++++++++++++++++------
 t/t5200-update-server-info.sh |  5 +++++
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.50.0

