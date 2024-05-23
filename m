Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D9273FD
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438129; cv=none; b=TaaSbqaewmkrMahRxVrvmFqhjxmJHyoUMORGdx7nHwK7eJZPzeHSiBnxBlZfXB7YW/wz5EQKL0zNV1LN7YtIphVpbnUEPkDmczfd3ZxzTmHRVvlTmld9IslcoXg7y7Wg4Y5btIJIrqzXUeShqqCjPXcPf8VIWiaEvdBI5+BP6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438129; c=relaxed/simple;
	bh=5UV8X0C1bHlWHIZWmdgc8u/RMDGllHb7PQDcU17PwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4eSHTvGBFQuagX4HZ4AWqjJJwhYLOJab3xruFMjPYN3gYJP4Dg7EorQo/qLxvwBy5tSAq6JQ2bKugOruVjnOvLJ3qbx2yheEtk3wpNPBBf1F7oXNl07ZVzeF928dvN3fJZlR5rYgpznoPpeRk7AC7Uu4GRLclwNZpggTTiwOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtjKJzyH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtjKJzyH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716438125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VO8ZpnP2I9ExOAtOfJGRxjkiuWI3o4kaK1wa7Ypiv0=;
	b=TtjKJzyH4JX8rV2OnYQmL8mwz2vLSfVE6h/boPoj+JzjEgbR4eZ9BsgcuOwZ6oXx33lVB3
	lYO5Dr5Ywr8oL1RSZWwMtT2fmOPVxm4qcML28DYcfJFCCF33VOPUUQx1cEuakosmtp+Q+7
	8I7lS9AmxTUMXSP8yCNV/CqnlB/Yrk8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-ZaDDMkuPOnC1kO_Ud7wYWA-1; Thu, 23 May 2024 00:22:04 -0400
X-MC-Unique: ZaDDMkuPOnC1kO_Ud7wYWA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-792ff352462so1141957885a.1
        for <git@vger.kernel.org>; Wed, 22 May 2024 21:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438122; x=1717042922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VO8ZpnP2I9ExOAtOfJGRxjkiuWI3o4kaK1wa7Ypiv0=;
        b=qaxsUI2+0uN+x7H56xebS0VeoHPDkvr5z5hsTuItXJxxB0sU3QMu54M+JVQJ6ps3Vg
         2j2YmolluOSNgQ1f7jhfZlmgbjF5jW29nX20/i4faPsvZyu7jsMD+mOhOhIYXsrbN9pp
         XXs1S1MUdAryaBP/jtfyE5SuIn6JewMcl2MCyEDX0h4HUtoKGUmVovqUM00THEHsZ7uM
         AWoejoPc4qS/wl+ZC7GFZ8lgbbRJ1QzhlFkd54eK5D9JAqc+Lz6LSVV2sIyIzaIRbZ2X
         L2Dy7Mq7sKTZ7oZfUD7C5nhYx1rtpPHplpE2Z6E8dZUEq80mw8zqhZXyR0xO6fOi8yv7
         WqNA==
X-Gm-Message-State: AOJu0YxKiHu/UxdwsPynF+mYDIL5aJHNxT0XqdUNTr5mUn2anrWuK9Mq
	bCgVOFTI/sugGuvI/mIQtnRvH1N23b3JGDTwx8L8TGRQ/zemhhLuLSDi427iEoJkudm+HxBTHrm
	gurr3+v1xQrhDxUUhZwfrxCa6g2K7UH9/hsPXmFKuWKhsl200U2cvfa9qAaP5m7dt27Ww1obwvJ
	H5GOKuq2IOPGas/F+qrF8QouhhjAsP0Cokqg==
X-Received: by 2002:a05:620a:350:b0:792:fa98:276 with SMTP id af79cd13be357-7949943e3d7mr356925885a.27.1716438122554;
        Wed, 22 May 2024 21:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0rV9OZDWDTurFkvN8eo9+NXQ+Y6Uq4bSZJhQu7mo9A/DVWj6gtfqYeorFECvh+A3tyTTAvQ==
X-Received: by 2002:a05:620a:350:b0:792:fa98:276 with SMTP id af79cd13be357-7949943e3d7mr356923985a.27.1716438121972;
        Wed, 22 May 2024 21:22:01 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794807f4465sm412760385a.62.2024.05.22.21.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:22:00 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v2 3/3] run-command: show prepared command
Date: Thu, 23 May 2024 14:20:59 +1000
Message-ID: <20240523042143.1220862-3-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523042143.1220862-1-iwienand@redhat.com>
References: <20240522024133.1108005-1-iwienand@redhat.com>
 <20240523042143.1220862-1-iwienand@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a trace point in prepare_cmd, so we can see the actual
command being run without having to resort to strace/code inspection.

e.g. "test = !echo" when run under GIT_TRACE will show:

 $ GIT_TRACE=1 git test hello
 10:58:56.877234 git.c:755               trace: exec: git-test hello
 10:58:56.877382 run-command.c:657       trace: run_command: git-test hello
 10:58:56.878655 run-command.c:657       trace: run_command: echo hello
 10:58:56.878747 run-command.c:437       trace: prepare_cmd: /usr/bin/echo hello
 hello

A "split" alias, e.g. test = "!echo $*" will show the shell wrapping
and appending of "$@".

 $ GIT_TRACE=1 git test hello
 11:00:45.959420 git.c:755               trace: exec: git-test hello
 11:00:45.959737 run-command.c:657       trace: run_command: git-test hello
 11:00:45.961424 run-command.c:657       trace: run_command: 'echo $*' hello
 11:00:45.961528 run-command.c:437       trace: prepare_cmd: /bin/sh -c 'echo $* "$@"' 'echo $*' hello
 hello hello

For example, this can be very helpful when an alias is giving you an
unexpected syntax error that is very difficult figure out from only
the run_command trace point, e.g.

test = "!for i in 1 2 3; do echo $i; done"

will fail if there is an argument given, we can see why from the
output.

 $ GIT_TRACE=1 test hello
 11:02:39.813030 git.c:755               trace: exec: git-test hello
 11:02:39.813233 run-command.c:657       trace: run_command: git-test hello
 11:02:39.814384 run-command.c:657       trace: run_command: 'for i in 1 2 3; do echo $i; done' hello
 11:02:39.814468 run-command.c:437       trace: prepare_cmd: /bin/sh -c 'for i in 1 2 3; do echo $i; done "$@"' 'for i in 1 2 3; do echo $i; done' hello
 for i in 1 2 3; do echo $i; done: -c: line 1: syntax error near unexpected token `"$@"'
 for i in 1 2 3; do echo $i; done: -c: line 1: `for i in 1 2 3; do echo $i; done "$@"'

A test case is added.
---
 run-command.c    | 1 +
 t/t0014-alias.sh | 7 +++++++
 2 files changed, 8 insertions(+)

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
 
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 95568342be..75c8763a6c 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -44,4 +44,11 @@ test_expect_success 'run-command formats empty args properly' '
     test_cmp expect actual
 '
 
+test_expect_success 'tracing a shell alias with arguments shows full prepared command' '
+	git config alias.echo "!echo \$*" &&
+	env GIT_TRACE=1 git echo argument 2>output &&
+	cp output /tmp/output &&
+	test_grep "^trace: prepare_cmd: /bin/sh -c '\''echo \$\* \"\$@\"" output
+'
+
 test_done
-- 
2.45.1

