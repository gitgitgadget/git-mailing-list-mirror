Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D719DC7EE23
	for <git@archiver.kernel.org>; Thu,  4 May 2023 03:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjEDDzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 23:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEDDzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 23:55:41 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31C1BDB
        for <git@vger.kernel.org>; Wed,  3 May 2023 20:55:22 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1928ec49077so64138fac.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683172520; x=1685764520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZSLAKHWer7nFNBOl42FlNGvPLQ708P88NQ4mPieDiQ=;
        b=UeONh/SiaDLCEa14BBBh/deN0/h6sYSZyQK7B+1e/WHi6zS1PP7yLZr3bee+DRJ54A
         kLHkxJUiBXk/vkFdTQhSPmKWeD21u4Vf9n2BgKav4J9eeAKm7s0BTdpPx5EyyG1vEACP
         yO34tcw3yujiuFqDiRTO4tYVnlZh+l6r2IKFWjSGo70/anwVtOq6rjeTW42doFJHq3eh
         J5iVbKgmjYDkipMUJ8oWNqb9HB1FrLOH2IfiKxQ4LoruCNDxOxx72X4s2BpPE9abKNka
         nWg102IVONjYTSuAqpx9chjxEscaOCv07L06il9IgzW+fbSBhuk8ny/tHX5cPiW/r4hV
         +DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683172520; x=1685764520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZSLAKHWer7nFNBOl42FlNGvPLQ708P88NQ4mPieDiQ=;
        b=BTuH8XIpEpxwdqXOiL/fHod0uUpbX8SWlpn0h/sSaesVqGvA68Ik3fTlpGHMF+RNJ7
         Jf7AU91T735okGww2skMRhdqb9kTpNNapKwOEp2oeQ7kXSl/ESccIASXx/XGCUi/hM3F
         b4CFGhBS3SPHoFFaJ9pFtEsuMH6DDPsMMUvHMmskKxPUqXol0qH+1D58gaUziqIzuMUb
         1CwCwcEQ2Va2KvlDFJ9NZQjVdUwFcp1Eo3T8e4ESdPPWXstLMiJiCxPuSZGVTHPHcWVM
         IQ0MfZIQVacsGCqsVe9/W0PANsAohuwC2ts6sAASX3pxt596EEblmMu15mgLnURdB72U
         /mvg==
X-Gm-Message-State: AC+VfDyzJJ9vTgGhbVj58J9He5GikA1cJKK1fTjNz8Udt/jsbJUD1iAi
        j/+Ah6tC567k5Ou7VqMQ9JNrpw5Lixk=
X-Google-Smtp-Source: ACHHUZ6HUIkKnSF5q5gOvLOqXKn9zkjtM2rlFEfNUNN7AZwLcZOqqQ0H0Ww/67/mqEtVgwzaXYmKLA==
X-Received: by 2002:a05:6870:9446:b0:17a:aca4:f3db with SMTP id e6-20020a056870944600b0017aaca4f3dbmr374972oal.34.1683172520248;
        Wed, 03 May 2023 20:55:20 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s6-20020a056830148600b006a643a2eeb5sm1298155otq.15.2023.05.03.20.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:55:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] doc: git-svn: use listing instead of verse
Date:   Wed,  3 May 2023 21:55:16 -0600
Message-Id: <20230504035517.329765-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230504035517.329765-1-felipe.contreras@gmail.com>
References: <20230504035517.329765-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Code snippets are supposed to be listing blocks, not verse blocks, and
it's easy to add them by a simple indentation.

This fixes the output for asciidoctor in a few places and gets rid of
the need of  a hack for asciidoc introduced in 9b6f84d2c2 (asciidoc: add
minor workaround to add an empty line after code blocks, 2008-10-30),
plus shows the snippets in monospace font in the html backend.

  --- a/git-svn.1
  +++ b/git-svn.1
  @@ -148,6 +148,7 @@ COMMANDS
                  be used to allow only certain refs.

                      config key: svn-remote.<name>.ignore-refs
  +
                  If the ignore-refs configuration key is set, and the
                  command-line option is also given, both regular expressions
                  will be used.
  @@ -160,6 +161,7 @@ COMMANDS
                  etc) on a given repository.

                      config key: svn-remote.<name>.ignore-paths
  +
                  If the ignore-paths configuration key is set, and the
                  command-line option is also given, both regular expressions
                  will be used.
  @@ -260,6 +262,7 @@ COMMANDS

                      config key: svn-remote.<name>.commiturl
                      config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
  +
                  Note that the SVN URL of the commiturl config key includes the
                  SVN branch. If you rather want to set the commit URL for an
                  entire SVN repository use svn-remote.<name>.pushurl instead.
  @@ -277,6 +280,7 @@ COMMANDS
                  /branches/bar:3,5-6,8")

                      config key: svn.pushmergeinfo
  +
                  This option will cause git-svn to attempt to automatically
                  populate the svn:mergeinfo property in the SVN repository when
                  possible. Currently, this can only be done when dcommitting

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-svn.txt | 43 ++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4e92308e85..79f767478f 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -148,8 +148,7 @@ the same local time zone.
 	`^refs/remotes/origin/(?!tags/wanted-tag|wanted-branch).*$`
 	can be used to allow only certain refs.
 +
