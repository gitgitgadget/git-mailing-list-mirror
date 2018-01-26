Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759A01F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeAZMho (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:44 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55016 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeAZMha (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id i186so995339wmi.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lUhkvQ/J9v+xYlAPJdit98dqMQkkuswJlg3+48rzgQU=;
        b=iKdGwqj0RP6iuqZk6VuxSW04iGnOspeQ3AdiLCqVl31t1cuTquQbs7dEUY8yYEYwMJ
         SAgKDEvDcgsGSkuqaEBGRyY/8+PAfo0OMvKYXWs0KKgkL9w4F+Cm8DwA9rMbGSeoYD7t
         rfEIpOFASk8LT3R49vfbgH3lARru7R6GOu51szCStSoSf3HyH2uQA4wJikq3yoEsnimX
         VcZ8sKNT7ctkwVZ5m7nxhYvqaP5jVWUkDv04617UffzsvHwrNlSFGT7l4keMq8cjxQ43
         /F5bmcFdUdipNanBGMDCI4GBw2mbZ/jTbGE0GRcT4Exp3S9m/SjMl0u7SmYuyJa/Pyct
         cuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lUhkvQ/J9v+xYlAPJdit98dqMQkkuswJlg3+48rzgQU=;
        b=EMJSUwfoIOzsZ3VgFZr2TxkTJqIC+9kuAcS9Kaj1N/EqSo7MImNOSDMnBg7ui+L2uT
         iYDQrhzarM7OURIo9kjCGiQfXkzPdjCZeupicUxBPRDSmk4gV06UwrlaRhCHl2Yo+wBo
         sJatkS1qJ2DYc/qpUPNIKjdKsdjJbZ3/vmY8XW+biXFMNXe2EwUcUvzzkUvjOHnhlJDn
         pIZ7k3N5MUn5LT4QHO2A6ch2MjqrPnwgRXh6iggSwnbM8pzwGu7OmlvPJPs2Q9j7WKfo
         P0hgucBwxpKUFLRqNjO8qva2UqfCbfsbXcooLEbnXZV8bfXlGhqFScN9dg8auTbJOVUF
         V3Pw==
X-Gm-Message-State: AKwxytcBswjRdcRtu4y6scpVpMCOTKcXVLHu2U91+pCSyOTMIs94C5vS
        +gMmiYuvz9hRsCHw+M5Zv7lq0w==
X-Google-Smtp-Source: AH8x225wTz/sQRULT1pZeUe6G7jzXcmP46ElwlprYQrR5BDgByXiXJX5vjf0BDRbtiOMeqxIP0yWng==
X-Received: by 10.28.54.157 with SMTP id y29mr11530359wmh.36.1516970248777;
        Fri, 26 Jan 2018 04:37:28 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:28 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/10] t: forbid piping into 'test_i18ngrep'
Date:   Fri, 26 Jan 2018 13:37:06 +0100
Message-Id: <20180126123708.21722-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checking a git command's output with 'test_i18ngrep', it's
tempting to conveniently pipe the git command's standard output into
'test_i18ngrep'.  Unfortunately, this is an anti-pattern, because it
hides the git command's exit code, and the test could continue even if
the command exited with error.

Add a bit of linting to 'test_i18ngrep' to detect when data is fed to
its standard input and to error out with a "bug in the test script"
message.

Note that this change will also forbid cases where 'test_i18ngrep'
would legitimately read its standard input, e.g.

  - when its standard input is redirected from a file, or

  - when a git command's standard output is first written to an
    intermediate file, which is then preprocessed by a non-git command
    before the results are piped into 'test_i18ngrep'.

See two of the previous patches for the only such cases we had in our
test suite.  However, reliably preventing this antipattern is arguably
more important than supporting these cases, which can be worked around
by only minor inconveniences.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 92ed02937..e381d50d0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -719,6 +719,10 @@ test_i18ncmp () {
 # under GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ngrep () {
+	( read line ) &&
+	error "bug in the test script: data on test_i18ngrep's stdin;" \
+	      "perhaps a git command's output is piped into it?"
+
 	if test -n "$GETTEXT_POISON"
 	then
 	    : # pretend success
-- 
2.16.1.155.g5159265b1

