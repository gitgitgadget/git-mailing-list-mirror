Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566C8BFD
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719012670; cv=none; b=LRQkZwfeAN0Y6DIiASLdzB4Gy7zrpJhp3OYgm3CF7tQcxP+jzH7sU2msv7mbebIvS0Ywl+AJZHUGpVc9tnzDOvalXa7zAGukg6VG87xYZgdQc+SiQwYONNO0F6tshRKojLSlWxb5Mcwj7T5Y3xGpVanUZkPegO96icf3oSJmi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719012670; c=relaxed/simple;
	bh=ZwAiB2FFBhVTGopsbvYO6Lu+ByJDTP6WJqTOSYJVlGY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TRbe6iqzbx8jsur/7YDuYWdFjQrx6fBhY6raznvz+A2pL49+cdtoEGMtjI+SjaizNeY7+XcnahklQOYgXRTGUWh9n3UyVqd+OjVJM3ZfusqyIwzBkpnI+Y9xHg7cbIoJUJalIpjVPtLVZooI6c7vADuCVN4fhVW4F7kqqSQQ4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTtc43Rl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTtc43Rl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3645e9839b3so1894964f8f.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 16:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719012667; x=1719617467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aUNeODFod3L6LXjV4E8gsS/TLM0Zla7C899gdPWEHkA=;
        b=LTtc43RlXTvNwKH7xUbk1fM7f01x9lD44CD0Wi+U3eN+M75CRlfN9fj1owb0OIJrjQ
         2LQB4kIau7jbj2G3e344vLflwomrdkWrsk+6CqJ1wWeXP7Y4acORPPSDwGEIhhGtun/B
         GSzybHlK8WhCpNZ/5TxwEWoT1/CCHB9U0rrHCz0P+xcBXa1svLxW9Bhv50zL7s0p8hQl
         GeMhqTUjPxebRs9ERSiTBenwc8zkUewFIhbykl58ZHfPvteAUGKSS7wyWgSTde4zGUdn
         27ukBZtGWvyx4tin466CNc09M4wqp4ycPGkfnu80zChCV7VMrxwOYmLKISHixeE8488s
         vwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719012667; x=1719617467;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUNeODFod3L6LXjV4E8gsS/TLM0Zla7C899gdPWEHkA=;
        b=hassJh8evNbBHnkURMFU/ufW3Z48GtOXPCdR4Ndin1XrnCAhre4Tkqrpj8Ft92O5sN
         Wgo7EcaBC9mqVMpSQJerMWxDgyzuJOtnIbNgyWvAeno8H8OcdtWUZSKdga8aHaobxN53
         YILcSIGjReaSCJsKR5iFtZt19sNbOw22EtRSFtROSZk3KI8RHVIs+VGFYpz4YcYmxAEa
         eeCuvVCDMeTsno0CDu5383RB6KIIDUNwD/pJfFfIGzj01Kdst8puSoB1s4uzCtlMwhCF
         RbM60NWm1eFG7UVcmgpaaLnoMYj9BxCdl7KZ1/ojfoFRxHP2KXjWAIhw1qdLLDB+EHi+
         ZJQw==
X-Gm-Message-State: AOJu0YxlJDdAuUGdS42rbYeSyWMSgqcSdTl2Rptqy6/LDJLXHyjoC9uq
	MEUYoLptYM79jjghkqM/5BwesW6ifnfrZVOHvw2FGgut9fqpYMprAxjcQA==
X-Google-Smtp-Source: AGHT+IGaB3SUu0V+ZHlx+xSde1jVRSue+Uv80mNaPN9ZoyA4SLyfgb7+sO+37WXw+TzxFbBsVdwrXQ==
X-Received: by 2002:a5d:6152:0:b0:360:9e06:c374 with SMTP id ffacd0b85a97d-36316ff8043mr6458180f8f.8.1719012667106;
        Fri, 21 Jun 2024 16:31:07 -0700 (PDT)
Received: from gmail.com (229.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f670csm3008055f8f.11.2024.06.21.16.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 16:31:06 -0700 (PDT)
Message-ID: <6850f558-ad20-403a-ae1e-5b9826c53790@gmail.com>
Date: Sat, 22 Jun 2024 01:31:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] pager: die when paging to non-existing command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Dragan Simic <dsimic@manjaro.org>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <0df06a80-723f-4ad7-9f2e-74c8fb5b8283@gmail.com>
Content-Language: en-US
In-Reply-To: <0df06a80-723f-4ad7-9f2e-74c8fb5b8283@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When trying to execute a non-existent program from GIT_PAGER, we display
an error.  However, we also send the complete text to the terminal
and return a successful exit code.  This can be confusing for the user
and the displayed error could easily become obscured by a lengthy
text.

