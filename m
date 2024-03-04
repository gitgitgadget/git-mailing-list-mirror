Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB4481D1
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566815; cv=none; b=bbn6UVv51OfI3dH5MgutE2yZ8DjBGpAXv+Pj0EH8GY3ZRhSb8KJ6yh2HiYVFrepiCG1KwZCB/kHzpRYzS6KyERCc3q10UgEuruysHYCtEkovHTeIm8+ZFvfHG+FbrbCYdeGgqhfQBZ/lF56Hnu4EIaZpMeFP935L+yYGgUG6x2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566815; c=relaxed/simple;
	bh=smkKSBjFfk9GhWeZEx4dPXGAWodL+yzJaQFC5xg7tRE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pM56+1Bsc4wZno1nHjHpq0NwDepSz8TIiDISqJZ56FKLD1Jguv04LL4sYfiyhsFeclssofjjf2LCMcFF264/L2NXE5GTocN3CTMwH7FX16ZIBoDvr3J+TxKMZ3dXuzwZikAiU5Xj20caXlzOP3xL+pUYYhdYxshg761K7HAt+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDHyKlWv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDHyKlWv"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ddd1624beso2993965f8f.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566812; x=1710171612; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU83T99cHGoAZca3sEX6lwhqsB1KO5dXBt4kckaA3DQ=;
        b=GDHyKlWvmaVXLSM4alk1QfDFQbfwXVFc0zJ6qMIlIAYIGzepQ1JqPuCWGs5Cz1FvkA
         HG6e97nVraFxA6nrtw584c61LzY9buQkNU57NyJb6HDfrO5p6peUKBO7BWG0ruIpowza
         bm87VoAbBmIpInW9oX57+knDRaM56ytmEavxO7u8km7yYnlVcDIcONxMort2vYm0ierr
         ufe51lPkwP/G6Tt//dsJvQAJfc6BApC4QBUCtAPbMDJdBjdoE+SswOn5HsZg/P7qkCM9
         t1y7xvDowk+ZfjjVJylyM/9CE/M49o+wJN1/3ijV5ZySjzqEQS0XhG1ltJNBhKUahFCq
         zNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566812; x=1710171612;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU83T99cHGoAZca3sEX6lwhqsB1KO5dXBt4kckaA3DQ=;
        b=HLHYAYsekkRzHXVwri7q1wR7kxKfDbjExGL6ifVU7rWSem4zPNwr4sITH0nEwkqTex
         xk3PxuogQz2hV18EK6v18a36fA/pfS7MVd17IlzOnjJrYqssxY1HBzz2sEOyHJbV4VXI
         IaaVIuy2Q5TCAq9rhnlnFqwABqb7c19eAdpLfy+6hY3sAo8GSdBaqf+zlXnXLQHbiF3g
         OMLAMKRunDZ0iCZb27suit7+KelWpQjE9PXVhiXeb6Ckr5OKiwOlCOzMc6XnV71NXvzq
         xe9JKI2QyUWHcwghiuu4h6Cv9fExfnvpCzSBJmPeIY8aBtUaFFxdWOkYK3uZokTaH2Yg
         HCyw==
X-Gm-Message-State: AOJu0YyYs5L0X2Nizs1zniHGRVXajylB0qh4bN2PhgHjYQnjAeZsXfA+
	GcU1dXF0rFwoIqSMCgegvM2PUxOcffY1hWInWbUOcCPJb4U89CnrMaixn1iQ
X-Google-Smtp-Source: AGHT+IEP8d3qSki3nfVPA2aNQ3bR+I4NJoPvtuDWq7zOPDdJCQPZHGV8DyMViHpbf0P6o+Zs2tZ+lg==
X-Received: by 2002:adf:edc4:0:b0:33d:3c0c:ad53 with SMTP id v4-20020adfedc4000000b0033d3c0cad53mr9205142wro.30.1709566811355;
        Mon, 04 Mar 2024 07:40:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id by12-20020a056000098c00b0033e25c39ac3sm7782685wrb.80.2024.03.04.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:40:11 -0800 (PST)
Message-ID: <b378b93242a7870772fdb53d7bf2d58d3347ba62.1709566808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Mar 2024 15:40:05 +0000
Subject: [PATCH 1/4] t0211: demonstrate missing 'def_param' events for certain
 commands
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Some Git commands fail to emit 'def_param' events for interesting
config and environment variable settings.

Add unit tests to demonstrate this.

Most commands are considered "builtin" and are based upon git.c.
These typically do emit 'def_param' events.  Exceptions are some of
the "query" commands, the "run-dashed" mechanism, and alias handling.

Commands built from remote-curl.c (instead of git.c), such as
"git-remote-https", do not emit 'def_param' events.

Likewise, "git-http-fetch" is built http-fetch.c and does not emit
them.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t0211-trace2-perf.sh | 231 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 290b6eaaab1..588c5bad033 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -287,4 +287,235 @@ test_expect_success 'unsafe URLs are redacted by default' '
 	grep "d0|main|def_param|.*|remote.origin.url:https://user:pwd@example.com" actual
 '
 
