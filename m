Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468594A68BC
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843064; cv=none; b=IfK/QUpvh6aNnlk1aSW349+aJc/GSDh6Ng7vxqe75crByF1z8zNV2ywavRvCDBb/SK/yg7avkW0IOSEm9b0C3hClF4tbPx+bI6xdGRO/Hzh529t2I/+o2XJiJbjEFKwpgavP8fXX0mcOBqopWHpuj1QCCzxZFTggfWnL9e/qyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843064; c=relaxed/simple;
	bh=UyKwDYXJrNJx3yRuu/yZqT3SvRtRBDgwkR4+tAxcbKg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BPCXmwgr5X3Kr1W0wY0EeuyQRlrxGnEeeI7axJJf1QnrN+LvPrrZ4s1UDYVS2G0o0/qr66T9HwIX47dR67n2LspA+bYuv/2yHzSSAdPs0MFG2Dneiv+7/Tb4UmrF9h4cixIjkp2fYorVXIVpp1I9R9DP6wW7p7ElAK7vPB0Ll58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAWnTIuE; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAWnTIuE"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91784fbb60dso30550006d6.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790843058; x=1791447858; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dbhuXdMnHAC6q5Ax6Eh5X44nRrM2QeSOVcVuaW/NQP8=;
        b=PAWnTIuEhHsUD8MWNmM4kV4JKF9y9vxSvJJ6uSdBdc7bsIIGl1ClSKVSyuy06oHqHn
         GZa0wxLO37xBflzuiYOMnB/IlrsN94WIQLYE5ZG5zRBT6Rir5ZBzJdpVCunVcdXuUUGp
         LVj2V8vBrQjcO7EOYoxd6lRjRE1UuL6ijv0ua9u2SAOfj2gDK77etlKNbo8v3vHyO7i7
         NzX6Eo/szE7GfoIVTk5PcC6ecfiJwWBpmHbWXofARXyxQWPtM9LcnsbgeVhI9rkuxHKL
         HcpuGQhI3R4xg3P7EDMhPNecB4Eb2iH/w2usiQ9YT2/nJc5VV3tQboZvqrCxYruyuGsE
         +RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790843058; x=1791447858;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbhuXdMnHAC6q5Ax6Eh5X44nRrM2QeSOVcVuaW/NQP8=;
        b=tJ+mT+U7su15F6nWxKJPXaX0bdLD/aeArb9duqccp9I8SftKqdDDMfnQm7u3fXtYoH
         DcKdeyidmRAYaLS90c93WPrNHoUGB9JcvDOnG/m8or9Xje6mlGvZZWnmdsIHJlNmLu5e
         kovsF/Rmge3a3Z+UFjAeGsIFKkhCLEEAaiBazBSBwa4seCGjp2aFfLRG3Pq3ZMVd2T1k
         ZGi8CZwT8S6OfkOJbo5FZFvWvBGukZqMabqJ1xzgy2k73O3fiFrgp1lbYwaQpQ+BHHEb
         B4fSqKFzfbscrLncrPLbbkHyo+Ip9U2SRZq9LC8a0jnKJEbwlH6L/jCRLaRucmF0oozq
         SxSA==
X-Gm-Message-State: AFuF++nGhMr6isAzeO2/YEhcQOOWq8Ivpo9o0wRlWLxVr0NX4YHHMZ4I
	AkEtcu9mY3ufSfN/7nwb+NmsOCKO+CkliR9+q7zcxq8TBKbAPlKWSRR0PM8x1w==
X-Gm-Gg: AYBFou3j8k/5w5MSVpMQGqvugJkVoJRJiodSW/5zUE/RS5/M+BAuydNEYn1bOH5gXXY
	q26ktekPOlxzOR5YY9LBrn7ip2SEBqjc3RQBAN9Cqgk3T+TljA+k3QFsEe+VDFwde0QYkuqgd8H
	zBtG7v4xgrfmumiIUXPHbiNtM7pY9LYzemsD4v66JikWJpy+AOjBpPkZYfM6LJOXl0R6kDiQ93/
	T0WfNVZWwEeWzKM/E62ujE58ywuCTz+jQng6qIo+6Vt3MRjQcQjRf+fgp95pyBziBlRxFIp+60f
	RlWu/D4hRr2s5KWkgDYa1E33C1yCNrKwLP67WlaSDNv21eA9HY/LA4xCFSSimNu9k09De8gTpsM
	1ZMnxHz3/yauNjilXhspSqF8e5vxXbuCqe1tteWCV3Fwi4+Mri4HUdIp3J5vuELvOYdGN7xeFRO
	Z53vI4Uwo4vXzKvmV9DL2saaRhSemY1UK0AZ8KsI7xS0ixnx7F81MrL+HwM51vYg2xCXW6lhs4f
	w==
