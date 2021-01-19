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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D903BC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3222312D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbhASHoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbhASHnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:43:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970BC061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:42:27 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p15so11154785pjv.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEkROURBkueec7EZdg66n2R5aFz4Vh4NqlIVzgftNH0=;
        b=LFJpU0ZSubj/jNpZDRA+OkIr8J/bLb87Onu12Nn/wqonYfyiodQVKTpgBKW1VYMrN9
         bsi7uY9nZmcylbU4vpYgO4+kK6s9hSFkqfuC3C0F92NnAf4GmtfpBjVCXRGU4fa7ZaRR
         zXNgKkzC1us9m/WlQBTWIgyCONIja38MdzvG+oXiOiVOfVPRCbzx58LtBaN/eOE65Seq
         XkUNACvuXA4V3AfLrDXJ3YEzneO+PNjGq/TsVxQaq+8dhYLFNGb195ew3T0pi1PAmwt9
         RcTR3yV0cRVcZW6yLtyUackVC7tV4YQFmyQYh+rMqT06v9Cw9tQL31rDBuzatSjeKW9i
         jK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEkROURBkueec7EZdg66n2R5aFz4Vh4NqlIVzgftNH0=;
        b=twQxL190I8VGMY1BOiP1SsacIFIuZYcvUZe6KO1PrGR1E7T97MGkYpikQZkDMn0heY
         3yDzdbtGQdS4d7u21jBmTrQPmRPjnW5uSdUZM2GAgjxIcUeSCfXuXhEuCNrhPBzCFTOy
         KMfNCujDs6VpzGsI0QOE5br8xc77kbf/s31e5YQvGOHS8nY9eZQobw87DaI/I9y+25rB
         JUxV39J1TgIFJdMh2NaVsTyoM5hu0UAz5bEf6H+C7KyqQAWmsLdy2TOWs2ct6odTpC9Y
         ujtHvaSqV8GEszeoPmVYS7k/ZRXza5w/gVGf+bGyrY6y2wZ1+ApBJEl8YaEVu0Be1kIi
         HAvw==
X-Gm-Message-State: AOAM533YfShX4Pq8r8BApNQpseQUX5ZFfVPYONzDK0nJUOjH0/ZNTciH
        k30711ANwk26yW6NR7U5ZYyd6KZ+tHtU/Q==
X-Google-Smtp-Source: ABdhPJy4Lj1vhEZzxXkmYNJIM2JR8AXm6/2HAHv3JXp8VPCNequziYOFvUOVyZteoUjbA9j82KjzDg==
X-Received: by 2002:a17:90a:7e90:: with SMTP id j16mr3840379pjl.163.1611042147273;
        Mon, 18 Jan 2021 23:42:27 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:42:26 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 0/9][Outreachy] rebase -i: add options to fixup command
Date:   Tue, 19 Jan 2021 13:10:54 +0530
Message-Id: <20210119074102.21598-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
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

Changes from v1 :
* added '< 0' to check that 'write_message()' returns an error
* checks if squash! line commented out in t3415-rebase-autosquash.sh
* removing line break and changing suffix from _str to _fmt in sequencer.c

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

 Documentation/git-rebase.txt    |  12 +-
 rebase-interactive.c            |   4 +-
 sequencer.c                     | 297 +++++++++++++++++++++++++++-----
 t/lib-rebase.sh                 |   4 +
 t/t3415-rebase-autosquash.sh    |  30 ++--
 t/t3437-rebase-fixup-options.sh | 202 ++++++++++++++++++++++
 t/t3437/expected-squash-message |  51 ++++++
 t/t3900-i18n-commit.sh          |   4 -
 8 files changed, 543 insertions(+), 61 deletions(-)
 create mode 100755 t/t3437-rebase-fixup-options.sh
 create mode 100644 t/t3437/expected-squash-message

--
2.29.0.rc1

