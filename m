Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320CDC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06ED120716
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK/jZlDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgA0OW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:22:29 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52894 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0OW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 09:22:29 -0500
Received: by mail-wm1-f54.google.com with SMTP id p9so6977186wmc.2
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 06:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TS3Ah3CuiEXq+4m5EAu3GCHE+T2RdzcLIMPLUJRoWRI=;
        b=WK/jZlDh62jDF7puCQbEv4J3pHbEyx1qWpDRJ3L04PkryyaHuFhGl+ehqVhHe7UeL8
         MRvCtxmIxKYyv5TJiBoz0lnz0/WawvJuWW+vavfhHg//yNr2TGW1NHi+KpoBcs2X0hYB
         P/FIV//PZ4MZ+Y9fVxAACOQpr0cLmoswe4tv+vU12+dqJx2K5BXgZB7ltqsNwrPsrwZN
         c2BJ/vNbH9XorD2SAsKzIXDmEBH8m+kQ6EFbc0NYzVoYqbK14rcpJT2GcBzBe3p78xiF
         bQVXahYdVxWPyPBt9uL3tZnYoAFSdtC1/mxgesB+NWgG5RO79qoKysta0u1MR6DX+8fD
         Lkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TS3Ah3CuiEXq+4m5EAu3GCHE+T2RdzcLIMPLUJRoWRI=;
        b=qRbg7Rq459A2hd44RoqEe80fKr/pii8Xvyfbm1kmO72ZzVAZwX1QlfF/RA4zI5JEoc
         w57BmWhWSPIs42QM+xhzoO5Vie6emgda808WNTpoWmZliMwNe7M4xwgLN3VmoVHNnltU
         LrpAnRZutmKTzdTLpYT8oSYuV0EqpUdwKcis9LiFBFtB0f9FrIktKPyig1l89VXb1bWt
         Huwi8lsR1pMMvtJlqgn0cnf+oMNMz7hBtYwQq+Dl8am1EaPpn73P8Fq6d05VjUGBL7Ls
         96jsoBzVbZnlI+Nghu7T/NAOrifh16gKTZ27g461iupvA52QvK9tz5q9zAnFmzpq1t5C
         YUcw==
X-Gm-Message-State: APjAAAURiYwcUBgDnLh4OdWiVm8SkobAdyWOxbTBg2wl8AMhjtl+0uLo
        imFtXvRC1Gk1TGQcVfKYndMU/O+Q
X-Google-Smtp-Source: APXvYqyvnoj8x8LWboJjMIAqEckGmrIKikaRE0gdFc8w2W+aRdRFUnRBrcXRHytXNQk4aj0zVJWsDg==
X-Received: by 2002:a1c:6a15:: with SMTP id f21mr12425864wmc.126.1580134947484;
        Mon, 27 Jan 2020 06:22:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm18544319wmj.33.2020.01.27.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:22:27 -0800 (PST)
Message-Id: <174b98f6dbdd35e96a6f10d34b9e44440922aea8.1580134944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 14:22:20 +0000
Subject: [PATCH v2 1/5] setup.c: enable repo detection for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

* only check R_OK for .git/refs.

  In the reftable format, tables are stored under $GITDIR/reftable/ and
  the list of tables is managed in a file $GITDIR/refs. Generally, this
  file does not have the +x bit set

* allow missing HEAD if there is a reftable/

Change-Id: I5d22317a15a84c8529aa503ae357a4afba247fe9
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 setup.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index e2a479a64f..e7c7dca701 100644
--- a/setup.c
+++ b/setup.c
@@ -304,22 +304,23 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
  *  - either an objects/ directory _or_ the proper
  *    GIT_OBJECT_DIRECTORY environment variable
  *  - a refs/ directory
- *  - either a HEAD symlink or a HEAD file that is formatted as
- *    a proper "ref:", or a regular file HEAD that has a properly
- *    formatted sha1 object name.
+ *  - a reftable/ director or, either a HEAD ref.
+ *    The HEAD ref should be a HEAD symlink or a HEAD file that is formatted as
+ *    a proper "ref:", or a regular file HEAD that has a properly formatted sha1
+ *    object name.
  */
 int is_git_directory(const char *suspect)
 {
 	struct strbuf path = STRBUF_INIT;
 	int ret = 0;
+        int have_head = 0;
 	size_t len;
 
 	/* Check worktree-related signatures */
 	strbuf_addstr(&path, suspect);
 	strbuf_complete(&path, '/');
 	strbuf_addstr(&path, "HEAD");
-	if (validate_headref(path.buf))
-		goto done;
+	have_head = !validate_headref(path.buf);
 
 	strbuf_reset(&path);
 	get_common_dir(&path, suspect);
@@ -339,9 +340,16 @@ int is_git_directory(const char *suspect)
 
 	strbuf_setlen(&path, len);
 	strbuf_addstr(&path, "/refs");
-	if (access(path.buf, X_OK))
+	if (access(path.buf, R_OK))
 		goto done;
 
+        if (!have_head) {
+                strbuf_setlen(&path, len);
+                strbuf_addstr(&path, "/reftable");
+                if (access(path.buf, X_OK))
+                        goto done;
+        }
+
 	ret = 1;
 done:
 	strbuf_release(&path);
-- 
gitgitgadget

