Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00DCC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 08:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB6C22C9C
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 08:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgLUISJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 03:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgLUIRq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 03:17:46 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F355C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 00:17:06 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id i18so8116359ioa.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 00:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcQEdd6UT6XzUOQX7UPabw15GPyvD4vZZlIefQhehrs=;
        b=YBSmVZOiwPz6nEj2CZEYLGK/3UXsLecH+yFuix468XzeQxwii+/pb6IbRErrwf8WlN
         soaPvmEzaYqdQppnXJ4ftcUhPJzwR73/U5G8rmb04WKwkoZs+7KIbp2XES9JkmBXFws5
         cYGwHSqbqrnBXaDYocTiwULmQZ0fnCnNLRHN1RtsjsY8sjMyxFuVJKkelTGLehF8Ujzr
         utFOPR0sO44a4RvdpQeCS9lAxj+DQ2tIt7ZV7pAmLAAgh29H8LzYzXulF5m2Do8vPNJc
         D3DEVO5j2sdjlnbtaAYqWRorp7g2e+1Fny4A6/T0MAW5jH3jY5d9mHSrQXWdItdHPlcp
         QzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UcQEdd6UT6XzUOQX7UPabw15GPyvD4vZZlIefQhehrs=;
        b=EvuhpjFmx+UXxOUPZVYRxsaBhfdFVfSds31SIwoD54YMN1GJbFRhbRN1eUxiCtexVN
         6dBrjqqMHCW9+2lo9r5+L6rOKXLpU4mguQrxcLhp8M9bWgLGDibuXGKVdgVlesGYEa2l
         I7lUZtkP6dI2/RyvjdAP5bWZBHSlSwCUsfROz3B9Kao+zmA4Y6F7fin/pP82m5QcTDpN
         PDtJmolqfVbnex2fx9xXCf+zdl44tHctYYyhT/7YbhHFCokTXWW0yyVhSYJxvTnwXcSh
         0PFSVQedZMEHYywVp2dAa6AL4qBdM9VILsFg4SpfstAqqwq0KrUwrki3ut1f1fkcIJWy
         X6OA==
X-Gm-Message-State: AOAM5335s6XdWTNSRDdz5GCfJqRjCyswA7d3leQ7Xrghgk6DZ19zWJY/
        IaSaVixffI3JfgD9GWGTHypyIoY/eOfKbA==
X-Google-Smtp-Source: ABdhPJxgFpDq0em7E6dKFIs8s/DlqDxdVZOEdLnv2Kf1mbXydjL51BaQ0hNNHggco8D+wH4C/VX64Q==
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr13091906ioc.48.1608538625091;
        Mon, 21 Dec 2020 00:17:05 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n10sm13075379ila.69.2020.12.21.00.17.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 00:17:04 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/1] teach `worktree repair` to fix two-way linkage
Date:   Mon, 21 Dec 2020 03:16:00 -0500
Message-Id: <20201221081601.55546-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.30.0.rc1.243.g5298b911bd
In-Reply-To: <20201208173705.5770-1-sunshine@sunshineco.com>
References: <20201208173705.5770-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which addresses a limitation of `git worktree
repair` in which it is unable to repair the two-way links between the
repository and its secondary worktrees if both the repository and the
worktrees have been moved manually.

The primary change in v2 is that the commit message has been expanded
quite a bit to explain how the new repair mechanism works, rather than
expecting the reader to glean the necessary information from the patch
itself, as well as to express the reasoning behind a couple changes
which might not be obvious at first glance.

The patch itself is unchanged with the exception of two minor
alterations to one of the two added tests. First, anchoring has been
added to a couple `sed` expressions. Second, the rename of the main and
secondary worktrees is now done with two distinct `mv` commands rather
than a single "clever" `mv` so as to avoid giving the reader the false
impression that the cleverness implies something about how the repair
mechanism works (it doesn't imply anything, it was just done as a
convenience in v1).

[1]: https://lore.kernel.org/git/20201208173705.5770-1-sunshine@sunshineco.com/

