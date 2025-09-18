Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3027D776
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186052; cv=none; b=dMEEGqWqB4DLbqGcDUYDcZdj6p73hXi7t/+ZeZoiBHgckEZBU3bsh/lGkLNmKK4y0wjXvOZWC/K2TIAUuSWZvsbwIAjbxueJQYbe6UwP+JAaArF40MTdgenB9MH2+VDoKjhtai/ta7VmfeTlAU8zLL2jLmK20jDMvoywFi3dBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186052; c=relaxed/simple;
	bh=wYLkCGLuScHRtjQUKbawvD9CiFD7YBx7/3qZhJVG+vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN7/IyRrtYpFag5XLd4YhwT1+3IXbn/MWqgFCXbveSyNo6GBRqN/9vhbthtz8D2HxxK8wUYVweyaLhcHO/hcuorPQXi0PMGsGPaX9a4e2HChLn0GirWJl9QsIamBEJkn3I7yuYJ545Nx73B8MUOJHfenmWC2iWknZxBPOHgmLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPlvAptW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPlvAptW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ece1102998so349132f8f.2
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758186048; x=1758790848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+UUC0zKMk6hLLsTIcvgP8GvDlzExgo/T1Rn6xAxizAM=;
        b=PPlvAptW7r5WqxR6kW83QeeTBkixe2Nq0UgpCOOebWN/gA5RdNYcOyJIZ+/pnYlTdo
         kdq4uoMVMMaIOqbv96pFkNMVDcoNJlQCXwT8rBIGHAae9ILK1O5ndovd6U3e9WfLXVms
         jtV0bkz8ejkcRsiP3EihmENeujwQ2P3dMVtZl+abSuheWtbnJHNkKJ4bzM7gZKwGMrPa
         Mpp3XOx+pfTr4rMrngiqnKPq5J9GsGbWYhmP0KZ8CMDnY5fYZKPobQGwt8NrrpLpkzEE
         MK79evRWFB8pdjf/jNI+EDCSyqCKFour48q25n2lryTjIHxGgNbqLZ4agwh3pi42P8X+
         +BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186048; x=1758790848;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UUC0zKMk6hLLsTIcvgP8GvDlzExgo/T1Rn6xAxizAM=;
        b=V8vdi8IvSmFGcAntHO/OZQCKMgMAtZG/kSYpjMzZ7V2ruiyoa2WKf4rCwoIm31Qc48
         ODghZGFmwyfrxxA6nHQjY3l9CPiZkpeWE36tV3tlcMX+X8EDpE+nrO9Zu93G84GTIrZx
         bBRncQc6Mn/mbimzQqNrsJw8ihV11iY36K9BeCWbNQkkGAMcmPrLz4uEEnPoHAaRZ2ZU
         ANHzKEu5IovB+g2SUu7+aqeL8GofljsBSl/gtjl5ZWUalDenOVRkm4PYBgvHxJuOzADh
         Bic/+XN5GZTuPwEQ6IrUAbhxX7wqQJFQ28Lz5KxFWmDSqw0cdvCF6ji/rYbN8AlN9lDs
         7I9w==
X-Gm-Message-State: AOJu0YzSS5UbskTGCHhFbW90LHuXHkgZq+J5jDsvA0+Xg3PZV4t/6k0b
	qdhwpECrQn1pi+tqMdEVKt/XKcdjgvRzxs8YeTKvwE7J3tzv5iw77HKfR7//6A==
X-Gm-Gg: ASbGncv0I0E6PYSswuZ+nvlv12D1mH1qHTTX5TGQYXl3+g9dfkfzzGOcnlwRvP9g7fP
	PqNNeMz55AYPW5vZ/XNVdScSgib7zLP80rEih2/oFi7vFTrNr3XwXDVd6BQbkMkPLJMlncGcNVP
	WX3p8CsTNbnbegSQKwviHbKgiWsFRXzCU/eNpJYTqqBxF+2vKC/ErKgqfwJLZ5Hbzlo6jrSrcGi
	1q7wpyZCwYPj8EUhRcQXGrDkFO8hFaZ2a4YS7KZxYmjdSQW2u921aeuEqq8aEn8aq0zaCI0w4t6
	IoxAictnavsUYLw2N2s06IekXQhOzZSG+bHw9JW0cfgmShNGuARdBdRk592F58XLYkEfM3MC396
	qpDhHrmTJzvPDOQied8v9acP4bpUgv7BtCaiCnDsyVIim
