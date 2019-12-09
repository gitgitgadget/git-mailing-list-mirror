Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C5CC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D124B2073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2n7piwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfLIOQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:16:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34802 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLIOQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:16:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id f4so2257wmj.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vd8+z17j4VK0u5J6krr0X2M8OZkmdtEv7OsSorJ2WAM=;
        b=T2n7piwGjwZFASmngUSjDDQrp0AHyI0BTeIt19hIjreNAX8p19K8AnDCO2454QipxB
         ayodOqh67JntGbvlrjWjOwfnBQG3ziSBPRsJy5I366ghROmBIBYhsmguVqvyEI/hvgw8
         u2eMZoNyOEwKneSYVvmUHgY8VE8ACrZVFtS3ie4KkcRwwTC87KyUp8b9GYYjfnvZOCGg
         OO0m12kl2Tr/2lwUn1klTN48sbczvtmBBFfgKt67xeArJJNwDZbS1OAhebKtTT0D9a0U
         ZfbCs923kuDpIuLWhgxn5hDzi70CiyqusH3KccH4l6A52Om8XSkAp0V3/nu9afhupaQ9
         D1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vd8+z17j4VK0u5J6krr0X2M8OZkmdtEv7OsSorJ2WAM=;
        b=q8xWmJaz4/SXOLkk/mNZQtRToGpXuEJcK6/3wab57txS7f/yvvpANvlFZglsur/ni9
         mV/f4x9sAzNkZym+W79KZ9gQ2QdytGV42gpi64iVt5hMd1h4asz5aEfZYE6B0xSaGFoI
         NirVA2UoAQs0j5WXkNW7wlYMFfuw7CFzh6bKTYQbilZmD99AfHY+QTR45RZaoLf3KzuR
         aZRJLi+Ub1MuzrCAfXzGc3+12atI9eC09DWD2ireew2s5Z1sRoHx6iYfZ7KYnenCoT2o
         yfM2HU6zYgPlIFToN8wm4iipmaEU60NRVj4Y/Zvf9xoORwfzIYAZggb5p1HaQ5hIF5I9
         +Tpw==
X-Gm-Message-State: APjAAAXR2wBEGCTyX+Lphojk7Dgv9XpP6ocaxuQ5oah7I/m5S994aLm6
        3xGd6jd0Z+ddE+Qm4Cce3EJjpy5v
X-Google-Smtp-Source: APXvYqwNa5WaQt5BTfqyR5rqWJ94IWp7rbTIRPN1wEw4ie+PjAy9m8X5IesWI0/fnPN7sn8/qAizGw==
X-Received: by 2002:a1c:407:: with SMTP id 7mr21341469wme.29.1575901010924;
        Mon, 09 Dec 2019 06:16:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v188sm14272332wma.10.2019.12.09.06.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:16:50 -0800 (PST)
Message-Id: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:16:46 +0000
Subject: [PATCH 0/3] git-p4: Usability enhancements
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

Ben Keene (3):
  git-p4: [usability] yes/no prompts should sanitize user text
  git-p4: [usability] RCS Keyword failure should suggest help
  git-p4: [usability] Show detailed help when parsing options fail

 git-p4.py | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)


base-commit: 083378cc35c4dbcc607e4cdd24a5fca440163d17
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-675%2Fseraphire%2Fseraphire%2Fp4-usability-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-675/seraphire/seraphire/p4-usability-v1
Pull-Request: https://github.com/git/git/pull/675
-- 
gitgitgadget
