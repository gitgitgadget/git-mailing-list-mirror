Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD03207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755586AbdEETyA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:00 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36484 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdEETxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:54 -0400
Received: by mail-pf0-f174.google.com with SMTP id q66so7063304pfi.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zpHcskpUZY4fc5uPBUeifJONJmY3v9NKCh6v89g7tdw=;
        b=GgpR6bG6UpKIGmzH5fYyF/S++5SMcHyUejippUtqePyDDU2iQsEVZaivLTvSxSU6tK
         4lgfu3fHwCALOFKFdhK1yxfTQPQYtwjaefT5Tr94iheYUXCa+Oi4XaQxQIQ8LYxrP6mS
         qGQiqY4fFdbn7VIAxCz2M+nDXhA4KHKFfIdWiN9U8LKtDGYK0ZcJJzu8cBVmNd9sLUzZ
         Qv3pGZWbqljiz7AiagWDr2REiMvY9T4vzuLmKjcTIFqjsTkD7fgrUJx+m716zEGB4X+2
         KW2mR6U7hE/FSilDBnNKTNgp6svjn/1t1DUOL2+8N7ib2OFeAvRdZn2Tto6EUa5Natu8
         JGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zpHcskpUZY4fc5uPBUeifJONJmY3v9NKCh6v89g7tdw=;
        b=d6iO1CAMw49/WUipPOAJlY33VJFCwt2ocMWWrJ2Kf3vC17wh/EyDmDp3dLW/Penhoz
         HmiLjzE+SUofUkkMN7HJJoH2PitoAItpYtVZcnJ5lWYDAulE3p0kpav0nYMdOBl/fnU3
         I54mekGLNYZgE1FonqrodXmwzlCtd+i3uJETOgxO3d2vZFuvLhvHj1yXBBDMDqpB/RMj
         frT2kq/GBjR9MyyWVnymjz9Vi42m/OEXg0VxY9w3emEZ8GvhuNJI0fPQecKE0GRDF37a
         86OJ51erupd+FEUOg9AGA9H6umuZjeEz96H36UupA7niigrmZCmHD9apleFhyI6KfIOF
         Ck0A==
X-Gm-Message-State: AN3rC/4XalUJhjkRiQwNJ1CU5r/vGVKBU6rS9+d+s+JedbOcCdeqleq2
        ZfFEOYn3C3JXWGIg
X-Received: by 10.84.224.10 with SMTP id r10mr43295459plj.25.1494014033862;
        Fri, 05 May 2017 12:53:53 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 06/14] dir: convert last_exclude_matching_from_list to take an index
Date:   Fri,  5 May 2017 12:53:26 -0700
Message-Id: <20170505195334.121856-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index a508e8076..077b756c2 100644
--- a/dir.c
+++ b/dir.c
@@ -961,7 +961,8 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
 						       int pathlen,
 						       const char *basename,
 						       int *dtype,
-						       struct exclude_list *el)
+						       struct exclude_list *el,
+						       struct index_state *istate)
 {
 	struct exclude *exc = NULL; /* undecided */
 	int i;
@@ -976,7 +977,7 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
 
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype == DT_UNKNOWN)
-				*dtype = get_dtype(NULL, &the_index, pathname, pathlen);
+				*dtype = get_dtype(NULL, istate, pathname, pathlen);
 			if (*dtype != DT_DIR)
 				continue;
 		}
@@ -1012,13 +1013,14 @@ int is_excluded_from_list(const char *pathname,
 			  struct exclude_list *el)
 {
 	struct exclude *exclude;
-	exclude = last_exclude_matching_from_list(pathname, pathlen, basename, dtype, el);
+	exclude = last_exclude_matching_from_list(pathname, pathlen, basename, dtype, el, &the_index);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
 }
 
 static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
+							struct index_state *istate,
 		const char *pathname, int pathlen, const char *basename,
 		int *dtype_p)
 {
@@ -1030,7 +1032,7 @@ static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
 		for (j = group->nr - 1; j >= 0; j--) {
 			exclude = last_exclude_matching_from_list(
 				pathname, pathlen, basename, dtype_p,
-				&group->el[j]);
+				&group->el[j], istate);
 			if (exclude)
 				return exclude;
 		}
@@ -1121,6 +1123,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			int dt = DT_DIR;
 			dir->basebuf.buf[stk->baselen - 1] = 0;
 			dir->exclude = last_exclude_matching_from_lists(dir,
+									&the_index,
 				dir->basebuf.buf, stk->baselen - 1,
 				dir->basebuf.buf + current, &dt);
 			dir->basebuf.buf[stk->baselen - 1] = '/';
@@ -1209,7 +1212,7 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
 	if (dir->exclude)
 		return dir->exclude;
 
-	return last_exclude_matching_from_lists(dir, pathname, pathlen,
+	return last_exclude_matching_from_lists(dir, &the_index, pathname, pathlen,
 			basename, dtype_p);
 }
 
-- 
2.13.0.rc1.294.g07d810a77f-goog

