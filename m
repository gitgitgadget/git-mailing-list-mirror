Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDD26AD3
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720973074; cv=none; b=d5VrN8eRjurVS2ooYxT5RV5sxbh64DXtxl4W6U3g8bOCsVNqWgYy/iaN6mR/i+fjLBPt+NeH/EKHyOoODcE5yY5KMs6O99wQPjV2xG3F4+jfQgptQTohmHtJAOM4MY0866CfVfc6rix3Bx0vOdBE2paoFbzNFr9o3AbwNIZT7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720973074; c=relaxed/simple;
	bh=fNXegqUDwxgs+eMz5yiR/4ne8X7p5Hh0Qw3YZayAA00=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R3QLmsVQPjwXCNxwV9vV5rLyBGacYob6bKSSdiLidYsLNmyTUXxdyrDAkZX4xUTe26pT+c2klkwUa6xXitcrj5sfFhL573zyw70vsWifmLe61cZ6Ahrku+esgFDfJAejNdbQIgISge6S2ibFWcLwhdQTkiPjkUw3rNimgFWN/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIAo6Mdp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIAo6Mdp"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-78c84837564so794553a12.3
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720973072; x=1721577872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YHMSX46FOELsX2EgPGA/HPy2dBfN6dzGHsTHxlhZls=;
        b=dIAo6Mdpb9+grI3wFOwyy/kDp6bT+iJzaXEag4AMJYa4JLvyW2qLwK0Ahqsuunm7FR
         y/GV37khSjdNdYYiE7tckHaWy2vvlPjcuJx8N+LzIacyf3Vm/QhszMSNa/52HR50Ovc9
         cn3dyDigQFJrJl/xEw4vBvriE/+BFLqnOmnejz3B7jKAwT2Wr53eP01Omygyq3bxUEct
         68nZphwNmCRK3sNHImzwaV5neIH2QSMe1bKuT84a3d1/pql5Ns1k/hXdRYoDx3Dj3vZu
         848Y5/aisTIKKeviGjPh0zl8xNqApD75ip9vOx1hqHrkBeVt0ST8gL3lr7l/s8qGZrG7
         lugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720973072; x=1721577872;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YHMSX46FOELsX2EgPGA/HPy2dBfN6dzGHsTHxlhZls=;
        b=BrjxrO18sfo/1+hJCmPh1pkAEW7hVqf6budgc5lQ0o5GNT9JyXQwUXPcLfRiPOVI/k
         Cv6Fvk9L7KHvZBdZ/Xf7VUzTiye1qeP9OYm/fKVYO3EjFhpNM6cKiBIc35MsoGL6fing
         obKIGqOQkN5RHlFM8CIpuPvPKbmx0H+8r8kaa6D9YAxNqzKW/u1xX8scz1aP727kAxW9
         TjDG552Fe9igJd8Cy4iABkytstHF7gpmKKPzOGHP8Prrn3bj7FHAxf2V6jMKoobKgF+c
         HPLW0D3Vny2wU3z+/3ZIqdAF+iUKvaqm98bA4FuW3HwhQY+jhnyT4HQkwhsJ4kowBhFC
         m7CA==
X-Gm-Message-State: AOJu0YwE6ad1h0ddmsQDEJTl6P6J0csJ91E+ZNJyH5LLAG0BrVsn+tij
	7NKEQxM78Ns4HBCPWXvga06jxpW3GBkch+1S0X64j0FH1+PpA+Xj0f8XKA==
X-Google-Smtp-Source: AGHT+IHEwoyYUAHMMvlRLh+rSaPYwDO95eVIc/eaDp/cBc9fgj7hHsL2lLUS5SaQW3+RMAspLSwVPg==
X-Received: by 2002:a05:6a21:7101:b0:1c3:b1e6:d27f with SMTP id adf61e73a8af0-1c3b1e6d2bcmr9117160637.46.1720973071864;
        Sun, 14 Jul 2024 09:04:31 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd419b60sm4723244a91.26.2024.07.14.09.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 09:04:31 -0700 (PDT)
Message-ID: <f48ac176-9938-4677-a956-350fb50dbc0f@gmail.com>
Date: Mon, 15 Jul 2024 01:04:28 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/4] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Content-Language: en-US
In-Reply-To: <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since f67b45f862 (Introduce trivial new pager.c helper infrastructure,
2006-02-28) we have the machinery to send our output to a pager.

That machinery, once set up, does not allow us to regain the original
stdio streams.

In the interactive commands (i.e.: add -p) we want to use the pager for
some output, while maintaining the interaction with the user.

Modify the pager machinery so that we can use setup_pager and, once
we've finished sending the desired output for the pager, wait for the
pager termination using a new function wait_for_pager.   Make this
function reset the pager machinery before returning.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 43 +++++++++++++++++++++++++++++++++++++------
 pager.h |  1 +
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index 251adfc2ad..bea4345f6f 100644
--- a/pager.c
+++ b/pager.c
@@ -14,7 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static char *pager_program;
-static int close_fd2;
+static int old_fd1 = -1, old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -24,11 +24,11 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	if (close_fd2)
+	if (old_fd2 != -1)
 		close(2);
 }
 
-static void wait_for_pager_atexit(void)
+static void finish_pager(void)
 {
 	fflush(stdout);
 	fflush(stderr);
@@ -36,8 +36,34 @@ static void wait_for_pager_atexit(void)
 	finish_command(&pager_process);
 }
 
+static void wait_for_pager_atexit(void)
+{
+	if (old_fd1 == -1)
+		return;
+
+	finish_pager();
+}
+
+void wait_for_pager(void)
+{
+	finish_pager();
+	sigchain_pop_common();
+	unsetenv("GIT_PAGER_IN_USE");
+	dup2(old_fd1, 1);
+	close(old_fd1);
+	old_fd1 = -1;
+	if (old_fd2 != -1) {
+		dup2(old_fd2, 2);
+		close(old_fd2);
+		old_fd2 = -1;
+	}
+}
+
 static void wait_for_pager_signal(int signo)
 {
+	if (old_fd1 == -1)
+		return;
+
 	close_pager_fds();
 	finish_command_in_signal(&pager_process);
 	sigchain_pop(signo);
@@ -113,6 +139,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
+	static int once = 0;
 	const char *pager = git_pager(isatty(1));
 
 	if (!pager)
@@ -142,16 +169,20 @@ void setup_pager(void)
 		die("unable to execute pager '%s'", pager);
 
 	/* original process continues, but writes to the pipe */
+	old_fd1 = dup(1);
 	dup2(pager_process.in, 1);
 	if (isatty(2)) {
-		close_fd2 = 1;
+		old_fd2 = dup(2);
 		dup2(pager_process.in, 2);
 	}
 	close(pager_process.in);
 
-	/* this makes sure that the parent terminates after the pager */
 	sigchain_push_common(wait_for_pager_signal);
-	atexit(wait_for_pager_atexit);
+
+	if (!once) {
+		once++;
+		atexit(wait_for_pager_atexit);
+	}
 }
 
 int pager_in_use(void)
diff --git a/pager.h b/pager.h
index b77433026d..103ecac476 100644
--- a/pager.h
+++ b/pager.h
@@ -5,6 +5,7 @@ struct child_process;
 
 const char *git_pager(int stdout_is_tty);
 void setup_pager(void);
+void wait_for_pager(void);
 int pager_in_use(void);
 int term_columns(void);
 void term_clear_line(void);
-- 
2.46.0.rc0.4.g913e7f3d09
