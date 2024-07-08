Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0233D0AD
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430612; cv=none; b=jGmgHtyMQw3jnbf6xsmJxk/0x7icHFYHT2HRLqn31//djgokNL5QVI17kxcikv17n/qljin1KVkDhM6cic/z10GLPDVV3lwOQnyy1LjEh4ejDV6hwmReb1/M2uW0gMdwKYoRrIfnNJivpWgEe3q6ZqwA4km5fH25mVKHifRrtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430612; c=relaxed/simple;
	bh=PUzCKn3hzTeNuENeLw8nH+0Q3g3kaJKwmY8KBoluJHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4bq5AhvPY93+7odwXwU002I9G9291kmbmQRfhRz8w0DAjCJfKVqPf24eYbibq5V7PM8zAA/HewmksSUrip9vsmWIVLKQGLB0Xk8StvkAS02y8qvnGJ1vze6sNs22+jEUbsoIiOPvrAMPpgqEXqSIiQG4XqouLt3GCSNLrBKTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT5QlAGn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT5QlAGn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42665be6916so6037765e9.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430609; x=1721035409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WgxvtLiOAp+6ebFIskn5swjtLMXmDPvDwEsUZDXcbE=;
        b=AT5QlAGnU2Aypa+3X38YYL7HqV+6Mdgf6Gi/iguzepXWuk1OCq8izcn9Z8bhhxMcyX
         CmAXKAL8T81Pp7uZw9+LzrnX01EgSqRcsDN1qcf3Op++reUV0eDVChG0fs4uQyG8WRD9
         L//A93NMCcgyzNWQQ6klYRHGEn4NSmJIyDMof1jJUOW9VzPGBG+GKe/AsjWW1X4NE0wo
         1rpGrEFOrLx4wds1vLLo10NWQKYfF372cCz2vfndvhn6hHbnq5XoZzRDQNAnVZ/nk2KM
         OImSArb79N3/92Uve7vFkDXDnh8Q9CJ1cUcC/Qews9ZOIQ6ed9eD7yg1s6w0DqZ66Cqc
         9RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430609; x=1721035409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WgxvtLiOAp+6ebFIskn5swjtLMXmDPvDwEsUZDXcbE=;
        b=IupGBG+f19T+a728pp8GsRdIQoQ9lPPZ75xaSBqp50kXlwA66PcE3G4mGeixrMj5DW
         HTycDNmrxoXdgRTfoUF5RrdsnmEC1ZbJl56rruwEXV4UMHB0CxLIkHEeF9njC1xxIfk+
         EbRmzR0jhtSkEbhUrZyzZlSTt5dUqUkH/CE+HneoQdHAbpr9y5roDN9m4xSpSQaOarRl
         LmW4kP5sl/uFU3mJsOBtqfmXCrdvE2x6CHIlgz/Zyqz62427a+302YR//XIK0q0XhtBl
         rq4gBSvBt6Tu4rpm9c0DeO7nlcg3cXpkW+zJqZWLUbFz6u3X4dCHDJqIdXUvyJ7LlxtN
         mcVQ==
X-Gm-Message-State: AOJu0YwWMBUbjL13pLG3hq+pU4ulXBP7tFt2qmg0uuLx4ckhubZx6O+S
	bolGfa9jpZWnmIx58Fo98B2Ruzil/TraXDg1GNxGZnTp1t8Pp5gw
X-Google-Smtp-Source: AGHT+IHq/8tISvpYu1BKDcYEir8YnBBc58eFlAOM26cnk9oFXWTTHL5xuucRfKpOcdgqLF2vtPRWSw==
X-Received: by 2002:a05:600c:4f42:b0:424:8be4:f2c with SMTP id 5b1f17b1804b1-4264b0cc4b0mr99381995e9.2.1720430608652;
        Mon, 08 Jul 2024 02:23:28 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 0/8] clang-format: add more rules and enable on CI 
Date: Mon,  8 Jul 2024 11:23:08 +0200
Message-ID: <20240708092317.267915-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series was mostly inspired by a patch sent recently to 'include
kh_foreach* macros in ForEachMacros' [1]. I was wondering why we don't
run the formatting on CI and reduce some of the workload of reviewers.

We have a '.clang-format' file to provide rules for code formatting.
The commits 1-6 aims to add more rules to the file while deprecating old
ones.

Commit 7 enables CI action on GitHub and GitLab to also check for the
code formatting. Currently, it is allowed to fail. This way we can build
confidence and fine tune the values as needed and finally enforce the
check in a future patch. I'm not well versed with GitHub workflows, and
I mostly tried to copy existing work there. Expecting some feedback in
that section!

Commit 8 fixes an existing issue with the 'check-whitespace' job, which
is failing as success in the GitLab CI.

1: https://lore.kernel.org/git/4e7893f5-2dd9-46cf-8a64-cf780f4e1730@web.de/

Karthik Nayak (8):
  clang-format: indent preprocessor directives after hash
  clang-format: avoid spacing around bitfield colon
  clang-format: ensure files end with newlines
  clang-format: replace deprecated option with 'SpacesInParens'
  clang-format: avoid braces on simple single-statement bodies
  clang-format: formalize some of the spacing rules
  ci: run style check on GitHub and GitLab
  check-whitespace: detect if no base_commit is provided

 .clang-format                     | 41 +++++++++++++++++++++++++++----
 .github/workflows/check-style.yml | 29 ++++++++++++++++++++++
 .gitlab-ci.yml                    | 14 ++++++++++-
 ci/check-whitespace.sh            | 13 +++++++---
 ci/install-dependencies.sh        |  2 +-
 ci/run-style-check.sh             |  8 ++++++
 6 files changed, 97 insertions(+), 10 deletions(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

-- 
2.45.1

