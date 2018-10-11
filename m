Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FEE1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJLErD (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:03 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:33836 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:03 -0400
Received: by mail-io1-f74.google.com with SMTP id y3-v6so9195454iob.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dme8qhhcnqeTIjMFt2ETKNBE+mclOGW530yf5DU2+Ec=;
        b=gt61NAzpytx/Wb1Jlnl3PeeevePuYTVAcgv9xfTOMq7r0pDkRYjXFE/hg3XvK+WG66
         qGmdkcaXznDoAf5n61kzvxsuXfiygJBVtwi6uvK6SXs8IsgqUy8NylLYAs1yvEcKvHpY
         upjiS7tEtSAPHmrcCHUJUaui1TjXkWq0rE0MawCwshuodcLMa5DvjJbFtG9L1lQCTd/G
         zaRjV9dDCSTFbYIv8cPcuwsgdlcITtaqDhM7aAYJHQS++XloTQIeMVxxnh+NM43JyqF+
         7x4OmNJYNF8/kzkUR5QmqsWcmrkhl6yn651yiyQ1ROnysNqY+CVMtxQyUljfzC/abW8J
         heyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dme8qhhcnqeTIjMFt2ETKNBE+mclOGW530yf5DU2+Ec=;
        b=N3dCY8iEgCMsV1N7lkXzPvYLnWCwx5+ooUpLjZI1fITaM4c47N7TRZFO+QKbaWea27
         4nnFIVyTLUhUTyvOqUSHqctx9wC3NJRonCw9ab7KexP/xktAnkMyZHUcTKRYoDEO+z9u
         fC+5/0L6esGpbhSBJuoxPHze1NGEQYNH8/or28sZa9wt11XZa21gM0+ZLmSeUPSk1uZI
         LCfepZqFVBFnEcGLco03CXe9xuj1zx1LMCrJj1GJpv5p3krdsA9u0fLNXO8W2I4JZUER
         18NrGa/vvrw2RWUfOLULoc65WU8GvBGddxG2qmPo0AGWM/cPtBTFklEjCmrGvY9BWRuO
         mbvQ==
X-Gm-Message-State: ABuFfojK3i3yrXj9aPB6IaOAcosdrv4Q2iuuHrXvNUJzl1KCljr03CIB
        Y5EnCpiNhPjh/8MfQU+v6FhdbEUIrJh4RsW4s5vLKlB3c5XQR1qMXhuMEiZWIIyKl2A4EeaHdox
        hcBWggUzPXkw6mrD00TzFFdECXks3qXSrvDIz+19oDvrcEWWzrsWO+vYq72M+
X-Google-Smtp-Source: ACcGV60YNdBnB7UJyziWBvIjfP8dhJRFfFWy2l/tcoQ1aFzTQIrzggMwT3Ctq4nDUKumY9uAC7sxK7+kQHTY
X-Received: by 2002:a05:660c:145:: with SMTP id r5mr2949877itk.25.1539292678054;
 Thu, 11 Oct 2018 14:17:58 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:35 -0700
Message-Id: <20181011211754.31369-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [RFC PATCH 00/19] Bring more repository handles into our code base
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies on nd/the-index (b3c7eef9b05) and is the logical continuation of
the object store series, which I sent over the last year.

The previous series did take a very slow and pedantic approach,
using a #define trick, see cfc62fc98c for details, but it turns out,
that it doesn't work:
   When changing the signature of widely used functions, it burdens the
   maintainer in resolving the semantic conflicts.
   
   In the orginal approach this was called a feature, as then we can ensure
   that not bugs creep into the code base during the merge window (while such
   a refactoring series wanders from pu to master). It turns out this
   was not well received and was just burdensome.
   
   The #define trick doesn't buy us much to begin with when dealing with
   non-merge-conflicts.  For example, see deref_tag at tag.c:68, which got
   the repository argument in 286d258d4f (tag.c: allow deref_tag to handle
   arbitrary repositories, 2018-06-28) but lost its property of working on any
   repository while 8c4cc32689 (tag: don't warn if target is missing but
   promised, 2018-07-12) was in flight simultaneously.
   
   Another example of failure of this approach is seen in patch 5, which
   shows that the pedantry was missed.
        
This series takes another approach as it doesn't change the signature of
functions, but introduces new functions that can deal with arbitrary 
repositories, keeping the old function signature around using a shallow wrapper.

Additionally each patch adds a semantic patch, that would port from the old to
the new function. These semantic patches are all applied in the very last patch,
but we could omit applying the last patch if it causes too many merge conflicts
and trickl in the semantic patches over time when there are no merge conflicts.


The original goal of all these refactoring series was to remove add_submodule_odb 
in submodule.c, which was partially reached with this series. I'll investigate the
remaining calls in another series, but it shows we're close to be done with these
large refactorings as far as I am concerned.

Thanks,
Stefan

Stefan Beller (19):
  sha1_file: allow read_object to read objects in arbitrary repositories
  packfile: allow has_packed_and_bad to handle arbitrary repositories
  object-store: allow read_object_file_extended to read from arbitrary
    repositories
  object-store: prepare read_object_file to deal with arbitrary
    repositories
  object: parse_object to honor its repository argument
  commit: allow parse_commit* to handle arbitrary repositories
  commit.c: allow paint_down_to_common to handle arbitrary repositories
  commit.c: allow merge_bases_many to handle arbitrary repositories
  commit.c: allow remove_redundant to handle arbitrary repositories
  commit: allow get_merge_bases_many_0 to handle arbitrary repositories
  commit: prepare get_merge_bases to handle arbitrary repositories
  commit: prepare get_commit_buffer to handle arbitrary repositories
  commit: prepare in_merge_bases[_many] to handle arbitrary repositories
  commit: prepare repo_unuse_commit_buffer to handle arbitrary
    repositories
  commit: prepare logmsg_reencode to handle arbitrary repositories
  pretty: prepare format_commit_message to handle arbitrary repositories
  submodule: use submodule repos for object lookup
  submodule: don't add submodule as odb for push
  Apply semantic patches from previous patches

 apply.c                                 |   6 +-
 archive.c                               |   5 +-
 bisect.c                                |   5 +-
 blame.c                                 |  15 +--
 builtin/am.c                            |   2 +-
 builtin/blame.c                         |   4 +-
 builtin/cat-file.c                      |  21 +++--
 builtin/checkout.c                      |   4 +-
 builtin/commit.c                        |  13 ++-
 builtin/describe.c                      |   4 +-
 builtin/difftool.c                      |   3 +-
 builtin/fast-export.c                   |   7 +-
 builtin/fmt-merge-msg.c                 |   8 +-
 builtin/grep.c                          |   2 +-
 builtin/index-pack.c                    |   8 +-
 builtin/log.c                           |   4 +-
 builtin/merge-base.c                    |   2 +-
 builtin/merge-tree.c                    |   9 +-
 builtin/mktag.c                         |   3 +-
 builtin/name-rev.c                      |   2 +-
 builtin/notes.c                         |  12 ++-
 builtin/pack-objects.c                  |  22 +++--
 builtin/reflog.c                        |   5 +-
 builtin/replace.c                       |   2 +-
 builtin/shortlog.c                      |   5 +-
 builtin/show-branch.c                   |   4 +-
 builtin/tag.c                           |   4 +-
 builtin/unpack-file.c                   |   2 +-
 builtin/unpack-objects.c                |   3 +-
 builtin/verify-commit.c                 |   2 +-
 bundle.c                                |   2 +-
 combine-diff.c                          |   2 +-
 commit-graph.c                          |   8 +-
 commit.c                                | 120 ++++++++++++++----------
 commit.h                                |  67 ++++++++++---
 config.c                                |   2 +-
 contrib/coccinelle/the_repository.cocci | 114 ++++++++++++++++++++++
 diff.c                                  |   3 +-
 dir.c                                   |   2 +-
 entry.c                                 |   3 +-
 fast-import.c                           |   7 +-
 fsck.c                                  |   9 +-
 grep.c                                  |   3 +-
 http-push.c                             |   3 +-
 log-tree.c                              |   3 +-
 mailmap.c                               |   2 +-
 match-trees.c                           |   4 +-
 merge-blobs.c                           |   6 +-
 merge-recursive.c                       |  13 +--
 negotiator/default.c                    |   6 +-
 negotiator/skipping.c                   |   2 +-
 notes-cache.c                           |   5 +-
 notes-merge.c                           |   4 +-
 notes-utils.c                           |   2 +-
 notes.c                                 |  10 +-
 object-store.h                          |  13 ++-
 object.c                                |   2 +-
 packfile.c                              |   5 +-
 packfile.h                              |   2 +-
 pretty.c                                |  33 ++++---
 pretty.h                                |   7 +-
 read-cache.c                            |   5 +-
 remote-testsvn.c                        |   4 +-
 remote.c                                |   2 +-
 rerere.c                                |   5 +-
 revision.c                              |  12 +--
 sequencer.c                             |  55 ++++++-----
 sha1-file.c                             |  22 +++--
 sha1-name.c                             |   9 +-
 shallow.c                               |   4 +-
 streaming.c                             |   2 +-
 submodule-config.c                      |   3 +-
 submodule.c                             |  51 +++++++---
 t/helper/test-revision-walking.c        |   3 +-
 tag.c                                   |   5 +-
 tree-walk.c                             |   6 +-
 tree.c                                  |   5 +-
 walker.c                                |   2 +-
 xdiff-interface.c                       |   2 +-
 79 files changed, 571 insertions(+), 278 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.cocci

-- 
2.19.0

