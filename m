Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36561F45F
	for <e@80x24.org>; Sun,  5 May 2019 08:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfEEIQy (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 04:16:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfEEIQy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 04:16:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so4887996pgh.9
        for <git@vger.kernel.org>; Sun, 05 May 2019 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9+/DMrEcPND9AkFf6E0e7ExQKQ48lC2vlsvVwWRI34=;
        b=POLmrQgrL/Q85KDk79Rkp8yR1RwT+hNCERvPI9xxPv+ZxFnOqYtpiHT8+DDZmyn6qy
         vtCZIgxYX8Py55MYvbG/DL6oRBa2y2de427NJ0rv+b68Iey6+iXGAC1l9mCBStw26umn
         sQih8QCuXGP1WSEfsKVugGKHGMYBw1f41d+EmbhqCIr09vYbQGndhIeWGxmlJnSltKJs
         bvOUbOU9fmIW3hISo/zMhtO2Ol5I/SJShmM0vVqspSJ9zNL4eL1yEJfb8jDpfIgcjDUt
         wPHXfCex/oFO2aR2lUNut1DJoIeJTPy66ZokEMxIImnUwuaRiFFx82V0hBCaS+yGu7LS
         7kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9+/DMrEcPND9AkFf6E0e7ExQKQ48lC2vlsvVwWRI34=;
        b=rVGfcBfUJQkwssvYYsUhnz/oGLd7++fYCYFOj1JdeAG1eAIi8+Up2T7rRFDSj0Nrq6
         EHdtK0zpl4mZvcNQxGZxJXIyUu8UKHmTEsUPoS/E0oeb0HqpwN9OW5cL86oxy9ii+l9H
         WXXt3MOA9eAswH4p9eEyQhD1bXFuUNl8mHA2FkoPgiJdPZTXJP7IPSnwjV2FqYHfq0tZ
         KnWPaYdsyEidBneQNxKp3vlUARfqxj+a5GAIU3A7UDx9ZfdlsRbqEiQ3Kg2AXrhvZKT9
         H/JtxfM2QD7rbNzmdThKGRvcRWyTdLcozYwd6mGOZ58mk7KauTCiY35eEHArijMQPNJc
         k0uA==
X-Gm-Message-State: APjAAAVL9q037xP27v9IfFXrnoWcN0DUzXT1rhhlHSId6GIpJlSon3xP
        zcF70nwebz1DqG6GiWYwuNe66Ms0rTY=
X-Google-Smtp-Source: APXvYqxtuNnLXIA8VLaRUsxi3/ugfmMBiK8yCf2fDaKVV5JUAaDMflwUNkjifBxBF3QCNUjaVYFkNA==
X-Received: by 2002:aa7:8252:: with SMTP id e18mr24262160pfn.105.1557044213560;
        Sun, 05 May 2019 01:16:53 -0700 (PDT)
Received: from MBP.local.hk ([202.189.108.96])
        by smtp.gmail.com with ESMTPSA id a10sm8789913pfc.21.2019.05.05.01.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 May 2019 01:16:52 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH v2] t4253-am-keep-cr-dos: avoid using pipes
Date:   Sun,  5 May 2019 16:16:33 +0800
Message-Id: <20190505081633.41157-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0.777.g83232e3864
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
Thanks to Eric Sunshine's review, I've removed spaces after '>'
and changed 'actual' into 'output'.
---
 t/t4253-am-keep-cr-dos.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
index 553fe3e88e..6e1b73ec3a 100755
--- a/t/t4253-am-keep-cr-dos.sh
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -51,14 +51,16 @@ test_expect_success 'am with dos files without --keep-cr' '
 
 test_expect_success 'am with dos files with --keep-cr' '
 	git checkout -b dosfiles-keep-cr initial &&
-	git format-patch -k --stdout initial..master | git am --keep-cr -k -3 &&
+	git format-patch -k --stdout initial..master >output &&
+	git am --keep-cr -k -3 output &&
 	git diff --exit-code master
 '
 
 test_expect_success 'am with dos files config am.keepcr' '
 	git config am.keepcr 1 &&
 	git checkout -b dosfiles-conf-keepcr initial &&
-	git format-patch -k --stdout initial..master | git am -k -3 &&
+	git format-patch -k --stdout initial..master >output &&
+	git am -k -3 output &&
 	git diff --exit-code master
 '
 
-- 
2.21.0.777.g83232e3864

