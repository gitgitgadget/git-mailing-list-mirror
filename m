Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1542C08B0
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190479; cv=none; b=Oy1M09YsMTbYpId9rEL3gPAWPfuhQl7NSvQC9YcobwACPxjemsfL76YR123lbwncbtpaAgg/TQRBkEu7XGOaFCx6mfKIR4GNOVu5yH4Hi4ZIWfvbxGng7k/G0izW3OHdahf1ME8uw48g4vQjJd9jkDOlbO/dZA7TDPyPIpKvByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190479; c=relaxed/simple;
	bh=RoOZhJTR9svDJMGWKHF/6vPHaerhKL5YcBdLYHSTw0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0H/22j6X5EHNUdM/y7JIg1eJ5Z+tzllo3i77hCwJaYQwsgTgEpIIfZM2AOObn+n1rX/tEJvgQe/gDgPmrLeu3Xq0FoXRWCCnnuRCo3FZoKjDFtHDHoGnRzvpUbszt8xY6ePsf1c8mRc37X7mvWjOwOazykQzXVhiVJs33OMRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKASkbhj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKASkbhj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24664469fd9so28698105ad.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756190476; x=1756795276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//5DeNgRn9CQ8XMqDYjCJlKAdOduhIHZbQQHG8Zosq0=;
        b=BKASkbhj/xgtO2c6D3N6/RXVbMWt+m3+y7Vko786qcy1Xz+GtkcTZ9iYQk1YtRXpOV
         W1c8PQ/JbJvcfpzq42QRv6aNiIhWCO280vxR82mwan69J69J/Vp2o+muDNefdxQjr0Xq
         Tz8KLgDl2R+x8zjrkgLl44scfvQu71payJ6i+aWRXnnBoC7BdL5uiqrr7teY0MUiMtRS
         ovrRmO17D7EYLVDzBu4BKRZwiYozMje45Jb//+Jt6lnEtyOedBZMPdM0rHNLUdDtudt8
         wwwHRT1EiYgP1ImBBhqG5gd0TkvRqhI2SgS838RZe1BYC6WqiWlbV+BhxnsV25T5xBFW
         k2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190476; x=1756795276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//5DeNgRn9CQ8XMqDYjCJlKAdOduhIHZbQQHG8Zosq0=;
        b=ZmjOU6jLvaA0rz9/DuOqzAIerrIDz7ud7LMB90qPtizk8Hspq/J/3hl0LO7XjtXplL
         lrS9D9Na+THcMTTv+puGIIt0TR/5qEY5Kln4KLEWo9taSbRLoTO9N4DhFQd7cpyDx15P
         libtLWqCqIVjOBpTqopnN24Pc8DuTSdxK2n0EVum9trxzE+3mm6otTO/dToSH6FXqnvZ
         xfhc3PXCqIVAw0QQlcF3p1qfGpJVUqYsL06uNnO9krjlVgvT4AVAidXeVmTbjfkvxx1R
         /VYgwRxgUg9K2MYGVPm0s0zoqjPLoBVMsyuBjuPEBwPkFMzepsjYHDKyetss3FM5JtdT
         X7EA==
X-Gm-Message-State: AOJu0YxMKSxebK/M15VkZF6Of6z9iS/BWsRsyTpfGGyzvphgyb+0DKf/
	XuKFB4QLU2fzzJNl2CV4ZYyNOY3olgvezP4yvhcHOeVvVp3ueeqQCdGKTqiBFA==
X-Gm-Gg: ASbGncvLf7HAHSLVCJeyAy8G5jjRe8rV+wr3HeJ3zNccxoE9DLhYmtoPj0VNjtSCxS/
	KqOzcmNIe8sOxA0nI5c3JWj0hGfPrklw6rtpnTdw3M+l8PdPq9zVYaE0RAWfR5UuFfvA7wrxwlx
	tDeXbs0Dl2zi50Uzm6IHkkRtSJZyBv9rOn0ZEkGh+YmYngDXIUe1qT2aEsc+V3qFDgUCTYVQtEz
	s3ojx8Kg1EEZs7snF8GkNy4rVxHjyJrSNm6l/RvZ6iMu/ymyOA6+PpdtPbGsM/f9pWybzApbeRc
	EcLQjV+L7Zd7WUhXzJaemcRCChlDnm4Cqc1HrDK8wss7UfOajp63ji5mogQdDa4QPAPI/aHm7Cn
	Iqw7mRdfNkk7vAEnnn3A3tTJXlTxYzg==
