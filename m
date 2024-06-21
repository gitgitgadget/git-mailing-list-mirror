Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFB4A3F
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005362; cv=none; b=bY3KlhYdosB0qhFmtKZexP7l32Yx7HH9mPWjJ4FYywmlnYF22PuhaiGE+JGVrQKzGuqml5moWzK0TV4MCkUSOR19DmuhFTQ1izObQRUqoIlqg50vvKQzArIzUAdU6pqG8qLvAkRhjOH6t4M+VMdC6Fk4dmUmubmKY473e6/Sb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005362; c=relaxed/simple;
	bh=YSWvWlmDf8gJXVlgvhYhF0z1ua09zZCiLyN7O1OcT4E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o446sWYXp9HP3YWrE0v58TydYYFSD9TcECPkGlW79/kc3rRKBe3Vq3U4MsXN9xfp39r+kxQ5Xfh/kF7O20+h/yARbdjd03bpgkky67QX5ZrUotcncgnvW1HhSXuRTxYVRWom0gH5fsXaggs38yszCXWhhJB+F0Yjwhen4pssUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYkNjg0X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYkNjg0X"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-364cdfdaf91so1750970f8f.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719005358; x=1719610158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVf4jDZHC5vqs5Otb3/E+ZuNwjnuzceb/eXLa5AA4RY=;
        b=EYkNjg0XNeYqoqQVPWLiLpHQnU5BrZ3/OSvZflZoz17bzcHZhZ0xcsw46fnnIMrFI0
         3PxeyhbhkigsEpMJAI51iCB3iQ2T595oU7Lh7oxDS6Y4P/RWQYwPTjqgnW2bNgdnMF2y
         0fTHWTyJB3IyaRruAdQWlwIv3lqN2mo2Al6EuBZoCq33Z6KVMDfJpApZxU/vUDArTbij
         QLL9FV2EfZ+xffGjI1CT5SskYdsNOS6jrcWUeXkRlT2G7XSJ/oil6z2LoJ/nik7moMVd
         keAyo4wStvHiFWBc+vAt9/WU0hzoQCjaD0XIIp/+q3XJ0MNOa/Q4PhjUNGZtCO8957K1
         O34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005358; x=1719610158;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVf4jDZHC5vqs5Otb3/E+ZuNwjnuzceb/eXLa5AA4RY=;
        b=H6CHw3FJQOTkIMfIUHwB/RriTfMQf+vzzcK9nFsaCwst6qV19RXE78BEwQ++I8slbt
         re4CNFBGK0a4l2V22gFKrUeztUX3Lr4Lfvpw8UG6x9E+LYpQNg+lYz8B3nU3HYDgegpQ
         wnogSQlKECmjatX+SDAQjBsqFuyq1EoJ2c65ONfml3UVWfXx/LuTJAzkRK082/Hd8rCl
         hpl5aRnnEGec7qXk2BRSgByDACsfHkHiVXX8fk477j5lgfYeGRzcEIFbW6qMsjVHLLMK
         5hJBNIAT8l2SqTMRVK4APok7jh+J05rlGSlZBJeIxWgfxPlt2IT8BHbLq450m1mvbuPY
         mKLg==
X-Gm-Message-State: AOJu0Yxd5J+cSiOQSGBbHpm/rKATI9ObQMQiobiJmf3XOIGbVGuVAxpT
	lS7ERO6CH97gj/1zgtBNSt5BcObkBf6THMtPL0N/X/e/TOnm3kH4nR1Rpw==
X-Google-Smtp-Source: AGHT+IGNtmjSN/AvKbtlXTuA0s9l3EleXQlKp+f/bLchdW/NDlapkTzx/xgAbbzJKj9a/+cT+locoA==
X-Received: by 2002:a05:6000:1e81:b0:364:aafb:61b0 with SMTP id ffacd0b85a97d-364aafb6e14mr4494418f8f.10.1719005358392;
        Fri, 21 Jun 2024 14:29:18 -0700 (PDT)
Received: from gmail.com (179.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366e0750e41sm206931f8f.97.2024.06.21.14.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 14:29:18 -0700 (PDT)
Message-ID: <0df06a80-723f-4ad7-9f2e-74c8fb5b8283@gmail.com>
Date: Fri, 21 Jun 2024 23:29:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] pager: die when paging to non-existing command
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Dragan Simic <dsimic@manjaro.org>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
In-Reply-To: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
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

This iteration, v2, is just to "revert" to the original error message
lost by ea27a18c. 

For those not yet used to it, the range-diff is at the end of the
message. ;)

Thanks!


 pager.c          |  3 ++-
 t/t7006-pager.sh | 17 +++++------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/pager.c b/pager.c
index e9e121db69..f5b6dc9b60 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "editor.h"
+#include "gettext.h"
 #include "pager.h"
 #include "run-command.h"
 #include "sigchain.h"
@@ -137,7 +138,7 @@ void setup_pager(void)
 	pager_process.in = -1;
 	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
 	if (start_command(&pager_process))
-		return;
+		die(_("unable to execute pager '%s'"), pager);
 
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

Range-diff against v1:
1:  5c7997810c ! 1:  95a2f36d18 pager: die when paging to non-existing command
    @@ Commit message
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## pager.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "config.h"
    + #include "editor.h"
    ++#include "gettext.h"
    + #include "pager.h"
    + #include "run-command.h"
    + #include "sigchain.h"
     @@ pager.c: void setup_pager(void)
      	pager_process.in = -1;
      	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
      	if (start_command(&pager_process))
     -		return;
    -+		die("unable to start the pager: '%s'", pager);
    ++		die(_("unable to execute pager '%s'"), pager);
      
      	/* original process continues, but writes to the pipe */
      	dup2(pager_process.in, 1);
    @@ t/t7006-pager.sh: test_expect_success TTY 'git discards pager non-zero exit with
     -test_expect_success TTY 'git skips paging nonexisting command' '
     -	test_when_finished "rm trace.normal" &&
     +test_expect_success TTY 'git errors when asked to execute nonexisting pager' '
    ++	test_when_finished "rm -f err" &&
      	test_config core.pager "does-not-exist" &&
     -	GIT_TRACE2="$(pwd)/trace.normal" &&
     -	export GIT_TRACE2 &&
    @@ t/t7006-pager.sh: test_expect_success TTY 'git discards pager non-zero exit with
     -	grep child_exit trace.normal >child-exits &&
     -	test_line_count = 1 child-exits &&
     -	grep " code:-1 " child-exits
    -+	test_must_fail test_terminal git log
    ++	test_must_fail test_terminal git log 2>err &&
    ++	test_grep "unable to execute pager" err
      '
      
      test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
-- 
2.45.2.562.g737041e583
