Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02E01F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbdBBIu5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:50:57 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33707 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdBBIu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:50:56 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so1019975pfg.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iH8lvf0p1URNdHXB0pbHVhDMgE6wnixXDG6A9pYyLOA=;
        b=CbScih4qpK6p6gmx1namtfFS57YI7wuaSSNIMxMoC3TCV237Wj/EhHKzS+YESXGWSX
         hG37QqUTTLsuwRQ+fc/Mt92P5lnT8Y3ZXPdJ8yni0AEd9kF4H8iVVYjv8nJjrM7Aq+yn
         NISzG3fou/C4vERnCPd6ZW70D6Hsm86m6DSEFBwwHxCYSfMWB3odb3tjQ8D8iA6/gmr5
         Lcz9lNufxMkM5GjaX0S54Cqi1XNCv5oA/TURvq9F4YJBC97o4euq+E+P8dkfArlA49PV
         +8kT4AmaK3Rs9Vfu2QRs6mU4z4z9Y/XJURC2CWGmMHidUMDl8591rlhUqUZmA4lvWNUr
         qWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iH8lvf0p1URNdHXB0pbHVhDMgE6wnixXDG6A9pYyLOA=;
        b=mNbDTaUOuhS6k6owSQnAqjvw0nxaK1xBBzHUTK2Yg/xia6YnLIvKfPfuPPSQ/VW41A
         dRgv8rIbEUsDQMLWg/YD507PLbHWAqcE5/ntNKpppRbJ8++ePh2LGXAcsQTfY3cQRItH
         siTqa560YNjdelQWkGzBjUoKfI3r652gneNn+dqUTqLWTPAFMGF9SdKq5IsLwWK6RQHF
         Aq5IjbluKpsuy8B4r6lTJgS9WtHjzfxQR08RKO3Gg7XHX9Q2u1m4khPPG4YdowSZkJwb
         b28K6n4tgMBk5BfCEg12Yh7p7btxtlOdBxKYw2SiMuBFj56RI1XCquoXHV5wpY7QRnby
         Adww==
X-Gm-Message-State: AIkVDXIhE0vjESHNbYbn7+bKwHIs0KJQtSQ1dbX4osYSHntYtg6o6GuVGXbWwoLZUM2v9Q==
X-Received: by 10.99.51.76 with SMTP id z73mr9381234pgz.137.1486025450384;
        Thu, 02 Feb 2017 00:50:50 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id u75sm56630680pgc.31.2017.02.02.00.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/11] worktree.c: add update_worktree_location()
Date:   Thu,  2 Feb 2017 15:50:03 +0700
Message-Id: <20170202085007.21418-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
References: <20170202085007.21418-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 worktree.c | 21 +++++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/worktree.c b/worktree.c
index 929072ad89..7684951da5 100644
--- a/worktree.c
+++ b/worktree.c
@@ -354,6 +354,27 @@ int validate_worktree(const struct worktree *wt, int quiet)
 	return 0;
 }
 
+int update_worktree_location(struct worktree *wt, const char *path_)
+{
+	struct strbuf path = STRBUF_INIT;
+	int ret = 0;
+
+	if (is_main_worktree(wt))
+		return 0;
+
+	strbuf_add_absolute_path(&path, path_);
+	if (fspathcmp(wt->path, path.buf)) {
+		write_file(git_common_path("worktrees/%s/gitdir",
+					   wt->id),
+			   "%s/.git", real_path(path.buf));
+		free(wt->path);
+		wt->path = strbuf_detach(&path, NULL);
+		ret = 0;
+	}
+	strbuf_release(&path);
+	return ret;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 4433db2eb3..1ee03f4d06 100644
--- a/worktree.h
+++ b/worktree.h
@@ -58,6 +58,12 @@ extern const char *is_worktree_locked(struct worktree *wt);
 extern int validate_worktree(const struct worktree *wt, int quiet);
 
 /*
+ * Update worktrees/xxx/gitdir with the new path.
+ */
+extern int update_worktree_location(struct worktree *wt,
+				    const char *path_);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
-- 
2.11.0.157.gd943d85

