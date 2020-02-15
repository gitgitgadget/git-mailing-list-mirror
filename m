Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E96C76195
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28EE20718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLZIi2Lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBOVg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:36:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53296 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBOVgy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so13526272wmh.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jBHnPqPC6gfu7bSIASbl8Avw7/lF+yCz5kqVQfLGBWk=;
        b=RLZIi2LxHxvdZsPwZcmhQE7ZTmN3hgBKpbuw0137Q/JmVetUIArfCsrqotDur/JD3X
         h4Oh0b4PpxubA/sztVG5OnhRsV7clvDkSGlEUbzqWNgAfEFYACVi/BbDbw6YaPexDfq9
         hgbncnyiH0GsZxBwYlgb/jObVYmbiAc9xfnxVIFRbe+6jzXy0prr/xurYXAIbsHEoA2t
         mNzRWq0cpa3Fds0lZCWmIrjOV+G+astjzlA1l9YSVC8LuYv5fr3bWxG50HFZH+Y7fX1A
         81a2P9pYMSF3kqC+x8jSlV52VvmC9vlkcSUbyGURO9ZnDNVQqt391+1aKHOLyiNru6VW
         bRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jBHnPqPC6gfu7bSIASbl8Avw7/lF+yCz5kqVQfLGBWk=;
        b=lJUu9l/3Z4D/+Wsox5LCHZux+CIt53jY1tyhWzxkEeynst3XIXyFPLru3siyfGTPge
         vceyHdBoOzvyupPvKYFRswzdfH0ay0dK2fljW6lgbLBQ7bVkJxtb3NoVm66qvEgbJDs9
         aOrHFuv2MMPTr8XjtSKk3FML2grgC0nyYk/YrRDzJfijkiEq2798TeoyP1hHz1Wej804
         B5Kym1J0sUSnlCu7d50unmglY+gbRnwR/F3srjoGYe5ID8PIt3G4FdbsAaOrzzL7+KjR
         iFnXkhRy4ZaCMkEP83fjArBQzVdjej1uBqX0HTpxf8Hc+mH8dfbkUUkOK+VVTuUegDK1
         PuRQ==
X-Gm-Message-State: APjAAAXCx5sm9cdVcXJSKVEt/aQ7o59WF7JgivAwOKN1x1PF6pwmTylL
        6XuIiR/fKPdW5VjWXM1b6sIq8EJw
X-Google-Smtp-Source: APXvYqxfvVR7bLo6US5X3GkSs5TaWPpecKZo2x69hx/yh8UKDH25sVDG0gsfAZc5qK0XS439Ew0TCw==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr13030800wmj.155.1581802612320;
        Sat, 15 Feb 2020 13:36:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm13121557wrt.1.2020.02.15.13.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:51 -0800 (PST)
Message-Id: <0c921919dcee49e90825e1f42177ce58f8b3eb5f.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:33 +0000
Subject: [PATCH v5 12/20] rebase: move incompatibility checks between backend
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
index 6e9a2fedc7f..a2f05f783d8 100644
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

