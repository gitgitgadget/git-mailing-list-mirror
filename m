Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401BC1A08B1
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181409; cv=none; b=acJKy+wipkj3HSCS4q0XohdpSata730ap695q5rO5dnEIqsBNwd9dPEnBHUfNOTp9UEsB9S2lfcHSK3jMoQv0wHsByrmXEGBLUqlz2lOYXJaPsZpw74Ax6MR98ExUHyV4q0sNDfbrXNEs/iARA8aqTpScWg6GTL+tPWL4nA7r5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181409; c=relaxed/simple;
	bh=qXedR5B1PsWSLg5Y/zRc1fb3T0XDloxD+aOIBnvsvQM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iHbFBZARMFG71rtaqqdrQVp1Ry69Ph7KCmAaRtZO/AdVgO1YE8giGzKn4o2SgfRvA2Tr9oIKTAmrcnJ5TjBzSxtlRj+QvOgXClWVXCXw256BGm6l+Ye/ijBWacV5pzlsdVgo705supc3ePaCBnhRxcEr8j0xGdcmeLhlqHs3l1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUTY6tGc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUTY6tGc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so19275715e9.2
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181405; x=1743786205; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6E3s83jH4uJYUhqQaNk5TKnFMkjYF9WLce23Lj6egg=;
        b=MUTY6tGc88Ssv0sJq6e8uQlMGe/tDb4dcABwW0FmkpJDER/mIo/86pPOufd5KiQlT4
         CNNGi2CGtEUQhOTciP36Eq49hqgiBuB9fWE2lwuARkbtXecYVj7BJDQk9vaR/hZ3zwUl
         6gHmY9AYV5Lz2oQxa8pZ0SygAmxLPEOVjgdZEA25ZjH4giv/MIokGeK4NLUGMPHxDu3m
         kqxZmaidqeqhha2wgWIltoyZ8bXfpzGROb9NYE43jQKXtakCPqSXE4CNXRXUXnXhi6bW
         MAOhfa6fDnKgRmTGBiifaQcZLvTZodi53/diAp4nA7yZu4K4TPLzgDjMA2fmKgrZp9qT
         vegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181405; x=1743786205;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6E3s83jH4uJYUhqQaNk5TKnFMkjYF9WLce23Lj6egg=;
        b=fTlKkcfOlLiqXkd5P7Daw2jyufBLMQtaysnKnYD1DO2Ig1VERY6AOzx+OXiw618kQG
         nfdCULDQHHQz6Vq1tVSsnZjJRYp/AXy4szM6oZTHIA5UTrT7BFdCPLe10Kl3el4heopA
         CIKtFy6A24NRsHkvMIzqFx3g5FLc3EW9oYjon1WbD55JAgnbfkIlzmiLA0y1VJ5qcx2T
         kPvqBzRp5vG7k843ey0q/WuArh+wgk+2I/xIrno75yDbDGO5ZYhJMltQfQDtndsZTA37
         wHk5wLGQU3U/MyIaxOhGlo/8svvtLf27XPEZ1aPAsk9Yx8djYc9mP7c3euSytHmUlVCk
         N9nA==
X-Gm-Message-State: AOJu0Yx5RwSUeqWczOxS0TY6oujcQcruujOl+12CJTbrR4qCDP3ustbT
	F9B/y/PGozMyW1OyBDx/l1T8UQYskbE7q4mplGyh0ZxEHd31cmpAUKQahQ==
X-Gm-Gg: ASbGncvEBgSDhyF7gM+s0A50W1rSamyI7tYnLM9dbUC6T76M8gxHziwF551h+bKamag
	SltlgFgXDZZC4hs5CK9w9HMOBP5ueVms8T2lA2GJPC3IARfRmWRw5z0EomDBAxcCD3Mjd42HPbs
	kugFm1fYAybpaBoWRABq74/5JGzU/4L3jK/Q3A1xYImm9N82rXsbeoK3eS+wFp5JHics9wI5E7M
	PzKbTpWRLvIa9bqRhx2v/ERBF2Fd8dHjXgyk0Ef8s/yghTl38r46EFtIY22ErbjR6EnFdJYF8pV
	U6Sr0rZfzCix8P72hIgoKBMIN+gMwQ0mmjgFFiamXW/hpg==
