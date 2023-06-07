Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317FFC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 19:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFGT1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 15:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjFGT0x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 15:26:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7CBA
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 12:26:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ae5f2ac94so7667320f8f.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686166010; x=1688758010;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq2ZksqUQJxfAoBdQ3UMOse9ULHbbOboz8UQkx4wBMg=;
        b=WVS2jizJ5UKniFe86YmdFrKzrlGtjAoqtwpNbelRv2hGZJEYPGL5RQByA3ZEMZ+k2O
         Rc2+oMWLDHScAI+NCfeOeAU5y5RT8Pq01kKNQvcSXFuWMTHsvTEicX0s3rEVkHE9WftX
         6e/xegyV7z/fZpdWxFodjhKgkVjIDY68scw7YdGDHcfFTMvLG2M9f6hVEKR6xv4YQivZ
         6/QfIy8JAldc9dRBWingO/QXGYRjoZkcoSIgOzuTOaPyjltRrbOVz3G3v6/K3TJFkVE2
         O51sTgX5wXBkonj20mjdmYIWEGaHNNEGjJWQXBGr0DOUoFolIB75k4UlbKiucZr9vl5o
         MUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686166010; x=1688758010;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mq2ZksqUQJxfAoBdQ3UMOse9ULHbbOboz8UQkx4wBMg=;
        b=Bg9JtIMKrG6kxegDKjePR1N59iwSX77gVL9SEN9vM3T6XO+4sY52DcGNfSRh9sTV7h
         9cuIX1fKXHyy9Yb/xaW4v1rBAb3gf8OR8l7iJaPoQttSeqiCPg35eNjVpKRB+tMuhMGS
         V6fCX74sT3yKAFoErxIO99XnRqJq3N24RaPba4phvVEyV4HvspUb3bhwezmL6zwnhnQx
         2rFraLYLiZPycHynCFqIKRcbL/AZSQ8ctWFrL2IAlXhGoQfOC0lo0yhaPNcvx5aaxrHV
         w0rfQzGez304T96/gQqWWLF37VfSfNtVjEi5FEDqw81KcOTwHNMEPXjMFm/In6XEd3yP
         bdmA==
X-Gm-Message-State: AC+VfDxyB0KOGK69zn7ukq+fuyXiYWON6eA7k2jqCtvtnfx4l2z61djb
        D+ZXJp8mChVVlywrMkg/NhdGFRStacA=
X-Google-Smtp-Source: ACHHUZ4lF4DPKUpX1giYlkB41X3q1N4CLZUYogRZCQP33/oJJdFiKmJ8WyCBV6n5VYIbME33viTZ8A==
X-Received: by 2002:a5d:6407:0:b0:30a:e69d:721e with SMTP id z7-20020a5d6407000000b0030ae69d721emr5213150wru.55.1686166009368;
        Wed, 07 Jun 2023 12:26:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bcb19000000b003f73a101f88sm2993715wmj.16.2023.06.07.12.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:26:49 -0700 (PDT)
Message-Id: <pull.1542.v2.git.1686166007816.gitgitgadget@gmail.com>
In-Reply-To: <pull.1542.git.1686099081989.gitgitgadget@gmail.com>
References: <pull.1542.git.1686099081989.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Jun 2023 19:26:47 +0000
Subject: [PATCH v2] docs: typofixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

These were found with an automated CLI tool [1]. Only the
"Documentation" subfolder (and not source code files) was considered
because the docs are user-facing.

[1]: https://crates.io/crates/typos-cli

Signed-off-by: Linus Arver <linusa@google.com>
---
    docs: typofixes
    
    
    Changes from v1 to v2
    =====================
    
    The typo fix "interation" was wrongly corrected to "interaction" (as
    suggested by the tool). Instead this has been fixed to be "iteration" to
    match the surrounding context.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1542%2Flistx%2Ftypofixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1542/listx/typofixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1542

Range-diff vs v1:

 1:  99d9e137f09 ! 1:  037fac6a10e docs: typofixes
     @@ Documentation/git-format-patch.txt: populated with placeholder text.
       	using such a reroll-count is that the range-diff/interdiff
       	with the previous version does not state exactly which
      -	version the new interation is compared against.
     -+	version the new interaction is compared against.
     ++	version the new iteration is compared against.
       
       --to=<email>::
       	Add a `To:` header to the email headers. This is in addition


 Documentation/CodingGuidelines                  | 2 +-
 Documentation/config.txt                        | 2 +-
 Documentation/git-cvsserver.txt                 | 2 +-
 Documentation/git-describe.txt                  | 4 ++--
 Documentation/git-format-patch.txt              | 2 +-
 Documentation/git-ls-tree.txt                   | 2 +-
 Documentation/git-mktag.txt                     | 2 +-
 Documentation/git-sparse-checkout.txt           | 2 +-
 Documentation/git-stash.txt                     | 2 +-
 Documentation/gitweb.txt                        | 2 +-
 Documentation/technical/remembering-renames.txt | 2 +-
 Documentation/urls-remotes.txt                  | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 003393ed161..1f3290f1736 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -687,7 +687,7 @@ Writing Documentation:
    Do: [-q | --quiet]
    Don't: [-q|--quiet]
 
- Don't use spacing around "|" tokens when they're used to seperate the
+ Don't use spacing around "|" tokens when they're used to separate the
  alternate arguments of an option:
     Do: --track[=(direct|inherit)]
     Don't: --track[=(direct | inherit)]
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e93aef8626..229b63a454c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -182,7 +182,7 @@ included, Git breaks the cycle by prohibiting these files from affecting
 the resolution of these conditions (thus, prohibiting them from
 declaring remote URLs).
 +
