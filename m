Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D02D1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 13:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeBANCg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 08:02:36 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38358 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbeBANCf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 08:02:35 -0500
Received: by mail-pg0-f65.google.com with SMTP id y27so12364128pgc.5
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iXgqfGpAJ0ak7qQ8sbuHhEG/s+TbqajPUV3ochMMlac=;
        b=VxxOzhxF3tUDk1Cr/C8N/ffLfe8voH5NPQ3eXX2C6qoSrz4pBVVwfRQSCZ9ViLK4ch
         /c6/oCtlXP8PH3XEXWOZBa94AZBe2ckTb7BCX6/8NsptjOtL1oXE8go2C4r/b2Q3CwkR
         RteF48jRtz1QyCUjQgXyBsExShLXqSyVPnd9nkxCmAS/pN5yQ53qn0v4vXIpdk1I46jB
         9Yy7gyPh3+DYyr6QC+3nBz7vEP0IQooeAWufP5w9unhw85GYc/qcLvZVut0IbUfW0vhe
         7agfuNkNT2D71P0kp119I1vtdQr3NV7kTeeomaPGLq/jY9BZOBp4UOaHTOLmh+BKxrpf
         84Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iXgqfGpAJ0ak7qQ8sbuHhEG/s+TbqajPUV3ochMMlac=;
        b=XvLxxTEwt6bKuPLDW0rap0Wg+vnUzdDoxYUfpqF4kPk2ZrVsYAEJtZq4N+fSNEYr9v
         zrA6ZnfIrwZ1orXNChd8MUQeGNydRA2yI4+rMgD/UX/ZOS2c0tVrJznJz2dNJPfLn008
         m/PBmEsvig7OyP9dW/ZzTb8bkRkDh6bF7Kv0CB1exsJc2mrVuhqtKifpKT5gwlf778/L
         x9FHvp1axd+BZ6MQQ89u6ug45ZveSYZtQY3vyXiGL7zBkb05t4VSL0nAl5mTyuEThIEP
         LSXjnTDIaJZWzSyMiPLJu8RIjIi1YOIgB7gYlcXgTneK1n1EfG+zQviNfJs0sJIRwVd3
         Ntpg==
X-Gm-Message-State: AKwxytcoXfHPM07FU/grB/3VkZmMyBWxRBDqawLIkEXYbo+Xy8kRHgmf
        OFBBXLSWOOoj2+OdvTjkZPJWFw==
X-Google-Smtp-Source: AH8x225A+0b8ixSBxcUlsmMIGdYzM4QPdA12KxbsHbPbdrzTwpcRoNJeZfR/3WP+a3iYNZCebIRJ7g==
X-Received: by 10.98.202.84 with SMTP id n81mr36633280pfg.226.1517490153846;
        Thu, 01 Feb 2018 05:02:33 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id 14sm29856292pga.12.2018.02.01.05.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 05:02:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Feb 2018 20:02:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/2] diff.c: refactor pprint_rename() to use strbuf
Date:   Thu,  1 Feb 2018 20:02:20 +0700
Message-Id: <20180201130221.15563-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180201130221.15563-1-pclouds@gmail.com>
References: <20180201130221.15563-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of passing char* around, let function handle strbuf
directly. All callers already use strbuf internally.

This helps kill the "not free" exception in free_diffstat_info(). I
don't think this code is so critical that we need to avoid some free()
calls.

The other benefit comes in the next patch, where we append something
in pname before returning from fill_print_name(). With strbuf, it's
very simple. With "char *" we may have to resort to explicit
reallocation and stuff.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 59 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/diff.c b/diff.c
index 0a9a0cdf18..9d874a670f 100644
--- a/diff.c
+++ b/diff.c
@@ -2045,11 +2045,10 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 }
 
