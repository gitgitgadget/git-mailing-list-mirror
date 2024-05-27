Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE024A22
	for <git@vger.kernel.org>; Mon, 27 May 2024 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769948; cv=none; b=Ml3NBcCVjZ5MP21pyzmr1bjbvMgkxyH8qrqNgTEzD5nYvziheRYeCJZI513yYFRLz4+gstxXOLSok2GyIZ0WDYoYFIWEKmC+osTr0gxnH+1ausQe0qBsBEY1+wJHIvPO6Hqls2cSM5blctO5VBc9jBYpKx1N1jG5yZ+Emz2HV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769948; c=relaxed/simple;
	bh=yez0/WswF0A/selG5A1noMsTpFdgrU8U3xWiB8oScX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrMj7yP37oPKsozbTTjl3u2y0vcYpg4EsUrAsJXp6bUmddIinBb20KpcgOch0GXqUpZwa3p9MRKn5X6vL38yzGtF6zx1N+0XXWAZYJ2Or+uWVQtfoAw+zt00Y86axF1KG/CCi6Fi9noosdpiygJil9Xf5JxiZOvod4l5qaS3NOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEZEDWO3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEZEDWO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716769945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUCCHwN+r6suSAIUcyoOMqSGuU2xLdZvgZ67T8AdgjA=;
	b=MEZEDWO3Hb/cPkopbNP/Cc/kcOESraTBKvSGkvLPJRYnUtkfwbSXPvU6XZRGt24l7Wrk7g
	YgQgRYAOGTFamwb/GOyZ+RPIVjAbwETOppDiSWq9sZZZt/xdA75PWW4keeccf7tiQnLfyU
	7ruMyBD8OTV+QtCVhdCnQSmkkqpbqSs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-tjzyBd8WOj2N8HUCTUxjww-1; Sun, 26 May 2024 20:32:22 -0400
X-MC-Unique: tjzyBd8WOj2N8HUCTUxjww-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-794ab09eff3so360088185a.2
        for <git@vger.kernel.org>; Sun, 26 May 2024 17:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716769942; x=1717374742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUCCHwN+r6suSAIUcyoOMqSGuU2xLdZvgZ67T8AdgjA=;
        b=CVbd7nwdrsub0DQrVUD7MAoLKaVEC/fp/SgZCKEOSTbo8LqSEp0HhkAFQxJH7djbnU
         wyCLb2TY2ee/8CZeGbZ/6PTqDTyqmuJGViO3g/X50NzDyaL+Rfum6w7WPAqhNcT3eQtl
         ktL1BfN6Sa7gx2O65bXdIEuWbxunB/T4BWrLZ/z3gSTMQT/ITPkVQvI3ZdRJ9xGaVZ7f
         BThZEHePBvBTWeRvi7taqe3wacGpKmH+9W11yVIhsZ1Yeyn+jUi3DLeUgxY0AxDmAcDU
         bFFvHzgptcu5f++nG19I+2eL81b/NFhAUAQ3jr5rlDe9GRhLQX58WW7an5W3lfn29Sd7
         MAzQ==
X-Gm-Message-State: AOJu0YyXkdr1gbWCX3AlzoMPcvgu97c3C+R5tDZzTGf5P/9gDnQyCzTK
	T83IjVy6HteBXcOSXG32F/pmQ0P6bCo7TUpTtLL9fDgYQ/U6RohBXYWoyMOHLWMv1QEQczHX97H
	a3kMUUKYQC2e6dJrTtLd116CdKa2OZuQjE7PAeVRZrozNyeUILONWO9HyeWuAAJQx8qOymbxRno
	wDDz3qlqy1UJDsDXctwB/YBvb4e4OvuX9Wdw==
X-Received: by 2002:a05:620a:558f:b0:790:c7f9:4639 with SMTP id af79cd13be357-794ab05a965mr899813285a.3.1716769941775;
        Sun, 26 May 2024 17:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5SKVJDdZ14cAt3sOwyjsXRlZsnYp+uFrNseqrjaWVxFc535UWfoj/5V1Ak1HbSeElnTzqJg==
X-Received: by 2002:a05:620a:558f:b0:790:c7f9:4639 with SMTP id af79cd13be357-794ab05a965mr899811785a.3.1716769941253;
        Sun, 26 May 2024 17:32:21 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcdca88sm257509685a.66.2024.05.26.17.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 17:32:20 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v7 3/3] run-command: show prepared command
Date: Mon, 27 May 2024 10:30:49 +1000
Message-ID: <20240527003208.1565249-3-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527003208.1565249-1-iwienand@redhat.com>
References: <20240525234454.1489598-1-iwienand@redhat.com>
 <20240527003208.1565249-1-iwienand@redhat.com>
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

A test case is added to ensure the full command output is present in
the execution flow.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 run-command.c    |  3 +++
 t/t0014-alias.sh | 11 +++++++++++
 2 files changed, 14 insertions(+)

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
index 95568342be..854d59ec58 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -44,4 +44,15 @@ test_expect_success 'run-command formats empty args properly' '
     test_cmp expect actual
 '
 
+test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
+	cat >expect <<-EOF &&
+	trace: start_command: SHELL -c ${SQ}echo \$* "\$@"${SQ} ${SQ}echo \$*${SQ} arg
+	EOF
+	git config alias.echo "!echo \$*" &&
+	env GIT_TRACE=1 git echo arg 2>output &&
+	# redact platform differences
+	sed -n -e "s/^\(trace: start_command:\) .* -c /\1 SHELL -c /p" output >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.45.1

