Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1817582
	for <git@vger.kernel.org>; Sun, 19 May 2024 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716102796; cv=none; b=Szg6n1W7trNTMV3xENAocFATSmLv6LMPbg9pl2yX1Zgm3XJQmnrLC+mN2GqIF7ERL2CMgPv9/I/hsImrPA0TxFTROSmaRGIW8AaRI9TXShSmT8FZQdHM/T8D4IhdFKbcic581FNgxK2HCYpo8mVZ7vHzTeEs7U2OjGWXQb5OtvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716102796; c=relaxed/simple;
	bh=Im3qcJ8j4sCLVn7NozYQF/NavaRE8dCDuMUz5NiiyP4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fMTctFWzop0e8yN68xP65G7WsSzzHFCUN54/946P58gsWUtECz3iG3oQM6anwp9Q9sb1Ijo7LOGPwK0XSLeeSr9Bd9qfBqFUZoNsHIGR9iiFMILhTkajDW53O52dhPhazUHSDqqV6WTVmjJF2B0DYzPijfmkdNKzd2tm78pkgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtTb7GeX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtTb7GeX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso11932675e9.3
        for <git@vger.kernel.org>; Sun, 19 May 2024 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716102793; x=1716707593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrZRZaQhxGK/FyvET0HebJXkPi59LaWzmKAigbaNaKo=;
        b=PtTb7GeXhKcpxP7yiS5Xnu6RBifCxmhmgtskn8i/yOVXRHww6KiXSO3NwndCmq9t9O
         zq8fS0ahI66EWsgUcK0rxH1WZMRVijYmUliop4vjUbwAO7HBbh8un5aqGM7UotqSoM9f
         FMUkehMUb5Ft7TODn7ROuf8i1XFqp5jGvO9iySsxfsxJmEEznCXEyOeOlC5y2oqAT3F1
         fHKUBxQiesoTZ9samBpdJZhj0BlX/tgOxSDAZJOXV2Jq6NsPEV8JFSbv23UIUEutvmzJ
         +Va+fmIP1YJf/FR70k91jvGL/VTJOoaCpv1/+WFvBYzHUNw/ll8Lts4dKdquGBl7qlDh
         D/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716102793; x=1716707593;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrZRZaQhxGK/FyvET0HebJXkPi59LaWzmKAigbaNaKo=;
        b=H0ckKGyeSssSzL4H9dzOCQYdjkCdwXVGFp0sWJf/RSbZ8gNYme5IjM62q19/NuS+az
         dnp02xQf9bFL5rJDWl620d24Extc/xsx8q1wznx5fyPyhudDrQbZugjRxXuuDO4EKgvR
         P4qDDtRorc/NuYIS3BKRr3Iyk9+k9WLgRxovldbcW6dsk+AhEt6/pmnzaf25tlulPwev
         m2pKNhwg10UgMmEYD1b8XWFgyWD4pysLRc+nHwQI4Yh/ThboC/sRXrnMVjSaLttZd2Qf
         S4EuTc1L2LfOSI44N50kY8ugl1bWgEmsdphUVdineQRk8JqdX93udclS7VFiGtIEt+kR
         ftlA==
X-Gm-Message-State: AOJu0Yx4cG7E9Msz8t82GwpZKcdTeoCBffz3N1IOEgSx1SI8f8EIgYrN
	3xPtfYVUnG9uVdR2bLoWrtfVNbTLCVYCDKIbqoBonGw24W7C58t0RWLpGA==
X-Google-Smtp-Source: AGHT+IEppSnnGNuFMt4I3SixpxLnSPoUw4ApktetYBNGU2YxsVc46dB++MK9JkLQFSXYuKGxnNtb1A==
X-Received: by 2002:a05:600c:a41:b0:41d:7d76:ffd4 with SMTP id 5b1f17b1804b1-41feaa2f3e4mr187144185e9.8.1716102793320;
        Sun, 19 May 2024 00:13:13 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce24c0sm373347105e9.17.2024.05.19.00.13.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 00:13:12 -0700 (PDT)
Message-ID: <d090a84c-6bdc-454b-98d5-4310f8b73697@gmail.com>
Date: Sun, 19 May 2024 09:13:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/5] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
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
pager termination using a new function wait_for_pager.  Make this
function reset the pager machinery before returning.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 37 +++++++++++++++++++++++++++++++------
 pager.h |  1 +
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index 3ef6798f7e..2fa06c43c4 100644
--- a/pager.c
+++ b/pager.c
@@ -14,12 +14,11 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static const char *pager_program;
-static int old_fd2 = -1;
+static int old_fd1 = -1, old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
 
-
 static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
@@ -30,14 +29,35 @@ static void close_pager_fds(void)
 
 static void wait_for_pager_atexit(void)
 {
+	if (old_fd1 == -1)
+		return;
+
 	fflush(stdout);
 	fflush(stderr);
 	close_pager_fds();
 	finish_command(&pager_process);
 }
 
+void wait_for_pager(void)
+{
+	if (old_fd1 == -1)
+		return;
+
+	wait_for_pager_atexit();
+	unsetenv("GIT_PAGER_IN_USE");
+	dup2(old_fd1, 1);
+	old_fd1 = -1;
+	if (old_fd2 != -1) {
+		dup2(old_fd2, 2);
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
@@ -113,11 +133,14 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
+	static int once = 0;
 	const char *pager = git_pager(isatty(1));
 
 	if (!pager)
 		return;
 
+	assert(old_fd1 == -1);
+
 	/*
 	 * After we redirect standard output, we won't be able to use an ioctl
 	 * to get the terminal size. Let's grab it now, and then set $COLUMNS
@@ -142,16 +165,18 @@ void setup_pager(void)
 		return;
 
 	/* original process continues, but writes to the pipe */
+	old_fd1 = dup(1);
 	dup2(pager_process.in, 1);
 	if (isatty(2)) {
-		old_fd2 = 1;
+		old_fd2 = dup(2);
 		dup2(pager_process.in, 2);
 	}
 	close(pager_process.in);
 
-	/* this makes sure that the parent terminates after the pager */
-	sigchain_push_common(wait_for_pager_signal);
-	atexit(wait_for_pager_atexit);
+	if (!once++) {
+		sigchain_push_common(wait_for_pager_signal);
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
2.45.1.209.gd5886bf9cd
