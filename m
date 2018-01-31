Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B27B1FAE2
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeAaLIq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:46 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46430 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeAaLIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:44 -0500
Received: by mail-pf0-f193.google.com with SMTP id y5so12239751pff.13
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voFsIWUh6XlCU58datGtaz/9793mrPz8mflhPuujUU8=;
        b=nJFJohD52tQImsE7z+Oyl3qdM4K/dh75cL34Xc+7xzALRoPw6XdAVSwIP7t5Gz6VVP
         /XsqKMAgrLq0S8vv9tYQJGQ/8IHeloiTR+AECXkAvZwmGKkOsV2fdZPCT0MvYE2UF0Fp
         dV2cfWn0c9DIj5XHijQzdaezLPv3PoadqDKbHUUnU448mld1AvRb5qfk5Aqzluwu/+FR
         oRxqB6qFn6xrnyJ+cSXT8M0Fl8qMe5mrAH7Mnue/2eL5ImgHTWJdf1PbdKBxwbTEPwem
         g8bnx4wmLxPLi2jzIw2dUY1gNjZ9WiFnKDF2UFjtu8vPVEsEMvignhvnT1wCGqcp9xLB
         EAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voFsIWUh6XlCU58datGtaz/9793mrPz8mflhPuujUU8=;
        b=elAisliYjzPZkD59eYVzGoDtXRmI4/xTFXfGHLHxpcAtriJTaDluQ7J0MGLSsRIFlT
         34KAYuWmNay3qvHJ9gVMXzs/KFL4r8Ijox7dn5H+IP/b97JAsy3XfW9CimRImkHdzsuR
         Y8edcJ5loxYEZsNszefdTDcOy4b0GkFm6o5zdDO4sBuQt3VdHBD8r9yNIHKZrJ1xd7Ja
         v9bBLT88DIzAKTQ+VmhijiVm0eIYhB74WDpbV4gcdkaAMg6QDbhGDJh/0dYsrv2W21bs
         I/CILqDEflgFYipv75OLnqiwEErPhs80uR+21l8xndESwj2OmJa7eGMiWgAaYPG1zizV
         nWsw==
X-Gm-Message-State: AKwxytfbVVlFaLDgAinN1yNl2XBUFJOZZGmBm3CuhqcfQVUOxyCkzjsB
        gN4fj4h2FhhE9TC5k2Uz8SxCHA==
X-Google-Smtp-Source: AH8x225/o0YQKR1oVpWyPk0ABtaTclkMoy3Ur9DH59N3NiQb5w1NrPY6ps9IhaYL8XsEdg3vRu8L1g==
X-Received: by 10.101.88.206 with SMTP id e14mr26281508pgu.441.1517396923517;
        Wed, 31 Jan 2018 03:08:43 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id t22sm41248254pfi.118.2018.01.31.03.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 37/41] completion: use __gitcomp_builtin in _git_rm
Date:   Wed, 31 Jan 2018 18:05:43 +0700
Message-Id: <20180131110547.20577-38-pclouds@gmail.com>
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

No new completable options!

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rm.c                           | 2 +-
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 6e0c7f5ac6..a818efe230 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -242,7 +242,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
-	OPT__FORCE(&force, N_("override the up-to-date check"), 0),
+	OPT__FORCE(&force, N_("override the up-to-date check"), PARSE_OPT_NOCOMPLETE),
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d6215c494e..e5a9f7f9b4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2698,7 +2698,7 @@ _git_rm ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp_builtin rm
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

