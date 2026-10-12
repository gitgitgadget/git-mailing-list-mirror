Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C822D4E9
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770464; cv=none; b=KK3qzkT3jAG2Q1SyqHQk9qKNm5nake4WkJnFFuIwruzu45mFsYt9eNa9+TJ4g6GkakCXQ5STY6Tpf9avX8uI15TLaYBys1TyDkdAlmLfAibcUPCQJm48T5d8BGoWh/SYnl+ht63Eu3sXbQlcxZAXM9GSUf8dLbDqUBYwX7Q5A+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770464; c=relaxed/simple;
	bh=N9AwabC1yaPLVGHiINDt5Allkvyy6dNsCReZ9LQn7ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBQSu+4G2R8KAllav090HA2JVAFpMiThyJ7SJx6VoEf1AJXoA1IZRWfg/p8+dLSoq9EhqzjYBsZY8iTtKqa+cy/7tuffTWk+ySAEg1icOAwHWP35MeRq3JF/H2qdbOPi6QZ6XdLcYKpe0VcsejdSuC1vveXE1zioyzL2l6yOncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nddQmsU8; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nddQmsU8"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so1684909eec.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791770462; x=1792375262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IaIIxRHk6r1fUfrKmfH4dAmtAxZ2cBP85R+I+TX6LM=;
        b=nddQmsU8Rf7hAmN/2o/DNf0CeSWyRc7eUml24qiBUXCpfj2FP/HVnX9hElE0MtPv6m
         Z9d3a+yDYwdMi8T4nuQP4uRul4hdl94Oj+VySOAe9HDriL9GOXklt4ih6GOaYLQMzkID
         mZcqnmk31MOtOkWq1ca2PHZi1O34WVrtKVKh+zWKvkX/Ci9kypeaLt9dIlqq4NJ7g02J
         nuH873jdhhdIBEsrOyxqpJ09wm0+889WBp49xIUUlYci6FjicOQr54gtjlPLfiiyIu4k
         qAnEzBMT5/aiEOflzioEfFGj6ImWFm2nRhdr8OXUYvTevpyhj6zZGqN652QnttAzn9EX
         hl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770462; x=1792375262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2IaIIxRHk6r1fUfrKmfH4dAmtAxZ2cBP85R+I+TX6LM=;
        b=Kt/OTDapx2zT99/QZPrI/BcB8H1OdTFiSz1oeUmGp9W97dJhtXh7ciWLzqpDrHFrp4
         n9hKEITSer8t6ADNjVwDJpY7jpiaMvM17RP5IgzByhRHvMxVH80Z7vFK7e30nb7Yggur
         lEJ4o3h0moAUZ6aNyeHKvg5yOWgdxI/lqU8dVBFDQSfWxA2qQnbIYfzPZlYmqJarIVo4
         JfbowlYAVXCO4uXWSk3ZrWxIkQf9gZSJvFFq0daxrMIXSVVz04qrqqKQzTuZWUa4gdPP
         CRanADH8Yd56/TdTW7WUhDNCwrOWP7PKBldu/0jFypVC4yCLGN4kPLb58ldYAF9xUwaS
         s4hw==
X-Gm-Message-State: AFq9FYItrcNswtaKsh9HpSoLdSrAtfKGMkCbe8s4pvBtrKCm8Lmryw2v
	z+CagBJzaitsDp1yIXshP7XOxvfPlwmPfUUAzBobjMklWpkqoBocj9x6lIcLzHKozUY=
