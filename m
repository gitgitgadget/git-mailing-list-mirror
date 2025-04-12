Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D12B9BF
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460456; cv=none; b=FAR0xo+ktXX0Rcq2kLLpqItbYLAnMCSOYtZW5j4ZFWHSxKl76xMAMIPrnx1grHLGHXFjv+Z/XiIfadJBPRMGClENlAl6iVw+6PmF2IOXqzUb2FQVIlh8hbWpVjzejH8mlNPEQ2yXp2+iXQWiAyh2eNnVaBrht2UjAOmefo/PQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460456; c=relaxed/simple;
	bh=D5JHrmM1Yvg64z0DLFvALoNUXR0SWBZ+C0dAtyH+m70=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ADl2lI3NYKaDNi3Y4Ygb2ysMUOZpslx/TU/ZbaY8mU+qbCNng4XLmz8hU4i52zm8+Fwq1UL2c1JSPvGwwMJYkvy7yBw2cCHYCmluwAD5DBMj7ugDqoA2Z6YRS0ndfVKMra+bmejTTdQdzr5YnoOEl9Nz5kfbS7RBFR4ccU6ueng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kojTmO7t; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kojTmO7t"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39bf44be22fso1723188f8f.0
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460453; x=1745065253; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NN8HjxgugE0KtoarSywjS6fneFvd5PJIv74Mud/kp8=;
        b=kojTmO7tBLx/kiiyRLgPEoowRszZ1qJMXEBHYNz8UXMF8z0EtgcGnfmwo1KIsmePor
         bWCncCKTM2BEVHx/om8/VsaR7QXkobLnnj6Rjw0fkV7oyl67ro4IyrLefGPMtrgFd53X
         UeCHvThht9Re4/cmeYA26Nh+cd/WoGVKUg7NeR+0CRQsEcEJxbZMqEwWjqOh8sMy154X
         KcIW0xukT5ZJmKcrpebp+0h+0LCm6cGBCqx/zdZTIID8A5gr3/LYm+SyAqs4JD6K44Po
         FG1Q8mRNEM0/2c906iMLE93E/iNoz/ydyUdy/mLbuG/HG+efoECT7F+qyKrQHYAXe+7v
         QXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460453; x=1745065253;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NN8HjxgugE0KtoarSywjS6fneFvd5PJIv74Mud/kp8=;
        b=Frkvos6UiQ04j6TrOYB7G8G2MEEaoYADhsXe/54pJsttPsTfjJ3b+tV2QK3dj88dcN
         NhNZhivT0tOwPmn+i8n9Puh1FzpTfoFX0ytnTguoTnSBfqCkjv3LBITVRYVI1mceM8eA
         lrwDP+JxqLENpEgVh37HsGnr9sSwQb4MJO5iICDrLz3slhmTDQr9hS9rp3Zu/7g8o5+D
         xWVkqQJ5QCF34p0K5E4qYbNT0LZX9cdScSjevMmDN/3MIhOgYWxvJg6VVeKOLJrPegNw
         m9JnxXC0uOuOeUYY6hjhKDKJ+5Yatj+oxLaZDgYGgFTTNNdI/bJNQEhXO0iJr/3MFTK1
         hecA==
X-Gm-Message-State: AOJu0YxabF7xHKKd0uEFAGE0PyMaQwbUj/NWQxW0/3E1ijoThhCMyZxp
	+hSzzTKmZeqTcK5fOvo/AqPOP74FvPx3qtSocsymRKY/Xjw08jW5BLLHfQ==
X-Gm-Gg: ASbGncu9gYAROFnwnVnmL1tuhsrStbp3/8e6Y1Ji74u+OjCCunIQr0/Pr6E13wq5P8P
	0782fxd5SG8Ib+qhDSqn0NVqGMKYuGXIkv85dvnvEwmtWIHBxRhS6Oki6gaYle/FuAcmY2iLoUP
	xDOO1W+5G0hyhI7z+X4cClt/nIPyIMuc3heMstxwham67O8bXjqlCFLsURqB60nzfa57oxBxc71
	SR9KfsmDe83+SG6h35fV2TRLBn0duPQWggov52Rvy/l9NtYHC+BnAaF222l51sUmx3T7qewfrIf
	QOLuAboMK/Q2x8RdY0tYZBIiizi8AFj/5+uOy7sLwA==
