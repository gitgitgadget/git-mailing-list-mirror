Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DA4C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4956722314
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/RIfnix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgBNNuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:50:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43524 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgBNNuA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 08:50:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id r11so10951947wrq.10
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 05:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5URfrNEmAoEuSQ8zSJiMgNiBaiMozxnqGk7O7W+OdtQ=;
        b=r/RIfnix6SjwCL+aoLbNcTzlz0yG1Y0bBfbbeuSk1qZ9GG4f8OzYw3SuprWOpMLIQ/
         1VT8QADxZDxlSrjvsHlnhXAIWsZlauWDvKos9c38eAx0eXhKB7jzvWQ3V9V3P69r1sW6
         tfxqXo+Yag1dqXRDsse16wh7EDvt4XEyOH5SRZn7XAdbJjJ76gGJjYxmmmCH/0QK2DPR
         Bm5rC5Hvn5DG9xqoVucILr/2c90hN/6Pj8iHei52m8uF5+BQAG14mBzADi33JMtaX8Xp
         xYRfk5p3YtJmWdhgOrQjfLqDbVos2Uka/xS07qDgN1Ys1dac04neiG2pEda0/6gxvr7t
         Ew/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5URfrNEmAoEuSQ8zSJiMgNiBaiMozxnqGk7O7W+OdtQ=;
        b=LLutL3AIxd/8LJsaWJUvGpOtTasT5UWAOwditcMju+Ba7TD2t/nfCj/Oe25F9FF6i4
         yGZuXVAeXqGcknrnxK8H7Yk0cprln6hodrnzp0fl+clwA6Am1/JTTOiHWnwJ42lyHG0l
         0H36v/ZN/QMBjTEh78xmXywor+0lf7Y3CuosJJg6ViUmx1vytfw7GvWlKKjEjMlR3VCq
         JbqZBG4DA1z8phwZfu6fFxTrec7f7d1nb2qaCtwIpvBdI4W9bNsxatzLxuOxSqn3sv+4
         Ll4J1eWtP4lyJoGRggPEiF1afUYew/plRygb77le+gzRHfYu2Lvjde2n7AB5s7D/6DSv
         h5Iw==
X-Gm-Message-State: APjAAAWB8I1oZ5259QIwSvs5YDcupQ7As1SA6GxgCheMB27YwuGUpBrV
        dz8PzvurEmsUlZuAf6scbMJztoPI
X-Google-Smtp-Source: APXvYqxOzX4Q94t/+xVxwt7Qutc7QCMVZFs9wRr70+s+h/R6qu6l62hlJx1BMzZLZCZePZaRKrlMMA==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr4393102wrh.371.1581688198258;
        Fri, 14 Feb 2020 05:49:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm7433825wme.16.2020.02.14.05.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:49:57 -0800 (PST)
Message-Id: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 13:49:56 +0000
Subject: [PATCH] credential.c: fix credential reading with regards to CR/LF
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nikita Leonov <nykyta.leonov@gmail.com>

This fix makes using Git credentials more friendly to Windows users. In
previous version it was unable to finish input correctly without
configuration changes (tested in PowerShell, CMD, Cygwin).

We know credential filling should be finished by empty input, but the
current implementation does not take into account CR/LF ending, and
hence instead of the empty string we get '\r', which is interpreted as
an incorrect string.

So this commit changes default reading function to a more Windows
compatible reading function.

Signed-off-by: Nikita Leonov <nykyta.leonov@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Prepare git credential to read input with DOS line endings
    
    This just came in via Git for Windows
    [https://github.com/git-for-windows/git/pull/2516].

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-710%2Fdscho%2Fcrlf-aware-git-credential-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-710/dscho/crlf-aware-git-credential-v1
Pull-Request: https://github.com/git/git/pull/710

 credential.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index 62be651b03..65989dfa4d 100644
--- a/credential.c
+++ b/credential.c
@@ -146,7 +146,7 @@ int credential_read(struct credential *c, FILE *fp)
 {
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline_lf(&line, fp) != EOF) {
+	while (strbuf_getline(&line, fp) != EOF) {
 		char *key = line.buf;
 		char *value = strchr(key, '=');
 

base-commit: d8437c57fa0752716dde2d3747e7c22bf7ce2e41
-- 
gitgitgadget
