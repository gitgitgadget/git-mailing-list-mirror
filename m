Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D811A4F1D
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904348; cv=none; b=Sjf/diHfBgDK6JwEBR3CLHXhR5JP/YC9Hgn3gJWOP6z2b+lSrDZA1UqcixLfZQpAQMXO+p1lFd3gDDbdATbnH023OwGvhMaFnllv5zT3JsUGN6Dfa7TtU6O3A+mLu23f5QNKPZkAQGO1ZJq3uxoEK72zhMxBXehQwikLl+Nqxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904348; c=relaxed/simple;
	bh=IJYZVW99ipiCOT//8+H0DDAkjUWfBlWHNqXFKK25Euw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=YXEKpIE27AmGaQdhMUtrwjZNn/t95GTobmFwaAypSbW33eOwBbgXeZNM+ykY40hobtcXMy8QF0wu4jNUK69TxKVnH6jYRRVGNLieasUbnwso9Wyeb5Woa+Af1WMfddwqz9GbgB33UkijInhfSUir08+53NMnNdXPrBGSRdwhKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtGHMnxb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtGHMnxb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3632a6437d7so733116f8f.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718904345; x=1719509145; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owHkf9l//dqUdRblgc+ndYC/2QFuWz6jWIVXyYXzzOg=;
        b=YtGHMnxb28gnADc/vPuOI29n5hel5LXZMEbTVWxD9yA+DVR621ZedonL+CZ6C4NCyq
         hJlpxRD32DILjYTKltv5gfgt7yJNfwwfVKZrSW5jwmt0AJ0/UFMqNXrWjDuD4GSKMNys
         Cn9WNOfnuEmhE79JRhQ/WmCqgbIIsqAGAlyl6eYQp4yRV2w74/iW1S04NbuFIr9rK6bU
         /yP0yYjkDed/owMuVwF4sXuHtGjBEI4O4MtfsSYK83vP2SmDdNjz0osIqJysVTZwDdaG
         kQ3oViifEb1NymAtQv97qw2DLw1fH1vuQ/2I9jLLYtF3CbYucEj2IZ9GaWbWfvJbgzQq
         0VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718904345; x=1719509145;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=owHkf9l//dqUdRblgc+ndYC/2QFuWz6jWIVXyYXzzOg=;
        b=ab8QcjR8twUUn/npxjh4S802J3S5UcGLo3hyRoqRurA85YmSkrUFSNR7Zc1WywvizM
         /ew+qNepYTjpWjr/Espsv3GbF8GWMkJDN5zbQ/zjccjpIkJd9CqtmTuc4zG8q7ZiT3Xz
         sF06W9feMPuPlnulRXOQAL6l6+v+XwAYt7VgO7eRUbUx7Goax4bQ8TRb3TYyplNDlAaz
         9f00GVryYwjv+s1JqB+OyDPZ6z4cwUJBHW1cJQCMcprtdxdjrILjtx509Agi/DzTD+uP
         isR7ocw7kWLfQwSHCzqxMMq2mg45dQyzEIQCU8phhmYlyF0AfepkavBmJC9TTJljRuaO
         TPoA==
X-Gm-Message-State: AOJu0Yy6xHjCTDVSmOyH81xoGCTAnBqC62VrgSlRIy5Unwq+JrekLFSX
	9kbvGSHXKXqFx9ylrvXTVGgJb390yPNIEUnWQnxPZzj6y1nIxiMIrCj5Wg==
X-Google-Smtp-Source: AGHT+IHLQ6lAySdTFGc8u+m9sZ6l8GXjNOulaIffbNgenBXtmHU4rJTYUN3VEs89YC9o+UGEqauNfQ==
X-Received: by 2002:adf:db49:0:b0:362:56c2:adb4 with SMTP id ffacd0b85a97d-36256c2ba0amr7898641f8f.18.1718904344854;
        Thu, 20 Jun 2024 10:25:44 -0700 (PDT)
Received: from gmail.com (133.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36387d9b812sm4865864f8f.26.2024.06.20.10.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 10:25:44 -0700 (PDT)
Message-ID: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
Date: Thu, 20 Jun 2024 19:25:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
Subject: [PATCH] pager: die when paging to non-existing command
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
 pager.c          |  2 +-
 t/t7006-pager.sh | 15 +++------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/pager.c b/pager.c
index e9e121db69..e4291cd0aa 100644
--- a/pager.c
+++ b/pager.c
@@ -137,7 +137,7 @@ void setup_pager(void)
 	pager_process.in = -1;
 	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
 	if (start_command(&pager_process))
-		return;
+		die("unable to start the pager: '%s'", pager);
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index e56ca5b0fa..80ffed59d9 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -725,18 +725,9 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 	test_path_is_file pager-used
 '
 
-test_expect_success TTY 'git skips paging nonexisting command' '
-	test_when_finished "rm trace.normal" &&
+test_expect_success TTY 'git errors when asked to execute nonexisting pager' '
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
+	test_must_fail test_terminal git log
 '
 
 test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
@@ -762,7 +753,7 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 
 test_expect_success TTY 'non-existent pager doesnt cause crash' '
 	test_config pager.show invalid-pager &&
-	test_terminal git show
+	test_must_fail test_terminal git show
 '
 
 test_done
-- 
2.45.2.562.g334133e685