Eric Sunshine (1):
  worktree: teach `repair` to fix multi-directional breakage

 Documentation/git-worktree.txt |  5 +++++
 builtin/worktree.c             |  2 +-
 t/t2406-worktree-repair.sh     | 26 +++++++++++++++++++++
 worktree.c                     | 41 ++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  956e61bbc8 ! 1:  cd38528672 worktree: teach `repair` to fix multi-directional breakage
    @@ Commit message
         Fix these shortcomings by teaching `repair` to attempt to infer the new
         location of the <repo>/worktrees/<id>/gitdir file when the location
         recorded in the worktree's gitfile has become stale but the file is
    -    otherwise well-formed.
    +    otherwise well-formed. The inference is intentionally simple-minded.
    +    For each worktree path specified as an argument, `git worktree repair`
    +    manually reads the ".git" gitfile at that location and, if it is
    +    well-formed, extracts the <id>. It then searches for a corresponding
    +    <id> in <repo>/worktrees/ and, if found, concludes that there is a
    +    reasonable match and updates <repo>/worktrees/<id>/gitdir to point at
    +    the specified worktree path. In order for <repo> to be known, `git
    +    worktree repair` must be run in the main worktree or bare repository.
    +
    +    `git worktree repair` first attempts to repair each incoming
    +    /path/to/worktree/.git gitfile to point at the repository, and then
    +    attempts to repair outgoing <repo>/worktrees/<id>/gitdir files to point
    +    at the worktrees. This sequence was chosen arbitrarily when originally
    +    implemented since the order of fixes is immaterial as long as one side
    +    of the two-way link between the repository and a worktree is sound.
    +    However, for this new repair technique to work, the order must be
    +    reversed. This is because the new inference mechanism, when it is
    +    successful, allows the outgoing <repo>/worktrees/<id>/gitdir file to be
    +    repaired, thus fixing one side of the two-way link. Once that side is
    +    fixed, the other side can be fixed by the existing repair mechanism,
    +    hence the order of repairs is now significant.
    +
    +    Two safeguards are employed to avoid hijacking a worktree from a
    +    different repository if the user accidentally specifies a foreign
    +    worktree as an argument. The first, as described above, is that it
    +    requires an <id> match between the repository and the worktree. That
    +    itself is not foolproof for preventing hijack, so the second safeguard
    +    is that the inference will only kick in if the worktree's
    +    /path/to/worktree/.git gitfile does not point at a repository.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
    @@ t/t2406-worktree-repair.sh: test_expect_success 'repair multiple gitdir files' '
      '
      
     +test_expect_success 'repair moved main and linked worktrees' '
    -+	test_when_finished "rm -rf orig moved" &&
    -+	test_create_repo orig/main &&
    -+	test_commit -C orig/main init &&
    -+	git -C orig/main worktree add --detach ../side &&
    -+	sed s,orig/side/\.git,moved/side/.git, \
    -+		orig/main/.git/worktrees/side/gitdir >expect-gitdir &&
    -+	sed s,orig/main/.git/worktrees/side,moved/main/.git/worktrees/side, \
    -+		orig/side/.git >expect-gitfile &&
    -+	mv orig moved &&
    -+	git -C moved/main worktree repair ../side &&
    -+	test_cmp expect-gitdir moved/main/.git/worktrees/side/gitdir &&
    -+	test_cmp expect-gitfile moved/side/.git
    ++	test_when_finished "rm -rf main side mainmoved sidemoved" &&
    ++	test_create_repo main &&
    ++	test_commit -C main init &&
    ++	git -C main worktree add --detach ../side &&
    ++	sed "s,side/\.git$,sidemoved/.git," \
    ++		main/.git/worktrees/side/gitdir >expect-gitdir &&
    ++	sed "s,main/.git/worktrees/side$,mainmoved/.git/worktrees/side," \
    ++		side/.git >expect-gitfile &&
    ++	mv main mainmoved &&
    ++	mv side sidemoved &&
    ++	git -C mainmoved worktree repair ../sidemoved &&
    ++	test_cmp expect-gitdir mainmoved/.git/worktrees/side/gitdir &&
    ++	test_cmp expect-gitfile sidemoved/.git
     +'
     +
      test_done
-- 
2.30.0.rc1.243.g5298b911bd

