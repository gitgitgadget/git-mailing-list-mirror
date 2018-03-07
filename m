Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D992D1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 01:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeCGBFf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 20:05:35 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33741 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932613AbeCGBFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 20:05:32 -0500
Received: by mail-pl0-f66.google.com with SMTP id c11-v6so376429plo.0
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 17:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kao9Q5/jTVcJsDI3hOwUypJVGg5d+V99RsP1VmeLxR4=;
        b=HrgBSn7mYC5Rlv6C6J4sCtwgXiKI9f56UTx426QdyRwmlo7oNe4AtWnQ8e5vSWCxHA
         WHPeeAve+FjK1P9BKegLQWepdPe9YkOMnBOhnzgikBJSvHDoprK3PenM2PymnzfL/9W5
         GxLo9+Vp8z1+OIDrQCl1OMCpXVkr2f1fxpLR3oJHJfePYnxvTeVozGzj1+q9Pg4iCN3D
         Pdla0WCV3g3ddhkCJ4UIxp6QSxhqXDdLTmPH3dYLUwZ331xcc5Jt14q+FI1zEyc/791N
         ZNMLgB0y+Ug5LSYeI+MImMK2IgHn9B2lJn6f5HZ1jDWVRGj3+IKNsCFZMWYur9Mpzovl
         rwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kao9Q5/jTVcJsDI3hOwUypJVGg5d+V99RsP1VmeLxR4=;
        b=JT1sASnIRkozTyVJmYOTScfvTEq2togC1pzB+Vsq8ZQxPANXlEZZZZu8maXmr50dwh
         5GoeUm49SfJCayl8Rqpn/9IvoGrL1giwo5lQ7JG4e0aeIu7FQmbJzAs7ZdJLTDb6uSdc
         EoQvDx9CgE1V3GTo53Q8Ch3o/HnzkwTJaJMpDjvbUXGLcMo3m/+AU+0P9F2scAhMGsKI
         mEIuKf8hdt0dy5gQartdSIfrBKEWeSWzO+8ilCFG0QQPUh3jMJtC9UPP6YKipzvcihTg
         OrESCZM/+CD2PtTfK8We8pm2R+tsFCpd3n9XofHa8almSHc5dS2KN2J1vq/yuau4+vWr
         XLGg==
X-Gm-Message-State: APf1xPDIm/+PEcqqke7ZTQqewunvQS647Q/pBN57TnY3OG1d2S60tRUP
        sUsCJY7+eOz8w2d/7XsOL3A=
X-Google-Smtp-Source: AG47ELt9rvwwwURjg5IJmdCN5aX8IuV8X40oPv2E9N+7g7L6xm/aEaS0XMtGV1kgiPICVC1cxJJSpQ==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2-v6mr18332480plb.12.1520384732286;
        Tue, 06 Mar 2018 17:05:32 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p10sm27664133pgd.28.2018.03.06.17.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 17:05:31 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        phillip.wood@talktalk.net
Subject: [PATCH v2 1/4] completion: don't set PARSE_OPT_NOCOMPLETE on --rerere-autoupdate
Date:   Wed,  7 Mar 2018 08:05:01 +0700
Message-Id: <20180307010504.9289-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.785.g429c04a1b9
In-Reply-To: <20180307010504.9289-1-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com>
 <20180307010504.9289-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is not a strong reason to hide this option, and git-merge already
completes this one. Let's allow to complete this for all commands (and
let git-completion.bash do the suppressing if needed).

This makes --rerere-autoupdate completable for am, cherry-pick and
revert. rebase completion is fixed manually because it's a shell
script and does not benefit from --git-completion-helper.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 parse-options.h                        | 4 ++--
 rerere.h                               | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0ddf40063b..0d858cacce 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1754,8 +1754,7 @@ _git_merge ()
 
 	case "$cur" in
 	--*)
-		__gitcomp_builtin merge "--rerere-autoupdate
-				--no-rerere-autoupdate
+		__gitcomp_builtin merge "--no-rerere-autoupdate
 				--no-commit --no-edit --no-ff
 				--no-log --no-progress
 				--no-squash --no-stat
@@ -1963,6 +1962,7 @@ _git_rebase ()
 			--autostash --no-autostash
 			--verify --no-verify
 			--keep-empty --root --force-rebase --no-ff
+			--rerere-autoupdate
 			--exec
 			"
 
diff --git a/parse-options.h b/parse-options.h
index 0ba08691e6..ab1cc362bf 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -148,8 +148,8 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
-#define OPT_UYN(s, l, v, h, f)      { OPTION_CALLBACK, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG|(f), &parse_opt_tertiary }
+#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
 	  parse_opt_approxidate_cb }
diff --git a/rerere.h b/rerere.h
index 5e5a312e4c..c2961feaaa 100644
--- a/rerere.h
+++ b/rerere.h
@@ -37,7 +37,6 @@ extern void rerere_clear(struct string_list *);
 extern void rerere_gc(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
-	N_("update the index with reused conflict resolution if possible"), \
-	PARSE_OPT_NOCOMPLETE)
+	N_("update the index with reused conflict resolution if possible"))
 
 #endif
-- 
2.16.2.785.g429c04a1b9

