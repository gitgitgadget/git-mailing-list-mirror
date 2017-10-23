Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8394202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 17:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdJWRGC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 13:06:02 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:55183 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdJWRF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 13:05:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id n5so22823631qke.11
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g3j1gWYaj3A4RBXY4TmZKvmK97wirY4dSUnx211x14Y=;
        b=B9AvLFdeinLIAK9BALOMQTd/VtcRHljsnELLJpAKj8WDthEN+Zs3Teclem1wrhNfMs
         Ds9iS8dp/WGWDIdXZd//KLr7FsdyJPiB9w3CVHekRQiGXDCXbjCuIfcSaZHLGQTGmQg8
         vA+LwYVa/uG584rTTjnzg9aMJGnbDooUQFs/keoRCNVEokVxvbFmDMrjzbvXF7WXbhD8
         xHvSOKJYXmTlA7vFwlWkaccwuCFT7PRRpo8UXU7dEA60Wt5/9CKqPqd/NgisopxEiqH9
         dkrucTEltFBjjGHvf04Th+KbcMCJiaUK0hN6PkeDI9lpbTej51tv2F1dlp1b4MTifdMo
         zt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g3j1gWYaj3A4RBXY4TmZKvmK97wirY4dSUnx211x14Y=;
        b=lYWv3I/xnJVFGEvuZ/A0knWjuKicmJj98LtArh3mLgk53CHyJoiIP0ejwfTE0lISCE
         38ZslAuE2fx6DM9vRzNofYrndRshQje4ka9bC+7DHzeFeHghd071hyKVzkIHpwNjorDz
         aEc3buGSR7D0my3RfpyU6Wpfg5lZrHGN2NFESM5nYiiTQQyH6YLoUIGMW02BLv2jw31w
         CI29gXHKuVtApGVLYEi0M1quiKIsAPjIWUE8ZwsdJ2R/BN1mr7FeftmqWowSKiyAzi7e
         9j4Qq9fT/osbnLaWWde2h1srD3/EDWp7y/h0j/6HMZH03p7jIDs2KZPQX6Mm+f9MuEKm
         xcNg==
X-Gm-Message-State: AMCzsaVSMdxoHQ8QXXvTvrT6zozLjW9brOX87McGzkwsu4Rzzwsi4D+A
        xdSt+ejn8eY+FIcMWpSMfQM=
X-Google-Smtp-Source: ABhQp+TDdSPZVCGBUsVdwQOMZp8lu886kdX03mD7DkVpgJkHcxELSCw6TgjwpPRSw/3N8qU4sMa5yQ==
X-Received: by 10.55.192.204 with SMTP id v73mr19643090qkv.117.1508778358063;
        Mon, 23 Oct 2017 10:05:58 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id p64sm4885397qkd.67.2017.10.23.10.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 10:05:57 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v4 2/4] status: report matching ignored and normal untracked
Date:   Mon, 23 Oct 2017 13:05:32 -0400
Message-Id: <20171023170534.157740-3-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171023170534.157740-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171023170534.157740-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach status command to handle `--ignored=matching` with
`--untracked-files=normal`

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 dir.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index b9af87eca9..20457724c0 100644
--- a/dir.c
+++ b/dir.c
@@ -1585,6 +1585,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 {
 	int exclude;
 	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
+	enum path_treatment path_treatment;
 
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, istate, path->buf, path->len);
@@ -1631,8 +1632,23 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, istate, untracked, path->buf, path->len,
-				       baselen, exclude, pathspec);
+		path_treatment = treat_directory(dir, istate, untracked,
+						 path->buf, path->len,
+						 baselen, exclude, pathspec);
+		/*
+		 * If 1) we only want to return directories that
+		 * match an exclude pattern and 2) this directory does
+		 * not match an exclude pattern but all of its
+		 * contents are excluded, then indicate that we should
+		 * recurse into this directory (instead of marking the
+		 * directory itself as an ignored path).
+		 */
+		if (!exclude &&
+		    path_treatment == path_excluded &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
+			return path_recurse;
+		return path_treatment;
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
-- 
2.13.6

