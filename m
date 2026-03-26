Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0D38A72E
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534655; cv=none; b=iM1sMNQGoKsMS064ewnOQGgyYnVKbU1IIZ1fwibJwax3M/ElxukkFUvwWv6sw1DhGo5QLzjJKg73HlNXlSiX598fIaKAL1MCrg4TihnlOL6iOfpF69yYkrNac6JmoHUs50bX6UqezFIW0mOetIYQwQCJMdKEVi+LuhU435EVyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534655; c=relaxed/simple;
	bh=XxDCp9aOCyMOWaGiTSimF50xzbp6bKvRR2qgAtyvwAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX1WRbbi4eEBx8ujIvZG5WYxABJGAtMcvlLIgNSyLcgXhFBBH9pbsoodDV5xuo6JKn6kXh5390BoqZvaciYNVY0hN26LGJSngoOprEBHuxXo3fY0CUCePQyeQoNdHmIYuFWFj3Xamo7loPcuCoDj7OpfGEXM3EnHwtrn1Y8aFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tuud5fCr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuud5fCr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4870206f73bso5954805e9.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774534646; x=1775139446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2a+Jm6vzEtgvsi66iroRAWwBhsD5cu6Fl/EIsndxIv4=;
        b=Tuud5fCrDGHktNry2ojxuJ1cPCAt0rZ5mg0Cdq/TpdQHm09NbOA80PBilx8tuuFp+c
         ePC30FFnDQuV7sKMtHOW4zQ3jjVtWPrKPki83ia5iu5d7K9WzgRyrBokA/otFqID7BwJ
         dM9shaU/MTtJdis1Lb9FvpSMKtiMswYximd+q2OHscv39gtdDKTsJ6HilDbuOqInzMOV
         ByMJibPoZb6VH7IofbuxmbZ/Tnh7GBKBov4ckVenArZjJgU+XfwJFA/6MLJTy8r1ydoZ
         ePSZkwEBKvYszSOne2yeJiITBSgOL9Q84Y5BnFvNEu6+p1wgd8mJcVFdwIEwq67viOIy
         d4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774534646; x=1775139446;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2a+Jm6vzEtgvsi66iroRAWwBhsD5cu6Fl/EIsndxIv4=;
        b=dMN4mpaMweRPBwSAYKYGLIvNW1JMld3OwrmEXAr4zGwLpVO05p4H4pDEx0mR6p4ZdY
         B87zu4jNSKiJQytk1FnEbDVlphY8ayr5n9gpo3BK01VMFTPnx5j0XXRqVv8n8dJCpAyW
         QIi3wB18381ADA5TMEoOHzHTKiClleOjrrCVpuVSTIWSyBF1bDPv05enL1Rr7FpXNbJZ
         rymNyHr+sKb5eLgUroMIqas7zoiZNEaAsdoX0dXEmZhnCqKc2Ui1hXnX+FOodNcHLKjv
         S+ORCpybI4ozXQYRPdArNaCAPHWIxPCKyJ0Hwn2XK09tkyUKTizrtoNeckDo0NEX1szU
         8Yhg==
X-Gm-Message-State: AOJu0YxJvhuEYwboMsJFS7INI9TAJ5rgygAGGpx74DQT/tEdQpT9WBlI
	EAV1/jNOlPPxM/zcNG4RVU/gFSlvPBGs5tKmipGCU/+P2MbaKn2TFAgM043WkQ==
X-Gm-Gg: ATEYQzyL1AzvQzYp2I8tkDY3ebcKuabFjHhf+9gcqzbVfv0uXU9xEjd8mZ6MbhR+Uoe
	cgzCISa9NZPyWaRKHqRMBQ0n+UgJr0ReIFvnainxCXGpt1hOyCX3kCRsTpHkFw71nXYgkYyTTZC
	v9SQXL1kN/uIvS13GJ53b505x+2CUfk9tqqvoYDsPyLXRqxjJlhlZ+frxVUuZ7IaEQvPRhARHnp
	jSAh+U+nMqVGYx3riI51cIyddWSavBk0WsMv9Z8clgxjaQRV/qT2KSOdU6QIolofE5f0bvrNVJU
	sZl4mN3TLZfKBgUTladnz5Fjo9m6Jlj+Hzid4PBINKGZOdKozGSmNTDb4bO+SwQcTuWAKZuGz3G
	RjQCCOgVCo08CXFU2sP/GPU3VYBrTVU4rLz5+ZJvaaGEhx8SbC8WiKfFJsZwrGHyeK1oYObWMvu
	Mf1EZiQHfJ24ISfd+oTN96lMIA90c=
X-Received: by 2002:a05:600c:8489:b0:486:fd3a:fd22 with SMTP id 5b1f17b1804b1-48715fc384dmr123493455e9.4.1774534646038;
        Thu, 26 Mar 2026 07:17:26 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720901b90sm15507775e9.17.2026.03.26.07.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:17:24 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/3] worktree: stop using "the_repository" in is_current_worktree()
