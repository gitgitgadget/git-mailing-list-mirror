Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8900C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A882C22CA2
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbhAXRFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhAXRFf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:05:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98DCC061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:04:54 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l18so896840pji.3
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JBvlIhTe1T+GnlZaYtKKiN4VRe3ejgbJpzFmmqxmcs=;
        b=pm1Sa33qyYoRg9LV9FYu1OC9mDmUGrax0NA+6ZEpvWcFTFkQCK1Sao3ZiutQONtgxN
         QFn5kO/x79Fw05RKXxUzTqq9GJbMg+2Lem0m/M1soPtZ/rQCXNHppcWASHBmSw6t7eQ7
         oniW2aqrj/ym2R/iaOpxsmeJbtpvGm20ufjX3HIYkt+awRDRIEvv11M+tk1/TygFUHul
         dV85cEahS83nU+A3ugIE6+JL70kX4d5bYGm5KDooVKIYDa6slNWeIAXSM2MyGci8xvsw
         YgFDp5FIRHa5G6dZkVg4jdQUHqGY7BLTyM1JHiAU/Mld280xVT9/QSWXCr3tcko8kkXg
         qfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JBvlIhTe1T+GnlZaYtKKiN4VRe3ejgbJpzFmmqxmcs=;
        b=fFiEn0ludn5XVzIASXeG8zd8V4mTmjnMCjvZWp7EgzJOORpBRy1bY4ieT5lssNwZB3
         RQPRs8HwxAWIWg/W5QhiE2FSe0+EIf4OtNZkj6QFaUL2Zn/YlGUZsMCYasB+cyZRlOKQ
         B5/v+oijTF+JvElJiV3hpx8bMZPNYMuIrEHu6mC275OL4ChuIoVE6Y3N2s242CwwqW6k
         QwbxbS4VdrTz4a5oaN20Z0quQlMTWHuaV9lbheAcsxq7WYGys9rp7llma8usrKO1b/o9
         pSoeWWGvoBVJqE/mNHZ5iI6dOqDc973SELPsH2BmoXEfruO6Wb3qKsDO4XExxI8SBT0e
         MK9A==
X-Gm-Message-State: AOAM531B/4cdNd8NmT2aYhy/HSw27Plj2t9/jDBvXo+9DPwZy0BN/gbc
        ju6MiEMcMMdG7DRugvSiTu8KAqddRgmVYA==
X-Google-Smtp-Source: ABdhPJzYmKHvTuqusbRQ48aGAH24IYLixl5a+Tnig4I8NL4rIxKDFeSeAZ33Ei3gdqO0+FELFYameg==
X-Received: by 2002:a17:90a:e649:: with SMTP id ep9mr16599454pjb.112.1611507894299;
        Sun, 24 Jan 2021 09:04:54 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:04:53 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 0/9][Outreachy] rebase -i: add options to fixup command
Date:   Sun, 24 Jan 2021 22:33:56 +0530
Message-Id: <20210124170405.30583-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210119074102.21598-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds fixup [-C|-c] options to interactive rebase. In
addition to amending the contents of the commit as the `fixup` command
does now, `fixup -C` replaces the commit message of the original commit
which we are fixing up with the message of the fixup commit.
And to edit the fixup commit message before committing, `fixup -c`
command is used instead of `fixup -C`. This convention is similar to
the existing `merge` command in the interactive rebase, that also supports
`-c` and `-C` options with similar meanings.

This patch series also changes `rebase -i --autosquash` to rearrange
commits whose message starts with "amend!" and replaces the pick
command with `fixup -C`. The creation of "amend!" commits will be
rebase -i: add options to fixup command added in another patch series.

This is done in reference to the issue opened by Dscho as here[1] and
further discussed briefly[2]. Also, there is discussion[3] regarding the
implementation of reword! commit. The past patches of Phillip Wood’s
work[4], implements 'reword!' as 'amend!' in git rebase and these patches
uses those as the initial base.
And to avoid the extra command in the interactive rebase, this patch
series instead add options to the current fixup command in interactive
rebase (fixup [-C | -c]) as discussed earlier[5].

Changes from v2 :

(Thanks to Junio C Hamano, Marc Branchaud, Christian Couder, Phillip Wood
and Taylor Blau for the reviews and suggestions)

* Updated the Documentation/git-rebase.txt
* Added tests(t3437-rebase-fixup-options.sh) to check working of multiple
  fixup -c in rebase -i and related changes in sequencer.c
* Updated subject_length() function in sequencer.c and some corrections in
  t3415-rebase-autosquash.sh

[1] https://github.com/gitgitgadget/git/issues/259
[2] https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/
[3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
[4] https://github.com/phillipwood/git/commits/wip/rebase-amend
[5] https://lore.kernel.org/git/29fc2f59-1cca-a3db-5586-bbd7b2e4806d@gmail.com/


Charvi Mendiratta (6):
  sequencer: pass todo_item to do_pick_commit()
  sequencer: use const variable for commit message comments
  rebase -i: add fixup [-C | -c] command
  t3437: test script for fixup [-C|-c] options in interactive rebase
  rebase -i: teach --autosquash to work with amend!
  doc/git-rebase: add documentation for fixup [-C|-c] options

Phillip Wood (3):
  rebase -i: only write fixup-message when it's needed
  sequencer: factor out code to append squash message
  rebase -i: comment out squash!/fixup! subjects from squash message

 Documentation/git-rebase.txt      |  14 +-
 rebase-interactive.c              |   4 +-
 sequencer.c                       | 295 ++++++++++++++++++++++++++----
 t/lib-rebase.sh                   |   4 +
 t/t3415-rebase-autosquash.sh      |  30 +--
 t/t3437-rebase-fixup-options.sh   | 225 +++++++++++++++++++++++
 t/t3437/expected-combined-message |  21 +++
 t/t3437/expected-squash-message   |  51 ++++++
 t/t3900-i18n-commit.sh            |   4 -
 9 files changed, 587 insertions(+), 61 deletions(-)
 create mode 100755 t/t3437-rebase-fixup-options.sh
 create mode 100644 t/t3437/expected-combined-message
 create mode 100644 t/t3437/expected-squash-message

--
2.29.0.rc1

