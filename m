Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1E4C6D
	for <git@vger.kernel.org>; Wed, 22 May 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345731; cv=none; b=hjupAo7KwGlajF8uxaMXGRAkOQW35FwiMUveUrTpsn/PQ1CX9ypcJF1muk4h7Nz9y3f69GNCW1kE/dAxheObZEX8FuSOP6/1/MN+2fMR7Upt9bQoeGFMSJDcTEYCgF97DXHV0ypnZMlUxvRr+kQDvp8FbQ/+Llg6/e03sTbCSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345731; c=relaxed/simple;
	bh=pBusJZSqpEindNZCKtiI3qQZeIhHNayV/iVv9tNk+kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8g0VNPxTyLku7oyJ5R4uyiIsRGsaEUMV29GEgOivsaC1rL0hKc0ApH8mixYp+rmtLgugQBQaqv4xVQlE/qgy8sYsfTgVSmMvRiYFZrm9OKKlzwqzPTu+TvSyqentYLlLvX0kIy8DolCZ+clxa1nJTeqChSqhSZ5hp9Loj9qFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A62xpzDQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A62xpzDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716345728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x5Pqj7p644zQEofzWYg7DBspY3955piKiEZ6bfkOGtU=;
	b=A62xpzDQqrUYHuuX94fOVnfLAah4xnlm0KSc8x0TXkFtGku0CWv/nmVmIpRgpUwS67eG7v
	nb0RbnzvTC6aOkGT16J+QNKXx5RSNgmkGtJUnEHtxqxHVMvo6M9xTd9VlLGNTzUSc82WZk
	1Fa1+Xg1l7j7+RhWSmiu9S8n6lzH1Go=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-YWVZwSYqNyKV2Au_82CkUQ-1; Tue, 21 May 2024 22:42:07 -0400
X-MC-Unique: YWVZwSYqNyKV2Au_82CkUQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-627e7734a29so2558497b3.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 19:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716345726; x=1716950526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5Pqj7p644zQEofzWYg7DBspY3955piKiEZ6bfkOGtU=;
        b=oWFORzBY55ZWqf9ufIGDqYxjqGYfionTlxrL2rPkqng04LX7ZjyFbERnWMMLfebz3C
         /SnXlsMCMAFNkqvP6ixGbYwo95+pujw8CdLS32RUeWN2GnRT1r9NLJo06fDlaBJaWz90
         INrKnQ2ZnefIGnH90AdtYgBhqvQsaRVReR9GJUuWbJLEaE9JJsodMP382RpqkUPlzNPX
         j2tRVw5mQEYvcn+O6X3AkbjKZhzTlEhKhioHEKa2my+GkywL5RCtMYyN2VGKU64dBNkP
         HJ4r0rGrh4lr0nF6HN52aiIYXShOSjyvJZSv25bqFHWQ0KXI4lo4JveBdDpu5OTVtefB
         5+iQ==
X-Gm-Message-State: AOJu0Yxn+vGYsz1CiHpetKr2JiKSRxLQBxAn6tDTFM+KSJn9P75L/byp
	ES9G1udtWJ7n+TC9lhplwoXYZzfVNCeYzP6JC+4/Mi6034mrSgCDgP8pCnn+2q1CB2Vzq1Wtpd9
	yKqFrTEsocwIIABuIfAB7BHRy47f9i1Y0+S7ukRReVO6pfe+k4S8hhGfvr0k2tlXAvTobuR6Wk4
	sfNFsYpvzwEmTmfPFLxrJkLhOLivpJmhHxmA==
X-Received: by 2002:a05:690c:6513:b0:618:ce0e:b915 with SMTP id 00721157ae682-627e46ebee5mr10721527b3.27.1716345726074;
        Tue, 21 May 2024 19:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZAs+pxh6qAIx8dMWYx8Gnm7geuxcIY1bokPsiRc1VOXU7Tu6r4V0SPm1/LkrGq/HixOBqNw==
X-Received: by 2002:a05:690c:6513:b0:618:ce0e:b915 with SMTP id 00721157ae682-627e46ebee5mr10721247b3.27.1716345725372;
        Tue, 21 May 2024 19:42:05 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ff09fsm128722036d6.133.2024.05.21.19.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 19:42:04 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH] alias: document caveats and add trace of prepared command
