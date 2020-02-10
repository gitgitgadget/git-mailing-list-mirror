Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCB3C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C552072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4kXRNKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJWGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:06:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53630 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJWGU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:06:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so1002254wmh.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j+YoWpeMfeBPIWmDsIMRl93z4wUa578EwoS1S3e9hOU=;
        b=M4kXRNKvHLe/qmWc7zJtyvbAOiScJMmFntBRq43qiw6dK5QcSy8wIesXu2ligA2LTw
         grLlK9Q9EhKVZ+m3+7mPhKUNfRvKBKFqMUNwVwqVWpvhq5XKJMA2GVi8tI7cFktwpSSo
         02eGkr1N5VG4px+PPnxetXM1SXviAdPfZLHPuo5B2kloSbTYFA7Oc8HUIR2WgqfssVdt
         96KWgX3yn43C6vCJFZI96nS2WjTcsgMPXjqdRqYurLXEoau6CIl0EXR08e/koBhCkwtO
         NSeDDWkjLypxP7tOpY/nrFVLIiUNB7Tt2AuO1zi40JylN6F9UIQRwqK/V1/vF7+BSuSa
         SjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j+YoWpeMfeBPIWmDsIMRl93z4wUa578EwoS1S3e9hOU=;
        b=JUfHyHPINXXoR+stIu+ynlU2f9YvnJJmn080mLjns43AgJo2BXthQ0OKjzVcM04z9U
         nDDekNCojr96VRfzqYDTWgrltQhrPaB4LoGrsIkH3aNsjCLERSlf1dFHmz/dQRNjFE79
         aRXDAusJH/BNdIH/g29yBDZjmX11GwgJ7Y9aG+MoCsfm7ZjinPl0yJhQhTlgItJu9pO7
         kg2LY9M/zzbtzBwW1GYvUrkevp6/Jyr5+AI3RDn6D93FutDSvyBQi5HJaLCkUjv8MQng
         yiD+0nHK92o1Ko4FpDi1RwTPx3iANPHHO5vL6nuGP+2EWqE+Ml+MguXpipxRaX0amGuW
         aTTg==
X-Gm-Message-State: APjAAAUiSqnfClfs+n2OAGVVwYuQCt13p3QBg8+N99woWlefWYy4EbCS
        xkWKFzsXbwzXO9LO7OVfdRfvWcmX
X-Google-Smtp-Source: APXvYqzkMbMW+lL7FGNTGiBxkrvV41WpESUj2jyy7t46cwArpq4nC2cFwOU/0vFUCMG+p75jA2AH0A==
X-Received: by 2002:a05:600c:54e:: with SMTP id k14mr1021225wmc.115.1581372378074;
        Mon, 10 Feb 2020 14:06:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm2361947wrq.16.2020.02.10.14.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:06:17 -0800 (PST)
Message-Id: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
References: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 22:06:10 +0000
Subject: [PATCH v4 0/6] git-p4: add hooks for p4-changelist
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

REQUEST FOR HELP - SEE END

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

