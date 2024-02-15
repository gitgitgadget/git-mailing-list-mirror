Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18769D0C
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992989; cv=none; b=g6O7wSAwl2X/n/dzHS9dhxmx6HbMQsQyUTIuW0eRP+/c/EXI81w94nOXNM17EHx33W/KIVNAosRxoXyh76bEKgI9767ln3kW9Hl/fpsQEWVrlLPB8tKbJxO8UmNxzeEkVRst4JmXqalRbzlpPBO92wvnqwkcFwk+hyG4NLX2Zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992989; c=relaxed/simple;
	bh=jPXFang1srJw4bZQSVknjo7OMOpzQSB7SbkHK3M3VwM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OjFt3ztFP/Slt9g4a71wr0oI+STuVVv1EtSj2blNu3JSyMO1DzKJ1gn0szb4nO2k/A0e82wWxaqhpzdfUZAGJqT8G2Or5J9AWs2KHCp0Sxg753Njn45e4GNCLuYnDMZ3pWdDMLbbTxbXmoFtHK8VT4tplSZdy6OD8O6V5jFp3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/p4bL6p; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/p4bL6p"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d118a181fso9705f8f.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 02:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707992986; x=1708597786; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFFlXaXhSVzkM+vKU3wWW4HNf9XxRFU91f9yeZk+K6g=;
        b=b/p4bL6pLQ/DAIH8su6m3EsrPTiGPgIq2LYQIXSx0Ltc7Qd8N+X5t5aV0vWQfJpYl8
         uzgcpvl+qvBLtZXy1yLPbjZnup9irQTzgVEzCX+NwpkgioW54W81mDhPudWMt4Qj8xdN
         MDdOBxfmcARyseRh5l7/DVs8ssf3MouQUnxyOYzvk1qgl8LMFX+LmbO5e51TrSyGcMQQ
         eBNL0ZNP07nBpdgRX8nPOSKWgEKLaS55DFBAbBN3iRH+AHCPFCqX08VF22SoU3BbMSp3
         xuL4OHIrbOShVM88GqZMz0AAT1r1/qRfNNXGzYuJ9W12wESRSqEtwxHMWH5P4qM20PKl
         f3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992986; x=1708597786;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFFlXaXhSVzkM+vKU3wWW4HNf9XxRFU91f9yeZk+K6g=;
        b=sDvVjbmhrjiaqGj19PGIINg8cSBQZWMuD4MyFKsWKvm5ZBD+7t6K0AAo2+1UY5qDgU
         rGBBFxPI1mvazTgDTMXMP5LHo4SgFIYPA3WC0U6DBrvujggQVju3eiyDYoOpRXjwfGff
         W/StfFFk+iF89wmpKA7O6RgDPTD+79Agbo1fWTJ3+M11GVMgQalbQ5JuMMcA0WolKFP9
         D4j1ttZLoV1TMIBQwcHsJ9if+5HXR9zxbj9HeLoczGq4Qni+pZBFIrLqc25WKoZ/N2q1
         YOgy/IsT+s2P5uq8o6PBc3yyMZmGsFb/eKe5NpOqPukrb98/mnXunrD9k1pMkU37E8Be
         2+0Q==
X-Gm-Message-State: AOJu0YysHHENsb9iaCOMIWBiQ3NMMssmV2I+nJnsbgQmkuxy9aOmfjkk
	h15xxjb9vXHgG+FK+mcyjBYcFLbL/XBFVVvVGKysA9H2cjvt9wk5TCdC1Y4V
X-Google-Smtp-Source: AGHT+IETMSaVfRiQUX3n6xAl5dzRxqBXKeknq5lYZd/iQVEjdt6UMGF+VHCKizndLQ7RSOnZCP9WQQ==
X-Received: by 2002:a5d:6a8b:0:b0:33b:4d13:3e91 with SMTP id s11-20020a5d6a8b000000b0033b4d133e91mr945618wru.45.1707992985877;
        Thu, 15 Feb 2024 02:29:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b0033b8808355fsm1345545wro.28.2024.02.15.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:29:45 -0800 (PST)
Message-ID: <2550a7824832ab4f570b82ec452bd12e315ea7f5.1707992978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
From: "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 10:29:36 +0000
Subject: [PATCH 5/7] fsmonitor: test updates
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
Cc: "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Glen Choo [ ]" <chooglen@google.com>,
    "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
    "Taylor Blau [ ]" <me@ttaylorr.com>,
    marzi <m.ispare63@gmail.com>,
    Eric DeCosta <edecosta@mathworks.com>

