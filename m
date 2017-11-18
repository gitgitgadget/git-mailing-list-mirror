Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0EB2036D
	for <e@80x24.org>; Sat, 18 Nov 2017 22:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423813AbdKRWpo (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 17:45:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46787 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937793AbdKRWpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 17:45:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id u83so3968911wmb.5
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hcBIHSi4zpZF45c47IcD4O4ABpDljMt1UQ0U5i3hp1Q=;
        b=FJJvpY0SU/AZ3p/ou2a0LXOFHV2N1SENnCXgmmQqdTVkP0Xc6D8CyX8lLDoNd4YNQB
         9LZmPLugghBcTezmVrtNyUG/ZMYSslxrye6EJBjw1M4z/EnhUHiSSrU4JrnE6m5a1K6k
         rLax6BWNUH6NeWSEPDGjGiy/kWbyw7/CTovfzLPgWUaOz0e/iAo05maxh1bk0SJv0ReE
         f8x8Xk59ts4b/ASSB7vIEWnKJBDkcs0ZrKNQFrb+g2IreyHHe2+NwtF1/8esVO28y6Qy
         C3/9pQ9CmHI4Pow5ry1aFAInqZVK2gYijOGcPwOd4S3+8u6ufgmbQwzmYQOBMA/txhP4
         0W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hcBIHSi4zpZF45c47IcD4O4ABpDljMt1UQ0U5i3hp1Q=;
        b=aoUXo63H2+FbxODeAajJfThV89zhwYTjl287g+EzNh1uLq+7Mp0PApjSipz2sSSBJY
         o5ryk+dTm+VEbXMEwljVPUrFc+JPVOnAl5CLh6SJZCGBTCxMyI4atbC77FEcrDEFina7
         mQkB946ygIzqq1jAam2dLlcc09/8sbbxLayLoTIU1AN9+LEg6LCh2eqyo6KWsy3otTfR
         VHrM+BJclUaU9CWTqhm3H24nWeWd9Ouo02N7l/uNakuPuCJK3quMa1YwvAjQ4pUkqDsN
         MX/06rRe4ksKESLr++ti7dakNL94FGXKOJ09DYy6LDxzgPszj3LbQBpdklYJPBVesxkF
         MkNA==
X-Gm-Message-State: AJaThX6oJinyKyqWj1ElcSr99VXoHRNxyUgTQwznGXCeIZzgNf1OWapr
        GgWZQ10InTSxnbvfCCq+Pwih2bDd
X-Google-Smtp-Source: AGs4zMaDV3SMPnW7MP0jZJJveR5aOGMnGDHnPc07ZKDai5EzMTwP7fJWm0L+t9hJbbesSa7pCCavDg==
X-Received: by 10.28.84.89 with SMTP id p25mr6377246wmi.112.1511045141249;
        Sat, 18 Nov 2017 14:45:41 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d17sm232671wrc.14.2017.11.18.14.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Nov 2017 14:45:40 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/3] make git worktree add dwim more
Date:   Sat, 18 Nov 2017 22:47:03 +0000
Message-Id: <20171118224706.13810-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171118181103.28354-1-t.gummerer@gmail.com>
References: <20171118181103.28354-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry about the noise with v2 and v3 so quickly one after another.  I
only too late realized that the new dwim for 'add <path> <branch>'
doesn't make much sense if -b or --detach are given, and it's better
to keep on erroring out in these cases.

The previous rounds were at https://public-inbox.org/git/20171112134305.3949-1-t.gummerer@gmail.com/
and https://public-inbox.org/git/20171118181103.28354-1-t.gummerer@gmail.com/.

In case anybody already started reading v2, an interdiff between the
two versions is below:

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 11cac104d9..eedead2c4c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -52,9 +52,9 @@ is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<branch>`; it is synonymous with `@{-1}`.
 +
-If <branch> is not found but there does exist a tracking branch in
-exactly one remote (call it <remote>) with a matching name, treat as
-equivalent to
+If <branch> is not found, and neither `-b` nor `-B` nor `--detach` are
+used, but there does exist a tracking branch in exactly one remote
+(call it <remote>) with a matching name, treat as equivalent to
 ------------
 $ git worktree add -b <branch> <path> <remote>/<branch>
 ------------
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 82088415b8..b2a6dd020c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -396,7 +396,7 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	if (ac == 2) {
+	if (ac == 2 && !opts.new_branch && !opts.detach) {
 		struct object_id oid;
 		struct commit *commit;
 		const char *remote;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index a566d867fe..87e233f812 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -347,6 +347,8 @@ test_expect_success '"add" <path> <branch> dwims' '
 		git config remote.repo_upstream.fetch \
 			  "refs/heads/*:refs/remotes/repo_upstream/*" &&
 		git fetch --all &&
+		test_must_fail git worktree add -b foo ../foo foo &&
+		test_must_fail git worktree add --detach ../foo foo &&
 		git worktree add ../foo foo
 	) &&
 	(

Thomas Gummerer (3):
  checkout: factor out functions to new lib file
  worktree: make add <path> <branch> dwim
  worktree: make add <path> dwim

 Documentation/git-worktree.txt |  22 +++++++--
 Makefile                       |   1 +
 builtin/checkout.c             |  41 +---------------
 builtin/worktree.c             |  24 ++++++++++
 checkout.c                     |  42 ++++++++++++++++
 checkout.h                     |  13 +++++
 t/t2025-worktree-add.sh        | 106 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 206 insertions(+), 43 deletions(-)
 create mode 100644 checkout.c
 create mode 100644 checkout.h

-- 
2.15.0.345.gf926f18f3
