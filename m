Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1F61F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162609AbeBNTCt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:49 -0500
Received: from mail-io0-f201.google.com ([209.85.223.201]:36198 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162500AbeBNTBE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:04 -0500
Received: by mail-io0-f201.google.com with SMTP id z6so20965541iob.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hdwRAUIs4ty1eX+THmV91Dx+56/3g56jw1NVQlp0Tl0=;
        b=LhyoQn9zCXHoF4erFR1JXTcTknnpTEjAPs7U4jjQYhMtN8qNZ6bJ9xQPm7SIe/YQ3W
         fkEgNwkPPhS9i8dEEd+2CXzKqRv1iepTBYh6GyJJLZBnxmwP/HAl36ErGbZDreb1HctA
         poyNOzXgd83NJMf06EszQkfz0tv4A5CA6FnDVCJ/u1jJF/8HrR+7zvMzHyHzYdaxBX3/
         LMEb4WjWdQTGPExTB2J9/SBpbXDN9n9lYWpn5QUs3YQUfSgLKPowdHvgKtVc2njrIZbn
         W+a2mLP1mq5zRRJBEIVATe7i/Qjh6vAkYIqH75hxKEseIt1oooa8gYD4zkB4v6d3yp2l
         H8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hdwRAUIs4ty1eX+THmV91Dx+56/3g56jw1NVQlp0Tl0=;
        b=bCofycs+vLM+VNKXkcjTSHYhM8RdWHW3y4LASpv3+UcHE+RoRpL79iUQzJgKmZqGwK
         Pa9ZGgMf9dE+RtTb4zyqtj9rgX+pgPhKdKtcEJmgtnyeeegpdOI5ERe+Xxj2LyuY2N0w
         M131CfnlqVvu+5jiDLx8zCI+DUjuSiHddZC6YKWud4sB7ceo4dSZljIbJ2oJT5NTVrq0
         lT9+HuXR5OTSX1jjdblZk4z8vpR2Pi8kj17RUzZ7qy1xuh+VCiJaLdpnyR4J4HHSyudu
         1AnvSwYvv5mA3X5jJ0jJ5sIATmH08bUEee7XFyiB7SyMpmVyS6Pd5PtMCQOKhjYTmv9D
         DugA==
X-Gm-Message-State: APf1xPD6XkSj0Mu+f4VGELVcUt+33AnaTmNNid4+aRJekqhkdElhgBtv
        cpqaknl2W+xEe8vvc4c4sX6iQeK3+Vg2Wsrppm1rkvDgf8Wb0GWPKIuEhoU2vHN2jhpvkLmn2CT
        5YxvYvJcG871ljaXQLrNAo0T2T+GUNj9DGjofIHY5XRAni0viJ25Qgkcpsg==
X-Google-Smtp-Source: AH8x225o/9ru8hm3U70HaDRCnEzeU+v2lCioUibnpDW4Mv6vcu2ylaKL0F2uOaaIFZIUf4FGSo11wAUQeX4=
MIME-Version: 1.0
X-Received: by 10.36.177.6 with SMTP id o6mr7575itf.30.1518634864075; Wed, 14
 Feb 2018 11:01:04 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:30 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-9-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 08/37] apply: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 apply.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/apply.c b/apply.c
index 071f653c6..e9f34dceb 100644
--- a/apply.c
+++ b/apply.c
@@ -2301,7 +2301,7 @@ static void update_pre_post_images(struct image *preimage,
 				   size_t len, size_t postlen)
 {
 	int i, ctx, reduced;
-	char *new, *old, *fixed;
+	char *new_buf, *old_buf, *fixed;
 	struct image fixed_preimage;
 
 	/*
@@ -2327,25 +2327,25 @@ static void update_pre_post_images(struct image *preimage,
 	 * We trust the caller to tell us if the update can be done
 	 * in place (postlen==0) or not.
 	 */
-	old = postimage->buf;
+	old_buf = postimage->buf;
 	if (postlen)
-		new = postimage->buf = xmalloc(postlen);
+		new_buf = postimage->buf = xmalloc(postlen);
 	else
-		new = old;
+		new_buf = old_buf;
 	fixed = preimage->buf;
 
 	for (i = reduced = ctx = 0; i < postimage->nr; i++) {
 		size_t l_len = postimage->line[i].len;
 		if (!(postimage->line[i].flag & LINE_COMMON)) {
 			/* an added line -- no counterparts in preimage */
-			memmove(new, old, l_len);
-			old += l_len;
-			new += l_len;
+			memmove(new_buf, old_buf, l_len);
+			old_buf += l_len;
+			new_buf += l_len;
 			continue;
 		}
 
 		/* a common context -- skip it in the original postimage */
-		old += l_len;
+		old_buf += l_len;
 
 		/* and find the corresponding one in the fixed preimage */
 		while (ctx < preimage->nr &&
@@ -2365,21 +2365,21 @@ static void update_pre_post_images(struct image *preimage,
 
 		/* and copy it in, while fixing the line length */
 		l_len = preimage->line[ctx].len;
-		memcpy(new, fixed, l_len);
-		new += l_len;
+		memcpy(new_buf, fixed, l_len);
+		new_buf += l_len;
 		fixed += l_len;
 		postimage->line[i].len = l_len;
 		ctx++;
 	}
 
 	if (postlen
-	    ? postlen < new - postimage->buf
-	    : postimage->len < new - postimage->buf)
+	    ? postlen < new_buf - postimage->buf
+	    : postimage->len < new_buf - postimage->buf)
 		die("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d",
-		    (int)postlen, (int) postimage->len, (int)(new - postimage->buf));
+		    (int)postlen, (int) postimage->len, (int)(new_buf - postimage->buf));
 
 	/* Fix the length of the whole thing */
-	postimage->len = new - postimage->buf;
+	postimage->len = new_buf - postimage->buf;
 	postimage->nr -= reduced;
 }
 
@@ -4163,30 +4163,30 @@ static void show_mode_change(struct patch *p, int show_name)
 static void show_rename_copy(struct patch *p)
 {
 	const char *renamecopy = p->is_rename ? "rename" : "copy";
-	const char *old, *new;
+	const char *old_name, *new_name;
 
 	/* Find common prefix */
-	old = p->old_name;
-	new = p->new_name;
+	old_name = p->old_name;
+	new_name = p->new_name;
 	while (1) {
 		const char *slash_old, *slash_new;
-		slash_old = strchr(old, '/');
-		slash_new = strchr(new, '/');
+		slash_old = strchr(old_name, '/');
+		slash_new = strchr(new_name, '/');
 		if (!slash_old ||
 		    !slash_new ||
-		    slash_old - old != slash_new - new ||
-		    memcmp(old, new, slash_new - new))
+		    slash_old - old_name != slash_new - new_name ||
+		    memcmp(old_name, new_name, slash_new - new_name))
 			break;
-		old = slash_old + 1;
-		new = slash_new + 1;
+		old_name = slash_old + 1;
+		new_name = slash_new + 1;
 	}
-	/* p->old_name thru old is the common prefix, and old and new
+	/* p->old_name thru old_name is the common prefix, and old_name and new_name
 	 * through the end of names are renames
 	 */
-	if (old != p->old_name)
+	if (old_name != p->old_name)
 		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
-		       (int)(old - p->old_name), p->old_name,
-		       old, new, p->score);
+		       (int)(old_name - p->old_name), p->old_name,
+		       old_name, new_name, p->score);
 	else
 		printf(" %s %s => %s (%d%%)\n", renamecopy,
 		       p->old_name, p->new_name, p->score);
-- 
2.16.1.291.g4437f3f132-goog

