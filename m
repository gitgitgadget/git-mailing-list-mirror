Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EEFE1FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 09:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756434AbdDRJ37 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 05:29:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35309 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755785AbdDRJ3P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 05:29:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id d79so13504876wmi.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skWG0Ir5vV2iSMfz6v/MACIeJaAXnJtGAmJzmoyetjA=;
        b=UttAoMgrGU45ItBSpZLm9lvucDQ9NvelR/IcRQPZqXOzH5VfsAUusoPN3oKJ4cRVsA
         Hi3N5cgLS7dnTwaougAvpV0in5RFXJeMuBT4z4fi6a6VzAEm2RcHDfJ3Z3TE+ovMPnj8
         AnaBHlm1gVAKbm+iYVFqlcDRscEJC1EVIgmUbICFv3XLn8nsLRBlPtJo1tWko50UrN2H
         +db5GKA7bjQ9T6oWMBCIQIrOKEXu/gpkZPwTHmpqX/CI7IUyURE2txVts5qnTUeqNN85
         R6MjmQhBIgHtDTaBK/7TRN7QrZPx8pcUEy008+gp8/pOcAGkZXbFlQWtb1bKd/zdmm5T
         XisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skWG0Ir5vV2iSMfz6v/MACIeJaAXnJtGAmJzmoyetjA=;
        b=QoiMVS9LnG6mkxL4xmJSNGz5Wob5+0SHiUykf8wR0/HvlY4iayEuE0BIDCPnxDfCog
         wwLAcn4QVaA8KW8BCSZurNSWzusULElN2N4j17wHLjiNeVDw0rkDn+WkwOyOULSwWFyw
         b1xQzR8BnqJcEDDfpFqKND8vNqw/Pai/eR7tLCs+dzr3oJltwRrG1hEvupJMIOLaOmPC
         MKgTUUa+JXH9e5vMBc0nHQK5Kh/EJDr7coezcbztW1Z7YWfmPh07qKXnUctkCcH/mmx7
         5mS04AkOIUPupziXHpNSwueuxNoQnNX1InrfgewflvrSwbbEQHRaeBU9MXv7BYc+WoU0
         4pYQ==
X-Gm-Message-State: AN3rC/5T5pEZdc6b/sQifTQtUCgSo4iSkBivOuCrFJZgO03KgQSieMOM
        nf/2wom932UhHA==
X-Received: by 10.28.31.200 with SMTP id f191mr12299587wmf.63.1492507754084;
        Tue, 18 Apr 2017 02:29:14 -0700 (PDT)
Received: from localhost ([193.206.223.117])
        by smtp.gmail.com with ESMTPSA id m21sm14080739wma.19.2017.04.18.02.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Apr 2017 02:29:13 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v4 3/3] rebase: pass --[no-]signoff option to git am
Date:   Tue, 18 Apr 2017 11:29:05 +0200
Message-Id: <20170418092905.20097-4-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.820.g78c033c3a1.dirty
In-Reply-To: <20170418092905.20097-1-giuseppe.bilotta@gmail.com>
References: <20170418092905.20097-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easy to sign off a whole patchset before submission.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-rebase.txt |  5 +++++
 git-rebase.sh                |  3 ++-
 t/t3428-rebase-signoff.sh    | 46 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100755 t/t3428-rebase-signoff.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 67d48e6883..53f4e14444 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -370,6 +370,11 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 	of the rebased commits (see linkgit:git-am[1]).
 	Incompatible with the --interactive option.
 
+--signoff::
+	This flag is passed to 'git am' to sign off all the rebased
+	commits (see linkgit:git-am[1]). Incompatible with the
+	--interactive option.
+
 -i::
 --interactive::
 	Make a list of the commits which are about to be rebased.  Let the
diff --git a/git-rebase.sh b/git-rebase.sh
index 48d7c5ded4..db1deed846 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,6 +34,7 @@ root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -i
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
+signoff            passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
@@ -321,7 +322,7 @@ do
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date)
+	--committer-date-is-author-date|--ignore-date|--signoff|--no-signoff)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
new file mode 100755
index 0000000000..2afb564701
--- /dev/null
+++ b/t/t3428-rebase-signoff.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='git rebase --signoff
+
+This test runs git rebase --signoff and make sure that it works.
+'
+
+. ./test-lib.sh
+
+# A simple file to commit
+cat >file <<EOF
+a
+EOF
+
+# Expected commit message after rebase --signoff
+cat >expected-signed <<EOF
+first
+
+Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
+EOF
+
+# Expected commit message after rebase without --signoff (or with --no-signoff)
+cat >expected-unsigned <<EOF
+first
+EOF
+
+
+# We configure an alias to do the rebase --signoff so that
+# on the next subtest we can show that --no-signoff overrides the alias
+test_expect_success 'rebase --signoff adds a sign-off line' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	git add file && git commit -m first &&
+	git config alias.rbs "rebase --signoff" &&
+	git rbs HEAD^ &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	test_cmp expected-signed actual
+'
+
+test_expect_success 'rebase --no-signoff does not add a sign-off line' '
+	git commit --amend -m "first" &&
+	git rbs --no-signoff HEAD^ &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	test_cmp expected-unsigned actual
+'
+
+test_done
-- 
2.12.2.820.g78c033c3a1.dirty

