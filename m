Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F41A9F85
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649740; cv=none; b=kCaKT2vZmaJBXvj46j2GKTJ3AS7LdJdUkoMvqR2JT+ipY5ijRRXDQRP5Y90NyatPy16CME+A2a5wgD1pi2NMS/MXlL6qYYoIajgjgbvFd0zwaJBE+M75thoEbTNL5SPZInZymB0cMzQE63YSFGqpp2C5X2GVL6ZbCcFqVPHVSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649740; c=relaxed/simple;
	bh=4iusRaqvrnW8ceM6kGozMhjqQHriocNijuyK7oeqDQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwqdrkyHtmwYXrqRblzedTxMtI1czqhA6aW0yTZFqRauro0ne6NN1V+GjxJRSp0IDtqaTVQA/+ANUANpf+oI8vLwdTLWLTgGqDL+e+n22HKe+dlHO7hFrFUNH0SBilQxKOwc+2QcCcsgiWyo2KC+KqvNHYcG3naZDCAo7+RfSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRQw3NnF; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRQw3NnF"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6466d8fd383so387338d50.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649737; x=1768254537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YAwGcCSXKyCxKkeGElq5zEnKQnZy5F5bXFkYyqQYt8=;
        b=HRQw3NnFAnAPCPOs5iGEvCoITkEiNFm9cBiPj0FG5z5gZZwRViPElp9RkWVNXxMsvv
         cEomZvRISLBjgW/tfgCT7cp7s/I/6SwqAXymrLcObZr7d2fCS3nDMwveyBIqxRtouYEc
         7J6kftLEtWD4yCuJLEiQeVrzvfFJSekWOSMJmtSFbhY3mvaw7+QNy4lx9mlgHQJUsD2d
         R0U4xEf11YPx+A0iOys2cdImP1dMr/+121MGs8/qISGcDHlRp6AtxninVG7PUYrlqurm
         vm95DRlHNqeuB++Ncr2vKRVs6F1HdYCUhQzTVdohKc7p058QosWWtx6mHCsyPCrGjFhK
         85bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649737; x=1768254537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YAwGcCSXKyCxKkeGElq5zEnKQnZy5F5bXFkYyqQYt8=;
        b=cg1j3bJcrK4dDzG6EsPizWs3qma2KJ+kdKOYBBMGT9CvhityJjnXkBbSasocfK1O+J
         q4mElmUh4tIPOBy+Y7jJtTNEeUrodmGUOSnp25RL4scelaW8X62U1VMBAxdcwh5rOjKK
         MW1LdCSJr6kcRPv+Nz74fJebxDomYHLFA+B9CUIoZUqyg/tjC5+uzlnNvK42Anxwm+Rd
         sxKFxrmPvgTQdOguT/8xak/WPAdGA37xZU7THbNkL8ZS/k5AK+/BfqSg4D4WyoGEHjiH
         ADd06DVkcREpeGNcFXShh1rgh8n3283nAfArNIUAwxlLNFSPqdM3osFBGpZpyQ2JfnSf
         uCVw==
X-Gm-Message-State: AOJu0YwfMuDDNKBRhz8AOcPsPTQTnG3FjvYurMvbN3b6oWm/PmzP28Zb
	1D7P9yKD6sbdSJAIdLIoMjG1YhnKFzlxIjGOC4tbydV7equ9MiaX/iqhkIBMuA==
X-Gm-Gg: AY/fxX7KjVHggmBaNgbmosfai3Q08ZUPZafYMdHiS4aldUkiEPqiSOhj8+t2VLzBbn/
	gs7ck7IUb3iguXoP1ijBVI4YYu+s7sp8o5R/0Mvu7T9vnp1YYZAsCyF7rmkPtwlKGBT7IaKdc/B
	zIQhV4ELVb0pP7stWVWOl7N6LumFoVeVrSIs3avR2nucRXGw6KpBSNLnoXMvxJXuGmBZ7hnzGwC
	0U+ydjQiDn2BVVfHQonN+nji1eNIedbEm9NMf6z3RLEi8fYEZgvtu69PALaAtLrFPWFNbe2Orfz
	VNjyu5Xv7wwr+Pok2XMw7Ajp3ZjtzDiC7hdFmPVepFwkagZdVnVkMIUmF7WYQBuJ8FK0IC084Kr
	C4pOWcuwH47ty2gQh/R6H6vCbzlp4D3sOgJUXf4Bp0sfEATcsr7lDY0noZzz1O803ohgFci8Iqx
	QUl8YHVo5oFhEkKggIWbW2805eig==
X-Google-Smtp-Source: AGHT+IEzJKAvkBWWTaGBdDIkEOSld8xOxLExkYxr/0jo7d28FQokONVJavrBwFBJimtRoy681SjlKQ==
X-Received: by 2002:a05:690e:2005:b0:644:51a4:4f16 with SMTP id 956f58d0204a3-6470c8ec98bmr582338d50.45.1767649737234;
        Mon, 05 Jan 2026 13:48:57 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa679385sm706737b3.32.2026.01.05.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:48:56 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Julia Evans <julia@jvns.ca>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v4 0/4] doc: git-reset: clarify DESCRIPTION section
