Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4B3307B
	for <git@vger.kernel.org>; Fri, 24 May 2024 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536077; cv=none; b=X8cGNSDBtw0m7cYu/Txa8ZN3qTxp4z8rPLzPlY27qQU50cZrH2EgEQbrDbhqkwJrucuI90S2v1n2/qwqfNG8z4LMHlCWFQ94ZEcZlAObZ50cxQ61Mh71LvRKR+nf/KaT06olBK3p8xCkeTdGYIQRnMXG0wy/COOTofu5ygAQt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536077; c=relaxed/simple;
	bh=3C9xNd5+0llTR6pS8OEf8G55WpH1tCpvQcGg5SgpmK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbQxJqqTlQBJ4aTZ+5jgvn4DUxSWfbizXZj5GVnxB3J/QilY/+WdV6sL6y7l70PvCrKRJ11GcF8umLuiBQrv+aZVnN+sIwSpYyCDM1S2mAT3/i71r2y9rehiQdAqLjNw8yu5HYNvQqZB9nNG9N33oCrrGJ53QtCaBeTJNqesKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btndI4Qs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btndI4Qs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716536074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t6EbyvMAGZNSN0LdW8Vx3hyL/VkHnKPDXbGOTFtSgws=;
	b=btndI4Qs5Ch8sMNIE9cMrqGi/Z4JNPlz3KfT1Rr4mQJx8IB/iKwx5RYN3LLdQTyrmEUFG0
	qLUzJkn9nUBlG86bFFIgL8MJZ7gMsMOW0BxzriJTLQOnuKOPMYDs0oye+eg+f32BrI+C5r
	wWI1V6NDqLe2pKnCdUlpve/tIJvrqGI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-1Q-Li0gxNouOKnCq0T0rmQ-1; Fri, 24 May 2024 03:34:33 -0400
X-MC-Unique: 1Q-Li0gxNouOKnCq0T0rmQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ab9d01cbc3so7590326d6.1
        for <git@vger.kernel.org>; Fri, 24 May 2024 00:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536072; x=1717140872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6EbyvMAGZNSN0LdW8Vx3hyL/VkHnKPDXbGOTFtSgws=;
        b=PoqewGtagbAo/cJcR3vpVztFrrkA7huYTcc+4xmP4AUPJduBhjRY2b74Hg2+/1PLMb
         ulYSOB/qBWPebWPft8rt1ShBF3pr+faGdF9YeuKHU66V0FvALi/+Dvy3D+jlV6DqQem5
         uuHaCseAX6avKLk740Se4N1j+2qYzsTdo/NWSuozDLX6y3TOGY71lshsub70Imeml8Ek
         rXpcIhazKAPDvdlE5JaV3YaGBVWssHw19uuDtbi5Bn0nylgV/CMTg8XVGztEx6mR3/tH
         38FB5lpzIfhs3xltP47AvItDGPByNZArWZtPWWTc+g+LVk2T/YSb9pjUyKYtfFeoG052
         8tRQ==
X-Gm-Message-State: AOJu0YwA6UQJgNuZDe1y7f2zAKh6mNAXsdz1xyZbwTS/j90fmdNavXAf
	a++Wmgtz8ilz85KOAgBDJ30MzqSKd9dF3/7or0Qh2DkV8tWc7pnAmRGFv7VOwAM+QYaCb3wexmU
	kZWIOap86lPAY276rWhv+TnPY/Px1MMRFzZiDCOwFhz19dDFJoMKfSJCCvx4OMrR1g+sJaGX1fS
	UTJBT7il2s1GrtUgm+ZkE+vz5DnMzwi9bGJw==
X-Received: by 2002:a05:6214:4604:b0:6a0:c339:1ede with SMTP id 6a1803df08f44-6abcd0b54efmr17624386d6.40.1716536072249;
        Fri, 24 May 2024 00:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqoZP6bGdZtFKyNSi/LThSrSRtLiYTNynnl2xwdsj5uhGkjavtOr3aNt7o8KlUf1hU4INxwQ==
X-Received: by 2002:a05:6214:4604:b0:6a0:c339:1ede with SMTP id 6a1803df08f44-6abcd0b54efmr17624236d6.40.1716536071835;
        Fri, 24 May 2024 00:34:31 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac0710865fsm4893356d6.71.2024.05.24.00.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:34:31 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v4 3/3] run-command: show prepared command
Date: Fri, 24 May 2024 17:32:44 +1000
Message-ID: <20240524073411.1355958-3-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524073411.1355958-1-iwienand@redhat.com>
References: <20240523043806.1223032-1-iwienand@redhat.com>
 <20240524073411.1355958-1-iwienand@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a trace point in prepare_cmd (for windows,
prepare_shell_cmd), so we can see the actual command being run without
having to resort to strace/code inspection.

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

Prior changes have made the documentation around the internals of the
alias command execution clearer, but I have still found this detailed
view of the aliased command being run helpful for debugging purposes.

A test case is added.  This simply looks for the trace point output;
the details change depending on platform -- the important thing is
that we have a verbose log point, not so much the details of what
happens on each platform.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 run-command.c    | 2 ++
 t/t0014-alias.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/run-command.c b/run-command.c
index 1b821042b4..13e35fb76e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -296,6 +296,7 @@ static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 	}
 
 	strvec_pushv(out, argv);
+	trace_argv_printf(&out->v[1], "trace: prepare_cmd:");
 	return out->v;
 }
 
@@ -435,6 +436,7 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 		}
 	}
 
+	trace_argv_printf(&out->v[1], "trace: prepare_cmd:");
 	return 0;
 }
 
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 95568342be..b7affbe93a 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -44,4 +44,10 @@ test_expect_success 'run-command formats empty args properly' '
     test_cmp expect actual
 '
 
+test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
+	git config alias.echo "!echo \$*" &&
+	env GIT_TRACE=1 git echo argument 2>output &&
+	test_grep "^trace: prepare_cmd:.*" output
+'
+
 test_done
-- 
2.45.1

