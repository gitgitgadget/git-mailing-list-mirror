Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0A19FA9D
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810969; cv=none; b=RgMmQKB8R1c0XmY0c8DZfMmTA2h6H8CtQCjjk9sda63YYB6enKMDjGSZWYYp3hJtHhw/pPJy11q5bEjPbXqXitMSvuZOBkp5adAi1yLp29tfIjsHRcORtYJbkA7+IS0JfqKn7vk249+uZ3dv6Ru+jLAYLTObsAVAm1JB7iziFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810969; c=relaxed/simple;
	bh=b6XPbunz/NlGKEAShDDCwgz8l6JyO9kLp5UKNqSUih0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U7Bcky24US4wXo/9lrjGNvwbW2sylyPMMTnwul6r7heHWzjEwMH9xUCg/ETfQLVCIch+yI+rHNa6f8WWob/wJuTQZeNoqnejWS0II7Halh05Qu022fLoaF2acuLqEYiUKodsKUpp9AL9FaVEpbBHJuTa7/ztbuuLzwNYl8M1G3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcwdRNvr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcwdRNvr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a90188ae58eso752703666b.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727810966; x=1728415766; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1V7heIKw8TBp/Mcrw29rlca5fA6c6rJEfD3i6wPXiI=;
        b=BcwdRNvrKNhV+KNelAOL2fN46ZuT83hnDPg9FissZh00Sahx7fePo16+G/+JfIdzlP
         gy5udsWsbTAjf7rFpU1zhGKR9Mh8ONs8VyfpKO5/lY8mRDa+imG9S8NVqhmJ46DFhzNO
         69TgzEdCi24u4vhPT70iGuTb5Brd1pBfaGDBJe3hhcXs6K63hT4xQsonMW5e4WO/USon
         0XTUo/0+mKEQeaYdQmFV49Rbxl7xQgkUHO9jpxUnRWXGLcUuI+yyM62WB5M3f7T/gi77
         ZbqX/LvfGe+0fck9qpWwL1QJh6kEGc4KciVQvEfuAE7rvED5VqeYLpZ+tNB9pRJmIncR
         B8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810966; x=1728415766;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1V7heIKw8TBp/Mcrw29rlca5fA6c6rJEfD3i6wPXiI=;
        b=gEiGRlYkG/zy4cNjSz2U6e9Ljxaz6NJLT9vqFms0c0PSj15M66KKy9pBfsM7pg0U52
         pFllwBBjWMN4OOFXb07bNhWCa80S3iBmpqN7a3+rCB+Un9n46lYy6OodgsY+0FM6xNWQ
         QiW12t7HJ9ni0wLSRgM53KCVpSlpHnQu3WBTyAMkSER6q67Z3dGNkxN9Ij7Fl+0OmlDm
         he9bjyiUyNCZISKnySiHPGpc45EJhl4aYPlafLEq+1NZuUEgrBVHRe8I8X84sfYNKOR0
         HpOpPVtH6LT/+MY9zo1De7mYfFyAk+IiPBkrsl6LGGOoJYT9UcTPOv95w/kZFECVKmiX
         0wiQ==
X-Gm-Message-State: AOJu0Yy65L5PRk28XLfidrlREZ9VnuoewZtbls7WR6Q7GUUAumoRwxAA
	m8eFuvI9y5WglR1jEKZYFxXrDGLNXUIgFVQF08UohAvm24ieItGmXGmAnQ==
X-Google-Smtp-Source: AGHT+IH1YhkLE+yZOiXVyr45g02g7ZeS4w2Q20lQ2hRrEL334WWGRb1FMkau6ElCrnt+YlGOH+baag==
X-Received: by 2002:a17:907:2da4:b0:a8d:3338:a492 with SMTP id a640c23a62f3a-a98f82008ffmr59355166b.7.1727810965739;
        Tue, 01 Oct 2024 12:29:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27ecd10sm751877466b.96.2024.10.01.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:29:25 -0700 (PDT)
