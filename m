Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D3EC35674
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6605B206EF
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd0gWcy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgBVWfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:35:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39331 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgBVWfN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 17:35:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so5566461wme.4
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9vcvACtESSI0at8vQhtic3fX/w7zVQNgQce3yCWhKpo=;
        b=jd0gWcy6t2eKB+6QE9Ok4VHM2Bkf354cWjoaKedRDQHTRbqHjG3kY/WStZ8/BPukKT
         NX6rhiDoRnqKeeQuaVVKhbYUfB4xsQlMj63f0NZF+0sNUDoECNnhIA2rVvQi84q4H/Y0
         9SN8Qh2kVX8wwVNh/kWFWOzdVuFddqc+8iaVaxxUk2JlkR+UFq1of+jw4s4aP6Rior/k
         66KtM2N+b8zy+DZRlzFDrvPhhY3BBA9wmp+TCRf4gBzqRjCc0c1UhPEQQvsbNV203HQT
         bgrXdi8d7bE4ymkHyJz55ecqNs2HmHB4MG106Ds+AYYOTT5wonOWX4ZKdu1jgfyZ1Lgh
         ZzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9vcvACtESSI0at8vQhtic3fX/w7zVQNgQce3yCWhKpo=;
        b=l15gqgCNd3RhwlqtZwIcrEHLX9S+RlLwSpuUeeFuhpdzMXlYZWTayRM0k90hMMt/PJ
         QrZ3yHZrC0OMznlEdb1ReUzyBcNwvC5C0PZWEnLW8pyiEGH2WKV0Bk2j9yxYx3buKsSn
         /jalhzjCA2NXffmEu5PVTJntvPOiMzG72bie1QOezRHqZPE5BpLvtdq6GQp67833qBEH
         g6tb/atDxAK0bJNH6QaSjFN48wi4bcry8yG0h1sZeBXa5UZ7LtiBTtDwK0SIYHe8iJ26
         UH+lkpZRXNh2WMSAjeqWl5rgPzRaoRbTCKUepRRnscLBx2PV4Ivj0MYasdkbMBId4YyZ
         irfA==
X-Gm-Message-State: APjAAAX34gO+ZGi9Wk867hWysmr1PyCxejsSKYXWtILHOIPM9dflIaNb
        ddX3g7UJNWe5b3M+gak0woUi2Q1A
X-Google-Smtp-Source: APXvYqwhkISGjds9jZ1SEighM3YBdc9Q3Zd2DdhNFvfnEsFkW+xvUzYpqWTt0/4gzOgxR0JUgIbzPQ==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr12656368wmk.65.1582410910240;
        Sat, 22 Feb 2020 14:35:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm10958492wrt.57.2020.02.22.14.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:35:09 -0800 (PST)
Message-Id: <8718facbc951614f19407afa6ca8d6110507483d.1582410908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 22:35:04 +0000
Subject: [PATCH v2 1/4] get_main_worktree(): allow it to be called in the Git
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
index 5b4793caa34..7c8cd213171 100644
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