Request for helpThere are 2 areas that I am requesting help with:

 1. Validating code - if there are any experts with python and Windows, I
    would appreciate a review of the changes that I have presented here.
    
    
 2. Git documentation - On my latest commit, I am getting an error with
    `test-documentation.sh . Searching for a fix, I see this thread: 
    https://patchwork.kernel.org/patch/11136547/ that points to an update
    for the documentation checking, but this is out of scope for the work I
    can put to this patch. 
    
    

The actual error can be seen here: 
https://dev.azure.com/git/git/_build/results?buildId=1705&view=logs&j=bbfa2fa6-a202-51ab-3559-6013e9e5f686&t=c5c726a2-e78b-50d9-5d91-f31f918b4814&l=2688
[https://dev.azure.com/git/git/_build/results?buildId=1705&view=logs&j=bbfa2fa6-a202-51ab-3559-6013e9e5f686&t=c5c726a2-e78b-50d9-5d91-f31f918b4814&l=2688]

Thank you in advance!

Ben Keene (6):
  git-p4: rewrite prompt to be Windows compatible
  git-p4: create new function run_git_hook
  git-p4: add --no-verify option
  git-p4: restructure code in submit
  git-p4: add p4 submit hooks
  git-4: add RCS keyword status message

 Documentation/git-p4.txt   |  45 ++++++-
 Documentation/githooks.txt |  51 +++++++-
 git-p4.py                  | 233 ++++++++++++++++++++++++++++---------
 3 files changed, 272 insertions(+), 57 deletions(-)


base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-698%2Fseraphire%2Fseraphire%2Fp4-hook-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-698/seraphire/seraphire/p4-hook-v4
Pull-Request: https://github.com/git/git/pull/698

Range-diff vs v3:

 1:  8881d76c46 ! 1:  71c51ccfb0 git-p4: rewrite prompt to be Windows compatible
     @@ -27,7 +27,6 @@
      +        sys.stderr.flush()
      +        sys.stdout.write(prompt_text)
      +        sys.stdout.flush()
     -+        sys.stdin.flush()
      +        response=sys.stdin.readline().strip().lower()
               if not response:
                   continue
 2:  85918a7edb ! 2:  596b18e5e5 git-p4: create new function run_git_hook
     @@ -80,7 +80,7 @@
      +
      +    hooks_path = gitConfig("core.hooksPath")
      +    if len(hooks_path) <= 0:
     -+        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
     ++        hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
      +
      +    if not isinstance(param, list):
      +        param=[param]
     @@ -94,7 +94,13 @@
      +            if not files:
      +                return True
      +            files.sort()
     -+            hook_file = files[0]
     ++            hook_file = files.pop()
     ++            while hook_file.upper().endswith(".SAMPLE"):
     ++                # The file is a sample hook. We don't want it
     ++                if len(files) > 0:
     ++                    hook_file = files.pop()
     ++                else:
     ++                    return True
      +
      +    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
      +        return True
     @@ -136,6 +142,28 @@
       def write_pipe(c, stdin):
           if verbose:
               sys.stderr.write('Writing pipe: %s\n' % str(c))
     +@@
     +             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
     +                      (len(commits), num_shelves))
     + 
     +-        hooks_path = gitConfig("core.hooksPath")
     +-        if len(hooks_path) <= 0:
     +-            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
     +-
     +-        hook_file = os.path.join(hooks_path, "p4-pre-submit")
     +-        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
     ++        try:
     ++            if not run_git_hook("p4-pre-submit"):
     ++                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
     ++                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
     ++                    "however,\nthis will also skip the p4-changelist hook as well.")
     ++                sys.exit(1)
     ++        except Exception as e:
     ++            print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
     ++                "with the error '{0}'".format(e.message) )
     +             sys.exit(1)
     + 
     +         #
      @@
           "unshelve" : P4Unshelve,
       }
 3:  b538ad08b6 ! 3:  57a6166ed1 git-p4: add --no-verify option
     @@ -95,41 +95,3 @@
       
               if gitConfig('git-p4.largeFileSystem'):
                   die("Large file system not supported for git-p4 submit command. Please remove it from config.")
     -@@
     -         applyPatchCmd = patchcmd + "--check --apply -"
     -         patch_succeeded = True
     - 
     -+        if verbose:
     -+            print("TryPatch: %s" % tryPatchCmd)
     -+
     -         if os.system(tryPatchCmd) != 0:
     -             fixed_rcs_keywords = False
     -             patch_succeeded = False
     -@@
     -                 print("Retrying the patch with RCS keywords cleaned up")
     -                 if os.system(tryPatchCmd) == 0:
     -                     patch_succeeded = True
     -+                    print("Patch succeesed this time")
     - 
     -         if not patch_succeeded:
     -             for f in editedFiles:
     -@@
     -             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
     -                      (len(commits), num_shelves))
     - 
     --        hooks_path = gitConfig("core.hooksPath")
     --        if len(hooks_path) <= 0:
     --            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
     --
     --        hook_file = os.path.join(hooks_path, "p4-pre-submit")
     --        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
     --            sys.exit(1)
     -+        if not self.no_verify:
     -+            if not run_git_hook("p4-pre-submit"):
     -+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
     -+                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
     -+                    "however,\nthis will also skip the p4-changelist hook as well.")
     -+                sys.exit(1)
     - 
     -         #
     -         # Apply the commits, one at a time.  On failure, ask if should
 4:  662b864d70 = 4:  d17e032767 git-p4: restructure code in submit
 5:  e34c377066 = 5:  ceb2b0aff6 git-p4: add p4 submit hooks
 -:  ---------- > 6:  b92e017cb1 git-4: add RCS keyword status message

-- 
gitgitgadget