X-Received: by 2002:a05:6214:3981:b0:914:3cd3:a1a9 with SMTP id 6a1803df08f44-917a0b30653mr78287836d6.12.1790843057972;
        Thu, 01 Oct 2026 01:24:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a5bd54sm20194446d6.39.2026.10.01.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 01:24:17 -0700 (PDT)
Message-Id: <pull.2243.v3.git.1790843056949.gitgitgadget@gmail.com>
In-Reply-To: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Oct 2026 08:24:16 +0000
Subject: [PATCH v3] t5520: don't expire reflogs where it matters
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

"git merge" saves any uncommitted changes with "git stash" before it
tries a merge strategy. When the strategy does not handle the merge,
it restores them with "git stash apply --index". If some of the
changes are staged, that runs "git reset", which writes an entry to
the reflog of HEAD. The tests that pull with autostash disabled run
eight such merges, each with a new file staged.

An upcoming change makes "git stash apply --index" merge the index
in-core, so it no longer runs "git reset" and those entries go away.
Another makes the default "merge" backend of "git rebase" run auto
maintenance when it finishes. Together, they change when auto
maintenance expires the reflogs.

This means that unfortunately the reflogs are expired at the end of
"git pull --rebase" in the "--rebase with rebased upstream" test. The
"git pull --rebase -f" in the next test looks for the fork point in
the reflog of refs/remotes/me/copy, but as the test suite dates every
reflog entry to 2005, the expiry has emptied that reflog. Pull then
finds no fork point, so the rebase also replays copy-orig, the commit
"copy" was rewound from, and it conflicts.

Disable reflog expiration in this script, as ea7d894f44 (t34xx: don't
expire reflogs where it matters, 2026-02-24) did for the rebase tests,
so that the test no longer depends on where the expiry falls.

Reported-by: Junio C Hamano <gitster@pobox.com>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
    t5520: don't expire reflogs where it matters
    
    The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series,
    bisected by Ben to tb/rerere-lock-grace and taken apart in the thread:
    https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com/
    
    Changes since v2: only the commit message. I had the eight merges in the
    wrong tests: they come from the pulls with autostash disabled, where
    "git merge" stashes and restores the staged file itself. I also dropped
    the clause about the hundred entries and took Phillip's opening for the
    third paragraph, all from his review:
    https://lore.kernel.org/git/8b81c508-ac67-498d-b78f-a4b5dab8c198@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2243%2Fthomasbachem%2Ft5520-reflog-expire-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2243/thomasbachem/t5520-reflog-expire-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2243

Range-diff vs v2:

 1:  6699f3782e ! 1:  be6c3f21c5 t5520: don't expire reflogs where it matters
     @@ Commit message
          tries a merge strategy. When the strategy does not handle the merge,
          it restores them with "git stash apply --index". If some of the
          changes are staged, that runs "git reset", which writes an entry to
     -    the reflog of HEAD. The autostash tests in this script run eight such
     -    merges.
     +    the reflog of HEAD. The tests that pull with autostash disabled run
     +    eight such merges, each with a new file staged.
      
          An upcoming change makes "git stash apply --index" merge the index
          in-core, so it no longer runs "git reset" and those entries go away.
          Another makes the default "merge" backend of "git rebase" run auto
          maintenance when it finishes. Together, they change when auto
     -    maintenance expires all reflogs, which it does once a hundred entries
     -    in the reflog of HEAD are due to expire.
     +    maintenance expires the reflogs.
      
     -    With both, the expiry comes at the end of the "git pull --rebase" in
     -    the "--rebase with rebased upstream" test. The "git pull --rebase -f"
     -    in the next test looks for the fork point in the reflog of
     -    refs/remotes/me/copy, but as the test suite dates every reflog entry
     -    to 2005, the expiry has emptied that reflog. Pull then finds no fork
     -    point, so the rebase also replays copy-orig, the commit "copy" was
     -    rewound from, and it conflicts.
     +    This means that unfortunately the reflogs are expired at the end of
     +    "git pull --rebase" in the "--rebase with rebased upstream" test. The
     +    "git pull --rebase -f" in the next test looks for the fork point in
     +    the reflog of refs/remotes/me/copy, but as the test suite dates every
     +    reflog entry to 2005, the expiry has emptied that reflog. Pull then
     +    finds no fork point, so the rebase also replays copy-orig, the commit
     +    "copy" was rewound from, and it conflicts.
      
          Disable reflog expiration in this script, as ea7d894f44 (t34xx: don't
          expire reflogs where it matters, 2026-02-24) did for the rebase tests,


 t/t5520-pull.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 27f38ab3c8..bc818605a5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -35,6 +35,12 @@ test_pull_autostash_fail () {
 }
 
 test_expect_success setup '
+	# Commit dates are hardcoded to 2005, and the reflog entries will have
+	# a matching timestamp. Maintenance may thus immediately expire
+	# reflogs if it was running.
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	echo file >file &&
 	git add file &&
 	git commit -a -m original

base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
-- 
gitgitgadget
