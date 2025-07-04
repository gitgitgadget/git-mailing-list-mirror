Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15571E4AE
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638445; cv=none; b=tcKwE5mtjEKgRzbzAfMoCST36at8wB//GoN+fYD1AT1MFsE9cyDgIe204bxyS/K0U2xZRpH3pFj3w9O7MNOAQrgC6E643om0jVr6Dxh12pvvNaYPKHvePWdL7biIGP8U6DosXxOHlIzmAF25fTYmvEIj7t0zHNftu7zwl0KFOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638445; c=relaxed/simple;
	bh=BMFIM083OpvoO8Ece6WCUfMJ0Tc5WuIGgv9IJli+exw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro9OPiT2Db17cWFp4UbF/scDE/u26Pg/+gWRl7SDY9McO6aBnrhz8iHxO96ZHs1ZkmQfkMG4ipHbb6Zq+Jjze90iB+/Eq4jRx6WAKHlMdpKdBmlJ1Gza9CERkePpWuaFeOmCn5HLvWWpDMIzRNww/psPpc+hzO0rDJ/jjUTy+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeBQc+bi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeBQc+bi"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3226307787so702819a12.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751638443; x=1752243243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/SZhQWXDkmgP+TphGc0FePGvdFZOZVVje/XLtRiDS4=;
        b=JeBQc+biskNCYweYf+LLupKqpVcEXp5pDEc6Qp74brwHw0yWlgyOt+y1D0nJx9q2hH
         VvM6+h5JZ4UJ6wVXAPexOzsQI5Nu7kNa5Jre5GzChO3tJ3/Fl+KYIlGkXmF2fl2G/mv3
         gvEAaL4UZC/O/kwRUG47L7XxZoR6Q7nZkY/TFKluXehbBaoTocYXF+RgOP63X9YPkGSm
         SPymUuk+qi1OISeOX8/Z/vk5QL6KnHEV6TJWeWU7TVcykOeFT5/35eF5tT+2+OfLL9h0
         wSTLLL7CXmTCkIpAspIoWK/7s50UzLQgY348EJHK5JQfGXobQ+gEhMsP/+TK9HuS4Tw8
         nPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638443; x=1752243243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/SZhQWXDkmgP+TphGc0FePGvdFZOZVVje/XLtRiDS4=;
        b=VOuxDFV26+8gnI8QQ+24nLSWIcL1fwpCu0AzGk7UD/kAHqpdPXA83C4Y+MJJgsumcc
         oFoHUArcM7FZpl1y/HOgu01JJj7KqsapMKTwUtoYGEBgGXohZeacTTbsro4mHO/zoHdX
         ezMODiWb0UZzTYssbbgn7KEp5orwlI14D3cw/D4n3td0Lk5MIbvKzV1DZ3z0n6XkUhMn
         xlh5YjDVzZM6tVrwQWIpTP7GYutqfhEvXEy5mxr5zAKsmziGGk2C8Dk3f6aOmDRv982b
         vE6rkkHM5SRdX9IOpKACGKVxMafixaHO97jWYPzRK/cKxHMyi4y0oFSGOaoq3gTBAb8R
         MaEA==
X-Forwarded-Encrypted: i=1; AJvYcCVgsih5EXIpgo2ykYdTp/DejWwPYX6MW382SB+nCNqcFlj3mslmDd9C3UUwymwp/nkGWTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Up3cTUyYB8fknvg4R0Ih0rWKfS8EfGXd6tpaHN78lVfTtND+
	k6SA5I2IDfOsePn3zfrgV5LDQp2zNnuHJqFadJqiUMlY71tWYL88mR6y
X-Gm-Gg: ASbGncstNswVXld77DgI+Zjf8+2ndBTmNKcv64PpjRB/fO510Eom9hLhjSJ/3V6nj1m
	PlI79nF1rJ5bjeS/bkSCuOCs2DJDqxNmTgFnb9GHHYAjxin2XB5dDyWj/BJ/3OAxDkjWsZMYpOU
	DySqZFIr+PTP0sgAbi2YR7swZrHSJBKHI4eysSZicAVrYXm+jvz8Nk6Ro3bOgV08afnrnXSmldO
	k6UoNJdJykQJz6wxdjSCu0AAeIvAz9kuEQWMwlUyUsyRTN+1WeA2oM6rldh+n0b7NFB7ttRb/OS
	mL/ouWtGwrW4i13AIa0EQ7CrsZ7GujPPJa7wb74cKuud0CAhOLmzGMxkr666m1StUaZEyjSoLX/
	H/hxx
