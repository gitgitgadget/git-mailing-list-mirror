Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86E5C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB0F6117A
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbhJGKDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbhJGKDn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:03:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D5C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:01:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v25so17268830wra.2
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6NQEeT/pN+bjaaPpeUiMoZ7ljb1rZNuzKqQeS7Gs3U=;
        b=NhQfsBWKZSrjtzXrIYNFBTaKuT6zlxsonGMhqM4xmVU2BUXnfQ2w2MshZ1xgufxlZ/
         oQe8pN8QQASMtAA0ILP5OHHtcCPdLGrT/rcBLOIkkB2iHZMkz+NFpFct319+TDYi586K
         DlBHiv3LhppDcM5qRpwALHm/PLwSK6bBBXYwa08yt4LaymMxIG+aaTovOsrG7Wd8SXfV
         mkbCBOxQA6x1ppQm3KU3Whl+xAX3Gc2KXFrA0O0oy9Przg9pJS3IvPqhVP6MPiLkFU7z
         c28SJ50n50W+ysNsC7a0sDXdzPybnkV37bbAaztkZ/WGG6oDodPMVGysWaNYPKZzZhVE
         boLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6NQEeT/pN+bjaaPpeUiMoZ7ljb1rZNuzKqQeS7Gs3U=;
        b=boH7hJxwMcRFydXKS0fGkkCFkAA8UdJdgfKNJol6OATBF3fJ767sMg/bgrvJzB7pLA
         KNo8MXj/1A2YABk1vIpTxd9zSnxdd+yopfIyonYdc/HNn9Xt8YhU0JPpEMaeah2Bn1aR
         U1QJwcbChmZPBob6hcS6fkS/iiTYYBzUhvWIPl+S+LQ+6EHQg6J8cVQ2EcNWNzUTxW0T
         92zZ8u3xIocM6e0VQSkNNAetF0hMz8bZ/xYIledlxXmDQEilEcvQfaBasKHoUAbNtDfT
         g0Xg7S5MVG9OL5vhNG+tvAEAF8MbxJs6Hf7vfnrXLSkcuDwopX3+SXjwHEXHJUyWQiF7
         QZJg==
X-Gm-Message-State: AOAM531/iDRoLgta/sxIE+EsqBYew71FtCKMmWA64BAt3VzsIO0rovft
        pjECEvCbK14ge7qCb6HjxGtmlfLwfPqxIA==
X-Google-Smtp-Source: ABdhPJwPlu60XSkpAHNaZk1V7YQsK9OOlRzWUL6FPpI2PUNW7tdTQVH7A4ZZnjnJdsC09GoXXtlCPA==
X-Received: by 2002:adf:c78d:: with SMTP id l13mr4170902wrg.134.1633600908453;
        Thu, 07 Oct 2021 03:01:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm628559wrr.53.2021.10.07.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:01:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] tests: fix test-oid-array leak, test in SANITIZE=leak
Date:   Thu,  7 Oct 2021 12:01:34 +0200
Message-Id: <patch-v2-4.7-b8ce8d7e972-20211007T100014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a trivial memory leak present ever since 38d905bf585 (sha1-array:
add test-sha1-array and basic tests, 2014-10-01), now that that's
fixed we can test this under GIT_TEST_PASSING_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-oid-array.c | 4 ++++
 t/t0064-oid-array.sh      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index b16cd0b11b1..d1324d086a2 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -35,5 +35,9 @@ int cmd__oid_array(int argc, const char **argv)
 		else
 			die("unknown command: %s", line.buf);
 	}
+
+	strbuf_release(&line);
+	oid_array_clear(&array);
+
 	return 0;
 }
diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
index 2e5438ccdac..88c89e8f48a 100755
--- a/t/t0064-oid-array.sh
+++ b/t/t0064-oid-array.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='basic tests for the oid array implementation'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 echoid () {
-- 
2.33.0.1446.g6af949f83bd

