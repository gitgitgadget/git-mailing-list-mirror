Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618A368260
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384184; cv=none; b=sP1BB5E5+1MW3jMkWxetfONzNNwHSFipVXO5OG9zTsm/okcxJ+etpC9i0nEqgGg3AKfhJmBQWD46UycKwK23EtJ0jpl/h10hFJP1QUoZkDkr1Zn2OIoTkbFumJ7hGk2Mmm9U+KgBfh0hSeP1xup2mu9z0mSNb4qGixAO6LWmKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384184; c=relaxed/simple;
	bh=Nk/LaxX2xewqHpX37WHNzb6QYPAuqPM3gtBJeBMUUFI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TrcHcOpW6sFL0eycmveAqNstG4IzBKVcmWIyBYMUTZGfFl7lS0CrRgAi4s6xVwCF2Ho10fV5iK/vXOUx0MC9dS5IuXcFJtSTX/a1dHonVF7s2CtS2dW2hLhN5TXfQLT7OFyw7/huOGFAiWII6XYgy9FyAQyIS2cwPiterErvPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YooLXgvh; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YooLXgvh"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12460a7caa2so717269c88.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384182; x=1770988982; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa2TSeCB4cMsfKGL1BvJtgRV4Z4CyBv67XXlxfZkyrI=;
        b=YooLXgvh/7uf5Njujds9qTLIaHMnJvGyDL7e0ElEwRfrZQAmy9pznNTfrxRv5IFKig
         /sTW4TNogfP3fON0VCRb35nBMULfPNEMH5hMfuudw9Yp0jUnhtufJxVRyXYrw12pXZ8t
         /8lA5Lj8hwvKkyBdlc+9nknqFp/3EjopxfYCArZfnQqVRWAjjagkVI0ilZ6P4+RlH2Da
         rQswtSyAXDGlaWfc0SkbBdvIkNd105KiVuovKU3T5Zti15jMCQSMSbgyAaMk1l/3ZJox
         LdYEu9FdogYGp9SVomwIq7MPYFKC9BxdRHbxn5gXikq+48xy+8GkfGESIfJYMuJZwv3C
         VqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384182; x=1770988982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xa2TSeCB4cMsfKGL1BvJtgRV4Z4CyBv67XXlxfZkyrI=;
        b=AfriFb//9cv9X0alpX5ExrHHpNwZyJgDQLl/cXAF1chAfUaz9STJkQjNvJIsgFwHhS
         91YW5PLl2ha/xOxZG2g7bHJ4orMD3MxOfnjeaIeNOS/HkfE9vlEyYk29ReelpAgumAsz
         LuTkwm3P83vPRDyOYiYPYypvC5BEKODuG4XXXvuiOwCHFjKWatZIMaKXKtk1pm9qAkU5
         HDLrwsHnWRoCTEof2p9RXoRCUj1kgUZVdpFOQ85zln9Jve4u2GkPtY0O+GNMgyymubJ+
         GiAn5mO96LMSpHye0nTH0kYyFZFt/gq+PAdgW3y7ck0L4nAgBdctszc9TDvXCEGLrSyT
         umMA==
X-Gm-Message-State: AOJu0Ywh0Kp8l7cRRvSD2R017j01OkzrnpzVaB4p2ql2fNV7EAbocwRX
	B6gtGo/QthE57ChquK1q7WFhQW/NsFTWXl8e9rLA+/ZdqYt9HQLnA2h6h8xHAQ==
X-Gm-Gg: AZuq6aKcjwvQMT2UPl/381PN7pHszXTDxNFapXe8zv+5bjoO1HLrUoPV8RchTxHrRI+
	X2ClYwe8WPWqBAHz21s5ipoT6XdiIgrk9F2Poid6IG9w9VD5CELbDQhQdUJFvH2Mz9Iqkbo81FT
	eaosn0jfxSzIIg+kwR2nCThYG0YDT0j1n/RgPDBE6SVq6IPD/71hII5SLLmg/6Bl9HhtrHKGoRD
	fQd6tYP05BAwew9iKgnR7Mc1+zPv7Acv2GdPd2uZPjelDTsWdRlzbaQq2SDmmoBSNEH876naF2U
	Qe/GLZ4+YXm4ovFeg5wQrouFTV18kGnqqscu05KZy5hBbOSwy0NxsIUCjDcxYbsX1DKtJ/eDj/L
	VWNJFRYoH8TDxX0PVtP/PHlDJ/tcrq990/VjU3EfsOy4b9CjtmLfGH+55k5iURbpwBy1N6W4ZD4
	j2XnpCbGnpVhwG
X-Received: by 2002:a05:7022:10e:b0:119:e569:f626 with SMTP id a92af1059eb24-12703fd06a5mr1201590c88.31.1770384182281;
        Fri, 06 Feb 2026 05:23:02 -0800 (PST)
