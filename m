Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F96C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FF12087F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDVVh7Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgAGKDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:03:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53957 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKDA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 05:03:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so18237775wmc.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 02:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yHe/+uKsb02w+OeC8q679iGUYV8ISn0ov13WCb5ZOew=;
        b=YDVVh7TdvBVBBrsvLYnrXxjsllhwA5Y2YqLL4FoKIg8nnYcwY06FFFDH3J8yT00Axr
         HkqJCYVn3LAMUdEHkDNyPZzAhrV/xjIIfXdN587q6kgmNJSCJywtMnDKsfdW4e4YisA7
         moGz6NBkGfxLzU7a0XfFU1MA6ZXoRz42/c5PjzM0qripqClGQ+kBeKoIRO547WUZsba5
         ikYJaJM6BzFG+pkC4apFl/fStvA745Woitp/VKng0QHMWasEOUekiN++q08H+oiULEnR
         4QU5TIrTmo04ll+1Id277QA4eF/GEl6zm23JOBZ6+C9dblZsw9sh+gE2nInI/IoYDKr8
         CEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yHe/+uKsb02w+OeC8q679iGUYV8ISn0ov13WCb5ZOew=;
        b=ROxtekEG3Zfgukotj7eCr0HO7A9oXROJh1Uu06nNJpLnTGixLT8JIfa3zVRCfGT6z3
         XihBLI23wPRe/KZI3ULWx+sSjy2JgOkP7s+lxoF24R6Ej9yBfoypLQ1ciEZcXSyLQMY4
         k6CmQWvdblqeQ6QqSOjnmH6Qa/TyXUbSXkBSzTwYXJEarf36VpQWcZusNjaQbeG4YyHc
         O3z4sdmH0zfWGgkX53y1SxbEIQF8ZckIsKDPQuBIO6Hhiv6jUvAaoFSsRWrb1qq8V3db
         PivKBa5JXmB2g1S85LH8VdfUimBGEn6X7C8bQtuYDsumV4Ghu6C3/ECvqTXF0fqzLDiM
         iXiA==
X-Gm-Message-State: APjAAAXuhh2ZFTCQ4uqg2bh8F90LsPHi/yjUTXA4cVFt+dCwtcEVpXFA
        8N0Lgy03+IvVGNBJLyfURLMknf1W
X-Google-Smtp-Source: APXvYqyiQYFCXKaNR0zVZZc3M3PDjz++4C5jmJopGWkiyrCunoidsLyPM4K3FR7pagni2ODyUdPmhg==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr37146644wmj.41.1578391377991;
        Tue, 07 Jan 2020 02:02:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q68sm27799328wme.14.2020.01.07.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:02:57 -0800 (PST)
Message-Id: <pull.516.git.1578391376.gitgitgadget@gmail.com>
From:   "Liam Huang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 10:02:55 +0000
Subject: [PATCH 0/1] Update imap-send.c, fix incompatibilities with OpenSSL 1.1.x
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some APIs have been changed since OpenSSL 1.1.0, so fix incompatibilities
with OpenSSL 1.1.x.

See:

 * https://www.openssl.org/docs/man1.1.0/man3/SSLv23_method.html
 * https://wiki.openssl.org/index.php/Library_Initialization

Liam Huang (1):
  Update imap-send.c, fix incompatibilities with OpenSSL 1.1.x

 imap-send.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)


base-commit: 042ed3e048af08014487d19196984347e3be7d1c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-516%2FLiam0205%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-516/Liam0205/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/516
-- 
gitgitgadget
