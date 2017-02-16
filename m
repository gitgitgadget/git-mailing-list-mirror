Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB3C20136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754970AbdBPLti (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:38 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32951 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754779AbdBPLtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:33 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so1484043pfg.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AzQFcTVFdYCX2UT1L2E56lsc7qnCMJLPWoUf6q2gXA=;
        b=hrJUeRIvdgplisEiIDjoaO3BO5M21geBPUNNLyvF8u4jpN/nqij9ZgqYStn01SJ4l9
         AxnQnzzdsgON2OY898881t5hG0gG0/9dvoVAR3b0fboxM2rZxbCgktdit1jH0pcaY+/C
         lcjlRb4EimfOuWIikt+13l2yHbaiwMyea8YgOrsb2EV7rxbGxgVjh50HbE4q99zFqkpX
         Qk97ukvXA2FHdbrZOeEkwlSIs/4+xWVZu7siWvvu+FATCCyC2QAwO3PcHp8NGcep6yJ7
         z10rjFAkBMFRQN5sYfqkNon7Bgz0yUSxtfxD2bD02GtFjiko6a1FvwZbGhi62bApXpU/
         S2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AzQFcTVFdYCX2UT1L2E56lsc7qnCMJLPWoUf6q2gXA=;
        b=CAqnakAwGfGOBhWxsE4MzgqBzGnlWJNzLx12mxrxiBikTPWEk91Lc6Oq1mnX9H9Zpg
         6Xkyt5af8zUHS+xNOpHLswm+yiNC/PsrOiCzLhd19tvuc7km2UmT/sWboja2KHrtNIvm
         z86uKGhmJNRAuwSa0fwhBxXNKeNnlz2x6EeC1fXqVzlRzFN0veXIropSnoNEGchqMdvQ
         vxULmVoi87viODs7N/smvdCP6rGoUf23AcWw/ST/rvH+UjdaA3CQgQm39VIUdSMkqYAc
         kHneUmBprCnIknbBU1kNDADhIzacoK7FQJbZ1MpXXTV/sIOSZ14wNOyFEkzZC0M/bIHX
         ut1Q==
X-Gm-Message-State: AMke39nXDwDuP8vAiaBgCDEF449xlv+PS2BPWep0cw7YmXB6DEhtw/6k7jMXYfaKTw/34w==
X-Received: by 10.84.175.74 with SMTP id s68mr2575691plb.155.1487245772611;
        Thu, 16 Feb 2017 03:49:32 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id g64sm13319084pfc.57.2017.02.16.03.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/16] files-backend: remove the use of git_path()
Date:   Thu, 16 Feb 2017 18:48:09 +0700
Message-Id: <20170216114818.6080-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given $GIT_DIR and $GIT_COMMON_DIR, files-backend is now in charge of
deciding what goes where. The end goal is to pass $GIT_DIR only. A
refs "view" of a linked worktree is a logical ref store that combines
two files backends together.

(*) Not entirely true since strbuf_git_path_submodule() still does path
translation underneath. But that's for another patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 24f5bf7f1..74e31d041 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -924,6 +924,9 @@ struct files_ref_store {
 	 */
 	const char *submodule;
 
+	struct strbuf gitdir;
+	struct strbuf gitcommondir;
+
 	struct ref_entry *loose;
 	struct packed_ref_cache *packed;
 };
@@ -937,6 +940,7 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 {
 	struct strbuf tmp = STRBUF_INIT;
 	va_list vap;
+	const char *ref;
 
 	va_start(vap, fmt);
 	strbuf_vaddf(&tmp, fmt, vap);
@@ -944,8 +948,12 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 	if (refs->submodule)
 		strbuf_git_path_submodule(sb, refs->submodule,
 					  "%s", tmp.buf);
+	else if (is_per_worktree_ref(tmp.buf) ||
+		 (skip_prefix(tmp.buf, "logs/", &ref) &&
+		  is_per_worktree_ref(ref)))
+		strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf);
 	else
-		strbuf_git_path(sb, "%s", tmp.buf);
+		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
 	strbuf_release(&tmp);
 }
 
@@ -1004,7 +1012,15 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 
 	base_ref_store_init(ref_store, &refs_be_files);
 
-	refs->submodule = xstrdup_or_null(submodule);
+	strbuf_init(&refs->gitdir, 0);
+	strbuf_init(&refs->gitcommondir, 0);
+
+	if (submodule) {
+		refs->submodule = xstrdup(submodule);
+	} else {
+		strbuf_addstr(&refs->gitdir, get_git_dir());
+		strbuf_addstr(&refs->gitcommondir, get_git_common_dir());
+	}
 
 	return ref_store;
 }
-- 
2.11.0.157.gd943d85

