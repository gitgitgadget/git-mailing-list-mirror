Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67781F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfIQQfM (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36424 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfIQQfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so2488696pfr.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5e9q3hamskGx3U8YXi/0rWMp9Di2mWvMCGXIeXOcYs=;
        b=GrVZUPqpvBJk11PQrmiAfLa2XhPzBvx0Uq7UIc31M2c7ZXVIXVaKW6glQoicrm6GCB
         DMSXMyknDqi5RhIhiKRyVLveG7Vo2p3APV88zDpYhB8H31focjObMzx5/DQYgAcUWby2
         hLH+WLONSGVpenUwDS7odFJ8jN+167YrnWHxMMYmUrAAIOjKIxeoep04uP+Euq3cNoQ3
         M3evZDc1Se+MdVCT65ySFIVHDr+DhaA4Rtws5iY1Wi+oMLCC72Phv8iHtF9bqaQ/xMyX
         oup3ns5fpZvzINBsAHrITKNw48o56SnpHXNHa3py/UPb5WBUDAER9wRxEygjOFXZETD/
         +jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5e9q3hamskGx3U8YXi/0rWMp9Di2mWvMCGXIeXOcYs=;
        b=ekS0+DrgBGXZ6a13dPdAgEEo6UNLAaQNrlMYT+wGJjY2Yp/jBkXeII+9YVGWEg8dkv
         ma6l3Kq1UyUe2uYhIy3NVR4WnXsAov0PPDKGRZlXL1l8g5trPtDfAdI6An2aVZHf4xqI
         7Flo3P95OYmGqAfnmhcsLfJxrHHfvzNCfWYqaw69jeDR1Rr+IX9WhLpNXgQ0JTy7Bu8Z
         jDkX2sael/9mrElKlqrxrlnJyZzfWjjMgln4ICImHYwbw8keNur65E6lPBQuFBL5sG9W
         HkBE+N97TmhCYKwnqLLXBE3CSwwSD8B3fr2IDTlYezriSx6/cksWXFMo3Z/2STsuQKro
         kjyQ==
X-Gm-Message-State: APjAAAXn10gO2Mk4R8d8/tVduv6dutzWn7MB5HoA7pJwV0YWj1yUMzse
        tyh+G6wA8L6Io9VGVG1z7dYrhM73w3o=
X-Google-Smtp-Source: APXvYqy/T5iZ6teRMxE54jyjcCb4TSbCJGq1/zOomzgL6csj5MtwBlj8CZ+AZmQsrnw/YO2W4CGlLQ==
X-Received: by 2002:a63:1020:: with SMTP id f32mr4279373pgl.203.1568738111023;
        Tue, 17 Sep 2019 09:35:11 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 00/12] Fix some git clean issues
Date:   Tue, 17 Sep 2019 09:34:52 -0700
Message-Id: <20190917163504.14566-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes a few issues with git-clean:
  * Failure to clean when multiple pathspecs are specified, reported both
    in April 2018[1] and again in May 2019[2].
  * Failure to preserve both tracked and untracked files within a nested
    Git repository reported a few weeks ago by SZEDER[3].
It builds on sg/clean-nested-repo-with-ignored.

[1] https://public-inbox.org/git/20180405173446.32372-4-newren@gmail.com/
[2] https://public-inbox.org/git/20190531183651.10067-1-rafa.almas@gmail.com/
[3] https://public-inbox.org/git/20190825185918.3909-1-szeder.dev@gmail.com/

Changes since v3:
  * Clarified a couple commit messages highlighted by Junio.

Elijah Newren (12):
  t7300: add testcases showing failure to clean specified pathspecs
  dir: fix typo in comment
  dir: fix off-by-one error in match_pathspec_item
  dir: also check directories for matching pathspecs
  dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule
    case
  dir: if our pathspec might match files under a dir, recurse into it
  dir: add commentary explaining match_pathspec_item's return value
  git-clean.txt: do not claim we will delete files with -n/--dry-run
  clean: disambiguate the definition of -d
  clean: avoid removing untracked files in a nested git repository
  clean: rewrap overly long line
  clean: fix theoretical path corruption

 Documentation/git-clean.txt | 16 +++++-----
 builtin/clean.c             | 15 +++++++--
 dir.c                       | 63 +++++++++++++++++++++++++++----------
 dir.h                       |  8 +++--
 t/t7300-clean.sh            | 44 +++++++++++++++++++++++---
 5 files changed, 112 insertions(+), 34 deletions(-)

