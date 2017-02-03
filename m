Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A815F1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbdBCCtg (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35141 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbdBCCte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:34 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so1170501wmu.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJ+Zkg4fbYJyqL2zzu/T6IMLZVrtHj/P/iD20jjy79o=;
        b=hkIXdQI4QvJpYc9Oh+MHxjBU/yR+p7/wjTS9L8wubkT87ENXxedcgCAxjjzEaEaGTx
         m6Cp4Ok9ohtgAzfynl+zj1yAmaSElUyEmrR+tCI/hGCIisvuGZVMLKomOsXVFMXZ0umK
         yIH3TQcVf+FrwF3R0DDF2wEuo72/YzGnRT+Dp0FZ8RotSTbTc8WvBwF2qFPqtaIVD2oT
         a35gtap+ZwAaepTrfjhHF5fXIODlzRObdYgjEfwAtTIqsBpImTg35B3stVhJSCieTYdi
         eap76KV5tMdIqB3xq41vbaARh6qk2YlUquB2uUphFSd0hIkfu/UQ7ACbEgIKM3HAk0Ni
         pWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJ+Zkg4fbYJyqL2zzu/T6IMLZVrtHj/P/iD20jjy79o=;
        b=hKPHxGMHfxCjZcrWEfnSYxKSRWdSORh0WQXzatxRwvxa39w/1Ll/xCLep+MZMeyWH3
         kQYSo6926PDWHl0r4VzWgEclM4vxLE2ZKtpDZQXZilRjBgvAcCxSzdLQvv3lIyRqeMi+
         8WrpzaCSf/xeCRrCcGEPWQWRyeoBdQeMPXGaBivVY+KhYLxkZMPxeYhbwhATw35g1IRr
         tTrkq8gLIkrDgSMZXMdJ4uKMrcUlIQhOBAQW6nG4qCr/NuqucBZ84HAFefc0LmEZGjpT
         J8yk8XHKLzXW+wnlg/Uw7EAlVnIp7Vll5pcLnGmQFjKCDRDAfJDdoYq6KqLXsk7hlBei
         ygQQ==
X-Gm-Message-State: AIkVDXKmg3FG3gu/A5rfnUp3lip/1w7nUURlgQimwPmZCsxH/xt9mUWtGDHgMlzSad1Ydg==
X-Received: by 10.223.163.81 with SMTP id d17mr9932482wrb.93.1486090162648;
        Thu, 02 Feb 2017 18:49:22 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:21 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 10/21] completion: list refs from remote when remote's name matches a directory
Date:   Fri,  3 Feb 2017 03:48:18 +0100
Message-Id: <20170203024829.8071-11-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the remote given to __git_refs() happens to match both the name of
a configured remote and the name of a directory in the current working
directory, then that directory is assumed to be a git repository, and
listing refs from that directory will be attempted.  This is wrong,
because in such a situation git commands (e.g. 'git fetch|pull|push
<remote>' whom these refs will eventually be passed to) give
precedence to the configured remote.  Therefore, __git_refs() should
list refs from the configured remote as well.

Add the helper function __git_is_configured_remote() that checks
whether its argument matches the name of a configured remote.  Use
this helper to decide how to handle the remote passed to __git_refs().

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 20 ++++++++++++++++++--
 t/t9902-completion.sh                  | 11 ++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7d7e8b9d9..fd0ba1f3b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -347,12 +347,16 @@ __git_refs ()
 	local format refs pfx
 
 	if [ -n "$remote" ]; then
-		if [ -d "$remote/.git" ]; then
+		if __git_is_configured_remote "$remote"; then
+			# configured remote takes precedence over a
+			# local directory with the same name
+			list_refs_from=remote
+		elif [ -d "$remote/.git" ]; then
 			dir="$remote/.git"
 		elif [ -d "$remote" ]; then
 			dir="$remote"
 		else
-			list_refs_from=remote
+			list_refs_from=url
 		fi
 	fi
 
@@ -435,6 +439,18 @@ __git_remotes ()
 	git --git-dir="$d" remote
 }
 
+# Returns true if $1 matches the name of a configured remote, false otherwise.
+__git_is_configured_remote ()
+{
+	local remote
+	for remote in $(__git_remotes); do
+		if [ "$remote" = "$1" ]; then
+			return 0
+		fi
+	done
+	return 1
+}
+
 __git_list_merge_strategies ()
 {
 	git merge -s help 2>&1 |
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6e64cd6ba..a201b5212 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -373,6 +373,15 @@ test_expect_success '__git_remotes - list remotes from $GIT_DIR/remotes and from
 	test_cmp expect actual
 '
 
+test_expect_success '__git_is_configured_remote' '
+	test_when_finished "git remote remove remote_1" &&
+	git remote add remote_1 git://remote_1 &&
+	test_when_finished "git remote remove remote_2" &&
+	git remote add remote_2 git://remote_2 &&
+	verbose __git_is_configured_remote remote_2 &&
+	test_must_fail __git_is_configured_remote non-existent
+'
+
 test_expect_success 'setup for ref completion' '
 	git commit --allow-empty -m initial &&
 	git branch matching-branch &&
@@ -516,7 +525,7 @@ test_expect_success '__git_refs - configured remote - full refs - repo given on
 	test_cmp expected "$actual"
 '
 
-test_expect_failure '__git_refs - configured remote - remote name matches a directory' '
+test_expect_success '__git_refs - configured remote - remote name matches a directory' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
-- 
2.11.0.555.g967c1bcb3

