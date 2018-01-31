Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593F81F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753836AbeAaLHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:51 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43888 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbeAaLHs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:48 -0500
Received: by mail-pf0-f195.google.com with SMTP id y26so12238928pfi.10
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHc5i/K5ljoqEDdhUNh2/72C902meZwEIugSQH26o10=;
        b=BDwkStZ6pwuXbn7Nq1oiW1EpX94QVg63HLhu6p7c4Hlwa0R7Kz4MIwg4gLgsiVQUxy
         w/WXyw1GM6/c+rKZSIll3djt4J0CfX9Yb5nVb+fqxLRA5v6AR6ZnszLx1blH5EjTmHWY
         svkLepRLdRo+YY2BgzGSzid1eSs11Xd+7GJbFgIXillRDj5hT/VWYGu00hufKV6088re
         MOs2swoRKhIMOBCupLE5lFPwOI0TxrXWAnh+YAWs50pLFHY/hm9IssSNhGXoPPRxzO+J
         Rz/JTx0jHzfDlHYLpbmiz25vYCiE9chrlQt7eNkgCUYZSJKhMkH9abB55PlfdUc3JRTo
         NUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHc5i/K5ljoqEDdhUNh2/72C902meZwEIugSQH26o10=;
        b=qcU3WzDZgxXCf4uySP5L8+U4gbysiJi9tGdGtgQkA4Fxng2kYWx4BLb3LRZHi019EP
         jUl/m1fTkSQ7EnjBDUPt1nLG4F6Rrf/niXoLpWJKNZBrnVPPWCvtEzn+ZN1C5SmzoJNw
         Tt/oMvfoZj1cxM45dFZPO7siqFs54zDdju3NJT4S9nFlLX8txAwnTeYc82aI8nROO74C
         AwOU4oeKVEG3eedRuVzf/rx97wx9vKRepMkU+a32yJ2QlW9I3eqV/yvSXTLDqzAeTQ7Y
         cqmLXttT3tsFGPeTPGPf94Tle+MrzQ7EasXuQ7sGx0DZzLsOVxaBk1mwfCkKSW7JG7tQ
         +iqw==
X-Gm-Message-State: AKwxytdoLrLIsKgOgdC2ccrF1TC7fHEqgkJ1Oe81M/mkGJfO5EiX2JI2
        FqJeSCeTjiIrSv464E70A4hf1Q==
X-Google-Smtp-Source: AH8x227adieF7vvvoK2xGqJRv3TSSJLSfC6oTDeG59cNhlqd+pljT+PzrkMsA8uDoY+WFkJZpvKjzw==
X-Received: by 2002:a17:902:6c:: with SMTP id 99-v6mr26315247pla.409.1517396867374;
        Wed, 31 Jan 2018 03:07:47 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id z15sm26493867pgr.62.2018.01.31.03.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 24/41] completion: use __gitcomp_builtin in _git_ls_remote
Date:   Wed, 31 Jan 2018 18:05:30 +0700
Message-Id: <20180131110547.20577-25-pclouds@gmail.com>
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

The new completable options are --quiet and --upload-pack=.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/ls-remote.c                    | 5 +++--
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c4be98ab9e..540d56429f 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -60,8 +60,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-		OPT_SET_INT(0, "exit-code", &status,
-			    N_("exit with exit code 2 if no matching refs are found"), 2),
+		OPT_SET_INT_F(0, "exit-code", &status,
+			      N_("exit with exit code 2 if no matching refs are found"),
+			      2, PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "symref", &show_symref_target,
 			 N_("show underlying ref in addition to the object pointed by it")),
 		OPT_END()
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e65e71760f..f1eb37fbff 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1616,7 +1616,7 @@ _git_ls_remote ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--heads --tags --refs --get-url --symref"
+		__gitcomp_builtin ls-remote
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

