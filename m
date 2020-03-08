Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB35C10DCE
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 18:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458BB206D7
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 18:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SivYa152"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgCHS3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:29:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46008 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgCHS3s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 14:29:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id h62so9276550edd.12
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dlAnfjeEY2pqA+a2Aanrns8K5uLPNq038Ka6nvTBujY=;
        b=SivYa152Rg6ULJffdunq+20TgeRgwMR4A5uBoF1KhKfbNBhbGdJuIkURXuZAv8gnXu
         JqIPmTUVWijvhX0ahAC4aYuFHJqA5oty6RqPZ37IUsMk8vHt/FCpx/GqcJeA0x8KZwF7
         8Gowp//2kkJUhk5bQKUw6UXnoFfLpHGa8gccIcPB2hSsmmjfAHZEWt2qoh6kOgcFQDFf
         ujCF2bXY2QM8u+fFFAW5PIyMKo3hyv0FBogDdXySngkmYx33zhSSySOjm6u+6DqJS1IA
         JnAOasfL2eqM5mCFEJyMHGHnMqZ/H4eQEcp0kvE1rre95q/10KYmEqnl7YsiOI+7KO/6
         TQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dlAnfjeEY2pqA+a2Aanrns8K5uLPNq038Ka6nvTBujY=;
        b=AQQzg8tiunQKagd+yBYtC3QiuqN/Cj9OtbLrvzZ5n2hd5dt5qhzOvyztaO5SICL9KP
         2RNquTN/m3c9ZvdmZbehO0fulTG0iAA9rd2b7Fkfj3+JR3HugwTxwRBP3fwVWwEpHCg2
         EtH6Epi+wjUXejMKKDYLAXaSi0tHikrxGzJqTBoU4+32D5gBASI5i09WUFu5yQK8RuC7
         z3co2c0MIwbESzaPBbDhsBIZbSwFXt/7bspZ6ngaQncJ4sH96cVwO/p2+aMA/XJ4tfe+
         VjzaLI3RPz5qw3ARzwJ4BGOsPDyywq0bAYWZA5sTYRMCLTHN0NIT67kFBaXz3gYMcqzI
         9vKQ==
X-Gm-Message-State: ANhLgQ1YH3uqYielUv+yM7NSN0/bqCFdoZSkOrPcksSBH48QWQY+78TI
        DdyAXjPQeXhijpHpwnVOEQWb31/l
X-Google-Smtp-Source: ADFU+vuqoox3ls17rwZDv+UXLK5dpOg3DBydrMIK7TRfJvQJtgtKYbE4lfBpRRIBQvBBL9Vp3hloPQ==
X-Received: by 2002:aa7:c552:: with SMTP id s18mr14170636edr.331.1583692186051;
        Sun, 08 Mar 2020 11:29:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k27sm1903072eja.20.2020.03.08.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 11:29:45 -0700 (PDT)
Message-Id: <pull.576.git.1583692184.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Mar 2020 18:29:41 +0000
Subject: [PATCH 0/3] Teach ref-filter API to correctly handle CRLF in messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref-filter API does not correctly handle commit or tag messages that use
CRLF as the line terminator. Such messages can be created with the--verbatim 
option of git commit and git tag, or by using git commit-tree directly.

This impacts the output of git branch -v, and git branch, git tag and git
for-each-ref when used with a --format argument containing the atoms 
%(contents:subject) or %(contents:body).

The first patch in this series adds a new test library, 
t/lib-crlf-messages.sh, that contains functions to test this behaviour for
commands using either the ref-filter or the pretty API to display messages. 

The second patch fixes the bug in ref-filter.c and adds corresponding tests.

Finally, the third patch adds a test that checks the behaviour of git log in
the presence of CRLF in messages, to prevent futur regressions.

Philippe Blain (3):
  t: add lib-crlf-messages.sh for messages containing CRLF
  ref-filter: teach the API to correctly handle CRLF
  log: add tests for messages containing CRLF to t4202

 ref-filter.c             | 19 +++++++++--
 t/lib-crlf-messages.sh   | 73 ++++++++++++++++++++++++++++++++++++++++
 t/t3203-branch-output.sh | 26 +++++++++++---
 t/t4202-log.sh           | 24 +++++++++++++
 t/t6300-for-each-ref.sh  |  5 +++
 t/t7004-tag.sh           |  7 ++++
 6 files changed, 147 insertions(+), 7 deletions(-)
 create mode 100644 t/lib-crlf-messages.sh


base-commit: 076cbdcd739aeb33c1be87b73aebae5e43d7bcc5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-576%2Fphil-blain%2Ffix-branch-verbose-crlf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-576/phil-blain/fix-branch-verbose-crlf-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/576
-- 
gitgitgadget
