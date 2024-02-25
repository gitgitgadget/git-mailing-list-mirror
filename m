Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB81B957
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708898199; cv=none; b=pGZhXHFZ8YKgLQ5l00kb4Up885zXtxEqbZjP/m+cGArdIorhi9vH9NU6sYtCudUR3k326ldCjltKsl7sx7L8OGEtL0KRsBse7lr0hUXiG/CCg6SwdfY795ftDiwBQKShVa12mzahfW/JBg7q8aB4oezx83TzSCvqnkg8PDVN0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708898199; c=relaxed/simple;
	bh=a6kPGIrbvmnjCSu1ZIFRNgWupSnS2rY27JpW9viGZWw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=WIqQdZN682F0A+vN0SPwEBsLkt2wI6M9Sy8GbrEIoHk/hF7mlgdMEUkxd4Wip4/mQtrhKnFFf6f/mYqmsVYVy2GM/xc8rYTrvsXyPIZYLawyV12hmYAakBr+ea9ylqt1fp4iZE/RCNZ+7dtYogYLALtXwzcprXutd/O3orFKFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5F4qVnF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5F4qVnF"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-686a92a8661so16552616d6.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 13:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708898196; x=1709502996; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSSJjz0eJPBBD87i6eKC9+rAv9xU5OkpO58Zcr9/fHM=;
        b=V5F4qVnFROhAaNDZza5B4NfVKE4dkMhhnNqwCN+KFHcZEmRYGf3MsfYS0XoaSYK0Id
         QaZ1QUtVDnMiok9f6HpzZxdHe+jsx0vAOPV5Z1kHR67VzdD79nSkqhGcFWgamchcviYz
         tncICS+xC15Q0t88pYIeXvyfrKOMuvZ0XjzLjjieXiLlCV7H7uYSCuggb39WmZDk4Aip
         PwuK5s0mRXu8/xGnGhPM/VA8c3VNkXT7hEpzUGUcEl5vYRcZfsUee4q2zBXIfaxXEDi8
         9Jk6e0odD/LrJm39nB0M41Jb2KJakqjIforf2w1xU5hJMFhCMp2T53Sy8ZaUU3nQgZOv
         2HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708898196; x=1709502996;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rSSJjz0eJPBBD87i6eKC9+rAv9xU5OkpO58Zcr9/fHM=;
        b=DDUcp2AWIj6C5N0wAqAOK8VnHRfGy70V507jEJIQYEAW3BHjpkMPda4cQlEj8fSPKz
         YR8ESZSgqbJ+YpOyP9MXkL9Y0cfsh8P8W+0VXxazqSyvNTIWidK0LCavKCGKJUb4ohVR
         K/aZrEUS8QHs0cJykIaFaSvPuZuiEme/zYZhqLHjcnB/zbqYxYXffc1s6dC1JEgZLD3k
         BZf1H3RCW8u02CSIgsfngfy5BxwAfXuQPbRt0YbbX+1d6OZLct9QVk3gTtHqfNChI/JX
         Rgd1e1VFkj8i7YRE2hG1b6SFvfFcZQqfjm27klVKu+H1R1Yc0CaN2MOgH2s+0Qwyt4si
         1pTQ==
X-Gm-Message-State: AOJu0Ywm54m0LvOkG8C5IJgcB4Uv63MFHv64nGcRgQAGmCNHPjsiG5/F
	ac0J9rqgEXPYAibs1lL+IJ08jCv6nTAT6t62W3R4rAV+JV/WU5YE
X-Google-Smtp-Source: AGHT+IGN4UNHXwfp63++8+7bIZuWTjAsGTKo2IhDa+/yFKJisUyl7WpH8JeScaUmctUS+ZvB3o4cZQ==
X-Received: by 2002:ad4:5bc3:0:b0:68f:daf8:f97d with SMTP id t3-20020ad45bc3000000b0068fdaf8f97dmr4608719qvt.5.1708898196604;
        Sun, 25 Feb 2024 13:56:36 -0800 (PST)
