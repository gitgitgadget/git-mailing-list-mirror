Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1C2AF06
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439114; cv=none; b=p5YoF2qHpzMC4EqUEuUkIgRWBuXJ04qYsqwzeopZFVAqi40rxBNIOxOHU+HR9hj4IUywrwBGQR8lmp41XUMBXhYex+yDAvEj6IYuYjJA4bal+3SCnrZemilbXDaTAYLnski0WU2dGLhW3+ln631rbNU8j8qKVxxQyLjK7dgQBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439114; c=relaxed/simple;
	bh=U0m4XZd1AIv+0hALXaomAxzQtOvWE+WerAViUgfyrug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePolZU0iJFtQSPT009Aviu5j/6nZj/wJcGExiO9y6eKoXhLPgkBzj5X/ur3Wp3sYjIM5DVhERe3tMJKzFYEFxLx54BvvTNfZOs/WOAXL1gIiBCN9MAGjW7vWRWAQ6MiNdN8iOVkpEja3Sn7LcRGF5AuXnq15wbcM6+dqHl35Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkBf948Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkBf948Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716439111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgX6Cu5E7N2apTEs4XC6U+2EvwrXfbifiHWF2oc97wE=;
	b=JkBf948ZW9hlg7QPFW/LQUyM5t/kDN/X66d169aNKf0Xg1XB439N43AGK6LB4CCokTa+WG
	iK9/VVTAF9t5OQ5hkE88Sh64aAvdEv3euwBpNyMlBEibryxt8SSMtr2HtZ4tuC0ScIrEpE
	c/PS1o/HaLENCxobUf6Pof6bH018owE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-UN83E2M_PcOdOR5gSvA4aA-1; Thu, 23 May 2024 00:38:29 -0400
X-MC-Unique: UN83E2M_PcOdOR5gSvA4aA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ab895ee028so12878496d6.2
        for <git@vger.kernel.org>; Wed, 22 May 2024 21:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716439109; x=1717043909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgX6Cu5E7N2apTEs4XC6U+2EvwrXfbifiHWF2oc97wE=;
        b=VanjWgd95EmObzCCjMqadLvlrVMegCATXfiQRRRmoer+8dci0U1fQFK+OjByNM7X2z
         exyfs+WSFd/YAHVoY+MvRc6lVeMwPInFI/dUJvhFON7pUv8gvTgehXBxwnQZV/RKBNaY
         nRavwmqycWYr6KEsVyx1Q6xs6dkLvkTuOPrhYDQeFepVEPl9oYyY4ll36QNkOa9+gfWX
         h27Q47ijixbFxW7KK/lMv8v9u5xO8h1hjQECC3Lm5fCZStTRl49ms2AfCkldfwhU+AGF
         5V/DozDG5ej7Fh0gnD/yEiFKknL/RRyY1DBYyILoCp44D6aMyp54y42CNER6quf0P+St
         680g==
X-Gm-Message-State: AOJu0YzuwdWD5VV2LPIlWtAVywnYEkZrv0Z/jXtIY/6MqWIHztdaruw0
	MfVRmhDibYIvf2teITQsu/DpMPyrdD3wEQKXsVaIF6+JkCfJ/tpPy/ljTkYYBB8xA5kgZCnmvjf
	AK4pzSc3y1NoZZmnofnoowKVt7jlgsEpE+3hsD9uRiG1sM7jotJHl5+4js4fZMzOoflqsdaJtrV
	nerRrAU1YSn3vC0kZymK6pu3naAVtw7cYdjQ==
X-Received: by 2002:a05:6214:440c:b0:6ab:656f:6a67 with SMTP id 6a1803df08f44-6ab7f3530f6mr33068086d6.15.1716439108982;
        Wed, 22 May 2024 21:38:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs2NKpkzqn79efUmd0ebv1LuzTWeMhtAAlXomZlu0c/JEoQHRU50VCNu5R/npOOZ04KPU9VA==
X-Received: by 2002:a05:6214:440c:b0:6ab:656f:6a67 with SMTP id 6a1803df08f44-6ab7f3530f6mr33067926d6.15.1716439108517;
        Wed, 22 May 2024 21:38:28 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a35969bcd5sm80952706d6.53.2024.05.22.21.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:38:28 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v3 3/3] run-command: show prepared command
Date: Thu, 23 May 2024 14:37:56 +1000
Message-ID: <20240523043806.1223032-3-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523043806.1223032-1-iwienand@redhat.com>
References: <20240523042143.1220862-1-iwienand@redhat.com>
 <20240523043806.1223032-1-iwienand@redhat.com>
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

Signed-off-by: Ian Wienand <iwienand@redhat.com>
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

