Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD691F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfBQKK0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41567 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so7070494pfi.8
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SArSb8OPBRUZVqMXmUXorSnL97zME5T0e3Z7eNBMPRA=;
        b=RV7jEl0R0MoPMHIMKDA0d3dU9NqWT6gpYYSewFP5iTvC20BZeAsG3VnGwd8BF/zFde
         kKRIzTyEplyn0mVO6p84q/tGjeGAH4JyQ30Zm6sU6ou8GpLblXLO8t6IcFT5Qsv69NTl
         Y8vPJgHU3NpZBIAVwK3TiZkvCJ0su6KOCPxKOK/venLC/wOsmJbC4vFx0y4gfN1aOKfo
         Z46SwLC8ClizMgia6g9OgiBFosur3QiYJrHUfYICMLVqtE1kDR0/favET166DiXk9R4V
         L0eY9wPvNCuL/qhMTM8RnebSWJFjnPUA+Y9wUyJ2SRkPr5HWcJwthElZmihCAsda8ypm
         X5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SArSb8OPBRUZVqMXmUXorSnL97zME5T0e3Z7eNBMPRA=;
        b=tnCNg6VBLfvZ00vl9iEPTqsw4RQUf9vjuV217GNNymYJFQujsoLiXoEAZZZlSNRiff
         src9yW4ne9qF39QNIQcCsUv4kBm3ON77XyfTLAxg1bHEH9duBx49cL4E8Bnfuh43to0L
         Lk8/rwSlGzT8V3AN55sI2OKiessGfir6iAjlohU77vEPGDvxEoIMQOhDuEF7r+EhobPa
         jlljrx3zQqN8KAae52Sa4LxxBOBlhUNU4Jmw1W84WvUVyn5lGvbqNPFFTAmJiVdmSNzD
         e/3i5PqISabJTGX2vsyt1JWVvDftphhsSzxQGmiouRy/8g+GRVSWMaAY/F3MRhr4TtHt
         VibQ==
X-Gm-Message-State: AHQUAuYOG+soCAFhh8cg5RWQRYp26BpLRJ/HzQANzIYgi0vtfvYq5kbp
        xwePYen5ROT0CeXxDkZQlKKvn4a/
X-Google-Smtp-Source: AHgI3IbkdJYUFRHm+JcNBrzwzivXq0E9rpIUW9CsMmJuoIPf/uZ/HMzlJD5T79ydxsxaIrHxs8i0jg==
X-Received: by 2002:aa7:82ca:: with SMTP id f10mr18368772pfn.131.1550398225040;
        Sun, 17 Feb 2019 02:10:25 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m20sm11733807pgv.93.2019.02.17.02.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/31] sha1-name.c: remove the_repo from get_short_oid()
Date:   Sun, 17 Feb 2019 17:08:57 +0700
Message-Id: <20190217100913.4127-16-pclouds@gmail.com>
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
 sha1-name.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index cdcf84b826..2643b75b54 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -436,7 +436,8 @@ static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
 	sort_ambiguous_repo = NULL;
 }
 
-static enum get_oid_result get_short_oid(const char *name, int len,
+static enum get_oid_result get_short_oid(struct repository *r,
+					 const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
 {
@@ -444,7 +445,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
-	if (init_object_disambiguation(the_repository, name, len, &ds) < 0)
+	if (init_object_disambiguation(r, name, len, &ds) < 0)
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
@@ -482,8 +483,8 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 			ds.fn = NULL;
 
 		advise(_("The candidates are:"));
-		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		sort_ambiguous_oid_array(the_repository, &collect);
+		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
+		sort_ambiguous_oid_array(r, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
@@ -855,7 +856,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY)))
+	     !get_short_oid(the_repository,
+			    str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
@@ -1109,7 +1111,8 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(cp, len, oid, flags);
+				return get_short_oid(the_repository,
+						     cp, len, oid, flags);
 			}
 		}
 	}
@@ -1163,7 +1166,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 	if (!ret)
 		return FOUND;
 
-	return get_short_oid(name, len, oid, lookup_flags);
+	return get_short_oid(the_repository, name, len, oid, lookup_flags);
 }
 
 /*
-- 
2.21.0.rc0.328.g0e39304f8d

