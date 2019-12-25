Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E3AC2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101802073B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPxeTAWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfLYL5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44512 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfLYL5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id bx28so19738522edb.11
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FZDSUqV06hmQLpH/Cq+n4VQ3uhEYmS11OkQgpOtu2Es=;
        b=dPxeTAWg8ogcg1ru9WE4osKYuVOfSlBqOT5KvgusnQ2pynW4xBzjGSpSTRoJvxeQaJ
         NyvX+rWj+4OZP5k0FD8km1lqK7aYjRaKrjysBjpA/Q7EoopaK0hIYOzDVczzyJgw26Rx
         a0MEZ8fsR0Wm+s+Mo5D67fB467UrNvTtww7xXlpjtMOKeAgphFdJZ/QMnCuiFVy0M24h
         eJNplhsqYxUliYEM73wUJ8yNG2MoEtPlJy794Ckf3J93XMW8KJCbnbG1SjEGeYBs3NIC
         sEc5UVNAFBp+K9SrgMCSlGN9Pf+XTIchUJiEJZe5h26krLWj0/nJWstS+MugKHCMNwjg
         MaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FZDSUqV06hmQLpH/Cq+n4VQ3uhEYmS11OkQgpOtu2Es=;
        b=hxfpzb86ZDJc3Trx0iKR7upgKjMPT+Erno2KdAVYa+Q/Udzk1jKr3lYpwTzC0r88fQ
         Kwm884NN4T52AyPaXEsMW+A0TsEiQteXoLRxgY6Rnlqx8/0qdsBDlk0YrbRlQToLynKA
         lpOPKIIDpKhpd4WjvgMdE7FT2eQb1SxFymbHh9f6eO/Y1rpvqoxvghVJQQd9hJDhmdfK
         ezTbA7f+oUAaydko00lUEUjqG+zq8I292UqLBM9Ij5X5LcaM+42asIfC+RqWIY+kuVwF
         BY3ZTz9JazxQ4wdECriZzlICHtYZUfUyoL12Feer25AtPFWwkJKT8J6CzfTbjeXs0SsH
         JsFg==
X-Gm-Message-State: APjAAAV1zsoSJ+C0S6JFci3AHCZgDSz28z4BVVxQBAAAGDg8f0xizJ2L
        Ok0MTpGpSaQk4+RrCwx6yoFQ+ybZ
X-Google-Smtp-Source: APXvYqx1v1SioSIOmHslbKmGe3LwuABpWDNF9DKK+mPAzufUwXufPiI0h/v6Zisw66GIujLZTFdNjQ==
X-Received: by 2002:a17:906:51d0:: with SMTP id v16mr37102147ejk.50.1577275021984;
        Wed, 25 Dec 2019 03:57:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm2963755ejs.8.2019.12.25.03.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:01 -0800 (PST)
Message-Id: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:56:51 +0000
Subject: [PATCH v2 0/9] built-in add -p: add support for the same config settings as the Perl
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

Changes since v1:

 * Fixed the commit message where a copy/paste fail made it talk about
   another GIT_TEST_* variable than the GIT_TEST_ADD_I_USE_BUILTIN one.

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


base-commit: c480eeb574e649a19f27dc09a994e45f9b2c2622
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-175%2Fdscho%2Fadd-p-in-c-config-settings-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-175/dscho/add-p-in-c-config-settings-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/175

Range-diff vs v1:

  1:  a7355776d6 =  1:  f45ff08bd0 built-in add -p: support interactive.diffFilter
  2:  74958419f6 !  2:  e9c4a13cbf built-in add -p: handle diff.algorithm
     @@ -62,7 +62,7 @@
      @@
       	int res;
       
     - 	argv_array_pushv(&args, s->mode->diff);
     + 	argv_array_pushv(&args, s->mode->diff_cmd);
      +	if (diff_algorithm)
      +		argv_array_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
       	if (s->revision) {
  3:  7631c1ea8c =  3:  e643554dba terminal: make the code of disable_echo() reusable
  4:  a77fa914da =  4:  bd2306c5d5 terminal: accommodate Git for Windows' default terminal
  5:  3996d7997a =  5:  190fb4f5e9 terminal: add a new function to read a single keystroke
  6:  6d6794089d !  6:  167dfa37dd built-in add -p: respect the `interactive.singlekey` config setting
     @@ -54,7 +54,7 @@
      +#include "compat/terminal.h"
       
       enum prompt_mode_type {
     - 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK
     + 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
      @@
       	return 0;
       }
  7:  fd5a129776 =  7:  32067bebe8 built-in add -p: handle Escape sequences in interactive.singlekey mode
  8:  af9b598738 =  8:  703719ffce built-in add -p: handle Escape sequences more efficiently
  9:  9719604a1f !  9:  23a3a47b01 ci: include the built-in `git add -i` in the `linux-gcc` job
     @@ -6,8 +6,8 @@
          a whole slew of `GIT_TEST_*` variables set.
      
          Now that the built-in version of `git add --interactive` is
     -    feature-complete, let's also throw `GIT_TEST_MULTI_PACK_INDEX` into that
     -    fray.
     +    feature-complete, let's also throw `GIT_TEST_ADD_I_USE_BUILTIN` into
     +    that fray.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      

-- 
gitgitgadget