X-Gm-Gg: AYBFou0uknDsR+/PFzx79GtMqBi9GEecXMzdm8yMBZPP2JYAQOb+quU3dWM1ZMTJJVa
	J8TlwFr+nC4Y1yKY3/K0Pe6doWsQfYcMvRqshQVnYnVveJT+VBTfyjoBL+MzjU4oO+/18C3+JKy
	haUZ3ADPxfPWFm4Pq+Zz09sFeeAIb8g+Be/r66pGVa+yHSITLq6K9JGAbJHBzejha7TEz4M0Aou
	4MkDKPeiOxPwnZfjLEKvFpa83bzfSkNcz5zYBdLe2OHdv5/QtFTRaJtOp350tpGxQtxxCnskYYw
	SzIN+Aeb06pimkYYtQGr8QxcFDSyH4mNd6gu/3fT+Lqd3X+QQlFoB1PzO0cy3FN9IVlR1Ye3YW4
	Cnjf1O8snbNIoD2gsShisSyRV9bO0MUDOcIDoDfRmegpdwtZ7WiiKuMqYP10kjVr0tBxLlguywE
	f3f6h0MraWHroj68E+vTofbCd8wNbIlfd8emTE6nAoryVC/sBD3wqJwIIu8oEWfbyVhRLvdXITV
	ytCcT2P65WrJNRuJKrPJMXL1nvPpMr1
X-Received: by 2002:a05:7022:3f0c:b0:151:2e62:fe8d with SMTP id a92af1059eb24-16a5dcf817bmr12527077c88.9.1791770462354;
        Sun, 11 Oct 2026 19:01:02 -0700 (PDT)
Received: from isabella-caselli-linux.. ([2804:14c:9e:81ad:adb8:bc9f:a8c8:3c2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35a352d4b05sm7196412eec.19.2026.10.11.19.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:01:02 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH 0/3] Add hostname condition to includeIf
Date: Sun, 11 Oct 2026 22:58:43 -0300
Message-ID: <20261012015846.2649843-1-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a "hostname:" condition to includeIf, allowing a
configuration file to be included only on machines whose hostname
matches a pattern. It also adds GIT_HOSTNAME to "git var", so users
can see which hostname Git uses for matching.

The series is based on Ignacio Encinas's v3 from March 2024 [1].
Ignacio dropped the series and agreed to let me give it a try,
so I am sending it as a new series.
The "hostname:" patch retains his work and credits him with
Based-on-patch-by.

Changes since Ignacio's v3:

 - Drop "test-tool xgethostname". Eric pointed out that exposing the
   hostname to users would make the helper unnecessary, and suggested
   adding GIT_HOSTNAME to "git var", which I agree is the best way to
   make this information available to users. Patch 1 adds it, and the
   tests use it instead of the helper.

 - Make "git var -l" omit GIT_HOSTNAME when the hostname cannot be
   determined, rather than failing, as Jeff suggested.

 - Make t6500 use "git var GIT_HOSTNAME || echo unknown", as Jeff
   suggested and Junio agreed.

 - Document that the hostname may be short or fully qualified, using
   Jeff's proposed wording, and point to "git var GIT_HOSTNAME"
   instead of gethostname(2), which Eric noted would not be helpful
   to users.

 - Use xmemdupz() in include_by_hostname(), as Jeff suggested.

 - In t1305, read the hostname into a variable before each
   here-document, so that failures are not silently ignored, as
   Junio pointed out.

One open question is case sensitivity. Matching is case-sensitive,
like "onbranch:", so "hostname:MyHost" would not match a machine that
reports "myhost", even though DNS names are case-insensitive. Keeping
it case-sensitive seems reasonable to me, but I was not sure. Should
it stay as is, ignore case, or have a "hostname/i:" variant, like
"gitdir/i:"?

[1] https://lore.kernel.org/git/20240319183722.211300-1-ignacio@iencinas.com/

Isabella Caselli (3):
  var: add GIT_HOSTNAME
  t6500: get hostname from "git var"
  config: learn the "hostname:" includeIf condition

 Documentation/config.adoc  | 14 ++++++++++++
 Documentation/git-var.adoc |  5 +++++
 builtin/var.c              | 13 +++++++++++
 config.c                   | 17 +++++++++++++++
 t/t0007-git-var.sh         |  5 +++++
 t/t1305-config-include.sh  | 44 ++++++++++++++++++++++++++++++++++++++
 t/t6500-gc.sh              |  2 +-
 7 files changed, 99 insertions(+), 1 deletion(-)


base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
-- 
2.43.0

