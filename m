Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498E13B78A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447104; cv=none; b=siDG2Mt/eoIDohhd3kor5UpxhMBCOZmt7lF/25OJecreYlgGTFIkg9YTNVBnY+8NLxJqLtslGCLxZi2Psow4+LLbSx5WAupO5tMuoCA6uo0nym3hu5eMdA2JJfhwarlcTB8DcDJ1YEK0SPeCXQFj1Oci3Hbqxwlz6VW4jtyNT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447104; c=relaxed/simple;
	bh=q7MLXEzp+e1hVWI+le4SbfhDrsoCTTlIu34x6EM7iHQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XhRIzRXRuspE0JcXFbxx2T142K5NPHcLCwyHP+thjocBTe0yI82Cab+MYL9T51kJOpqEdf5GihZqze0QbOhyJ91Jy1EeYOI4l1gNNfG6JgYqTEzmCtcPW7oQtaOT/ieGDAo9OyPspv/YU1CinK9D0AN6CE1uEeNXtvNOPtSzLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hATcYlik; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hATcYlik"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35dd0c06577so3540743f8f.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717447100; x=1718051900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2aMAmJmJ4CpKAM0B/DGMf81IvLZt+/q3msMuyfNWNM=;
        b=hATcYlikhnTYafT4BXcozgozFkRKIaLCOe7gbxzcaQQa19lUce2L8Crv3MXxS5zcHU
         R2E9a60CejpG3O+VXIOQzmzABKZs7ZluDciJuFG5LWxURWxa3RsiuCfIAbE2PFBp+X7p
         R+iaI+TKJoz2MwBAvmkYJOqGoUJTxTJK4tcQuvX13m21McF2B0p1PFmrdj2o0+0nYAaj
         O9WdYrLDIYoCoP6489IQXrRYG2NCyYSsRzc/Y+MgkbglMD1zZlIZcIwmHLJkIAQ5U9oC
         9lAWjvGhye4QCKrAno154WP3E+yDKRmvBIEIi9nVlk7IkdOTXXhR6KkuCETWfzjDjmIY
         h5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447100; x=1718051900;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2aMAmJmJ4CpKAM0B/DGMf81IvLZt+/q3msMuyfNWNM=;
        b=ITGTEuQLGmANXQptbsnLX9ejGDAqDvmPGjJxGpwzTT1XWiC9mejkApXsa3EaeA01C6
         KKpF01JQ3XR4OBthmINKugE1hU/WmAL6CRmMAidS+DEPcAjTY8vBKLT06uxcG8zu5AKU
         aKHaEex0qHSy/vLp0FoOsl5aJCpu9LRcZR8sfqrXWCdalGLxu8repempfI0VpoFkxAdT
         5q6JypUwWu7+huwJ9uhckC4IjTyf3epBOA+2PlDFo50DgNZdhSyZs4f3WfCAYP8mA1CJ
         WwlvrB4ErTq5PdH4sK79k8nnhcuKOd1mYRUu/ziKiO40f8pVTMSOmP0Asr+wGK9lc0mM
         Zmaw==
X-Gm-Message-State: AOJu0Ywb8YYUr3fXZC4Fd/oCa0ulJNz5LD7XKCMF4T2qVXRBUzQBCTw/
	QjlBIC7CzkW5I+eqM+DExrzJSR8wGbuFxBE7AONfC0LhrodEjqjIedG35g==
X-Google-Smtp-Source: AGHT+IHnGKjqPkKcnbbWDFqKfnXMoFSchcbGjYJU+hT6Xu4Zc57BP7dnawg4DSljAbULs7Tq1O+KcA==
X-Received: by 2002:adf:cf0f:0:b0:355:3b3:f1a3 with SMTP id ffacd0b85a97d-35e0f25e5dcmr6215012f8f.7.1717447100588;
        Mon, 03 Jun 2024 13:38:20 -0700 (PDT)
Received: from gmail.com (20.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e52ec4616sm5609316f8f.4.2024.06.03.13.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:38:20 -0700 (PDT)
Message-ID: <76c725b4-1bc4-4916-81d8-98cad8fc4ca0@gmail.com>
Date: Mon, 3 Jun 2024 22:38:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 3/6] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Language: en-US
In-Reply-To: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
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
 pager.c | 36 ++++++++++++++++++++++++++++++------
 pager.h |  1 +
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index b786601074..925f860335 100644
--- a/pager.c
+++ b/pager.c
@@ -14,7 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static const char *pager_program;
-static int close_fd2;
+static int old_fd1 = -1, old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -24,20 +24,41 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	if (close_fd2)
+	if (old_fd2 != -1)
 		close(2);
 }
 
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
@@ -113,6 +134,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
+	static int once = 0;
 	const char *pager = git_pager(isatty(1));
 
 	if (!pager)
@@ -142,16 +164,18 @@ void setup_pager(void)
 		return;
 
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
2.45.0.97.gb691764a17
