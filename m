Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D69C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A3520684
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWqjK3NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfLPOCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:02:30 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41556 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfLPOC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 09:02:26 -0500
Received: by mail-wr1-f44.google.com with SMTP id c9so7374757wrw.8
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PUL39FBIRxR5AlYKTPseu4W8cG8J2Xbt4iCySgZ6YcU=;
        b=eWqjK3NSF1osM+qg3QGafHx1vxNzBppgakEiDszvVgZkcL95OCi4vxbAZMF9TosFX+
         6CWwOesl8+pBYoeQC4yMQnQiP/OVM7nvgWF6mJ1wqATeVjQsiYyMlEXeVTWolg6vwf45
         Lj40n3vU8cDBWpm7RP0rYeH9X+843/xrHAku3bFxQzUD+SS5gwwOJ9mrKPMqqlVQpui9
         WJnMVGxds0WBCAyymcKAbGcBXlLXJmZyA3qqBMq05OVaqZ+f+aw9Ts5m/uafoaZzuk4W
         tBIFlyN6waV7Tm46EI+p7bClO/qhBVwLIH1doeIm8x2dQKyPW8RL+FdtEhPL529M+8DK
         uNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PUL39FBIRxR5AlYKTPseu4W8cG8J2Xbt4iCySgZ6YcU=;
        b=Ip1l4/TJsVfIjVl+95YfRwKxEK5m84Y3tHKnzl0BRK5JPUJ/kk+AmWOWlol+nx5Pm/
         jbnXh8dBi85eMs3arrJxth4Asvk29GKIygRLPlxnyDKBYTAD41GLc4mdEvLFXiyVhhSu
         l186gaPABMu67CuVFnqQJxFj5tJQfhNUlXGdkqicDHdKx0YtEDAw8UneTvjTMpKueI8a
         DeLhI80BaMGgHVs0GEBf3t0WFO/SIAhBvmjS2Qh+31+UrCgObZNHoBmycxlM0QlraVpZ
         dQw07wlw6oPDoH3kJ/THE7p9Rj20HwuBzERMiZuxwI7S8rVsn0i9Ba1KnUXCvoGfSffZ
         28cw==
X-Gm-Message-State: APjAAAXhpbCZf9a8NfBuHXl+N4VsJToFXs7QDLqUP6TaQkeBIAhMIi7i
        e61q8s944aNZ4oFc9dJeu8MsQp2v
X-Google-Smtp-Source: APXvYqzGaLW3si3tz1BTpd44/RLo7SmoILTtN34bAULfWSNWnv27PVgkXuIa/EfSijVxMrNFVLtgkQ==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr30551867wrm.131.1576504944239;
        Mon, 16 Dec 2019 06:02:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm20598048wmd.1.2019.12.16.06.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:02:23 -0800 (PST)
Message-Id: <7e0145fa321647e14ecb886707025ac3f516a137.1576504942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
        <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 14:02:19 +0000
Subject: [PATCH v5 1/4] git-p4: yes/no prompts should sanitize user text
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

When prompting the user interactively for direction, the tests are
not forgiving of user input format.

For example, the first query asks for a yes/no response. If the user
enters the full word "yes" or "no" or enters a capital "Y" the test
will fail.

Create a new function, prompt(prompt_text) where
  * prompt_text is the text prompt for the user
  * returns a single character where valid return values are
      found by inspecting prompt_text for single characters
      surrounded by square brackets

This new function must  prompt the user for input and sanitize it by
converting the response to a lower case string, trimming leading and
trailing spaces, and checking if the first character is in the list
of choices. If it is, return the first letter.

Change the current references to raw_input() to use this new function.

Since the method requires the returned text to be one of the available
choices, remove the loop from the calling code that handles response
verification.

Thanks-to: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 67 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..3b3f1469a6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -167,6 +167,21 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+def prompt(prompt_text):
+    """ Prompt the user to choose one of the choices
+
+    Choices are identified in the prompt_text by square brackets around
+    a single letter option.
+    """
+    choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
+    while True:
+        response = raw_input(prompt_text).strip().lower()
+        if not response:
+            continue
+        response = response[0]
+        if response in choices:
+            return response
+
 def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
@@ -1778,12 +1793,11 @@ def edit_template(self, template_file):
         if os.stat(template_file).st_mtime > mtime:
             return True
 
-        while True:
-            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
-            if response == 'y':
-                return True
-            if response == 'n':
-                return False
+        response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+        if response == 'y':
+            return True
+        if response == 'n':
+            return False
 
     def get_diff_description(self, editedFiles, filesToAdd, symlinks):
         # diff
@@ -2345,31 +2359,22 @@ def run(self, args):
                           " --prepare-p4-only")
                     break
                 if i < last:
-                    quit = False
-                    while True:
-                        # prompt for what to do, or use the option/variable
-                        if self.conflict_behavior == "ask":
-                            print("What do you want to do?")
-                            response = raw_input("[s]kip this commit but apply"
-                                                 " the rest, or [q]uit? ")
-                            if not response:
-                                continue
-                        elif self.conflict_behavior == "skip":
-                            response = "s"
-                        elif self.conflict_behavior == "quit":
-                            response = "q"
-                        else:
-                            die("Unknown conflict_behavior '%s'" %
-                                self.conflict_behavior)
-
-                        if response[0] == "s":
-                            print("Skipping this commit, but applying the rest")
-                            break
-                        if response[0] == "q":
-                            print("Quitting")
-                            quit = True
-                            break
-                    if quit:
+                    # prompt for what to do, or use the option/variable
+                    if self.conflict_behavior == "ask":
+                        print("What do you want to do?")
+                        response = prompt("[s]kip this commit but apply the rest, or [q]uit? ")
+                    elif self.conflict_behavior == "skip":
+                        response = "s"
+                    elif self.conflict_behavior == "quit":
+                        response = "q"
+                    else:
+                        die("Unknown conflict_behavior '%s'" %
+                            self.conflict_behavior)
+
+                    if response == "s":
+                        print("Skipping this commit, but applying the rest")
+                    if response == "q":
+                        print("Quitting")
                         break
 
         chdir(self.oldWorkingDirectory)
-- 
gitgitgadget

