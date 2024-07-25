Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F217588
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925827; cv=none; b=bNhpyZ+4MNjMnVNdf5cfFGaaWn47sqZo9rzvIcHWTNMJfJgPUXBCC/QmWs0nPh/15dxR1e1vQTLFQXsYN1OjCZ3z4Y8qpFpJ92cEDy8b5t7NKZGcoiVEei8PRQTcieyaCLFcv7Fi+p0K43k9/fClejhSl3bSuiO+s0PRaohHfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925827; c=relaxed/simple;
	bh=Omf/eaV5LL5iuQcAXAPsgxBSSP9sAiaZ8oHmHevmAL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LpV51ou5l9c21Sge2zzhmBrzlIMZxKw0QtbiwPCDmNzxEdh2SYR1rw6kw0pHBtAYTa1QfJN6Im8zfESK4jXHJJNk3mwBMjKZxFPJivZJvspI7Kv84fvsG5P6Xc9LvF3C/v/yDU9oE3lUFVYHuJZ9S2hXJ+fW09SmZ/YvruZJ2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br1r7hMl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br1r7hMl"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368f92df172so641979f8f.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721925824; x=1722530624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2OT0opVs5PMG17etEgNDPC4DiGev5Ba7/9NVk+bnF54=;
        b=br1r7hMlVmh+uYl0SGwWtWPi+bbVLb2xJUIXobnOkkREWAn6X69oDsQnPua8K4WeC0
         BTCFgtWRP44MsMDL6aqstdRiZ41aPdkvHT91ccXwUcea7g8HbADDNNgJ6DZzy2XmjVnG
         ocTjqwZbiBAb2j5Sg5xtSWz4xQAgNZyRMtBQGUHNveC7EMIl5u4NW/kCgcu9SiLp2T7j
         68kuU8B8l6uGJdQP3kV7UQaIlrfuV3MFiUkJ063xftib1LEuEvpWDtLXgZ9BY8UXgcJw
         6JWNqRjiyc+Wk4hlXapCxPgVwVntsQYjz0Bdp6RBS9TdEn5+OBNOaM6aQPkkuYbyJVER
         TFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721925824; x=1722530624;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OT0opVs5PMG17etEgNDPC4DiGev5Ba7/9NVk+bnF54=;
        b=cf0GWr1UPJB3v+t3uPlGkyeT9lEiN7f5CPBJuibgubu35XH0nfPGJ35sp2gzVG6ilp
         H+xw91/LBkBPcnUqsM+dyOQE5P9jYpV5uMqzXvr6TCPL46ZLoHSlnOrJJfCFrRl9sxh4
         iXknNusBwKEi/KgGpg8eFZO2WJzpeKDjSCweeXlNDWfu4N0+KTjLNmnVDtFX12JsI9e4
         haI1FxHgfrBagpRfaC9rEIKjyMmYbqQIaAvS5SEpW5f6tRBhE+83EOkIr/+H4mdbuvLL
         hAkxV/lChHbUsf+sQf5uqsAHpT9wZ9h4Za0YF59ulU+dBe0Hg/ND2JihYvEQ7nzBa4y7
         PlsA==
X-Forwarded-Encrypted: i=1; AJvYcCXV1HBVrmjqcRvnI675l/MHCbdpBcPi5+qLJCws/NQOmeMIK3Iuuc6h7XyCcBjTA42CCuzR+pJvJRgRV0K0yEvFc/H+
X-Gm-Message-State: AOJu0YyvqRDHSFIcpWDgjX7EYO1drOW5uq2/8R9pqwuFDUfLzp0sSbMf
	ojHf0n5tzs+5zb3hB8XCNkXw0MuFhBmwt0LF9xusXlwcMsRso3nP
X-Google-Smtp-Source: AGHT+IGxUYIklsSOpxSFw7thaJofIFb7lMy+38lZNLx722p/8zUgSsa5E8BRsRuX4A5hBEWirRM9ow==
X-Received: by 2002:a5d:6dcd:0:b0:368:420e:b7a4 with SMTP id ffacd0b85a97d-36b319d9f50mr2551620f8f.4.1721925824141;
        Thu, 25 Jul 2024 09:43:44 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427fb7bdfa0sm73637625e9.14.2024.07.25.09.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 09:43:43 -0700 (PDT)
Message-ID: <2ec2a894-a173-469c-8211-ac5f49a82a27@gmail.com>
Date: Thu, 25 Jul 2024 18:43:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com> <xmqqcyn1lcjo.fsf@gitster.g>
 <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
Content-Language: en-US
In-Reply-To: <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since f67b45f862 (Introduce trivial new pager.c helper infrastructure,
2006-02-28) we have the machinery to send our output to a pager.

That machinery, once set up, does not allow us to regain the original
stdio streams.

In the interactive commands (i.e.: add -p) we want to use the pager for
some output, while maintaining the interaction with the user.

Modify the pager machinery so that we can use `setup_pager()` and, once
we've finished sending the desired output for the pager, wait for the
pager termination using a new function `wait_for_pager()`.  Make this
function reset the pager machinery before returning.

One specific point to note is that we avoid forking the pager in
`setup_pager()` if the configured pager is an empty string [*1*] or
simply "cat" [*2*].  In these cases, `setup_pager()` does nothing and
therefore `wait_for_pager()` should not be called.

We could modify `setup_pager()` to return an indication of these
situations, so we could avoid calling `wait_for_pager()`.

However, let's avoid transferring that responsibility to the caller and
instead treat the call to `wait_for_pager()` as a no-op when we know we
haven't forked the pager.

   1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
                   2006-04-16)

   2.- caef71a535 (Do not fork PAGER=cat, 2006-04-16)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 pager.h |  1 +
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index 251adfc2ad..896f40fcd2 100644
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
@@ -36,8 +36,37 @@ static void wait_for_pager_atexit(void)
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
+	if (old_fd1 == -1)
+		return;
+
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
@@ -113,6 +142,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
+	static int once = 0;
 	const char *pager = git_pager(isatty(1));
 
 	if (!pager)
@@ -142,16 +172,20 @@ void setup_pager(void)
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
2.46.0.rc0.4.g6f4990c0d4
