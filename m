Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E5C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7293461AA7
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhKOLzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKOLzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 06:55:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83243C061766
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:52:28 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so10888069pjj.0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgved5jrV+zQPRtwXmRrZVJhNzEzbYmG+Szo57Cn5tA=;
        b=fjy4NyIwoVXf3qPdoilW5i7q6DHqjGTe8T5xD2w2EjDhd90Dhcl7+CSzieTT1WceoM
         zJc1/CCw0+4t46iljgnY2L40sNt57fzO9aKpkLdWw/Uu5l4buuiqMA0/9tVcSzJUsT2s
         kQuXGkZfeIkjfPrU6FVQNpbbMVLiG8AMT5S+j7D3VECdcZ6C+MCinOgLLeegvRYumEqp
         q+1sP5X+ckO5jCj7K4O2QGWoW/GVe2suAyx24TPqEQi1rzMMgxVaoMYqy3zj/ifNFChf
         TJ0FruWhcdk17AWMjZ6wqWUuVRVHW5S+Dwm7cXvb0MuJVacPZVgjxxYYijPb3aT6E79k
         5YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgved5jrV+zQPRtwXmRrZVJhNzEzbYmG+Szo57Cn5tA=;
        b=46CLU/VBcQ+H08T1MM5wR1lr4jTfymnCYuGZCCaNdfy12Lg6fHBFrFgtTMOOIkk90+
         6JKi/3kBeUNLFe63kK9dJ3bhkY2kpVdloT4OnEjChB7H5Yoo1U1kpGzW3trRUGVypJoW
         VyfmWv0Qmq3xn2oYTmr4aS4116uA26GcG63/tdYzCcOyQiZSMI9XpB/GWLi+8/657HNI
         GzAu5AHDA1uzRh9HeLCSe7ZTleoN1RFXQE90mzS43eV9mUzfC7EP7OMus8alfvQ2DJJc
         NllFxup2CfZbP9gZ+dpczGRoFyNDBZ6TgeNOlrXfB6GRQg0NYjF1W6ig4EtEf6u3msfl
         KnlQ==
X-Gm-Message-State: AOAM530HtaNUQkUYIGVFU3vHzAnWWFjn4Pc9UUwJL4LbjBdVh2vomG9L
        /ozyf6SKpjzPcOUraZtN4+6fFmUn0IJmTw==
X-Google-Smtp-Source: ABdhPJyAh8KMDG+P8I1DvtUEkCRl4Ztgnw7Hu4H/nGT8oXnjK9/VfdlzFSaqvrxvrJPxC2mGKcN7xA==
X-Received: by 2002:a17:90b:3807:: with SMTP id mq7mr45490769pjb.38.1636977147746;
        Mon, 15 Nov 2021 03:52:27 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id s2sm17543280pfg.124.2021.11.15.03.52.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 03:52:27 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 3/3] git-ls-tree.txt: description of the 'oid-only' option
Date:   Mon, 15 Nov 2021 19:51:53 +0800
Message-Id: <20211115115153.48307-4-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.9.g5fbd2fc599.dirty
In-Reply-To: <20211115115153.48307-1-dyroneteng@gmail.com>
References: <20211115115153.48307-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db02d6d79a..bc711dc00a 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
+	    [--name-only] [--name-status] [--oid-only]
+	    [--full-name] [--full-tree] [--abbrev[=<n>]]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -59,7 +60,10 @@ OPTIONS
 --name-only::
 --name-status::
 	List only filenames (instead of the "long" output), one per line.
-
+	Cannot be used with `--oid-only` together.
+--oid-only::
+	List only OIDs of the objects, one per line. Cannot be used with
+	`--name-only` or `--name-status` together.
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show the shortest prefix that is at least '<n>'
-- 
2.33.1.9.g5fbd2fc599.dirty

