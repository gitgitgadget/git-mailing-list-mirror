Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377F27453
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126562; cv=none; b=Mn+cl9PkAoOOH9qNQg59G716xgIcIxrnbjzvufOsYV1gCLe/u38GWOd936gNAPZ8FG/X3EPUVfAO6Eo3b5DsJmFB/8FFPLWqHv6++P+Wa229Tj9AyWCs1hJGockPPXorXjoTjXZU69ql+xeWubM5dMf2TJOLGbwoA89ijTVXN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126562; c=relaxed/simple;
	bh=zmJqYBeo2hbHk00PxWD023n5s48kV+S3WU3/M26wuhE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dVKGxbmgEYs861GT4QSEpGHHRDv1WwUgL6tiHf35jOvpIp7vOcJcvb+Cqx4LUqUb2AwUj1iJklCtoQk3RXHUHd2CLrCOCSZj2E8XeMUjmrTBCHTTThXAMByRuqYzd74KkAPS+5UF/3JloAELEfMNf3w5aYGpyoabPk4aPzbeJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbUUU/5u; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbUUU/5u"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso34587091fa.1
        for <git@vger.kernel.org>; Sun, 23 Jun 2024 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719126559; x=1719731359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BDUqKXn1FX2qXdNGhBYrSbxiD55FKrGmeG4LeSDq6Q=;
        b=JbUUU/5uWMJFoPRWU+VAsOgXyKVytTDbgPXxoDKUzikiRxcGH1LOiLVYzFyImxRGnu
         ESkcw2sBkR6ts7TPy6Dl8E6JoUhfV9FXMa/2K3kbak+/gf3U1fnNgZn4eiyFX4cizbXA
         /u5a/byjrLJif5OHvrbkIknv93sqjkYYh1H5J5C6Y04hX9lSYb4iwmf60Gv922g1tDhC
         rjYfTI+ozIafc00M6NCcLQbv/twndPO9USAuQvhsV46llRbwPmPtVF7Y8OzwbcAA14LL
         V5c9dXwSXfDAA3kGH4Sk8xlq0xNevc3zoIrQpnGIwgW2izUZZ0HgZLVIyqaV1IpHxVCK
         Dbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126559; x=1719731359;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BDUqKXn1FX2qXdNGhBYrSbxiD55FKrGmeG4LeSDq6Q=;
        b=PNN24+hTWtoo5CGsUZzUOtdaLeO4RsIx4C/duWo5J+mzr9nFxltPIMF6LK/uQIKUaa
         wH/rigdYBkGbaBeORx97b5gZBCjnK94EhIAMjWJJnVsz3B26+TeWAWuYrhD5jwaakF2n
         YOG4yLI39CbHf8wQENZdBrFgC4DxjxBdHdeCMN1fI90UnWYQdbsoBg2Z+4G5h5aTnYgQ
         LJTEbT2HFj0x/14778LgeVZ9hu+kGi4qalU3+LXqd9WV12sRZ3cANKvt9eIkYtYX8eyU
         MQPX9xtRjsdyIcDyY8gAM9/VhG7UbteQCl4Zqn48aHC95JxCqZhS7HzpR93k7Z7MS/DV
         l6Vg==
X-Gm-Message-State: AOJu0YzeFMe2YAyjpF08EHVzunoeF8oQPYTg0LMdm2Gn1TixkGSmLpL2
	NMXHXvS2UtbcQdvomEncHr+gFXSUgl5bKM1OiQDoEF6Z4DP2AKGmEsYJfQ==
X-Google-Smtp-Source: AGHT+IFlCVPihwFV791Rw76i5Sen31OVlzEvRAnyc/fEFEbIjQdlXPik3e6o40sCBECsiLMsNwCecw==
X-Received: by 2002:a05:651c:237:b0:2ea:7f5d:ed93 with SMTP id 38308e7fff4ca-2ec59587ef8mr10748211fa.50.1719126558925;
        Sun, 23 Jun 2024 00:09:18 -0700 (PDT)
Received: from gmail.com (226.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be841sm129081675e9.20.2024.06.23.00.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 00:09:18 -0700 (PDT)
Message-ID: <392deded-9eb2-42fa-b6f9-54c22d3ffd33@gmail.com>
Date: Sun, 23 Jun 2024 09:09:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4] pager: die when paging to non-existing command
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Dragan Simic <dsimic@manjaro.org>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <0df06a80-723f-4ad7-9f2e-74c8fb5b8283@gmail.com>
 <6850f558-ad20-403a-ae1e-5b9826c53790@gmail.com>
In-Reply-To: <6850f558-ad20-403a-ae1e-5b9826c53790@gmail.com>
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
    fatal: unable to execute pager 'non-existent'
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

Error pointed out by Hannes in:

https://lore.kernel.org/git/f031c152-1b97-4598-92f3-a72aefd701a4@kdbg.org

Thanks!

Range-diff against v2:
1:  60e852bffb ! 1:  93d6074a17 pager: die when paging to non-existing command
    @@ Commit message
     
             $ GIT_PAGER=non-existent t/test-terminal.perl git log | wc -c
             error: cannot run non-existent: No such file or directory
    -        fatal: unable to start the pager: 'non-existent'
    +        fatal: unable to execute pager 'non-existent'
             0
     
         The behavior change we're introducing in this commit affects two tests

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
