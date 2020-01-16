Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87615C33CB7
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA7520728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1H0PmAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgAPGOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33846 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbgAPGOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id w5so6359768wmi.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QOilVeCGg+qFeMFK2BB2zBxerFFKOhIwWI+wDB70K9w=;
        b=e1H0PmAdLZ6DRPVi5j5Mng+sZSkZtMWcU5AngsUZBYaul5sU9IYQm16Uc5TaKT508j
         n8N+Dj8xu2wGhaJNpI3rp19jQ6kT7VF9HW5v298QRN4z/0FeuTAnzbesuWN8hs2TBNjK
         dWHOzTj+rDDm6aCu+Z5i00/XhMzo7VWsYcc+MYwn8upVPUj0EfLNJY+vObEzAFv7f79a
         zohU7cm77OJOFueskzcyYV7UPnB4J0ecBSTZwmQ8QGGIzuAZ0T4uagHu4Pzeilp7OW/V
         uho2mHsroUF7/NA/9dJTJs5M16i08FUXyZC/OOW6qZ6E7kBZx8+N7tNAIRtqhr/vce21
         tbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QOilVeCGg+qFeMFK2BB2zBxerFFKOhIwWI+wDB70K9w=;
        b=OlcjZ54xaUzJkkwlGn6MsXBzFc8QYJ4zQmRPmVz/QSlO7ffD1vRNnm7X0CcRmifgvj
         8PI/yYgctrIs5Gw9YBQKverXorzvnO11NG6hh53shx+XMBNuBK97uUW4Q4WZZAfDuhVE
         DOEIaM5M4dtRYZC93EcO45607JaSdN02fGG4GcLKeq61ms8Lkkk9nNkNGShWqlKKJWsA
         cqrwryvzBkwITl5hDoyC3erVaLJQhcN59FCIBvEvY4JdVWZ9bpAkdI8O3Q7+kAw915I3
         s76OZfgiuQqWk5ijegVzqif3EL3YbNd9b3dkngO2yeP1t2/YGzQZ41PYo+5TZtIER+wy
         KA3g==
X-Gm-Message-State: APjAAAVV0f/5HpEsFp7wi50BUNUPE/VID+/3q5xsM42WDKTUIVGGOT71
        zx/QseG8lAqwXv96NNV9B0peaL5S
X-Google-Smtp-Source: APXvYqxSSMv3eqMPLcVfr9URNfNQPjLHraF/6YY+tgsd2ylqt+4XBX1tCG2um/jF7k/RtnR85uUgOg==
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr4339910wmc.162.1579155284628;
        Wed, 15 Jan 2020 22:14:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm28666616wrb.48.2020.01.15.22.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:44 -0800 (PST)
Message-Id: <58e6e4ffb3fd10b04a64264e9e08e84bf6107ef9.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:26 +0000
Subject: [PATCH v4 12/19] rebase: move incompatibility checks between backend
 options a bit earlier
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4b7d8fc908..55a0b2a288 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1878,6 +1878,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
+	if (options.git_am_opts.argc) {
+		/* all am options except -q are compatible only with --am */
+		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
+			if (strcmp(options.git_am_opts.argv[i], "-q"))
+				break;
+
+		if (is_interactive(&options) && i >= 0)
+			die(_("cannot combine am options with either "
+			      "interactive or merge options"));
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1908,17 +1919,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (reschedule_failed_exec >= 0)
 		options.reschedule_failed_exec = reschedule_failed_exec;
 
-	if (options.git_am_opts.argc) {
-		/* all am options except -q are compatible only with --am */
-		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
-			if (strcmp(options.git_am_opts.argv[i], "-q"))
-				break;
-
-		if (is_interactive(&options) && i >= 0)
-			die(_("cannot combine am options with either "
-			      "interactive or merge options"));
-	}
-
 	if (options.signoff) {
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
-- 
gitgitgadget

