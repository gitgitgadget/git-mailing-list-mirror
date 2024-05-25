Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF33391
	for <git@vger.kernel.org>; Sat, 25 May 2024 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600146; cv=none; b=ZO2XeIt93FEIbY1Q9EvIVStuzbJKFfkdEpgOo7vIaEiF8/5NcBYBAqbqWAmPlCS7vAUff5bc+JYNN/rowjuPi0FOc7Z7NyoEq9cc0kh3tW1ooLRHQDeDVOqypU9EQbQYrcUMZg40WQz19hV+fnflNRJ9LEoQgmwdu8bMQUCrkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600146; c=relaxed/simple;
	bh=JI0JSSenzJoScZQtRlnx/zzXicQlXXYsaK18lBM+8sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjJeQI/MBXHAG0cdCNO9o+XShO+qtB/HgqwvGCDjVDeO1IWnjoE0xGz9i5jt910ThdHNgthRN8xozNddtocaj3BwVXj1w1uOFSRHPzr0DKN+bsCcya/XLn5xDmHeqo7iYr947El/+i+iphixTMT2qTm9y/otEaeN1YX3YJ//XOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QafTpg9m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QafTpg9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716600144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgfPt2o6pq/B1K+nzHLUtdowfTGR+xIywUSytWRHK+E=;
	b=QafTpg9mY5tS+BFNeFuQic2EoKUdX6Wng84OW/Yak7hvDi+zivYVq0ukMwAcUZ2fnu+nbf
	kb9htQyVgSDaELm8+yDYZrZvfkroGTPp0E6vRQOOi5UgM98k22y+rkVj/6aNtZ5Uf6jBUc
	Z/ENNewwPklhHXMJuyELSEYLci5Zuio=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Kx6anINQPyGRj53VHKH_-g-1; Fri, 24 May 2024 21:22:22 -0400
X-MC-Unique: Kx6anINQPyGRj53VHKH_-g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43f7eb72eccso28709901cf.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 18:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600142; x=1717204942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgfPt2o6pq/B1K+nzHLUtdowfTGR+xIywUSytWRHK+E=;
        b=ko0g5re12vD6krtlhGAbCY8WN+FPWxT4Vpr3BgLT8ThvVPV4OoEjYrp1c6i12rbiB/
         9WM9pzC7uKFpibs7fMWEdbTyzAgfmq6AGZUZd/xRt7KnyMTmSzZTwUuugKpcx9otJ35B
         J6CBGhUhh/+3XqYGhIBKDRCuU+kBhDFkRgnQPswlRq0WdzO4cOHwnBJZ2Wr2KqqvooO0
         Rwkj3DiqnOHU6T4e5KzJBGjKBqUY5Y8S41PwuoCYWOKbv83IF3EmdmRddlOz2nH+1qMj
         aqPRORvNk44DXajPaU6MmkVXq+Ts7omOHp3rkTaiwhMnbRHrjcA7hCTyWDgGjuBXDVIF
         tSGg==
X-Gm-Message-State: AOJu0YybdPGcIMN74JxxHRcgX3nmOIZhHJgxVNqVPahv0VElQiDJpFWL
	obC0+53DTh/3Enq6CNFc15hAsEhmqby4fNy+9+YkxLNxOfaEomcY9JobH38lS+zZfCTnIevWWJ5
	H/c1BOx+xw+Ie+uePmgtpMqTAYrkgmjrZfx8d63bdwhZhp/N/NETNPVsqWsM2rRX6Wm67Bkq74N
	G3VGv1RLyyIW1FPkWsmBrWvP3C27+hs8w4iA==
X-Received: by 2002:ac8:588c:0:b0:43a:7886:eca7 with SMTP id d75a77b69052e-43fa736ae92mr126847351cf.0.1716600141645;
        Fri, 24 May 2024 18:22:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHkM6EsEBJmmyqZ27NhZ5Fr+Wch2AzTqrNZL+oqvxSGgJ3+JKEUbU2fZZtAhdlSYJFk2XgxQ==
X-Received: by 2002:ac8:588c:0:b0:43a:7886:eca7 with SMTP id d75a77b69052e-43fa736ae92mr126847131cf.0.1716600141135;
        Fri, 24 May 2024 18:22:21 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b6a79sm13347841cf.13.2024.05.24.18.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 18:22:20 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v5 3/3] run-command: show prepared command
Date: Sat, 25 May 2024 11:20:52 +1000
Message-ID: <20240525012207.1415196-3-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525012207.1415196-1-iwienand@redhat.com>
References: <20240524073411.1355958-1-iwienand@redhat.com>
 <20240525012207.1415196-1-iwienand@redhat.com>
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
 run-command.c    | 3 +++
 t/t0014-alias.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/run-command.c b/run-command.c
index 1b821042b4..9892c4421c 100644
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
 
+	trace_argv_printf(&cmd->args.v[1], "trace: start_command:");
 	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
 				  (char**) cmd->env.v,
 				  cmd->dir, fhin, fhout, fherr);
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 95568342be..db747950c7 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -44,4 +44,10 @@ test_expect_success 'run-command formats empty args properly' '
     test_cmp expect actual
 '
 
+test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
+	git config alias.echo "!echo \$*" &&
+	env GIT_TRACE=1 git echo argument 2>output &&
+	test_grep "^trace: start_command:.*" output
+'
+
 test_done
-- 
2.45.1

