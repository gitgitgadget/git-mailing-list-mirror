Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA331F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeCWRWt (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32770 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeCWRVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id x205-v6so19396863lfa.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LoUF9LSnAgzaMz+PRiVqX8pQC4FE6MhSi0mZUwRPaw=;
        b=KSCL/SJ/tLILL4HejknpFUj7aeuNYoX17jXAxG81XeX7z3wd8/MIz0sau14NvC4eT4
         IiyQE9tAitBvfkDw75q8lUsTYJxYa4jaqkHbtGegIX6B4ausA3ZW2lsB9Yoh9qc1IJgr
         aW/wrCc42dg4FwZklvtS30QQMypMlUD2tjehF3T07y+Vww5s7ardid0axDglilBSJAGQ
         k+IxmNJUDGklLswexP+2SB7EfrUD+ch+xS7wCJa36KOWALzXrfE5P85EG5XqCmo/h5CS
         K136cSbT8bRMASFojlqzixpx20FanDiyLu5g3sA/XnwxvpyhQotRrrOct7eYQgkFi/8v
         xC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LoUF9LSnAgzaMz+PRiVqX8pQC4FE6MhSi0mZUwRPaw=;
        b=IhtsluYOatZ5qAPD7095fhAckRxLd6LSDWWB1Qbkz5lDGb6R28bDBAal4jMAfrF/4M
         TMy28WjP27YOZ3O3srpHj4oc7b18oV4Ogf3d+/RmJSaatkDxDCbQ673qEli6OVOVUKn+
         bgISHNUQBQwWOv2qgxWRD/zNMa0D+acInzdEV5fASXB/89ZvXPmEZSSPrxRXJlPtElLf
         h7bhna+fpjJnKNDcXqqbiuOOOE+6k4RlaJwXFVYDMSDOSVnvwIazu6eAYlHR7VCEPj8q
         nS6JYxyhdGwevagbN/fdgfAX7n25xxLTgoPiVMYrkVhDyUTAtKdIoDjQQS0Rbvue2HLw
         BM/w==
X-Gm-Message-State: AElRT7Gt4T4tGsxG/oXoVUcN08s/xDxF67Nf9deNFcWuI40IaJRD5NQn
        yKLXH0PNQ3RNuPUGCQik/pE=
X-Google-Smtp-Source: AG47ELv53KTqQB+l7XADc+ajh0iV8GwoB8HNrP15FjrFr3FuFbC9G+G7i56G0fI7fMf1ser59dlwqw==
X-Received: by 10.46.157.22 with SMTP id t22mr1823704lji.107.1521825711673;
        Fri, 23 Mar 2018 10:21:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/27] sha1_file: add raw_object_store argument to alt_odb_usable
Date:   Fri, 23 Mar 2018 18:21:03 +0100
Message-Id: <20180323172121.17725-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a raw_object_store to alt_odb_usable to be more specific about which
repository to act on. The choice of the repository is delegated to its
only caller link_alt_odb_entry.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 84b361c125..097c372d03 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -347,7 +347,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+static int alt_odb_usable(struct raw_object_store *o,
+			  struct strbuf *path,
+			  const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
@@ -363,7 +365,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+	for (alt = o->alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -415,7 +417,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(the_repository->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
-- 
2.17.0.rc0.348.gd5a49e0b6f