Range-diff:
 1:  fe35ab8cc3 !  1:  a48d4e7faf t7300: add testcases showing failure to clean specified pathspecs
    @@ -28,9 +28,15 @@
         showed that the same buggy behavior exists without using that flag, and
         has in fact existed since before cf424f5fd89b.
     
    -    Add testcases showing that multiple untracked files within entirely
    -    untracked directories cannot be cleaned when specifying these files to
    -    git clean via pathspecs.
    +    Although these problems at first are perceived to be different (e.g.
    +    never clearing out the requested files vs. taking multiple invocations
    +    to get everything cleared out), they are actually just different
    +    manifestations of the same problem.  The case with multiple directories
    +    that have no tracked files is the more general case; solving it will
    +    solve all the others.  So, I concentrate on it.  Add testcases showing
    +    that multiple untracked files within entirely untracked directories
    +    cannot be cleaned when specifying these files to git clean via
    +    pathspecs.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
 2:  707d287d79 =  2:  eb00b46822 dir: fix typo in comment
 3:  bb316e82b2 !  3:  c0e5b820a9 dir: fix off-by-one error in match_pathspec_item
    @@ -6,11 +6,22 @@
         namelen will be 4, and match[namelen] will be 'b'.  The correct location
         of the directory separator is namelen-1.
     
    -    The reason the code worked anyway was that the following code immediately
    -    checked whether the first matchlen characters matched (which they do) and
    -    then bailed and return MATCHED_RECURSIVELY anyway since wildmatch doesn't
    -    have the ability to check if "name" can be matched as a directory (or
    -    prefix) against the pathspec.
    +    However, other callers of match_pathspec_item() such as builtin/grep.c's
    +    submodule_path_match() will compare against a path named "foo" instead of
    +    "foo/".  It might be better to change all the callers to be consistent,
    +    as discussed at
    +       https://public-inbox.org/git/xmqq7e6cdnkr.fsf@gitster-ct.c.googlers.com/
    +    and
    +       https://public-inbox.org/git/CABPp-BERWUPCPq-9fVW1LNocqkrfsoF4BPj3gJd9+En43vEkTQ@mail.gmail.com/
    +    but there are many cases to audit, so for now just make sure we handle
    +    both cases with and without a trailing slash.
    +
    +    The reason the code worked despite this sometimes-off-by-one error was
    +    that the subsequent code immediately checked whether the first matchlen
    +    characters matched (which they do) and then bailed and return
    +    MATCHED_RECURSIVELY anyway since wildmatch doesn't have the ability to
    +    check if "name" can be matched as a directory (or prefix) against the
    +    pathspec.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
 4:  56319f934a =  4:  397775ec35 dir: also check directories for matching pathspecs
 5:  81593a565c =  5:  b836de82c0 dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
 6:  9566823a0f =  6:  feb317d090 dir: if our pathspec might match files under a dir, recurse into it
 7:  7821898ba7 =  7:  0a574d6779 dir: add commentary explaining match_pathspec_item's return value
 8:  13def5df57 =  8:  0eaa08537c git-clean.txt: do not claim we will delete files with -n/--dry-run
 9:  e6b274abf7 =  9:  a1438301bb clean: disambiguate the definition of -d
10:  5f4ef14765 = 10:  8dc21923ee clean: avoid removing untracked files in a nested git repository
11:  4e30e62eb1 = 11:  707b6a5509 clean: rewrap overly long line
12:  de2444f7cb = 12:  84a90010ed clean: fix theoretical path corruption
-- 
2.22.1.17.g6e632477f7.dirty

