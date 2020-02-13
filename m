Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA82C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB112206CC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV+783xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgBMS7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:59:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43097 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgBMS7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:59:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so7994086wrq.10
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 10:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IdKCESMQ+SzRi7//uH5ZlU0/7iBrSjkU4CP5tGuZb7k=;
        b=FV+783xn5jbc/QcUBuDxVE8bp78RYDN1mTw5N/Sfasz0NC0op+Z0MuvkrGtII9+gMX
         pswTA0YSlzHY/sFo8OgF2Zj3y5WXnt0snzoVTiljmHBpJhR++rQ6RDNW/nNWy82sp7vL
         IbYL+os8HHd2zWRnee0v+x3pehuc2AsVOG51/CJEuEF1wHO9diZ2n+L5UGaMkVUxBMmF
         nhSQzFRGBohd0gmQTxiZyUNWbNXwNsY4jKwYH3PndzO2CacD2RKvRueFzS6wTyOA94Zo
         GOZEdH5OWiFE3zyp7l4qz/A5PG8lLYdovbyMJl01OECoL9ewKy5dZURpzRZ+REZ7fssa
         b5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IdKCESMQ+SzRi7//uH5ZlU0/7iBrSjkU4CP5tGuZb7k=;
        b=acM2W7kcTcxF4yzleAaNS2bF1UZyegQzAvyxfrgt7Xd41nI80XsPKD2XU5rm3TInLF
         luy5KF8u9U7V1i7oDf4PB9CEYFsvkCIHb3MLIrBiI8MfZWe60f87LpLwIO1r1Dfi6HRa
         JFyVHEOIoK/P6fOh9vNF5B1DTjUkENDRFJ8DgmBYXLGplDpPplQT31tTdFQ8P72gAh1U
         CrkIbhovWl4p1v2t1LBBr8gxBOe4WyT/YzHbpSYR+RTPkBb++xH4OppT5w590KxR/Rx3
         bIRGrkiBUfFewlOR3KAyghq/6P4p1rtAkNqx+l3Bwtq4fR3SpFGk7fbfc3aF0qGIOLJ/
         3Pyw==
X-Gm-Message-State: APjAAAWiNiFYaAhkVjcBsRPy+0dca5Zc2cVmx5kW7kpbymfe4LrJADx0
        odrUjyQLxhXWYxypxZHk2v4JJ/47
X-Google-Smtp-Source: APXvYqwYpZ0STRwK/MaLXSUIiE6tdXO0v/k5XnWrMSHY1giaP87jpLKwul9fpyMYUUryfRWNjj6SRA==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr23227296wru.154.1581620352638;
        Thu, 13 Feb 2020 10:59:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm3942535wmi.27.2020.02.13.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:59:12 -0800 (PST)
Message-Id: <902c8a3f17153ebd3871aa51e5cabe9338438655.1581620351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.git.1581620351.gitgitgadget@gmail.com>
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Feb 2020 18:59:08 +0000
Subject: [PATCH 1/3] get_main_worktree(): allow it to be called in the Git
 directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

When called in the Git directory of a non-bare repository, this function
would not return the directory of the main worktree, but of the Git
directory instead.

The reason: when the Git directory is the current working directory, the
absolute path of the common directory will be reported with a trailing
`/.git/.`, which the code of `get_main_worktree()` does not handle
correctly.

Let's fix this.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 worktree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/worktree.c b/worktree.c
index 5b4793caa3..7c8cd21317 100644
--- a/worktree.c
+++ b/worktree.c
@@ -51,6 +51,7 @@ static struct worktree *get_main_worktree(void)
 	struct strbuf worktree_path = STRBUF_INIT;
 
 	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
+	strbuf_strip_suffix(&worktree_path, "/.");
 	if (!strbuf_strip_suffix(&worktree_path, "/.git"))
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-- 
gitgitgadget

