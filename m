Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3903C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F4420838
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3eKEpj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBFPPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:15:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35922 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgBFPPx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 10:15:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so7677383wru.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 07:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=39fy91fgGzKvFe/kdRqWd1b5A2SJFlQxpy83ONk/D2o=;
        b=K3eKEpj1oH05ILbmADt/HWLfMaMhkMw/6G0P4g83dJ/uQNrVk/CmCR417IGpZEp+u2
         ADffSfMcpLf+F+H8zqbz7AUS49tvy+SKkKppKcvqGynhIbfM5iydWWTAUmg2SLSKIOKS
         8w05Rzpp8HbqVcLT34f2E8iu53Vsx0sb0DM9KL12nfz+0kiTWroA+X6bmKAkaKyJSELa
         fqBnRNCX9Y/4ZSQmzLGjuLsVxIrd60cDT+N0RkCyS1JoQKytA4FQYxHULt3CbuwQJLGA
         XrzG6UWG27p49JpHiwysXpU7IlKPAL9GPxdQ7oYbHqNFEDkxIiGvLLkCU7M32hn89tX9
         uezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=39fy91fgGzKvFe/kdRqWd1b5A2SJFlQxpy83ONk/D2o=;
        b=cJUcfZJbIi9MhQmmUZDlP6BTU98ue9oljtbOQrfm1aSubgfOjz/hXqXwgxlPso+TTm
         XXo/yaWNFMLvcvhQAslSz6fBqhCUiAB0n0qudRuO8HuUt3tApMNqFDv+bCT+97tcisrW
         2MhqAxXvkmTt8FAS8OzSIL2s7w5zeipTFafwOTI5yvbXgBvy3zuC/Unbxyiv8Q3Yszi1
         2yksbOrF2H3Z8ahuEpeEU++A4r9m76jrJUqVCTPjQuI/zdRbVs3HQSPlLTpYw44eP70L
         ad3lcLnSHAyREhlcUUEsoSwLctDKZUYVowqj3SGI0jzEjrD/AZCiii55CF7l2IqVnGBu
         YQpw==
X-Gm-Message-State: APjAAAWt07fFajgeD9zzxcv/VkPJ4AOC3SVPaqeqDhIWCUgBakgik16D
        8E1ytNV99hZ89Db/S3HOGUS/BQvI
X-Google-Smtp-Source: APXvYqwobSUILDjXFy8C762ruXEpAsTdPE5OcTGpaXwZwXjoRgcszfAUKtzoLT2B+MEW7buqlq/90w==
X-Received: by 2002:adf:e984:: with SMTP id h4mr4342760wrm.275.1581002151440;
        Thu, 06 Feb 2020 07:15:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z19sm3845327wmi.35.2020.02.06.07.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:15:50 -0800 (PST)
Message-Id: <8881d76c46ce0af9a7e3c9e8d61c718beea24906.1581002149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 15:15:44 +0000
Subject: [PATCH v3 1/5] git-p4: rewrite prompt to be Windows compatible
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

