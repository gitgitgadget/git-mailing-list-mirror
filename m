Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A303820248
	for <e@80x24.org>; Thu, 28 Feb 2019 15:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbfB1P16 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 10:27:58 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41229 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbfB1P1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 10:27:48 -0500
Received: by mail-ed1-f51.google.com with SMTP id x7so17286714eds.8
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8LfcSrLOEv9iR3BQW0qnYzjf0jxEkvjaoepxZHwCoxE=;
        b=lNw28W0BaKKjGExkF5O3n0f+SlJWXM7PS5c7nTfCHwC1zb1qeF74WLFKN7Hvgn/vFz
         YT01XA1Q49259N0AsS5CvMdS5gn3DyjJiBNlu0Sn7VIg6vszVQ+GGbwLUyMoreEqKi8o
         HG/S7j0XteYi5+Yc4DhjpwwPFH+V2toXZHAL1uSN5Y9uCBgMG/eGy/QTVLD9OcnW3CW5
         Hi0JNdj9TDip+l1m5DbybHGAvTeebubDpmq/BLnQ6VHuUfs6Z6RAmdimTeIH8TFRHln9
         0SWAmbA8dlxEK8TsR2pna0CsrWMayKfkg15GwLTeNLb3SfVM13zqLb2YBvWT9bWDOO85
         qoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8LfcSrLOEv9iR3BQW0qnYzjf0jxEkvjaoepxZHwCoxE=;
        b=GJfm025DTfiVGzOFC1mcpkIXUAHwdhOuQkaQqsgjoGIUiqz+INQ7p6/FYr+RGKdIZh
         yBMsOnqoGCvkMDCAe4ZF2viRYUC+tMMQf7x3Lb1zNR2rq8fUeCPkkgJ12vTKEYTHJ1sl
         zvfbliLMtMeaozFsSqr1ku7DpqF+y6pmZWh/pIhZPd4mgFq94aojA5LFZGdAQ3uDbEQ3
         hfVhjh9B/DnbK3emaKSURQZp24Rqry8CXPWKz9vvKhOUPUF/KZXjT/cJHC3cOfvwyrod
         6dhil4jJwVi7R3aPUOGL+eV5IdlGARi1Ci5j54qS/K1a1DTGcfT4UAuhR3w2RbgPqORz
         +XLw==
X-Gm-Message-State: AHQUAuYXG54srwwjhlLl7RG9Bl/e1xSe3p1cFj2xhtf1e3wjALMlKr3M
        GW4sss0+8rmNyQCCIzzb2n44EPjG
X-Google-Smtp-Source: AHgI3IZ5icmmuZtFs9GXIaF6Tl6CceavNeOx/LuPtYRixd13poi/Ma4uJL/OfvsJH0U9QGHpMxCfmQ==
X-Received: by 2002:a17:906:3b8e:: with SMTP id u14mr5849224ejf.130.1551367666071;
        Thu, 28 Feb 2019 07:27:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm1527257eda.69.2019.02.28.07.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:27:45 -0800 (PST)
Date:   Thu, 28 Feb 2019 07:27:45 -0800 (PST)
X-Google-Original-Date: Thu, 28 Feb 2019 15:27:41 GMT
Message-Id: <2d99429387ba63526efe233bbefe851c5d556fdc.1551367664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] built-in rebase: no need to check out `onto` twice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the case that the rebase boils down to a fast-forward, the built-in
rebase reset the working tree twice: once to start the rebase at `onto`,
then realizing that the original HEAD was an ancestor, `reset_head()`
was called to update the original ref and to point HEAD back to it.

That second `reset_head()` call does not need to touch the working tree,
though, as it does not change the actual tip commit. So let's avoid that
unnecessary work.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 08ec4d52c7..813ec284ca 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1740,8 +1740,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
-			   "HEAD", msg.buf);
+		reset_head(NULL, "Fast-forwarded", options.head_name,
+			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf);
 		strbuf_release(&msg);
 		ret = !!finish_rebase(&options);
 		goto cleanup;
-- 
gitgitgadget

