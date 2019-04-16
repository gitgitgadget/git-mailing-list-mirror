Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F60420248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfDPJge (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34095 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so10131194pfd.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWJeBEVQ6y4/jgIZVFGfDqfjduHgcPTzI8Qo1NNEpcQ=;
        b=TZIU2FYqU4d2y9SXOL0957N30t00eZbiR4KBPxyoOnEyaXZpb1uI3kk7wGxmofZZh9
         z3DPfTzmbE+9fREcg2v6/0U3NN6y9BhE1Y5P1TYQJS3xYOQls9+qjCH04fH7dkqwhMkd
         WK7TmrAdAscucfxqLUhXc2uEQilMWBKDwg0kVXA+k+uOGlA1JR/+GwFl7odaMwK1fg8H
         T3p9Vwu9nE/AF8l0Xk6JCZse9xP+dvD6bWxJC+m3FvCF+Ka+yMP6z8/mOvulMrMDc15O
         Aq30+myGAEeDtlciWqe4AoQ43/q/FwNNZYraJQauBq1GODIJ+riiOzy360TjCXIRSOMF
         Ct5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWJeBEVQ6y4/jgIZVFGfDqfjduHgcPTzI8Qo1NNEpcQ=;
        b=nXGtSxNC3/eyAD6Lp5OFPi3Qh+jqrYMfpcLJzXOo7o3VIczYKRBGDsEqwDoFbcOeOj
         H7rEFuQVI/RVXu9iQlB0zeTEOr07vi5LnVAhSNVccz96Vh9lgFx/T1TUOEpqExGoRi9J
         E94wkf+aMRnnfSWMB4KIODfEW69za3VqjmZWzAB9YA/Z1hqfFEnDIzGH3Bc+8xrSP+Pl
         R82gh4W/9PFNIdTAguZd19a2nwRaRknRStQGu//kYyTyHc2puT4hiQy4iLzQ3DMKUhis
         6SRqL+Dx4VerIrsDlNk0O5LFnAG0X08o8mRdVOkfUGpyGy53xglx0oiXRPxtZEpe5nZ3
         5JrA==
X-Gm-Message-State: APjAAAU7d7XR2PnoQo7cedHuUpCdfyzSvyBZGy4WT4ixO+FTbtWfaUB5
        eOVA8lR5Dlf6pnUhN+Qp9Fk=
X-Google-Smtp-Source: APXvYqwCWcqYVAM7BiYLSxGKCDSu6wKsut2G/VPbHq+2179dI6zG0ZQ7OCXOZ2th/f0C1bepepgOWw==
X-Received: by 2002:a62:1b8a:: with SMTP id b132mr82145473pfb.19.1555407393326;
        Tue, 16 Apr 2019 02:36:33 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id 17sm121643759pfw.65.2019.04.16.02.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:36:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 20/34] sha1-name.c: remove the_repo from interpret_branch_mark()
Date:   Tue, 16 Apr 2019 16:33:27 +0700
Message-Id: <20190416093341.17079-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

