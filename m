Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A241F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeAaLIN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36427 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeAaLIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id 23so12250447pfp.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ITsCol/qhoOYtSSI4hfXRKhxRmnLwxV75atgcFdrrZc=;
        b=vctrqPPXHBrzjQwlMZ7bLfxs7MxuMCsoRnTYHYpYLyS6ifIt9qL5C1J1sYma18tkPF
         lnckd38uRDXZ827NHM5kgH775GmYhdC4IEhEPs4o1fMSasqvaQmxA42sOAxCRDipolqt
         3hnz4tvOzrHzYMG39ztffmT981XfND2LjWWTHDQD+sOZKnmegomQn8JaT458PqVprxvX
         +I93I1kSNCjPvu6IuF/9pJ44KTOK9Kdl/okdLo3wXHcT+MI6q8PZ/2tHfzZMRECNNSpl
         HyLIsz9m3iar48/OX4kSs0+T9sJlCodIHUo4xeq29BuBk/5BfGQE6wBGU35BoDp5focG
         /wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ITsCol/qhoOYtSSI4hfXRKhxRmnLwxV75atgcFdrrZc=;
        b=LIZD7klMG8oJW4EcWUI5o6abGZgOjRQ1x7HbWn3zX2vTB5B3xQSPKcmnP9zOVrfp8z
         Zj946xurSsgBOALyQMRxfdA00a4O3TlqWti9+lb9U3GbR+IymH2/JvWPZlhUlszDWwhu
         yBuXhN5vxP9ndbcN8/CBG+VwGeTWs3kZB6AXp8GCEK6zRkIwvdKurbqCWrfWJzsghLIZ
         IuZ0UEqj1qLKh+O7VAJd8iQSYTv6OzQNTfiVztrQpUjE9jL8+orUIB9sorjKisQ0rqm+
         S7JlT5imMgvB68/+WkX9T+n/ZoY5AiQVYPbrdNlPr5sfF6Id7dpaCtV8JyGmVJUGFRf3
         XJng==
X-Gm-Message-State: AKwxytehJA3CW/WPeHEFQys4IS6B6Rac8cei78g1f81kR9Wl6LobB3Ns
        S3JskKcKvua8q3q+cA6qRIj7iw==
X-Google-Smtp-Source: AH8x227hT/oXdy+ZrG5ldfbC8gX/s+TLn1OShyDiVsyyskw051+Unh9b1Z47aUEEcdPrrzPKWWSBIg==
X-Received: by 10.99.157.72 with SMTP id i69mr25030699pgd.300.1517396888403;
        Wed, 31 Jan 2018 03:08:08 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id e9sm23833121pgv.14.2018.01.31.03.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 29/41] completion: use __gitcomp_builtin in _git_notes
Date:   Wed, 31 Jan 2018 18:05:35 +0700
Message-Id: <20180131110547.20577-30-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--allow-empty (notes add and notes append)
--for-rewrite= (notes copy)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/notes.c                        |  4 ++--
 contrib/completion/git-completion.bash | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index b52e71c73e..6990683bd4 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -413,7 +413,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg},
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
-		OPT__FORCE(&force, N_("replace existing notes"), 0),
+		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
@@ -484,7 +484,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	const char *rewrite_cmd = NULL;
 	struct option options[] = {
-		OPT__FORCE(&force, N_("replace existing notes"), 0),
+		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read objects from stdin")),
 		OPT_STRING(0, "for-rewrite", &rewrite_cmd, N_("command"),
 			   N_("load rewriting config for <command> (implies "
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 391074a772..14af9457af 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1821,7 +1821,7 @@ _git_notes ()
 
 	case "$subcommand,$cur" in
 	,--*)
-		__gitcomp '--ref'
+		__gitcomp_builtin notes
 		;;
 	,*)
 		case "$prev" in
@@ -1837,15 +1837,17 @@ _git_notes ()
 	add,--reedit-message=*|append,--reedit-message=*)
 		__git_complete_refs --cur="${cur#*=}"
 		;;
-	add,--*|append,--*)
-		__gitcomp '--file= --message= --reedit-message=
-				--reuse-message='
+	add,--*)
+		__gitcomp_builtin notes_add
+		;;
+	append,--*)
+		__gitcomp_builtin notes_append
 		;;
 	copy,--*)
-		__gitcomp '--stdin'
+		__gitcomp_builtin notes_copy
 		;;
 	prune,--*)
-		__gitcomp '--dry-run --verbose'
+		__gitcomp_builtin notes_prune
 		;;
 	prune,*)
 		;;
-- 
2.16.1.205.g271f633410

