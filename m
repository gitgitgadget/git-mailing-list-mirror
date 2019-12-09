Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAA8C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DB720726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/sivd8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfLIOQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:16:56 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40227 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfLIOQx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:16:53 -0500
Received: by mail-wr1-f52.google.com with SMTP id c14so16371893wrn.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I8b8jus+gL9qTMtX2MUVL0s1hihf58yRSrMe9WY6y50=;
        b=q/sivd8qjHP/ZVNGyZvN721VIEhifgmpu4p7hjzp8tCoy9equppCyOGPEu+gLXkjco
         8+XNaR/kQnbLFCtPd+CDtq7YPgTIE/G51iT9L27RSv7PJ5QEgb4thS1AmxA8s8dGiv14
         K/saBDh+sJKQF+CyXqNrBPk3ZpUzkCoBgjzHqSB8D/KqyFIEQ+X8PZ7ueYRO7O6ivR0b
         NCfZoSAIdQmuHV6ReQixUL5arLO/XUEys5G/cH1CYSGWrSpSHfY7xMn7NxkiaOofLNBy
         LrNVXcBAY8wAtEZM3/8YepcmvNF2kLFboej6AtIN/YkVq/safyK8CFtaAFTsMIOC5ybh
         wt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I8b8jus+gL9qTMtX2MUVL0s1hihf58yRSrMe9WY6y50=;
        b=YmDGY/5tVPluBCF5WPjNUtbOPeAbLXTTMJaGc/OaBRt2Gmwx3j4mq///vPGznygt/z
         2eltQyQ9UsmjhGYI9jHxYSHJ5uw+PwNsKGWpMT4Rgbgoy0P0Qjw+M9mPc2m5zHeVqMd/
         MRpbMtLqdvD7AHoOZGyJq4XBVKbdeukuTyWVk8/HwpEZ8my8BDTirQWbJK7aSIzkPsJ5
         Nhh+GHDy4J0rHPtjwY8qlMAANAA/c2+0cbeyKzpdzujlHiCV0KuaFYqFqLzNl6nArgxA
         g+P1v9bTWcx37aqpwOVMcJC7LdjBZTqs/+m71iLT9+gBJAiOy1PkB2IfcqGRsRyKvOC4
         LImg==
X-Gm-Message-State: APjAAAULH9bB75pDsO1tJUzqKUm6GOZ2QEAeGbLYxTbypVGBMeEMLtpr
        SLtusYarRCJ6kN8I574TQJKYr9UR
X-Google-Smtp-Source: APXvYqzjEgmDQsJNb7g3ZoQviAugZugx+QPOjzk950fiOsNp7lvJu4/IbasWI1BxHLzMznCFLwkn5w==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr2495595wrq.199.1575901011648;
        Mon, 09 Dec 2019 06:16:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm14129536wmi.18.2019.12.09.06.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:16:51 -0800 (PST)
Message-Id: <e721cdaa008263b896c1d162e411c4e7a04c5710.1575901009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:16:47 +0000
Subject: [PATCH 1/3] git-p4: [usability] yes/no prompts should sanitize user
 text
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

Create a new function, prompt(prompt_text, choices) where
  * promt_text is the text prompt for the user
  * is a list of lower-case, single letter choices.
This new function must  prompt the user for input and sanitize it by
converting the response to a lower case string, trimming leading and
trailing spaces, and checking if the first character is in the list
of choices. If it is, return the first letter.

Change the current references to raw_input() to use this new function.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..0fa562fac9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -167,6 +167,17 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+def prompt(prompt_text, choices = []):
+    """ Prompt the user to choose one of the choices
+    """
+    while True:
+        response = raw_input(prompt_text).strip().lower()
+        if len(response) == 0:
+            continue
+        response = response[0]
+        if response in choices:
+            return response
+
 def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
@@ -1779,7 +1790,7 @@ def edit_template(self, template_file):
             return True
 
         while True:
-            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+            response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ", ["y", "n"])
             if response == 'y':
                 return True
             if response == 'n':
@@ -2350,8 +2361,8 @@ def run(self, args):
                         # prompt for what to do, or use the option/variable
                         if self.conflict_behavior == "ask":
                             print("What do you want to do?")
-                            response = raw_input("[s]kip this commit but apply"
-                                                 " the rest, or [q]uit? ")
+                            response = prompt("[s]kip this commit but apply"
+                                                 " the rest, or [q]uit? ", ["s", "q"])
                             if not response:
                                 continue
                         elif self.conflict_behavior == "skip":
-- 
gitgitgadget

