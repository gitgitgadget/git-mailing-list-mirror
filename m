Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9E11F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfBQKKf (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32794 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so7088357pfb.0
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jv4pp01mxwPL7MLI+Sna5LW19GCqzcRRps3ZBGSfs4o=;
        b=rZy3Pki4+SOWQUWyPmn6hx0r+stCLXLwTa6uaT/qau3k/vZybiAoHLk9qyy6oErBlU
         1iinAC27m7+fW4QWKVsfZAwEH3Y4hFWS0H93ZxguS8AFSx3hl6k/AMtYFIbkXy7E9pex
         r2xGTnxXW7NAXRvb7K/6Bnx+ri1vyKup0WpE23IwGwQJciANNCRmzgcG2E2flzfK/S3D
         ByV0TocbkSpsqjlubbdGE9elVQJ53mExBh4k/sWRQ761Gb5QoVOFy1Psz3wL+yhKywZE
         4lMKi/XDaEYWj+ChfY9FF1GZvNWpsI/x0A58/F3/+L0b1V8h7n9MR1Xs8lI4cf7EC1qf
         petA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jv4pp01mxwPL7MLI+Sna5LW19GCqzcRRps3ZBGSfs4o=;
        b=lhTq0+R0xvpx6LRPMLhYofOid6KXN8LdjCwsD63FQuAZlZj9WNnRyaZ+mA3OMKKMM5
         EZBvocjjoGc3HE0xaIfGdxr3vqH4tYq0LHQ97v7unsuXfLA7OB3UnPgwBpCLlNEiRAbw
         bSGaQ5aTpiOMaxgurvu/SvW07lAMMeCQ2o4duXmyhbl9Dp1M2lVHg/8Wl7QQBCURW7fL
         rXIeOjWAcME87KyPwGsdLCJwT54g/XGwJeVG+bCbojvArtqd36SHc0AxHaSjKT93w5rw
         HRhj607QFdr3QN9notLm4sehBPHdsMZE55pWphZ7D45h92baVSyuocFmYw+aN/f+Bywt
         5Gpw==
X-Gm-Message-State: AHQUAubUgtiTUkO6aY6I8GpUqk2XooM8upj3EKrDJ5arXmu2O3uI7IzD
        PpyYViqqKRWuZUGEeDeu4gEBhg3C
X-Google-Smtp-Source: AHgI3IaLkWBp7cDDKSV7rGfRSwFRbEXK4a7axWqVml7l/Bx7iza2NVAdOG04bTUc8aX3t1+mckDDvg==
X-Received: by 2002:aa7:808a:: with SMTP id v10mr18838644pff.8.1550398234147;
        Sun, 17 Feb 2019 02:10:34 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v26sm14388359pfg.62.2019.02.17.02.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/31] sha1-name.c: remove the_repo from interpret_branch_mark()
Date:   Sun, 17 Feb 2019 17:08:59 +0700
Message-Id: <20190217100913.4127-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index af8bf5b351..7d9512ac44 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1412,9 +1412,9 @@ static int reinterpret(const char *name, int namelen, int len,
 	return ret - used + len;
 }
 
-static void set_shortened_ref(struct strbuf *buf, const char *ref)
+static void set_shortened_ref(struct repository *r, struct strbuf *buf, const char *ref)
 {
-	char *s = shorten_unambiguous_ref(ref, 0);
+	char *s = refs_shorten_unambiguous_ref(get_main_ref_store(r), ref, 0);
 	strbuf_reset(buf);
 	strbuf_addstr(buf, s);
 	free(s);
@@ -1435,7 +1435,8 @@ static int branch_interpret_allowed(const char *refname, unsigned allowed)
 	return 0;
 }
 
-static int interpret_branch_mark(const char *name, int namelen,
+static int interpret_branch_mark(struct repository *r,
+				 const char *name, int namelen,
 				 int at, struct strbuf *buf,
 				 int (*get_mark)(const char *, int),
 				 const char *(*get_data)(struct branch *,
@@ -1468,7 +1469,7 @@ static int interpret_branch_mark(const char *name, int namelen,
 	if (!branch_interpret_allowed(value, allowed))
 		return -1;
 
-	set_shortened_ref(buf, value);
+	set_shortened_ref(r, buf, value);
 	return len + at;
 }
 
@@ -1509,13 +1510,13 @@ int repo_interpret_branch_name(struct repository *r,
 						   allowed);
 		}
 
-		len = interpret_branch_mark(name, namelen, at - name, buf,
+		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
 					    upstream_mark, branch_get_upstream,
 					    allowed);
 		if (len > 0)
 			return len;
 
-		len = interpret_branch_mark(name, namelen, at - name, buf,
+		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
 					    push_mark, branch_get_push,
 					    allowed);
 		if (len > 0)
-- 
2.21.0.rc0.328.g0e39304f8d

