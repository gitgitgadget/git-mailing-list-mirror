Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9442C2D0C9
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D107227BF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfAWTHTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfLLTqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:46:32 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35907 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfLLTqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 14:46:32 -0500
Received: by mail-wm1-f44.google.com with SMTP id p17so3942490wma.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 11:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mxPNmL42A2h9fz4vlUNjq/E7qrLDc1321UtNAOa5VIw=;
        b=LfAWTHTwtZtqLSq19JpPkYWb3ytphBzcVwViXQiROUNlIVvr8WckML1k17cX0tBOvw
         oICPaUc/wztehqwyFvdU+xT/6IPBcE1/cL682Xml7gPqf6NncEeMNVTMU/RW/86kTA5Q
         4fliCutexKsu+F5eoOjnTZQpydsGkY1v3CWHcltaQ2eA6T/xldq3FiIrBogutjuFqU2U
         7Or2tchGtYah/OkGwgqezTQqE7IPEc+lhNJ4aZTgP+lkYxSM5NBf9a35LlKi55Pp3iFr
         42kxHVKBtqy7LcpgSNzEYyfYnQT1QBPzXmZJqQwSICVRi44xu/7W4mKr/fvs5h3k8Gzc
         6YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mxPNmL42A2h9fz4vlUNjq/E7qrLDc1321UtNAOa5VIw=;
        b=VkvA3t0GgZ8zpHfre0UGPEfyOIGiRhLg9Vs0B3ni2+XUcPwfhr4oMbg0Ybwtnst1Si
         KekzrPyPAE5lzDGk8bQj37VOzNUDmiBfqF1qLhM3mw1Ir5dsz89a+JeD9jzaDHFfdVgD
         v3v5GuSnJttXTF3cbM1asWPm6JUrRQMqfvgb5aABQ8bxo9OQu11z9UODkkEc6sT/Ej63
         Zoq3MgMbawEVSWVCxBh4QjPw917+eStDgBTbC6XX0FB3xBUdmdTkz6YYrUd58Q34Odmk
         gMtEs0HuudPufl2xqdrd+XAgpOCc+njqr+cqeP3N1pRfCVkQrSaNct/KkeDGc7VvgSd/
         64ug==
X-Gm-Message-State: APjAAAWW1t3/ainJE1v6xXN0T/mupuC5l80KLzoDxraZRTGm+EnokFJh
        VUZ1RbyzPawGvZfDkmUqBN/0FV3m
X-Google-Smtp-Source: APXvYqxPk5fImtwpnyJlX8lUO8OKo9U3M9dvlng9BPgnnbTlUnE2HVoMNAKRQEHhvrU4MxJiOlqBFA==
X-Received: by 2002:a1c:f601:: with SMTP id w1mr3951333wmc.129.1576179988719;
        Thu, 12 Dec 2019 11:46:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 62sm7806660wmb.27.2019.12.12.11.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:46:28 -0800 (PST)
Message-Id: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 19:46:23 +0000
Subject: [PATCH v3 0/4] git-p4: Usability enhancements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some user interaction with git-p4 is not as user-friendly as the rest of the
Git ecosystem. Here are three areas that can be improved on:

1) When a patch fails and the user is prompted, there is no sanitization of
the user input so for a "yes/no" question, if the user enters "YES" instead
of a lowercase "y", they will be re-prompted to enter their answer. 

Commit 1 addresses this by sanitizing the user text by trimming and
lowercasing their input before testing. Now "YES" will succeed!

2) Git can handle scraping the RCS Keyword expansions out of source files
when it is preparing to submit them to P4. However, if the config value
"git-p4.attemptRCSCleanup" isn't set, it will just report that it fails.

Commit 2 adds a helpful suggestion, that the user might want to set
git-p4.attemptRCSCleanup.

3) If the command line arguments are incorrect for git-p4, the program
reports that there was a syntax error, but doesn't show what the correct
syntax is.

Commit 3 displays the context help for the failed command.

Ben Keene (4):
  git-p4: yes/no prompts should sanitize user text
  git-p4: show detailed help when parsing options fail
  git-p4: wrap patchRCSKeywords test to revert changes on failure
  git-p4: failure because of RCS keywords should show help

 git-p4.py | 94 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 34 deletions(-)


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-675%2Fseraphire%2Fseraphire%2Fp4-usability-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-675/seraphire/seraphire/p4-usability-v3
Pull-Request: https://github.com/git/git/pull/675

