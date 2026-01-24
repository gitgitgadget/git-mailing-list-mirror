Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16534503B
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769257291; cv=none; b=me+iWZ1cGKQrG4XrrRr08QtSSzAUkU4vPOghYODwJWnmKGMzmIJYGOtAnAEjaYVXLUju+qiaHWtEzevB8gg9rkIe848YTbM+1VV1avG1zDo9dDeE1Xv6mRWzTh7zulT1+9Ppgrr6qOn5hVOWh7zaPlHUwlLqB6MiZd/zOiS7l1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769257291; c=relaxed/simple;
	bh=1QfvzpU4mlu710MCG8KJWllhFeAO84Q2tmcu5AsAMac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jx4uH+KmuzbZ6AiT+fq5xVmEHFO6JwNDdoUGntnlyDf5OOhv8ahcoxvxcB4NQX9FkvtYmDK9FdzZnN8shDvpWQdBkxmWxuJFEJWndLkBIL8mhOdCFgztcSN/5M4vFOB7fbaBrtH2AohSBzTLz/NNaa9OTHpJjkDBmvIpMpv1wK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTyEH9hs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTyEH9hs"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2060498f8f.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 04:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769257288; x=1769862088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUYNp+Rizh5v4F6epZ7Q479383bo66uo3Sz3cCZX2dU=;
        b=kTyEH9hsoYT6No7I3zBbwSx5zhQTj8z1jf14VDx/48M0odlL6MIp2TZKHLHF0VxT1r
         hHENA82S9GR7LvfkYxKVGPxUdgPnqLuZNv2G4oOXlicLwwC4GJ1cjw1Wa407LTEP+VTq
         LefClHsmmnyJ0+MvjGCCPsvxPvvMJwL9Q9j+xQXscfcGjI7mIWhjCDwgmDLaZZVIOtpn
         nRFSmqFROgyKpu2qgLoyuDPu2bdLMrAHyl98G78+/1uBOtmG3kYFR60R0FiFbEPeeS8y
         8EVBf+7ULouaWuS97wFQ8rkS8LVYYj0fwKAfhd4jRU7v7IXJuh65LaGTZJfgLcESUAQF
         1t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769257288; x=1769862088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUYNp+Rizh5v4F6epZ7Q479383bo66uo3Sz3cCZX2dU=;
        b=cEcuPfGJc1FL7Lc37Pjy/fhOOPGc4F1r9dGqsXCKt5+HM9O7L2XS0VHoHztRmIJfGd
         W9HcTlpsJUc/LVOcKKQ8vU1GLHTn1zZ1ryi2eYLnW5xesjai7FXAZmgNjJ83V+j5JfrG
         gizXmtTgUhWDUWSUlte3TQigRHl8pjwRgo+Xx958X8GuTyFaH+oqXagDmggIj/2FT922
         fw8b989wEYM7nQfXflTm2+zl8bFW02e3zyY54t89MPU8PHMrPbp3lcYOLca7kRRGKN/I
         jliaRQqeAuYDRllqQ304lgLbOSBWwbBtTPoc4uqRoicM537EDXG7r+ce2Q1FlBjJbj6w
         T4+w==
X-Gm-Message-State: AOJu0Yzm9lJj7et7B3sDFVkVcMpUsfFmNUUZY1ZvsqiNawDO4QC/ssHM
	k0/R/jgWOMgeeVxYw+iXis9WkqifaMH3JBiL4dOsOFNR988FB9Ni8Dqf
X-Gm-Gg: AZuq6aKH2l0qN1E/MnCs0JQ2hTjhXIlCciDq5yfa584kOLlzQHr7Itug/lIP29106KG
	tor/ZisZZYDfK4O+jyp4tDEDcg2BS0SBTi9ldaTrL6+BbHyxDLCS8HucVsrMEnncBsdFBkm9c3I
	MvzDDe3wJ+nPGXR1ZaIcXcl4UxJT9L2kF36mzKUFJGogyMM9dfJSM8sakVVfDuRxniVLs8A27VF
	jhM+0pbB9qMIM5O71B8VjRZejv1oiwpQ1UatvKAFk8+9JJWX/fU8J4fWduvSdw8rfP+7ZHKrNGq
	gKAIuvpuCbLeyO831sw6U1r7sHdosj4QfIqhC8cSI815QyHPtDCLdU0d+wbUkBRMGAf/76Coaio
	/I80rVLZ2VotdXn2dmDHJ/0xRRywKngzdJbSUEfU4QuRVGG7Gk6w9ZyDdNo4qI5p/B1MT3HVlkA
	JYUg==