X-Google-Smtp-Source: AGHT+IHMLr5oH4qjsZ+FSrHj86wK3Ween30pMTDZyMTYME7oEA4WlP2IXqm5Xxd0NmtU9H/yjRpWRw==
X-Received: by 2002:a05:6000:3112:b0:3ec:db87:e88f with SMTP id ffacd0b85a97d-3ecdfa3c86fmr4569805f8f.58.1758186048351;
        Thu, 18 Sep 2025 02:00:48 -0700 (PDT)
Received: from berwick ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7284sm2703082f8f.33.2025.09.18.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:00:47 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Cheng <cyqsimon@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] rebase -i: respect commit.cleanup when picking fixups
Date: Thu, 18 Sep 2025 10:00:38 +0100
Message-ID: <8fb1b4b4a5f4857a3d7d98d029b22904751ec144.1758186038.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.51.0.595.g259a2096d9c
In-Reply-To: <cover.1758186038.git.phillip.wood@dunelm.org.uk>
References: <cover.1758186038.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user uses a prepare-commit-msg hook to add comments to the
commit message template and sets commit.cleanup to remove them when the
commit is created then the comments will not be removed when rebase
commits the final command in a chain of "fixup" commands[1].  This
happens because f7d42ceec52 (rebase -i: do leave commit message intact
in fixup! chains, 2021-01-28) started passing the VERBATIM_MSG flag
when committing the final command in a chain of "fixup" commands. That
change was added in response to a bug report[2] where the commit
message was being cleaned up when it should not be. The cause of that
bug was that before f7d42ceec52 the sequencer passed CLEANUP_MSG
when committing the final fixup. That commit should have simply
removed the CLEANUP_MSG flag, not changed it to VERBATIM_MSG. Using
VERBATIM_MSG ignores the user's commit.cleanup config when committing
the final fixup which means it behaves differently to an ordinary
"pick" command which respects commit.cleanup.

Fix this by not setting an explicit cleanup flag when committing the
final fixup which matches the way "pick" commands behave. The test
added in f7d42ceec52 is replaced with one that checks that "fixup"
and "pick" commands do not clean up the message when commit.cleanup
is not set and do clean up the message when it is set.

[1] https://lore.kernel.org/git/CA+itcS3DxbgpFy2aPRvHQvTAYE=dU0kfeDdidVwWLU=rBAWR4w@mail.gmail.com
[2] https://lore.kernel.org/git/CANVGpwZGbzYLMeMze64e_OU9p3bjyEgzC5thmNBr6LttBt+YGw@mail.gmail.com

Reported-by: Simon Cheng <cyqsimon@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                  |  1 -
 t/t3415-rebase-autosquash.sh | 28 ++++++++++++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9ae40a91b24..47c57c2ea3c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2436,7 +2436,6 @@ static int do_pick_commit(struct repository *r,
 		if (!final_fixup)
 			msg_file = rebase_path_squash_msg();
 		else if (file_exists(rebase_path_fixup_msg())) {
-			flags |= VERBATIM_MSG;
 			msg_file = rebase_path_fixup_msg();
 		} else {
 			const char *dest = git_path_squash_msg(r);
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5d093e3a7ab..5033411a431 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -486,12 +486,28 @@ test_expect_success 'fixup a fixup' '
 	test XZWY = $(git show | tr -cd W-Z)
 '
 
-test_expect_success 'fixup does not clean up commit message' '
-	oneline="#818" &&
-	git commit --allow-empty -m "$oneline" &&
-	git commit --fixup HEAD --allow-empty &&
-	git -c commit.cleanup=strip rebase -ki --autosquash HEAD~2 &&
-	test "$oneline" = "$(git show -s --format=%s)"
+test_expect_success 'pick and fixup respect commit.cleanup' '
+	git reset --hard base &&
+	test_commit --no-tag "fixup! second commit" file1 fixup &&
+	test_commit something &&
+	write_script .git/hooks/prepare-commit-msg <<-\EOF &&
+	printf "\n# Prepared\n" >> "$1"
+	EOF
+	git rebase -i --autosquash HEAD~3 &&
+	test_commit_message HEAD~1 <<-\EOF &&
+	second commit
+
+	# Prepared
+	EOF
+	test_commit_message HEAD <<-\EOF &&
+	something
+
+	# Prepared
+	EOF
+	git reset --hard something &&
+	git -c commit.cleanup=strip rebase -i --autosquash HEAD~3 &&
+	test_commit_message HEAD~1 -m "second commit" &&
+	test_commit_message HEAD -m "something"
 '
 
 test_done
-- 
2.51.0.595.g259a2096d9c

