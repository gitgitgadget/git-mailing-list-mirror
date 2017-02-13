Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3191FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbdBMPVD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:21:03 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33767 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbdBMPU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:20:59 -0500
Received: by mail-oi0-f65.google.com with SMTP id j15so7827123oih.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diG7+F+TYBUY1w9x1vwv0AKzEpJ8OVCJ8oNObjnYnsc=;
        b=PZTF6dZqklTzJdRo5HZorY0fdqhMuRUopKVagHCduxA4u8OdRPu3/0pXtL4BxIFcyV
         1uQQ2szn8IfcyQfkZvUFXaSMsUbMRO5IHaoIpMRiEV8mcz6e5wx/6htHWAv2KYJyHfln
         KW1FAy+oVLW98ZepKcNw8zX7iX/9XVVS39Kj2Ez6MunI3bvXOZMqVIfhGuXqUbD26pL4
         FKphYp/3ntQhSS0/dxbDffCrXHVOMu6zJCUEmxQgJAamWPY+XmcYgAGd4PWCBQFXh6zR
         kc7gWdqB6dgt73oB9wn2nP0cpgLJfO42HDusu6mu6G+Q3OL91FI6WIflPID4PXbEt9PC
         MyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diG7+F+TYBUY1w9x1vwv0AKzEpJ8OVCJ8oNObjnYnsc=;
        b=Pb/NAdkqNqU1crMwaSzeI4MFj3NNQ4KOp0yKXf8y9/AOXN8Gc5K9huqhAXXO2EwxfT
         VbOXmkXUlUhrTVjMLEkvT1YjrCSozUxAR4z/Tsbz32bMo6xI8/qHWX8hwL6ySsCVURlq
         IgsryMCrmS4RuV4mUBUVID+ojjTKzwZCbultqSl6ZQhwIruuFPxztjxTkQZwpPjeIisC
         c9iljDYYUVbRBvs1B19N1K0o+ieyHcHmZ9UX/0QAQ0vavk6yjotarM6oWOfXJFq2VkQ0
         ta15xqtixYrz+JZ+wk/hr/3TV2ux7XkX/nQ9OJ59fUKuT7WNUDMpLwWstXTCyIazhTlO
         2fug==
X-Gm-Message-State: AMke39mr/7/e4uMqpr959Kb68LZDrajKnAK7EZUYV7zg/gMgnpuiFU8PL8SPetqgXBCNlw==
X-Received: by 10.84.137.165 with SMTP id 34mr30959518pln.24.1486999258286;
        Mon, 13 Feb 2017 07:20:58 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id z77sm21702549pfk.47.2017.02.13.07.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:20:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:20:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/11] files-backend: remove the use of git_path()
Date:   Mon, 13 Feb 2017 22:20:07 +0700
Message-Id: <20170213152011.12050-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
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
index c69e4fe84..50eb9edb6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -927,6 +927,9 @@ struct files_ref_store {
 	 */
 	const char *submodule;
 
+	struct strbuf gitdir;
+	struct strbuf gitcommondir;
+
 	struct ref_entry *loose;
 	struct packed_ref_cache *packed;
 };
@@ -939,6 +942,7 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 {
 	struct strbuf tmp = STRBUF_INIT;
 	va_list vap;
+	const char *ref;
 
 	va_start(vap, fmt);
 	strbuf_vaddf(&tmp, fmt, vap);
@@ -946,8 +950,12 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
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
 
@@ -1006,7 +1014,15 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 
 	base_ref_store_init(ref_store, &refs_be_files);
 
-	refs->submodule = xstrdup_or_null(submodule);
+	strbuf_init(&refs->gitdir, 0);
+	strbuf_init(&refs->gitcommondir, 0);
+
+	if (submodule) {
+		refs->submodule = xstrdup_or_null(submodule);
+	} else {
+		strbuf_addstr(&refs->gitdir, get_git_dir());
+		strbuf_addstr(&refs->gitcommondir, get_git_common_dir());
+	}
 
 	return ref_store;
 }
-- 
2.11.0.157.gd943d85

