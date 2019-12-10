Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD689C2D0BF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8915D20637
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CigF9h1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLJPXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:23:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55090 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJPW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 10:22:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so3673788wmj.4
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 07:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D/nQNxrNbwRfXVw8XexasmfnpnH2eZZ4j/OiEmWOZXM=;
        b=CigF9h1tE/mme9B3muYGdf+tJjp2uk/itC8S2Bnky3uEte7ezSd9k4CwCwmuJyo6Y6
         cL3itIUvaLxEhVwBzgrPM8PxJwaMf3lF4SGmGZrhZ+RSTBWM5XCrVsncUsOwSllNnuxg
         xLYjtPSMLmZEDFDNFDY0bgDwATxSKEyGTloA0avN1PQ78D496iTagjBKvQGoxda+lnO8
         06enSIsK1+vkfJSXbbHKrfQhO22VDAfIDGOLG1qsDbHHpUzNC855yo2HPAcIfFZy/P37
         jauY6mgZbz+zZxQXbxJHwUMF1kjZzsUl+2Y4k0O2DcyaBa/WYzTyfhxpy/jAialrjNym
         YBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D/nQNxrNbwRfXVw8XexasmfnpnH2eZZ4j/OiEmWOZXM=;
        b=qTdT1LBOzbQEsXwHiSdaNxJTxRlCXxc8Tr+KTq52mP7+DQdMMcrCZ8MZMwbf7bob3n
         hPCLHymwvrjb028JymZqf3E8s0LVUXrcxEzSnnP/S2eZorVeRBlGZTZY1KPOgCjVkcTZ
         ih9mAgUzWYu0jI7gKdJfhGtWQwFoKERg/cjWrjB4c0JqWh2UH1XcLRYBoXIA4r35dtwg
         kh1qlxu7jGD7W3QkHGH95NYG5y9fnkR+HgPDCmKbC9KKaOgX8bV1yN6rUk58lCJ+xUwi
         W6QFUY1iB5qTJ+jfqdNRyFwu8eNU3/oKjTOTD0bVwI6DDz4+Qd8sZ/yRXXhFYPxQEdet
         752A==
X-Gm-Message-State: APjAAAUnAZ63vm9svxxzruWooodYyoyY15eQkUK8HseUS+KE2cw7hZHZ
        l6jhB9UfyHW8kcBdLLAUqIiE649C
X-Google-Smtp-Source: APXvYqyjYQEhozj+TVAEj2Kii1ph7GEwJSBTCsbC8bvNXj2j5coSIOWs4TEWshr3m3J+Nt1CanjU6A==
X-Received: by 2002:a1c:1d8:: with SMTP id 207mr5787747wmb.155.1575991376553;
        Tue, 10 Dec 2019 07:22:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm3582333wrw.52.2019.12.10.07.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 07:22:56 -0800 (PST)
Message-Id: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 15:22:50 +0000
Subject: [PATCH v2 0/4] git-p4: Usability enhancements
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

 git-p4.py | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)


base-commit: 083378cc35c4dbcc607e4cdd24a5fca440163d17
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-675%2Fseraphire%2Fseraphire%2Fp4-usability-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-675/seraphire/seraphire/p4-usability-v2
Pull-Request: https://github.com/git/git/pull/675

Range-diff vs v1:

 1:  e721cdaa00 ! 1:  527b7b8f8a git-p4: [usability] yes/no prompts should sanitize user text
     @@ -1,6 +1,6 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: [usability] yes/no prompts should sanitize user text
     +    git-p4: yes/no prompts should sanitize user text
      
          When prompting the user interactively for direction, the tests are
          not forgiving of user input format.
 3:  2a10890ef7 ! 2:  1d4f4e210b git-p4: [usability] Show detailed help when parsing options fail
     @@ -1,6 +1,6 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: [usability] Show detailed help when parsing options fail
     +    git-p4: show detailed help when parsing options fail
      
          When a user provides invalid parameters to git-p4, the program
          reports the failure but does not provide the correct command syntax.
 2:  d608f529a0 ! 3:  20aa557193 git-p4: [usability] RCS Keyword failure should suggest help
     @@ -1,14 +1,13 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: [usability] RCS Keyword failure should suggest help
     +    git-p4: wrap patchRCSKeywords test to revert changes on failure
      
     -    When applying a commit fails because of RCS keywords, Git
     -    will fail the P4 submit. It would help the user if Git suggested that
     -    the user set git-p4.attemptRCSCleanup to true.
     +    The patchRCSKeywords function has the potentional of throwing
     +    an exception and this would leave files checked out in P4 and partially
     +    modified.
      
     -    Change the applyCommit() method that when applying a commit fails
     -    becasue of the P4 RCS Keywords, the user should consider setting
     -    git-p4.attemptRCSCleanup to true.
     +    Add a try-catch block around the patchRCSKeywords call and revert
     +    the edited files in P4 before leaving the method.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
      
     @@ -30,14 +29,6 @@
      +                        for f in editedFiles:
      +                            p4_revert(f)
      +                        raise
     -+            else:
     -+                # They do not have attemptRCSCleanup set, this might be the fail point
     -+                # Check to see if the file has RCS keywords and suggest setting the property.
     -+                for file in editedFiles | filesToDelete:
     -+                    if p4_keywords_regexp_for_file(file) != None:
     -+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
     -+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
     -+                        break
       
                   if fixed_rcs_keywords:
                       print("Retrying the patch with RCS keywords cleaned up")
 -:  ---------- > 4:  50e9a175c3 git-p4: failure because of RCS keywords should show help

-- 
gitgitgadget