Date: Wed, 22 May 2024 12:41:33 +1000
Message-ID: <20240522024133.1108005-1-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a number of hidden caveats when using command/shell
expansion ("!") in an alias.  The command is exec'd, unless it can be
split, when it is then run as an argument to "sh -c".  Split commands
have "$@" appended.

Firstly this updates the documentation to explain this a little
clearer.

Secondly, this adds a trace point in prepare_cmd where this
substitution is done, so we can see the command being run without
having to resort to strace/code inspection.  e.g. "test = !echo" you
will show:

 $ GIT_TRACE=1 git test hello
 10:58:56.877234 git.c:755               trace: exec: git-test hello
 10:58:56.877382 run-command.c:657       trace: run_command: git-test hello
 10:58:56.878655 run-command.c:657       trace: run_command: echo hello
 10:58:56.878747 run-command.c:437       trace: prepare_cmd: /usr/bin/echo hello
 hello

For a "split" alias, e.g. test = "!echo $*" you will see

 $ GIT_TRACE=1 git test hello
 11:00:45.959420 git.c:755               trace: exec: git-test hello
 11:00:45.959737 run-command.c:657       trace: run_command: git-test hello
 11:00:45.961424 run-command.c:657       trace: run_command: 'echo $*' hello
 11:00:45.961528 run-command.c:437       trace: prepare_cmd: /bin/sh -c 'echo $* "$@"' 'echo $*' hello
 hello hello

which clearly shows you the appended "$@".  This can be very helpful
when an alias is giving you an unexpected synatx error that is very
difficult figure out from only the run_command trace point,
e.g. test = "!for i in 1 2 3; do echo $i; done"

 $ GIT_TRACE=1 test hello
 11:02:39.813030 git.c:755               trace: exec: git-test hello
 11:02:39.813233 run-command.c:657       trace: run_command: git-test hello
 11:02:39.814384 run-command.c:657       trace: run_command: 'for i in 1 2 3; do echo $i; done' hello
 11:02:39.814468 run-command.c:437       trace: prepare_cmd: /bin/sh -c 'for i in 1 2 3; do echo $i; done "$@"' 'for i in 1 2 3; do echo $i; done' hello
 for i in 1 2 3; do echo $i; done: -c: line 1: syntax error near unexpected token `"$@"'
 for i in 1 2 3; do echo $i; done: -c: line 1: `for i in 1 2 3; do echo $i; done "$@"'

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 Documentation/config/alias.txt | 26 +++++++++++++++++++++-----
 run-command.c                  |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 01df96fab3..a3f090d79d 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -21,8 +21,24 @@ If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
 `alias.new = !gitk --all --not ORIG_HEAD`, the invocation
 `git new` is equivalent to running the shell command
-`gitk --all --not ORIG_HEAD`.  Note that shell commands will be
-executed from the top-level directory of a repository, which may
-not necessarily be the current directory.
-`GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
-from the original current directory. See linkgit:git-rev-parse[1].
+`gitk --all --not ORIG_HEAD`.  Note:
++
+* Shell commands will be executed from the top-level directory of a
+  repository, which may not necessarily be the current directory.
+* `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
+  from the original current directory. See linkgit:git-rev-parse[1].
+* Single commands will be executed directly.  Commands that can be "split"
+  (contain whitespace or shell-reserved characters) will be run as shell
+  commands via an argument to `sh -c`.
+* When arguments are present to a "split" command running in a shell,
+  the shell command will have `"$@"` appended.  The first non-command
+  argument to `sh -c` (i.e. `$0` to the command) is always the alias
+  string, and other user specified arguments will follow.
+** This may initially be confusing if your command references argument
+   variables or is not expecting the presence of `"$@"`.  For example:
+   `alias.echo = "!echo $1"` when run as `git echo arg` will execute
+   `sh -c "echo $1 $@" "echo $1" "1"` resulting in output `1 1`.
+   An alias `alias.for = "!for i in 1 2 3; do echo $i; done"` will fail
+   if any arguments are specified to `git for` as the appended `"$@"` will
+   create invalid shell syntax.  Setting `GIT_TRACE=1` can help debug
+   the command being run.
diff --git a/run-command.c b/run-command.c
index 1b821042b4..36b2b2f194 100644
--- a/run-command.c
+++ b/run-command.c
@@ -435,6 +435,7 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 		}
 	}
 
+	trace_argv_printf(&out->v[1], "trace: prepare_cmd:");
 	return 0;
 }
 
-- 
2.45.1

