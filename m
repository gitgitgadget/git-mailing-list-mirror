Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2262AD03
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171958; cv=none; b=kPZX81HRcS/JW6TP9utkDpmehMxn806U/R4rukqqHgZSdQgJ67pBWTWb3k07WR4roQQ7BrwrIc2QX3r1co9nN2djmkDI313OoLOwWMi6+QMVQFbzxJGpUtRukRuoqBMvYe3Q/+ZND21JRK6YRqwZe3GY44tbIXA1HDU2ZD1iNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171958; c=relaxed/simple;
	bh=uA64la/oTxA1FXrGNgAeAORAT3CbCSmKi1PNO1u0q4I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=s4gt/5DLlAaMR3oRgiQtOgN4+LihV2ZRCErr9IJMItEJ6cnjWS+OYw2ijssemRO7Tahn/dsgpELNVUO/kU0F+P/GHmNRJV1awYdrW2J1FcrCxvLr20pbi2j6XiVtck2+JreYOmacsuzy1zj44j0WHy0AQeEe+4ZflgQjLbgMooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ckgl1xpK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckgl1xpK"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1579888a91.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789171957; x=1789776757; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z1TYzfBdbvhws2RYf8Wzpirx6yvCP/zCwes/ecC3R+s=;
        b=Ckgl1xpKyvFdM0Mfypr4BgMWsZk5v94Nze2fXQuOrrl5EHSPIWRA9X+4vzAdTUFUNw
         u+EtmGh4eBWFwZeOlJIJd8cIMxKZCe1rG9hrnlYoPCQB8HypIjK3FvK1CD+LPiNSvjvV
         4/YHmCvOCMtMoI3ioBd1Wmdw5nyLqryqwuzBwNkGxj0SSVs4ckuNPy7qO4W7VAwMOss+
         Ca+ceD/P8zQSaiYt04/lEHsDwzf01VDECecmEnjbeDW1wKiz7Wst7EVANpvQMtXBADNH
         jM2TcrKHCxRZR/KY0MgvfXT2GsWp/O5SaLP/NxQ0Hp/2/berWbA6yVIGwbsprkIzKBbk
         ieIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789171957; x=1789776757;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z1TYzfBdbvhws2RYf8Wzpirx6yvCP/zCwes/ecC3R+s=;
        b=NtO+MqZftMuE8fOHv3n4yz61S9Ju/5eWXh0xUARjc9bB8bgQ0xXWLspOhalCuPvPTQ
         cXDMxpbnMW9FSrtfK9qy90JV3e88h/lrOPjofxBj03jlyAcByYtYt9x28Un+EinlhkV0
         7iBs7msIVNXVqkRX6xKF/n5+bU8v6bAYm/hHLoi/6LP2P2LugsGTSI4paJ0vlKVt8SYC
         1o+rjAoldW5aQhAQGS3njg3c1a1JFJ06CZvWuqgA/mUEJkLcoEoVLl5ICvIBqR5/Udye
         +yXk3B8XpRJ/M31nhc9lNFAEWFIsRODcp5AxeQdhAGNd0v71tlnPiYCB+LXKB1BgQyQ+
         Qyyw==
X-Gm-Message-State: AFuF++k+IjzeaGoU79BFoYGUxRJMECOS1jYY+q5Ms370WeKCSqDSiNaD
	s4Ns1zA7yrOVvJ7msdsRNUk2WujYNg+m5VjRFJ1EOwoDiTQbCiTbKioNyEoYdQ==
X-Gm-Gg: AYBFou1RSNuNYfQQdFCk//2Ys2CXewWP3Or/8HhaVvGnOES2F4Nz3qc/nY3I17tgVHL
	o7P3slx3EHXO51LQ3O2GSKxvN3b3xjvuDTZJvSKQFirr8jmjiFAFt8+3ZIgdgyxVzrxHBmgU8AU
	ACAnTeUPExRj4M27rjHDHl1irqZN6WNF6g/schddsoKiav/oGq+hdjZ/k+/SNTlROPhJcqRMPXx
	dmz3Z0igFV/QTERR43eDiS3C5/rDsntpG5hKUSKQwc28NqnAMFj4eg9VMsLqP9AU5rh2f1rkrwj
	WUOaLiXbewZerunvy1MvPaYXDEZrWWmwnXh5gotcYFcRoAvLGt0BWGthHk/I4O+IkMzaCeWLbCC
	/M1Sy6OxXvdGYH40kwxLAgUHjRdCGgalHOJ90b7dr7VyayKHihcejSwKurJ4LSkR9BXYUIl3NKB
	9IuPq/Ci9P7JYFtS8bphgovxA6mtnWNp67xYjHsMFyeIZsqTLMw7IATbO5/57QRgFNE0Q4cVT2
X-Received: by 2002:a17:90b:5887:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-39d9c1b60damr8928942a91.13.1789171956640;
        Fri, 11 Sep 2026 17:12:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.94.28])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ee07f2sm8486800eec.18.2026.09.11.17.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:12:36 -0700 (PDT)
Message-Id: <pull.2218.git.1789171955370.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Sep 2026 00:12:35 +0000
Subject: [PATCH] completion: complete 'git worktree repair'
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
Cc: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Added completion support for the 'repair' subcommand of worktree. It
optionally receives a list of paths to linked worktrees or paths to
worktrees with broken links.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    completion: complete 'git worktree repair'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2218%2Fyoichi%2Fcomplete-worktree-repair-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2218/yoichi/complete-worktree-repair-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2218

 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f8b9b50ff..c3a49e2e22 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3816,7 +3816,7 @@ __git_complete_worktree_paths ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock move prune remove unlock"
+	local subcommands="add list lock move prune remove repair unlock"
 	local subcommand subcommand_idx
 
 	subcommand="$(__git_find_on_cmdline --show-idx "$subcommands")"
@@ -3866,7 +3866,7 @@ _git_worktree ()
 			;;
 		esac
 		;;
-	lock,*|remove,*|unlock,*)
+	lock,*|remove,*|repair,*|unlock,*)
 		__git_complete_worktree_paths
 		;;
 	move,*)

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
gitgitgadget
