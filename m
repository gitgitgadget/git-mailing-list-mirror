Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739491F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935335AbeFMXFg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:05:36 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:55342 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935070AbeFMXFf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:05:35 -0400
Received: by mail-ua0-f202.google.com with SMTP id n13-v6so1335209uaj.22
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=G5Eazgn/qSv4UyoJOYsWmcP1WigtquJLeOO2JZmZPS8=;
        b=itmSEEBlZu5El5tGTY1gJazzjLLxgXn3uGns+x6MTmm2EACa/lSW9v5CwedoUkm5Rh
         KuMtNxcEBzJjjmO1u+L9J6ZNuiAsLEh7KnjAR/DgycZ0ahtaMUR8/HCzodCDAyyNa0n4
         k5WKSkD+zBju3E3Zq6P5oboTG2tHPRoX2ch7gB/YTPJmSbVLeZSNDwcSVbSa5mlKdfvc
         pOmxjgXVkXXcfQCuAkeAIzLsXuY6Xh9NPl9XEeyZ9cdnUOnl943kKKwIFhX3k25Hl7q3
         nrd5boL19HVIgTMGAxHFHgJnPfVseZiUtCmeTXStnrdFwJSyT70jHGxEU78JiKTglVdB
         ZGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=G5Eazgn/qSv4UyoJOYsWmcP1WigtquJLeOO2JZmZPS8=;
        b=dltCKcTXEXp+ksdaEiFf2n14Dl0qHRN2YwM3PfOegsxhE8LyYIhO/h0ugx7wXfdTTS
         sugSX5jCryAtyFyNeRZuJE/5aBkd6JgYh/4mlDLBPw1VCcczwkp12sM6Tsy3xhizqV8t
         n4xxK0JjmN+bLvdGwgg5T7xPjgndNQUFqMQQRCI7eywHQKYf9mkIMLaQjappFzKh6WoK
         55OQ+Mh4ai+KbIEsyRQS8bcjvcz87f0jU089wtLvMiSImHNXVIrkq7b8lA4D+6pMqLaT
         FKoPGYjIsxyY1ynRM00tJB4U/3+G3hsp0pzqNp5urjdsh8yZqQX/fneVfRpB2AWft65v
         c2/g==
X-Gm-Message-State: APt69E03NdBLyk+GVz0qdHFxFjfzlkoDSYr3zL5jk9jN/EVsMi/dxtF6
        vdKUk4AefFxYXXAoLLUCL3sdofUaRnXc0rRaRlTVoXDskVCw+wyBul2HyaJCo2OKkQ2l3sqsQpW
        6+hjaxPpg/V+wWC6Cc1aZ/53FkHsMhNvR46EGqYSwXrJISpC3iSxszcP+tZqc
X-Google-Smtp-Source: ADUXVKLJlmZddgXGJ5Y+VqZ7JHmDqjbECVDT0jCBbjtPy7SDfj4h1D01NyV2Q+HL39M2P9VAS+N7910gTBue
MIME-Version: 1.0
X-Received: by 2002:a1f:a9cb:: with SMTP id s194-v6mr76739vke.96.1528931134167;
 Wed, 13 Jun 2018 16:05:34 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:04:51 -0700
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
Message-Id: <20180613230522.55335-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 00/31] object-store: lookup_commit
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* removed mentions of cooci patches
* added forward declaration of commit buffer slabs.
* dropped 3 patches that add the repository to lookup_unkonwn_object,
  parse_commit and parse_commit_gently, but were not converting those
  functions. We'll convert these in the next series, as this series is
  growing big already.
* This series can be found as branch 'object-store-lookup-commit' on github,
  it applies on top of nd/commit-util-to-slab merged with sb/object-store-grafts

v1, https://public-inbox.org/git/20180530004810.30076-1-sbeller@google.com/

This applies on the merge of nd/commit-util-to-slab and sb/object-store-grafts,
and is available at http://github.com/stefanbeller/ as branch object-store-lookup-commit
as the merge has some merge conflicts as well as syntactical conflicts (upload-pack.c
and fetch-pack.c introduce new calls of functions that would want to take a repository struct
in the object-store-grafts series)

As layed out in https://public-inbox.org/git/20180517225154.9200-1-sbeller@google.com/
this is getting close to finishing the set of object store series though the last
unfinished part of this RFC hints at new work on the plate:
* To give this series a nice polish, we'd want to convert parse_commit, too.
  But that requires the conversion of the new commit graph. Maybe we need
  to split this series into 2. 
* Once this is in good shape we can talk about converting parts of the revision
  walking code,
* which then can be used by the submodule code as the end goal for the
  object store series.

Thanks,
Stefan

