Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DB440A3A
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395309; cv=none; b=an+d76HpKNHdpb6YfSY4NNh72BbA5BfBRnJ9b3tLKUhREKjvO2Bxl+7Fq7tIOeL9pZtVeimRPLzAs3ZYFFmGLu6MUX7WsfShrBUSfQ6N1X0Xcr1V65ESSZYoErJ6q3giIhzTteqvv4HaM7aedXQT6M4HSspLyR1eGYpYBMsCbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395309; c=relaxed/simple;
	bh=JT65yxbgcHYfxxUtv9l17oqH4U9WLSDZSqD1V0ZPg4g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=anrW2qNbg1QJMBIHb4PIjJ/LkhfH4aLinKJIa2SA1aAoa5JoTjWFO7egBWFVgMAtgPTJnecgjqjq3cxzpZBM/vPlh6/CMiwHJrkaeh/r8qTouynYgj7/cVSvEHTnueAn/JY6S5xG4jE4hTH510bFouN0Fc5QEURr+rAft3H7/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGOx58ss; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGOx58ss"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2299356a91.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786395308; x=1787000108; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZfA7eu30Ywj6/Zx4i80Sm3J+YHj1dOAFGG+qvBl7xkM=;
        b=dGOx58ssRVleHjxZNxole3eFcYIqEVIb840wW5aZFgWIJUV4JkEcKHfLZqAMJiXwOs
         odI45Idcttr7k+RHnaKW48OvSMcqPgjBPEIsXlIr4RTvyPo6e+mna3W4o6rQCLw7+mMr
         RSpqE027+/nEvzr8WqD46oJL9gBrWsxdIGLa5TxrbV8kT5pczKLNHmb8N3sg9yyBlYnl
         X2ikxuEWgDwTcQNjDPJiTiIXKdBV+/4C4nriJzn07FjdVjJn/haZKmbJhOYJWNF4/dM5
         4fI6aBuQ8ePZyeJLMMNctGem4/n16cYI9UQfEpdLMJeVlh9PHOdOPv4Ry5vS9jPZrFO5
         tKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786395308; x=1787000108;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfA7eu30Ywj6/Zx4i80Sm3J+YHj1dOAFGG+qvBl7xkM=;
        b=sQITd/+4QfH7DasqeFM1NMHrzl0Hi0pcq7tviM5SAzdRJ0x9n5iVIbxe3JX4br42u8
         t908jb3BbLm0U2xh/in78UjlJqCflsbxJL3Lggkhv3FOAqnAH+1t7G0VcIob/hyIwqUs
         hg5jTxadqOrJ6YRiYao7z7v10Ff1OuaKzqIhRDHB4PzyagR1yoeHUKDnlWduODnnB7ly
         ASh/qN8eVoS5z420+eb67DztRZuffUvQ2SlYaBQW3WKr6H7037EvLkrbSoKbV+ks2404
         x755KTkfFiu9nQHA3nbATGpfbHDJH+Xbi2kM0mpS8J+IHc0QG3QnbZkJYEmw8C5vPME1
         B9KQ==
X-Gm-Message-State: AOJu0YyfyLRSjDUR2U5+TPFHLAzIbni0qeWRd4vHf4G9cXIueLU2lapS
	tAuGcAGccsJ3FsHz8SN1XuzahfKdST3Owv7CZBdrMyq1B/osfL3mER9Ul3ILVw==
