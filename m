Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A956C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D598A2083B
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+w6d1rZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIQHol (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIQHoe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC003C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so671241pfp.11
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=917LF5kiH4xoGrQycmjhkxK3O2r6PkiVqTB/20gRxng=;
        b=T+w6d1rZpUWTxZsPxZ5fK8O3Pgi9Q4GMVxLG6fyxf1eVyE+q/TmHE/mnNa4h5UdLF0
         fYMOeuUkRjhqsPVnS/QEEIDJezI5MmhhL5t0WvnYIwZdvsR/PIsG0x92ejlyASvqzkQO
         EI5g+BQEmnkE1gtgJfVPGL4hXvfbd/9sj5YnhXQcWFH3RcI0pMHJ8OPhVSA4/uF8N2lA
         fPGsCwdbGnSn6c0TBq6AX2lrCKLXADjKjdvGtM3Xe0mRf2IbXQSjjmB1niih3Z6LAVyr
         v11Q0XaG9DjGqKpDhKRGGV8ujAT+YPjg5nNMkCe9bVaSfox5cLXVcB22EkLLgLqcFhxL
         AwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=917LF5kiH4xoGrQycmjhkxK3O2r6PkiVqTB/20gRxng=;
        b=gJm3yqRh3U6KTIfK8oe8HT48+rUfPmm8aVN6mpHZKwGl9W04sGOLwuyAwKTgqqqX5a
         iR2odu6Ru2BE1qfeSyTMrcY+bKiNq0m3uP4NkzTmMYzwH+eypJDInzpfwWTdWz75Nb9d
         aolrdCSBN2mffXNpvLYXqwQZcXHJ4ED4uIBct0zJQgTYDy0WAS0jtUbZsTjwTtXIznZL
         hR85f1dJ8N6kBXWvn585x6dzo1QVLbJSjSQcdlw7pRYjl7RHenGbAzor5QbP6MJGtO85
         gcH2frWGfpZQrKSiXIGOEZMMskyrV5S5NilPQfFzqfWxHjlo5HQldGHZerUHvjflnuKd
         6b2Q==
X-Gm-Message-State: AOAM532Ip77M8T0xW0sGJ13qL298KLy2HvQhsiuOAJZ71+ftox2DGpo6
        DKmI2bbWQnbXU0NvivegVMsn/m3sPjfCBA==
X-Google-Smtp-Source: ABdhPJw6JhW1qV2epZLJrV28OBBSw/7YCLZ+K0lgviXXaELurT8VR7jQZi6E5NPaibmSNOn6fYx59Q==
X-Received: by 2002:a63:7018:: with SMTP id l24mr20770896pgc.55.1600328672909;
        Thu, 17 Sep 2020 00:44:32 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/10] builtin/diff: learn --merge-base
Date:   Thu, 17 Sep 2020 00:44:04 -0700
Message-Id: <cover.1600328335.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599723087.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The range-notation in `git diff` has been cited as a mistake since diff
compares two endpoints, not whole ranges.[0]  In fact, the ranges seem
to take on the opposite meanings when compared to range notation in
`git log`.

In an effort to reduce the use of range notation as much as possible,
introduce the `--merge-base` flag, slightly modified from a suggestion
by Jonathan Nieder.[1] This flag allows us to replace the first commit
given on the command-line with its merge base between the first and
second commits. This allows us to gently deprecate the `...` form
entirely, although that is left as an exercise to the reader ;)

One additional bonus is that this flag allows the "after" side to be not
just constrained to a commit (like with `...` notation). It can now be
the working tree or the index as well.

The `--merge-base` name isn't very satisfying. If anyone has any better
suggestions, please let me know.

Changes since v1:

* Implement Junio's documentation suggestions

* Update git diff's usage to include this option

Changes since v2:

* Teach diff-index and diff-tree the --merge-base option as well

[0]: https://lore.kernel.org/git/xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com/
[1]: https://lore.kernel.org/git/20191223215928.GB38316@google.com/

Denton Liu (10):
  t4068: remove unnecessary >tmp
  git-diff-index.txt: make --cached description a proper sentence
  git-diff.txt: backtick quote command text
  contrib/completion: extract common diff/difftool options
  diff-lib: accept option flags in run_diff_index()
  diff-lib: define diff_get_merge_base()
  t4068: add --merge-base tests
  builtin/diff-index: learn --merge-base
  builtin/diff-tree: learn --merge-base
  contrib/completion: complete `git diff --merge-base`

 Documentation/git-diff-index.txt       |   9 +-
 Documentation/git-diff-tree.txt        |   7 +-
 Documentation/git-diff.txt             |  37 +++--
 builtin/diff-index.c                   |  10 +-
 builtin/diff-tree.c                    |  18 +++
 builtin/diff.c                         |  50 ++++---
 contrib/completion/git-completion.bash |  15 +-
 diff-lib.c                             |  65 ++++++++-
 diff.h                                 |   6 +-
 t/t4068-diff-symmetric-merge-base.sh   | 193 +++++++++++++++++++++++++
 t/t4068-diff-symmetric.sh              |  91 ------------
 11 files changed, 358 insertions(+), 143 deletions(-)
 create mode 100755 t/t4068-diff-symmetric-merge-base.sh
 delete mode 100755 t/t4068-diff-symmetric.sh

Range-diff against v2:
 1:  80e9066a59 =  1:  80e9066a59 t4068: remove unnecessary >tmp
 -:  ---------- >  2:  21b20281e6 git-diff-index.txt: make --cached description a proper sentence
 2:  8e72bd8fea =  3:  ca9568c2ea git-diff.txt: backtick quote command text
 3:  ea6717e7b3 <  -:  ---------- builtin/diff: parse --no-index using parse_options()
 4:  4f219cf0d1 <  -:  ---------- builtin/diff: learn --merge-base
 -:  ---------- >  4:  1ac8459541 contrib/completion: extract common diff/difftool options
 -:  ---------- >  5:  496908ac10 diff-lib: accept option flags in run_diff_index()
 -:  ---------- >  6:  6aac57ca02 diff-lib: define diff_get_merge_base()
 -:  ---------- >  7:  c9225a0440 t4068: add --merge-base tests
 -:  ---------- >  8:  1e4f805e57 builtin/diff-index: learn --merge-base
 -:  ---------- >  9:  c0d27b125e builtin/diff-tree: learn --merge-base
 -:  ---------- > 10:  42a8c9b665 contrib/completion: complete `git diff --merge-base`
-- 
2.28.0.618.gf4bc123cb7

