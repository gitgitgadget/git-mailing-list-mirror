Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B1C35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117D120679
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 19:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="FTdSBku+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgBBTWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 14:22:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38437 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgBBTWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 14:22:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so15237939wrh.5
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 11:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcFm9TyQCu9kfNFd9XVfL91/Pe1050507TfWejm20gc=;
        b=FTdSBku+MDBjXijiDTnZqti03cMl7weaG858xJHlB770NOqXP/XSuf+XshKjcXdM8W
         6JyNHf4UI/eY8/9o389CthOqoYsR6eooRJog76wdoYo06eYRYfToIMDUZdHRa4jNx0qM
         W8mQuzpWtZjI0MHHXl+xZxNMOFCpab/vftCjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcFm9TyQCu9kfNFd9XVfL91/Pe1050507TfWejm20gc=;
        b=fYJtwjjyvX2RCZzIOGjKAaatXKtjzXdrxnMQ5oT91GvLzH7zW/kYG93D33KPPVT8OH
         LVywLFtq2rWXVo7L40XscHY6s78A3rqS4y/0R0WhXcLiyO+5pjhEJ6jIhIF+7iwVW5qm
         X/cd5R1IotCcMh4N7QHjXQKCjZSWv8FlSVh5JiroMsbPViHXw66tk2Ogcuj+io6WeFlX
         HzlFAajhyvctauj117cru5OLsQxPWZIsTYv1Kr8856dRUkokcMw7E3HPhnDLddpI7ZfX
         ZNcz1l2wSdLerVhGGMjrtLboBtGDiTCextuxQ5u7rrMUi2pBPkp/GfstJbd6g3CKgVK0
         6gJA==
X-Gm-Message-State: APjAAAUEhoXDg3aaoaPzlqKXuYJKbmLK12NzN3Z12odT5F16AXnN6ShU
        mLkCxtsni+qnJHsneFvvb2KGXib71LKIOg==
X-Google-Smtp-Source: APXvYqwqNUqBSggfCzCTr375YjfCiG0pttsRQQc0hkfbXg5kPfpoDrP6FqupZh59KvuEGJSyxfFpJQ==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr10943908wrp.17.1580671355621;
        Sun, 02 Feb 2020 11:22:35 -0800 (PST)
Received: from Wheatley.home (host86-185-221-158.range86-185.btcentralplus.com. [86.185.221.158])
        by smtp.gmail.com with ESMTPSA id z133sm21442344wmb.7.2020.02.02.11.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Feb 2020 11:22:35 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Ramkumar Ramachandra <artagnon@gmail.com>,
        Phil Hord <phil.hord@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff-options.txt: correct command syntax
Date:   Sun,  2 Feb 2020 19:22:26 +0000
Message-Id: <20200202192226.29176-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the example arguments in the description of the -G diff argument
to be consistent throughout the description.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 Documentation/diff-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 09faee3b44..84a74cb2da 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -561,19 +561,19 @@ Binary files are searched as well.
 -G<regex>::
 	Look for differences whose patch text contains added/removed
 	lines that match <regex>.
 +
 To illustrate the difference between `-S<regex> --pickaxe-regex` and
 `-G<regex>`, consider a commit with the following diff in the same
 file:
 +
 ----
 +    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
 ...
 -    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
 ----
 +
-While `git log -G"regexec\(regexp"` will show this commit, `git log
--S"regexec\(regexp" --pickaxe-regex` will not (because the number of
+While `git log -G<regex>` will show this commit, `git log
+-S<regex> --pickaxe-regex` will not (because the number of
 occurrences of that string did not change).
 +
 Unless `--text` is supplied patches of binary files without a textconv
-- 
2.25.0

