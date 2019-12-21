Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC84C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BD4206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDtHT7JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLUWmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33183 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUWmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so12069416edq.0
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=suG/qebKToSVAh96yvZVmiPSXY6JLPt7maVdk746ueA=;
        b=cDtHT7JRMG1wqnAe/khVOkq01EuBFOSMSvI+llXV+FqCipZekraj3PYJyiVNnv79N7
         btWf9mynnEDV+VU22mkiaNUmZezrjY55imkyFxFAvgF3WE+ULG+OtT38CKmDno0nBGKC
         QZ5EjADejrznajHBM2FCbkLAZ9B1a3jET6m32eDHOdYRhdpAR3kCm2IcqBPV4XNxdvSL
         2t3Yb+TWHEVvyzAQhJ8UoEv0SS7mV19QMi2qX4ayuoyXw9dUqUWqY48cTMZYzki+1AS8
         lskpk4gGkLCji2Mzy64BSrnX1loefwSl1nyshk56z0cleu9Dxr7WrHVHM+LCtJ3urDdI
         wHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=suG/qebKToSVAh96yvZVmiPSXY6JLPt7maVdk746ueA=;
        b=DPKIeNaYmyergZFz1QYaBbk4Jbs3nGZhZJ4mNv5wf+cVVD9pVZfyTqX3hXWaMoujnq
         MAdrcE+RpdVIQSX8tFEzh4Nc/hRx5a9kjLWzrqyZa3Qh9vZ2WOTDC8ID0TwhNT3v+9RH
         86xeR6uU4OY0c0kIkkge+5v3SjAzphkf2UfbgmBSg30De1MOfWlkqdIfFtQwHWmSsELV
         iVvEtTqJKkqyyih8sMZHm6DKiG3v0bunms43gY+qMOgOOBsHYiHCY4yXGWHmKWHygQoU
         lyInA3O49Tt04LZxYwSzGwoRWjTIWjm+cOpkjQp2181TauanCi36rZseyxv9eEjxbyc5
         iFrA==
X-Gm-Message-State: APjAAAWrgxi51QIgDytV4waJw27EubrL6qTzYNGY+WGEbcumtyLVnw3H
        199sG9VziLRNfXRsXQ7XAVP47sVl
X-Google-Smtp-Source: APXvYqymbiqakc97DMeqjhlvWOp/bxj6yZE7FPptRj6r9Sw3OJdC3mVp3kW3tBRZuwj+5GoBIkvJow==
X-Received: by 2002:a50:d905:: with SMTP id t5mr24409571edj.67.1576968121490;
        Sat, 21 Dec 2019 14:42:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm1517136edv.90.2019.12.21.14.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:01 -0800 (PST)
Message-Id: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:41:51 +0000
Subject: [PATCH 0/9] built-in add -p: add support for the same config settings as the Perl
 version
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

This is the final leg of the journey to a fully built-in git add: the git
add -i and git add -p modes were re-implemented in C, but they lacked
support for a couple of config settings.

The one that sticks out most is the interactive.singleKey setting: it was
particularly hard to get to work, especially on Windows.

It also seems to be the setting that is incomplete already in the Perl
version of the interactive add command: while the name of the config setting
suggests that it applies to all of the interactive add, including the main
loop of git add --interactive and to the file selections in that command, it
does not. Only the git add --patch mode respects that setting.

As it is outside the purpose of the conversion of git-add--interactive.perl 
to C, we will leave that loose end for some future date.

Johannes Schindelin (9):
  built-in add -p: support interactive.diffFilter
  built-in add -p: handle diff.algorithm
  terminal: make the code of disable_echo() reusable
  terminal: accommodate Git for Windows' default terminal
  terminal: add a new function to read a single keystroke
  built-in add -p: respect the `interactive.singlekey` config setting
  built-in add -p: handle Escape sequences in interactive.singlekey mode
  built-in add -p: handle Escape sequences more efficiently
  ci: include the built-in `git add -i` in the `linux-gcc` job

 add-interactive.c         |  19 +++
 add-interactive.h         |   4 +
 add-patch.c               |  57 ++++++++-
 ci/run-build-and-tests.sh |   1 +
 compat/terminal.c         | 249 +++++++++++++++++++++++++++++++++++++-
 compat/terminal.h         |   3 +
 6 files changed, 325 insertions(+), 8 deletions(-)


base-commit: 2d4b85ddc76af3e703e6e3a6a72319b5e79c2d8b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-175%2Fdscho%2Fadd-p-in-c-config-settings-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-175/dscho/add-p-in-c-config-settings-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/175
-- 
gitgitgadget
