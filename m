Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1621C9FE
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769753; cv=none; b=FbaNG+uUU7UPgiCyxKHB9fXI5rfhvETTxPoWvXPzFszl68yK6uj8YClSaFZhRDqgLWsQ3Qr67XrD/oVkA41bkotpzrZzhTvtZTUh/tSH8yQ0LBmcZtvAHUg+tWyfouIHUUWfqjoPwP/rJKW1QZ88SpHsJnWaM8lqm7+W0U9NUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769753; c=relaxed/simple;
	bh=fMLaAj4ue+y57NE3H1NJGCvSW71XR73rnCTSoB8Vtqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmjXApkp2rNXV3IkkaqrkkdoMscruxr26V68SGz6Yp8yBs+FMdBPbuNUqd4R8ZE/KQv6AFuIvFRjMHKrHxzjIVcCuqlk+IOrBi9KxvpTd3MH7USGiKTRmyJ4oN1ItsT789CjNWS57Wo/JM+aZOG/GDkzO1qhp7Pky5+NlpHA/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hufG1pim; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hufG1pim"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e73e9e18556so5910952276.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747769751; x=1748374551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/jYmUj8lMIIoMP7fRwhxgjQPEZYtllxygIiaN8Nd0g=;
        b=hufG1pimxRvMYeJpStgcSQTUf5KuTBX+clM+HYdWxjpevjQJr2ctmNWcgMTOak3edm
         cXfocF9kMit3wFYk0QCmRyWI6B6GY1/AL+Jo+LqJgjyy25rV7SDgWUeOliK+rWQozSff
         ycuG1o4b4nHtNgieJRCvWAxA8tE45Bmbm4iuz9Ji84QZkeZDKhR0H1D1KLviYxbp2SV3
         MI4kuV9iwrir8qVA6LtyigI42Syq4febg6tIreus+qqa1cxgn11iR2+mAxHAWl+zf/p9
         SfMiUyoeJ5FqGDfnnMsalRpch9CP3aDJav2QhvUtt82Ttl/o880OTjI/ga+qL/qJox47
         GgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769751; x=1748374551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/jYmUj8lMIIoMP7fRwhxgjQPEZYtllxygIiaN8Nd0g=;
        b=IIq5f4etuxvASi3ubWfMzuvaSNbHCtLIqpWvNGhBCkiDEwR0+KyYV7/8mt9SWD/McH
         9za5QN8PE2we42JWecucu5BXpn09LG9d4fAGYLV4jyLP0i50YJbJC4E/8I3Esq5QxJzP
         OaaQbeTYf9TKFDUeiXCmMQgJlTvLQz69OzkEDxfM/TK1Xb7en4JoGY9dc2+NR5tco/j7
         9c404gHjOYTXNP+M+ubIpJ+sQPAkUTFLOezlSt1PCQCbC3bMimvX5mCFrnSahhSPEFa+
         +FFOnayTteUC1+WlJB2thUfT8nOnBM4odSlai74QUhsG9wSFaWCsLvK6L4CibMowcMPk
         yRyQ==
X-Gm-Message-State: AOJu0YxIJnMBmmdLs/21N6fYbUGXz88/85YYKboF876e6zEBp4Dqf78Q
	l6Pc9emx5CM7z+T/ehSQYaOaa9Evhv+GgCMtU86fkZnpmBrjix6kg+NYE/BwSy1B
X-Gm-Gg: ASbGnctVl8ETqKXQ+JrpujVGbkc9GUWETkMMYOAaupjWxSwEyN7zbxYy+bEsiYWpNac
	aIfX2FgW0x+Eb9313SXGaRaMUITzF0RS6VPpML3m8HPmP4NVbDO23xL/jDdyk0PSrqUOJJwSM4y
	eO1UmTxXTVE9Gr7d8OTphw8PZ/eZpeAnj2naI3sOSNwFjeTSpnYSQ/KisI2fp9Mhe8sKolDrKg9
	QdihYx20DOZiCCSgCeRUz9nbijLjrgQ/9uloTMgqhoLhk6jmYNlbMgVM71vMYJJxsE5SCSa6i7B
	stnni6i4jO5DF12ABHzzbZos4DTV4kuAUKpI540aEkghf5ZqapmAFIHUD+FiUaCPvCvKYEf0DB1
	a+WwVK6YVjX95+SFMQDsj9zcE2Q==
X-Google-Smtp-Source: AGHT+IE03go+MZlVHLh/dMPQxdzuh47wTAU5FibuVpcT554VE+A3DnT1ypEFJ32osrgrSLONwOe5Fw==
X-Received: by 2002:a05:6902:1882:b0:e7b:94da:575a with SMTP id 3f1490d57ef6-e7b94da58e1mr15038855276.1.1747769750696;
        Tue, 20 May 2025 12:35:50 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:41e8:72c5:601a:7e86])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7d597dd6e0sm131664276.26.2025.05.20.12.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:35:50 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ian Wienand <iwienand@redhat.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] run-command: prep_childenv on all platforms
Date: Tue, 20 May 2025 15:34:57 -0400
Message-ID: <20250520193506.95199-4-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only prepare the child environment on non-Windows platforms, but
prep_childenv is the natural interposition point for our subprocess
system to adjust the environment as needed. Use it for Windows
platforms, also. In subsequent commits we'll use this interposition
point to modify the environment on all platforms.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 run-command.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 8833b23367..dee6ae3e62 100644
--- a/run-command.c
+++ b/run-command.c
@@ -680,6 +680,7 @@ int start_command(struct child_process *cmd)
 	int fdin[2], fdout[2], fderr[2];
 	int failed_errno;
 	const char *str;
+	char **childenv;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
@@ -745,11 +746,12 @@ int start_command(struct child_process *cmd)
 	if (cmd->close_object_store)
 		close_object_store(the_repository->objects);
 
+	childenv = prep_childenv(cmd->env.v);
+
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
 	int null_fd = -1;
-	char **childenv;
 	struct strvec argv = STRVEC_INIT;
 	struct child_err cerr;
 	struct atfork_state as;
@@ -772,7 +774,6 @@ int start_command(struct child_process *cmd)
 		set_cloexec(null_fd);
 	}
 
-	childenv = prep_childenv(cmd->env.v);
 	atfork_prepare(&as);
 
 	/*
@@ -893,7 +894,6 @@ int start_command(struct child_process *cmd)
 	if (null_fd >= 0)
 		close(null_fd);
 	strvec_clear(&argv);
-	free(childenv);
 }
 end_of_spawn:
 
@@ -933,7 +933,7 @@ int start_command(struct child_process *cmd)
 
 	trace_argv_printf(cmd->args.v, "trace: start_command:");
 	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
-				  (char**) cmd->env.v,
+				  childenv,
 				  cmd->dir, fhin, fhout, fherr);
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
@@ -952,6 +952,8 @@ int start_command(struct child_process *cmd)
 }
 #endif
 
+	free(childenv);
+
 	if (cmd->pid < 0) {
 		trace2_child_exit(cmd, -1);
 
-- 
2.48.1

