Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E1DC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB483206E6
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBCYawGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCFTDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:03:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54716 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFTDW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 14:03:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id i9so3636997wml.4
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 11:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rhdaN88Y3W/CYrRdJaszbIuLLtUMZ5SvNrVRjUTOJKA=;
        b=fBCYawGdmlhqmMNNeVkJganISwP+B67iKbWcea1GPbo0fqHhyI/wo7miug9Z4ra9jg
         W1bxFoQphMuOqo3lXXRRa0Y8jYxnZ/COtQCJvRnkJmPcPX+zmVamWyxcdQIFsVel1xiu
         6rCa3nudWrLJV0vWkb/ne3nUeOMeV42vXwPIAv2fC1/Wg9ttas2Cvy/62bYuHwOgcC1z
         kmt0uhptmQSze1HC3WNUSG4dfxm2CNyIbof9XOtCN/3CxC1PKkKAAlIgBuYDgnKPE4BC
         3zeBsJAKZiTzuh1FZvLsDv0fylF09SpZv9OfuRkxXTZTfxtl9fpxtjWqimRZ38uPGnIe
         uVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rhdaN88Y3W/CYrRdJaszbIuLLtUMZ5SvNrVRjUTOJKA=;
        b=cbtWfx4ZFlY3JnUF+cZganpTXZ+823Gk2T65X3RB2AIKwuKFxUIh74eDw4rI3HF3Jo
         nfBZ5dbq+ggiyjayYjYOPzxMSTR/ueMxg3dHAh3QQAlwQgKlSRp8edT4a+xO9oSciNE8
         QANBUxYCEgiOIUOI+VC2JaET/HX9n84XFD++S51m1eZCXaMMPxV7GAmLDZLrEqCL3n1O
         9g1ZFRH64x1y0pjErMJztxVwgvDHJtPaqCNi75/vIN6oQH4WSinz4IEhIZvUN9In7n2q
         McsB+GeSOBZk6ZYyjOfXT5ujoZDgO3UqULoEmpIUFPvChQ50QBh6W4zjHsApK4syDnZD
         fnAg==
X-Gm-Message-State: ANhLgQ1bqt31+w0Kxb9fg888i4Gt5nSM0eND0SUCnkiw4MEn8MylMW/0
        SVV7uwQ5jSliElrf/nttUN7DJU/Q
X-Google-Smtp-Source: ADFU+vtkYrIx+1tp2L+qmLqwwoYMMOZOW5PqTiU0YPuKkz+598Xeh0amQvcYed+RdPk8a1xAOiYcTw==
X-Received: by 2002:a1c:9c96:: with SMTP id f144mr5174680wme.98.1583521400973;
        Fri, 06 Mar 2020 11:03:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm47831023wrm.80.2020.03.06.11.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:03:20 -0800 (PST)
Message-Id: <2eeefda3d41e6af1bc61249daf14b42050f0d0c3.1583521397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.575.git.1583521396.gitgitgadget@gmail.com>
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Mar 2020 19:03:16 +0000
Subject: [PATCH 4/4] get_superproject_working_tree(): return strbuf
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Together with the previous commits, this commit fully fixes the problem
of using shared buffer for `real_path()` in `get_superproject_working_tree()`.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/rev-parse.c |  7 ++++---
 submodule.c         | 17 ++++++++---------
 submodule.h         |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 06ca7175ac7..06056434ed1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -808,9 +808,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
-				const char *superproject = get_superproject_working_tree();
-				if (superproject)
-					puts(superproject);
+				struct strbuf superproject = STRBUF_INIT;
+				if (get_superproject_working_tree(&superproject))
+					puts(superproject.buf);
+				strbuf_release(&superproject);
 				continue;
 			}
 			if (!strcmp(arg, "--show-prefix")) {
diff --git a/submodule.c b/submodule.c
index 215c62580fc..46f6c2cbfd0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2168,14 +2168,13 @@ void absorb_git_dir_into_superproject(const char *path,
 	}
 }
 
-const char *get_superproject_working_tree(void)
+int get_superproject_working_tree(struct strbuf* buf)
 {
-	static struct strbuf realpath = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
 	const char *cwd = xgetcwd();
-	const char *ret = NULL;
+	int ret = 0;
 	const char *subpath;
 	int code;
 	ssize_t len;
@@ -2186,10 +2185,10 @@ const char *get_superproject_working_tree(void)
 		 * We might have a superproject, but it is harder
 		 * to determine.
 		 */
-		return NULL;
+		return 0;
 
 	if (!strbuf_realpath(&one_up, "../", 0))
-		return NULL;
+		return 0;
 
 	subpath = relative_path(cwd, one_up.buf, &sb);
 	strbuf_release(&one_up);
@@ -2233,8 +2232,8 @@ const char *get_superproject_working_tree(void)
 		super_wt = xstrdup(cwd);
 		super_wt[cwd_len - super_sub_len] = '\0';
 
-		strbuf_realpath(&realpath, super_wt, 1);
-		ret = realpath.buf;
+		strbuf_realpath(buf, super_wt, 1);
+		ret = 1;
 		free(super_wt);
 	}
 	strbuf_release(&sb);
@@ -2243,10 +2242,10 @@ const char *get_superproject_working_tree(void)
 
 	if (code == 128)
 		/* '../' is not a git repository */
-		return NULL;
+		return 0;
 	if (code == 0 && len == 0)
 		/* There is an unrelated git repository at '../' */
-		return NULL;
+		return 0;
 	if (code)
 		die(_("ls-tree returned unexpected return code %d"), code);
 
diff --git a/submodule.h b/submodule.h
index c81ec1a9b6c..17492e478fc 100644
--- a/submodule.h
+++ b/submodule.h
@@ -152,8 +152,8 @@ void absorb_git_dir_into_superproject(const char *path,
 /*
  * Return the absolute path of the working tree of the superproject, which this
  * project is a submodule of. If this repository is not a submodule of
- * another repository, return NULL.
+ * another repository, return 0.
  */
-const char *get_superproject_working_tree(void);
+int get_superproject_working_tree(struct strbuf* buf);
 
 #endif
-- 
gitgitgadget
