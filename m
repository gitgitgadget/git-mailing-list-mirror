Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7913282FD
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074919; cv=none; b=FzHZo6ajufU/iv1wcttEQcNpuF1GDgKqbG2Y/4ioHUKA/PiGZ73MIFbhzxafDyKesnyMIn1TOV4mwcp4UEJTzmloYo+zkn6+GhxkxNYhH0JDkCmXOL8fJh/nwOAJbd2yLQDHqIgpX+O/JBLOE4t0EaKo101ySRdn2i0AOnXzsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074919; c=relaxed/simple;
	bh=eybTNNn6GOol/ZFna1blhl6Xq7kTJBAXEbY6ShWv2Bo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k1CEK6VT9B06a4kJ+r4zvt6ZxL7LysEEfJkrhxbvVNBnn8kQpRTqXam0i5VRthHgM1gpE7nqZQqzwltt65I4lNEfn/LoI0og1pe6+Ekwp9CkFTqCrHZoUVNnGuyFe2bNtR8gsPPraQcrk5rBz8lWdP84KGHtXOQl0Z/J6SiKn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJadHj9q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJadHj9q"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so2959128a12.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721074917; x=1721679717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jP4uRA8QRVuvZpKig1R/AhI0LJi2scYLcSpl9be2erA=;
        b=dJadHj9qECN9eHTz+88vLKbvEyD7YVJIh81UQ+qLZD2pToqTDPTOjGsEaoGUDPUpZE
         xrxxlUCEzSYUFRI9cRYGMdFfEgVzOgZth+sikkLFuyNWysz0088I670/SYe+v/GQYDwL
         jxh9jRSLEFDSDZcsBfMcnTiGnCUMfUEBL6tIU9/cn+qwdCjE4X+CelRyxBZPy634v+I+
         lvekK8F4nNPyGBT1CioGcmU2OdFiXKrNvWW8v7ZVocvVXmObL8vPFCuULCEjTnz+Gy6Y
         eYrse9C/k5HDt5oUMKmRCDIYShPGhXkIaX2rwdBht05+MUy4klxHclZh+LA5dgChMGwk
         wx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074917; x=1721679717;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jP4uRA8QRVuvZpKig1R/AhI0LJi2scYLcSpl9be2erA=;
        b=IdEfrq/gOrYLNIsEvbQBAIFC8PkH1MhbSAOEaDtPd0+qSGG16tFj9H5r0h8kIKt9cd
         cWCkLM9yiAvapYT5gkNNWrP9+jN6GJ/DvVBSelFm8NaWDpES7VOqWSd1kKKnG6ERm29i
         nxF1l7TEIAwuPfDXfw5ITrJrWPA4ySHg0kcuXEOUK8iUV952nqGX5fH7RpzRzCjk0OrH
         7Tu13jDObqbUm9fLp7IWdp63+t2hjt+NBTZxHSmoCl23C6zdggEUWHRgDNWU82TxH/An
         KVCPkubD1X9B0uHojKWTWeFt9wcICBB9VB4l7soaFZTZbWm/NECRhQIR99QKiCCMXJXs
         v1MQ==
X-Gm-Message-State: AOJu0YxDNo6yU8r7olPI7OCCWEkFf8BBKXv+7T68N22i5fMFK4wd+lgn
	gdigPmUjxEJOPNfzMXu/T4WATqmpkBYG/fGqqDgh2QDnZCF76tFaQpOVHg==
X-Google-Smtp-Source: AGHT+IH/5nyX4o0OWpmvb5SaaS1VnPIl/KPeJHcIjfa+pZJDWzpSPWrhCDgoPhL6UOznABK2Gb/kXw==
X-Received: by 2002:a05:6a20:43a2:b0:1c2:905c:db0 with SMTP id adf61e73a8af0-1c3f1242119mr45949637.33.1721074916915;
        Mon, 15 Jul 2024 13:21:56 -0700 (PDT)
Received: from gmail.com (p4453252-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.169.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc382dbsm44971435ad.197.2024.07.15.13.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:21:56 -0700 (PDT)
Message-ID: <bbdce408-230e-497a-ae05-ad9be8f3e70a@gmail.com>
Date: Tue, 16 Jul 2024 05:21:53 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 3/4] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
Content-Language: en-US
In-Reply-To: <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
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
2.46.0.rc0.4.g229d67bbd7
