Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB518C3B19F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A923224649
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJwsEMPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgBNOoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:44:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39533 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgBNOoy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so11178709wrt.6
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sGRNsxuyHRz+riv06aTjXiqn20BEbLaF2huS2hqI0+M=;
        b=vJwsEMPVAThtE9WjlIRtK3C5bP4YjnR2mzkldaD/XrII6j6ckn+EBJaTtc/GsRHExO
         igmaONISYSTY92m+bzZnK6EU0OX2AFo5LpHlso+V/6YP5pUFn44E3++3FbUqwwCORCcK
         HBLTv2n/4X68IBcOwPN7JgFxVTEjk2ZDWS38cQSVfvJ0QBlzJW1AS1l7uWt7kO75w9PC
         Y0bxqN4tKyF+i7XhLoJHVzAY4E73JylIyt2iGtMszGZZA8EQr6zANN+NRzHevkW/Io3G
         BGkmatawMmwqE9eBW7iPcZaKLyrhV0Y0cjMAFp++nBIiWRs0A3z54UANMjm9n18LjZHE
         XXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sGRNsxuyHRz+riv06aTjXiqn20BEbLaF2huS2hqI0+M=;
        b=oKRNGUMINdPcKc/frpGqcIODjd2IqtE5+8ruMJJTlwmbvdQoMyMjjrRCYQaU0wYjiG
         Y9sZToFeWBS1fTz0lBB9jp9foVa5S+p7iyioZ4dZ+EneRQMY/QoQqFTqkmCsqsienIwh
         LRRrchBSY99TepVEsb4QJ7VP427KkWvKdYCgWWD4ppacFwtL/PXAfuWfiP5bsLM4xSJS
         m+q4KnGnaMlgsXBzpveYaznFwNesmnCYSnkd1BHXlo5wN/w36a9tdTPREatUCKIuHbM7
         mNZxb5rQEn4oRHLJMCn4KaOVn/0z8T2X8GFBvZIzKL5o99ZCqcabWH9wCKfoQ/4hIpq/
         pJ9w==
X-Gm-Message-State: APjAAAVdvN7COn85r09d9eoESMCeBIx9YQ6KUUFA2APVzZ+bf/wLLX1H
        Q+D8IzvxNDG+/8mKLeqg6D8mE7yO
X-Google-Smtp-Source: APXvYqyKKLG876SdQuM2q3DvRbZMMGuNwzxzpEF//6g9e1WXXm5M1JrfCORlFlF8Nfy9QWerEO+XWQ==
X-Received: by 2002:a5d:61d1:: with SMTP id q17mr4547503wrv.156.1581691491885;
        Fri, 14 Feb 2020 06:44:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4sm4233294wra.14.2020.02.14.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:44:51 -0800 (PST)
Message-Id: <22ac4384bd5e68709ee03ac0beaaff7e3d39fe51.1581691486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
References: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
        <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 14:44:44 +0000
Subject: [PATCH v6 5/7] git-p4: restructure code in submit
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

In preparation for adding new hooks to the submit method of git-p4,
restructure the applyCommit function in the P4Submit class.  Make the
following changes:

* Move all the code after the definition of submitted = False into the
  Try-Finally block. This ensures that any error that occurs will
  properly recover.  This is not necessary with the current code because
  none of it should throw an exception, however the next set of changes
  will introduce exceptional code.

  Existing flow control can remain as defined - the if-block for
  prepare-p4-only sets the local variable "submitted" to True and exits
  the function. New early exits, leave submitted set to False so the
  Finally block will undo changes to the P4 workspace.

* Make the small usability change of adding an empty string to the
  print statements displayed to the user when the prepare-p4-only option
  is selected.  On Windows, the command print() may display a set of
  parentheses "()" to the user when the print() function is called with
  no parameters. By supplying an empty string, the intended blank line
  will print as expected.

* Fix a small bug when the submittedTemplate is edited by the user
  and all content in the file is removed. The existing code will throw
  an exception if the separateLine is not found in the file. Change this
  code to test for the separator line using a find() test first and only
  split on the separator if it is found.

* Additionally, add the new behavior that if the changelist file has
  been completely emptied that the Submit action for this changelist
  will be aborted.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 92 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c969d9235b1..4ae6aa30f06 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2102,47 +2102,47 @@ def applyCommit(self, id):
         tmpFile.write(submitTemplate)
         tmpFile.close()
 
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
                 # read the edited message and submit
                 tmpFile = open(fileName, "rb")
@@ -2150,7 +2150,15 @@ def applyCommit(self, id):
                 tmpFile.close()
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
-                submitTemplate = message[:message.index(separatorLine)]
+                if message.find(separatorLine) != -1:
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
@@ -2174,19 +2182,21 @@ def applyCommit(self, id):
                 submitted = True
 
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
+            if not self.prepare_p4_only:
+                os.remove(fileName)
         return submitted
 
     # Export git tags as p4 labels. Create a p4 label and then tag
-- 
gitgitgadget

