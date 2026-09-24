Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB2292B2E
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261066; cv=none; b=CNyHU+hnZbPJ0Bdb83GnSEvcGw6DOGkgRu3E7DhksHpgeIdhfm9E6can/GinZ/+bEE5FbWmqQtCnG1hNW7rw2b90O5kRkCrTSiI3t+RHYHb6s2RCFsJ2q+fLYYNVLvOrQTJ8lAY2n6ZnUSPmtETSwnMw5eSW23PaBchda/DZrH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261066; c=relaxed/simple;
	bh=WbvFkT9Xcz49s4N2qbA715woPSdOCOzIuHg6i+sBWxU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Jsnq/UpuwU2t9FsPaNmkwINomn+MqRgMYY3DiVQKjr11vN8Ej6mwGVV03p8Np5ppo9EF16E2Z7THj0JBwN250TYrWX4CWMCE2wZtdMI6Y11U0AV3HDGG8EVN90DxdY69Wbzzpq/l2/fGKRfaEFJ59puDQJ7GPVkCTvQmjYOYeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj+RCtrM; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj+RCtrM"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e2254dso322553b3a.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261064; x=1790865864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yliC+YTje7kAO8+OLZsndopO3YjK5SDoz55KZtY575c=;
        b=Yj+RCtrMjmRSGTEJ6I414i5T1V4DRHoRCEf43qnFJ7NTXTdAOcJlJJw/pZY1TebypQ
         2r7HWwNkKr/MGKwFFl+l3Sa4wNscGXM8oHng93VpQDap9HP6kaXJ3DUwGmkMCC1LQJoE
         DrkxVYhQGKlkMu/SJo8aj9zzDdUxMAzvRbmHRHO77F+UdGQF5yu/9axENTgHzhhCO1v4
         W6J0p6pMHem571RsDz3ghKXUsUuZc9Q3Ac3Xy8UcvTDDuQPsYpmnE1XpVx5JZTrShrVH
         gFV47SOO3wTELScPWpMsao5oum3izE8jBGOyiXHTxa21706P2WxlkQB6MzR7HcBFcN1F
         7eVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261064; x=1790865864;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yliC+YTje7kAO8+OLZsndopO3YjK5SDoz55KZtY575c=;
        b=NDm1GV70s9fvbNO50d/6fvWOZMWLmG1vNtCllyZW8DUgm9gOlS/e6PcEwxbb0RfupW
         ksmX+fonEvvzMOhAXRS2BH1Iqabl5+/tNAqdSJrZTs7DQR405r1erZQB0xEliNy0u10w
         Jh3RrwEk5y0nZWovuW5jkURHW4O6gmzzDiJbk4BNuWHYHV6eHuNzFmwZIaCZyxg2hc80
         Czr3WWnkDh3sIfd3zix1RkBDsv9LaaSplX3OS5IFIeuQGFMR66HXBXUSiQ9Jk3IE+RCp
         27sK3wd/XCMS2P6Q0PQzm6/+n1kNFW1JTtWE9JQF+lFDQam/DuGdTDLOD0iqaDF/xvD/
         31DQ==
X-Gm-Message-State: AFuF++lJRiYwOwqf2CAoEqhkdIYSGmcELLYGgRzdZm/C3qf2aDV5u12X
	LaRx4yf+s+zeA1ndUpT8mhVsnn71Ri1kJEsLAq/sE5DQGeXil+3efvH9XC2Txq1m
X-Gm-Gg: AYBFou1eAcdI+va2vsAYc355skPbwdI6c6avaqdM7yPnQjZU4FO8MwMQknijb9JWvCh
	/Q8GnlLEpM04wGnXH3LIbufgvqWJIGlai+hxxiAW/CfpfrOH3ymjibTWAWsWz9HO4G/1o8lxLcf
	mkwSvpa2yeNxqQvE9l0at5BXWoo2WMDLwlBW1QBCX/BPTluqXQR10m0mk8yOrj3N9ifUt1r96HG
	3KltbXg1Y8PL3ekfMajRXoS/HpKQv51brzu7gmzflT1cZZPJl9oJiF6a2XFA8maIXWZp0Eye/ao
	HXlcU9C13wNj1HlVoRPejewQZ2M1S4/hyLShN/L2I0J9KwI5ICfj7dCkRiVGSAzeCS3uI/q2Clu
	hYHTrA8hmshJr4nkM4A9MTPZuqfClnTNANzs4KVqul1xrBXINEPsAEr1SSPzMgvcXqfPu/EN9Yy
	QoCAq+zSYJcKI5ZOy/2sq9MhVVza3cebxHgxnpTT+ygP2XWxAUr6kFt4PvbKHQNtBv4Fz57p6U+
	/Q=
