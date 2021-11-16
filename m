Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29305C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCFE61B98
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhKPJwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhKPJwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92C8C061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:42 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b12so36383097wrh.4
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=196Fzi9pWJNNoy0fcJITLBwaY4nVQto3zq+DfxxjTpI=;
        b=guZdoP0FWkVrfSvv/oNJAWez37MVtBPUIxgxH2Y/cReXcQqByg9JdmPesair+LgXDR
         tPsdic+8pZNeFppQTrRPxXHQSgDrNW9Wrdtm62QDnRhrnT0anuxwFI/Z3IJvnkuO4B0b
         2QvoqhzcjQvGgvM4KVzYaLR+2hvLKLiLZysODrmKsqse3hp20E6F4wlx5zcoBgtFx3B+
         4YbwXNdnCp8GT7sfS/CbwnDmqbMMBYiPrmHR0c4xbsZ0nlpHep9/R2KBCfD4v1d/KYYY
         L7vrJDdLeDPtafffbOBhTU9t0+BF+1wrqKXlPquBYFWSrqlg9KlpvcbGG7RZ7H8IXrTa
         ZStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=196Fzi9pWJNNoy0fcJITLBwaY4nVQto3zq+DfxxjTpI=;
        b=hMUJzmTgKX+cwWf1y9Tel/OMj981pVM4S9j3AQCN7dtNP4Dv6Qjd3cgwTZgH9IK/eT
         d3k86bMqDqna7GxUz8tv0siYRly+hSw5l/KksxGsNsrFtPZXy8saDnkV3oLv1C0jhBaI
         55v5ZcBOBeyMU+yJL0FA2eTCsK6fMP+XLpymtRv1ixiJWppWM/K/MW1m3H+HcwSqOoUZ
         O7/ElIRVl5FXUYrtE9VL0TNu2Fc/XSC72XYMZOOPX3l0JkXW8t7mezaXqP9tYgX3CG1M
         qMzxMJGtslHvMIQcvZKM7/9NmoiHP3Sc9Vb79h1MguGEhp2cQujq1vZwgyr9fG2ArEP6
         nuaQ==
X-Gm-Message-State: AOAM530s4LcuWnCYb3QqkGJVLkXyLLxUsSaEJidxZIFSUwQZuZxlhYRJ
        n82rM6IgTSRKK6TUhTjYvfC2Vii5oYU=
X-Google-Smtp-Source: ABdhPJwnT2WfhrLojxiOo2BAHZF6xvjur6pQWWkirgkLSltVkZIO3cVUOsHsflKhWFi2gMe+afkjYA==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr7472190wrw.253.1637056181218;
        Tue, 16 Nov 2021 01:49:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm16630321wrt.58.2021.11.16.01.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:40 -0800 (PST)
Message-Id: <48ee03cf52a619d22d7ee7b1958dd59872bf721f.1637056178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:24 +0000
Subject: [PATCH v4 01/15] diff --color-moved: add perf tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add some tests so we can monitor changes to the performance of the
move detection code. The tests record the performance --color-moved
and --color-moved-ws=allow-indentation-change for a large diff and a
sequence of smaller diffs. The range of commits used for the large
diff can be customized by exporting TEST_REV_A and TEST_REV_B when
running the test.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/perf/p4002-diff-color-moved.sh | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100755 t/perf/p4002-diff-color-moved.sh

diff --git a/t/perf/p4002-diff-color-moved.sh b/t/perf/p4002-diff-color-moved.sh
new file mode 100755
index 00000000000..ab2af931c04
--- /dev/null
+++ b/t/perf/p4002-diff-color-moved.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+test_description='Tests diff --color-moved performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# The endpoints of the diff can be customized by setting TEST_REV_A
+# and TEST_REV_B in the environment when running this test.
+
+rev="${TEST_REV_A:-v2.28.0}"
+if ! rev_a="$(git rev-parse --quiet --verify "$rev")"
+then
+	skip_all="skipping because '$rev' was not found. \
+		  Use TEST_REV_A and TEST_REV_B to set the revs to use"
+	test_done
+fi
+rev="${TEST_REV_B:-v2.29.0}"
+if ! rev_b="$(git rev-parse --quiet --verify "$rev")"
+then
+	skip_all="skipping because '$rev' was not found. \
+		  Use TEST_REV_A and TEST_REV_B to set the revs to use"
+	test_done
+fi
+
+GIT_PAGER_IN_USE=1
+test_export GIT_PAGER_IN_USE rev_a rev_b
+
+test_perf 'diff --no-color-moved --no-color-moved-ws large change' '
+	git diff --no-color-moved --no-color-moved-ws $rev_a $rev_b
+'
+
+test_perf 'diff --color-moved --no-color-moved-ws large change' '
+	git diff --color-moved=zebra --no-color-moved-ws $rev_a $rev_b
+'
+
+test_perf 'diff --color-moved-ws=allow-indentation-change large change' '
+	git diff --color-moved=zebra --color-moved-ws=allow-indentation-change \
+		$rev_a $rev_b
+'
+
+test_perf 'log --no-color-moved --no-color-moved-ws' '
+	git log --no-color-moved --no-color-moved-ws --no-merges --patch \
+		-n1000 $rev_b
+'
+
+test_perf 'log --color-moved --no-color-moved-ws' '
+	git log --color-moved=zebra --no-color-moved-ws --no-merges --patch \
+		-n1000 $rev_b
+'
+
+test_perf 'log --color-moved-ws=allow-indentation-change' '
+	git log --color-moved=zebra --color-moved-ws=allow-indentation-change \
+		--no-merges --patch -n1000 $rev_b
+'
+
+test_done
-- 
gitgitgadget

