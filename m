Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4A8C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDC52168B
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyYLIgXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgBKS6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:58:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34904 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBKS6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so13827954wrt.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 10:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d3gp7KCzPz94PRPy5qTRjlmenN+3QEpqP1dUjbZv2Cs=;
        b=NyYLIgXVr6bf5FbjK2XaV7CYd9r7soUvaj2ffsi5qig9Pw78d3AI8h3pKcf7O+HB1F
         5ZtnD2eUkinNsJYOq8D44d1IbGqltmsMPTG9ytHfBflStpu+zly/bBb+jHPUbFv73rBF
         TipU3FfbgFJv8XDbJTXQAaIsH1i0QF43SoyLaths2HOBIfasCm+NpPoTyRZVNHKzgXqo
         zcZi+tjNfxOICprqUtwHGKzKAevxgyHrpvBSkN2riSH/wmYJG82j0IakfhQtGTuesGdF
         OHoPRmSdnPjlrlF5tu8j75+6HzSscp+TKZ9GKc9c/rnVRACUNuTtFeafs4rmUNabbjPH
         cqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d3gp7KCzPz94PRPy5qTRjlmenN+3QEpqP1dUjbZv2Cs=;
        b=W80U3Z3JweBbfF+Jke87I8qEzvqQT5zHMzbppfCDWbhzfNtkcV+jW56Re2zXXIi3Ye
         MHdHtHpHL/IWIBR4e+GK6VX6wTu+cbbwKyCLI3b/4VcWDcckBx8WF7Fx88VONpC6gBfp
         HWCtyQurcsiUlACumFoloiuOk5wNConSlyv8JbghyEX9AWOPNFySbJyRPvNP+tYZ23YG
         qGo9PKHbFlh9Dur+QGA9f5b8aiQMPslnECLqQYhxm2UWh2MaKIaJ3e4VhEVwThfPRGJo
         glsVA7OMTBuoXeAPneCh0ApOwJhY6bEbRpyCMrR/0AmcMkz8x8RJTyVgJ1BjIHrahyti
         6uhQ==
X-Gm-Message-State: APjAAAWK1S/1ow86Pgn0xoYuhmXABPKN5O0y2MRm4bBZkO92Hc00n6KO
        G+FXBju79WiEDhMlNBxjkUW0969V
X-Google-Smtp-Source: APXvYqzJuOt/dtY3lqWTAHGa7fJ3o38ErU7RiJNNbBKQnJ/jggBfFM1fWvwiEE8Qbh6LcbP7/v+YTg==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr9843892wrm.75.1581447486038;
        Tue, 11 Feb 2020 10:58:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm6409558wrp.58.2020.02.11.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:58:05 -0800 (PST)
Message-Id: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
References: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 18:57:57 +0000
Subject: [PATCH v5 0/7] git-p4: add hooks for p4-changelist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Request for help - if there are any experts with python and Windows, I would
appreciate a review of the changes that I have presented here.


----------------------------------------------------------------------------

Our company's workflow requires that our P4 check-in messages have a
specific format. A helpful feature in the GIT-P4 program would be a hook
that occurs after the P4 change list is created but before it is displayed
in the editor that would allow an external program to possibly edit the
changelist text.

v1:My suggestion for the hook name is p4-pre-edit-changelist.

It would take a single parameter, the full path of the temporary file. If
the hook returns a non-zero exit code, it would cancel the current P4
submit.

The hook should be optional.

v2:Instead of a single hook, p4-pre-edit-changelist, follow the git
convention for hook names and add the trio of hooks that work together,
similar to git commit.

The hook names are: 

 * p4-prepare-changelist
 * p4-changelist
 * p4-post-changelist

The hooks should follow the same convention as git commit, so a new command
line option for the git-p4 submit function --no-verify should also be added.