X-Received: by 2002:a05:6a00:3a06:b0:878:3704:e0f1 with SMTP id d2e1a72fcca58-87ea07d0e7fmr1557082b3a.23.1790261063590;
        Thu, 24 Sep 2026 07:44:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c1646sm3217454b3a.30.2026.09.24.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:23 -0700 (PDT)
Message-Id: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 14:44:15 +0000
Subject: [PATCH 0/7] [doc] Add new page on merge conflicts
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
Cc: ps@pks.im,
    Julia Evans <julia@jvns.ca>

Handling merge conflicts is difficult, and currently Git's guidance on merge
conflicts isn't giving users the information they need to navigate the
process. As usual, the process I used to write this was to collect comments
from Git users on the existing documentation, and then address those issues.
I listed the specific issues we're aiming to solve in the first commit
message in the series.

This patch series introduces a new manual page, gitmergeconflicts, which
explains the process of explaining a merge conflict with examples. It also
links to that new page from the commands which can cause merge conflicts,
instead of trying to reexplain the process every time.

This is a pretty big change, so here's a list of things I'm still
considering in the hopes that it'll help with the discussion:

 * I wrote that git commit does the same thing as git merge --continue
   during a git merge , but I'm not sure if that's always true.
 * Not 100% sure that the explanation of diff3 vs zdiff3 is correct
 * Right now we're listing git merge, git revert, git rebase, git
   cherry-pick, and git pull as commands that can cause merge conflicts. I
   believe that git apply and git am can also result in conflicts when
   applying a patch, though it's a bit complicated because applying a patch
   is a different operation than doing a 3-way merge and the tools available
   for dealing with it are a different. My thought right now is to avoid the
   issue of applying patches for now (because it's a whole can of worms) and
   instead just try to not imply that this is necessarily an exhaustive
   list. Also if/when the git rebase --squash changes land, then we'd need
   to add git history to this list.
 * Instead of creating a new page, I considered using an include to have a
   "handling merge conflicts" section in git rebase, git merge, etc. Merge
   conflict resolution is complex and it's very useful to be able to include
   examples: this version ended up at ~300 lines and I think that's too big
   of an include, especially for short man pages like cherry-pick
 * Explaining what "ours" and "theirs" mean was one of the hardest parts of
   writing this. From polling Git users in one of my many informal Mastodon
   polls about Git, my understanding is that Git users are actually
   relatively unlikely to actually reason about what "ours" and "theirs"
   mean when dealing with a merge conflict, and that most people prefer to
   get more context instead, for example by using a mergetool or by using
   diff3 or zdiff3. I heard a lot of "I can never remember which is which I
   so I don't even try". So I put the information about what "ours" and
   "theirs" mean relatively far down the page (with some cross-references),
   so that it's easily available but not the main focus.
 * I removed a couple of mentions of the various _HEAD references. It's hard
   for me to know exactly where they belong because I personally have never
   used MERGE_HEAD, REBASE_HEAD, ORIG_HEAD, CHERRY_PICK_HEAD etc, and I
   don't know how they're meant to be used. From some quick unscientific
   polling (at https://social.jvns.ca/@b0rk/117320011885941855), it seems
   like most Git users have never used them either (and folks who do use a
   *_HEAD reference mainly seem to use FETCH_HEAD which isn't relevant
   here), so from that perspective it seems important to avoid emphasizing
   them too much. The git revert man page doesn't mention REVERT_HEAD and
   git rebase only mentions REBASE_HEAD in passing. Of course they're all
   explained in gitrevisions(7) which might be the best place for them.
 * I'm still not sure what the SYNOPSIS section is for in a "guide" man page
   which is not about a specific Git command (what is the user intended to
   use it for?). I tried to leave it out but the CI said it was required.

Thanks to Lobo, Adam Svahn, Louis Vanier, David Turner, Ben Zanin, Salih,
and about 12 others who gave feedback on both the original git merge man
page, as well as the proposed improvements.

Julia Evans (7):
  [doc] Add new gitmergeconflicts man page
  [doc] git-merge: link to new merge conflicts guide
  [doc] git-rebase: link to new merge conflicts guide
  [doc] git-revert: link to new merge conflicts guide
  [doc] git-cherry-pick: link to new merge conflicts guide
  [doc] git-pull: link to new merge conflicts guide
  [doc] ignore conflict markers in gitmergeconflicts.adoc

 .gitattributes                       |   1 +
 Documentation/Makefile               |   1 +
 Documentation/git-cherry-pick.adoc   |  23 +--
 Documentation/git-merge.adoc         | 125 +-----------
 Documentation/git-pull.adoc          |   3 +-
 Documentation/git-rebase.adoc        |  13 +-
 Documentation/git-revert.adoc        |   5 +
 Documentation/gitmergeconflicts.adoc | 294 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 9 files changed, 320 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/gitmergeconflicts.adoc


base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2237%2Fjvns%2Fmerge-conflicts-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2237/jvns/merge-conflicts-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2237
-- 
gitgitgadget
