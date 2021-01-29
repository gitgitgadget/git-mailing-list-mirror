Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F18BC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2480964E08
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhA2SWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhA2SW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 13:22:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC7C061574
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:21:45 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id my11so6805518pjb.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hyEP8PJVKMjd7vu8bg80G0kRw9jiNNViC+QBilVKyE=;
        b=QA9W1QrnthhADavGmIW1IrKX0pwrLuCFnbzFOTPAmJjiSbOr92cLhcWezvs0dB3zWu
         3ZP4MJ+MMZBGbdwkilbCUKjWU84KA2FMCXC90b+jNyTanO7iQzlgmXN93lrs5qIXOQon
         XeEaafUvWRVuyTruluNeFgKfUEw5clgAch3enHq34JpZA1tdCAhXiq74Or60wRI+qJr5
         e21NYHmLiNGUTZ7I770r0/xJ8JN8uCnoM+ehg5BDTYqqA2Q1Jwn8kzbW9JeAVYXMLFtO
         T4oRphJ4bpva2+NeamjwAZTSsdfE5qjjw1yHiokYRmeLaiTp9XrdCAXtyJGwv5vZSkgM
         AumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hyEP8PJVKMjd7vu8bg80G0kRw9jiNNViC+QBilVKyE=;
        b=ay1rpLSYF1oXzvhgQRUFHhi5YH54cTSmZkxFDDuvjMAAzvBqa9FaVnOFsCtPwnhVH5
         qlS1dcKlVKgNoxD1KXzlqendPVOXKlp5sWtbzNRLgYVOR0XAjU33Gjb7V3hjN6pjhgT5
         jt33/Rd/jxiVs62Srp9YgF7b1DdzrafA0nNd0nvg+gs21FfNUs02fH2Yqtun71z5kOk4
         cRx2c7cn5gVMcz8eS1egT6pI5CMHXSYSQPaAuSZl9hiaPX20brhQ2qcIFJb6W52DjqJN
         YwYx4/YiX31lVYzpMVg1eikmx3tAievZoyXk30ZHZYq6puLlAQFdPjg+IazvzVioZeqX
         zxPA==
X-Gm-Message-State: AOAM531iksD7MhIq1fuHXBx2MaAx+/MbxUlguBdAQ3tTknWvb6nTAgrb
        MFYD8qIGpW2HGCBeIbkUKt+Ij41osfQ=
X-Google-Smtp-Source: ABdhPJyByJ/D2DWoNYCvVcIXVH4L70p/TxnaTVXFALeohtAgBadZp9tqE61G671G/NRE9904/disDw==
X-Received: by 2002:a17:902:8ec4:b029:de:26a5:1b39 with SMTP id x4-20020a1709028ec4b02900de26a51b39mr5599320plo.24.1611944505210;
        Fri, 29 Jan 2021 10:21:45 -0800 (PST)
Received: from localhost.localdomain ([2402:8100:396a:4597:fd76:2af1:5584:160e])
        by smtp.googlemail.com with ESMTPSA id x141sm9497834pfc.128.2021.01.29.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:21:44 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 0/9][Outreachy] rebase -i: add options to fixup command
Date:   Fri, 29 Jan 2021 23:50:41 +0530
Message-Id: <20210129182050.26143-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210124170405.30583-1-charvi077@gmail.com>
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

Changes from v3 :

* Corrected a small bug in t3415-rebase-autosquash.sh
 (Bymistake sent the patches of local branch, with error in test script in v3,
 corrected those in these patch series revision)

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