From: Eric DeCosta <edecosta@mathworks.com>

t7527-builtin-fsmonitor was leaking fsmonitor--daemon processes in some
cases.

Accomodate slight difference in the number of events generated on Linux.

On lower-powered systems, spin a little to give the daemon time
to respond to and log filesystem events.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 t/t7527-builtin-fsmonitor.sh | 138 +++++++++++++++++++++++++++--------
 1 file changed, 106 insertions(+), 32 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 363f9dc0e41..1d33e418015 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -13,7 +13,7 @@ fi
 stop_daemon_delete_repo () {
 	r=$1 &&
 	test_might_fail git -C $r fsmonitor--daemon stop &&
-	rm -rf $1
+	rm -rf $r
 }
 
 start_daemon () {
@@ -72,6 +72,34 @@ start_daemon () {
 	)
 }
 
+IMPLICIT_TIMEOUT=5
+
+wait_for_update () {
+	func=$1 &&
+	file=$2 &&
+	sz=$(wc -c < "$file") &&
+	last=0 &&
+	$func &&
+	k=0 &&
+	while test "$k" -lt $IMPLICIT_TIMEOUT
+	do
+		nsz=$(wc -c < "$file")
+		if test "$nsz" -gt "$sz"
+		then
+			if test "$last" -eq "$nsz"
+			then
+				cat "$file" &&
+				return 0
+			fi
+			last=$nsz
+		fi
+		sleep 1
+		k=$(( $k + 1 ))
+	done &&
+	cat "$file" &&
+	return 0
+}
+
 # Is a Trace2 data event present with the given catetory and key?
 # We do not care what the value is.
 #
@@ -137,7 +165,6 @@ test_expect_success 'implicit daemon start' '
 # machines (where it might take a moment to wake and reschedule the
 # daemon process) to avoid false alarms during test runs.)
 #
