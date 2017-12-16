Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4E81F406
	for <e@80x24.org>; Sat, 16 Dec 2017 22:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756826AbdLPWtD (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 17:49:03 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36451 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756532AbdLPWtC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 17:49:02 -0500
Received: by mail-wm0-f52.google.com with SMTP id b76so23551086wmg.1
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=DGtt2iAD7J4rFKWsxjyEQtUWRxD4PNyQVTRriLF8enU=;
        b=hYxXkKeugAdAFYcc+cT/fVoh/c4nCLjF2AJKM0TkJ7F24uDCSB4EnPalT5xkgULW9D
         aRmr3xC0iicBjnE/Pq60ljaTsOfxm+HayNwiPm7xqZ+LqhVrpVde8O294zlHHLqkI/g2
         oEZTOVyf63Z7x5iLWn7pLvXG7olb+efenWNPSqiM7BYThY55fblC9rrIqiZIVwoLlgmC
         K/CIVnv1C+sUxBdg1NDXjcoCY/CD5Mrplwtfcww9bJEgP9EGTFyDee03VuPq9kINxSFN
         lSiuTK2435f8oGqtrKpOas3f/NprzFaGYlgk+Yg8mi/j5IdKPRM4wArLc4eX7m91udmh
         HBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=DGtt2iAD7J4rFKWsxjyEQtUWRxD4PNyQVTRriLF8enU=;
        b=d6+mL0X606/zkwirDhTAFE5hAhYNDYO4PNsDg0n5NK3GeXAd2XzKh4Ph4Gn+ll6OSc
         0mt6cRwTs0XGDHsRoD8ggN0ys2FODM/AKojXgYmRPmvYyp9RYbHEKlN5t6OBb1Ht/f7u
         luPMCuywF6x2s9/n/D3F6YUAa9yeCrDUecd3w4KxtJkzNypPM8xnwJR+YbSipp0WE+Nk
         hFlYcjgUCEEHt77/zIkP389HCgma5NdNYjtxIUpEXJEaOpyfMhkiRTREmZe3qHSzUwLw
         yayDj7dHEp7vI1btU7tMxLKdnWiD2ttBGJNnCsYTWs1MFhnlj0HpFMlqvGRQ1RstUIz7
         B6pg==
X-Gm-Message-State: AKGB3mL4GpXQAGAOki+1ayGNtUNTD1NkmsGD62m/j4n69El30RXNiidZ
        xxww4p0VseJrAGYEXNVay5HUeA==
X-Google-Smtp-Source: ACJfBos+jplMalxCdXP2LUeen+JKvKzADTqOVzg1HjL6+YZFtF2Jw7hAxW+SU8/7pBs6tYPct5kfIg==
X-Received: by 10.28.31.137 with SMTP id f131mr7653708wmf.110.1513464541048;
        Sat, 16 Dec 2017 14:49:01 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id p15sm2695888wre.24.2017.12.16.14.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 14:49:00 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] travis-ci: only print test failures if there are
Date:   Sat, 16 Dec 2017 23:48:39 +0100
Message-Id: <20171216224839.11372-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <CAPig+cTL5hU6R=L3M2i0kfM6_zMLvcHWvNooAr8BU3VQ=X0_Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Sat, Dec 16, 2017 at 7:58 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
> rote:

> > +if test t/test-results/*.exit =3D "t/test-results/*.exit"
> 
> Isn't the above going to cause 'test' to error out?
>
>     $ mkdir -p t/test-results
>     $ >t/test-results/a.exit
>     $ >t/test-results/b.exit
>     $ test t/test-results/*.exit =3D 't/test-results/*.exit'
>     -bash: test: too many arguments

Indeed it does, though Travis CI's /bin/sh gives a different error
message.  Thanks for pointin it out, I didn't notice the error msg,
because the script as a whole still did the right thing and then I
didn't look close enough.

> I'd think you'd want to capture the result of the expansion of
> t/test-result/*.exit as a string and compare that instead.

I'm not sure how the result of the expansion could be captured in the
shell, because the shell performs the expansion only just before it
executes a command.  And if we do have to execute a command anyway,
then we can simply rely on the command exiting with an error code upon
not finding any files, and there's no need to capture the expansion or
for the comparison for that matter.

So I propose this updated patch, using 'ls' instead of 'test':


  -- >8 --

Subject: [PATCH v2.1 8/8] travis-ci: only print test failures if there are test results available

When a build job running the test suite fails, our
'ci/print-test-failures.sh' script scans all 't/test-results/*.exit'
files to find failed tests and prints their verbose output.  However,
if a build job were to fail before it ever gets to run the test suite,
then there will be no files to match the above pattern and the shell
will take the pattern literally, resulting in errors like this in the
trace log:

  cat: t/test-results/*.exit: No such file or directory
  ------------------------------------------------------------------------
  t/test-results/*.out...
  ------------------------------------------------------------------------
  cat: t/test-results/*.out: No such file or directory

Check upfront and proceed only if there are any such files present.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/print-test-failures.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index f757e616c..b4a62ef98 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,6 +8,12 @@
 # Tracing executed commands would produce too much noise in this script.
 set +x
 
+if ! ls t/test-results/*.exit >/dev/null 2>/dev/null
+then
+	echo "Build job failed before the tests could have been run"
+	exit
+fi
+
 for TEST_EXIT in t/test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
-- 
2.15.1.429.ga000dd9c7