Date: Thu, 26 Mar 2026 14:16:56 +0000
Message-ID: <cover.1774534617.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9.dirty
In-Reply-To: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is a follow up to pw/no-more-NULL-means-current-worktree that removes
"the_repository" from is_current_worktree() and get_worktree_git_dir().
The first patch removes the use of "the_repository" when determining
if a worktree is current. Patches 2 & 3 require a non-NULL worktree
when calling get_worktree_git_dir() to remove the last use of
"the_repository" in that function.

Changes since V2

 - Patch 1: expanded commit message and added a comment to is_current
            member of struct worktree. (thanks to Patrick)

Changes since V1

 - Patch 2: fixed indentation (thanks to Junio)
 - Patch 3: removed stale comment (thanks to Junio)

Base-Commit: 7f19e4e1b6a3ad259e2ed66033e01e03b8b74c5e
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fworktree-is-current-use-repo%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/7f19e4e1b...c33290280
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/worktree-is-current-use-repo/v3


Phillip Wood (3):
  worktree: remove "the_repository" from is_current_worktree()
  worktree add: stop reading ".git/HEAD"
  worktree: reject NULL worktree in get_worktree_git_dir()

 builtin/worktree.c      | 21 ++-------------------
 t/t2400-worktree-add.sh | 28 ++++++++++++----------------
 worktree.c              | 10 +++++-----
 worktree.h              |  3 +--
 4 files changed, 20 insertions(+), 42 deletions(-)

Range-diff against v2:
1:  075700a2256 ! 1:  5357c0dd53e worktree: remove "the_repository" from is_current_worktree()
    @@ Metadata
      ## Commit message ##
         worktree: remove "the_repository" from is_current_worktree()
     
    -    is_current_worktree() compares the gitdir of the worktree to the gitdir
    -    of "the_repository" and returns true when they match. To get the gitdir
    -    of the worktree it calls get_workree_git_dir() which also depends on
    -    "the_repository". This has the effect that even if "wt->path" matches
    +    The "is_current" member of struct worktree was added in 750e8a60d69
    +    (worktree.c: mark current worktree, 2016-04-22) and was used in
    +    8d9fdd7087d (worktree.c: check whether branch is rebased in another
    +    worktree, 2016-04-22) to optionally skip the current worktree when
    +    seeing if a branch is already checked out in die_if_checked_out().
    +
    +    To determine if a worktree is "current" is_current_worktree() compares
    +    the gitdir of the worktree to the gitdir of "the_repository"
    +    and returns true when they match. To get the gitdir of the
    +    worktree it calls get_workree_git_dir() which also depends on
    +    "the_repository". This means that even if "wt->path" matches
         "wt->repo->worktree" is_current_worktree(wt) will return false when
    -    "wt->repo" is not "the_repository" which is confusing.
    +    "wt->repo" is not "the_repository". Consequently die_if_checked_out()
    +    will fail to skip such a worktree when checking if a branch is already
    +    checked out and may die errounously. Fix this by using the worktree's
    +    repository instance instead of "the_repository" when comparing gitdirs.
     
         The use of "the_repository" in is_current_wortree() comes from
         replacing get_git_dir() with repo_get_git_dir() in 246deeac951
         (environment: make `get_git_dir()` accept a repository, 2024-09-12). In
         get_worktree_git_dir() it comes from replacing git_common_path() with
         repo_common_path() in 07242c2a5af (path: drop `git_common_path()`
    -    in favor of `repo_common_path()`, 2025-02-07). In both cases we have
    -    a repository instance available so use that instead. This means
    -    that a worktree "wt" is always considered current when "wt->path"
    -    matches "wt->repo->worktree" and so the worktree returned by
    -    get_worktree_from_repository() is always considered current.
    +    in favor of `repo_common_path()`, 2025-02-07). In both cases the
    +    replacements appear to have been mechanical.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    @@ worktree.c: char *get_worktree_git_dir(const struct worktree *wt)
      }
      
      static struct worktree *find_worktree_by_suffix(struct worktree **list,
    +
    + ## worktree.h ##
    +@@ worktree.h: struct worktree {
    + 	struct object_id head_oid;
    + 	int is_detached;
    + 	int is_bare;
    +-	int is_current;
    ++	int is_current;		/* does `path` match `repo->worktree` */
    + 	int lock_reason_valid; /* private */
    + 	int prune_reason_valid; /* private */
    + };
2:  c3c5767725d = 2:  4d50e6bcb2e worktree add: stop reading ".git/HEAD"
3:  75eecc8492e = 3:  c3329028010 worktree: reject NULL worktree in get_worktree_git_dir()
-- 
2.52.0.362.g884e03848a9.dirty

