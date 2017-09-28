Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE9420A10
	for <e@80x24.org>; Thu, 28 Sep 2017 22:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdI1Wbn (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 18:31:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35327 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdI1Wbm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 18:31:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id n64so3391760wrb.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TR0m+8oBhwaza/ytYEhsblywiZQSIHwpRV85YhrsvCg=;
        b=GldSgVygzF91IxBSt1swF1b3vzJon1h6qPdcbpM6nuErLzBTwfP+HOyKnml1q2hUvs
         4Njd47eA+8gas6x6T84gcPYPhR0eCJALWIhm/ZtFL8HaD0qVn6KAztkB1hyWlqx1eiAe
         tRgWMqB1+kK/+d+xMHWRlG7d3+PNxS4onBVP+NiEiiEUWOWfU2OQGfKg13IdA2KbxG8Z
         jmEj7/uKedON1NMYQyai6A7PE/+En8avquk+aeksh0aq6MvaO4CAu23PwjHZbmC+Poel
         o+GV0C5d91nxuwlKkJZwOOGWN5wn+aVxbqwHdh2TDTYWG56y6voeIOFhywCtdGNxMwZb
         VxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TR0m+8oBhwaza/ytYEhsblywiZQSIHwpRV85YhrsvCg=;
        b=jq7efEiVtCutv+Xc/LOLxfa9B7OpkIn7VaNe8YZfqJun9wQLG8EW/kgdFLITuN5rVr
         iZMGv5zaZu1FhvfsyqoqB9aGNS+2EPicvbkmY+NYR5qRDvmMwridJnKjqzgmegbVUr2G
         E1LegH99W2tWWFY47ODKnM/0LnRjh61RCqg+yQ2vLwVXDGUCdQ18Gudv/Fombm4BowXz
         GgSmwn6U0G5rCXvnskmpAw4uTIK+j54OD7bgsI4XKRMmAabE9j1G0suy6LPFSvfngzVf
         BonORl9cezeyvRT7EhIdFIIMU4rAIJKacVTm6C/EguvBAryuNaL4g5iz9yBYMEkAoKJx
         U92A==
X-Gm-Message-State: AHPjjUiOyYGeYIDwDLz2qowW25cs/QQA493IdTzQhQ5sQFJJ7EReomtT
        z9T33T7ixzqIL4G6Mexzc7kg8pcF
X-Google-Smtp-Source: AOwi7QAau47Vs3nPNDggfEhoU+X2ESaBhDHXmAcK8n+t8WKlS1VBLcQ0TSmTkPeoWv7tL2/3sjgpzg==
X-Received: by 10.223.164.71 with SMTP id e7mr5632803wra.4.1506637900632;
        Thu, 28 Sep 2017 15:31:40 -0700 (PDT)
Received: from varnish ([92.184.97.102])
        by smtp.gmail.com with ESMTPSA id 69sm2547262wmp.11.2017.09.28.15.31.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Sep 2017 15:31:39 -0700 (PDT)
Date:   Fri, 29 Sep 2017 00:31:34 +0200
From:   Dridi Boukelmoune <dridi.boukelmoune@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] git-sh: Avoid sourcing scripts with git --exec-path
Message-ID: <20170928223134.GA30744@varnish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.0 (2017-09-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For end users making use of a custom exec path many commands will simply
fail. Adding git's exec path to the PATH also allows overriding git-sh-*
scripts, not just adding commands. One can then patch a script without
tainting their system installation of git for example.

Signed-off-by: Dridi Boukelmoune <dridi.boukelmoune@gmail.com>
---

Hi,

I've been bothered by this problem ever since I upgraded my system to
Fedora 26, and I grew tired of locally patching git-sh-setup after every
git-core update. So I decided to look at the instructions on how to send
patches to the Git project, and here is my first patch.

I hope you will find it appropriate, I didn't study the test suite to
have it enforce that files shouldn't be sourced from the "system"
installation. I couldn't reproduce it after a quick look, and I'm not
familiar enough to tinker with it yet, so I reached my trial&error quota
before I could figure things out.

Best Regards,
Dridi

 Documentation/CodingGuidelines            | 22 ++++++++++++++++++++++
 contrib/convert-grafts-to-replace-refs.sh |  3 ++-
 contrib/rerere-train.sh                   |  3 ++-
 contrib/subtree/git-subtree.sh            |  1 -
 git-sh-setup.sh                           |  2 +-
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c4cb5ff0d..fdc0d3318 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -151,6 +151,28 @@ For shell scripts specifically (not exhaustive):
    interface translatable. See "Marking strings for translation" in
    po/README.
 
+ - When sourcing a "git-sh-*" file using "git --exec-path" make sure
+   to only use its base name.
+
+	(incorrect)
+	. "$(git --exec-path)/git-sh-setup"
+
+	(correct)
+	. git-sh-setup
+
+   Otherwise for a user with a custom "GIT_EXEC_PATH=/foo" the shell
+   expects "/foo:/usr/libexec/git-core/git-sh-setup" or something
+   similar depending on the installation. The git command already
+   adds the git exec path to the regular path before executing a
+   command.
+
+   For scripts that aren't run via the git command, add the git exec
+   path to the path instead.
+
+	(correct)
+	PATH="$(git --exec-path):$PATH"
+	. git-sh-setup
+
  - We do not write our "test" command with "-a" and "-o" and use "&&"
    or "||" to concatenate multiple "test" commands instead, because
    the use of "-a/-o" is often error-prone.  E.g.
diff --git a/contrib/convert-grafts-to-replace-refs.sh b/contrib/convert-grafts-to-replace-refs.sh
index 0cbc917b8..f7d2fab03 100755
--- a/contrib/convert-grafts-to-replace-refs.sh
+++ b/contrib/convert-grafts-to-replace-refs.sh
@@ -5,7 +5,8 @@
 
 GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
 
-. $(git --exec-path)/git-sh-setup
+PATH="$(git --exec-path):$PATH"
+. git-sh-setup
 
 test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
 
diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 52ad9e41f..07bad67e6 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -7,7 +7,8 @@ USAGE="$me rev-list-args"
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
-. "$(git --exec-path)/git-sh-setup"
+PATH="$(git --exec-path):$PATH"
+. git-sh-setup
 require_work_tree
 cd_to_toplevel
 
diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dec085a23..1d61f75d0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -32,7 +32,6 @@ squash        merge subtree changes as a single commit
 "
 eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
 
-PATH=$PATH:$(git --exec-path)
 . git-sh-setup
 
 require_work_tree
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 378928518..12e1220f8 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -44,7 +44,7 @@ git_broken_path_fix () {
 # @@BROKEN_PATH_FIX@@
 
 # Source git-sh-i18n for gettext support.
-. "$(git --exec-path)/git-sh-i18n"
+. git-sh-i18n
 
 die () {
 	die_with_status 1 "$@"
-- 
2.13.5

