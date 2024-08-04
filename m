Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0503BE47
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722755546; cv=none; b=oGZm0tQFWP8afQ50tn5F/9xgLfP+7tecA/c/n9MrRpJ1XOZgI5lQbm11gA+5Zs/cFHEtq9fQ2Qw5UuM8sTHPXb9nc0aL1a6TPmBchoCJnpISktG7HBaqWRqEswr+eupWM041/DNkXm2eHQz8qsoYLXwXy7o5VGUvb0LkwFSpxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722755546; c=relaxed/simple;
	bh=gnSGU+WWZzIuvUjKCRtllXXqbGvQGhoQwiwGB4zcFYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t421zgV0jKslwo8yrvanK4L4KFyAujEW99wa/axjBFGZFYv5ae/Z+FaTh9qqqKfa7IadkKMrnixh9OsKQwWjoSsQs9z1WZ5mnrKK8pAyq961YhyERikWerHvtfXR0XiVn2BqJFu7LQiS1HCcOIeFab5Smq7tgT94/vYcWrIeIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kld0TST+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kld0TST+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428243f928fso59097205e9.0
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722755543; x=1723360343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d48DUSgpn19adYHxGvX9g7c/kdkVW1q0AmIGtYhICN0=;
        b=kld0TST+HRqICXKEymEgFnyb/RTPzg9WiL1oBQc0KfRtMIxSgR8S/SnfE1K50PmNs9
         +jJc70Ccep08ll6FR3CgobQM+B5+rLCx0VZBOahYLunGHS7UG2ILf+pYcTAtYWTCqth0
         6Wj6prTacHhImbz403P0FwYAJHoT9xAPmRgCqNU4YC34hczih66adIuk6cyn9sClglYm
         aeA1XIlC8gOMMH8ln/88p5PeoEbSU23lGzwNBu71WyNVVnMJFy2mDgEH37FQIzuNlcgQ
         ZFFgEaI9VIprLYZ9lKWi2m54W29xmUl55DM3+THcfR5mviD1GnkqdPIhtKeVL15qmvlf
         AxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722755543; x=1723360343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d48DUSgpn19adYHxGvX9g7c/kdkVW1q0AmIGtYhICN0=;
        b=rOSt1Ml32KEvPDLFQgm1tM448KUSmvHOB4Zj9OtxD+Nzf5c5hwCcq2XJGSmk3N0b0K
         XMS4f5Qz46R8o/RaEb1SObt4aCtH5VzlOP7msM2Z8vXk7ACG5k2S5KmJIHm4HMHsdl4m
         7SYhAiWpPiNXvwVYTxhiW0iCduIB7SmtNcMYMlzfuniRBv+HX8Pd8LShM9Z49qi1fEjA
         ZyfxVmkWeGWikSwjby8v3BEy1/sf2F01of72HM7vOBs3DLC9kxC1RMJkWmMMTANWKTln
         iFI7Dn5+MeI9hC3DergcFyejWL0T/7RLvC0oGxKAwSw+S0viIFtSQyEsREpEUwvn4//6
         HS2w==
X-Gm-Message-State: AOJu0Yw1MqT+KZeTlF4TYLRBR7ndkbaP/jX8gIZczxvIDUaPc4pdzDAC
	uP5pxZcX14XJSiTXbUFsrLvk8hZbyjkRszVa3zmk7p/V+WPwCbtCWeUavEV3+8g=
X-Google-Smtp-Source: AGHT+IFB7819PgDQhHaCDNeg0MXcuERmduoompzNdwZ9kL4LiA5huT8Cd3meA8uKvCw1JuHv/EpXkA==
X-Received: by 2002:a05:600c:5489:b0:426:6b14:1839 with SMTP id 5b1f17b1804b1-428e6a5f361mr79637435e9.0.1722755542552;
        Sun, 04 Aug 2024 00:12:22 -0700 (PDT)
Received: from abdobngad.. ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3c0b7sm88477595e9.23.2024.08.04.00.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 00:12:22 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v3 0/6] [Newcomer] t7004: modernize the style
Date: Sun,  4 Aug 2024 10:11:31 +0300
Message-ID: <20240804071137.30326-1-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- remove whitespace after the redirect operators.

- move number of expect files prepared outside of
  test_expect_success to be inside the tests that use it.

- split some lines that have two commands into two lines
  one command each.

- turn some "<<\EOF" into "<<-\EOF" and indent their body.

- avoid using pipes in the output from "test-tool ref-store"
  and write the output to a file.

- change test_expect_success that are seperated from its name
  to be on the same line.


AbdAlRahman Gad (6):
  [Newcomer] t7004-tag: redirection operator
  [Newcomer] t7004-tag: do not lose exit status to pipe
  [Newcomer] t7004-tag: one command per line
  [Newcomer] t7004-tag: do not prepare except outside
    test_expect_success
  [Newcomer] t7004-tag: here-doc modernization
  [Newcomer] t7004-tag: description on the same line as
    test_expect_success

 t/t7004-tag.sh | 584 +++++++++++++++++++++++--------------------------
 1 file changed, 274 insertions(+), 310 deletions(-)


base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
2.43.0

