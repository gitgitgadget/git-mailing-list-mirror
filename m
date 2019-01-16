Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867051F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbfAPNhX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:37:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44154 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733003AbfAPNhW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:37:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so5393656edd.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oEVXF66/5PducDKWWXLy4Ui7R7XXIuAig4cs6P4eRLI=;
        b=diYWgf8Bht9Zt/1UMG4dEoBJVM1PKx223V8y9HCxyvE1poElapa/g1w8I+/7EdXGcJ
         t3INONLKGOBRdP5FH9sn/fYBtPj0ca3Hah4KDyBMy2uflEY4cuUlz6rT0vruSXgF3Vc/
         E4TBNtz8wVgp6nmwK2wr/6TindpiEsRDUy/0JkIWYX3jT0UHTtfv98l9XUEklYuRWMLQ
         qR72Sf4xx0pEMqmCiQ64pCq6YL4oN6FznbkIdgGC9ZE7hMreZ6OiKw0KSE0RIPeUuZo3
         vaFRLqSTrxaoHmLx5sxQx+kHkrP5hTzv0M/2ciA6gmNBK5XEPvHZS39+bcFN/GUfI4EY
         oJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oEVXF66/5PducDKWWXLy4Ui7R7XXIuAig4cs6P4eRLI=;
        b=ETNzKQ6Jg3uCuqyjVvOO03XASy5sQPuwS5f9u+sWrkL5A2KQtoRxc2AFyH9hLxAGQD
         7PL7QM2Z7PtgluY9cYv1MdiYNl9vncEu1WFkQZotAbJbDPw0E2d3cwqBhp+7ozk95LUC
         6xgmMUeYl4CVer2pSau/hohDWTKPaabiscW7hCCRhYeZWG5NqnOD6jzsjmhSaykyg9bg
         ESp3ZxRFNmtbiHH1NwF1xIqHktwEpyuA3niT+fcQEXs25qYvKs7eus2twsja5JtlSUZJ
         ItFAulA1yj4p3RBoAk7U5xIE0hjhdReI7lsf+9mVwYRuE8rFz3kBuO+9zbvFSR7LTUas
         yopg==
X-Gm-Message-State: AJcUukckQut837kxtyZP616jVEHYn8GLgxco60dRkWS3VSp3hvX3tlEp
        qVqrrb85vNQQNlj02qa1rXsUPOjF
X-Google-Smtp-Source: ALg8bN6TsW4u6qdWAYxCzb9YI5Vto04LZfcdpfRhw2dAtpOF5Y9e4FDtVVqyDaYp2vkZOCEbxiztHw==
X-Received: by 2002:a50:a622:: with SMTP id d31mr7882692edc.228.1547645840719;
        Wed, 16 Jan 2019 05:37:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9sm5636009edl.3.2019.01.16.05.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:37:20 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:37:20 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:37:18 GMT
Message-Id: <598de6652cdb19b9772f322f17600c3845f208cc.1547645839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.109.git.gitgitgadget@gmail.com>
References: <pull.109.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t6042: work around speed optimization on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git determines whether a file has changed, it looks at the mtime,
at the file size, and to detect changes even if the mtime is the same
(on Windows, the mtime granularity is 100ns, read: if two files are
written within the same 100ns time slot, they have the same mtime) and
even if the file size is the same, Git also looks at the inode/device
numbers.

This design obviously comes from a Linux background, where `lstat()`
calls were designed to be cheap.

On Windows, there is no `lstat()`. It has to be emulated. And while
obtaining the mtime and the file size is not all that expensive (you can
get both with a single `GetFileAttributesW()` call), obtaining the
equivalent of the inode and device numbers is very expensive (it
requires a call to `GetFileInformationByHandle()`, which in turn
requires a file handle, which is *a lot* more expensive than one might
imagine).

As it is very uncommon for developers to modify files within 100ns time
slots, Git for Windows chooses not to fill inode/device numbers
properly, but simply sets them to 0.

However, in t6042 the files file_v1 and file_v2 are typically written
within the same 100ns time slot, and they do not differ in file size. So
the minor modification is not picked up.

Let's work around this issue by avoiding the `git mv` calls in the
'mod6-setup: chains of rename/rename(1to2) and rename/rename(2to1)' test
case. The target files are overwritten anyway, so it is not like we
really rename those files. This fixes the issue because `git add` will
now add the files as new files (as opposed to existing, just renamed
files).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6042-merge-rename-corner-cases.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 7cc34e7579..09dfa8bd92 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -1175,7 +1175,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
 
 		# Handle the left side
 		git checkout L &&
-		git mv one three &&
+		git rm one two &&
 		mv -f file_v2 three &&
 		mv -f file_v5 two &&
 		git add two three &&
@@ -1183,7 +1183,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
 
 		# Handle the right side
 		git checkout R &&
-		git mv two three &&
+		git rm one two &&
 		mv -f file_v3 one &&
 		mv -f file_v6 three &&
 		git add one three &&
-- 
gitgitgadget