Received: from [127.0.0.1] ([2606:6d00:11:ff90:6090:e182:bd61:ebff])
        by smtp.gmail.com with ESMTPSA id qh27-20020a0562144c1b00b0068fb940bc92sm2126129qvb.144.2024.02.25.13.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 13:56:36 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH v5 0/2] Implement `git log --merge` also for
 rebase/cherry-pick/revert
Date: Sun, 25 Feb 2024 16:56:15 -0500
Message-Id: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIC322UC/52PzU7DMBCEX6XymQ226xC3J94DcfDPNrbwT2S7g
 arKu+OUA5y5rDS7mv1m7qRi8VjJ+XAnBVdffU5djE8HYpxKM4K3XRNOuaCcUYgBQp4hYum3T98
 cGIel3GDx5gNUspBbX8BS8WozOFS2Ah21lSin02Q16a+Xghf/9cC+vXetVUXQRSXjdth1qa2gi
 s9R1YZldzhfWy63R871uPt+IjE2UckEHYc+GAcG0Q8qDCG7qFJ6naPyYTA5kp2zil/nv8usAig
 ctTnhC5dUXsRfyLZt37ubHT9UAQAA
In-Reply-To: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.14-dev

Changes in v5:
- Marked error messages for translation and tweaked them as suggested by Phillip
- Reworded the message of 2/2 as suggested by Phillip
- Removed the change to gitk's doc in 2/2 as pointed out by Johannes
- Fixed the trailers in 2/2
- Improved the doc in 2/2 as suggested by Phillip and Jean-Noël

Changes in v4:
- Added a commit message for 2/2 detailing the use case and summarizing the discussion in the thread
- Adjusted the documentation of the option

---
Michael Lohmann (2):
      revision: ensure MERGE_HEAD is a ref in prepare_show_merge
      revision: implement `git log --merge` also for rebase/cherry-pick/revert

 Documentation/rev-list-options.txt |  7 +++++--
 revision.c                         | 27 +++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)
---
base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
change-id: 20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-05bd8e8797db

Range-diff versus v4:

1:  37405be1a3 ! 1:  c9536431d1 revision: ensure MERGE_HEAD is a ref in prepare_show_merge
    @@ Commit message
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
     
      ## revision.c ##
     @@ revision.c: static void prepare_show_merge(struct rev_info *revs)
    @@ revision.c: static void prepare_show_merge(struct rev_info *revs)
     +			&oid, NULL))
      		die("--merge without MERGE_HEAD?");
     +	if (is_null_oid(&oid))
    -+		die("MERGE_HEAD is a symbolic ref???");
    ++		die(_("MERGE_HEAD is a symbolic ref?"));
      	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
      	add_pending_object(revs, &head->object, "HEAD");
      	add_pending_object(revs, &other->object, "MERGE_HEAD");
