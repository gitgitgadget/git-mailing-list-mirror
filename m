Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88C35E958
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305335; cv=none; b=WC6ce3k9HS9UaXQO4qPe1A87y5sFUHL21/fWqPTUoQsGw8lO0MvBJI/xuWYiu/s247SHTiEfAiG6NWyQyBc95XYC29+z6na3XHuwhNkcb4937X10nXqF4+i96FIbju7AmKuahdiReoUeKjO+vNR3X46yV8czdp7yuI4IoBZRZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305335; c=relaxed/simple;
	bh=HXQXKhZvBqLNWHo4oJk49zH+xa/EumlTDfJke+/lYwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCjoB56Vk4w/8LEtdgH2n21saOIYVhje5WMnD+Kj3VqzpHcQKtlbLvEykbViqWY1weSFuggyjRdo0V8BjdfzeicHBXSLWdwtrbU2du+VIs8N5h5KddAFFvSSC1z1lfDx65rST0aIbo57fFDM87yPMiggwrEZB74T72NfrtDLz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoATjJMp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoATjJMp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824acdfb73dso161279b3a.2
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 11:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772305333; x=1772910133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clX+HHNYZKc4iMjbr8oSi19m/sPVKy/vo0r33jT5ZiQ=;
        b=QoATjJMpbxuMb4eeEtZticzKtKkN1Yn34j+lwzoAjT9YeOs2BHvApSQdarcBCgANRF
         jLHkNqkfx1FmdgPcF0MLFld+btfJo/VUGmNUU9lkGpZpQjwGzskAr3pNNCSwhZdlGz/c
         E0j5mxZ0Nt5PwXhLDn33tMew0p1LJSdu0UJMxXIobrEXwI4KP9qlkjnkwjMZ6ei5PZy1
         v19MOUpFuY1DecQJvalF1NNfiO7R+lLBAX+TTWzEkxjLeXJDLwa8w68SUJhhTbQXB97F
         w+KbG9HKtPICtdWi/Y8a7/zb/pYUsVUXFwGyc790UteQw5wwaA7TQb3ZuYoO0d4QEnaS
         pEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305333; x=1772910133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=clX+HHNYZKc4iMjbr8oSi19m/sPVKy/vo0r33jT5ZiQ=;
        b=WVBic2juq49IlRuEWUmQBez3f7T5wlP5ZB3IC7rr1fvVfXSZpaL+soxtofNCeugt3x
         JRYP1b+3Mc+V3L0Aj0t/noRoCqmWkdZvUY5grb1jjKBeQbZqzak+XqFWdhYbIYHXv/9k
         epMrbu2SniZ69qLs5IxPK82RNIsh/1cVpwt7CARCnIPVdwJXOECNl4miOLlFM6pfvhOB
         SXI5pfo/cmBOcslEjnqfqHnbzQU5BPXp5mS4rqevlqZ+Zh8td7BIQuPje4v6CaC7+OcE
         FHGmU9vIPafqicZPMX4Eg4q2jzx0e2eoQVrlEGoBVKRsgJZGQel6k2Che0jZe9KKWb2v
         +8ig==
X-Gm-Message-State: AOJu0YypFmw8dmhgcLSbP9er6W2ZoWWkJXKo0iIYelPjiIowNQlT959U
	Y5IuWPXkA+k5g9CyTtVcJbPAB2EVjCJ54uhZIFF0d4yVeCQbaVr4Hxtv3it8lJnH
X-Gm-Gg: ATEYQzyHFmNbYDOwBzOUCz4xp8K9jObMRcbxWkwCPDYo8ktlEDWNWIrOgAKZToc0R/x
	+mFJxfIvep6YVn195Uc7BFUrZDU9UOYBZeRoHQjHIM+D08O22xUYEV+hPVybFHXnmWUUtqLxmzc
	qskxtz5CQW+4mkOi0qmN2AfYpn6I3pMfwuYSEhO4Hw1Da9G1AiML2fnKoGRaTr4vQIcrDxKeSle
	0dqCzNMpi3djJfBQdu8ZyEoTB6B//PgnBqIIu9SVBmw71dQrXztZKRxnaH6LB3PVZ8qjWctukeJ
	Sljjgo5Mo+g8lI3bHhUtOwcLrsANyZ3croWrwBHIaDHr6bGkL/IKf/nWcig4Y26I6Menx/kHqst
	qq9r4KBqBTa+Mh+R5cjc6IcKILYuRJKbeeSIRPUNNfGBnaWHEYkr8lpe5M9ET9A+8089O7JkoZT
	QJxGsuSY0WcxmfSU5Xg6h2rufwSRoyZf6RgQtw0NJQ/J/WHnIdPWOZmiJGV7zudfFfBHXaGTKMp
	eEFFfX3SQ1lL6Yb6LSRaEw=
