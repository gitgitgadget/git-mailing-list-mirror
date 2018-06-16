Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0781F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932383AbeFPFmX (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:23 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:38237 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932270AbeFPFmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:16 -0400
Received: by mail-lf0-f50.google.com with SMTP id i83-v6so17517956lfh.5
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhEyH9v24Q6oyEtoG7UrsNYvQV8HDUsLSChL/aJGKRY=;
        b=T9OYi/7emo7+m6ljcDQX3tHb7fWeXrg0wCjW6SzWp/Q1UrQRgQ/kEhFkDiuU6dK1jQ
         rGLkoPIjI8SyCMTZuZmXa2inmFb5XsG6//oXP2OKrsDMW5MeWBlfWRcSuMesEZJDXrGa
         /blB73FLRubq2WRUFTPOo0wd6AhTglzb/x8+1OUzMbUNYOB6D43xQru0c+Kh/S6LyP3e
         /Z/ti28m67+DpQfFbgnyf/NRkLWj4dvcq8y5YyWF5JhiRI9T9xx+41BsbwI6yDrV1O9o
         3LnuHCd9RisjnH1MskPe8au0oiMxC21nK4FwcAr3UZHFzjOBdsS3Wly6sAr5V0utaj28
         Npiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhEyH9v24Q6oyEtoG7UrsNYvQV8HDUsLSChL/aJGKRY=;
        b=cPB31/1AhwWTP4YgajoFGSJ9MYuH9VUimgFSLa7dXM5jHeWQEnabV1xyU0q0kOVxux
         fZsgvSP5NLGbsOjg/53j6c8Lquyo08P5vVKV0Ply2AHyS+3eHan4wCBgqSW/4p5xhREn
         Piwof+lhdRvLbi0q3b6OmHVe1xaUO73Pdew2v8cyABwqzr7l/p5PH7Tf8FIDuqnf0euc
         FQ5qWJFeEsuUtjqiaoolvAMEhirI0R61FOjYI2KrJyo7rdaKUvKcyHOYJsWb2F/biF/K
         o6R9P5BMoIhh7eJ76mEErRgqW4PbL3BNX0+oWqyurU4QcAkq7polKgdiCbsoAsNgvMQD
         DszQ==
X-Gm-Message-State: APt69E2t5FEuFeFQvNF3/faSuYLxcVvaRdINoCaFVYecsMiwUmzNUhAw
        DYEe/E9JyHvjBaxSdrwLbV4/QQ==
X-Google-Smtp-Source: ADUXVKJHTrssv483hjee6WusLUo4yBJwIebZyLPVBOlVYfd0qUmqHXupmBe9ZE4bDAYXSwwVQuhBCg==
X-Received: by 2002:a19:7b0c:: with SMTP id w12-v6mr2658781lfc.22.1529127734545;
        Fri, 15 Jun 2018 22:42:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/15] sha1-name.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:55 +0200
Message-Id: <20180616054157.32433-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7e..8344d9a9e0 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1560,11 +1560,11 @@ static void diagnose_invalid_index_path(int stage,
 		prefix = "";
 
 	/* Wrong stage number? */
-	pos = cache_name_pos(filename, namelen);
+	pos = index_name_pos(&the_index, filename, namelen);
 	if (pos < 0)
 		pos = -pos - 1;
-	if (pos < active_nr) {
-		ce = active_cache[pos];
+	if (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos];
 		if (ce_namelen(ce) == namelen &&
 		    !memcmp(ce->name, filename, namelen))
 			die("Path '%s' is in the index, but not at stage %d.\n"
@@ -1576,11 +1576,11 @@ static void diagnose_invalid_index_path(int stage,
 	/* Confusion between relative and absolute filenames? */
 	strbuf_addstr(&fullname, prefix);
 	strbuf_addstr(&fullname, filename);
-	pos = cache_name_pos(fullname.buf, fullname.len);
+	pos = index_name_pos(&the_index, fullname.buf, fullname.len);
 	if (pos < 0)
 		pos = -pos - 1;
-	if (pos < active_nr) {
-		ce = active_cache[pos];
+	if (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos];
 		if (ce_namelen(ce) == fullname.len &&
 		    !memcmp(ce->name, fullname.buf, fullname.len))
 			die("Path '%s' is in the index, but not '%s'.\n"
@@ -1672,13 +1672,13 @@ static int get_oid_with_context_1(const char *name,
 		if (flags & GET_OID_RECORD_PATH)
 			oc->path = xstrdup(cp);
 
-		if (!active_cache)
-			read_cache();
-		pos = cache_name_pos(cp, namelen);
+		if (!the_index.cache)
+			read_index(&the_index);
+		pos = index_name_pos(&the_index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
-		while (pos < active_nr) {
-			ce = active_cache[pos];
+		while (pos < the_index.cache_nr) {
+			ce = the_index.cache[pos];
 			if (ce_namelen(ce) != namelen ||
 			    memcmp(ce->name, cp, namelen))
 				break;
-- 
2.18.0.rc0.333.g22e6ee6cdf

