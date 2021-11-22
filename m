Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B81C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbhKVOYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbhKVOYG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 09:24:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF189C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:20:59 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 133so15603482wme.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2bnCoDymTUy35GY0pnGuwLVLYsI77eGdhk8l9/1MYn0=;
        b=TbHTd0Nsgh/BZgNAI3BnjF+HJqYjHPMxEhmA0RxOgN8ZK1p1FwL8xCUfflwscBAMYM
         kHXevm/2HRqHFVEoRl3vmgGeEtF7yPn9UT00MvPSsDWPc6BjNiP5ON8rhh49u/4a4D2G
         R1ON3kzJj+Sb981EKh4XTrEPM8jGavYRZXrvsPJH2h5XAUUxzytz7PeFkFbTLLu2ja2F
         CqsFteTT25KqjV8GuVWfZtJcxU4KsyqnbxtRa3jmNl4VVWxW3TCjNxuP+ISFvDCBtdH+
         MOaWBXi3NG9HymMw+WXdObkkUjEdoSPmWmqUFi6z4rjhaWnjFIqy4ULXmYjeY+ucLVm0
         xvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2bnCoDymTUy35GY0pnGuwLVLYsI77eGdhk8l9/1MYn0=;
        b=kKfozFUvJCkFqXiqOo19FxWpJzvhkwQtckd1737U+q+FoVzHLSJjoSmQ/x+7CUkbPC
         jUto5pnO7TcbOABDQ/ZVN+kVklKFFXrV5Qxv5scFswsMJcrFF7RwcDYpCqvm5u5QqsVt
         2BjKbh9LmCHhpKG4FaFaXkYSOY86oEJA8JbZGe87T/eMPWtTVw7AK/Y8RF8v3Av5sDLA
         JgE/Xw3Tl1EXLfL7zIO33zI2fsezSsYysBWn+PEeBG0vIp426nKH+DO4JrIrpP38iPyU
         9huL7iQGUjG1wktELZGjzjLQkvoqwLTF15PocrIt8QD9gcBoVY/Enad7bP4FMcu/qxJb
         Y0tA==
X-Gm-Message-State: AOAM532yXD69FUcN2867/TlWuHBD83I7m+jYPcdFbhuVMVwCEvp1z6Fp
        b0eHV9Ig9vOmmQG1Rtmm6WnAVFdHBdo=
X-Google-Smtp-Source: ABdhPJwvyrAh3jLkvT/8PsGkhAb63OEvxj+hZz8YaJRa/dfXtvBtfdC9msrNNy4ngp6Ngr0beiW/Dw==
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr30388993wmb.14.1637590858314;
        Mon, 22 Nov 2021 06:20:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm10789182wri.74.2021.11.22.06.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:20:57 -0800 (PST)
Message-Id: <8a1b094d54732b8b60eacb9892ab460a411bcec3.1637590855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:20:54 +0000
Subject: [PATCH 3/4] test-ref-store: tweaks to for-each-reflog-ent format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Follow the reflog format more closely, so it can be used for comparing
reflogs in tests without using inspecting files under .git/logs/

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 5 ++---
 t/t1405-main-ref-store.sh | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..0fcad9b3812 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -151,9 +151,8 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
 		       int tz, const char *msg, void *cb_data)
 {
-	printf("%s %s %s %"PRItime" %d %s\n",
-	       oid_to_hex(old_oid), oid_to_hex(new_oid),
-	       committer, timestamp, tz, msg);
+	printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
+	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
 	return 0;
 }
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a600bedf2cd..76b15458409 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -94,6 +94,7 @@ test_expect_success 'for_each_reflog_ent()' '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
+	head -n1 actual | grep recreate-main &&
 	tail -n1 actual | grep one
 '
 
-- 
gitgitgadget

