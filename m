Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF81BC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845E622527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTkFdcEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMIIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38539 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMIIK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so525537wmc.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=nDe3GS87bP/7OT75S3Al+f55k34ElChxRQ6ITyesXQs=;
        b=TTkFdcEdMUCD382w+iOtJs02soCEm+9IrdH7TvNp9rJX8EbDbUlaBs9YadPX6D71iN
         lFpU3n7dJK87ecPh6t4gXlkGnUZtw4pUK4ZA2RxooGKP5161jpq1pUusP6nAAPYhDsUv
         jO25doUJk/hTlc1DwbEZEiCkXUzfWIk6uMKQQwIHOLoF3wupgW4ctaxQ2veW4Q8rau7a
         nRFO+xiO7QchomxhZvs38N2lTzUI67YdA+Y4oHDDMpnOcVy+EXAupjigaSdEZnWDYmjU
         L3DoTLjjlmiu+gZKVK4wSiyuvLkyqlNr7NfREqxZyzJ4qWac/3f3iA2P3OV343eQknkv
         YzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nDe3GS87bP/7OT75S3Al+f55k34ElChxRQ6ITyesXQs=;
        b=iKhhEh8Jag4GErHAs6yvNbuE9Lg3/d15lZ6Q3URJqE8xvcIdjjmTJhp9x2HwuqTJoC
         jeGQ0rA/rKsDo6W6xpJXTc0ezvyOwkaEwgisViqFQjSzeCHJtn/pn//9ePVelcHdMwsp
         wSd1hT+1kRTZ7RgpFR4SQYZTPvCqBOz6FSTkKBbBqo1hwvfsklmX5HmWQMdxsxZbaVjM
         5N0YhCC7DYHN/V5S+anzxNtPG6DzYM+fPtetnh3OamVrFzU58s45T9r50dIyG3QZ8fbY
         cu4rna2wVjbeMtj8V3O7rfLfynfv9gT2oOZ0XUdv2RfOIG6AaNZl0BrXUqUlfBx7jhYS
         DGSQ==
X-Gm-Message-State: APjAAAUoqXlwuwLyHHagP57wvr1h0SErNwH3g3XoZuq6R3tu98cyqKsh
        24uS/5zdN7svhHTIhWAmJqt3vFth
X-Google-Smtp-Source: APXvYqziq+/1tflCSP3G9LxyX2fUsHixJCT1mYlZS8j2sZTLX2mVSTpAcuR8YegKs/uY/d5Yn9ScOQ==
X-Received: by 2002:a05:600c:1007:: with SMTP id c7mr12295765wmc.158.1576224488080;
        Fri, 13 Dec 2019 00:08:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm9025312wrw.2.2019.12.13.00.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:07 -0800 (PST)
Message-Id: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:47 +0000
Subject: [PATCH 00/19] Implement the git add --patch backend in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Out of all the patch series on the journey to provide git add --interactive 
and git add --patch in built-in versions, this is the big one, as can be
expected from the fact that the git add --patch functionality makes up over
half of the 1,800+ lines of git-add--interactive.perl.

The two patches that stick out are of course the ones to implement hunk
splitting and hunk editing: these operations are fundamentally more
complicated, and less obvious, than the entire rest of the operations.

Johannes Schindelin (19):
  built-in add -i: start implementing the `patch` functionality in C
  built-in add -i: wire up the new C code for the `patch` command
  built-in add -p: show colored hunks by default
  built-in add -p: adjust hunk headers as needed
  built-in add -p: color the prompt and the help text
  built-in add -p: offer a helpful error message when hunk navigation
    failed
  built-in add -p: support multi-file diffs
  built-in add -p: handle deleted empty files
  built-in app -p: allow selecting a mode change as a "hunk"
  built-in add -p: show different prompts for mode changes and deletions
  built-in add -p: implement the hunk splitting feature
  built-in add -p: coalesce hunks after splitting them
  strbuf: add a helper function to call the editor "on an strbuf"
  built-in add -p: implement hunk editing
  built-in add -p: implement the 'g' ("goto") command
  built-in add -p: implement the '/' ("search regex") command
  built-in add -p: implement the 'q' ("quit") command
  built-in add -p: only show the applicable parts of the help text
  built-in add -p: show helpful hint when nothing can be staged

 Makefile                   |    1 +
 add-interactive.c          |   29 +-
 add-interactive.h          |   19 +
 add-patch.c                | 1338 ++++++++++++++++++++++++++++++++++++
 builtin/add.c              |   15 +-
 strbuf.c                   |   28 +
 strbuf.h                   |   11 +
 t/t3701-add-interactive.sh |   42 ++
 8 files changed, 1464 insertions(+), 19 deletions(-)
 create mode 100644 add-patch.c


base-commit: b4bbbbd5a247e0e75d079bca591b657ec9084a46
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-173%2Fdscho%2Fadd-p-in-c-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-173/dscho/add-p-in-c-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/173
-- 
gitgitgadget