Stefan Beller (31):
  object: add repository argument to lookup_object
  object: add repository argument to parse_object_buffer
  object: add repository argument to object_as_type
  blob: add repository argument to lookup_blob
  tree: add repository argument to lookup_tree
  commit: add repository argument to lookup_commit_reference_gently
  commit: add repository argument to lookup_commit_reference
  commit: add repository argument to lookup_commit
  commit: add repository argument to parse_commit_buffer
  commit: add repository argument to set_commit_buffer
  commit: add repository argument to get_cached_commit_buffer
  tag: add repository argument to lookup_tag
  tag: add repository argument to parse_tag_buffer
  tag: add repository argument to deref_tag
  object: allow object_as_type to handle arbitrary repositories
  object: allow lookup_object to handle arbitrary repositories
  blob: allow lookup_blob to handle arbitrary repositories
  tree: allow lookup_tree to handle arbitrary repositories
  commit: allow lookup_commit to handle arbitrary repositories
  tag: allow lookup_tag to handle arbitrary repositories
  tag: allow parse_tag_buffer to handle arbitrary repositories
  commit.c: allow parse_commit_buffer to handle arbitrary repositories
  commit-slabs: remove realloc counter outside of slab struct
  commit.c: migrate the commit buffer to the parsed object store
  commit.c: allow set_commit_buffer to handle arbitrary repositories
  commit.c: allow get_cached_commit_buffer to handle arbitrary
    repositories
  object.c: allow parse_object_buffer to handle arbitrary repositories
  object.c: allow parse_object to handle arbitrary repositories
  tag.c: allow deref_tag to handle arbitrary repositories
  commit.c: allow lookup_commit_reference_gently to handle arbitrary
    repositories
  commit.c: allow lookup_commit_reference to handle arbitrary
    repositories

 archive.c                |  2 +-
 bisect.c                 |  2 +-
 blame.c                  | 13 +++----
 blob.c                   | 10 +++---
 blob.h                   |  2 +-
 branch.c                 |  2 +-
 builtin/am.c             |  9 +++--
 builtin/branch.c         |  7 ++--
 builtin/checkout.c       |  6 ++--
 builtin/clone.c          |  3 +-
 builtin/commit-tree.c    |  4 ++-
 builtin/describe.c       | 13 +++----
 builtin/diff-tree.c      |  6 ++--
 builtin/diff.c           |  5 +--
 builtin/fast-export.c    | 12 ++++---
 builtin/fetch.c          |  9 +++--
 builtin/fmt-merge-msg.c  |  5 +--
 builtin/fsck.c           | 16 +++++----
 builtin/grep.c           |  3 +-
 builtin/index-pack.c     |  5 +--
 builtin/log.c            |  7 ++--
 builtin/merge-base.c     |  7 ++--
 builtin/merge-tree.c     |  3 +-
 builtin/name-rev.c       |  6 ++--
 builtin/notes.c          |  3 +-
 builtin/pack-objects.c   |  2 +-
 builtin/prune.c          |  2 +-
 builtin/pull.c           | 15 +++++---
 builtin/reflog.c         | 12 ++++---
 builtin/replace.c        |  4 +--
 builtin/reset.c          |  4 +--
 builtin/rev-parse.c      |  6 ++--
 builtin/show-branch.c    |  5 +--
 builtin/tag.c            |  2 +-
 builtin/unpack-objects.c |  7 ++--
 builtin/verify-commit.c  |  4 ++-
 bundle.c                 |  5 +--
 cache-tree.c             |  3 +-
 commit-graph.c           | 14 ++++----
 commit-slab-impl.h       |  3 --
 commit.c                 | 77 +++++++++++++++++++++++++---------------
 commit.h                 | 18 ++++++----
 fast-import.c            |  6 ++--
 fetch-pack.c             | 25 +++++++------
 fsck.c                   |  4 +--
 http-backend.c           |  2 +-
 http-push.c              | 10 +++---
 line-log.c               |  2 +-
 list-objects.c           |  4 +--
 log-tree.c               |  6 ++--
 merge-recursive.c        |  9 ++---
 notes-cache.c            |  3 +-
 notes-merge.c            |  5 +--
 notes-utils.c            |  4 ++-
 object.c                 | 59 ++++++++++++++++--------------
 object.h                 | 13 ++++---
 parse-options-cb.c       |  2 +-
 pretty.c                 |  2 +-
 reachable.c              |  8 ++---
 ref-filter.c             |  9 +++--
 refs.c                   |  2 +-
 remote.c                 | 19 +++++-----
 revision.c               | 12 +++----
 sequencer.c              | 14 ++++----
 server-info.c            |  2 +-
 sha1-file.c              |  4 +--
 sha1-name.c              | 23 ++++++------
 shallow.c                | 30 ++++++++++------
 submodule.c              | 10 +++---
 tag.c                    | 27 +++++++-------
 tag.h                    |  7 ++--
 tree.c                   | 14 ++++----
 tree.h                   |  2 +-
 upload-pack.c            |  4 +--
 walker.c                 |  9 +++--
 wt-status.c              |  2 +-
 76 files changed, 400 insertions(+), 297 deletions(-)

-- 
2.18.0.rc1.244.gcf134e6275-goog