For example, here the error message would be very far above after
sending 50 MB of text:

    $ GIT_PAGER=non-existent t/test-terminal.perl git log | wc -c
    error: cannot run non-existent: No such file or directory
    50314363

Let's make the error clear by aborting the process and return an error
so that the user can easily correct their mistake.

This will be the result of the change:

    $ GIT_PAGER=non-existent t/test-terminal.perl git log | wc -c
    error: cannot run non-existent: No such file or directory
    fatal: unable to start the pager: 'non-existent'
    0

The behavior change we're introducing in this commit affects two tests
in t7006, which is a good sign regarding test coverage and requires us
to address it.

The first test is 'git skips paging non-existing command'.  This test
comes from f7991f01f2 (t7006: clean up SIGPIPE handling in trace2 tests,
2021-11-21,) where a modification was made to a test that was originally
introduced in c24b7f6736 (pager: test for exit code with and without
SIGPIPE, 2021-02-02).  That original test was, IMHO, in the same
direction we're going in this commit.

At any rate, this test obviously needs to be adjusted to check the new
behavior we are introducing.  Do it.

The second test being affected is: 'non-existent pager doesnt cause
crash', introduced in f917f57f40 (pager: fix crash when pager program
doesn't exist, 2021-11-24).  As its name states, it has the intention of
checking that we don't introduce a regression that produces a crash when
GIT_PAGER points to a nonexistent program.

This test could be considered redundant nowadays, due to us already
having several tests checking implicitly what a non-existent command in
GIT_PAGER produces.  However, let's maintain a good belt-and-suspenders
strategy; adapt it to the new world.

Finally, it's worth noting that we are not changing the behavior if the
command specified in GIT_PAGER is a shell command.  In such cases, it
is:

    $ GIT_PAGER=:\;non-existent t/test-terminal.perl git log
    :;non-existent: 1: non-existent: not found
    died of signal 13 at t/test-terminal.perl line 33.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

This is a response to
https://lore.kernel.org/git/xmqqed8pkhkn.fsf@gitster.g/

Range-diff against v2:
1:  95a2f36d18 ! 1:  60e852bffb pager: die when paging to non-existing command
    @@ Commit message
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## pager.c ##
    -@@
    - #include "git-compat-util.h"
    - #include "config.h"
    - #include "editor.h"
    -+#include "gettext.h"
    - #include "pager.h"
    - #include "run-command.h"
    - #include "sigchain.h"
     @@ pager.c: void setup_pager(void)
      	pager_process.in = -1;
      	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
      	if (start_command(&pager_process))
     -		return;
    -+		die(_("unable to execute pager '%s'"), pager);
    ++		die("unable to execute pager '%s'", pager);
      
      	/* original process continues, but writes to the pipe */
      	dup2(pager_process.in, 1);

 pager.c          |  2 +-
 t/t7006-pager.sh | 17 +++++------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/pager.c b/pager.c
index e9e121db69..be6f4ee59f 100644
--- a/pager.c
+++ b/pager.c
@@ -137,7 +137,7 @@ void setup_pager(void)
 	pager_process.in = -1;
 	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
 	if (start_command(&pager_process))
-		return;
+		die("unable to execute pager '%s'", pager);
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index e56ca5b0fa..932c26cb45 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -725,18 +725,11 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 	test_path_is_file pager-used
 '
 
-test_expect_success TTY 'git skips paging nonexisting command' '
-	test_when_finished "rm trace.normal" &&
+test_expect_success TTY 'git errors when asked to execute nonexisting pager' '
+	test_when_finished "rm -f err" &&
 	test_config core.pager "does-not-exist" &&
-	GIT_TRACE2="$(pwd)/trace.normal" &&
-	export GIT_TRACE2 &&
-	test_when_finished "unset GIT_TRACE2" &&
-
-	test_terminal git log &&
-
-	grep child_exit trace.normal >child-exits &&
-	test_line_count = 1 child-exits &&
-	grep " code:-1 " child-exits
+	test_must_fail test_terminal git log 2>err &&
+	test_grep "unable to execute pager" err
 '
 
 test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
@@ -762,7 +755,7 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 
 test_expect_success TTY 'non-existent pager doesnt cause crash' '
 	test_config pager.show invalid-pager &&
-	test_terminal git show
+	test_must_fail test_terminal git show
 '
 
 test_done
-- 
2.45.1