v3:2-Feb-2020 This version reorganizes the commits to be easier to read. The
function for running the git hook has been rewritten to include suggestions.
This version no longer restricts the executable supported by windows for the
hook. It will first look for a file with the hook name without an extension
and if found, it will pass it to sh.exe (Git for Window's MINGW shell)
Otherwise it will take the file with the lowest alphabetical extension and
ask Windows to execute the program.

v3:10-Feb-2020 Integrated the suggested changes from the mailing list into
this release. The changes are:

 * Restructure the commits to pull the p4-pre-submit hook changes into the
   commit for adding git_run_hook.
 * Update the git_run_hook to include additional tests for GIT_DIR being set
   if getting the environment returns no value.
 * Updated the windows file resolution to ensure that the script to be run
   is NOT the .SAMPLE version of the hooks.
 * Split the RCS keyword cleanup message into its own commit.

Thank you in advance!

Ben Keene (7):
  git-p4: rewrite prompt to be Windows compatible
  git-p4: create new function run_git_hook
  git-p4: add p4-pre-submit exit text
  git-p4: add --no-verify option
  git-p4: restructure code in submit
  git-p4: add p4 submit hooks
  git-p4: add RCS keyword status message

 Documentation/git-p4.txt   |  45 ++++++-
 Documentation/githooks.txt |  51 +++++++-
 git-p4.py                  | 236 ++++++++++++++++++++++++++++---------
 3 files changed, 274 insertions(+), 58 deletions(-)


base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-698%2Fseraphire%2Fseraphire%2Fp4-hook-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-698/seraphire/seraphire/p4-hook-v5
Pull-Request: https://github.com/git/git/pull/698

Range-diff vs v4:

 1:  71c51ccfb0 = 1:  71c51ccfb0 git-p4: rewrite prompt to be Windows compatible
 2:  596b18e5e5 ! 2:  a2342f7161 git-p4: create new function run_git_hook
     @@ -152,15 +152,7 @@
      -
      -        hook_file = os.path.join(hooks_path, "p4-pre-submit")
      -        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
     -+        try:
     -+            if not run_git_hook("p4-pre-submit"):
     -+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
     -+                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
     -+                    "however,\nthis will also skip the p4-changelist hook as well.")
     -+                sys.exit(1)
     -+        except Exception as e:
     -+            print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
     -+                "with the error '{0}'".format(e.message) )
     ++        if not run_git_hook("p4-pre-submit"):
                   sys.exit(1)
       
               #
 -:  ---------- > 3:  5f2b47bf6a git-p4: add p4-pre-submit exit text
 3:  57a6166ed1 ! 4:  05b8c7ad67 git-p4: add --no-verify option
     @@ -95,3 +95,30 @@
       
               if gitConfig('git-p4.largeFileSystem'):
                   die("Large file system not supported for git-p4 submit command. Please remove it from config.")
     +@@
     +             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
     +                      (len(commits), num_shelves))
     + 
     +-        try:
     +-            if not run_git_hook("p4-pre-submit"):
     +-                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
     +-                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
     +-                    "however,\nthis will also skip the p4-changelist hook as well.")
     ++        if not self.no_verify:
     ++            try:
     ++                if not run_git_hook("p4-pre-submit"):
     ++                    print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
     ++                        "this pre-submission check by adding\nthe command line option '--no-verify', " \
     ++                        "however,\nthis will also skip the p4-changelist hook as well.")
     ++                    sys.exit(1)
     ++            except Exception as e:
     ++                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
     ++                    "with the error '{0}'".format(e.message) )
     +                 sys.exit(1)
     +-        except Exception as e:
     +-            print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
     +-                "with the error '{0}'".format(e.message) )
     +-            sys.exit(1)
     + 
     +         #
     +         # Apply the commits, one at a time.  On failure, ask if should
 4:  d17e032767 = 5:  5299f61e4e git-p4: restructure code in submit
 5:  ceb2b0aff6 = 6:  7a6d9fafce git-p4: add p4 submit hooks
 6:  b92e017cb1 ! 7:  c0aca43185 git-4: add RCS keyword status message
     @@ -1,15 +1,15 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-4: add RCS keyword status message
     +    git-p4: add RCS keyword status message
      
          During the p4 submit process, git-p4 will attempt to apply a patch
     -    to the files found in the p4 workspace. However, it P4 uses RCS
     +    to the files found in the p4 workspace. However, if P4 uses RCS
          keyword expansion, this patch may fail.
      
          When the patch fails, the user is alerted to the failure and that git-p4
          will attempt to clear the expanded text from the files and re-apply
          the patch. The current version of git-p4 does not tell the user the
     -    result of applying the patch after the RCS expansion has been removed
     +    result of the re-apply attempt after the RCS expansion has been removed
          which can be confusing.
      
          Add a new print statement after the git patch has been successfully

-- 
gitgitgadget
