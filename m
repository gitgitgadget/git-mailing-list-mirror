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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38379C35240
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C47D20705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBUaaL+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgAaV6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:58:19 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40336 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAaV6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:58:19 -0500
Received: by mail-wm1-f50.google.com with SMTP id t14so10442406wmi.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=39fy91fgGzKvFe/kdRqWd1b5A2SJFlQxpy83ONk/D2o=;
        b=SBUaaL+eXQyAJere8VPHpSP+gpq65ImN7y4E/aYIA/+dN/L0siB+uQVh5eW2OqzHdS
         90QGsTG3+JYMIkvcXBoCjngt91G99sC2Ma+pJUk5Yatmd1O/VePhy/ScK8/WLNtYg2PN
         4k5KsPjlGHd8B96BdOD7pGI2ZvVUeK8Ak0B1SZ33nqbyqN7QPVHxowhBeD5f7QD5dfzO
         sZvqTqDc6+ikkTmQydNr6QWfdfpotAXkdWIA9hcKOxxOt0+RuHub7PdCvMlPRXXQZPta
         7OFjIqB0xRnPKwMUBjix3OqwIssGYBM7PrANrTn42K+HNYowu3BiRtB50jy0IFXHGwTh
         CjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=39fy91fgGzKvFe/kdRqWd1b5A2SJFlQxpy83ONk/D2o=;
        b=CRDnXzx0QlbvB0v/gpMJoT2PPnOAelyVamjjBJJT47il1p03vyl4AiX5C3h2xXdPCZ
         3rJ6kuw7aoytqW88YwnwfaPYfT+R1OFd58llc3R/aK2bAQv74PJ4bqjl7Y3M+eHzwWhN
         pl2x/tM6M/wgKId0BsGBOBQ0oNoPU+yi6p8ZiJ1BPZUqnclLjvtGT3QhLqQQcNBb9FFD
         eoZHI7fqGv0UppVRpEcEWoAdCGNZyDhZLLXAU91DtVKKupquBPQnr8JobjyT3MbBwIVz
         sl4ikP+F07Q7rzaTWBDTXSjUOeSeCJEGG/aHgyMJbOutkqqfrTDW1DMS4ku7fEzA3K+e
         kWGg==
X-Gm-Message-State: APjAAAW3GdmNbktXktQJ0wHGlfBG7Clj78zY3NVGwL6finVy6boVXIEr
        S81XEhRz+GeLdvVdFgoojvBNOGqC
X-Google-Smtp-Source: APXvYqz1WaKvT9dtSU7HCBelQznzqG7XN1Lo5LYSS/JqbQOxAo7KzxlpJaTcfWUW6beUD3DUZlzbFw==
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr13975867wmi.60.1580507897292;
        Fri, 31 Jan 2020 13:58:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm13366473wrr.35.2020.01.31.13.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 13:58:16 -0800 (PST)
Message-Id: <585bdd51b258acbf438efe5a84924977778aff71.1580507895.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 21:58:12 +0000
Subject: [PATCH v2 1/4] git-p4: rewrite prompt to be Windows compatible
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

The existing function prompt(prompt_text) does not work correctly when
run on Windows 10 bash terminal when launched from the sourcetree
GUI application. The stdout is not flushed properly so the prompt text
is not displayed to the user until the next flush of stdout, which is
quite confusing.

Change this method by:
* Adding flush to stderr, stdout, and stdin
* Use readline from sys.stdin instead of raw_input.

The existing strip().lower() are retained.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 40d9e7c594..7d8a5ee788 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -175,7 +175,11 @@ def prompt(prompt_text):
     """
     choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
     while True:
-        response = raw_input(prompt_text).strip().lower()
+        sys.stderr.flush()
+        sys.stdout.write(prompt_text)
+        sys.stdout.flush()
+        sys.stdin.flush()
+        response=sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
-- 
gitgitgadget

