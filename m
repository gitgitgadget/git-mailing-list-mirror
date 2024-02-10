Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68485C022
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707608134; cv=none; b=MqYmeKVFhkeK2TqOwSICJuPHbfUC4rd72B97E3gLUUFxmf9grMraW8FUc2uFcTKG+Z4McG3PRQ+Q2t7O0zN8SkyqEGrCIK29zr/DwTl9/G2C1aLdzCrXY+TzIwKC2UORp9Le5xjCDIh++ftnsF+Wozcbe+kxC2nUdYnqwrIT3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707608134; c=relaxed/simple;
	bh=yFeoc4/DvNkWLj6XIGWuBU8BsiDZa1o80Grg9lIZvn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=AgOQmFZO/3nrY7K/lfGweAjQ3LoxWT4NZJlezNLCARMHe85i/4lnoEvtqrmaORPLMUDMJRNeUu5GCCJUiw+fWMFPhnWxRFRTKsG1H8ULly3wtagCZioa2p6FVXhgmhD7lR+V+HLKdtcnK9DiEFs2ADQLU6QRyPL7uAAVHgNyTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEu3nNFU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEu3nNFU"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78407987510so125777185a.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 15:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707608132; x=1708212932; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17bbfmaRHt2GbGdUIkgHxhXmmyq5hwl9w0vjY3b3jkA=;
        b=HEu3nNFUrsq62Qo42un2RrI8rnvCIhLVdKnakT5VG0UDZ62EqgOeDYhq3oaQepLba6
         T5nQkPRJ2gA4426sNEEsJTcpMvZrZ+2SclKoDO3V5x0vpRbM3BjCymCpBdIREE7Axt86
         aXoCDvV/xFTERatPHN2vFArrVFIDKzH79/xeGASef9FOJW7WsdBx80Xa7S4zM9qq6nFe
         VLHcfnNO+l2briJvyJK53NW+R+r6PoF0X3EqfTN34IaTkREmtGzgX+M5Wp9Uhxgtm6G5
         WpzxZAZVhGc2kHzlw6tI+07QVaSyhkAWgbA0jDpeYJxMfwpIsC3tJfKJAg57R9qJvko1
         lQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707608132; x=1708212932;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=17bbfmaRHt2GbGdUIkgHxhXmmyq5hwl9w0vjY3b3jkA=;
        b=f+EPSWW9j7fC4oBlGL6uIH8fnj+eIZ79j07O25+5gmuJm2nuSwOLVQWSOKOdQdThQL
         weMSufI+Jh+gLPaQiKDfzOaMFZw9qjibSy5JA2p2BLYX/RHxgjdd1KLzQY2DtTrMR7hp
         qGiMPQl9nQOrWKCQM9h6qItbcmlZ692Y59Ppt3m2Rz456gj6K4xfyFdZjKDoy3hhsUCN
         HxY5iPyJL39YDLbW2yk41fjXn8zzz0tTcvgOJiiM8WUMudKhqlGkuS+l2GFdZaEq82lb
         GRvhINd2lmdQ30iTYBBWsKIsLnWioDUNHOFVYehhsE0Z0IiiSArlfSbaCr+JMp0J9Drz
         NtXA==
X-Gm-Message-State: AOJu0YzSijzM2uMl3dNbBgIQ0rZYHc4r9gzs4GXo4Tyfj5EHSKgIPRZC
	mgN3pVCJKf3rKs7u2Cdta+o0j2ikwBRPk9DaPNn++oTR5bKooKcEUjVWDWF0/8A=
X-Google-Smtp-Source: AGHT+IG7pfYkIbP5NIkGrreHg0r4nDphyDmu5tPo616xsf+FVRnTL8vO9hef8tkjrnE1/pRLVPn/aQ==
X-Received: by 2002:a05:620a:4110:b0:784:f2e6:e10e with SMTP id j16-20020a05620a411000b00784f2e6e10emr3959584qko.21.1707608130889;
        Sat, 10 Feb 2024 15:35:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXlT2366RAn0SLhakGKMVTXaPwHCLBsMS9caywZMzoR0GTjtmMrmlHo+5kvlYwcsq+9LDFSZ0e1xfWEZsmDwiZx0BU8y+UY4bTWZrnZvGwDGUVqiKX6xYsjcsTdMW/8nknIVLigfqGlWAwcOMlBMt5toPo+UfZEsSc+dyr95+Tj2eqmDpw3T2yRnq/xfZJOCMOSvkofiuhaxTreNOhY/6C0+1eWTwIvn2KUHmnqinU1SJRSq0jHfUHXhlo0qT2qQ9nJmAOSazEuq/M
Received: from [127.0.0.1] ([2606:6d00:17:3855:d82e:7889:6cb3:5f])
        by smtp.gmail.com with ESMTPSA id qp9-20020a05620a388900b00785c9ea7974sm571942qkn.79.2024.02.10.15.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:35:30 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH v4 0/2] Implement `git log --merge` also for
 rebase/cherry-pick/revert