X-Google-Smtp-Source: AGHT+IGEFq3bB58TehR2VjrxIVkH39yLOMOGjeg3LwPM9wmVPHGR5Dmp9QcXtNVvHHB9mhg33lvXqQ==
X-Received: by 2002:a17:902:cec2:b0:245:fd9a:c90b with SMTP id d9443c01a7336-2462edd6b48mr226167005ad.12.1756190476184;
        Mon, 25 Aug 2025 23:41:16 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889ddc6sm86442025ad.159.2025.08.25.23.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:41:15 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 0/4] Add refs exists subcommand
Date: Tue, 26 Aug 2025 12:11:06 +0530
Message-Id: <20250826064110.10540-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823060012.540433-1-meetsoni3017@gmail.com>
References: <20250823060012.540433-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces `git refs exists` as a modern replacement for
`git show-ref --exists`, continuing the effort to consolidate commands
under the `git refs` namespace.

changes in v3:
 - Reverted commit message.
 - nit: added empty line.

Meet Soni (4):
  builtin/refs: add 'exists' subcommand
  t1403: split 'show-ref --exists' tests into a separate file
  t1422: refactor tests to be shareable
  t: add test for git refs exists subcommand

 Documentation/git-refs.adoc |  7 ++++
 builtin/refs.c              | 48 +++++++++++++++++++++++
 t/meson.build               |  4 +-
 t/show-ref-exists-tests.sh  | 77 +++++++++++++++++++++++++++++++++++++
 t/t1403-show-ref.sh         | 65 -------------------------------
 t/t1422-show-ref-exists.sh  |  9 +++++
 t/t1462-refs-exists.sh      | 10 +++++
 7 files changed, 154 insertions(+), 66 deletions(-)
 create mode 100644 t/show-ref-exists-tests.sh
 create mode 100755 t/t1422-show-ref-exists.sh
 create mode 100755 t/t1462-refs-exists.sh

Range-diff against v2:
 1:  19623eb97e <  -:  ---------- doc: factor out common option
 2:  69c207dc45 <  -:  ---------- builtin/for-each-ref: align usage string with the man page
 3:  6eeb1c070a <  -:  ---------- builtin/for-each-ref: factor out core logic into a helper
 4:  eecccfe98b <  -:  ---------- builtin/refs: add list subcommand
 5:  aa91c5c570 <  -:  ---------- t6300: refactor tests to be shareable
 6:  fed66d91c0 <  -:  ---------- t: add test for git refs list subcommand
 7:  b55e6d36eb <  -:  ---------- diff: ensure consistent diff behavior with ignore options
 8:  e1d3d61a45 <  -:  ---------- diff: --no-index should ignore the worktree
 9:  621ce9c1c6 <  -:  ---------- git-jump: make `diff` work with filenames containing spaces
10:  9a49aef8dc <  -:  ---------- environment: remove the global variable 'merge_log_config'
11:  22d421fed9 <  -:  ---------- builtin/fmt-merge-msg: stop depending on 'the_repository'
12:  741f36c7d9 <  -:  ---------- docs: remove stray bracket from git-clone synopsis
13:  1fa68948c3 <  -:  ---------- The second batch
14:  d1fa4e927e !  1:  0c9349fa74 builtin/refs: add 'exists' subcommand
    @@ Commit message
         builtin/refs: add 'exists' subcommand
     
         As part of the ongoing effort to consolidate reference handling,
    -    introduce `exists` subcommand. This command provides the same
    +    introduce a new `exists` subcommand. This command provides the same
         functionality and exit-code behavior as `git show-ref --exists`, serving
         as its modern replacement.
     
    @@ Commit message
         `git refs list`, where sharing the larger implementation of
         `for-each-ref` was necessary.
     
    -    Documentation for this subcommand is also added to the `git-refs(1)`
    +    Documentation for the new subcommand is also added to the `git-refs(1)`
         man page.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
15:  f1dfafe6c9 =  2:  d32067af55 t1403: split 'show-ref --exists' tests into a separate file
16:  a2a65c428c !  3:  fb7223ad07 t1422: refactor tests to be shareable
    @@ Commit message
      ## t/show-ref-exists-tests.sh (new) ##
     @@
     +git_show_ref_exists=${git_show_ref_exists:-git show-ref --exists}
    ++
     +test_expect_success setup '
     +	test_commit --annotate A &&
     +	git checkout -b side &&
17:  e92da499b5 =  4:  75b5ee4ede t: add test for git refs exists subcommand
-- 
2.34.1

