Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1E18DF9E
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594720; cv=none; b=ISbltO9vmNeVmCy/t2IkmTAseetoP9k7JhJBD7LiZZFzuxbmQz/oFkug9mnzNw7MwQ6JtRTtrrx2JMnGGdOJMO8sc1FgKmcxqgy6DNgvsUXUnA8RSBNWBTIN7FIjP+hxd1yd8hkPIVRjublccimy2nYT3DM4IAz8biXquP5AaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594720; c=relaxed/simple;
	bh=51KIUdNj0dJpqN+PGAWAPKLFCvpX+qBLnE55FPJzFEU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HvGfsEvJOTb+HeRTjwzpBzy4yvtuP8sOIqt8uCt+Mmi8bDlyL2urZhjPXQ/6PFx/PC1dARVu7bfwszE55jZ4XPVrTugtRtmSdwvNR7Rbhi+2pzLWQztzXXFAVX+xu8pU8nkNwPLfLJYTLqn8CjPbM5UR4o+bzOdk1BxdmyGvTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CaRXYytl; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CaRXYytl"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e920cf6so26733817b3.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728594718; x=1729199518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dVkjaKUUU0LNmtfW1zfdQxnT8wU3fM81nrivjdhAhBg=;
        b=CaRXYytlIGeDg9uOtGkh17dz/T/BvT6+cIOYXkPuUrVQSlTLnuZiYfCOTHif83pA09
         aJmk8BaRyweqpS6jiuqHlfl1JCwrhJIsOroyOVZ4jlOg+Mj4ohGeHPxuh2NyZbMxfGyj
         +qC+yBKw70LeQl3wFd+WLCMrZsL13uEdgZfwEiCu91viwk1OCABQTbeUTUop+XtImU9O
         DFe/+aSes9fZBHBFeI+6f6+9K7iJLyiz710hM8GwBgdZzEkhLhU6xpsOJxK3WzEPwkOR
         3qg+H6xYKOXTAFWzLIO82wJLAda46n6cUcTqrcsPkBnkZoMM5tpjspUG62O0jMKgGJoQ
         Z2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594718; x=1729199518;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVkjaKUUU0LNmtfW1zfdQxnT8wU3fM81nrivjdhAhBg=;
        b=vAMn8cu2CNE5AtpFRHS2PfKFzbfB1imhh9KWqVDaoUgf/ZfsBNmYP9CogzIYGLr/wE
         3E7LMEh/c2y/UOe4Zhl9pFks/34B0czEGk/tNQcasF3xzA5L/iRO8zZjHGNn3tM1hlUc
         OL6oZTfjVRjqQOXvQOCyMxRbnpqgdSMMuQds3sfo1jJP2mEq8dwUS2+GWfdbRH6Km38Y
         scbgU60mM/DQHHgb8hvFnIv3EDn7Gv5DyGSr9TC5jqt1vzlkZjhLZEJ7wV+wsWsBauoK
         OtGff2LpYrpCq7NY+nODDILxNlVNlpbhr/Y1qrn94OHHxIUnUvw4Bqwtr954suwbbzwO
         NCfA==
X-Gm-Message-State: AOJu0Ywr8L7y5bD1by9FJmXSdBa/+5OFgBWbSqEeRD42/N7g+ct5q1r4
	pZxBzaSQmTZn8Aeet6FOpLZrypzzoMZWVRNqQx2s70ARMwHCUsm7qvj/ul6F+MFuc4e2vd5HGZu
	zzkPNrEFVMPJDTvWkz2cdG2MzF9NKCUBuxOSUBLMMMwVZ/kpuKVrxRZ6rK2BrMV5R3TALvskv+L
	1uxndJ9YWdGiFe6tK7qnhPLoSzn2a4b/LSjTV504w=
X-Google-Smtp-Source: AGHT+IF/0H5AsAzKhXW2VDDX7yfiwNp61PXlkNqponxAAp6XIYsQP9nLELGkI8Av7Tz8I9LjVhGjZDv8QOGKcg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5a71:d442:305f:726f])
 (user=steadmon job=sendgmr) by 2002:a05:690c:6009:b0:650:a16c:91ac with SMTP
 id 00721157ae682-6e347c7f1f0mr26917b3.8.1728594717703; Thu, 10 Oct 2024
 14:11:57 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:11:52 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <cover.1728594659.git.steadmon@google.com>
Subject: [PATCH 0/3] fuzz: port OSS-Fuzz tests back to Git
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: eric.sesterhenn@x41-dsec.de, jarlob@gmail.com
Content-Type: text/plain; charset="UTF-8"

Git's fuzz tests are run continuously as part of OSS-Fuzz [1]. Several
additional fuzz tests have been contributed directly to OSS-Fuzz;
however, these tests are vulnerable to bitrot because they are not built
during Git's CI runs, and thus breaking changes are much less likely to
be noticed by Git contributors.

OSS-Fuzz's recommended setup is for tests to live in the repository of
the code they test and to be built along with other tests [1].

Port some of these tests back to the Git project, so that they can be
built and tested during our normal development workflow and CI, and as
such avoid future bitrot.

[1] https://google.github.io/oss-fuzz/advanced-topics/ideal-integration/


Eric Sesterhenn (3):
  fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz
  fuzz: port fuzz-parse-attr-line from OSS-Fuzz
  fuzz: port fuzz-url-decode-mem from OSS-Fuzz

 Makefile                                   |  3 ++
 attr.c                                     | 38 +------------------
 attr.h                                     | 43 ++++++++++++++++++++++
 ci/run-build-and-minimal-fuzzers.sh        | 15 +++++++-
 oss-fuzz/.gitignore                        |  3 ++
 oss-fuzz/fuzz-credential-from-url-gently.c | 32 ++++++++++++++++
 oss-fuzz/fuzz-parse-attr-line.c            | 39 ++++++++++++++++++++
 oss-fuzz/fuzz-url-decode-mem.c             | 43 ++++++++++++++++++++++
 8 files changed, 177 insertions(+), 39 deletions(-)
 create mode 100644 oss-fuzz/fuzz-credential-from-url-gently.c
 create mode 100644 oss-fuzz/fuzz-parse-attr-line.c
 create mode 100644 oss-fuzz/fuzz-url-decode-mem.c


base-commit: 159f2d50e75c17382c9f4eb7cbda671a6fa612d1
-- 
2.47.0.rc1.288.g06298d1525-goog

