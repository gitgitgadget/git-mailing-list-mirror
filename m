Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2C631FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932500AbdJ3RWT (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:22:19 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:50042 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932659AbdJ3RV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:21:57 -0400
Received: by mail-qt0-f195.google.com with SMTP id k31so17346055qta.6
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gV2y0jEnxRwdGvkA4MZcYeQQlGFjtKD3GmL8oBCq6tc=;
        b=NKk8cFDKzOo8OJla6wbSAo40Pqu4AgWa18vH41eI2nTrgCzeoLQGIvZy1tC/C03iGT
         wUbzKNvLWM94xj9Q/ymYgPScPNCrWC2JaO48M0CCjhVKfIpRqrK4INAJAQRpB+CFHVaQ
         8RCGzslQTvCbA/4TQq48I7sPdFhwFXMAaBOuWLaa5K6yCevMs3b7Hbe6ydyXMNWj/lmv
         xT+o4USTgNFtbuQmEWGYV7JwVJ0r+RkRWAxeLDF6/yTe/9EtqWoy/dR/+VpVPYTflTy5
         /yl0uZtrQP/sgk8tICpqNf7CpYDkEQbtXff4Hao15Ll+gWs57jYKT0Ya7xrV8EDHC4Mc
         20Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gV2y0jEnxRwdGvkA4MZcYeQQlGFjtKD3GmL8oBCq6tc=;
        b=pXg5dTss61xs/hLCq5ZV50HMU9vwxDXkhRoYQODIc42g5+wEZO8Ph2PnD9LY2wf/rP
         xMAfvGaKoHmo7WN102YHCZUwgLW0ALXYn5FBT1EERCGmq/oF6lNqABbfOgISipvyH8zD
         fwwCngvWgGSiHaVc6BcOTT4ws/xje22c8bdeP4PuvZi8DGCYxBBEsOIll7j8egcUkYyJ
         +1FYyR8XOX0QlEsjGvvFvkhLYAz/zF9NzCboYxSwECn/6g1RlpcXJrxHN+xzMbbQjTgX
         BxF1iMjIbLAykwbKqhaTJzl2cKnVoqiO/oxnDrGZ758fDenxvdpLkfOFk5L7wZm51WIA
         Xjew==
X-Gm-Message-State: AMCzsaU3ADynsL2IzWQx/mA//KpDKwksbPfYAbcFQSbX1YmRp+H9Njf1
        KzHjicGJtxYrRf/aeIn1NAI=
X-Google-Smtp-Source: ABhQp+REx+CSz/Ya4TuPSxBvrhKJlbLm3XmbbSChPrfd03JEHyArVbDw4gKPiaGCRoO3ILhWlrsXWg==
X-Received: by 10.237.59.249 with SMTP id s54mr15083315qte.34.1509384117137;
        Mon, 30 Oct 2017 10:21:57 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id n23sm9670119qka.1.2017.10.30.10.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Oct 2017 10:21:56 -0700 (PDT)
From:   jameson.miller81@gmail.com
X-Google-Original-From: jamill@microsoft.com
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v5 2/4] status: report matching ignored and normal untracked
Date:   Mon, 30 Oct 2017 13:21:38 -0400
Message-Id: <20171030172140.235797-3-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171030172140.235797-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171030172140.235797-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

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

