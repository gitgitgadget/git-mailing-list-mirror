Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860F1BCA1C
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441891; cv=none; b=iTuTvpkFvDEXc5WPUEdzDysVr/3irjRIvoBfjlEWz5p6rcxzcChkCUgTmHQrDnJAvRmNL5iBmT1zMpg8uV5FlxHaYCntoQwJVfcdyfgygbzIUHz66oS/Z5mhHvRlN9dfe5a8eree+KcFQghM/VRMmXL8H0SHLNpuG1OXvGdidAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441891; c=relaxed/simple;
	bh=Fovlo+kkfWf4fAGaMms4794BjKzee6vzlqJaTkY6SWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSb6n/xz91qUKNDtuSxuc7FdPB3CI0GHSnHMw4QLUoqtLFL0DPIbr7Vem5fLO0/zCr6eZxLa51/0RqeqdvhlmT4GUUIjAgbtNoMK+gO4SCXKuYA0DC3DSh0xolhKnZORoG71EQ4Z3feNGZdxcQTH3ONa2mzqMU888f0swz0ziUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF8aftm6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF8aftm6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab1c8fdc40so2538655ad.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772441889; x=1773046689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYW+6OWwt++TZT5ld6qzlphS+X/7wCbyPui6hOikZxU=;
        b=fF8aftm6x+uUTkPwx7QemrY+yoRpYemoKsDXcLae3KnErX5jPqB2rm9mdJc6avopPs
         GC+Ygf3iZItanNmkMIs1u7RJNLF71I/jAaRMeozozlnW5h2NjIYlkdlF6plQ7nrMlBwX
         oxJWtIQDF5pt3AxMhsHQj+Y71uNDIHtzPlsjUD5t2R4AnxR26C7sRmLcWP7ULuTByGpm
         Um9FgZkjvmBOeiiRhXnav18E3G/T+yfgCeJgjn2kit5m17U3PhKawsqLKx9aGtWfCcdm
         UhLi7EnO7erVetAjq1FLJxpcro2aGW0I6Ylx96Qrkwvug361NJ5/5jk3oo8QvPjVH9+d
         gGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441889; x=1773046689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYW+6OWwt++TZT5ld6qzlphS+X/7wCbyPui6hOikZxU=;
        b=ki1iPASDXqhkoLAscQsqhI5bW4m/bAQtsjZYptXCSRNQrUbIpQCl68//oTmYGYjmPQ
         3fxjDwLUCHkZuHltjiTdHpaBcs78tRMxh13W0S5EnusqRPUAlmwFloPSJ90zB0bCtHUl
         1r+ytUD3lWvrwbJjJgJhGvfh0m/CzTuYkHEMtK3c+Cq+9A2aS8leA74bi1h/aYblhw5n
         zFVOdFA8cfyUAp7ZZMHNk2kmT6ep8wkX3utEiRtWykpiiW3y919+YUgQYI8LYLpeUgsy
         bQicyNO5ZHiRcoOf0lBxJgsklC0n5Mi+kSYvEsx/sKnnCd8y+fADBCY1j//05MHw1ZWY
         cWGw==
X-Gm-Message-State: AOJu0YxHUn5kkTQN3Tc7uZjJGLCJRLyEgDs6wl6bZayDZcnHdPLjm19+
	faVvhXmkpuUzFbpsEV22kME2SgmQIZxf+lfjFpQHUYSpKCPHClYitVxfe6cJ1/Y1
X-Gm-Gg: ATEYQzw0P1jB+1kF591rzwlDtmAVSsrOb4m5XoWCjKETrKcPe2f9j8hBnL+ZXxjM249
	58htVwrzfyReDcCpVL/0fCk2NQBZfcNkqGUmsWJgoMy3F8iEeBdPq813PFd29VXwXGTwHL4NwAg
	afpetDJ//rY2tNEZ9GCSQ6BM/70885WwwbcTfjF08aVLWOqYr9NUUUX3+V985eyYL3FVhF4pLhz
	JUCEx9sI62NFoib6wG/A8V1PlsJMneoMNQxskE1kL12cDj2TpkpbI05DY6Nb6uLZJNHFgH4n+Ov
	VumlmcRppHSbWr65kHOuCtLUF3k4ngQV86d22wRLxo7+2+aTEzn7H/B97pnOGFprFwODy3UX5on
	wS8b/vRG5cnZYPmBFGm4Sm4rXTAmJhjo0DygwWx+GgMbKfyu+GCVt7o1/Hm6Asiu3Z0qN6LLTbW
	r/VuRmJ4c0iCJ1pCdCjo/scaSi6o8iniBpuIY8kGTWQn5tCsVIGHOAhWTKwD+vNNELVeYl6u55U
	RfthMEbQUHqB1B9i1p6pGQ=
X-Received: by 2002:a17:902:fc8f:b0:2ae:5745:f0ef with SMTP id d9443c01a7336-2ae5745f3e2mr6925365ad.2.1772441888948;
        Mon, 02 Mar 2026 00:58:08 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4d31138fsm33920325ad.83.2026.03.02.00.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:58:08 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	jltobler@gmail.com
Subject: [PATCH v4 0/3] move encoding configs to repo_config_values()
Date: Mon,  2 Mar 2026 16:57:34 +0800
Message-ID: <20260302085738.2510514-1-a3205153416@gmail.com>
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

This is v4 of the series aimed at reducing the global state associated with 
`git_commit_encoding` and `git_log_output_encoding`.

This v4 series is built on top of Olamide Caleb Bello's recent patch:
"[Outreachy PATCH v7 1/3] environment: stop storing `core.attributesFile` globally"
(Message-ID: <48821a3848bef25c13038be8377ad73e7c17a924.1771258573.git.belkid98@gmail.com>)

It adopts the 'struct repo_config_values' introduced in that patch
to safely encapsulate repository-specific parsed configurations.

I would like to express my gratitude to Phillip Wood for help
and guidance.

Tian Yuchen (3):
  commit: plumb 'struct repository' into commit creation APIs
  pretty: plumb 'struct repository' into pretty-print APIs
  environment: migrate encoding configs to repo_config_values()

 builtin/am.c          |  6 +++---
 builtin/blame.c       |  2 +-
 builtin/checkout.c    |  4 ++--
 builtin/commit-tree.c |  2 +-
 builtin/commit.c      |  8 ++++----
 builtin/history.c     |  2 +-
 builtin/log.c         |  4 ++--
 builtin/mailinfo.c    |  6 +++---
 builtin/merge.c       |  6 +++---
 builtin/rebase.c      |  2 +-
 builtin/reset.c       |  2 +-
 builtin/rev-list.c    |  4 ++--
 builtin/shortlog.c    |  4 ++--
 builtin/show-branch.c |  2 +-
 builtin/stash.c       | 12 ++++++------
 bundle.c              |  4 ++--
 commit.c              | 20 ++++++++++----------
 commit.h              |  4 ++--
 environment.c         | 33 ++++++++++++++++++++-------------
 environment.h         | 10 +++++-----
 log-tree.c            |  6 +++---
 notes-cache.c         |  2 +-
 notes-utils.c         |  2 +-
 pretty.c              |  8 ++++----
 pretty.h              |  4 ++--
 range-diff.c          |  2 +-
 remote-curl.c         |  2 +-
 replay.c              |  4 ++--
 repository.c          |  2 ++
 revision.c            | 12 +++++++-----
 sequencer.c           | 32 ++++++++++++++++----------------
 submodule.c           |  2 +-
 32 files changed, 113 insertions(+), 102 deletions(-)

-- 
2.43.0