Date: Sat, 10 Feb 2024 18:35:11 -0500
Message-Id: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAIyGUC/yWOS27DMAxErxJoXbqS68BuVr1HkQUtsRZRfQxK+
 SHw3SunmwHeEMOZpyokTEWdDk8ldOXCOTUY3g7KekwLAbvGqtf9oHujIQYIeYFI0m43rh6sJ5E
 HrGx/AZODXJsBa6GLy+AJXQF9nN1E0/g5ulm116vQD99ftd/nxjMWglkwWb+XXdZShTC+RyyVZ
 E94LjXL47Xz+rHn/icZM+rJDPrYNTE9GIjcYehC9hFT+loicuhsjuq8bdsfbcpVDu8AAAA=
In-Reply-To: <20240117081405.14012-1-mi.al.lohmann@gmail.com>
References: <20240117081405.14012-1-mi.al.lohmann@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.13-dev-71c1b

Changes in v4:
- Added a commit message for 2/2 detailing the use case and summarizing the discussion in the thread
- Adjusted the documentation of the option

Link to v3: https://lore.kernel.org/r/20240117081405.14012-1-mi.al.lohmann@gmail.com

Range-diff vs v3:

1:  37405be1a3 = 1:  37405be1a3 revision: ensure MERGE_HEAD is a ref in prepare_show_merge
2:  de080a628c ! 2:  6ac1608809 revision: implement `git log --merge` also for rebase/cherry_pick/revert
    @@ Metadata
     Author: Michael Lohmann <mi.al.lohmann@gmail.com>

      ## Commit message ##
    -    revision: implement `git log --merge` also for rebase/cherry_pick/revert
    +    revision: implement `git log --merge` also for rebase/cherry-pick/revert

    +    'git log' learned in ae3e5e1ef2 (git log -p --merge [[--] paths...],
    +    2006-07-03) to show commits touching conflicted files in the range
    +    HEAD...MERGE_HEAD, an addition documented in d249b45547 (Document
    +    rev-list's option --merge, 2006-08-04).
    +
    +    It can be useful to look at the commit history to understand what lead
    +    to merge conflicts also for other mergy operations besides merges, like
    +    cherry-pick, revert and rebase.
    +
    +    For rebases, an interesting range to look at is HEAD...REBASE_HEAD,
    +    since the conflicts are usually caused by how the code changed
    +    differently on HEAD since REBASE_HEAD forked from it.
    +
    +    For cherry-picks and revert, it is less clear that
    +    HEAD...CHERRY_PICK_HEAD and HEAD...REVERT_HEAD are indeed interesting
    +    ranges, since these commands are about applying or unapplying a single
    +    (or a few, for cherry-pick) commit(s) on top of HEAD. However, conflicts
    +    encountered during these operations can indeed be caused by changes
    +    introduced in preceding commits on both sides of the history.
    +
    +    Adjust the code in prepare_show_merge so it constructs the range
    +    HEAD...$OTHER for each of OTHER={MERGE_HEAD, CHERRY_PICK_HEAD,
    +    REVERT_HEAD or REBASE_HEAD}. Note that we try these pseudorefs in order,
    +    so keep REBASE_HEAD last since the three other operations can be
    +    performed during a rebase. Note also that in the uncommon case where
    +    $OTHER and HEAD do not share a common ancestor, this will show the
    +    complete histories of both sides since their root commits, which is the
    +    same behaviour as currently happens in that case for HEAD and
    +    MERGE_HEAD.
    +
    +    Adjust the documentation of this option accordingly.
    +
    +    Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
         Co-authored-by: Johannes Sixt <j6t@kdbg.org>
    +    Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
         Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
         [jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
         Signed-off-by: Junio C Hamano <gitster@pobox.com>

    + ## Documentation/gitk.txt ##
    +@@ Documentation/gitk.txt: linkgit:git-rev-list[1] for a complete list.
    +
    + --merge::
    +
    +-	After an attempt to merge stops with conflicts, show the commits on
    +-	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
    +-	that modify the conflicted files and do not exist on all the heads
    +-	being merged.
    ++	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
    ++	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
    ++	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
    ++	when the index has unmerged entries.
    +
    + --left-right::
    +
    +
    + ## Documentation/rev-list-options.txt ##
    +@@ Documentation/rev-list-options.txt: See also linkgit:git-reflog[1].
    + Under `--pretty=reference`, this information will not be shown at all.
    +
    + --merge::
    +-	After a failed merge, show refs that touch files having a
    +-	conflict and don't exist on all heads to merge.
    ++	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
    ++	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
    ++	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
    ++	when the index has unmerged entries.
    +
    + --boundary::
    + 	Output excluded boundary commits. Boundary commits are
    +
      ## revision.c ##
     @@ revision.c: static void add_pending_commit_list(struct rev_info *revs,
      	}

---
Michael Lohmann (2):
      revision: ensure MERGE_HEAD is a ref in prepare_show_merge
      revision: implement `git log --merge` also for rebase/cherry-pick/revert

 Documentation/gitk.txt             |  8 ++++----
 Documentation/rev-list-options.txt |  6 ++++--
 revision.c                         | 27 +++++++++++++++++++++++----
 3 files changed, 31 insertions(+), 10 deletions(-)
---
base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
change-id: 20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-05bd8e8797db

