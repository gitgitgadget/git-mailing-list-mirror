Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00D256C8E
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289555; cv=none; b=le45jmNZA54ProgqUwF951cFR9TQsUQGqYf624LIfO/IGMi4LRjovo51f5TkKLciWzIcTAd8Yh96tWfrFs3nv9g+ot5vThauAyTDbFNkn2MTWknQ2npHBqfr6ijN9+383UMgkPHP9mzdl8QQr3nJ9AeJmQfZ4lVL7hKzYtMNBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289555; c=relaxed/simple;
	bh=4Dqikrb5Qu5zIBCm6Kn142g0EGg5AvTRAj1ReESZ1vw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AnR016ZVlJAUbh/ZDTvSaOGFGKXYwBpn03U3auoYNYhA1smQ/V075qhYi+gtNzWY/cBzCt3mHi9emz5TvuFHZHz4tIxrVdidCWLufe4+tTGqj2EL8H53Hx4gEl4RxTNvVCyS/bEV0qUP7o3kT4W/75O4UOqIZSW2D5wUQ0IarpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QikBDF03; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QikBDF03"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4395560cc13so7174265e9.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 07:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739289551; x=1739894351; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL2NoRKDUzAkrNEMlK3gVCf4ojwS9IKuRkrT7BLtGzk=;
        b=QikBDF03xdq2DEFQKgeQIcw9GHuP7dxlnd0aC9Jg/sPD8RTz1HkkS8TCb/9y5Ay5eI
         v/oNqIgSDQ4R6HR4AVPB8kT70JEUSWZRZ6Fppc7Luiwev+24MgxDXpQcCbGjUO4nd8Nm
         oJw5wHO7RMq6+jcHB0H5+qHEBz3eVfXvjxIU26lyQWoutTJUF4SYYWRajJg17akyeZFR
         flYUa6W9Hd8TVDHFirVqZFXfqIPsSm6pOY+OQXQMFu6QMF3QX7T2WtAa3qEy9fcLFuTQ
         ZMbdiiXfUCSGW+YyFn72PHIseec8a4vLt5UXLrO9HrWAdiLg9w9E1zMOSkhxN62i1z5G
         BNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739289551; x=1739894351;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL2NoRKDUzAkrNEMlK3gVCf4ojwS9IKuRkrT7BLtGzk=;
        b=EfNaC6jmc0UJtcxu0yDzNkh6LILHx4UsAEjZGUPzYPRh18wA6pFk3GoNUGZvxrnI3J
         Onb5e2xWo6yfZrytPx5r6kxPT+/rm3WLXqjsgfV25L4ledBwIan29kfMHOuCTIpcGxSm
         X5sP5DfcTyRfxNBiOP/e/2TR1oWrH/N3V/gVdnhB3dN7nKYvi0h4sjJgLsOtB96e86ru
         6SXYokJ07lgv5wgElKrugbg/Pn3VzjNI9lvpB6QFt+YobfX2tggxGfkC32S0SZ2LYx8k
         mrxTs8LFlBdca1aqZ4Cc+ZwRx73YHu9ASh48iux5GuF/SSjZDDFNnyfmk3fouQ4KAGyl
         Mjeg==
X-Gm-Message-State: AOJu0Yy7tjle9frQQrXDDffTf/MFoEVhLjacHGrnAF4oWyeGjdmjCpb5
	3ptPoa8B4Z0lnGnrgVbIrPR+GFzP2A3HE7bFvcTn3iBS/xPldzby5xx/3Q==
X-Gm-Gg: ASbGncsS2ivHBuiRol0pyplobr3Zh+uMwE54wLJYUKtCmxjjyMIqjAX+HkzBNfOiXpp
	IcuxSkmpLByjAwy3Shf4as+6TauF6PBveFj0E03fWjOALnTTOSF0Yt7kwhnKBT1DVOotA1hc8oK
	Fd+DQdbtk1/bWjBYd6ASraWN6pZhZQq7kKS3HxbafMisatjs0ozFZp7CsNyUo6bEdAz1sIQZEPW
	jIUTHLq3Bt4YblEYtZqnFhB52UrOPAl4Ruzhv8ui34nIElOXbtBaB3t6rK3bNZbX/SEHTM4zK3r
	bbNjrE39bXEm2fjl
X-Google-Smtp-Source: AGHT+IGOwoovojpy11plg8R1MuJB1x5R8onBb5ypMhX7c82ySABnOfm6AvwyRBAUPjHM6ES5xBrDmQ==
X-Received: by 2002:a05:600c:4f89:b0:439:4b9e:45fc with SMTP id 5b1f17b1804b1-4394b9e4883mr55683065e9.4.1739289550837;
        Tue, 11 Feb 2025 07:59:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43948698d56sm49868535e9.7.2025.02.11.07.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:59:10 -0800 (PST)
