Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE818129A6D
	for <git@vger.kernel.org>; Sat, 25 May 2024 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716680716; cv=none; b=CtJkSlOIkgEMsEdGe0kg4yMytpICrTOD/mAGM8GSsn8oA5/mSIRDhYQs3GC7KM2U9EI6GqDpadthMVzsHJ1u3wQ3surQCEVWuQZRFsW81vxmOYWvar6v4Donj8UzRfcQLbScBolDnY0/LOuepZzMukmMeGqJx4QGHz4fCxzhs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716680716; c=relaxed/simple;
	bh=2Wdrh2o1iOGV/xaMNdzXV9akzYZgfEwzecSL6U1Tf00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPpFwtCOSI/xYJW27XScngg4zzqz0ZWhtSPR0CzXBeCezPzEmV90j5LTKJXynCaaW53Ar27LFKpi14ozmjl4fFQ4zu8CXJ/M7TS3h+DxB5GpmkvI8Num89VjfZKDpsUbN01GZt+SseDA1DpolZL0b2DGFqT2IE7Bm3POGYn0+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCo8YYFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCo8YYFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716680713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8L0UL7f/syMFmiwYzpaW8axuQN3OmAYtAUqaWgvUpys=;
	b=iCo8YYFUSCiFaV5ZvZCPmv6Q0g3xS8LEQkz7izEuGAvBR8PUXOPK3d8jeeRcWf80LrQO6i
	H1UMtXO9exafFDEY6wEDxFzDiEYrath/hIzkBLf6PO774+omb0VvOSz+bgkPBwJYnhS9EP
	DX7BgB4hOS55+3lkESLQCbgPgeFBjfY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-BGL-LdGWOZ-LJ5vkvEJcag-1; Sat, 25 May 2024 19:45:12 -0400
X-MC-Unique: BGL-LdGWOZ-LJ5vkvEJcag-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6f8e4f0e3e9so476524a34.3
        for <git@vger.kernel.org>; Sat, 25 May 2024 16:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716680711; x=1717285511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L0UL7f/syMFmiwYzpaW8axuQN3OmAYtAUqaWgvUpys=;
        b=jlo5vF8cUIZIsZNOccmI4h+bt2Am2HQJhe4yAc7ALOFsm0VbHg8ts+ly7PqNFFhe15
         13jIFpeaYjjnbL7Vp6Ieg1KgajKn/Z1tg62dfkAKN7D63xn6KlU16akxz7Vfw4VsfGtc
         YQVwmMaueVq/9+MwO1JDoc+US+Z7AQQsePYXE0CTX38FGCJNYW8pkHK3KF+UJZlCWTMa
         wciDX2NkzI+mBoA65Dtelk/ttDVDMWyGafXxTNgTS8b7AVhH2Sduwc4SQPIpSYVe5Ijf
         +un3Ygil9ljVB4pBR/KjS4rkYqlWYnHJxiiG5YHtby3eO1dDFMosv0uOBX70qPrTMaHv
         BKFw==
X-Gm-Message-State: AOJu0YzN4n3FTFDTRX4JDU4ncTPYAWPHwnOF4lAI0B1JkSqHfBGntLTq
	9G9sBqiAr196k+pWX9HKddtANc3xwkNw6UMPAWl4DDj8Zy4ROaGLyuK/xoFvdJat8OwpHD8vID6
	qmYIbo5fX7tEkS9/RP7fvdQJS11gWVXI3RAuU0nosfuj6LfHljPDtCU6rPtDW1Xd3OB7JmVcrE2
	RaMHtLoUSjZ3wSvOW08wIkFPTbdO+8k9WeFg==
X-Received: by 2002:a05:6830:4408:b0:6ef:c0f5:366f with SMTP id 46e09a7af769-6f8d0b40ba2mr7106314a34.36.1716680711288;
        Sat, 25 May 2024 16:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPJnOk5k1LNCQEHKKwTkrH5eowhRFYcmtLyOFCCtSHRXO60oq4Ajog4f/pvGj2nLPlU2ur1Q==
X-Received: by 2002:a05:6830:4408:b0:6ef:c0f5:366f with SMTP id 46e09a7af769-6f8d0b40ba2mr7106295a34.36.1716680710787;
        Sat, 25 May 2024 16:45:10 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb182c636sm20553761cf.52.2024.05.25.16.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:45:10 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v6 3/3] run-command: show prepared command
Date: Sun, 26 May 2024 09:44:35 +1000
Message-ID: <20240525234454.1489598-3-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525234454.1489598-1-iwienand@redhat.com>
References: <20240525012207.1415196-1-iwienand@redhat.com>
 <20240525234454.1489598-1-iwienand@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a trace point in start_command so we can see the full
command invocation without having to resort to strace/code inspection.
For example:

 $ GIT_TRACE=1 git test foo
 git.c:755               trace: exec: git-test foo
 run-command.c:657       trace: run_command: git-test foo
 run-command.c:657       trace: run_command: 'echo $*' foo
 run-command.c:749       trace: start_command: /bin/sh -c 'echo $* "$@"' 'echo $*' foo

Prior changes have made the documentation around the internals of the
alias command execution clearer, but I have still found this detailed
view of the aliased command being run helpful for debugging purposes.

A test case is added.  This simply looks for the trace point output;
the details change depending on platform -- the important thing is
that we have a verbose log point, not so much the details of what
happens on each platform.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 run-command.c    |  3 +++
 t/t0014-alias.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/run-command.c b/run-command.c
index 1b821042b4..31b20123d8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -746,6 +746,8 @@ int start_command(struct child_process *cmd)
 		goto end_of_spawn;
 	}
 
+	trace_argv_printf(&argv.v[1], "trace: start_command:");
+
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
@@ -913,6 +915,7 @@ int start_command(struct child_process *cmd)
 	else if (cmd->use_shell)
 		cmd->args.v = prepare_shell_cmd(&nargv, sargv);
 
+	trace_argv_printf(cmd->args.v, "trace: start_command:");
 	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
 				  (char**) cmd->env.v,
 				  cmd->dir, fhin, fhout, fherr);
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 95568342be..634f6d78ef 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -44,4 +44,16 @@ test_expect_success 'run-command formats empty args properly' '
     test_cmp expect actual
 '
 
+test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
+	cat >expect <<-EOF &&
+	trace: start_command: SHELL -c ${SQ}echo \$* "\$@"${SQ} ${SQ}echo \$*${SQ} arg
+	EOF
+	git config alias.echo "!echo \$*" &&
+	env GIT_TRACE=1 git echo arg 2>output &&
+	# redact platform differences
+	cat output &&
+	sed -n -e "s/^\(trace: start_command:\) .* -c /\1 SHELL -c /p" output >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.45.1

