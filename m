Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449F2C08CF
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551490; cv=none; b=Kze5XbR83KKRJrc8UM8TLUA9buRwoWdMNfA9D3o0DoKCaureb81ETujBoS/+1pBv8K7utIfIuZrLbTivYT0Oy4ILKgrQwtTvV4WPlO2+Q9TUJYE//PPvy0UsdBR5RfZS4ygl8icdowmTMJ7d1yoj2T7O0Yum9us/c8DnBZPHuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551490; c=relaxed/simple;
	bh=GUmIsLqLwE2xKPe0pubAeJN3FfcuyYHwut75JeBop6I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N/I4rBMtE6GN8+fJ/g7DcadkRmMC42s3AGcagxoMcI4LJiu5pdU+UKe99u8bWNv2ykDV6S5viUx0mBsTdcXE3aT5PVvzszQYiXKM+Tl+DiWDzzVtT2S/iV27HIxvONH/E6xSI3cqAYGMvvibsKR89/QQfZKY+UU+0E+mTIBMF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrNh+chZ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrNh+chZ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e55db58cfso570938085a.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791551488; x=1792156288; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c+sNHnw/KTImI6nmVXHj2a3Zl3Ttlq2io6qPn/hWlSk=;
        b=nrNh+chZcyMYFTq2jyfCfL62BSqYPaCZ9deocFmmOGikgYycx99Ggxmv7SAZ2/qpLq
         qRyry0nGypFw7glmm/zsjAvnqsNM8TgU65+I1g0KHMVsltGA4L8gaWeH7jZZXqayrE7z
         dgBCOG9AZJ7YS89LLy84zwxlXKIlv320VYg/PY5it3yeXOFtWqdkehA6Z2xbDqecOdky
         9Z1pb7IjTRIBCCwTUMnCNdU91UzhjcSKzXdTegiF16jV+BtirbGa/A5fLC7kulaqOaYR
         CUcWiSdFHKob3clMXTXBYH1By/5UXseH6V/KIFWWvjhRjYh9QuFmwRnmuPDaVQbmGD9x
         Y9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791551488; x=1792156288;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+sNHnw/KTImI6nmVXHj2a3Zl3Ttlq2io6qPn/hWlSk=;
        b=FxKkNPA/bYtzR/PGV2FoHSgF+5ikacybROxPBLo0s48kVHsO9l6jcgnuls8l09DJ68
         PhaxVXWRWP2SY3xN7qPfrfMouIfwCeCXDVZ0Vb2YYYvIj5dM76n77j9P6OHt2bYk7TLv
         wE3SvIU1zjAFl/44fyJyx+QVnyRFkRX5A9UWAgQ0EpIMC5YzNGpBYW0P7c47/22TrFUp
         g6Rd4EcN9SUiGPdCjTw2RXNHqcWZyuE0ugspRp+kv4/ADrjyQarlfO0OZxlA40xfOqrD
         Xnc+BdIET5kQ7MD6zXPyzjSn+IOpktQHanBkU394aCXxqfXfm38CiNp6l9ZJ571w6biF
         jqyA==
X-Gm-Message-State: AFuF++lf2diTZ1nq0XM9irrA2A9/A3E/hhJdDNiJZeIsroY3tuto12Rh
	cN4QayLItFiHun9dHt85ON69lEeQxnRaml03ntva4jx1TPKLfAlA0qUn9ud3eg==
X-Gm-Gg: AYBFou0+4ugT5g5pvyx/540jzC8u2ZEkc6SATZO56BpvRXMjw9qD7BvZzxQP78LvuBW
	7k34D4aQbZEvKXhmbTrppF/s+219i4DsKEF6CFadGTkEu6QdReXsr78Fze4NT9SEjftTn3pnISR
	iSehYZOU9yVp8QNi7m4pdUP2YtIMCFm6gp0s0aavYO8YD2uvwbaLR9jiP1XZvGcYwojDObt86KX
	jEtgBrdsf+Ntefpo5UdWmEvos3wTUHY5/P/rYCoX/crnrMp9CKSK80u+DQEoEVB6W6zkhzglDAc
	elwWsrJUtt+Pi11gEhPUbNAhsGB3B/ha1f9KouwOE7T28no8y9aPdRBm2NcwdoMudlHbJJnlmyY
	WsTTbli8/n/K/OXoKSWa4rCXf/PQQpSzs1Aq/VZQHs/2ywJv7lVF63DnVbyBuEH5n2PgTJ9CMm+
	dwCdsNlxaEaK8a+ZTR3mDnpnD+u7cf9Ce3NqrfAwwfTRqkxNgfas/Fk/c39FfigAq+yPE/aNLsA
	Mxx
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:9b6c with SMTP id af79cd13be357-93ec12c9f75mr141722285a.71.1791551487530;
        Fri, 09 Oct 2026 06:11:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.237.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c0c4sm181712185a.18.2026.10.09.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:11:26 -0700 (PDT)
