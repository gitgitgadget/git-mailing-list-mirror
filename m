Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463401F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754735AbeDTMLL (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:11:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44534 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754607AbeDTMLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:11:09 -0400
Received: by mail-wr0-f193.google.com with SMTP id o15-v6so22380436wro.11
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8mhknhIhA91ENXz8b+Rh61zn0JBtKkUdXfF5rPNVmrk=;
        b=Vr8WEKM4Fwqjpsa9cXcxi4GK/SAXPDJN50x7gn7VFo1ySh09WWT6WZzVGUPaE9dtkg
         mqXuOJMK/xbbh3bptrrL2+ALlvf/gWfumtBrH/4nZyqvQs4BWORCNBep08+sIQXrYI63
         UP6qx0mEwIYB+sAeJSKbTaqu+f2y6iPdFzRR1eISaVDqsnIJTQe2eryTeTr3hv21OC9v
         +P5Kj2GucN7GlfYYESRItsWCHMWHdtpjsYdVQr889sSh7wvmQDN+s0Ip3/82+KfUsOTc
         JKWjv0Ae08Tq8YRWAjzWy2gxwBNcpZMk0mkesNp61w7qELG45e6ZWIWdpSW7oWgaxnpB
         owZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8mhknhIhA91ENXz8b+Rh61zn0JBtKkUdXfF5rPNVmrk=;
        b=l01RxPG1dcVaK0N40lwUscxCuaGLJgcbkEN6HTIy60Has/uAGfwD9hX84aRpB/8PPI
         UUmc7vuKOuHAG7fJVSQuXqUHmXCmooY8DC7mscz++swsk2Tz6cXiW9SLAzE4NqtZpZiX
         huY9EiB/TZ/X3X1w5qxrzh4Wcw562KuccGfdNz2ZHyKkAu9WBagO9kWGsgJl2MzJj/DE
         NS9IPhkZ0Lzyh2Fq6ZysM1UyuvbaYGav4MGm4xPx1JGB4i7e4mYJlUWMNAHg0CHSJT5h
         p9QEKN7hPwOkj/ruEwdt8pT//ogSWjA0cBhkQzUskd1K07z/QX5x/n+eiBL28NcnuAWd
         Hp6g==
X-Gm-Message-State: ALQs6tBtAfRStiAMW7OnB69g1/ixlQuAzoPdYtgl2cXKaRO0xwFVJt1t
        TY4VrfAa0cw0ATaZ2dAZIkIehgHx
X-Google-Smtp-Source: AIpwx48t2694pk6XXzS2x+wEekQW53EOqkZJm0hYuHnVvzqCFjQCK92MgSVIPWCQrv8rmACmf1r9IA==
X-Received: by 10.28.179.67 with SMTP id c64mr1685066wmf.144.1524226267880;
        Fri, 20 Apr 2018 05:11:07 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h16-v6sm4764515wri.16.2018.04.20.05.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 05:11:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1] perf/aggregate: tighten option parsing
Date:   Fri, 20 Apr 2018 14:10:41 +0200
Message-Id: <20180420121041.32558-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.257.g28b659db43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When passing an option '--foo' that it does not recognize, the
aggregate.perl script should die with an helpful error message
like:

  unknown option '--foo' at ./aggregate.perl line 80.

rather than:

  fatal: Needed a single revision
  rev-parse --verify --foo: command returned error: 128

While at it let's also prevent something like
'foo--sort-by=regression' to be handled as if
'--sort-by=regression' had been used.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 48637ef64b..2cc9eb0ac5 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -46,7 +46,7 @@ while (scalar @ARGV) {
 		shift @ARGV;
 		next;
 	}
-	if ($arg =~ /--sort-by(?:=(.*))?/) {
+	if ($arg =~ /^--sort-by(?:=(.*))?$/) {
 		shift @ARGV;
 		if (defined $1) {
 			$sortby = $1;
@@ -76,6 +76,9 @@ while (scalar @ARGV) {
 		}
 		next;
 	}
+	if ($arg =~ /^--.+$/) {
+		die "unknown option '$arg'";
+	}
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
-- 
2.17.0.257.g28b659db43

