Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C7192D74
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727759377; cv=none; b=W+vUyZHbF8VgZopzlI4RZXXffJwOxc15Ft5vk15fm93jp1/fF+KxQ7MsAJ7Piq956OC2qNQ8j/ZaqLDRjrq+7QE1Gj5OjDB3v1ykn9KmNNtVSGSYtHTrC0jy/4NzBD7dhIGwO27qGzCJphU2QxP5cZUrN7EkJLfp1aIOHkWBB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727759377; c=relaxed/simple;
	bh=uDPoSgd4JmywQWDw4V2mraak3f4M1ugSehWQT6UNAms=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eZrmkWx1mqE7JH9dUMcT5q59nebD+PJHTOM8RZdzzRZuY602OwpJgpGvrMWCyqEf8/xgfpOBQRzWR9dEcSEf/yJh4vV3mS5IQs6GTDuM+J1JxJDz32fY8g9dHi3RpcgG+VVUSPKxEaRGNMVfwzTZYLUCIEAzQ/B8Tf82iyVGZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1sXx38S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1sXx38S"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93a1cda54dso728531066b.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727759373; x=1728364173; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNV2KaQLnrUzlAp20xlT2TlqGFGFcp8rY7QIsR149XA=;
        b=A1sXx38SXh4Tuuyy1L74CjyH5oTspsU8P417ha/f8Uf+ww7ay2X8KNlcVzGIH+PaRb
         1TdlIC7LsJP3HGLDrZZYfa7sjHfvFljjgs3QMsOFAlu8OL6E3AJavDJiTnFOosEcXXfO
         9EBOtOzTox0ZMes3GMCOmRYvzpF5+gpF4QuKFvuRi9zee2NGnD90Q5B/II/mowkCWwnR
         swOQ81J4Urswdfnn5gQrL5VWNml03ixl7DJRDxEXhdRHkERLINLDhJFw4voZLjxJqO+0
         DG3KgLgpfR5PC3IAbU8lcYxsY8PmhzjW/2vvaYpWLBiG4Or1vSbH2HoiQofDk2ESaZaQ
         OIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727759373; x=1728364173;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNV2KaQLnrUzlAp20xlT2TlqGFGFcp8rY7QIsR149XA=;
        b=BzwkrmRW/BFYjSSO8amnPXuK1KsjLR0ixIk6/FSOyXCiJt8+bZgV+1pi3WfoZPFHrl
         Lfl3Mu0Uo4C+AbI5z+RcOuVcC3zEc8Qr5y6mEcEQZdTc3FMsI+uummyn5VNP3W82CzZK
         C6NjaFgM94itYsVO/sA0zOXPYe0d7cQ9GL/QpXVsGMejCmNDPQlcWSMw2PeIzz3buDe5
         mdfXFPIKZPnZfwWdIKAK0TW2MGFUUZbNXc5ZElirMo9tBWkVdpd3S91glxnYuadkRlQw
         e4pyBwG0FJnEVG6b+nRMBqFmZR9a24g4LAJvcDMYhvJQd0WXOyaFQVAcHAQtlpLPJP1c
         QwRw==
X-Gm-Message-State: AOJu0YzD+2t8VU0BeVfmAPg74CzpsrsFPWpq5QC9VLOqm3qYsKa7WaSS
	kSZKqkizq55HAQO8ZSeL3qs31fxa3koSB61p3A8TtC1isfjUkFsft67eew==
X-Google-Smtp-Source: AGHT+IHAH6Fa69Q5OsBa6ZAjeHNwEfnG6nVtRxUPhzZjWNr9YP5GQgX2VK4+U7FUG+ipzn1/BvCo7A==
X-Received: by 2002:a17:907:7283:b0:a8d:2faf:d33d with SMTP id a640c23a62f3a-a93c48f1d0dmr1290375966b.9.1727759372440;
        Mon, 30 Sep 2024 22:09:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997d4csm633035366b.188.2024.09.30.22.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 22:09:32 -0700 (PDT)
Message-Id: <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com>
In-Reply-To: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Oct 2024 05:09:30 +0000
Subject: [PATCH v2] fsmonitor OSX: fix hangs for submodules
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1802%2FKojiNakamaru%2Ffix%2Ffsmonitor-darwin-hangs-for-submodules-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1802/KojiNakamaru/fix/fsmonitor-darwin-hangs-for-submodules-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1802

Range-diff vs v1:

 1:  1889cbb193d ! 1:  decf68499f7 fsmonitor OSX: fix hangs for submodules
     @@ Commit message
          Remove trailing "/." from state->path_gitdir_watch.buf for submodules
          and add a corresponding test in t7527-builtin-fsmonitor.sh.
      
     -    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Suggested-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
      
       ## builtin/fsmonitor--daemon.c ##
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       
      
       ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: have_t2_data_event () {
     - 	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
     - }
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
     + 	test_subcommand git fsmonitor--daemon start <super-sub.trace
     + '
       
      +start_git_in_background () {
      +	git "$@" &
      +	git_pid=$!
     ++	git_pgid=$(ps -o pgid= -p $git_pid)
      +	nr_tries_left=10
      +	while true
      +	do
      +		if test $nr_tries_left -eq 0
      +		then
     -+			kill $git_pid
     ++			kill -- -$git_pgid
      +			exit 1
      +		fi
      +		sleep 1
      +		nr_tries_left=$(($nr_tries_left - 1))
     -+	done > /dev/null 2>&1 &
     ++	done >/dev/null 2>&1 &
      +	watchdog_pid=$!
      +	wait $git_pid
      +}
      +
     -+stop_git_and_watchdog () {
     -+	kill $git_pid $watchdog_pid
     ++stop_git () {
     ++	while kill -0 -- -$git_pgid
     ++	do
     ++		kill -- -$git_pgid
     ++		sleep 1
     ++	done
     ++}
     ++
     ++stop_watchdog () {
     ++	while kill -0 $watchdog_pid
     ++	do
     ++		kill $watchdog_pid
     ++		sleep 1
     ++	done
      +}
      +
     - test_expect_success 'explicit daemon start and stop' '
     - 	test_when_finished "stop_daemon_delete_repo test_explicit" &&
     - 
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
     - 	test_subcommand git fsmonitor--daemon start <super-sub.trace
     - '
     - 
      +test_expect_success "submodule implicitly starts daemon by pull" '
     -+	test_atexit "stop_git_and_watchdog" &&
     -+	test_when_finished "rm -rf cloned; \
     -+			    rm -rf super; \
     -+			    rm -rf sub" &&
     ++	test_atexit "stop_watchdog" &&
     ++	test_when_finished "stop_git && rm -rf cloned super sub" &&
      +
      +	create_super super &&
      +	create_sub sub &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "submodule absorbgitdirs impli
      +	git clone --recurse-submodules super cloned &&
      +
      +	git -C cloned/dir_1/dir_2/sub config core.fsmonitor true &&
     ++	set -m &&
      +	start_git_in_background -C cloned pull --recurse-submodules
      +'
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
index 730f3c7f810..2dd1ca1a7b7 100755
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
+	test_when_finished "stop_git && rm -rf cloned super sub" &&
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
