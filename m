Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E7C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B3320728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfaWVnP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgAPGOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45396 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAPGOi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so17841367wrj.12
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HfRdFfJPSLJjAri6z3B326PtqlDMwDmwzwOatgUkKHc=;
        b=mfaWVnP0Hj7/jt0NRNYm4eUeWAZaobaUwjbU3oZg1WkgiARCGRPHQYUANhY3Lhg5oz
         USF7KIll7lszGrVy+tdsv7diHVLIQeX8joeXmtuznI4J+AMTxQmLe/nw7JPlCB75Hxpf
         8v5+uZtvN57fAJfCpnXneuUChgPt70fVbEyOxQucllZ7umCiDzPunG8G0AIWD0nFgRrR
         BBV29Y60pt17zNHZie2JpRG2jLyeHNOlBeROcht56ZqC+kAWllaKvhaADFj6irkJs5UT
         bU585mhSWnd+64GOXpBsDg50Ef155XjYXX8RNdGIpvm/CBzfz6BNVpOD3Xoy5tAro4Ya
         EvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HfRdFfJPSLJjAri6z3B326PtqlDMwDmwzwOatgUkKHc=;
        b=KVF1wvvEcbxknmg2BboYmk3S3THVU0OiBid4Ioou4gQsJ+0Eum9Ls2W3jxHBXhJcrn
         ttrr9QrVf6F2vMaPPYUiPzvgRH48CstTwmBVDqrfQaEpOGQ+1ZjPWZLhi6sW5U9ZqY7s
         ljotgbKBWVsUfxwq/rJkr0AT0TRoEm8dHCeKal2MzL8beJ2EQtq60qKJfFnRqPvYkpzl
         bkAd6NwtdLLdqsbMl7PUuwk7AJmSQTRb2KomCuX214+qUJOdrQGOQB2OWdrSkhdfQ2xI
         1xUkBCti6/HtAyIh1hvox2Fh0WSuC/gBvqC+QucRfCTJfr81ZNVbfzWmJSK4Mx58gEV7
         kBLA==
X-Gm-Message-State: APjAAAWyR7xxEJr02hDYfUiKfkR24an0g2PZSY1NDX08hDEwLiwzsONo
        vEqzLPzF3MjqkXsEfczkBqH5liPf
X-Google-Smtp-Source: APXvYqwLGYXJneIui1PfX2VfKdzpExfbnp3b4drwD17St8iPOkKeyvmnO1u4XsZL1mVp2D5R05bvIQ==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr1238092wrx.87.1579155276195;
        Wed, 15 Jan 2020 22:14:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm3136821wmi.19.2020.01.15.22.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:35 -0800 (PST)
Message-Id: <3ea48d53940cb7e1a82a8a6eb819497c0448af6a.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:15 +0000
Subject: [PATCH v4 01/19] git-rebase.txt: update description of
 --allow-empty-message
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

Commit b00bf1c9a8dd ("git-rebase: make --allow-empty-message the
default", 2018-06-27) made --allow-empty-message the default and thus
turned --allow-empty-message into a no-op but did not update the
documentation to reflect this.  Update the documentation now, and hide
the option from the normal -h output since it is not useful.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt |  7 ++++---
 builtin/rebase.c             | 12 +++++++-----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0c4f038dd6..c83be7ffc2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -265,9 +265,10 @@ See also INCOMPATIBLE OPTIONS below.
 See also INCOMPATIBLE OPTIONS below.
 
 --allow-empty-message::
-	By default, rebasing commits with an empty message will fail.
-	This option overrides that behavior, allowing commits with empty
-	messages to be rebased.
+	No-op.  Rebasing commits with an empty message used to fail
+	and this option would override that behavior, allowing commits
+	with empty messages to be rebased.  Now commits with an empty
+	message do not cause rebasing to halt.
 +
 See also INCOMPATIBLE OPTIONS below.
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8081741f8a..faa4e0d406 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -453,8 +453,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
 			   REBASE_FORCE),
 		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
-		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
-			 N_("allow commits with empty messages")),
+		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
+			   N_("allow commits with empty messages"),
+			   PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &opts.rebase_cousins,
 			 N_("keep original branch points of cousins")),
@@ -1495,9 +1496,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
-		OPT_BOOL(0, "allow-empty-message",
-			 &options.allow_empty_message,
-			 N_("allow rebasing commits with empty messages")),
+		OPT_BOOL_F(0, "allow-empty-message",
+			   &options.allow_empty_message,
+			   N_("allow rebasing commits with empty messages"),
+			   PARSE_OPT_HIDDEN),
 		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-- 
gitgitgadget