Message-Id: <pull.1802.v3.git.1727810964571.gitgitgadget@gmail.com>
In-Reply-To: <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com>
References: <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Oct 2024 19:29:24 +0000
Subject: [PATCH v3] fsmonitor OSX: fix hangs for submodules
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
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

fsmonitor_classify_path_absolute() expects state->path_gitdir_watch.buf
has no trailing '/' or '.' For a submodule, fsmonitor_run_daemon() sets
the value with trailing "/." (as repo_get_git_dir(the_repository) on
Darwin returns ".") so that fsmonitor_classify_path_absolute() returns
IS_OUTSIDE_CONE.

In this case, fsevent_callback() doesn't update cookie_list so that
fsmonitor_publish() does nothing and with_lock__mark_cookies_seen() is
not invoked.

As with_lock__wait_for_cookie() infinitely waits for state->cookies_cond
that with_lock__mark_cookies_seen() should unlock, the whole daemon
hangs.

Remove trailing "/." from state->path_gitdir_watch.buf for submodules
and add a corresponding test in t7527-builtin-fsmonitor.sh.

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    fsmonitor/darwin: fix hangs for submodules

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1802%2FKojiNakamaru%2Ffix%2Ffsmonitor-darwin-hangs-for-submodules-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1802/KojiNakamaru/fix/fsmonitor-darwin-hangs-for-submodules-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1802

Range-diff vs v2:

 1:  decf68499f7 ! 1:  aabc1c2f6ee fsmonitor OSX: fix hangs for submodules
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "submodule absorbgitdirs impli
      +
      +test_expect_success "submodule implicitly starts daemon by pull" '
      +	test_atexit "stop_watchdog" &&
     -+	test_when_finished "stop_git && rm -rf cloned super sub" &&
     ++	test_when_finished "stop_git; rm -rf cloned super sub" &&
      +
      +	create_super super &&
      +	create_sub sub &&


 builtin/fsmonitor--daemon.c  |  1 +
 t/t7527-builtin-fsmonitor.sh | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index dce8a3b2482..e1e6b96d09e 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1314,6 +1314,7 @@ static int fsmonitor_run_daemon(void)
 		strbuf_reset(&state.path_gitdir_watch);
 		strbuf_addstr(&state.path_gitdir_watch,
 			      absolute_path(repo_get_git_dir(the_repository)));
+		strbuf_strip_suffix(&state.path_gitdir_watch, "/.");
 		state.nr_paths_watching = 2;
 	}
 
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 730f3c7f810..e6ddc7048c0 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -907,6 +907,57 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 	test_subcommand git fsmonitor--daemon start <super-sub.trace
 '
 
+start_git_in_background () {
+	git "$@" &
+	git_pid=$!
+	git_pgid=$(ps -o pgid= -p $git_pid)
+	nr_tries_left=10
+	while true
+	do
+		if test $nr_tries_left -eq 0
+		then
+			kill -- -$git_pgid
+			exit 1
+		fi
+		sleep 1
+		nr_tries_left=$(($nr_tries_left - 1))
+	done >/dev/null 2>&1 &
+	watchdog_pid=$!
+	wait $git_pid
+}
+
+stop_git () {
+	while kill -0 -- -$git_pgid
+	do
+		kill -- -$git_pgid
+		sleep 1
+	done
+}
+
+stop_watchdog () {
+	while kill -0 $watchdog_pid
+	do
+		kill $watchdog_pid
+		sleep 1
+	done
+}
+
+test_expect_success "submodule implicitly starts daemon by pull" '
+	test_atexit "stop_watchdog" &&
+	test_when_finished "stop_git; rm -rf cloned super sub" &&
+
+	create_super super &&
+	create_sub sub &&
+
+	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
+	git -C super commit -m "add sub" &&
+	git clone --recurse-submodules super cloned &&
+
+	git -C cloned/dir_1/dir_2/sub config core.fsmonitor true &&
+	set -m &&
+	start_git_in_background -C cloned pull --recurse-submodules
+'
+
 # On a case-insensitive file system, confirm that the daemon
 # notices when the .git directory is moved/renamed/deleted
 # regardless of how it is spelled in the FS event.

base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
-- 
gitgitgadget
