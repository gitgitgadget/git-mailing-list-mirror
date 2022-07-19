Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D2FCCA483
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiGSSc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbiGSScY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:32:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4444857E15
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so18423398wrs.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/E+2Jd6OxKlN9Tyqjv9wdk1ekcImn1lNmwNLQccL7cE=;
        b=OpybqMoM54/+3Mbdre7GPWqyaQjwe10KF4REuooiQgD2YIYVX8LvfAh36z1C5RaNkZ
         j1P1XvaGihd0Ut2hO4YyjYJy7sJDBYO74/D2QdujlNKHXep6v33A4FJGSoOr48BI5YCK
         7sU6ypXbQjTm48Qp9cWoIh1SN5fOcfvhXRlGcickWctqRu5u5uZ8jRFnSdsZS9YmAFk3
         BUBbcURMKwIzZZvlSKYp0ZD4zBSWMovp5FZX6MBY4XOPheieIlvrpsXTxI0iCfkR9ac4
         FvLICsAXNxmRwpADnkr9iNHAfqJOZfgSRj4zz7iM08V1ZKaAFqj+eH55NeEoypg67Z5X
         7F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/E+2Jd6OxKlN9Tyqjv9wdk1ekcImn1lNmwNLQccL7cE=;
        b=1I79FDhzGd7JWFDGHjmFGMrH/Q8D1DrFDKh0dL4X+blKE4WG9nokKck8PKwY+ByOzq
         gK3loauq5aa0OaIZ85pArW0Vo/n1eN6Ct2G7YkoDkMBoDO6bQ1MhxNGhhq4vJDJMzYxR
         ihkgDhjkHDHldnRn7rpx3mRG7KVYhcRCRQm6drLeimyuGk0nA/ngG9lMRrvWDXmt5/0T
         WdVnlZqeBqLjop1R42AWSwl0UaxL3r7eCJGLtVox22J81Nuombd9lnid9j38GfCLkTmP
         G4kLtoSaAD2/jcnH6hgEooNyoM0w61DrBZuLL6awAGL8BGfZoy5XnpqIrDEZ64Najx9h
         Zxgg==
X-Gm-Message-State: AJIora+W2o4+vPWUk4eVdAKY04Sz0vpeIUxu0Pz0Ital7irEC7FOqRty
        IgzGA99V1pmQqjYJiidHqK+1Wt0jEIE=
X-Google-Smtp-Source: AGRyM1tkHEr9+UesDuIT7JVpDBD32bbLYccusz+qBRs8aXtH/SNR0TRb/MVjuK16qpGgudfs3U6Fqg==
X-Received: by 2002:adf:f3c7:0:b0:21d:9349:7a5 with SMTP id g7-20020adff3c7000000b0021d934907a5mr27993769wrp.23.1658255541293;
        Tue, 19 Jul 2022 11:32:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a1c2104000000b00397402ae674sm23385872wmh.11.2022.07.19.11.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:32:20 -0700 (PDT)
Message-Id: <db32444b87917089aaef7d501cc0e2a7fa969d97.1658255537.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
References: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
        <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:32:14 +0000
Subject: [PATCH v3 2/5] git-cvsserver: clarify directory list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The documentation and error messages for git-cvsserver include some
references to a "whitelist" that is not otherwise included in the
documentation. When different parts of the documentation do not use
common language, this can lead to confusion as to how things are meant
to operate.

Further, the word "whitelist" has cultural implications that make its
use non-inclusive. Thankfully, we can remove it while increasing
clarity.

Update Documentation/git-cvsserver.txt in a similar way to the previous
change to Documentation/git-daemon.txt. The optional '<directory>...'
list can specify a list of allowed directories. We refer to that list
directly inside of the documentation for the GIT_CVSSERVER_ROOT
environment variable.

While modifying this documentation, update the environment variables to
use a list format. We use the modern way of tabbing the description of
each variable in this section. We do _not_ update the description of
'<directory>...' to use tabs this way since the rest of the items in the
OPTIONS list do not use this modern formatting.

A single error message in the actual git-cvsserver.perl code refers to
the whitelist during argument parsing. Instead, refer to the directory
list that has been clarified in the documentation.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-cvsserver.txt | 19 ++++++++++---------
 git-cvsserver.perl              |  2 +-
 t/t9400-git-cvsserver-server.sh |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 4dc57ed2547..53f111bc0ac 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -63,11 +63,10 @@ Print version information and exit
 Print usage information and exit
 
 <directory>::
-You can specify a list of allowed directories. If no directories
-are given, all are allowed. This is an additional restriction, gitcvs
-access still needs to be enabled by the `gitcvs.enabled` config option
-unless `--export-all` was given, too.
-
+The remaining arguments provide a list of directories. If no directories
+are given, then all are allowed. Repositories within these directories
+still require the `gitcvs.enabled` config option, unless `--export-all`
+is specified.
 
 LIMITATIONS
 -----------
@@ -311,11 +310,13 @@ ENVIRONMENT
 These variables obviate the need for command-line options in some
 circumstances, allowing easier restricted usage through git-shell.
 
-GIT_CVSSERVER_BASE_PATH takes the place of the argument to --base-path.
+GIT_CVSSERVER_BASE_PATH::
+	This variable replaces the argument to --base-path.
 
-GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
-repository must still be configured to allow access through
-git-cvsserver, as described above.
+GIT_CVSSERVER_ROOT::
+	This variable specifies a single directory, replacing the
+	`<directory>...` argument list. The repository still requires the
+	`gitcvs.enabled` config option, unless `--export-all` is specified.
 
 When these environment variables are set, the corresponding
 command-line arguments may not be used.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 4c8118010a8..7b757360e28 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -152,7 +152,7 @@ $state->{allowed_roots} = [ @ARGV ];
 
 # don't export the whole system unless the users requests it
 if ($state->{'export-all'} && !@{$state->{allowed_roots}}) {
-    die "--export-all can only be used together with an explicit whitelist\n";
+    die "--export-all can only be used together with an explicit '<directory>...' list\n";
 }
 
 # Environment handling for running under git-shell
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 210ddf09e30..379b19f2f85 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -221,7 +221,7 @@ test_expect_success 'req_Root (export-all)' \
   'cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU\$"'
 
-test_expect_success 'req_Root failure (export-all w/o whitelist)' \
+test_expect_success 'req_Root failure (export-all w/o directory list)' \
   '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
-- 
gitgitgadget

