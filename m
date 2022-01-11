Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518FC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 11:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiAKLMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiAKLMP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 06:12:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A829DC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:12:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q8so32163356wra.12
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qxLEDaVVXuSkRbZPv11EOStJOOrvJtXLEYzIeB0ifgQ=;
        b=jhWmpjj3HajawXBrKlXKfCIyKPqt6wwd48y6BygT5nJGtzTDdYZMd0OMHSGsXTt2Ro
         E1xp8XmmlbpjgofyF3JmMltlWQ2l9s69K0wSvfsR5ohR415WPdr6nb145pORDTZvdmt0
         7fage0BLEEu69y2K/YyMOV5QERvFPKvNt8m4wi/qQgND+JY+ZTpNnMcYg0tShxV2DS0q
         oL27wac/fYEavy70nfROnsuq7GprexdXhAQos4rNmGUWfub9JZvUtp0vC/Vx54kVz2DQ
         PH6jokz/mVPDuD5a8Rbvi8lVN+TlQfwNUocA4hVZn9h0MADJIPa6df6dD/9DPlo5F5OH
         +kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qxLEDaVVXuSkRbZPv11EOStJOOrvJtXLEYzIeB0ifgQ=;
        b=ETA6iKRI7OytzM4HYGncuoSMqJYnXoPaI+Aw8HhnYK3VNJ0LQkC1eleupBmAS6li3h
         FzR1Ci9O8KvDIuT90zMQvAvfKLjPOEFrjYShvQCRl83Ipw+cEsuz+GJOl1t6XsAGzLuN
         qLXdgtDn7qHd/sSyZJbc8BkGhYTSbLI192aEEroqPzc7W6Ebwhcroc0IU21swH7l0zG7
         do6CJwd17lxpnYU5QA0KdrGQGdCy3ZYle4OFa9IGheiO7rT+XXLokkxNRhay9SUtu0Mu
         K4SI2v2SadVHQ1pV0JNZuoUVLfMrip4wUtDUzoUoJIDwbN+XcJrp7sy1c6fGsBOZvgJ2
         2cPA==
X-Gm-Message-State: AOAM532U/zs9zKOd861tfen3wOItK00vPijL4T3PngLEuH2NtHzPFe8Z
        FhnNMXbTuffhmaSo/PIKbxnXsuyvQx0=
X-Google-Smtp-Source: ABdhPJwmHxtVzLzJ0nfcPJzreckKXLnrTFlx+isJLj29KtJRUKpJlzlHv+dcvSu5UukvqVjAKQTxcw==
X-Received: by 2002:a5d:430e:: with SMTP id h14mr3447399wrq.99.1641899532837;
        Tue, 11 Jan 2022 03:12:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm1463153wrn.11.2022.01.11.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:12:12 -0800 (PST)
Message-Id: <cc8639fc29db18da00ba2a95a1305efc3ea24205.1641899530.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
        <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 11:12:09 +0000
Subject: [PATCH v2 1/2] t3701: clean up hunk splitting tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Clean up some test constructs in preparation for extending the tests
in the next commit. There are three small changes, I've grouped them
together as they're so small it didn't seem worth creating three
separate commits.
 1 - "cat file | sed expression" is better written as
     "sed expression file".
 2 - Follow our usual practice of redirecting the output of git
     commands to a file rather than piping it into another command.
 3 - Use test_write_lines rather than 'printf "%s\n"'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3701-add-interactive.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 207714655f2..77de0029ba5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -347,7 +347,7 @@ test_expect_success 'setup patch' '
 # Expected output, diff is similar to the patch but w/ diff at the top
 test_expect_success 'setup expected' '
 	echo diff --git a/file b/file >expected &&
-	cat patch |sed "/^index/s/ 100644/ 100755/" >>expected &&
+	sed "/^index/s/ 100644/ 100755/" patch >>expected &&
 	cat >expected-output <<-\EOF
 	--- a/file
 	+++ b/file
@@ -373,9 +373,9 @@ test_expect_success 'setup expected' '
 test_expect_success 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
-	printf "%s\n" s y y | git add -p file 2>error |
-		sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
-		       -e "/^[-+@ \\\\]"/p  >output &&
+	test_write_lines s y y | git add -p file 2>error >raw-output &&
+	sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
+	       -e "/^[-+@ \\\\]"/p raw-output >output &&
 	test_must_be_empty error &&
 	git diff --cached >diff &&
 	diff_cmp expected diff &&
-- 
gitgitgadget

