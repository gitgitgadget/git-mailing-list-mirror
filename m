Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C22E1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 18:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeAVS1d (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 13:27:33 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34728 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeAVS1c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 13:27:32 -0500
Received: by mail-wm0-f53.google.com with SMTP id j21so10131551wmh.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 10:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whKCSpSr24MMIQm1FQ+ifsT0FSyEGP0Gg/pyWWMjcOo=;
        b=c+w40Pxz9Tk7sWtsa33jU5QTEBzJPgFiGDAr5DF2xQIz7lm5G9dnG8CUG2iAba2mKe
         XBLjM9ubGfvLzAzKlNIpXsgnWOnYFajz0iXXHnU3AwECCtmM266QjTRLADhL2jQRdCVl
         +K/4axZtHuKPB54QumKmh9lr5gefevE55O9Oi0Z59cxuqcTmVrn53VaT6irzW/mtdpSg
         +kdrtTP1uk4mAa9qmtyEZRPfCXc7FDTqadLDrGGa8zKC7C1s02MwAz2agP+WjJV1fkE/
         gF9h11AaAGPcD82bDv7/4mYU9pFMrm8sBn88nD0IwMKWN2hYj3QrgQghQNHt+tzT+M95
         gFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whKCSpSr24MMIQm1FQ+ifsT0FSyEGP0Gg/pyWWMjcOo=;
        b=HeRu4dNK/2j3rKOi4slpdXa7See8bUKYybnPSX5ShvV4LadCzUVba8vqJtOi5a7FbT
         BWMUDNbAxk3GX1z5MymrPKlMvWQFy4EqWgshu+Qbc8jntzqQbA+yv7oOz1fBhYg53eew
         cNy4IA9c474um1pUx/u5BCl9dPfJP3aBqmdXVrYSIQd+/vInCOP4oQUj0PdCKDMsmw0N
         VK38UsxrOw5Z1LkIRWo28lnM/J6Rl/ZlMsdS1w1fbnGA2uL5SIvDwnIP2LZrj/HtKGDt
         OmmXMUt5WXIQs7gancPwYUiDs5+cLpIQpzlQd3AeVs1ldi2tZxqi/WUtzBX0RLD92xfw
         yqtw==
X-Gm-Message-State: AKwxytf4vDfH1X/KOL4vOTePsNHXA7dXJ/KwoAD/q1oXkSt+fSvB4uQS
        5JQr7twuckM4uvqOQFPwBVw=
X-Google-Smtp-Source: AH8x224yHhasjuLrHUf2zodI/8Mj/QTiGTC+ZJ6ZJe3bMHUPn/GX/b3zm2U2yr6Z7xZdOjdyvRvnzg==
X-Received: by 10.28.65.133 with SMTP id o127mr5710312wma.130.1516645650947;
        Mon, 22 Jan 2018 10:27:30 -0800 (PST)
Received: from localhost.localdomain (x590e64ec.dyn.telefonica.de. [89.14.100.236])
        by smtp.gmail.com with ESMTPSA id 31sm13698789wra.49.2018.01.22.10.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 10:27:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write shared index
Date:   Mon, 22 Jan 2018 19:27:17 +0100
Message-Id: <20180122182717.21539-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.80.gc0eec9753d
In-Reply-To: <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
References: <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 18, 2018 at 1:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jan 18, 2018 at 6:36 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>> This series, queued as 'nd/shared-index-fix', makes the 32 bit Linux
>> build job fail on Travis CI.  Unfortunately, all it can tell us about
>> the failure is this:
>>
>>   Test Summary Report
>>   -------------------
>>   t1700-split-index.sh                             (Wstat: 256 Tests: 23
>>   Failed: 1)
>>     Failed test:  23
>>     Non-zero exit status: 1
>>   Files=809, Tests=18491, 401 wallclock secs ( 7.22 usr  1.60 sys + 263.16
>>   cusr 49.58 csys = 321.56 CPU)
>>   Result: FAIL
>>
>> because it can't access the test's verbose log due to lack of
>> permissions.
>>
>>
>>   https://travis-ci.org/git/git/jobs/329681826#L2074
>
> I may need help getting that log (or even better the trash directory
> of t1700). 

Well, shower thoughts gave me an idea, see the included PoC patch below.
I can't really decide whether it's too clever or too ugly :)

It produces output like this (a previous WIP version without
'--immediate'):

  https://travis-ci.org/szeder/git/jobs/331601009#L2486


  -- >8 --

Subject: [PATCH] travis-ci: include the trash directories of failed tests in
 the trace log

The trash directory of a failed test might contain valuable
information about the cause of the failure, but we have no access to
the trash directories of Travis CI build jobs.  The only feedback we
get from there is the trace log, so...

Modify 'ci/print-test-failures.sh' to create a tar.gz archive of the
test directory of each failed test and encode it with base64, so the
result is a block of ASCII text that can be safely included in the
trace log, along with a hint about how to restore it.  Furthermore,
run tests with '--immediate' to faithfully preserve the failed state.

A few of our tests create a sizeable trash directory, so limit the
size of each included base64-encoded block, let's say, to 1MB.

Note:

  - The logs of Linux build jobs coming from Travis CI have mostly
    CRLF line endings, which makes 'base64 -d' from 'coreutils'
    complain about "invalid input"; it has to be converted to LF
    first.  'openssl base64 -d' can grok it just fine, even without
    conversion.

  - The logs of OSX build jobs have CRCRLF line endings.  However, the
    'base64' util of OSX doesn't wrap its output at 76 columns, i.e.
    prints one single albeit very long line.  This means that while
    'base64' from 'coreutils' still complains, by the time it gets to
    the invalid input it already decoded everything and produced a
    valid .tar.gz.  OTOH, 'openssl base64 -d' doesn't grok it, but
    exits without any error message or even an error code, even after
    converting to CRLF or LF line endings.

    Go figure.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh        |  2 +-
 ci/print-test-failures.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 1efee55ef7..981c6e9504 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -97,7 +97,7 @@ fi
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-export GIT_TEST_OPTS="--verbose-log"
+export GIT_TEST_OPTS="--verbose-log --immediate"
 export GIT_TEST_CLONE_2GB=YesPlease
 
 case "$jobname" in
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 4f261ddc01..cc6a1247a4 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -23,5 +23,25 @@ do
 		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
 		echo "------------------------------------------------------------------------"
 		cat "${TEST_OUT}"
+
+		TEST_NAME="${TEST_EXIT%.exit}"
+		TEST_NAME="${TEST_NAME##*/}"
+		TRASH_DIR="t/trash directory.$TEST_NAME"
+		TRASH_TGZ_B64="$TEST_NAME.trash.base64"
+		if [ -d "$TRASH_DIR" ]
+		then
+			tar czp "$TRASH_DIR" |base64 >"$TRASH_TGZ_B64"
+
+			if [ 1048576 -lt $(wc -c <"$TRASH_TGZ_B64") ]
+			then
+				# larger than 1MB
+				echo "$(tput setaf 1)Trash directory of '$TEST_NAME' is too big to be included in the trace log$(tput sgr0)"
+			else
+				echo "$(tput setaf 1)Trash directory of '$TEST_NAME':$(tput sgr0)"
+				echo "(Extract it to a file from the raw log, make sure it has Unix line endings, then run 'base64 -d <file> |tar vxzp' to restore it)"
+				cat "$TRASH_TGZ_B64"
+				echo "$(tput setaf 1)End of trash directory of '$TEST_NAME'$(tput sgr0)"
+			fi
+		fi
 	fi
 done
-- 
2.16.1.80.gc0eec9753d