Range-diff vs v2:

 1:  527b7b8f8a ! 1:  fff93acf44 git-p4: yes/no prompts should sanitize user text
     @@ -9,9 +9,12 @@
          enters the full word "yes" or "no" or enters a capital "Y" the test
          will fail.
      
     -    Create a new function, prompt(prompt_text, choices) where
     +    Create a new function, prompt(prompt_text) where
            * promt_text is the text prompt for the user
     -      * is a list of lower-case, single letter choices.
     +      * choices are extracted from the prompt text [.]
     +          a single letter surrounded by square brackets
     +          is selected as a valid choice.
     +
          This new function must  prompt the user for input and sanitize it by
          converting the response to a lower case string, trimming leading and
          trailing spaces, and checking if the first character is in the list
     @@ -19,6 +22,10 @@
      
          Change the current references to raw_input() to use this new function.
      
     +    Since the method requires the returned text to be one of the available
     +    choices, remove the loop from the calling code that handles response
     +    verification.
     +
          Signed-off-by: Ben Keene <seraphire@gmail.com>
      
       diff --git a/git-p4.py b/git-p4.py
     @@ -28,12 +35,16 @@
               sys.stderr.write(msg + "\n")
               sys.exit(1)
       
     -+def prompt(prompt_text, choices = []):
     ++def prompt(prompt_text):
      +    """ Prompt the user to choose one of the choices
     ++
     ++    Choices are identified in the prompt_text by square brackets around
     ++    a single letter option.
      +    """
     ++    choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
      +    while True:
      +        response = raw_input(prompt_text).strip().lower()
     -+        if len(response) == 0:
     ++        if not response:
      +            continue
      +        response = response[0]
      +        if response in choices:
     @@ -43,22 +54,73 @@
           if verbose:
               sys.stderr.write('Writing pipe: %s\n' % str(c))
      @@
     +         if os.stat(template_file).st_mtime > mtime:
                   return True
       
     -         while True:
     +-        while True:
      -            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
     -+            response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ", ["y", "n"])
     -             if response == 'y':
     -                 return True
     -             if response == 'n':
     +-            if response == 'y':
     +-                return True
     +-            if response == 'n':
     +-                return False
     ++        response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
     ++        if response == 'y':
     ++            return True
     ++        if response == 'n':
     ++            return False
     + 
     +     def get_diff_description(self, editedFiles, filesToAdd, symlinks):
     +         # diff
      @@
     -                         # prompt for what to do, or use the option/variable
     -                         if self.conflict_behavior == "ask":
     -                             print("What do you want to do?")
     +                           " --prepare-p4-only")
     +                     break
     +                 if i < last:
     +-                    quit = False
     +-                    while True:
     +-                        # prompt for what to do, or use the option/variable
     +-                        if self.conflict_behavior == "ask":
     +-                            print("What do you want to do?")
      -                            response = raw_input("[s]kip this commit but apply"
      -                                                 " the rest, or [q]uit? ")
     -+                            response = prompt("[s]kip this commit but apply"
     -+                                                 " the rest, or [q]uit? ", ["s", "q"])
     -                             if not response:
     -                                 continue
     -                         elif self.conflict_behavior == "skip":
     +-                            if not response:
     +-                                continue
     +-                        elif self.conflict_behavior == "skip":
     +-                            response = "s"
     +-                        elif self.conflict_behavior == "quit":
     +-                            response = "q"
     +-                        else:
     +-                            die("Unknown conflict_behavior '%s'" %
     +-                                self.conflict_behavior)
     +-
     +-                        if response[0] == "s":
     +-                            print("Skipping this commit, but applying the rest")
     +-                            break
     +-                        if response[0] == "q":
     +-                            print("Quitting")
     +-                            quit = True
     +-                            break
     +-                    if quit:
     ++                    # prompt for what to do, or use the option/variable
     ++                    if self.conflict_behavior == "ask":
     ++                        print("What do you want to do?")
     ++                        response = prompt("[s]kip this commit but apply the rest, or [q]uit? ")
     ++                    elif self.conflict_behavior == "skip":
     ++                        response = "s"
     ++                    elif self.conflict_behavior == "quit":
     ++                        response = "q"
     ++                    else:
     ++                        die("Unknown conflict_behavior '%s'" %
     ++                            self.conflict_behavior)
     ++
     ++                    if response == "s":
     ++                        print("Skipping this commit, but applying the rest")
     ++                    if response == "q":
     ++                        print("Quitting")
     +                         break
     + 
     +         chdir(self.oldWorkingDirectory)
     +@@
     + 
     + if __name__ == '__main__':
     +     main()
     ++
 2:  1d4f4e210b = 2:  5c5c981632 git-p4: show detailed help when parsing options fail
 3:  20aa557193 = 3:  c466e79148 git-p4: wrap patchRCSKeywords test to revert changes on failure
 4:  50e9a175c3 ! 4:  00307c3951 git-p4: failure because of RCS keywords should show help
     @@ -23,7 +23,7 @@
      +                # They do not have attemptRCSCleanup set, this might be the fail point
      +                # Check to see if the file has RCS keywords and suggest setting the property.
      +                for file in editedFiles | filesToDelete:
     -+                    if p4_keywords_regexp_for_file(file) != None:
     ++                    if p4_keywords_regexp_for_file(file) is not None:
      +                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
      +                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
      +                        break

-- 
gitgitgadget