+# Confirm that the requested command produces a "cmd_name" and a
+# set of "def_param" events.
+#
+try_simple () {
+	test_when_finished "rm prop.perf actual" &&
+
+	cmd=$1 &&
+	cmd_name=$2 &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+			$cmd &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+	grep "d0|main|cmd_name|.*|$cmd_name" actual &&
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual
+}
+
+# Representative mainstream builtin Git command dispatched
+# in run_builtin() in git.c
+#
+test_expect_success 'expect def_params for normal builtin command' '
+	try_simple "git version" "version"
+'
+
+# Representative query command dispatched in handle_options()
+# in git.c
+#
+test_expect_failure 'expect def_params for query command' '
+	try_simple "git --man-path" "_query_"
+'
+
+# remote-curl.c does not use the builtin setup in git.c, so confirm
+# that executables built from remote-curl.c emit def_params.
+#
+# Also tests the dashed-command handling where "git foo" silently
+# spawns "git-foo".  Make sure that both commands should emit
+# def_params.
+#
+# Pass bogus arguments to remote-https and allow the command to fail
+# because we don't actually have a remote to fetch from.  We just want
+# to see the run-dashed code run an executable built from
+# remote-curl.c rather than git.c.  Confirm that we get def_param
+# events from both layers.
+#
+test_expect_failure 'expect def_params for remote-curl and _run_dashed_' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_might_fail env \
+		ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+		git remote-http x y &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	grep "d0|main|cmd_name|.*|_run_dashed_" actual &&
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	grep "d1|main|cmd_name|.*|remote-curl" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
+# Similarly, `git-http-fetch` is not built from git.c so do a
+# trivial fetch so that the main git.c run-dashed code spawns
+# an executable built from http-fetch.c.  Confirm that we get
+# def_param events from both layers.
+#
+test_expect_failure 'expect def_params for http-fetch and _run_dashed_' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_might_fail env \
+		ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+		git http-fetch --stdin file:/// <<-EOF &&
+	EOF
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	grep "d0|main|cmd_name|.*|_run_dashed_" actual &&
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	grep "d1|main|cmd_name|.*|http-fetch" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
+# Historically, alias expansion explicitly emitted the def_param
+# events (independent of whether the command was a builtin, a Git
+# command or arbitrary shell command) so that it wasn't dependent
+# upon the unpeeling of the alias. Let's make sure that we preserve
+# the net effect.
+#
+test_expect_success 'expect def_params during git alias expansion' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_config_global "alias.xxx" "version" &&
+
+	ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+			git xxx &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	# "git xxx" is first mapped to "git-xxx" and the child will fail.
+	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+
+	# We unpeel that and substitute "version" into "xxx" (giving
+	# "git version") and update the cmd_name event.
+	grep "d0|main|cmd_name|.*|_run_git_alias_ (_run_dashed_/_run_git_alias_)" actual &&
+
+	# These def_param events could be associated with either of the
+	# above cmd_name events.  It does not matter.
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	# The "git version" child sees a different cmd_name hierarchy.
+	# Also test the def_param (only for completeness).
+	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_git_alias_/version)" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
+test_expect_success 'expect def_params during shell alias expansion' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_config_global "alias.xxx" "!git version" &&
+
+	ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+			git xxx &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	# "git xxx" is first mapped to "git-xxx" and the child will fail.
+	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+
+	# We unpeel that and substitute "git version" for "git xxx" (as a
+	# shell command.  Another cmd_name event is emitted as we unpeel.
+	grep "d0|main|cmd_name|.*|_run_shell_alias_ (_run_dashed_/_run_shell_alias_)" actual &&
+
+	# These def_param events could be associated with either of the
+	# above cmd_name events.  It does not matter.
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	# We get the following only because we used a git command for the
+	# shell command. In general, it could have been a shell script and
+	# we would see nothing.
+	#
+	# The child knows the cmd_name hierarchy so it includes it.
+	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_shell_alias_/version)" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
+test_expect_failure 'expect def_params during nested git alias expansion' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_config_global "alias.xxx" "yyy" &&
+	test_config_global "alias.yyy" "version" &&
+
+	ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+			git xxx &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	# "git xxx" is first mapped to "git-xxx" and try to spawn "git-xxx"
+	# and the child will fail.
+	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+	grep "d0|main|child_start|.*|.* class:dashed argv:\[git-xxx\]" actual &&
+
+	# We unpeel that and substitute "yyy" into "xxx" (giving "git yyy")
+	# and spawn "git-yyy" and the child will fail.
+	grep "d0|main|alias|.*|alias:xxx argv:\[yyy\]" actual &&
+	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_/_run_dashed_)" actual &&
+	grep "d0|main|child_start|.*|.* class:dashed argv:\[git-yyy\]" actual &&
+
+	# We unpeel that and substitute "version" into "xxx" (giving
+	# "git version") and update the cmd_name event.
+	grep "d0|main|alias|.*|alias:yyy argv:\[version\]" actual &&
+	grep "d0|main|cmd_name|.*|_run_git_alias_ (_run_dashed_/_run_dashed_/_run_git_alias_)" actual &&
+
+	# These def_param events could be associated with any of the
+	# above cmd_name events.  It does not matter.
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual >actual.matches &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	# However, we do not want them repeated each time we unpeel.
+	test_line_count = 1 actual.matches &&
+
+	# The "git version" child sees a different cmd_name hierarchy.
+	# Also test the def_param (only for completeness).
+	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_dashed_/_run_git_alias_/version)" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
 test_done
-- 
gitgitgadget

