Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E261F461
	for <e@80x24.org>; Tue, 14 May 2019 00:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfENAYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:24:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36474 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbfENAYO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 20:24:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2302960825;
        Tue, 14 May 2019 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557793451;
        bh=tXkwZBie4yZ08BeN/2OOShqFaVZ0FAhWy+7epQChYlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=oCbG0Ta2moYhRXAZqGgyjfm/KFlMO6YlIMuW9uoQl4vKfBv2mlTcxTjk3zklIQ3xG
         2rvyjpmglIgyNWqYGv6oJT54sXDS50VeVrdpjyX5DSFOnfBq+p/i2eN5V2XIYNpboz
         nncM4qzvPrhd6qLs3aoTyK5wA1/GvcoqyJdLMMksQ8t+Cgky9MoOxE/DD3EH8Sw+xB
         xFaKNfCUXNdIwVYoDgzvSXLE+CUL57ZpSEp8i82+O6aXEzDpGOP5ykqAzpBxfVyaXz
         84nCPUHM+/5P1gmJgfLgh5avGm5d3zMN5/x9kR/VyQUHE4Tlf88RGC3exA+fQ9rHDZ
         d87I2pvAESEJwLQt8qNop6zsTiQOjgV+DLtGfwmb0pmAOBcLoikhkAqIIa+FJKvd1T
         u6ecBv2fqne6dV5ubl7+lpCzT6U3do2BUu/aNTznqh1ODW33aeLcV5MliH7PXagYB7
         /iRfjj7w1xX3x34qvAsXSAXrHZMS22kmf+zcQlvYke4bjsiECh3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 7/7] docs: document multiple hooks
Date:   Tue, 14 May 2019 00:23:32 +0000
Message-Id: <20190514002332.121089-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190514002332.121089-1-sandals@crustytoothpaste.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the semantics and behavior of multiple hooks, including the
configuration options and requirements for them to be run.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config.txt      |  2 ++
 Documentation/config/hook.txt | 19 +++++++++++++++++++
 Documentation/githooks.txt    |  9 +++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 Documentation/config/hook.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d87846faa6..f62b8ce494 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -350,6 +350,8 @@ include::config/guitool.txt[]
 
 include::config/help.txt[]
 
+include::config/hook.txt[]
+
 include::config/http.txt[]
 
 include::config/i18n.txt[]
diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
new file mode 100644
index 0000000000..4585cc7f55
--- /dev/null
+++ b/Documentation/config/hook.txt
@@ -0,0 +1,19 @@
+hook.<name>.errorBehavior::
+  Control the error behavior when using multiple hooks.
++
+--
+* `stop-on-first` - If a hook fails, do not execute further hooks, even if the
+  command normally ignores whether hooks succeed or fail, and return its exit
+  code as the exit code of the hook set. If all hooks succeed, the exit code is 0.
+  This is the default.
+* `report-any-error` - Always execute all hooks, but return the exit code of the
+  first failing hook as the exit code of the hook set. If all hooks succeed, the
+  exit code of the hook set is 0.
+* `report-any-success` - Always execute all hooks, and if any hook succeeds,
+  return 0 as the exit code of the hook set. If all hooks fail, the exit code of
+  the hook set is 1.
+--
++
+If the exit code of the hook set is zero, then the hooks are considered to have
+succeeded; otherwise, they are considered to have failed. Note that the success
+or failure of some hooks is ignored (see linkgit:githooks[5] for more).
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 786e778ab8..c680e575b3 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -31,6 +31,15 @@ Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
 details.
 
+It is possible to provide multiple hooks for a single function. If the
+main hook file is absent, hooks are additionally looked for in a
+directory with the name of the main hook file with a `.d` appended.
+(That is, if `post-receive` is missing, `post-receive.d` is inspected
+for any hooks that might be present.) Each of these hooks is executed in order,
+sorted by file name. By default, if a hook fails, additional hooks are not
+executed, but this can be controlled with the `hook.*.errorBehavior` setting
+(see linkgit:git-config[1]).
+
 `git init` may copy hooks to the new repository, depending on its
 configuration. See the "TEMPLATE DIRECTORY" section in
 linkgit:git-init[1] for details. When the rest of this document refers
