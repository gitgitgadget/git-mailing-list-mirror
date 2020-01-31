Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76233C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F27E20705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4KgNy9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgAaV6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:58:18 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46797 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAaV6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:58:18 -0500
Received: by mail-wr1-f42.google.com with SMTP id z7so10317618wrl.13
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 13:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RfXP50NHqKCmf0cyaK+6RolecwevXU3jLjQQizGW2RM=;
        b=E4KgNy9Y6UhZ4tkX2578k+4SfFbO5g54i2xI1v+/lXZlAF5HkWlxKW6G6aW0J7qc61
         18Ckms7Z0Hd7D2d8lT0KHu9oZN6MTUf91ryr2pLXMaziqLCfXDtNIobzIpBDPF6l1VMn
         +asWQfDdVzozo/ETPwYQo9kyRfSzEQ6oH9K131pSCnM3ZvfDTC6ihYWP37IZRwLGuhde
         MbQVY9L7F/BcXW97DLeisLT3rJ+FGxprrUbybTO9tW1FWQ1fyC0bktxRs4AsNpkuHEZ2
         QVxrllz7WpJDuRLnJZmyVVx611gN5kiLmFHALaoaKmqn1poUaMxIRz/w8ybW4J7o8ScP
         1AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RfXP50NHqKCmf0cyaK+6RolecwevXU3jLjQQizGW2RM=;
        b=tptN546hnLz7v1v9P8U+YG7ClFDdPRggrW7BmASRgYdhrxGnxFAVJRPZxHpxHmC0xl
         K4R5Yb4BA1qhS/OQeUkteGaRmpqU1qK9aULQLzFV6Nv/vVnLaA1RtgYQyevayvd/06WV
         l3qq1f0zwIv7urlCgqELuKyiFHQGDubx9jHMevMyNyyM0IHI8gJzXdDMzv5g61otPOi9
         ClC+YXjFysKEFTHgfEB8Lc1Sn85n6kneIh1mSnXqyKX3lkeluKxBkx3A2kzoYIMSFdtp
         qtwBbZHj4ceZN54K5AxkJVx57BYHczx0BW3nCdcyB9jV2AmA7SUfysPWlgk/7oqS5g9B
         QNOA==
X-Gm-Message-State: APjAAAWAQE7m8miLAA5vlyh1bPI6bJ8uX6xJWGDR1/0a+eL9zjMS9xUv
        BcjQG9I78AjQoKTN334B/fom0Mug
X-Google-Smtp-Source: APXvYqzw7ABNOqkeobMmrB9Ei+4coGkEnyJjMYIOk4rDrbv5qQPjRbS6SvJfXPjNFhfEW822qULq8A==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr437573wrn.384.1580507896547;
        Fri, 31 Jan 2020 13:58:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm13455098wrx.20.2020.01.31.13.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 13:58:16 -0800 (PST)
Message-Id: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 21:58:11 +0000
Subject: [PATCH v2 0/4] git-p4: add hook p4-pre-edit-changelist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our company's workflow requires that our P4 check-in messages have a
specific format. A helpful feature in the GIT-P4 program would be a hook
that occurs after the P4 change list is created but before it is displayed
in the editor that would allow an external program to possibly edit the
changelist text.

v1:My suggestion for the hook name is p4-pre-edit-changelist.

It would take a single parameter, the full path of the temporary file. If
the hook returns a non-zero exit code, it would cancel the current P4
submit.

The hook should be optional.

v2:Instead of a single hook, p4-pre-edit-changelist, follow the git
convention for hook names and add the trio of hooks that work together,
similar to git commit.

The hook names are: 

 * p4-prepare-changelist
 * p4-changelist
 * p4-post-changelist

The hooks should follow the same convention as git commit, so a new command
line option for the git-p4 submit function --no-verify should also be added.

Ben Keene (4):
  git-p4: rewrite prompt to be Windows compatible
  git-p4: create new method gitRunHook
  git-p4: add hook p4-pre-edit-changelist
  git-p4: add p4 submit hooks

 Documentation/git-p4.txt   |  44 ++++++++-
 Documentation/githooks.txt |  46 +++++++++
 git-p4.py                  | 191 ++++++++++++++++++++++++++-----------
 3 files changed, 225 insertions(+), 56 deletions(-)


base-commit: 5b0ca878e008e82f91300091e793427205ce3544
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-698%2Fseraphire%2Fseraphire%2Fp4-hook-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-698/seraphire/seraphire/p4-hook-v2
Pull-Request: https://github.com/git/git/pull/698

Range-diff vs v1:

 -:  ---------- > 1:  585bdd51b2 git-p4: rewrite prompt to be Windows compatible
 -:  ---------- > 2:  f1f9fdc542 git-p4: create new method gitRunHook
 1:  bb3ce3a795 ! 3:  1bdcdc4c18 git-p4: Add hook p4-pre-pedit-changelist
     @@ -1,6 +1,6 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: Add hook p4-pre-pedit-changelist
     +    git-p4: add hook p4-pre-edit-changelist
      
          Add an additional hook to the git-p4 command to allow a hook to modify
          the text of the changelist prior to displaying the p4editor command.
 -:  ---------- > 4:  3d34dd042e git-p4: add p4 submit hooks

-- 
gitgitgadget