2:  6ac1608809 ! 2:  1641c4be81 revision: implement `git log --merge` also for rebase/cherry-pick/revert
    @@ Commit message
         to merge conflicts also for other mergy operations besides merges, like
         cherry-pick, revert and rebase.
     
    -    For rebases, an interesting range to look at is HEAD...REBASE_HEAD,
    -    since the conflicts are usually caused by how the code changed
    -    differently on HEAD since REBASE_HEAD forked from it.
    +    For rebases and cherry-picks, an interesting range to look at is
    +    HEAD...{REBASE_HEAD,CHERRY_PICK_HEAD}, since even if all the commits
    +    included in that range are not directly part of the 3-way merge,
    +    conflicts encountered during these operations can indeed be caused by
    +    changes introduced in preceding commits on both sides of the history.
     
    -    For cherry-picks and revert, it is less clear that
    -    HEAD...CHERRY_PICK_HEAD and HEAD...REVERT_HEAD are indeed interesting
    -    ranges, since these commands are about applying or unapplying a single
    -    (or a few, for cherry-pick) commit(s) on top of HEAD. However, conflicts
    -    encountered during these operations can indeed be caused by changes
    -    introduced in preceding commits on both sides of the history.
    +    For revert, as we are (most likely) reversing changes from a previous
    +    commit, an appropriate range is REVERT_HEAD..HEAD, which is equivalent
    +    to REVERT_HEAD...HEAD and to HEAD...REVERT_HEAD, if we keep HEAD and its
    +    parents on the left side of the range.
     
    -    Adjust the code in prepare_show_merge so it constructs the range
    -    HEAD...$OTHER for each of OTHER={MERGE_HEAD, CHERRY_PICK_HEAD,
    -    REVERT_HEAD or REBASE_HEAD}. Note that we try these pseudorefs in order,
    -    so keep REBASE_HEAD last since the three other operations can be
    -    performed during a rebase. Note also that in the uncommon case where
    -    $OTHER and HEAD do not share a common ancestor, this will show the
    -    complete histories of both sides since their root commits, which is the
    -    same behaviour as currently happens in that case for HEAD and
    -    MERGE_HEAD.
    +    As such, adjust the code in prepare_show_merge so it constructs the
    +    range HEAD...$OTHER for OTHER={MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD
    +    or REBASE_HEAD}. Note that we try these pseudorefs in order, so keep
    +    REBASE_HEAD last since the three other operations can be performed
    +    during a rebase. Note also that in the uncommon case where $OTHER and
    +    HEAD do not share a common ancestor, this will show the complete
    +    histories of both sides since their root commits, which is the same
    +    behaviour as currently happens in that case for HEAD and MERGE_HEAD.
     
         Adjust the documentation of this option accordingly.
     
    -    Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
         Co-authored-by: Johannes Sixt <j6t@kdbg.org>
    -    Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
    +    Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
         Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
         [jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/gitk.txt ##
    -@@ Documentation/gitk.txt: linkgit:git-rev-list[1] for a complete list.
    - 
    - --merge::
    - 
    --	After an attempt to merge stops with conflicts, show the commits on
    --	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
    --	that modify the conflicted files and do not exist on all the heads
    --	being merged.
    -+	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
    -+	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
    -+	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
    -+	when the index has unmerged entries.
    - 
    - --left-right::
    - 
    +    Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
     
      ## Documentation/rev-list-options.txt ##
     @@ Documentation/rev-list-options.txt: See also linkgit:git-reflog[1].
    @@ Documentation/rev-list-options.txt: See also linkgit:git-reflog[1].
      --merge::
     -	After a failed merge, show refs that touch files having a
     -	conflict and don't exist on all heads to merge.
    -+	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
    -+	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
    ++	Show commits touching conflicted paths in the range `HEAD...<other>`,
    ++	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
     +	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
    -+	when the index has unmerged entries.
    ++	when the index has unmerged entries. This option can be used to show
    ++	relevant commits when resolving conflicts from a 3-way merge.
      
      --boundary::
      	Output excluded boundary commits. Boundary commits are
    @@ revision.c: static void add_pending_commit_list(struct rev_info *revs,
     +				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
     +				oid, NULL)) {
     +			if (is_null_oid(oid))
    -+				die("%s is a symbolic ref???", other_head[i]);
    ++				die(_("%s is a symbolic ref?"), other_head[i]);
     +			return other_head[i];
     +		}
     +
    -+	die("--merge without MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD?");
    ++	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
     +}
     +
      static void prepare_show_merge(struct rev_info *revs)
    @@ revision.c: static void prepare_show_merge(struct rev_info *revs)
     -			&oid, NULL))
     -		die("--merge without MERGE_HEAD?");
     -	if (is_null_oid(&oid))
    --		die("MERGE_HEAD is a symbolic ref???");
    +-		die(_("MERGE_HEAD is a symbolic ref?"));
     -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
     +	other_name = lookup_other_head(&oid);
     +	other = lookup_commit_or_die(&oid, other_name);

