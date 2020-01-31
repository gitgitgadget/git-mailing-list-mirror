Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4219DC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C9920705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9KFdqFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgAaV6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:58:24 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36657 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgAaV6X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:58:23 -0500
Received: by mail-wm1-f54.google.com with SMTP id p17so10468783wma.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 13:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EaWm5pCgfKAlsWAM1IG+K5SJlgQQMIeaaTAi1/FbsL4=;
        b=b9KFdqFniAAoPZ+QmFGpbDOD/hFnVoWfCJ+nhYHl0ILqxjUI92oEuJUbKA+SvDd8n4
         /mhu1nprHCy369gVOgcqui+WfNE6/f4ybNItRQe1/iQUKCbUpsoT84og9V8LuuwqU9FA
         gRDL3tQl0oAoeZbdyzXOq4Q5Vnmi4WZZ1XK0TSuz+aIteh5zdO+O8AOnn7pg1AUaehm9
         yJAjqcIXDr6rKxq7cEDRP21kdLyZWO4Xyn1xwcg0gfH7B0d2h+RzeHGDQihy+e/aGdNE
         J+nT9GPsQGJk6lCefM0ZlO5AE8kBGna2exaDsXiAEXvk+aqnqUxTiV8Ni/paHwcFtSAg
         1jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EaWm5pCgfKAlsWAM1IG+K5SJlgQQMIeaaTAi1/FbsL4=;
        b=QWzua4PkxHNZopFRHSEmgQV0JL+mYt0TQdnhDF9EFUD/JSkMDCS6IV1QXApOuVFAXP
         yUik3LXd4gGESenz1UYftqKfws/tP3ckzBDMasElxRZ2f2bdUf9gso7EDD3zbhpmYbu9
         aM488FlYP0cn1nyYhCl8buTwAB0C7L9e1T/P3usq/Gt2sXBy6QDW0Nz1uVMznjxgelTn
         +DxnaNIUK1zAa7+CL8CVs1idkZq/9GkCc3M6TlW6eckRfhTmSwtFwOsJwAkRwCBPN8tr
         BHAct6p2zvmzyVzRQPIfuecNM1YR8T3yKfyNpnayOyXvlUf3I8jTAPoCbp95rqfpEtJn
         08AA==
X-Gm-Message-State: APjAAAUlwV6sp/5aOWQsjrbdPjnqqFYaOL2MVP9KbsHzY39in305Abws
        kzCF4LrNK/gb0WpkAI9hAbcXAOsF
X-Google-Smtp-Source: APXvYqz27xhwLYogtyoXckpHelhti95hLT2rDNd5NTq31UiVxzTGEJI9yxJJfK0gKQXMmfY78abY6Q==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr13739796wmj.29.1580507899631;
        Fri, 31 Jan 2020 13:58:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm14169wrc.6.2020.01.31.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 13:58:19 -0800 (PST)
Message-Id: <3d34dd042e47fce7bc49a63f676378172e15775e.1580507895.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 21:58:15 +0000
Subject: [PATCH v2 4/4] git-p4: add p4 submit hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

The git command "commit" supports a number of hooks that support
changing the behavior of the commit command.  The git-p4.py program only
has one existing hook, "p4-p4-pre-submit".  This command occurs early
in the process.  There are no hooks in the process flow for modifying
the P4 changelist text programmatically.

Adds 3 new hooks and 1 new option to git-p4.py to the submit option.

The new command line option --no-verify:

Add a new command line option "--no-verify" to the Submit command of
git-p4.py.  This option will function in the spirit of the existing
--no-verify command line option found in git commit. It will cause the
P4 Submit function to ignore the existing p4-pre-submit and the new
p4-changelist hooks.

The new hooks are:
* p4-prepare-changelist - Execute this hook after the changelist file
  has been created. The hook will be executed even if the
  --prepare-p4-only option is set.  This hook ignores the --no-verify
  option in keeping with the existing behavior of git commit.

* p4-changelist - Execute this hook after the user has edited the
  changelist. Do not execute this hook if the user has selected the
  --prepare-p4-only option. This hook will honor the --no-verify,
  following the conventions of git commit.

* p4-post-changelist - Execute this hook after the P4 submission process
  has completed successfully. This hook takes no parameters and is
  executed regardless of the --no-verify option.  It's return value will
  not be checked.

Change the execution of the existing trigger p4-pre-submit to honor the
--no-verify option. Before exiting on failure of this hook, display
text to the user explaining which hook has failed and the impact
of using the --no-verify option.