X-Gm-Gg: AR+sD13f3AqR10uLhw+GEPCvHbm5LBuamb5BwJCNExHv65T/SQTAWOnmX5HWklZx/On
	93QMJMOST+a21uobdDQPTPSPSJn403L7bbpArTBnNMykZbIbrNIJAddl4W2rLYNHKQQMk/ygtqY
	iz11UA7JGa2WfiehUYu7ZIKY46Zc36iA37si+k5WoVyXuxOj94gqzBDzhwfQHOkgOdeiFMsf/8j
	UiNaER1gHGjF73AKm2PWFoAvLKMUUGZPEtCCPMHGoUzLohArWcMFhs0//Ri0Dq0UhhM0lD+QjqR
	Xpkc0GldIjEmAI4q/Qh2BaIP1GSrm5Up8pxnT/JnwGDJLH9HRpFIVCIJOkK68j9Ja0CbmYDzx3d
	tdefCvrWPZ65sk4vTFq1ahDf+VhWy30IhR1br/YRRpn/RRSQ9iggCax446XPSbfpiYJnIMS5hXi
	FtC/ApguIWLdyMBgc4HVx1Vnaujr8QXVwbS34JPmKD9G7VA1n/4eVPiCywgf/QKHDS
X-Received: by 2002:a17:90b:2b50:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-392cc905a96mr4451345a91.6.1786395307569;
        Mon, 10 Aug 2026 13:55:07 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5381dd3sm933223a91.16.2026.08.10.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:55:06 -0700 (PDT)
Message-Id: <pull.2197.v3.git.1786395305884.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Aug 2026 20:55:05 +0000
Subject: [PATCH v3] worktree add: improve message for ambiguous remote branch
 name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When the user runs 'git worktree add x y' command that does not
exactly say which remote they want to work with, and there is no local
branch named y, we try to guess which remote by passing y then create
a new branch named y which tracks the remote branch.

If there are multiple remotes that have branch named y, we silently
gave up, leaving the variable branch intact.  This later causes
creating local branch and worktree not happen, and we end up with
passing an non-existing branch to lookup_commit_reference_by_name(),
triggering "invalid reference" error and die.

To resolve this issue, display a hint and a descriptive error message
and die immediately when multiple mathing branches are found.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree add: improve message for ambiguous remote branch name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v2:

 1:  1bc57ce497 ! 1:  1b9364da7e worktree add: improve message for ambiguous remote branch name
     @@ Metadata
       ## Commit message ##
          worktree add: improve message for ambiguous remote branch name
      
     -    Display a hint and a descriptive error message when DWIM fails.
     +    When the user runs 'git worktree add x y' command that does not
     +    exactly say which remote they want to work with, and there is no local
     +    branch named y, we try to guess which remote by passing y then create
     +    a new branch named y which tracks the remote branch.
     +
     +    If there are multiple remotes that have branch named y, we silently
     +    gave up, leaving the variable branch intact.  This later causes
     +    creating local branch and worktree not happen, and we end up with
     +    passing an non-existing branch to lookup_commit_reference_by_name(),
     +    triggering "invalid reference" error and die.
     +
     +    To resolve this issue, display a hint and a descriptive error message
     +    and die immediately when multiple mathing branches are found.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      


 builtin/worktree.c      | 23 ++++++++++++++++++++++-
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..b29c3a3755 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -64,6 +64,19 @@
 	"\n" \
 	"    git worktree add --orphan %s\n")
 
+#define WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT \
+	_("Matched multiple remote tracking branches, you can list them by:\n" \
+	"\n" \
+	"    git branch -r --list \"*/%s\"\n" \
+	"\n" \
+	"If you meant to create a worktree from a remote tracking branch on,\n" \
+	"e.g. 'origin', you can do so by:\n" \
+	"\n" \
+	"    git worktree add -b %s %s origin/%s\n" \
+	"\n" \
+	"If you'd like to always prefer some remote, e.g. 'origin',\n" \
+	"consider setting checkout.defaultRemote=origin in your config.")
+
 static const char * const git_worktree_usage[] = {
 	BUILTIN_WORKTREE_ADD_USAGE,
 	BUILTIN_WORKTREE_LIST_USAGE,
@@ -904,10 +917,18 @@ static int add(int ac, const char **av, const char *prefix,
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL);
+			int num_matches = 0;
+			remote = unique_tracking_name(branch, &oid, &num_matches);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet)
+					advise_if_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+							  WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT,
+							  branch, branch, path, branch);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
 		}
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual

base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
gitgitgadget