X-Google-Smtp-Source: AGHT+IEm6memSit57T5HvQdEXu4HtgszvtqlZHvEp/ww262yqPgXxsAiwZ8T58iRVbB5NpqZPul5oA==
X-Received: by 2002:a05:6000:2207:b0:391:4389:f36a with SMTP id ffacd0b85a97d-39eaaec7d22mr5070256f8f.48.1744460452452;
        Sat, 12 Apr 2025 05:20:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445772sm4943195f8f.91.2025.04.12.05.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:20:51 -0700 (PDT)
Message-Id: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 12:20:43 +0000
Subject: [PATCH v2 0/7] doc: convert git-reset, git-rm and git-mv to new documentation format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

doc: convert git-reset, git-rm and git-mv to new documentation format

change since V1:

 * fix remarks from reviewers
 * stack the commit fixing the handling of three-dot notation

Jean-Noël Avila (7):
  doc: convert git-reset to new documentation format
  doc: fix synopsis analysis logic
  doc: convert git-rm to new documentation format
  doc: move synopsis git-mv commands in the synopsis section
  doc: convert git-mv to new documentation format
  doc: fix asciidoctor synopsis processing of triple-dots
  doc: add markup for characters in Guidelines

 Documentation/CodingGuidelines             |  3 +
 Documentation/asciidoc.conf.in             |  8 +-
 Documentation/asciidoctor-extensions.rb.in | 12 +--
 Documentation/git-mv.adoc                  | 33 ++++----
 Documentation/git-reset.adoc               | 98 +++++++++++-----------
 Documentation/git-rm.adoc                  | 56 ++++++-------
 builtin/mv.c                               |  3 +-
 7 files changed, 109 insertions(+), 104 deletions(-)


base-commit: 485f5f863615e670fd97ae40af744e14072cfe18
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1896%2Fjnavila%2Fdoc_git_reset-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1896/jnavila/doc_git_reset-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1896

Range-diff vs v1:

 1:  1676b5ac628 ! 1:  5a6c7def260 doc: convert git-reset to new documentation format
     @@ Documentation/git-reset.adoc: and specifying a commit with `--source`, you
      +`--soft`::
       	Does not touch the index file or the working tree at all (but
      -	resets the head to `<commit>`, just like all modes do). This leaves
     --	all your changed files "Changes to be committed", as `git status`
      +	resets the head to _<commit>_, just like all modes do). This leaves
     -+	all your changed files "Changes to be committed", as `git status
     + 	all your changed files "Changes to be committed", as `git status`
       	would put it.
       
      ---mixed::
 2:  6206e65ac4d = 2:  440eac1f974 doc: fix synopsis analysis logic
 3:  41a01969d93 = 3:  6814e98f71d doc: convert git-rm to new documentation format
 4:  9f7cd02cc1e = 4:  2a129734e3d doc: move synopsis git-mv commands in the synopsis section
 5:  4887567c57c ! 5:  1868dfc3282 doc: convert git-mv to new documentation format
     @@ Documentation/git-mv.adoc: git-mv - Move or rename a file, a directory, or a sym
      +
      +[synopsis]
      +git mv [-v] [-f] [-n] [-k] <source> <destination>
     -+git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>
     ++git mv [-v] [-f] [-n] [-k] <source>... <destination-directory>
       
       DESCRIPTION
       -----------
     @@ Documentation/git-mv.adoc: SUBMODULES
       
       BUGS
       ----
     +
     + ## builtin/mv.c ##
     +@@
     + 
     + static const char * const builtin_mv_usage[] = {
     + 	N_("git mv [-v] [-f] [-n] [-k] <source> <destination>"),
     +-	N_("git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>"),
     ++	N_("git mv [-v] [-f] [-n] [-k] <source>... <destination-directory>"),
     + 	NULL
     + };
     + 
 -:  ----------- > 6:  2ddce76f14d doc: fix asciidoctor synopsis processing of triple-dots
 -:  ----------- > 7:  2690f84602b doc: add markup for characters in Guidelines

-- 
gitgitgadget
