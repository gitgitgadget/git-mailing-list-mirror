Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A78C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8E42080C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7Z5IbHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgBJOOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:14:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38123 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgBJOOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:14:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so7919064wrh.5
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a5MugNypZYrYYS+PqgDeP05BEbdNQfn2h67TbnEP+6w=;
        b=I7Z5IbHeCah/1wCnRN4IVZ4iTtRq/52CnMlnBOE4VobTi2+xue622rIxbOGrabvI8c
         7kezoAS99+d1O5oAey03nok6lFIs/ObdnJiUadCW3KCp0lkvbnPpghQzdH1wMd8wm2Oa
         73UW7RqEDhqX35L/7l5svacDMbkOcC1uEbbCnIzv9aOW9SGexesU6ocbHbV/coFTeilO
         9TDo0mEXxbziM92p1DDxUN2cwPptl0C8lW19PJX+XsHOUmvHSqyqy4Q9siVT8JTFVMU9
         KGR9dg61ptrhPyerjk0hrUWhQRshcEBK+nWDnxeIPc53RWpj61BvXIS3yeOBJnODpjAj
         aMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a5MugNypZYrYYS+PqgDeP05BEbdNQfn2h67TbnEP+6w=;
        b=gKmvKwalqn2zQuqqVtRvcpelPohGpDF4Dgti5Hq7Wi7eTC87iF1VGR54SFlyzMa9ra
         JSkPK+PKjlie7HzGLaq1nZa2vbdMVfbMSZC8H7Epu5Nkg9p3NUw1pRioGqUL3YeSa1h+
         UL3toIWq0IuUktpKCvx5yOxOWvtNN9wPRKKo66ceSNi32P76uxu/50KZShU1RaAJWDnx
         YCS8m3UBb7xjUpR0eOpe/Cn8SCjveRgNQORyhVkGyGdfoojdL4SVYlG4bvO1fh7+5qdV
         itpHJKrazkYs7HW6lNnc/knyq/LzzlflsurkRxIQHWS5wyL1mqNWKDo8oRtMlbHtU4DX
         VLfA==
X-Gm-Message-State: APjAAAVdkIFwSet47lf4eJO+S31z6o7mTFdg191jeGHlXmp4VVPQqkfz
        +oro4+Xdq3Q12sF2RaQ3WQxKZc5Q
X-Google-Smtp-Source: APXvYqwJgtI8shxIasoVRc5lFqD90mhqqdMxnARaVSRLal0A8muHeq2dKBAaQN/8Ar2t9Qm1r+03lw==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr2247489wrt.300.1581344063140;
        Mon, 10 Feb 2020 06:14:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm755007wrc.64.2020.02.10.06.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:14:22 -0800 (PST)
Message-Id: <4d6da9bc473580f56ecd1f1fa2df5c8e8bd5e936.1581344060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
References: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
        <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:14:17 +0000
Subject: [PATCH v5 2/5] create .git/refs in files-backend.c
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

This prepares for supporting the reftable format, which will want
create its own file system layout in .git

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/init-db.c    | 2 --
 refs/files-backend.c | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 944ec77fe1..45bdea0589 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -226,8 +226,6 @@ static int create_default_files(const char *template_path,
 	 * We need to create a "refs" dir in any case so that older
 	 * versions of git can tell that this is a repository.
 	 */
-	safe_create_dir(git_path("refs"), 1);
-	adjust_shared_perm(git_path("refs"));
 
 	if (refs_init_db(&err))
 		die("failed to set up refs db: %s", err.buf);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ea66a28b6..1d362e99fb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3158,9 +3158,15 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
+	files_ref_path(refs, &sb, "refs");
+	safe_create_dir(sb.buf, 1);
+	/* adjust permissions even if directory already exists. */
+	adjust_shared_perm(sb.buf);
+
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
+	strbuf_reset(&sb);
 	files_ref_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
 
-- 
gitgitgadget

