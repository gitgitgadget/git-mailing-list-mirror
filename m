Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C592A20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934158AbdBQOFr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:05:47 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33670 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934065AbdBQOFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:05:46 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so4181158pfg.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqX/p2Kys6d/Ofg9X5LPa//HPO9bH6hHz2H4QzA5vqE=;
        b=KX08vuKaOXsa0RoHDgYyUhYaVGOPUMGIfBhkgDidKsPo2GzT0yAfbUGnK7XiWigvjX
         SbrWI+OJDMnyKVapvglk47tHhRezxd0aNiu7GrC2rVyj3OTzQ5VbXvUsPZhhxDefreXe
         uT622au8OjkVyDJqxRrsc2w6ioAYhXeqwbst6lSnY+C0pzz+aNmvghVGF08V4c8Cy0oo
         G0r4NI9MaH88/KVo4gSwnAypKgVdaPAF/G2ldBhyrlrwdctFktOkeBIK+33NAsG/4hRr
         xhm2BzK10JAMe0HcYUDSYw5QV6l3X6VQzQAEsGZgTMq5BG5GEf5utdJEDYvaKoxaMET7
         gC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqX/p2Kys6d/Ofg9X5LPa//HPO9bH6hHz2H4QzA5vqE=;
        b=aLe3qdUWviyUD3CtjkcUlXx/1WS8+4eq2IrVy7J7ZcKQ+///dfg1H2EirIXX7dA9E4
         HBd73BCXlgE2XKRSJ157ImQlXeVaTN/tATae+B311jP4sSnpg3yzi8N3M0Dk2O1LXzkA
         5ceAlINMKpb3hTtdWj3llaJDXRO9gvNmN+cum7efRU/+zKLvUJhaVzDeFChRaSKrM537
         4fjyVeOebVAIdQNu2kCw02alhGmkVu6B9TYBLU5XVkCw2lvoPKBornazpQCf84W3RYds
         uz0wdMqDAn/YtdbcJIpyIeWQ+Ojo9bATqCpmtxdqopv/E+46ap97EpgyG7ZuGiQ2vCeN
         kOQA==
X-Gm-Message-State: AMke39kinoX4LeTfQ0EZdccvGith1ZcJxyFVMRFR8EORawo/PhH2qD8RnYwZri8hFobAuw==
X-Received: by 10.99.152.65 with SMTP id l1mr10520965pgo.28.1487340345572;
        Fri, 17 Feb 2017 06:05:45 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id c64sm20012962pfa.45.2017.02.17.06.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:05:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:05:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 07/16] files-backend: remove the use of git_path()
Date:   Fri, 17 Feb 2017 21:04:27 +0700
Message-Id: <20170217140436.17336-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
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
 refs/files-backend.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 24f5bf7f1..07cf2cb93 100644
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
@@ -944,8 +948,14 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 	if (refs->submodule)
 		strbuf_git_path_submodule(sb, refs->submodule,
 					  "%s", tmp.buf);
+	else if (!strcmp(tmp.buf, "packed-refs") || !strcmp(tmp.buf, "logs"))
+		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
+	else if (is_per_worktree_ref(tmp.buf) ||
+		 (skip_prefix(tmp.buf, "logs/", &ref) &&
+		  is_per_worktree_ref(ref)))
+		strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf);
 	else
-		strbuf_git_path(sb, "%s", tmp.buf);
+		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
 	strbuf_release(&tmp);
 }
 
@@ -1004,7 +1014,15 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 
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

