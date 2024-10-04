Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC80367
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 00:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000439; cv=none; b=r0LB37Y17HDh0+XaSt1EAnTBsnUGwBYBMIDQqKSa5MvR28UHyv2KqZZ6ytF4mgYoTWHKHFsMX//hZmoj+uFx0viu7L2Rhtm65IcBmQnCnxmCuK8NmMfqzyx4+DC/DL7Qgct5OjLI0kMhUngy1v+ZqPJg8/vaAUK3v7VVGiR33OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000439; c=relaxed/simple;
	bh=IvUbTbv4GaMemvX2YkbSD5s9TCq7ZirXELg3RrrDsuI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CRwYNaHrqdwtkuV31fxiS7cBSY8Fs0MwXkyusocVKVMr9lmPvVjxx2ZsG9W1hZcgK4f6MGYJE9VSI6q5Rqn0EXTX0YdGddteR86+kiVYm7rFmN3HW78ozm1KZ44eiNqsZIR/mJofeI3dSyfi6rEUs8TB6/K7VVrqiOyi/i3qcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERpfJNG0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERpfJNG0"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so16653431fa.2
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728000436; x=1728605236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCJuucl211tg5ICCzuEAsX3YJvA1scWza0rF2yKD+1g=;
        b=ERpfJNG0QMvlLYyAsUKsuT8YOnqtV5qBN717qpNDl+z5F5v0XWBHrmJn2vwqqTuGa7
         ubndwpnFx25bimCLaw3Bkvr0a2n5us8KMDX6QUTiyOHXltqRXp8fHWyi6LBQtsMc1QPl
         5pXGUCW0eFvLMT76L5b4znHStLdvSjv7TgY1e60Laa5geKNPI4MQd2a52VyeUx9pWcsG
         2+i4aKxb7OUg8jwwCK5JLEqpX8lSZ540irEB91svBYG3NodAcBdMBpun3RD2c0gkO+lo
         RmA4Q+wMh+DM9p1HX5SL4lFcFvTtZJEj7mktEda77AcKMB8TCZd5+ML3xB/Esm9OFERk
         Lb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728000436; x=1728605236;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCJuucl211tg5ICCzuEAsX3YJvA1scWza0rF2yKD+1g=;
        b=OhNXiTDHZFflX0hjuSG5YtyJRLxQFDzKUHr0kLh8gdtRqy4iNfxSXe3ByS/RN6sCHU
         vTFP9pVsmKxhoLM7txh03+NkQlVIZ8dd1V8cU1fWzFkM/V7xH2MJoBeGZcKCYe4/9Ltm
         VVYXnzQALXx0i0nRFfOHdRo9wS/8JP1OYmQDefaiIO2QZcQDpUb7ZvAB41TxWo5gSPWV
         XK9Rv7DBZTb2XKb/NG/SCSQR59OcCgqTnorB0MLGBK0gbry4CrxXwMkYK5eWqd6BqO4E
         8h7NTD5VDKMs5a7OHRLuHDtaJQtPYwUMJ5U9dTP18AyCCGxUnZkoq6piCNXgE5fOOm4O
         aC2A==
X-Gm-Message-State: AOJu0YwfZl/EKeM7Gk+pn90SjQnfoueNrnGezVSqJ1SZpRPv0JwT3A75
	wIkXAH61z42UimumKfFDfKVPUnCPnHkRJSUwDZFKWIPnuAhjycvOi0jVsw==
X-Google-Smtp-Source: AGHT+IHJmOa+EphPmFrXI1HlgvPOJj76UJFgwE9X4XUj/Dv+jFzLjzs8dDeoIShRPyGZPwY8HhLyBw==
X-Received: by 2002:a2e:9e18:0:b0:2f3:f7cf:2f01 with SMTP id 38308e7fff4ca-2faf3d71ab3mr2853731fa.41.1728000435289;
        Thu, 03 Oct 2024 17:07:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4f70cfsm1212385a12.92.2024.10.03.17.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 17:07:14 -0700 (PDT)
Message-Id: <pull.1802.v4.git.1728000433326.gitgitgadget@gmail.com>
In-Reply-To: <pull.1802.v3.git.1727810964571.gitgitgadget@gmail.com>
References: <pull.1802.v3.git.1727810964571.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Oct 2024 00:07:13 +0000
Subject: [PATCH v4] fsmonitor OSX: fix hangs for submodules
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
and add a corresponding test in t7527-builtin-fsmonitor.sh. The test is
disabled for MINGW because hangs treated with this patch occur only for
Darwin and there is no simple way to terminate the win32 fsmonitor
daemon that hangs.

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    fsmonitor/darwin: fix hangs for submodules

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1802%2FKojiNakamaru%2Ffix%2Ffsmonitor-darwin-hangs-for-submodules-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1802/KojiNakamaru/fix/fsmonitor-darwin-hangs-for-submodules-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1802

Range-diff vs v3:

 1:  aabc1c2f6ee ! 1:  7b7224ef718 fsmonitor OSX: fix hangs for submodules
     @@ Commit message
          hangs.
      
          Remove trailing "/." from state->path_gitdir_watch.buf for submodules
     -    and add a corresponding test in t7527-builtin-fsmonitor.sh.
     +    and add a corresponding test in t7527-builtin-fsmonitor.sh. The test is
     +    disabled for MINGW because hangs treated with this patch occur only for
     +    Darwin and there is no simple way to terminate the win32 fsmonitor
     +    daemon that hangs.
      
          Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Suggested-by: Junio C Hamano <gitster@pobox.com>
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "submodule absorbgitdirs impli
      +	done
      +}
      +
     -+test_expect_success "submodule implicitly starts daemon by pull" '
     ++test_expect_success !MINGW "submodule implicitly starts daemon by pull" '
      +	test_atexit "stop_watchdog" &&
      +	test_when_finished "stop_git; rm -rf cloned super sub" &&
      +


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
index 730f3c7f810..9b15baa02d3 100755
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
+test_expect_success !MINGW "submodule implicitly starts daemon by pull" '
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