-static char *pprint_rename(const char *a, const char *b)
+static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 {
 	const char *old = a;
 	const char *new = b;
-	struct strbuf name = STRBUF_INIT;
 	int pfx_length, sfx_length;
 	int pfx_adjust_for_slash;
 	int len_a = strlen(a);
@@ -2059,10 +2058,10 @@ static char *pprint_rename(const char *a, const char *b)
 	int qlen_b = quote_c_style(b, NULL, NULL, 0);
 
 	if (qlen_a || qlen_b) {
-		quote_c_style(a, &name, NULL, 0);
-		strbuf_addstr(&name, " => ");
-		quote_c_style(b, &name, NULL, 0);
-		return strbuf_detach(&name, NULL);
+		quote_c_style(a, name, NULL, 0);
+		strbuf_addstr(name, " => ");
+		quote_c_style(b, name, NULL, 0);
+		return;
 	}
 
 	/* Find common prefix */
@@ -2109,19 +2108,18 @@ static char *pprint_rename(const char *a, const char *b)
 	if (b_midlen < 0)
 		b_midlen = 0;
 
-	strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_length + 7);
+	strbuf_grow(name, pfx_length + a_midlen + b_midlen + sfx_length + 7);
 	if (pfx_length + sfx_length) {
-		strbuf_add(&name, a, pfx_length);
-		strbuf_addch(&name, '{');
+		strbuf_add(name, a, pfx_length);
+		strbuf_addch(name, '{');
 	}
-	strbuf_add(&name, a + pfx_length, a_midlen);
-	strbuf_addstr(&name, " => ");
-	strbuf_add(&name, b + pfx_length, b_midlen);
+	strbuf_add(name, a + pfx_length, a_midlen);
+	strbuf_addstr(name, " => ");
+	strbuf_add(name, b + pfx_length, b_midlen);
 	if (pfx_length + sfx_length) {
-		strbuf_addch(&name, '}');
-		strbuf_add(&name, a + len_a - sfx_length, sfx_length);
+		strbuf_addch(name, '}');
+		strbuf_add(name, a + len_a - sfx_length, sfx_length);
 	}
-	return strbuf_detach(&name, NULL);
 }
 
 struct diffstat_t {
@@ -2197,23 +2195,17 @@ static void show_graph(struct strbuf *out, char ch, int cnt,
 
 static void fill_print_name(struct diffstat_file *file)
 {
-	char *pname;
+	struct strbuf pname = STRBUF_INIT;
 
 	if (file->print_name)
 		return;
 
-	if (!file->is_renamed) {
-		struct strbuf buf = STRBUF_INIT;
-		if (quote_c_style(file->name, &buf, NULL, 0)) {
-			pname = strbuf_detach(&buf, NULL);
-		} else {
-			pname = file->name;
-			strbuf_release(&buf);
-		}
-	} else {
-		pname = pprint_rename(file->from_name, file->name);
-	}
-	file->print_name = pname;
+	if (file->is_renamed)
+		pprint_rename(&pname, file->from_name, file->name);
+	else
+		quote_c_style(file->name, &pname, NULL, 0);
+
+	file->print_name = strbuf_detach(&pname, NULL);
 }
 
 static void print_stat_summary_inserts_deletes(struct diff_options *options,
@@ -2797,8 +2789,7 @@ static void free_diffstat_info(struct diffstat_t *diffstat)
 	int i;
 	for (i = 0; i < diffstat->nr; i++) {
 		struct diffstat_file *f = diffstat->files[i];
-		if (f->name != f->print_name)
-			free(f->print_name);
+		free(f->print_name);
 		free(f->name);
 		free(f->from_name);
 		free(f);
@@ -5241,10 +5232,12 @@ static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
 		struct diff_filepair *p)
 {
 	struct strbuf sb = STRBUF_INIT;
-	char *names = pprint_rename(p->one->path, p->two->path);
+	struct strbuf names = STRBUF_INIT;
+
+	pprint_rename(&names, p->one->path, p->two->path);
 	strbuf_addf(&sb, " %s %s (%d%%)\n",
-			renamecopy, names, similarity_index(p));
-	free(names);
+		    renamecopy, names.buf, similarity_index(p));
+	strbuf_release(&names);
 	emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
 				 sb.buf, sb.len, 0);
 	show_mode_change(opt, p, 0);
-- 
2.16.1.75.ga05e3333b4

