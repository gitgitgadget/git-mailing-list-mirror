Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EB6C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 04:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjAMEmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAMEl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 23:41:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0313AB3E
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:41:58 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso12568717wmb.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94ZdZOC93ccYfr+u+i7kJoVlJI42pQWXTJUpPUa9cvA=;
        b=kEo+7C+7XAJ/tsJ1QXDUufG/czW8eS5Mf/gWr5bN7kqtYIEGJIGcO5bQrrd2m/dxqc
         bfQeN+aSigN8JBpwTP3zzJGv1tHu3BOWOJTOCxkem+YNl4jg1YHsKZWqU1iYp/y+t98g
         M30OqENCH4o79oMoSr4SzVnRYo4kX6dCSLYZPuIf2FCWm/sHJjI61VuLsmJbv8DZ2Alu
         rCKyM2Iue9IZcMz6YHl8H1mcrHQIH7t5L0BKvfpfcUhdWvcXbZq410JkbYcCAuo0iiF5
         ZLQXCWfeQ8iFqU7xS53K87p6NIYFMAwRtVcxhesIGc4V1m6AE6o8eLG6DbtI0uKE+d4W
         ec4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94ZdZOC93ccYfr+u+i7kJoVlJI42pQWXTJUpPUa9cvA=;
        b=RZ3MekPDcuvOO2s8yShn0PCxAz1dVF7FOV26kNty/DaxryyYSCCOlVFhGSLyCMOGHL
         02LST0w1uh3X2VYZY0yUbnrmVr6Rs87XBGwXdGMGYqurL4X6WstMuN+BoS640kNKuIxC
         0kYn1BDdUUOMzY5duK23+qqDzoGm++uYBdvhs1FbXuwwVf+YHi9u2xwPEh2Gz/orBe4c
         COhNFNyDxJYeeWZk+dG6levY4dVMEY8YlhGXO0y62lGhUYcLDo6ZDz6sB7uKX8maIn4f
         fijB8xSUQEkR1MHjQRoLtW6gEfFAgESsEIWZD4SnToX4KKqHSwFfiyH4iTbmTlUswZRy
         +nog==
X-Gm-Message-State: AFqh2kpdXAm4Lq2IDsvKnzBDWv8asuAd7H2VAYB8FYShmpySGT1tXRpP
        wDDMdf1CHW7zY8d5ser0u894JMX4r0o=
X-Google-Smtp-Source: AMrXdXvQ1VseEjRn1dCqjo6QWOLz4tV+Z3QHqXCmZd909uQqcf4u8gvPrkM/UWOm9jjNzB0gvtgyeQ==
X-Received: by 2002:a05:600c:5006:b0:3d2:3eda:dd1 with SMTP id n6-20020a05600c500600b003d23eda0dd1mr57623890wmr.17.1673584916389;
        Thu, 12 Jan 2023 20:41:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003d9fa355387sm11417410wmo.27.2023.01.12.20.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:41:56 -0800 (PST)
Message-Id: <6bd92c51550c4960ee4de272d3b19451f1e337cc.1673584914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 04:41:51 +0000
Subject: [PATCH 1/4] ls-files: add missing documentation for --resolve-undo
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

ls-files' --resolve-undo option has existed ever since 9d9a2f4aba
("resolve-undo: basic tests", 2009-12-25), but was never documented.
However, the option has been referred to in the ls-files manual itself
ever since ce74de931d ("ls-files: introduce "--format" option",
2022-07-23), making its omission a bit jarring.  Document this option.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-ls-files.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 440043cdb8e..cb071583f8b 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git ls-files' [-z] [-t] [-v] [-f]
 		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--ignored]
 		[-s|--stage] [-u|--unmerged] [-k|--killed] [-m|--modified]
+		[--resolve-undo]
 		[--directory [--no-empty-directory]] [--eol]
 		[--deduplicate]
 		[-x <pattern>|--exclude=<pattern>]
@@ -77,6 +78,13 @@ OPTIONS
 	to file/directory conflicts for checkout-index to
 	succeed.
 
+--resolve-undo::
+	Show files having resolve-undo information in the index
+	together with their resolve-undo information.  (resolve-undo
+	information is what is used to implement "git checkout -m
+	$PATH", i.e. to recreate merge conflicts that were
+	accidentally resolved)
+
 -z::
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT below for more information.
@@ -136,6 +144,7 @@ a space) at the start of each line:
 	C::	modified/changed
 	K::	to be killed
 	?::	other
+	U::     resolve-undo
 --
 
 -v::
-- 
gitgitgadget