X-Received: by 2002:a05:6a00:390e:b0:824:9f50:83c7 with SMTP id d2e1a72fcca58-8274d7d4efbmr4779438b3a.0.1772305332273;
        Sat, 28 Feb 2026 11:02:12 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3e4asm8556644b3a.28.2026.02.28.11.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:02:11 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 0/3] migrate encoding settings and bubble up repository
Date: Sun,  1 Mar 2026 03:01:58 +0800
Message-ID: <20260228190201.3684705-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228040727.2057192-1-a3205153416@gmail.com>
References: <20260228040727.2057192-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

As part of the ongoing libification effort and my GSoC 2026 proposal,
this series migrates commit and log encoding settings into 'struct
repo_settings' and bubbles up the 'struct repository *' dependency.

Previously, 'git_commit_encoding' and 'git_log_output_encoding' were
global, where core APIs implicitly rely on 'the_repository'. This
series resolves this in three steps:

  - Patch 1: Moves encoding configs into 'repo_settings' using lazy
    -loading, safely handling CLI overrides in 'revision.c'.

  - Patch 2: Updates 'commit_tree()' and related APIs in 'commit.c'
    to accept a repository context, passing it down the call chain.

  - Patch 3: Updates 'pretty_print_commit()' and 'pp_commit_easy()'.
    We leverage existing contextual pointers ('diffopt->repo' and 
    'revs->repo') to pass the repository downwards.

To maintain a clean boundary, leaf callers in 'builtin/' and top-level
components (e.g., 'bundle.c') fall back to 'the_repository'.

(Though series passes the full test suite and is verified with 'S
ANITIZE=address,undefined', I'm quite certain I must have inadvertently
left out some parts. Therefore, this patch series is currently more
of a self-archival exercise than a final submission.

For example, I might have left out some of the exsiting contextual
pointers in patch 2. Will check in the following days.)

Regards,

Yuchen

Tian Yuchen (3):
  environment: migrate encoding settings to repo-settings
  commit: pass 'struct repository' to commit creation APIs
  pretty: pass 'struct repository' to pretty_print_commit()

 builtin/am.c          |  6 +++---
 builtin/blame.c       |  2 +-
 builtin/checkout.c    |  4 ++--
 builtin/commit-tree.c |  2 +-
 builtin/commit.c      |  8 ++++----
 builtin/history.c     |  2 +-
 builtin/log.c         |  4 ++--
 builtin/mailinfo.c    |  2 +-
 builtin/merge.c       |  6 +++---
 builtin/rebase.c      |  2 +-
 builtin/reset.c       |  2 +-
 builtin/rev-list.c    |  4 ++--
 builtin/shortlog.c    |  4 ++--
 builtin/show-branch.c |  2 +-
 builtin/stash.c       | 12 ++++++------
 bundle.c              |  4 ++--
 commit.c              | 31 +++++++++++++++++--------------
 commit.h              |  6 ++++--
 diff.c                |  2 +-
 environment.c         | 37 +++++++++++--------------------------
 environment.h         |  7 ++-----
 log-tree.c            |  6 +++---
 notes-cache.c         |  4 ++--
 notes-cache.h         |  2 +-
 notes-utils.c         |  2 +-
 pretty.c              | 13 +++++++------
 pretty.h              |  4 ++--
 range-diff.c          | 10 +++++-----
 remote-curl.c         |  3 ++-
 replay.c              |  4 ++--
 repo-settings.c       |  7 +++++++
 repo-settings.h       |  3 +++
 revision.c            | 11 ++++++-----
 sequencer.c           | 36 ++++++++++++++++++------------------
 submodule.c           |  2 +-
 35 files changed, 128 insertions(+), 128 deletions(-)

-- 
2.43.0