Move all the code after creating the submitTemplate text into the
try-finally block in the applyCommit() method.  By restructuring the
code, the P4 workspace is protected against otherwise unhandled
exceptions and other early exits.

The calls to the new hooks: p4-prepare-changelist, p4-changelist,
and p4-post-changelist should all be called inside the try-finally
block.

Existing flow control can remain as defined - the if-block for
prepare-p4-only sets the local variable "submitted" to True and exits
the function. All other early exits, leave submitted set to False so the
Finally block will undo changes to the P4 workspace.

Make the small usability change of adding an empty string to the
print statements displayed to the user when the prepare-p4-only option
is selected.  On Windows, the command print() may display a set of
parentheses () to the user when the print() function is called with no
parameters. By supplying an empty string, the intended blank line will
print as expected.

Fix a small bug when the submittedTemplate is edited by the user
and all content in the file is removed. The existing code will throw
an exception if the separateLine is not found in the file.  Change this
code to test for the separator line using a find() test first and only
split on the separator if it is found.

Additionally, add the new behavior that if the changelist file has been
completely emptied that the Submit action for this changelist will be
aborted.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 Documentation/git-p4.txt   |  44 +++++++++-
 Documentation/githooks.txt |  46 ++++++++++
 git-p4.py                  | 167 +++++++++++++++++++++++--------------
 3 files changed, 191 insertions(+), 66 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3494a1db3e..f17c1d0561 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -374,14 +374,54 @@ These options can be used to modify 'git p4 submit' behavior.
     been submitted. Implies --disable-rebase. Can also be set with
     git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
 
-Hook for submit
-~~~~~~~~~~~~~~~
+Hooks for submit
+----------------
+
+p4-pre-submit
+~~~~~~~~~~~~~
+
 The `p4-pre-submit` hook is executed if it exists and is executable.
 The hook takes no parameters and nothing from standard input. Exiting with
 non-zero status from this script prevents `git-p4 submit` from launching.
 
 One usage scenario is to run unit tests in the hook.
 
+p4-prepare-changelist
+~~~~~~~~~~~~~~~~~~~~~
+
+The `p4-prepare-changelist` hook is executed right after preparing
+the default changelist message and before the editor is started.
+It takes one parameter, the name of the file that contains the
+changelist text. Exiting with a non-zero status from the script
+will abort the process.
+
+The purpose of the hook is to edit the message file in place,
+and it is not supressed by the `--no-verify` option. This hook
+is called even if `--prepare-p4-only` is set.
+
+p4-changelist
+~~~~~~~~~~~~~
+
+The `p4-changelist` hook is executed after the changelist
+message has been edited by the user. It can be bypassed with the
+`--no-verify` option. It takes a single parameter, the name
+of the file that holds the proposed changelist text. Exiting
+with a non-zero status causes the command to abort.
+
+The hook is allowed to edit the changelist file and can be used
+to normalize the text into some project standard format. It can
+also be used to refuse the Submit after inspect the message file.
+
+p4-post-changelist
+~~~~~~~~~~~~~~~~~~
+
+The `p4-post-changelist` hook is invoked after the submit has
+successfully occured in P4. It takes no parameters and is meant
+primarily for notification and cannot affect the outcome of the
+git p4 submit action.
+
+
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 50365f2914..67e78a8a05 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -515,6 +515,52 @@ The exit status determines whether git will use the data from the
 hook to limit its search.  On error, it will fall back to verifying
 all files and folders.
 