-IMPLICIT_TIMEOUT=5
 
 verify_implicit_shutdown () {
 	r=$1 &&
@@ -373,6 +400,15 @@ create_files () {
 	echo 3 >dir2/new
 }
 
+rename_directory () {
+	mv dirtorename dirrenamed
+}
+
+rename_directory_file () {
+	mv dirtorename dirrenamed &&
+	echo 1 > dirrenamed/new
+}
+
 rename_files () {
 	mv rename renamed &&
 	mv dir1/rename dir1/renamed &&
@@ -427,10 +463,12 @@ test_expect_success 'edit some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	edit_files &&
+	wait_for_update edit_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/modified$"  .git/trace &&
 	grep "^event: dir2/modified$"  .git/trace &&
 	grep "^event: modified$"       .git/trace &&
@@ -442,10 +480,12 @@ test_expect_success 'create some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	create_files &&
+	wait_for_update create_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/new$" .git/trace &&
 	grep "^event: dir2/new$" .git/trace &&
 	grep "^event: new$"      .git/trace
@@ -456,10 +496,12 @@ test_expect_success 'delete some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	delete_files &&
+	wait_for_update delete_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/delete$" .git/trace &&
 	grep "^event: dir2/delete$" .git/trace &&
 	grep "^event: delete$"      .git/trace
@@ -470,10 +512,12 @@ test_expect_success 'rename some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	rename_files &&
+	wait_for_update rename_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/rename$"  .git/trace &&
 	grep "^event: dir2/rename$"  .git/trace &&
 	grep "^event: rename$"       .git/trace &&
@@ -487,23 +531,42 @@ test_expect_success 'rename directory' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	mv dirtorename dirrenamed &&
+	wait_for_update rename_directory "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dirtorename/*$" .git/trace &&
 	grep "^event: dirrenamed/*$"  .git/trace
 '
 
+test_expect_success 'rename directory file' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	wait_for_update rename_directory_file "$PWD/.git/trace" &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	test_might_fail git fsmonitor--daemon stop &&
+
+	grep "^event: dirtorename/*$" .git/trace &&
+	grep "^event: dirrenamed/*$"  .git/trace &&
+	grep "^event: dirrenamed/new$"  .git/trace
+'
 test_expect_success 'file changes to directory' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	file_to_directory &&
+	wait_for_update file_to_directory "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: delete$"     .git/trace &&
 	grep "^event: delete/new$" .git/trace
 '
@@ -513,10 +576,12 @@ test_expect_success 'directory changes to a file' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	directory_to_file &&
+	wait_for_update directory_to_file "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1$" .git/trace
 '
 
@@ -561,7 +626,7 @@ test_expect_success 'flush cached data' '
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
 	nul_to_q <actual_2 >actual_q2 &&
 
-	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+	grep "^builtin:test_00000002:[0-1]Q$" actual_q2 &&
 
 	>test_flush/file_3 &&
 
@@ -732,7 +797,8 @@ u_values="$u1 $u2"
 for u in $u_values
 do
 	test_expect_success "unicode in repo root path: $u" '
-		test_when_finished "stop_daemon_delete_repo $u" &&
+		test_when_finished \
+		"stop_daemon_delete_repo `echo "$u" | sed 's:x:\\\\\\\\\\\\\\x:g'`" &&
 
 		git init "$u" &&
 		echo 1 >"$u"/file1 &&
@@ -823,8 +889,7 @@ test_expect_success 'submodule setup' '
 '
 
 test_expect_success 'submodule always visited' '
-	test_when_finished "git -C super fsmonitor--daemon stop; \
-			    rm -rf super; \
+	test_when_finished "rm -rf super; \
 			    rm -rf sub" &&
 
 	create_super super &&
@@ -871,10 +936,29 @@ test_expect_success 'submodule always visited' '
 # the submodule, and someone does a `git submodule absorbgitdirs`
 # in the super, Git will recursively invoke `git submodule--helper`
 # to do the work and this may try to read the index.  This will
-# try to start the daemon in the submodule.
+# try to start the daemon in the submodule *and* pass (either
+# directly or via inheritance) the `--super-prefix` arg to the
+# `git fsmonitor--daemon start` command inside the submodule.
+# This causes a warning because fsmonitor--daemon does take that
+# global arg (see the table in git.c)
+#
+# This causes a warning when trying to start the daemon that is
+# somewhat confusing.  It does not seem to hurt anything because
+# the fsmonitor code maps the query failure into a trivial response
+# and does the work anyway.
+#
+# It would be nice to silence the warning, however.
 
-test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
-	test_when_finished "rm -rf super; \
+have_t2_error_event () {
+	log=$1
+	msg="fsmonitor--daemon doesnQt support --super-prefix" &&
+
+	tr '\047' Q <$1 | grep -e "$msg"
+}
+
+test_expect_success "stray submodule super-prefix warning" '
+	test_when_finished "git -C super/dir_1/dir_2/sub fsmonitor--daemon stop; \
+			    rm -rf super; \
 			    rm -rf sub;   \
 			    rm super-sub.trace" &&
 
@@ -891,31 +975,21 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 
 	test_path_is_dir super/dir_1/dir_2/sub/.git &&
 
-	cwd="$(cd super && pwd)" &&
-	cat >expect <<-EOF &&
-	Migrating git directory of '\''dir_1/dir_2/sub'\'' from
-	'\''$cwd/dir_1/dir_2/sub/.git'\'' to
-	'\''$cwd/.git/modules/dir_1/dir_2/sub'\''
-	EOF
 	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
-		git -C super submodule absorbgitdirs >out 2>actual &&
-	test_cmp expect actual &&
-	test_must_be_empty out &&
+		git -C super submodule absorbgitdirs &&
 
-	# Confirm that the trace2 log contains a record of the
-	# daemon starting.
-	test_subcommand git fsmonitor--daemon start <super-sub.trace
+	! have_t2_error_event super-sub.trace
 '
 
 # On a case-insensitive file system, confirm that the daemon
 # notices when the .git directory is moved/renamed/deleted
-# regardless of how it is spelled in the FS event.
+# regardless of how it is spelled in the the FS event.
 # That is, does the FS event receive the spelling of the
 # operation or does it receive the spelling preserved with
 # the file/directory.
 #
 test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
-	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
+#	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
 
 	git init test_insensitive &&
 
@@ -927,8 +1001,8 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	test_path_is_dir test_insensitive/.git &&
 	test_path_is_dir test_insensitive/.GIT &&
 
-	# Rename .git using an alternate spelling to verify that
-	# the daemon detects it and automatically shuts down.
+	# Rename .git using an alternate spelling to verify that that
+	# daemon detects it and automatically shuts down.
 	mv test_insensitive/.GIT test_insensitive/.FOO &&
 
 	# See [1] above.
-- 
gitgitgadget

