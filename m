Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE762C34034
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971DE21D7D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT15mq+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgBRInp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:43:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51632 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRInp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 03:43:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so1861245wmi.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 00:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zvV6ikoarnwTEEvMB5pK+kHoMHc6Mf8HUaG+5pG6Nus=;
        b=PT15mq+FTp8Gbl2kga77k+E12AyejLfMoOogl3oVFqmz+ibQ9SgU8/wLFieQsM8+IF
         nIxQ+GAvwGWACugI9Ja1WnX1SwZ9hkmUDyulilUORWzy22vNIG9dsPFbQBK7E2Pa6MBn
         MPacisMYjrI4qrAi+uPMOLhspiI/rYvHS1jgGpb3ZUmR7whlh7e1jt45X/lzLCew5quJ
         6BUCH6vIqhAjIHvsAz33Hq2XbMB/SwcLgfjcPMu87OQYmfkxOBx8oSrNsqKoO0w+i5PR
         NVZG+w/RMgBL+xmlzsvsAfSlh7vyOytZ96I39Tf6mAJiVdIYbtTY9WxCS0ruAW9w4+go
         WibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zvV6ikoarnwTEEvMB5pK+kHoMHc6Mf8HUaG+5pG6Nus=;
        b=kq3j1B5cy4EGtIzXRK4ka94i2va3wXPAYcpYYFtKLNy6KXF1Dk7DOyDAKkW8XCUNPd
         cicbKBkjBzyWzO3Ct1BUxQLHs75oLaeJA1mrmdEFRuPKE4hg38wE5gnOwRB9awoBHZu/
         irOQubRNMao6oVFToCe7OMpfajn5WWtd/ZRCrfVb+cMIQmnXWUbCaRe4qMRgLSTdTrv1
         52XSR1MgowgAcgTHxO8U2SQgW1r3PXrsQuAUGRaZbRH3w9Vus4GUEvSg8/pEH1e3PtOk
         9gPxUyYfQXj/ZRqfhIBoq+2B9jCHXmxT1NfkEI463SwhFpmTIluL83dj5EjprEuZZ5Z4
         D2lg==
X-Gm-Message-State: APjAAAUs5nJGUEBqJfE8/URrqM4WMYNsmZujy2CISAi6j53iaFttvOFo
        Gkeo9j/BpdE7s3v5zkJCdUC9lBWK
X-Google-Smtp-Source: APXvYqy2j2btZhOYFiKYWsHfj8Yl9QfHzMS+6bmCExi8fOGgzHTrFcTz1BpaFgKkOlh71sHHPwheLg==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr1709443wme.125.1582015423386;
        Tue, 18 Feb 2020 00:43:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm4866196wro.66.2020.02.18.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 00:43:43 -0800 (PST)
Message-Id: <c25b6c601dc69566dab4a393a000bf7bed64181c.1582015420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 08:43:37 +0000
Subject: [PATCH v6 2/5] create .git/refs in files-backend.c
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
index 944ec77fe10..45bdea05890 100644
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
index 561c33ac8a9..ab7899a9c77 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3157,9 +3157,15 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
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

