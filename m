Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAABC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F308564DF1
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhCAIsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhCAIrF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:47:05 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4700C061797
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 00:46:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u18so3225154plc.12
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 00:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=KeHm8Qhh0htfvws+PjZAuCcLMiti9x59dZxgzq8nDfY=;
        b=ldYh7Rslw5LCpKvrSp8730wrm4/3Wdx98RKBaEz2OxKp19KrgmpJpks7kjuzypmwbj
         L+mYh4aaY+04wC6P6Fw5eVOBcjztWpOJ4b8q11qwqQ9Qc7jXyTERjHXjKDTHAC6zrdZW
         Ta6NEWInPPowBCgj/58dvluXzh+i3oY21uMk4EluhsTH4/Mu2UMio0gPrBnMKxN7NwZm
         1cnf74EI7aibD2UdU2G1STffbrW0BkzvsBoQjpFEx9z4NrDv3JQGKvR6di3T1F/tzebb
         qItBh/zt0VJum610IeKmgK1tTCKF7s9MqCiN1x3xiMnyf+V8u+Q/1PyH1cwVpmbY4kTa
         cHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=KeHm8Qhh0htfvws+PjZAuCcLMiti9x59dZxgzq8nDfY=;
        b=m8rG1tVOfY9vow25+NV5U7FjbMzPbUVDAkZYyC6fgVbu1b/8PVLo3S9z1WRYdm0knU
         MSzlLs92OQi/Z/EoyyLl4NOdi+HMyQ9Ia66PRw+K9T2BqiEJQy9ZWL1xx64eZ657hu1y
         jQIpxYmrd/ltJ3nwcZ7o68y0OCk5xBjcJJoOEsFBNBth6KayzOL/EgAHwB46tj10O5/M
         UqQnwUA7ACRQ37Q21pqI9G5ZTzZu4KyJzbYuhQ7iXCkEv6DryRN6S711mYi/uyIq5AJd
         y/U96RGwlHt4AGm9AnQqZ2PuVWnFS5lIDu7inproEUUQfPcGNlmTkEfjcQWDoJYC8TYf
         klCw==
X-Gm-Message-State: AOAM530AK8eq2SksiBgoqKJkGIYsUZ+dlvJjo8tdUmDMLj05fNixEfBR
        /glDIQT0hGLgkDNiUxSo054LvzNPooH5Gw==
X-Google-Smtp-Source: ABdhPJwJF6DVzx94X/Vd+M4tAstEFXKxP3i3XTl/U04zGQ3Q7wSEkh+4h48oP6u42le5lHR6T0uuPw==
X-Received: by 2002:a17:902:aa8f:b029:e3:df7f:fd51 with SMTP id d15-20020a170902aa8fb02900e3df7ffd51mr14502843plr.71.1614588384202;
        Mon, 01 Mar 2021 00:46:24 -0800 (PST)
Received: from localhost.localdomain ([2405:204:302d:d8af:c047:a272:aff7:4de6])
        by smtp.googlemail.com with ESMTPSA id b34sm16781426pgl.63.2021.03.01.00.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:46:23 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 0/6][Outreachy] commit: Implementation of "amend!" commit
Date:   Mon,  1 Mar 2021 14:15:08 +0530
Message-Id: <20210301084512.27170-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
Reply-To: 20210217072904.16257-1-charvi077@gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series teaches `git commit --fixup` to create "amend!" commit
as an alternative that works with `git rebase --autosquash`. It allows to
fixup both the content and the commit message of the specified commit.
Here we add two suboptions to the `--fixup`, first `amend` suboption that
creates an "amend!" commit. It takes the staged changes and also allows to
edit the commit message of the commit we are fixing.
Example usuage:
git commit --fixup=amend:<commit>

Secondly, `reword` suboption that creates an empty "amend!" commit i.e it
ignores the staged changes and only allows to reword/edit the commit message
of the commit we are fixing.
Example usuage:
git commit --fixup=reword:<commit>

** This work is rebased on the top of cm/rebase-i-updates.

Changes from v2 :

* doc/git-commit.c: reword and simplify the `--fixup=[amend|reword]`
* error out "foo" in the output message when `--fixup=reword:` combined
  with pathspec i.e
  $ git commit --fixup=reword:HEAD~ -- foo
  (I am bit unsure about this as I have directly used the "argv" to get the
  first foo (file) passed. I am doubtful and not sure about, if we can
  use the `pathspec_from_file` in (builtin/commit.c) ? )
* fixes the TRANSLATOR, commit message and other minor cleanup (v2 2/6)

Charvi Mendiratta (6):
  sequencer: export subject_length()
  commit: add amend suboption to --fixup to create amend! commit
  commit: add a reword suboption to --fixup
  t7500: add tests for --fixup=[amend|reword] options
  t3437: use --fixup with options to create amend! commit
  doc/git-commit: add documentation for fixup=[amend|reword] options

 Documentation/git-commit.txt              |  40 ++++++-
 Documentation/git-rebase.txt              |  21 ++--
 builtin/commit.c                          | 125 ++++++++++++++++++--
 commit.c                                  |  14 +++
 commit.h                                  |   3 +
 sequencer.c                               |  14 ---
 t/t3437-rebase-fixup-options.sh           |  30 +----
 t/t7500-commit-template-squash-signoff.sh | 135 ++++++++++++++++++++++
 8 files changed, 316 insertions(+), 66 deletions(-)

--
2.29.0.rc1

