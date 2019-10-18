Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0707F1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 14:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393734AbfJROA5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 10:00:57 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:52889 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393182AbfJROA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 10:00:57 -0400
Received: from localhost.localdomain ([92.30.121.54])
        by smtp.talktalk.net with SMTP
        id LSoJicsvqgI7iLSoJi6hhs; Fri, 18 Oct 2019 15:00:55 +0100
X-Originating-IP: [92.30.121.54]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=/cLN2YrzNMz5fcHgWq8JfQ==:117
 a=/cLN2YrzNMz5fcHgWq8JfQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10
 a=T55LNRSU53l9ut4ZAHwA:9 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2] t/README: the test repo does not have global or system configs
Date:   Fri, 18 Oct 2019 15:00:49 +0100
Message-Id: <20191018140049.2183-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.23.0.windows.1.21.g947f504ebe8.dirty
In-Reply-To: <dc8afd1b-2e69-e54d-aee9-e5d6c4b729f5@iee.email>
References: <dc8afd1b-2e69-e54d-aee9-e5d6c4b729f5@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfB+pqlTdKJtgBG6P/kv22tUhYM9OaomObvK7XEu7GpXlf6PHT0kcakjThcf6EqbajYXqyoT5RFhfate8eyTZPoYuwaqshigb8hOzKybrv4kdGy4lCh/e
 MntYH+j/ET2dS1t6TTg0O7us+S8/2ZWqWeoqwIjMfMJoS7Ddvm4TmhZ4Aw1ZiefZ9lVQN674FQ64/OsmXtKAO7stRoN3HSWEuxU7hTpqiAtdNwK34nXrsjF5
 /vEPhngQdxZ1ahmnAMpeDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, fix minor wording mistake in referenced config section.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
The basic --local config also doesn't appear to be well defined here.
test-lib.sh sets GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
If no config template then..? e.g. G-F-W
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
---
 Documentation/git-config.txt | 2 +-
 t/README                     | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 899e92a1c9..d4c792076d 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -107,7 +107,7 @@ OPTIONS
 	For writing options: write to global `~/.gitconfig` file
 	rather than the repository `.git/config`, write to
 	`$XDG_CONFIG_HOME/git/config` file if this file exists and the
-	`~/.gitconfig` file doesn't.
+	`~/.gitconfig` file if it doesn't.
 +
 For reading options: read only from global `~/.gitconfig` and from
 `$XDG_CONFIG_HOME/git/config` rather than from all available files.
diff --git a/t/README b/t/README
index 60d5b77bcc..71946902d7 100644
--- a/t/README
+++ b/t/README
@@ -485,6 +485,13 @@ This test harness library does the following things:
    the --root option documented above, and a '.stress-<N>' suffix
    appended by the --stress option.
 
+ - The test framework sets GIT_CONFIG_NOSYSTEM=1, thus ignoring any
+   --system config files. The --global config is redirected through
+   the environment variables. It unsets the $XDG_CONFIG_HOME variable
+   and sets HOME="$TRASH_DIRECTORY" for the tests.
+   A basic --local config is created in the test repository.
+   See linkgit:git-config[1].
+
  - Defines standard test helper functions for your scripts to
    use.  These functions are designed to make all scripts behave
    consistently when command line arguments --verbose (or -v),
-- 
2.23.0.windows.1.21.g947f504ebe8.dirty

