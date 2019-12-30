Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8B6C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BDF20718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvUMv86f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfL3Pil (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:38:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36153 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfL3Pik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 10:38:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so32914930edp.3
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 07:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6gzD8DeI7yxAK4wtC3SkKOkWJt74Txjf93B/RybXBcc=;
        b=AvUMv86fKZHXISMD0lNRJticWVyep8bN6WIkK13MVlF+hjPpqoArQ4TNzy0bCBCf87
         WIsY8oyL6+0MEbxNsLmtkM16VrAvbbbIr4mDln10uMQDtkJ4GOKMgdTbv4Um5nVbiAwC
         IzahDecy7RMTswet93IJSqAIlWPzZyTytjq783z5eZDQaF6DtCl97O79qCcB+oPA1e7W
         PYNEbL+2sb/jZF6nQR/kDzy2znl3u+zY3fy1bq32Js27gCs2i+1WyjuCn3hhRw1Gskbh
         oH4SVpdOrQm5/72c4pR2kAxlT6CJn2d+GtU+zZ8GFKpIP0GpqOfVoAFtYA148RKGSFCl
         Jk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6gzD8DeI7yxAK4wtC3SkKOkWJt74Txjf93B/RybXBcc=;
        b=n3z91f1N1prEXN+UHV3H9Fo1rgrdECqqUyPUdG4RSkDKrcvlNeaCInOt4+56iPwUVW
         HzJAE3kNBZoX/IXO/vXBlJL0YXxi/dtPwRDlIPcoEQKOnjIz6EcJBZF92YDn2f5peYpQ
         9jCmqj1hmFd21KXkdYYz1tFx4iNoB/oETQH94of9DkrrcsoiD6Y9xeqWGkGKZipba4jQ
         GEGDwjtuEhq9eJFIy8oHDWueEP8b+RkBpuUEjfy+sUXzCRoAtaENAPjc0oJL8pEMHqfX
         FIUFCQpLFAPTI8ai/1iur9P3ccFvWI5CmZZtFrNPy3dzCaUGMX9mHz8dPSQgLdJjdGPc
         04XA==
X-Gm-Message-State: APjAAAUihldtlfMMMM6eW+boN3k4EPkI3FfTWhW629ziDui4Jnt2jmTz
        /jNNmYJLlaRm4+Ka5zywomUFjAbI
X-Google-Smtp-Source: APXvYqzLhDW8vQvvwZcYoKfaYgaJOufsbTX+lLKNx0X+MfMqhIXlHHqg8rEjnRM/Y9innVSo7L9n6Q==
X-Received: by 2002:a05:6402:298:: with SMTP id l24mr71470897edv.70.1577720318908;
        Mon, 30 Dec 2019 07:38:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm5391503edl.6.2019.12.30.07.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 07:38:38 -0800 (PST)
Message-Id: <pull.502.git.1577720318.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 15:38:37 +0000
Subject: [PATCH 0/1] t: add tests for error conditions with --pathspec-from-file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds tests for various cases where using `--pathspec-from-file` would result in a git error, such as using incompatible options.

This branch is a follow-up for [1] where part of branch was merged into `master` via [2].
The idea for these tests is from [3] where another error condition was added together with a test.

[1] https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/
[2] https://public-inbox.org/git/pull.445.v4.git.1575381738.gitgitgadget@gmail.com/
[3] https://public-inbox.org/git/4401823b-8039-99b4-2436-ed2f1a571d78@gmail.com/

Alexandr Miloslavskiy (1):
  t: add tests for error conditions with --pathspec-from-file

 t/t2026-checkout-pathspec-file.sh | 17 +++++++++++++++++
 t/t2072-restore-pathspec-file.sh  | 18 ++++++++++++++++++
 t/t3704-add-pathspec-file.sh      | 25 +++++++++++++++++++++++++
 t/t7107-reset-pathspec-file.sh    | 30 +++++++++++++++++++++---------
 t/t7526-commit-pathspec-file.sh   | 27 ++++++++++++++++++++++++---
 5 files changed, 105 insertions(+), 12 deletions(-)


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-502%2FSyntevoAlex%2F%230207(git)_2a_test_error_conditions-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-502/SyntevoAlex/#0207(git)_2a_test_error_conditions-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/502
-- 
gitgitgadget
