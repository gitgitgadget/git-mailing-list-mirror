Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EAECAAA1
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 16:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiJXQUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiJXQSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 12:18:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D240E1E
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 08:04:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so8035751wrh.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hx8MTcO9qtJ2RzEoDcJrkdJfjD3/h3bxqdijd6mxO+Q=;
        b=Wu0Ktj1aN4WHdtAt6xPmGWiFZXBVapp3KD2XljuEzH8WL/fdp4egKfKM6NICTF6KSV
         YekVTMlSgyahJMvLJLTo8HQFfb3qKzHeXkLk5xjL/ngaEXBFej9ESwAXb+xSKd6IofD6
         9qpf+pReS2tF2wIa4vp9rRm+MG8I1uPxRoYEuZhxa4YxYVQJSPYA8QXXKyf3l8pBb2Ka
         PQQ8ubZ30vGP9WjsyoHgVPcM/5W1SYZChH8jej1fe38zRZMxJHBZythYcv6SHfBX0MVf
         5eAGVu0zgTkQZk7BwpllmLOk6HpxmrXb7j1CrTKga1zcyiuV9AHvFghYyjJe685LQxbT
         S5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hx8MTcO9qtJ2RzEoDcJrkdJfjD3/h3bxqdijd6mxO+Q=;
        b=iqv1jLLPOsQPXdIRZkZQkpQ5J2+vU7fUYfDhDRIcvONckAXd5FUbOPOpLKUoUx0AJ+
         IQbe0+rpkMXA8AijbtJXtFtj+cSSj82xW3FPu35zDMK5sM48ZuteLFKmiE6zsqBYqhfZ
         YImMR4BpYOoXYn3i7LWBBVTzW+JQY1D9qfQ0MPMAxZ5K+pOnuYTirky9zA8F+aj9aAAX
         hf0QYwjOBR8Q15kxXtkMd7VXlTzgl3o6eE9JfbOyNAutoQ59E/NVqMfwu7xDkyWP6njv
         dbOGPRgj3pnz96ptRbp4x3oUoQqjNwO1TCoUQdgsbaBTAL10tOc+WChrjWGJC2/MNAuJ
         E1Pw==
X-Gm-Message-State: ACrzQf1FMIiaKB0odj9FhEqyg/oR65MM/AxE5txvNmZPdcN3MdZmPOfn
        YljtyfQDidHwSEogF39ODp71vIiB9Ng=
X-Google-Smtp-Source: AMsMyM6YTXMOIBpugJvfnUR8cioYASID1Px7rcx/tNkOlYRNNiGvXPf6Mdo/YNnZyqVdxqagGEycPQ==
X-Received: by 2002:adf:e198:0:b0:22e:ab4d:935b with SMTP id az24-20020adfe198000000b0022eab4d935bmr21825517wrb.306.1666618875016;
        Mon, 24 Oct 2022 06:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22-20020a056000025600b00231ed902a4esm12207238wrz.5.2022.10.24.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:41:14 -0700 (PDT)
Message-Id: <acfae17548c59b3a0145740addc0c1b8f175355a.1666618868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 13:41:04 +0000
Subject: [PATCH v4 5/8] trace2: improve thread-name documentation in the
 thread-context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Improve the documentation of the tr2tls_thread_ctx.thread_name field
and its relation to the tr2tls_thread_ctx.thread_id field.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index d4e725f430b..3ac4380d829 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -25,12 +25,15 @@ struct tr2tls_thread_ctx {
 /*
  * Create thread-local storage for the current thread.
  *
- * We assume the first thread is "main".  Other threads are given
- * non-zero thread-ids to help distinguish messages from concurrent
- * threads.
- *
- * Truncate the thread name if necessary to help with column alignment
- * in printf-style messages.
+ * The first thread in the process will have:
+ *     { .thread_id=0, .thread_name="main" }
+ * Subsequent threads are given a non-zero thread_id and a thread_name
+ * constructed from the id and a thread base name (which is usually just
+ * the name of the thread-proc function).  For example:
+ *     { .thread_id=10, .thread_name="th10:fsm-listen" }
+ * This helps to identify and distinguish messages from concurrent threads.
+ * The ctx.thread_name field is truncated if necessary to help with column
+ * alignment in printf-style messages.
  *
  * In this and all following functions the term "self" refers to the
  * current thread.
-- 
gitgitgadget

