Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C317BEBF
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744438806; cv=none; b=qFWFDa04Bp7gg1jSkp8P+P14YWCB08eteTEmGKoNLa1dToCgkfLFy9cnZJxYCuGjYNgh+V9mgdJdfc5+yBpyOTqqToXj69JsBdu41ivcDiMX/1omsZSKnDM9Jkm5KUcNUsy3e3RBXTmBr2tULHCbUC6X1nloGOlqfZAwgO1Cu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744438806; c=relaxed/simple;
	bh=CUYC5CKbKmXBx2t5gYC2jH5BHokrvNhc0vkW5ftOgiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eg7yiNOBHXP9nt79T9z7YR+D9Uwj5i3xKqu8jhDrR+fD+CdGc+cHQWwV0pc6/1yU094A8ykhpd3tUiA8eaLYRfOlcUVcp/q2VNLp5wQNOu0DyrrQ1/1q+Dt3Q5rMfvfDS1D2j748g+N4nz3Thk4x7p39qAM1j3xeJ609/ArC3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWomMc5o; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWomMc5o"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac73723b2d5so533657566b.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744438802; x=1745043602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6CT+ul/5bi3oRHPKCyTy4ttyS4M4U0PPswBukIjtmA=;
        b=TWomMc5oKPfXJHebSTUVLDFps/4oRXJvRlp5qlDPwJz5a/hBZuuY5hwQBG2Gj1s6fA
         oNy1G9cHkIHgh5Wkh938wFwQ/E2nWo0CZ2f4oerWbXVuRTgtcdqZvoWBifPcg0V6QsHA
         OF8TPDEJU7O2nwUTeelssKjKdUZhhbFASwitKBl7TCynIqhRTx1hVzW4IJLQ/Ldmpovt
         NGild5RqRczVe3THCYMQP9rm+ER8evl3yr+KCUaFt3q/36zPqIJx+Jyqekqhd+/ZF09L
         fbsNQFAH/DU9YkbzcVHOHGxe49qawYpsbkmpkTHHQLP3/b7UsNj4xtqS2otbxMkFJGyS
         cZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744438802; x=1745043602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6CT+ul/5bi3oRHPKCyTy4ttyS4M4U0PPswBukIjtmA=;
        b=nRsSj2Ji1kmJYIXv/lOy6jloviJQ5KUypTHIMEFX9d433PIrFhzbc7avBDX10i64p/
         txsnyt93M8Fc+QlEZcmmtHnu7ESkn4lobzFmPau92jssxn43JUivcVGaN+fMQahOGtHJ
         e/F1XCHhFw3WoNefoJVDPOe6wgsVgRxi/CZLSmgS956Zv6+zh7NbzKUDrDGfDhlb6Z+B
         KclX34mRaMmIbrf3RGbtMwWA3EYb7Jl8bb+fL+zLmun2DiTalVqoq+K7h4dnODnDOmuE
         CREWFQqXn4ldca1u2EZq0bKrqRCuHB1mY5xiXUj2Y2v1+pTxbnf4aVkZmFLKRKwN7WJX
         LYAw==
X-Gm-Message-State: AOJu0YzLNInAwnkr+0McMSxZwkGh2FD8PL730ZiNAyCsL6wk7QSH+w7k
	7ad3V7uZyaWLeqQvT47k9vz1qGJzlmTot0dP8rbWDkbvPMNOSP6O7cQE3OZZ997kUB0=
X-Gm-Gg: ASbGnct/e7vOSVXxsUXznTd7CnIX9HN60dZOiL4npg+QdSd8ptKCJ1JK0//s4+rqFPk
	ZGH8kseOl96wCV8d8Spv/bXgNN4LQ8WUQK6b6AtsMMacyZ0YvXN0ibFIvbyz3aywYhJga1sSzkx
	ejLKf4cG8Es96NmpNTOnk7+HGsQPenJMEtvZyEuEImDp4IZSMzn6PQqB++OdOclyFTjIA1UzXC1
	+0qny3P24vaomN0SdbA+KBpJu+5DlabYeAoV1qtmNEb4G/K4FlP64JwB4nANysOPMQrGSidKLiY
	QQ0LlqrOYI4fMZ9u0ub+pW6wib1K6Amc1oRYSk+W4UtW+UIOq2KsRNZNHPK019eayRU=
X-Google-Smtp-Source: AGHT+IH0T20H//odHvVr/HwVibqJQNNDiuQG82BptKYNF5M+gndMFEtmQ+Ntx6x96q+6MILRfOz86w==
X-Received: by 2002:a17:907:9810:b0:aca:b720:f158 with SMTP id a640c23a62f3a-acad348a128mr488863766b.13.1744438802069;
        Fri, 11 Apr 2025 23:20:02 -0700 (PDT)
Received: from localhost.localdomain ([206.0.75.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9c27sm558519766b.68.2025.04.11.23.20.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Apr 2025 23:20:01 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: [GSoC] [PATCH v6 0/1] t9811: be more precise to check importing of tags
Date: Sat, 12 Apr 2025 08:19:56 +0200
Message-Id: <20250412061957.81747-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250405103718.25160-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to expose more testing outputs, we remove the piping of `git tag` 
outputs in order to expose the exit codes. In addition, we change the 
usage of `grep` to `git show-ref --verify` to check for the existence of
expected tags in a cleaner manner, preventing false positives. We also
check to make sure TAG_F1_ONLY does not exist, as it is not expected to be 
created in this test.

--------------
changes in v6:
- removed unneccesary calls to `git tag`
- changed commit message to better describe rationale for changes
- added missing sign-off to patch #1

changes in v5:
- moved commit message to message body, and fixed subject line
- fixed whitespace issues in patch #1

changes in v4:
- changed `grep` to `git show-ref --verify` to check for the existence of 
  tags, and added a test_must_fail check for the unexpected tag.
- consolidated the three commits into one, as the changes were not 
  significant enough to warrant three separate commits.
- added a new commit message to clarify the changes made.

changes in v3:
- patch #1 and #2 were missing my sign-off, which has now been added.
- patch #2 referenced a line number, which was not informative. A new 
  discription has been added referencing the context of the code.

changes in v2:
- patch #2 and #3 have been added to reduce confusion caused by the 
  implications of `grep` followed by `grep -q`, and increase debug 
  output.

 t/t9811-git-p4-label-import.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.39.5 (Apple Git-154)