Date: Mon,  5 Jan 2026 16:48:14 -0500
Message-ID: <cover.1767649692.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1767307382.git.ben.knoble+github@gmail.com>
References: <cover.1767307382.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues Julia Evans's excellent work updating the git-reset docs.

Changes in v4:
- Adjust wording per Jean-Noël Avila's review

Changes in v3:
- Adjust "git reset -p" description per Junio's review

Changes in v2:
- Mostly address Junio's review while keeping to Julia's style (?),
  taking at a stab at a few gray areas.
- I left alone the first patch, the commented-upon part of which is
  later rewritten anyway.

v1: https://lore.kernel.org/git/pull.1991.git.1760731558.gitgitgadget@gmail.com/
v2: https://lore.kernel.org/git/cover.1766103827.git.ben.knoble+github@gmail.com/
v3: https://lore.kernel.org/git/cover.1767307382.git.ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/git/tree/bk/je/doc-reset

Julia Evans (4):
  doc: git-reset: reorder the forms
  doc: git-reset: clarify intro
  doc: git-reset: clarify `git reset [mode]`
  doc: git-reset: clarify `git reset <pathspec>`

 Documentation/git-reset.adoc | 111 ++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 54 deletions(-)

Diff-intervalle contre v3 :
1:  a558c5a868 = 1:  a558c5a868 doc: git-reset: reorder the forms
2:  f90be8559f ! 2:  3fc46c7158 doc: git-reset: clarify intro
    @@ Documentation/git-reset.adoc: git-reset(1)
      NAME
      ----
     -git-reset - Reset current HEAD to the specified state
    -+git-reset - Set HEAD or the index to a known state
    ++git-reset - Set `HEAD` or the index to a known state
      
      SYNOPSIS
      --------
    @@ Documentation/git-reset.adoc: git reset (--patch | -p) [<tree-ish>] [--] [<paths
     -In the last three forms, copy entries from _<tree-ish>_ to the index.
     +`git reset` does either of the following:
     +
    -+1. `git reset [<mode>] <commit>` changes which commit HEAD points to. This makes
    -+   it possible to undo various Git operations, for example commit, merge,
    ++1. `git reset [<mode>] <commit>` changes which commit `HEAD` points to. This
    ++   makes it possible to undo various Git operations, for example commit, merge,
     +   rebase, and pull.
     +2. When you specify files or directories or pass `--patch`, `git reset` updates
     +   the staged version of the specified files.
3:  89c87c14aa ! 3:  0ca9fcf943 doc: git-reset: clarify `git reset [mode]`
    @@ Documentation/git-reset.adoc: DESCRIPTION
     -	Resets the index but not the working tree (i.e., the changed files
     -	are preserved but not marked for commit) and reports what has not
     -	been updated. This is the default action.
    -+	Leaves your working directory unchanged.
    -+	Updates the index to match the new HEAD, so nothing will be staged.
    ++	Leave your working directory unchanged.
    ++	Update the index to match the new `HEAD`, so nothing will be staged.
      +
    - If `-N` is specified, removed paths are marked as intent-to-add (see
    +-If `-N` is specified, removed paths are marked as intent-to-add (see
    ++If `-N` is specified, mark removed paths as intent-to-add (see
      linkgit:git-add[1]).
      
     +`--soft`::
    @@ Documentation/git-reset.adoc: DESCRIPTION
     -	Resets the index and working tree. Any changes to tracked files in the
     -	working tree since _<commit>_ are discarded.  Any untracked files or
     -	directories in the way of writing any tracked files are simply deleted.
    -+	Overwrites all files and directories with the version from _<commit>_,
    ++	Overwrite all files and directories with the version from _<commit>_,
     +	and may overwrite untracked files. Tracked files not in _<commit>_ are
     +	removed so that the working tree matches _<commit>_.
    -+	Updates the index to match the new HEAD, so nothing will be staged.
    ++	Update the index to match the new `HEAD`, so nothing will be staged.
      
      `--merge`::
    -+	Mainly exists to reset unmerged index entries, like those left behind by
    -+	`git am -3` or `git switch -m` in certain situations.
    - 	Resets the index and updates the files in the working tree that are
    - 	different between _<commit>_ and `HEAD`, but keeps those which are
    +-	Resets the index and updates the files in the working tree that are
    +-	different between _<commit>_ and `HEAD`, but keeps those which are
    ++	Reset the index and update the files in the working tree that are
    ++	different between _<commit>_ and `HEAD`, but keep those which are
      	different between the index and working tree (i.e. which have changes
      	which have not been added).
    ++	Mainly exists to reset unmerged index entries, like those left behind by
    ++	`git am -3` or `git switch -m` in certain situations.
      	If a file that is different between _<commit>_ and the index has
      	unstaged changes, reset is aborted.
     -+
4:  96566265d8 ! 4:  accf7a0673 doc: git-reset: clarify `git reset <pathspec>`
    @@ Documentation/git-reset.adoc: linkgit:git-add[1]).
     -and specifying a commit with `--source`, you
     -can copy the contents of a path out of a commit to the index and to the
     -working tree in one go.
    -+In this mode, `git reset` updates only the index (without updating the HEAD or
    ++In this mode, `git reset` updates only the index (without updating the `HEAD` or
     +working tree files). If you want to update the files as well as the index
     +entries, use linkgit:git-restore[1].
      

base-commit: f229982df19c327876ce7ded40f6efefe20da5d4
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