Message-Id: <pull.1860.v2.git.1739289549299.gitgitgadget@gmail.com>
In-Reply-To: <pull.1860.git.1738751840816.gitgitgadget@gmail.com>
References: <pull.1860.git.1738751840816.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Feb 2025 15:59:08 +0000
Subject: [PATCH v2] rebase -i: reword empty commit after fast-forward
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When rebase rewords a commit it picks the commit and then runs "git
commit --amend" to reword it. When the commit is picked the sequencer
tries to reuse existing commits by fast-forwarding if the parents are
unchanged. Rewording an empty commit that has been fast-forwarded fails
because "git commit --amend" is called without "--allow-empty". This
happens because when a commit is fast-forwarded the logic that checks
whether we should pass "--allow-empty" is skipped. Fix this by always
passing "--allow-empty" when rewording a commit. This is safe because we
are amending a commit that has already been picked so if it had become
empty when it was picked we'd have already returned an error.

As "git commit" will happily create empty merge commits without
"--allow-empty" we do not need to pass that flag when rewording merge
commits.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: reword empty commit after fast-forward
    
    Thanks to Junio for his comments on V1. I've added a comment explaining
    why we use a fixed set of commits flags as he suggested.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1860%2Fphillipwood%2Frebase-reword-empty-commit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1860/phillipwood/rebase-reword-empty-commit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1860

Range-diff vs v1:

 1:  06de47a91d8 ! 1:  826edd3ba48 rebase -i: reword empty commit after fast-forward
     @@ sequencer.c: static int do_pick_commit(struct repository *r,
      -			res = run_git_commit(NULL, opts, EDIT_MSG |
      -					     VERIFY_MSG | AMEND_MSG |
      -					     (flags & ALLOW_EMPTY));
     ++			/*
     ++			 * To reword we amend the commit we just
     ++			 * picked or fast-forwarded. As the commit has
     ++			 * already been picked we want to use the same
     ++			 * set of commit flags regardless of how we
     ++			 * got here.
     ++			 */
      +			flags = EDIT_MSG | VERIFY_MSG | AMEND_MSG | ALLOW_EMPTY;
      +			res = run_git_commit(NULL, opts, flags);
       			*check_todo = 1;


 sequencer.c                   | 12 +++++++++---
 t/t3404-rebase-interactive.sh | 14 ++++++++++++++
 t/t3430-rebase-merges.sh      | 20 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 407ee4e90fe..ad0ab75c8d4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2510,9 +2510,15 @@ static int do_pick_commit(struct repository *r,
 		*check_todo = !!(flags & EDIT_MSG);
 		if (!res && reword) {
 fast_forward_edit:
-			res = run_git_commit(NULL, opts, EDIT_MSG |
-					     VERIFY_MSG | AMEND_MSG |
-					     (flags & ALLOW_EMPTY));
+			/*
+			 * To reword we amend the commit we just
+			 * picked or fast-forwarded. As the commit has
+			 * already been picked we want to use the same
+			 * set of commit flags regardless of how we
+			 * got here.
+			 */
+			flags = EDIT_MSG | VERIFY_MSG | AMEND_MSG | ALLOW_EMPTY;
+			res = run_git_commit(NULL, opts, flags);
 			*check_todo = 1;
 		}
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ecfc02062cd..2aee9789a2f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -791,6 +791,20 @@ test_expect_success 'reword' '
 	grep "C changed" actual
 '
 
+test_expect_success 'reword fast-forwarded empty commit' '
+	git commit --allow-empty -m "empty commit" --only &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND=edited FAKE_LINES="reword 1" \
+			git rebase -i HEAD^
+	) &&
+	test_commit_message HEAD <<-\EOF
+	empty commit
+
+	edited
+	EOF
+'
+
 test_expect_success 'no uncommitted changes when rewording and the todo list is reloaded' '
 	git checkout E &&
 	test_when_finished "git checkout @{-1}" &&
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 2593711fecd..b84d68c4b96 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -610,4 +610,24 @@ test_expect_success 'truncate label names' '
 	grep "label 0123456789-$" out
 '
 
+test_expect_success 'reword fast-forwarded empty merge commit' '
+	oid="$(git commit-tree -m "D1" -p A D^{tree})" &&
+	oid="$(git commit-tree -m "empty merge" -p D -p $oid D^{tree})" &&
+
+	write_script sequence-editor.sh <<-\EOF &&
+	sed /^merge/s/-C/-c/ "$1" >"$1.tmp"
+	mv "$1.tmp" "$1"
+	EOF
+
+	(
+		test_set_sequence_editor "$(pwd)/sequence-editor.sh" &&
+		GIT_EDITOR="echo edited >>" git rebase -i -r D $oid
+	) &&
+	test_commit_message HEAD <<-\EOF
+	empty merge
+
+	edited
+	EOF
+'
+
 test_done

base-commit: 58b5801aa94ad5031978f8e42c1be1230b3d352f
-- 
gitgitgadget