Message-Id: <pull.2249.v2.git.1791551486318.gitgitgadget@gmail.com>
In-Reply-To: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 13:11:26 +0000
Subject: [PATCH v2] status: suggest `git merge --continue`, not `git commit`
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

During a merge conflict, we suggest using --continue to continue the
merge for rebase, revert, and cherry-pick.

Change the `git merge` advice to be consistent.
Commit 367ff694281ce569edd8f6e444fc770f92f5d215 says that
`git merge --continue` is intended to be a synonym for `git commit`,
and the `git merge` man page already suggests to use
`git merge --continue`.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    status: suggest git merge --continue, not git commit
    
    Changes in v2:
    
     * Use git show -s --format=reference to format the reference in the
       commit message (thanks to Phillip)
     * change to "conclude the merge" (thanks to Phillip)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2249%2Fjvns%2Fadvice-merge-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2249/jvns/advice-merge-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2249

Range-diff vs v1:

 1:  551b0e79b0 ! 1:  afc69ffeb8 status: suggest `git merge --continue`, not `git commit`
     @@ t/t7512-status-help.sh: test_expect_success 'status when conflicts resolved befo
       On branch conflicts
       All conflicts fixed but you are still merging.
      -  (use "git commit" to conclude merge)
     -+  (use "git merge --continue" to conclude merge)
     ++  (use "git merge --continue" to conclude the merge)
       
       Changes to be committed:
       	modified:   main.txt
     @@ wt-status.c: static void show_merge_in_progress(struct wt_status *s,
       		if (s->hints)
       			status_printf_ln(s, color,
      -				_("  (use \"git commit\" to conclude merge)"));
     -+				_("  (use \"git merge --continue\" to conclude merge)"));
     ++				_("  (use \"git merge --continue\" to conclude the merge)"));
       	}
       	wt_longstatus_print_trailer(s);
       }


 t/t7060-wtstatus.sh    | 8 ++++----
 t/t7512-status-help.sh | 4 ++--
 wt-status.c            | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 942ddbbf0e..a9b435b5e3 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -37,7 +37,7 @@ test_expect_success 'M/D conflict does not segfault' '
 	cat >expect <<EOF &&
 On branch side
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -141,7 +141,7 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
 	cat >expected <<\EOF &&
 On branch main
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -174,7 +174,7 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
 	cat >expected <<\EOF &&
 On branch conflict_second
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -198,7 +198,7 @@ test_expect_success 'status when conflicts with only rm advice (both deleted)' '
 	cat >expected <<\EOF &&
 On branch conflict_second
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Changes to be committed:
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index aca4b6d332..f2e712ac39 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -31,7 +31,7 @@ test_expect_success 'status when conflicts unresolved' '
 	cat >expected <<\EOF &&
 On branch conflicts
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -53,7 +53,7 @@ test_expect_success 'status when conflicts resolved before commit' '
 	cat >expected <<\EOF &&
 On branch conflicts
 All conflicts fixed but you are still merging.
-  (use "git commit" to conclude merge)
+  (use "git merge --continue" to conclude the merge)
 
 Changes to be committed:
 	modified:   main.txt
diff --git a/wt-status.c b/wt-status.c
index 57772c7501..238bb48643 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1273,7 +1273,7 @@ static void show_merge_in_progress(struct wt_status *s,
 		status_printf_ln(s, color, _("You have unmerged paths."));
 		if (s->hints) {
 			status_printf_ln(s, color,
-					 _("  (fix conflicts and run \"git commit\")"));
+					 _("  (fix conflicts and run \"git merge --continue\")"));
 			status_printf_ln(s, color,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
@@ -1282,7 +1282,7 @@ static void show_merge_in_progress(struct wt_status *s,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
 			status_printf_ln(s, color,
-				_("  (use \"git commit\" to conclude merge)"));
+				_("  (use \"git merge --continue\" to conclude the merge)"));
 	}
 	wt_longstatus_print_trailer(s);
 }

base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
-- 
gitgitgadget