X-Google-Smtp-Source: AGHT+IHa2KnppQY4juMZMUxHogLqBV5310vupg3GL/vz7DuY9pjCgqMd4GWDn2gKLZqQkPN37RNTiw==
X-Received: by 2002:a5d:584a:0:b0:391:41c9:7a87 with SMTP id ffacd0b85a97d-39ad17988dcmr8375084f8f.51.1743181403803;
        Fri, 28 Mar 2025 10:03:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02f9csm34057795e9.26.2025.03.28.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:03:23 -0700 (PDT)
Message-Id: <6c8f77cb71c7e0c820704b1725331f4601d8876e.1743181401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Mar 2025 17:03:19 +0000
Subject: [PATCH 1/3] rebase -r: do create merge commit after empty resolution
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

When a user runs 'git rebase --continue' to conclude a conflicted merge
during a 'git rebase -r' invocation, we do not create a merge commit if
the resolution was empty (i.e. if the index and HEAD are identical). We
simply continue the rebase as if no 'merge' instruction had been given.
This is confusing since all commits from the side branch are absent from
the rebased history. What's more, if that 'merge' is the last
instruction in the todo list, we fail to remove the merge state, such
that running 'git status' shows we are still merging after the rebase
has concluded.

This happens because in 'sequencer.c::commit_staged_changes', we exit
early before calling 'run_git_commit' if 'is_clean' is true, i.e. if
nothing is staged. Fix this by also checking for the presence of
MERGE_HEAD before exiting early, such that we do call 'run_git_commit'
when MERGE_HEAD is present. This also ensures that we unlink
git_path_merge_head later in 'commit_staged_changes' to clear the merge
state.

Make sure to also remove MERGE_HEAD when a merge command fails to start.
We already remove MERGE_MSG since e032abd5a0 (rebase: fix rewritten list
for failed pick, 2023-09-06). Removing MERGE_HEAD ensures that in this
situation, upon 'git rebase --continue' we still exit early in
'commit_staged_changes', without calling 'run_git_commit'. This is
already covered by t5407.11, which fails without this change because we
enter 'run_git_commit' and then fail to find 'rebase_path_message'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 sequencer.c                |  3 ++-
 t/t3418-rebase-continue.sh | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..2baaf716a3c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4349,6 +4349,7 @@ static int do_merge(struct repository *r,
 		error(_("could not even attempt to merge '%.*s'"),
 		      merge_arg_len, arg);
 		unlink(git_path_merge_msg(r));
+		unlink(git_path_merge_head(r));
 		goto leave_merge;
 	}
 	/*
@@ -5364,7 +5365,7 @@ static int commit_staged_changes(struct repository *r,
 		flags |= AMEND_MSG;
 	}
 
-	if (is_clean) {
+	if (is_clean && !file_exists(git_path_merge_head(r))) {
 		if (refs_ref_exists(get_main_ref_store(r),
 				    "CHERRY_PICK_HEAD") &&
 		    refs_delete_ref(get_main_ref_store(r), "",
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 127216f7225..f4b459fea16 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -111,6 +111,30 @@ test_expect_success 'rebase -r passes merge strategy options correctly' '
 	git rebase --continue
 '
 
+test_expect_success '--continue creates merge commit after empty resolution' '
+	git reset --hard main &&
+	git checkout -b rebase_i_merge &&
+	test_commit unrelated &&
+	git checkout -b rebase_i_merge_side &&
+	test_commit side2 main.txt &&
+	git checkout rebase_i_merge &&
+	test_commit side1 main.txt &&
+	PICK=$(git rev-parse --short rebase_i_merge) &&
+	test_must_fail git merge rebase_i_merge_side &&
+	echo side1 >main.txt &&
+	git add main.txt &&
+	test_tick &&
+	git commit --no-edit &&
+	FAKE_LINES="1 2 3 5 6 7 8 9 10 11" &&
+	export FAKE_LINES &&
+	test_must_fail git rebase -ir main &&
+	echo side1 >main.txt &&
+	git add main.txt &&
+	git rebase --continue &&
+	git log --merges >out &&
+	test_grep "Merge branch '\''rebase_i_merge_side'\''" out
+'
+
 test_expect_success '--skip after failed fixup cleans commit message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b with-conflicting-fixup &&
-- 
gitgitgadget