X-Google-Smtp-Source: AGHT+IEmXAtxqNC8f0l1AFt7PKiMQsQpF0vt4xnofqKTDc+PyBKzm0OaB4th7tEoIWWkbbhczFPMKw==
X-Received: by 2002:a17:90b:2ed0:b0:311:c1ec:7d0a with SMTP id 98e67ed59e1d1-31aaddba4a9mr3396718a91.25.1751638442959;
        Fri, 04 Jul 2025 07:14:02 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:b11f:29cd:a954:9c31:7c0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaaf2cd54sm2115780a91.23.2025.07.04.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 07:14:02 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shejialuo@gmail.com,
	shyamthakkar001@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com
Subject: [GSOC PATCH v3 0/2] builtin/prune: remove dependency on global variables and 'the_repository'
Date: Fri,  4 Jul 2025 19:42:33 +0530
Message-ID: <cover.1751630981.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751296633.git.ayu.chandekar@gmail.com>
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
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
the definition. Also, add a test to check if 'git prune -h' can be run when repository is 'NULL'.


Ayush Chandekar (2):
  repository: move 'repository_format_precious_objects' to repo scope
  builtin/prune: stop depending on 'the_repository'

 builtin/gc.c            |  2 +-
 builtin/prune.c         | 27 ++++++++++++---------------
 builtin/repack.c        |  2 +-
 environment.c           |  1 -
 environment.h           |  2 --
 repository.c            |  1 +
 repository.h            |  1 +
 setup.c                 |  5 ++++-
 t/t1517-outside-repo.sh |  7 +++++++
 9 files changed, 27 insertions(+), 21 deletions(-)

-- 

Summary of range-diff:
* Format the commit message of 1/2 correctly.
* Move the call to `repo_init_revisions()` after `parse_options()` in 2/2. 
* Add a test to check if 'git prune -h' can be run outside repository in 2/2.

Range-diff with v2:
1:  a58577a147 ! 1:  a828ade541 repository: move 'repository_format_precious_objects' to repo scope
    @@ Commit message
         repository: move 'repository_format_precious_objects' to repo scope
     
         The 'extensions.preciousObjects' setting when set true, prevents
    -    operations that might drop objects from the object storage.
    -    This setting is populated in the global variable
    +    operations that might drop objects from the object storage. This setting
    +    is populated in the global variable
         'repository_format_precious_objects'.
    -    Move this global variable to repo scope by adding it to struct
    -    `repository` and also refactor all the occurences accordingly.
    +
    +    Move this global variable to repo scope by adding it to 'struct
    +    repository and also refactor all the occurences accordingly.
     
         This change is part of an ongoing effort to eliminate global variables,
         improve modularity and help libify the codebase.
2:  c5eaebc2cc ! 2:  22fbbc8cf1 builtin/prune: stop depending on 'the_repository'
    @@ Commit message
         Refactor builtin/prune.c to remove the dependency on the global
         'the_repository'. Replace all the occurrences of 'the_repository' with
         repo and thus remove the definition '#define
    -    USE_THE_REPOSITORY_VARIABLE'
    +    USE_THE_REPOSITORY_VARIABLE'. Also, add a test to make sure that 'git
    +    prune -h' can be called when the repository is `NULL`.
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
    @@ builtin/prune.c: int cmd_prune(int argc,
      	save_commit_buffer = 0;
      	disable_replace_refs();
     -	repo_init_revisions(the_repository, &revs, prefix);
    -+	repo_init_revisions(repo, &revs, prefix);
      
      	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
      
     -	if (the_repository->repository_format_precious_objects)
    ++	repo_init_revisions(repo, &revs, prefix);
     +	if (repo->repository_format_precious_objects)
      		die(_("cannot prune in a precious-objects repo"));
      
    @@ builtin/prune.c: int cmd_prune(int argc,
      		perform_reachability_traversal(&revs);
      		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
      	}
    +
    + ## t/t1517-outside-repo.sh ##
    +@@ t/t1517-outside-repo.sh: test_expect_success 'update-server-info does not crash with -h' '
    + 	test_grep "[Uu]sage: git update-server-info " usage
    + '
    + 
    ++test_expect_success 'prune does not crash with -h' '
    ++	test_expect_code 129 git prune -h >usage &&
    ++	test_grep "[Uu]sage: git prune " usage &&
    ++	test_expect_code 129 nongit git prune -h >usage &&
    ++	test_grep "[Uu]sage: git prune " usage
    ++'
    ++
    + test_done

2.49.0

