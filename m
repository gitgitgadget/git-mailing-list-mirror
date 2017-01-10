Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEDC205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 11:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966032AbdAJLd5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 06:33:57 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35412 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966015AbdAJLd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 06:33:56 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so9702724pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 03:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PN6fqJ4kQYek8iA4AOsxWU5AwG22LDIVyb9Jjl9h+Uk=;
        b=WROI92a1asjWyO/yYSZE9SLXhu0FCeiNY1rc/5H4hvIz9D6o3OScH+bbcu9fHUBChK
         nFcTcVX6HGW6twYemYqF0MbdT1xQuaDEpLMxReYmX7b0MufKPoqOhgMk1AIra75Q4/Jy
         K8dlV3/ATPNhnLap46d0EW1jAUfg1nQnPeR3PoNHVY8K6XUaj6bNYiytzWxt+VfBH2+X
         kw2rcIhIKGMwvTd7kXRIpfVwlPvSKI95loCyj4JiEIDBCkf+LP3FL6De1ZQRrM+WOE4z
         3k7/AowquSFptaMKZOEIM9gK+B1P49++EAK44Fnm8ZAmSgYhmZ1oQq2zZKbKNaLIaa1K
         f3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PN6fqJ4kQYek8iA4AOsxWU5AwG22LDIVyb9Jjl9h+Uk=;
        b=nzbS+M3k3Rwh4LBxf20s2XcMNoJFHMDtwBBDKE9UnciDmgsqGQeFf+EthRChECA4zD
         Akvd/oINasTOnyPjuc+kqunWE4r+Plg1XrwJS4JheSnr9f7bvt+qu7LD5RGrKA0JyUsH
         eJyiuZGvVdVudsj3EEtdcwFAAL6numY9/aDVpjjFB8mVSmPsevZAnZVe1W1AfEQ93vLd
         B7O6y+73i72nypiYTUmtT1XogaggMZUd8jIVjAbF2/da2k2FB+AFgFl/6Q5ASZjaL/d3
         Vsqi6jRfcSLXAZ/QfVP6vEf2ZccOaaW0DP53gZyTaKyqRooEWvDskqcOQnw/jE477wzO
         eC6Q==
X-Gm-Message-State: AIkVDXK6b/z7ZxNxixS7Kz7khdB4+66dImv5/TQhzfjYzOrMzsCGmIaThU0Jw8AG5u5kMg==
X-Received: by 10.99.222.85 with SMTP id y21mr3386807pgi.119.1484048035682;
        Tue, 10 Jan 2017 03:33:55 -0800 (PST)
Received: from ash ([115.73.174.142])
        by smtp.gmail.com with ESMTPSA id j130sm5040308pgc.2.2017.01.10.03.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 03:33:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 10 Jan 2017 18:33:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 5/4] Redefine core.bare in multiple working tree setting
Date:   Tue, 10 Jan 2017 18:33:20 +0700
Message-Id: <20170110113320.13119-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170110112524.12870-1-pclouds@gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When core.bare was added, time was simpler, we only had one worktree
associated to one repository. The situation gets a bit complicated when
multiple worktrees are added. If core.bare is set in the per-repo config
file, should all worktrees see this variable?

Since core.bare affects worktree-related commands (e.g. you are not
supposed to run "git status" when core.bare is true because no worktree
is supposed to link to the repository), when multi worktree is added,
core.bare is evaluated true by the main worktree only. Other worktrees
simply do not see core.bare even if it's there.

With per-worktree configuration in place, core.bare is moved to main
worktree's private config file. But it does not really make sense
because this is about _repository_. Instead we could leave core.bare in
the per-repo config and change/extend its definition from:

   If true this repository is assumed to be 'bare' and has no working
   directory associated with it.

to

   If true this repository is assumed to be 'bare' and has no _main_
   working directory associated with it.

In other words, linked worktrees are not covered by core.bare. This
definition is the same as before when it comes to single worktree setup.

A plus of this definition is, it allows a setup where we only have
linked worktrees (e.g. core.bare set to true, and the main repo is
tucked somewhere safe), which makes all worktrees equal again because
"the special one" is gone.

This patch is incomplete. I need to go through all is_bare_repository()
calls and adjust their behavior. But I wanted to run the idea through
the community first..

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt       | 2 +-
 Documentation/git-worktree.txt | 7 +++----
 t/t2029-worktree-config.sh     | 4 ++--
 worktree.c                     | 6 ------
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c508386..ff146be 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -484,7 +484,7 @@ core.preferSymlinkRefs::
 	expect HEAD to be a symbolic link.
 
 core.bare::
-	If true this repository is assumed to be 'bare' and has no
+	If true this repository is assumed to be 'bare' and has no main
 	working directory associated with it.  If this is the case a
 	number of commands that require a working directory will be
 	disabled, such as linkgit:git-add[1] or linkgit:git-merge[1].
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index f5aad0a..a331d0a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -161,7 +161,7 @@ them to the `config.worktree` of the main working directory. You may
 also take this opportunity to move other configuration that you do not
 want to share to all working directories:
 
- - `core.worktree` and `core.bare` should never be shared
+ - `core.worktree` should never be shared
 
  - `core.sparseCheckout` is recommended per working directory, unless
    you are sure you always use sparse checkout for all working
@@ -169,9 +169,8 @@ want to share to all working directories:
 
 When `git config --worktree` is used to set a configuration variable
 in multiple working directory setup, `extensions.worktreeConfig` will
-be automatically set. The two variables `core.worktree` and
-`core.bare` if present will be moved to `config.worktree` of the main
-working tree.
+be automatically set. The variable `core.worktree` if present will be
+moved to `config.worktree` of the main working tree.
 
 DETAILS
 -------
diff --git a/t/t2029-worktree-config.sh b/t/t2029-worktree-config.sh
index 4ebdf13..dc84c94 100755
--- a/t/t2029-worktree-config.sh
+++ b/t/t2029-worktree-config.sh
@@ -70,13 +70,13 @@ test_expect_success 'config.worktree no longer read without extension' '
 	cmp_config -C wt2 shared this.is
 '
 
-test_expect_success 'config --worktree migrate core.bare and core.worktree' '
+test_expect_success 'config --worktree migrate core.worktree' '
 	git config core.bare true &&
 	git config --worktree foo.bar true &&
 	cmp_config true extensions.worktreeConfig &&
 	cmp_config true foo.bar &&
 	cmp_config true core.bare &&
-	! git -C wt1 config core.bare
+	cmp_config -C wt1 true core.bare
 '
 
 test_done
diff --git a/worktree.c b/worktree.c
index d8c9d85..c07cc50 100644
--- a/worktree.c
+++ b/worktree.c
@@ -395,12 +395,6 @@ void migrate_worktree_config(void)
 	read_repository_format(&format, main_path.buf);
 	assert(format.worktree_config == 0);
 
-	if (format.is_bare >= 0) {
-		git_config_set_in_file(worktree_path.buf,
-				       "core.bare", "true");
-		git_config_set_in_file(main_path.buf,
-				       "core.bare", NULL);
-	}
 	if (format.work_tree) {
 		git_config_set_in_file(worktree_path.buf,
 				       "core.worktree",
-- 
2.8.2.524.g6ff3d78

