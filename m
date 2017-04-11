Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A401FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 08:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbdDKIdh (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 04:33:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36788 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdDKIde (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 04:33:34 -0400
Received: by mail-wr0-f195.google.com with SMTP id o21so27022337wrb.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Ot9klzWic49WCcJhP0wDisp9zRcrT4vrrnj9f/oaRM=;
        b=j6B3mrePlw4looDww6kD093F7ptLVN9ZjP4XGVQWss5kNMBqS1v5968XRf5xnStF97
         jeSeMrbTTXt4JyM8Zttp0ELTSva2fo5z3nxKYZILwDpJR14AkkQ+9yjQChRcP6bHw19e
         NQB1UQSDfWUra7zO8bKL2yfJg+pJRUcwWBci44lNi2KpNDAgsfO7T5Xe8ZKi2N+uu4DN
         F0N7909cVobDHmIJ8l62R4ErjE0R9+UDj/xx/lou8W09RLCF1CA3BL8HakLDFN2XH4g2
         CtbmhLLeq7M9nVtYZ42qOLbzhzaNueZzNizkkfQYoNwbyEP83a35P4cBqcih+dv7TECI
         QyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Ot9klzWic49WCcJhP0wDisp9zRcrT4vrrnj9f/oaRM=;
        b=Y1oZXOoqeAKV52Gzoj6CpWdYIgWVTM408e8ranKlVJLjVcVvGE1wrsulltSjpIESt2
         lRYXsj3AXongrvjP4MuCnGarGrvUiO9fNVsIli14EkSs3vw+68lTM771fGUEQua2lQZg
         CcQmWmQejPswXKk3vvKwZpNJ8rGWF7a2I3U+3eyosRJq6GZbiJdpmaRMDe8OUmzqwofI
         M3MgVyTTlLWMdwn7FslKfPoo3YnXe0S4CXCySsPAATiIGu67UAwtSLe399XZtj6nHWGU
         s7XkkdMNiMVeRndqOGlx4dxbJmH4OOmxiaoaVI8ozkjY2wuRVNojd9DDX/81+jWJdBQv
         DIFg==
X-Gm-Message-State: AN3rC/4lbGoQ7R1TaABYBTN0DiBT7/5NGmhJ/0gfWsSreJ3WQU/AbbbsnulJBcG2zQ71Bg==
X-Received: by 10.223.183.21 with SMTP id l21mr14196600wre.191.1491899612716;
        Tue, 11 Apr 2017 01:33:32 -0700 (PDT)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id d17sm1499083wmi.21.2017.04.11.01.33.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 01:33:31 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net
Subject: [PATCH v1 1/3] travis-ci: build documentation with AsciiDoc and Asciidoctor
Date:   Tue, 11 Apr 2017 10:33:07 +0200
Message-Id: <20170411083309.58315-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170411083309.58315-1-larsxschneider@gmail.com>
References: <20170411083309.58315-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ec3366e introduced a knob to enable the use of Asciidoctor in addition
to AsciiDoc. Build the documentation on TravisCI with this knob to
reduce the likeliness of breaking Asciidoctor support in the future.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml              |  2 +-
 ci/test-documentation.sh | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 591cc57b80..c26f3bf789 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -69,7 +69,7 @@ matrix:
           - asciidoc
           - xmlto
       before_install:
-      before_script:
+      before_script: gem install asciidoctor
       script: ci/test-documentation.sh
       after_failure:
 
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 579d540d32..e47d2ea611 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -7,8 +7,16 @@ set -e
 
 make check-builtins
 make check-docs
-make doc
 
+# Build docs with AsciiDoc
+make doc
 test -s Documentation/git.html
 test -s Documentation/git.xml
 test -s Documentation/git.1
+grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
+
+# Build docs with AsciiDoctor
+make clean
+make doc USE_ASCIIDOCTOR=1
+test -s Documentation/git.html
+grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
-- 
2.12.2