Received: from [127.0.0.1] ([57.151.137.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d94cesm1714225c88.3.2026.02.06.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:23:01 -0800 (PST)
Message-Id: <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
From: "Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 13:22:55 +0000
Subject: [PATCH v4 0/5] git-add: Skip submodules with ignore=all unless --force and explicit path
 used
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Claus Schneider <claus.schneider@eficode.com>

The ignore=all configuration for submodules is currently honored by status
and diff, but not by add. This inconsistency causes friction when working
with submodules:

 * Developers unintentionally stage submodule updates, leading to conflicts
   and unnecessary changes.
 * Tracking branches in submodule configs causes friction as updates to the
   submodule SHA1 are added without intent.

This patch aligns git add with the behavior of status and diff:

 * Submodules marked ignore=all are skipped by default.
 * Attempting to add such a submodule explicitly now requires --force.

A submodule can frictionless track a branch in the configuration or manually
switched to and use update --update --remote without unintentionally add the
changes to the super-project.

Tests that previously added submodules without --force have been updated
accordingly. A new test is added to test the behavior of git add with and
without --force.

Claus Schneider(Eficode) (5):
  read-cache: update add_files_to_cache take param ignored_too
  read-cache: submodule add need --force given ignore=all configuration
  tests: t2206-add-submodule-ignored: ignore=all and add --force tests
  tests: fix existing tests when add an ignore=all submodule
  Documentation: update add --force option + ignore=all config

 Documentation/config/submodule.adoc |  13 +--
 Documentation/git-add.adoc          |   5 +-
 Documentation/gitmodules.adoc       |   5 +-
 builtin/add.c                       |   2 +-
 builtin/checkout.c                  |   2 +-
 builtin/commit.c                    |   2 +-
 read-cache-ll.h                     |   2 +-
 read-cache.c                        |  80 ++++++++++++++++-
 t/lib-submodule-update.sh           |   6 +-
 t/meson.build                       |   1 +
 t/t2206-add-submodule-ignored.sh    | 134 ++++++++++++++++++++++++++++
 t/t7508-status.sh                   |   2 +-
 12 files changed, 235 insertions(+), 19 deletions(-)
 create mode 100755 t/t2206-add-submodule-ignored.sh


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1987%2FPraqma%2Frespect-submodule-ignore-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/Praqma/respect-submodule-ignore-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1987

Range-diff vs v3:

 1:  d2b66286c2 = 1:  69e0065b1b read-cache: update add_files_to_cache take param ignored_too
 2:  de72bf0a91 ! 2:  504edcb0f5 read-cache: submodule add need --force given ignore=all configuration
     @@ Commit message
          unless overridden by --force and the submodule path is explicitly specified.
      
          A message is printed (like ignored files) guiding the user to use the
     -    --force flag if the user has explicitely want to update the submodule
     -    reference.
     +    --force flag if the user explicitly wants to update the submodule reference.
      
     -    The reason for the change is support submodule branch tracking or
     -    similar and git status states nothing and git add should not add either
     -    as a default behaviour. The workflow is more logic and similar to regular
     -    ignored files even the submodule is already tracked.
     +    The reason for the change is to support branch tracking in submodules
     +    with configuration `submdule.<name>.branch` or similar workflows where the
     +    user is not interested in tracking each update of the sha1 in the submdule.
     +    You can additionally set `submodule.<name>.ignore=all` and the `git status`
     +    will state nothing and, with this patch, the `git add` does not either - as
     +    the default behaviour. This patch changes the workflow to a more logical
     +    behaviour and similar to workflow for ignored files.
      
     -    The change opens up a lot of possibilities for submodules to be used
     -    more freely and simular to the repo tool. A submodule can be added for many
     -    more reason and loosely coupled dependencies to the super repo which often
     -    gives the friction of handle the explicit commits and updates without
     -    the need for tracking the submodule sha1 by sha1.
     +    The patch gives more scenarios for submodules to be used effectively with
     +    less friction similar to the "repo" tool. A submodule can be added for many
     +    different reasons than a hard dependency. It can be added as loosely
     +    coupled dependencies whereas the user wants the latest based on the
     +    configuration `submoule.<name>.branch`, but are not interested to track
     +    each commit in the `super-repo`. Currently it gives friction of handling
     +    conflicts between branches even the sha1's are fast-forward and the user
     +    just wants the latest in any way. The user can still add a sha1 explicitly
     +    to track updates.
      
          Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
 3:  d7b97e12d3 = 3:  d5ea8eb6e0 tests: t2206-add-submodule-ignored: ignore=all and add --force tests
 4:  6e44ab6804 = 4:  df5c85d9f2 tests: fix existing tests when add an ignore=all submodule
 5:  37fe7956e0 ! 5:  8bfaa14d44 Documentation: update add --force option + ignore=all config
     @@ Documentation/config/submodule.adoc: submodule.<name>.fetchRecurseSubmodules::
      -	commit when it has been staged), "dirty" will ignore all changes
      -	to the submodule's work tree and
      +	a submodule as modified.
     -+	Set to "all" will never consider the submodule modified. It can
     ++	When set to "all" will never consider the submodule modified. It can
      +	nevertheless be staged using the option --force and it will then show up
      +	in the output of status.
     -+	Set to "dirty" will ignore all changes to the submodule's work tree and
     ++	When set to "dirty" will ignore all changes to the submodule's work tree and
       	takes only differences between the HEAD of the submodule and the commit
       	recorded in the superproject into account. "untracked" will additionally
       	let submodules with modified tracked files in their work tree show up.
      -	Using "none" (the default when this option is not set) also shows
      -	submodules that have untracked files in their work tree as changed.
     -+	Set to "none"(default) It is also shows submodules that have untracked
     -+	files in their work tree as changed.
     ++	When set to "none"(default) It also show submodules as changed if they have
     ++	untracked files in their work tree.
       	This setting overrides any setting made in .gitmodules for this submodule,
       	both settings can be overridden on the command line by using the
       	"--ignore-submodules" option. The 'git submodule' commands are not

-- 
gitgitgadget