-As for the naming of this keyword, it is for forwards compatibiliy with
+As for the naming of this keyword, it is for forwards compatibility with
 a naming scheme that supports more variable-based include conditions,
 but currently Git only supports the exact keyword described above.
 
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 53f111bc0ac..cf4a5a283ec 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -118,7 +118,7 @@ for example:
    myuser:$5$.NqmNH1vwfzGpV8B$znZIcumu1tNLATgV2l6e1/mY8RzhUDHMOaVOeL1cxV3
 ------
 You can use the 'htpasswd' facility that comes with Apache to make these
-files, but only with the -d option (or -B if your system suports it).
+files, but only with the -d option (or -B if your system supports it).
 
 Preferably use the system specific utility that manages password hash
 creation in your platform (e.g. mkpasswd in Linux, encrypt in OpenBSD or
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c6a79c2a0f2..08ff715709c 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -140,7 +140,7 @@ at the end.
 
 The number of additional commits is the number
 of commits which would be displayed by "git log v1.0.4..parent".
-The hash suffix is "-g" + an unambigous abbreviation for the tip commit
+The hash suffix is "-g" + an unambiguous abbreviation for the tip commit
 of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The
 length of the abbreviation scales as the repository grows, using the
 approximate number of objects in the repository and a bit of math
@@ -203,7 +203,7 @@ BUGS
 
 Tree objects as well as tag objects not pointing at commits, cannot be described.
 When describing blobs, the lightweight tags pointing at blobs are ignored,
-but the blob is still described as <committ-ish>:<path> despite the lightweight
+but the blob is still described as <commit-ish>:<path> despite the lightweight
 tag being favorable.
 
 GIT
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b1c13fb39a0..373b46fc0de 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -245,7 +245,7 @@ populated with placeholder text.
 	or "--reroll-count=4rev2" are allowed), but the downside of
 	using such a reroll-count is that the range-diff/interdiff
 	with the previous version does not state exactly which
-	version the new interation is compared against.
+	version the new iteration is compared against.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 0240adb8eec..fa9a6b9f2cb 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -145,7 +145,7 @@ FIELD NAMES
 -----------
 
 Various values from structured fields can be used to interpolate
-into the resulting output. For each outputing line, the following
+into the resulting output. For each outputting line, the following
 names can be used:
 
 objectmode::
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 466a6975191..b2a2e80d421 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -33,7 +33,7 @@ from warnings to errors (so e.g. a missing "tagger" line is an error).
 
 Extra headers in the object are also an error under mktag, but ignored
 by linkgit:git-fsck[1]. This extra check can be turned off by setting
-the appropriate `fsck.<msg-id>` varible:
+the appropriate `fsck.<msg-id>` variable:
 
     git -c fsck.extraHeaderEntry=ignore mktag <my-tag-with-headers
 
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 53dc17aa77a..529a8edd9c1 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -286,7 +286,7 @@ patterns in non-cone mode has a number of shortcomings:
     problem above?  Also, if it suggests paths, what if the user has a
     file or directory that begins with either a '!' or '#' or has a '*',
     '\', '?', '[', or ']' in its name?  And if it suggests paths, will
-    it complete "/pro" to "/proc" (in the root filesytem) rather than to
+    it complete "/pro" to "/proc" (in the root filesystem) rather than to
     "/progress.txt" in the current directory?  (Note that users are
     likely to want to start paths with a leading '/' in non-cone mode,
     for the same reason that .gitignore files often have one.)
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index f4bb6114d91..06fb7f1d18c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -366,7 +366,7 @@ only the commit ends-up being in the stash and not on the current branch.
 # ... hack hack hack ...
 $ git add --patch foo           # add unrelated changes to the index
 $ git stash push --staged       # save these changes to the stash
-# ... hack hack hack, finish curent changes ...
+# ... hack hack hack, finish current changes ...
 $ git commit -m 'Massive'       # commit fully tested changes
 $ git switch fixup-branch       # switch to another branch
 $ git stash pop                 # to finish work on the saved changes
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 7cee9d36899..af6bf3c45ec 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -503,7 +503,7 @@ repositories, you can configure Apache like this:
 
 The above configuration expects your public repositories to live under
 `/pub/git` and will serve them as `http://git.domain.org/dir-under-pub-git`,
-both as clonable Git URL and as browseable gitweb interface.  If you then
+both as clonable Git URL and as browsable gitweb interface.  If you then
 start your linkgit:git-daemon[1] with `--base-path=/pub/git --export-all`
 then you can even use the `git://` URL with exactly the same path.
 
diff --git a/Documentation/technical/remembering-renames.txt b/Documentation/technical/remembering-renames.txt
index 1e34d913901..73f41761e20 100644
--- a/Documentation/technical/remembering-renames.txt
+++ b/Documentation/technical/remembering-renames.txt
@@ -664,7 +664,7 @@ skip-irrelevant-renames optimization means we sometimes don't detect
 renames for any files within a directory that was renamed, in which
 case we will not have been able to detect any rename for the directory
 itself.  In such a case, we do not know whether the directory was
-renamed; we want to be careful to avoid cacheing some kind of "this
+renamed; we want to be careful to avoid caching some kind of "this
 directory was not renamed" statement.  If we did, then a subsequent
 commit being rebased could add a file to the old directory, and the
 user would expect it to end up in the correct directory -- something
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index e410912fe52..ae8c2db427b 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -35,7 +35,7 @@ config file would appear like this:
 The `<pushurl>` is used for pushes only. It is optional and defaults
 to `<URL>`. Pushing to a remote affects all defined pushurls or to all
 defined urls if no pushurls are defined. Fetch, however, will only
-fetch from the first defined url if muliple urls are defined.
+fetch from the first defined url if multiple urls are defined.
 
 Named file in `$GIT_DIR/remotes`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
-- 
gitgitgadget
