Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188091F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJ0EGO (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 00:06:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52328 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeJ0EGO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 00:06:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so2517001wmw.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqP4ifgdyK4zyDNdbbZLEqxXMcAsbdFVTcoO9nvJutA=;
        b=N1eNc+Y4C63zGWgo6IYyckhXtWoG3XgmO9JmzlRFZeoBIpQF7KJXGnMSxRmO16r9kE
         r9+bC8SaLVz6OnYSWfczf1zajf+yqBgJ0sTN3pft1jcio2iE2rIBfrIOI0c6WtSWc1YI
         xqvRrMlU5X2L2SJc04X+Uaawaq/NRugAwAim9g2jLo+gKiQt6ed02hNZCotCHTt0g4kJ
         Zisl2vM1s51PSm6G3NpSe3ZsQ0mA/ZB/r2QZVzIQHjTg9d4mICWdhuWRNHDOwxHP/Q0v
         W+KzaiPOsIeZot6eVPewQcEZQ4NRyeX/yvhagoySFhEqFKUFyMiwKMHgPe2ggathH02G
         avFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqP4ifgdyK4zyDNdbbZLEqxXMcAsbdFVTcoO9nvJutA=;
        b=AULSNNHUWDYnwczfrI7jo3hDAzHcvOuoCz3FHVVMzi/rL5SdPMRxGsxI5SkTxnnZZ2
         TzP5YzE3aISVOZuWCcnXXwCCbw7j3oRl0RqvJcyeZo2htVRUEnYVfykVZZvidWVRsAFt
         6haU1s5XE7deZmnyqUsCpLxX2TSGUeYA7uUsXu6LxsfZwhg+EpFskSzhwLyc8gnj80B9
         uvmXWOZ6WbwoA6HZU82pgvkT7iJaUZsMbYU/wVN47u3T5E2baNOOM2WtlTpDl4WJP/qg
         THZ9EssDAXIqdfW7K4XRR3zBlH8+nXlWRzs7p8muUY+GGsUvTUANL+I9I8J1HQTqeqWS
         hHQg==
X-Gm-Message-State: AGRZ1gIKlk0xpZTVJIxb2onlAyJ4rHKTBNp1QlWJa6+cstSSexPi4Uen
        FJtt3WRL2S16lqSv5g/kv5WKzxCq2+o=
X-Google-Smtp-Source: AJdET5cWPerzWV8TYoi2OWEFyum2A0uZ8LjngfmX6ZEC49UEw9fUxN/+s8WG5lyn5KV4X1LC4GHrQg==
X-Received: by 2002:a1c:981:: with SMTP id 123-v6mr6373406wmj.130.1540582074903;
        Fri, 26 Oct 2018 12:27:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e196-v6sm10738981wmf.43.2018.10.26.12.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:27:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] push: test that <src> doesn't DWYM if <dst> is unqualified
Date:   Fri, 26 Oct 2018 19:27:33 +0000
Message-Id: <20181026192734.9609-7-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test asserting that "git push origin <src>:<dst>" where <src> is
a branch, tag, tree or blob in refs/remotes/* doesn't DWYM when <dst>
is unqualified. This has never worked, but there's been no test for
this behavior.

See f88395ac23 ("Renaming push.", 2005-08-03), bb9fca80ce ("git-push:
Update description of refspecs and add examples", 2007-06-09) and
f8aae12034 ("push: allow unqualified dest refspecs to DWIM",
2008-04-23) which are most relevant commits that have changed or
documented the behavior of this feature in the past.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5505-remote.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2e58721f98..979a13b415 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1246,5 +1246,33 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	)
 '
 
+test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
+	(
+		cd two &&
+		git tag -a -m "Some tag" some-tag master &&
+		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
+		git update-ref refs/blobs/my-file-blob HEAD:file
+	) &&
+	(
+		cd test &&
+		git config --add remote.two.fetch "+refs/tags/*:refs/remotes/two-tags/*" &&
+		git config --add remote.two.fetch "+refs/trees/*:refs/remotes/two-trees/*" &&
+		git config --add remote.two.fetch "+refs/blobs/*:refs/remotes/two-blobs/*" &&
+		git fetch --no-tags two &&
+
+		test_must_fail git push origin refs/remotes/two/another:dst 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/two-tags/some-tag:dst-tag 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/two-trees/my-head-tree:dst-tree 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/two-blobs/my-file-blob:dst-blob 2>err &&
+		test_i18ngrep "error: The destination you" err
+	)
+'
+
 
 test_done
-- 
2.19.1.759.g500967bb5e