+p4-changelist
+~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-changelist` hook is executed after the changelist
+message has been edited by the user. It can be bypassed with the
+`--no-verify` option. It takes a single parameter, the name
+of the file that holds the proposed changelist text. Exiting
+with a non-zero status causes the command to abort.
+
+The hook is allowed to edit the changelist file and can be used
+to normalize the text into some project standard format. It can
+also be used to refuse the Submit after inspect the message file.
+
+Run `git-p4 submit --help` for details.
+
+p4-prepare-changelist
+~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-prepare-changelist` hook is executed right after preparing
+the default changelist message and before the editor is started.
+It takes one parameter, the name of the file that contains the
+changelist text. Exiting with a non-zero status from the script
+will abort the process.
+
+The purpose of the hook is to edit the message file in place,
+and it is not supressed by the `--no-verify` option. This hook
+is called even if `--prepare-p4-only` is set.
+
+Run `git-p4 submit --help` for details.
+
+p4-post-changelist
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-post-changelist` hook is invoked after the submit has
+successfully occured in P4. It takes no parameters and is meant
+primarily for notification and cannot affect the outcome of the
+git p4 submit action.
+
+Run `git-p4 submit --help` for details.
+
 p4-pre-submit
 ~~~~~~~~~~~~~
 
diff --git a/git-p4.py b/git-p4.py
index 61cfd1c1ae..fe633acf84 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1521,13 +1521,39 @@ def __init__(self):
                                      "work from a local git branch that is not master"),
                 optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                      help="Skip Perforce sync of p4/master after submit or shelve"),
+                optparse.make_option("--no-verify", dest="no_verify", action="store_true",
+                                     help="Bypass p4-pre-submit and p4-changelist hooks"),
         ]
         self.description = """Submit changes from git to the perforce depot.\n
-    The `p4-pre-submit` hook is executed if it exists and is executable.
-    The hook takes no parameters and nothing from standard input. Exiting with
-    non-zero status from this script prevents `git-p4 submit` from launching.
-
-    One usage scenario is to run unit tests in the hook."""
+    The `p4-pre-submit` hook is executed if it exists and is executable. It
+    can be bypassed with the `--no-verify` command line option. The hook takes
+    no parameters and nothing from standard input. Exiting with a non-zero status
+    from this script prevents `git-p4 submit` from launching.
+
+    One usage scenario is to run unit tests in the hook.
+
+    The `p4-prepare-changelist` hook is executed right after preparing the default
+    changelist message and before the editor is started. It takes one parameter,
+    the name of the file that contains the changelist text. Exiting with a non-zero
+    status from the script will abort the process.
+
+    The purpose of the hook is to edit the message file in place, and it is not
+    supressed by the `--no-verify` option. This hook is called even if
+    `--prepare-p4-only` is set.
+
+    The `p4-changelist` hook is executed after the changelist message has been
+    edited by the user. It can be bypassed with the `--no-verify` option. It
+    takes a single parameter, the name of the file that holds the proposed
+    changelist text. Exiting with a non-zero status causes the command to abort.
+
+    The hook is allowed to edit the changelist file and can be used to normalize
+    the text into some project standard format. It can also be used to refuse the
+    Submit after inspect the message file.
+
+    The `p4-post-changelist` hook is invoked after the submit has successfully
+    occured in P4. It takes no parameters and is meant primarily for notification
+    and cannot affect the outcome of the git p4 submit action.
+    """
 
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
@@ -1545,6 +1571,7 @@ def __init__(self):
         self.exportLabels = False
         self.p4HasMoveCommand = p4_has_move_command()
         self.branch = None
+        self.no_verify = False
 
         if gitConfig('git-p4.largeFileSystem'):
             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
@@ -1931,6 +1958,9 @@ def applyCommit(self, id):
         applyPatchCmd = patchcmd + "--check --apply -"
         patch_succeeded = True
 
+        if verbose:
+            print("TryPatch: %s" % tryPatchCmd)
+
         if os.system(tryPatchCmd) != 0:
             fixed_rcs_keywords = False
             patch_succeeded = False
@@ -1970,6 +2000,7 @@ def applyCommit(self, id):
                 print("Retrying the patch with RCS keywords cleaned up")
                 if os.system(tryPatchCmd) == 0:
                     patch_succeeded = True
+                    print("Patch succeesed this time")
 
         if not patch_succeeded:
             for f in editedFiles:
@@ -2030,66 +2061,73 @@ def applyCommit(self, id):
         tmpFile.write(submitTemplate)
         tmpFile.close()
 
-        # Run the pre-edit hook to allow programmatic update to the changelist
-        hooks_path = gitConfig("core.hooksPath")
-        if len(hooks_path) <= 0:
-            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
-
-        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
-        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
-            for f in editedFiles:
-                p4_revert(f)
-            return False
-
-        if self.prepare_p4_only:
-            #
-            # Leave the p4 tree prepared, and the submit template around
-            # and let the user decide what to do next
-            #
-            print()
-            print("P4 workspace prepared for submission.")
-            print("To submit or revert, go to client workspace")
-            print("  " + self.clientPath)
-            print()
-            print("To submit, use \"p4 submit\" to write a new description,")
-            print("or \"p4 submit -i <%s\" to use the one prepared by" \
-                  " \"git p4\"." % fileName)
-            print("You can delete the file \"%s\" when finished." % fileName)
-
-            if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
-                print("To preserve change ownership by user %s, you must\n" \
-                      "do \"p4 change -f <change>\" after submitting and\n" \
-                      "edit the User field.")
-            if pureRenameCopy:
-                print("After submitting, renamed files must be re-synced.")
-                print("Invoke \"p4 sync -f\" on each of these files:")
-                for f in pureRenameCopy:
-                    print("  " + f)
-
-            print()
-            print("To revert the changes, use \"p4 revert ...\", and delete")
-            print("the submit template file \"%s\"" % fileName)
-            if filesToAdd:
-                print("Since the commit adds new files, they must be deleted:")
-                for f in filesToAdd:
-                    print("  " + f)
-            print()
-            return True
-
-        #
-        # Let the user edit the change description, then submit it.
-        #
         submitted = False
 
         try:
+            # Allow the hook to edit the changelist text before presenting it
+            # to the user.
+            if not gitRunHook("p4-prepare-changelist", [fileName]):
+                return False
+
+            if self.prepare_p4_only:
+                #
+                # Leave the p4 tree prepared, and the submit template around
+                # and let the user decide what to do next
+                #
+                submitted = True
+                print("")
+                print("P4 workspace prepared for submission.")
+                print("To submit or revert, go to client workspace")
+                print("  " + self.clientPath)
+                print("")
+                print("To submit, use \"p4 submit\" to write a new description,")
+                print("or \"p4 submit -i <%s\" to use the one prepared by" \
+                      " \"git p4\"." % fileName)
+                print("You can delete the file \"%s\" when finished." % fileName)
+
+                if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
+                    print("To preserve change ownership by user %s, you must\n" \
+                          "do \"p4 change -f <change>\" after submitting and\n" \
+                          "edit the User field.")
+                if pureRenameCopy:
+                    print("After submitting, renamed files must be re-synced.")
+                    print("Invoke \"p4 sync -f\" on each of these files:")
+                    for f in pureRenameCopy:
+                        print("  " + f)
+
+                print("")
+                print("To revert the changes, use \"p4 revert ...\", and delete")
+                print("the submit template file \"%s\"" % fileName)
+                if filesToAdd:
+                    print("Since the commit adds new files, they must be deleted:")
+                    for f in filesToAdd:
+                        print("  " + f)
+                print("")
+                sys.stdout.flush()
+                return True
+
             if self.edit_template(fileName):
+                if not self.no_verify:
+                    if not gitRunHook("p4-changelist", [fileName]):
+                        print("The p4-changelist hook failed.")
+                        sys.stdout.flush()
+                        return False
+
                 # read the edited message and submit
                 tmpFile = open(fileName, "rb")
                 message = tmpFile.read()
                 tmpFile.close()
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
-                submitTemplate = message[:message.index(separatorLine)]
+                if message.find(separatorLine) <> -1:
+                    submitTemplate = message[:message.index(separatorLine)]
+                else:
+                    submitTemplate = message
+
+                if len(submitTemplate.strip()) == 0:
+                    print("Changelist is empty, aborting this changelist.")
+                    sys.stdout.flush()
+                    return False
 
                 if update_shelve:
                     p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
@@ -2112,20 +2150,22 @@ def applyCommit(self, id):
 
                 submitted = True
 
+                gitRunHook("p4-post-changelist")
         finally:
-            # skip this patch
+            # Revert changes if we skip this patch
             if not submitted or self.shelve:
                 if self.shelve:
                     print ("Reverting shelved files.")
                 else:
                     print ("Submission cancelled, undoing p4 changes.")
+                sys.stdout.flush()
                 for f in editedFiles | filesToDelete:
                     p4_revert(f)
                 for f in filesToAdd:
                     p4_revert(f)
                     os.remove(f)
 
-        os.remove(fileName)
+                os.remove(fileName)
         return submitted
 
     # Export git tags as p4 labels. Create a p4 label and then tag
@@ -2349,13 +2389,12 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
-        hooks_path = gitConfig("core.hooksPath")
-        if len(hooks_path) <= 0:
-            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
-
-        hook_file = os.path.join(hooks_path, "p4-pre-submit")
-        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
-            sys.exit(1)
+        if not self.no_verify:
+            if not gitRunHook("p4-pre-submit"):
+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
+                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
+                    "however,\nthis will also skip the p4-changelist hook as well.")
+                sys.exit(1)
 
         #
         # Apply the commits, one at a time.  On failure, ask if should
-- 
gitgitgadget
