Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F8C2D0BE
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D120661
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJDEFBlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfLDW34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37071 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbfLDW3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so1539459wmf.2
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P3NS7SOafgOGxasVXp35ajnW/qv3DzAtEW2MjvpUDls=;
        b=BJDEFBlqog8qiZJpfMr7GVQaqDNcbkibJC+M18qVSb9PYUjZowJ9wQiIYUVare0oT7
         bE0zkiIHCy2e6g57p+29P5wbeZZ8EC/PdyWl+Ru7x6xxasHoL5y7WBLhYSlOMCE0Hgct
         zeAXSLFCtndSDta+35e8MOmmLo8uPcbw2ArM7iGQcnXV194IzyufJ5QFrhoOrl86+3lt
         bsFHmBX4Rktme047C2vf3TkqNBWyKl62XkG/YAi9p1bYutBRXAAfC8PmQYzE0UghKhdu
         tXRvFfZgZ6kJHfyj3HRmN9LiLZnrRt4HPkswLVIWpnaLJxT0PutyKOnWW93gqtG++2//
         dXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P3NS7SOafgOGxasVXp35ajnW/qv3DzAtEW2MjvpUDls=;
        b=ivbKSLB37a7IgWNcWW3eck+FdKGa5aaKSk12r2deU7kGWQ43lgA/Z7s8ScxUbv5Z4H
         SPW1kH54Yvb2Z3fB896z1jhbLkfeZzYfIgAfbtbLGDye5CDOk0mLI+qvH6Imwyr5tcX1
         bFB1rkcnshEdCcO7mYXGYByTcYtaGXlFI/aPG9ZFDOqFl5XLMvZJ7N9AsYWxMvI9Syo2
         LkQ2t3Fwsu1/awDJhBHyQwRja8AMOq49bBLRlsHkFAPvhG9CGd9TM6PjkMH+6eYyOMXL
         6eRc5RvhcPhp2f+qw4RD5xmTAa7/uqU9/PYzNz5XtuIVoWyYN8E6SOyENCnc4C5oXvLg
         ZqXQ==
X-Gm-Message-State: APjAAAV/+uGiEe7CIZTsYHePnSRu7ovzZ562bZLFBvKxfrWMlZci7nDb
        qEWJd/rAwfiKV1f2+VO4hsZ7qoWD
X-Google-Smtp-Source: APXvYqxm2aj/Cl17aLzjTIwZvWsxZeo+DSWOTtRRFn9+qSHuL1fIurF6oBbQavdjjPh09Lksf9WTxg==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr2053376wml.65.1575498586742;
        Wed, 04 Dec 2019 14:29:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i127sm8890170wma.35.2019.12.04.14.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:46 -0800 (PST)
Message-Id: <4fc49313f0d68a913ad19085ddb337ac4c18d0fe.1575498578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:35 +0000
Subject: [PATCH v4 09/11] git-p4: Add usability enhancements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Issue: when prompting the user with raw_input, the tests are not forgiving of user input.  For example, on the first query asks for a yes/no response. If the user enters the full word "yes" or "no" the test will fail. Additionally, offer the suggestion of setting git-p4.attemptRCSCleanup when applying a commit fails because of RCS keywords. Both of these changes are usability enhancement suggestions.

Change the code prompting the user for input to sanitize the user input before checking the response by asking the response as a lower case string, trimming leading/trailing spaces, and returning the first character.

Change the applyCommit() method that when applying a commit fails becasue of the P4 RCS Keywords, the user should consider setting git-p4.attemptRCSCleanup.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit 1fab571664f5b6ad4ef321199f52615a32a9f8c7)
---
 git-p4.py | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f7c0ef0c53..f13e4645a3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1909,7 +1909,8 @@ def edit_template(self, template_file):
             return True
 
         while True:
-            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ").lower() \
+                .strip()[0]
             if response == 'y':
                 return True
             if response == 'n':
@@ -2069,8 +2070,23 @@ def applyCommit(self, id):
                     # disable the read-only bit on windows.
                     if self.isWindows and file not in editedFiles:
                         os.chmod(file, stat.S_IWRITE)
-                    self.patchRCSKeywords(file, kwfiles[file])
-                    fixed_rcs_keywords = True
+                    
+                    try:
+                        self.patchRCSKeywords(file, kwfiles[file])
+                        fixed_rcs_keywords = True
+                    except:
+                        # We are throwing an exception, undo all open edits
+                        for f in editedFiles:
+                            p4_revert(f)
+                        raise
+            else:
+                # They do not have attemptRCSCleanup set, this might be the fail point
+                # Check to see if the file has RCS keywords and suggest setting the property.
+                for file in editedFiles | filesToDelete:
+                    if p4_keywords_regexp_for_file(file) != None:
+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
+                        break
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
@@ -2481,7 +2497,7 @@ def run(self, args):
                         if self.conflict_behavior == "ask":
                             print("What do you want to do?")
                             response = raw_input("[s]kip this commit but apply"
-                                                 " the rest, or [q]uit? ")
+                                                 " the rest, or [q]uit? ").lower().strip()[0]
                             if not response:
                                 continue
                         elif self.conflict_behavior == "skip":
@@ -4327,7 +4343,12 @@ def main():
                                    description = cmd.description,
                                    formatter = HelpFormatter())
 
-    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    try:
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    except:
+        parser.print_help()
+        raise
+
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-- 
gitgitgadget