X-Received: by 2002:a05:6000:2505:b0:435:b068:d3c4 with SMTP id ffacd0b85a97d-435b16034ecmr11052140f8f.33.1769257288135;
        Sat, 24 Jan 2026 04:21:28 -0800 (PST)
Received: from ubuntu ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e716b6sm14153880f8f.27.2026.01.24.04.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 04:21:27 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v5 0/3] store repo specific config values in new `struct repo_config_values`
Date: Sat, 24 Jan 2026 13:21:10 +0100
Message-Id: <cover.1769256839.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769252118.git.belkid98@gmail.com>
References: <cover.1769252118.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Git Community,
Over the course of my ongoing internship, which focused on moving repo specific
global variables in environment.h into local scope, I have attempted to move some
variables into the struct repo-settings.
However there has been some design concerns as regards the use of
`prepare_repo_settings()` with respect to when and where to call the
function, and also the change in behaviours when the variable is lazily
loaded as discussed in [1] and [2].

After different deliberations, Phillip Wood proposed creating a new config
struct [3], adding it to the repository struct and passing the repo struct to
`git_default_config()` to store parsed repo specific config values per repo.
This ensures the current behaviours will be retained.

I have experimented with this approach for some values and I would
appreciate feedbacks about this approach before we can move forward
and use it for more variables related to `git_default_config()`.

For now, the parsed value is stored in `the_repository` in
`git_default_*_config()` and further efforts to pass the repository
parameter to `git_default_config()` as the callback parameter will
be looked into later on.
The link to the CI tests can be see in [4]

1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/
4. https://gitlab.com/gitlab-community/gitlab-org/git/-/pipelines/2266020513

Changes in v5:
==============
- Corrected mistake in commit message of patch 3 which spelt branch
  wrongly in `branch.autoSetupmerge`


Olamide Caleb Bello (3):
  environment: stop storing `core.attributesFile` globally
  environment: stop using core.sparseCheckout globally
  environment: move "branch.autoSetupMerge" into `struct
    repo_config_values`

 attr.c                      |  7 ++++---
 branch.h                    |  2 --
 builtin/backfill.c          |  2 +-
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/clone.c             |  2 +-
 builtin/grep.c              |  2 +-
 builtin/mv.c                |  2 +-
 builtin/push.c              |  2 +-
 builtin/sparse-checkout.c   | 23 ++++++++++++-----------
 builtin/submodule--helper.c |  2 +-
 builtin/worktree.c          |  2 +-
 dir.c                       |  2 +-
 environment.c               | 28 ++++++++++++++++++----------
 environment.h               | 14 ++++++++++++--
 repository.c                |  1 +
 repository.h                |  4 ++++
 sparse-index.c              |  6 ++++--
 unpack-trees.c              |  2 +-
 wt-status.c                 |  3 ++-
 20 files changed, 68 insertions(+), 42 deletions(-)

Range diff versus v4:
====================
1:  d28850bcdb = 1:  d28850bcdb environment: stop storing `core.attributesFile` globally
2:  5e56e1cc41 = 2:  5e56e1cc41 environment: stop using core.sparseCheckout globally
3:  aed3183321 ! 3:  e7f37bac87 environment: move "branch.autoSetupMerge" into `struct repo_config_values`
    @@ Metadata
      ## Commit message ##
         environment: move "branch.autoSetupMerge" into `struct repo_config_values`

    -    The config value `brach.autoSetupMerge` is parsed in
    +    The config value `branch.autoSetupMerge` is parsed in
         `git_default_branch_config()` and stored in the global variable
         `git_branch_track`. This global variable can be overwritten
         by another repository when multiple Git repos run in the the same process.

-- 
2.34.1