-[verse]
-config key: svn-remote.<name>.ignore-refs
+ config key: svn-remote.<name>.ignore-refs
 +
 If the ignore-refs configuration key is set, and the command-line
 option is also given, both regular expressions will be used.
@@ -161,8 +160,7 @@ option is also given, both regular expressions will be used.
 	(including automatic fetches due to 'clone', 'dcommit',
 	'rebase', etc) on a given repository.
 +
-[verse]
-config key: svn-remote.<name>.ignore-paths
+ config key: svn-remote.<name>.ignore-paths
 +
 If the ignore-paths configuration key is set, and the command-line
 option is also given, both regular expressions will be used.
@@ -191,8 +189,7 @@ Skip "branches" and "tags" of first level directories;;
 	'rebase', etc) on a given repository. `--ignore-paths` takes
 	precedence over `--include-paths`.
 +
-[verse]
-config key: svn-remote.<name>.include-paths
+ config key: svn-remote.<name>.include-paths
 
 --log-window-size=<n>;;
 	Fetch <n> log entries per request when scanning Subversion history.
@@ -267,9 +264,8 @@ Use of 'dcommit' is preferred to 'set-tree' (below).
 	reused if a user is later given access to an alternate transport
 	method (e.g. `svn+ssh://` or `https://`) for commit.
 +
-[verse]
-config key: svn-remote.<name>.commiturl
-config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
+ config key: svn-remote.<name>.commiturl
+ config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
 +
 Note that the SVN URL of the commiturl config key includes the SVN branch.
 If you rather want to set the commit URL for an entire SVN repository use
@@ -286,8 +282,7 @@ discouraged.
 	branches, use a single space character between the branches
 	(`--mergeinfo="/branches/foo:1-10 /branches/bar:3,5-6,8"`)
 +
-[verse]
-config key: svn.pushmergeinfo
+ config key: svn.pushmergeinfo
 +
 This option will cause git-svn to attempt to automatically populate the
 svn:mergeinfo property in the SVN repository when possible. Currently, this can
@@ -608,8 +603,7 @@ removed by default if there are no files left in them.  Git
 cannot version empty directories.  Enabling this flag will make
 the commit to SVN act like Git.
 +
-[verse]
-config key: svn.rmdir
+ config key: svn.rmdir
 
 -e::
 --edit::
@@ -619,8 +613,7 @@ Edit the commit message before committing to SVN.  This is off by
 default for objects that are commits, and forced on when committing
 tree objects.
 +
-[verse]
-config key: svn.edit
+ config key: svn.edit
 
 -l<num>::
 --find-copies-harder::
@@ -629,9 +622,8 @@ config key: svn.edit
 They are both passed directly to 'git diff-tree'; see
 linkgit:git-diff-tree[1] for more information.
 +
-[verse]
-config key: svn.l
-config key: svn.findcopiesharder
+ config key: svn.l
+ config key: svn.findcopiesharder
 
 -A<filename>::
 --authors-file=<filename>::
@@ -648,8 +640,7 @@ will abort operation. The user will then have to add the
 appropriate entry.  Re-running the previous 'git svn' command
 after the authors-file is modified should continue operation.
 +
-[verse]
-config key: svn.authorsfile
+ config key: svn.authorsfile
 
 --authors-prog=<filename>::
 	If this option is specified, for each SVN committer name that
@@ -664,8 +655,7 @@ relative to the current directory for 'init' and 'clone' and relative
 to the root of the working tree for 'fetch'. If 'filename' is
 not found, it is searched like any other command in '$PATH'.
 +
-[verse]
-config key: svn.authorsProg
+ config key: svn.authorsProg
 
 -q::
 --quiet::
@@ -703,8 +693,7 @@ creating the branch or tag.
 	'dcommit' operations), look for the first `From:` line or `Signed-off-by` trailer
 	in the log message and use that as the author string.
 +
-[verse]
-config key: svn.useLogAuthor
+ config key: svn.useLogAuthor
 
 --add-author-from::
 	When committing to svn from Git (as part of 'set-tree' or 'dcommit'
@@ -713,8 +702,7 @@ config key: svn.useLogAuthor
 	Git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
 +
-[verse]
-config key: svn.addAuthorFrom
+ config key: svn.addAuthorFrom
 
 ADVANCED OPTIONS
 ----------------
@@ -748,8 +736,7 @@ ADVANCED OPTIONS
 	process. This feature is enabled by default, use
 	--no-follow-parent to disable it.
 +
-[verse]
-config key: svn.followparent
+ config key: svn.followparent
 
 CONFIG FILE-ONLY OPTIONS
 ------------------------
-- 
2.40.0+fc1

