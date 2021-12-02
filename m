Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F57C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348225AbhLBRkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376360AbhLBRkE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:40:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5346EC06175C
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 09:36:40 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so317152wrr.8
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 09:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YPuHjyUe58NKnqxWJN/lGzTi0JbU5A1GnQrgggUF/5M=;
        b=EVpZ6CAd/pAwKvegRbJ1+P5/y9M7sqTHI2lxFhSJZcdW5t9QT+AAvMlXJxSezgpox2
         7r6G86Nbv//gY9C8D0nembWsJRYex5IEMRb92qt273lP/DXWdmUMbzMZFzsepWpacQLX
         WoY74wHBRh2BXxoCZ3wZv55mMC34Krfzs2CPHB4iewSvAxn77f0dVJHkNA6YH+ikZ+io
         TY6SUZQLLHqSwpQGhAaylSyZxgM9cdloqYm8FjlxbEVKUxY/+N3THOeDIqm7iSUFYEep
         jtYPRMwMzb/PzCXjMNcr139HRUSKd4uZvXlAPDOOw4ZV7ORCjWbs1xb8HOs2wo1RsZFI
         CQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YPuHjyUe58NKnqxWJN/lGzTi0JbU5A1GnQrgggUF/5M=;
        b=ytAbfYvUgKsq7jbstDvgCT/Qpe9QJ8/TbDBrK6ifr95IBSGcLCbPnr8d0phz4wNMa2
         tjXRqE/XmxbQnMQL/n/bHk+NIlKZqzXtneQvFmkAHWLVaEP0+fPqdQ457G0PzJzQUQ5i
         lWZhpv1JCMFkBQd1csgleVaEgEOp/dq/HcRDa6T6mPeT7rmhVvV3n7Ay+NHcnEho0/BP
         fTQzSsOG61NAQcfZtcdf5n06hEBiVPUm0bqjLiGwRv8t0r5leN+2LgKgOPiUmFHT78vw
         R0HdJo1fpJCEAHVemH8jL3Sl7PPExiSLathddu8260Myv/+z4VGRBziwrbzoV4/hLRcv
         chfA==
X-Gm-Message-State: AOAM532DYM7Jo4oWJq1XnoxQ/dcHnz9A5SohNH8+RsR2258jBZ7OQ8Uw
        Gv9a33DVqoa+r1sRm5JwCIPCkU1YuoE=
X-Google-Smtp-Source: ABdhPJxFOxB/TcmSlYY0gq/dLdiAzuQ8HPa5ot9/E49RGKmdq96pEqYXuChF+FyU4uMf/dy2J9SQ4w==
X-Received: by 2002:adf:db04:: with SMTP id s4mr15480261wri.467.1638466598820;
        Thu, 02 Dec 2021 09:36:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s63sm327712wme.22.2021.12.02.09.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:36:38 -0800 (PST)
Message-Id: <751f713a0257126f45d9dc8f86bf38cfa2f923e6.1638466594.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
References: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 17:36:33 +0000
Subject: [PATCH v3 5/5] refs/debug: trim trailing LF from reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

On iteration, the reflog message is always terminated by a newline. Trim it to
avoid clobbering the console with is this extra newline.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/debug.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 8667c640237..2defaa9c52e 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -284,6 +284,7 @@ static int debug_print_reflog_ent(struct object_id *old_oid,
 	int ret;
 	char o[GIT_MAX_HEXSZ + 1] = "null";
 	char n[GIT_MAX_HEXSZ + 1] = "null";
+	char *msgend = strchrnul(msg, '\n');
 	if (old_oid)
 		oid_to_hex_r(o, old_oid);
 	if (new_oid)
@@ -291,8 +292,10 @@ static int debug_print_reflog_ent(struct object_id *old_oid,
 
 	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
 		      dbg->cb_data);
-	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
-		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
+	trace_printf_key(&trace_refs,
+			 "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%.*s\"\n",
+			 dbg->refname, ret, o, n, committer,
+			 (long int)timestamp, (int)(msgend - msg), msg);
 	return ret;
 }
 
-- 
gitgitgadget
