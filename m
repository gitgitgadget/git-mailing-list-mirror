Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40AEA1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756211AbeDYSVR (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:21:17 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:40381 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756170AbeDYSVK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:10 -0400
Received: by mail-pf0-f180.google.com with SMTP id f189so6818373pfa.7
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kQ00K9A6CsZH015KuOgF+07zMYC9PFYDbdSJCV5g0Ng=;
        b=kQVG1K/SLio32qoS5nK4l8bgsYq2TBIdbI6U+QjKTVdEp+bTtkORSlRUFKjCTJwjLL
         /p72JX5fk2uEHW56XKZhi4q1UOUclc5yPhLLi1EN+P29TimrFdxTtZ0rFt+Eijmvg+ya
         S7eFPInDCMJwxzK+NKEIRuvlH8GmB0di1P3t6wEkjbcNNbEQP/0XLZWi4oLT5obIVraA
         kbHzX3wsa2zHrjG/NdHNZfWHgAxIQ+aUZnWrx176ShrAxxoezk8DrCDfY144WxkRceO6
         8X0qpJMeyFdXfMpWjL7vaUL/feRPTd4Lo3CTSl6j3wC8gUTOqHZAeOgYpTTPEwr9TKtN
         2KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kQ00K9A6CsZH015KuOgF+07zMYC9PFYDbdSJCV5g0Ng=;
        b=GQUZVkKvx2e/ziBOyItgGx9u1v23PHYMyN0bsefwo/YVFbMp1T7cv46JhiRNblbbjC
         MnxXMytD58xMnTnRFPA4tX8pKubtLRvn9dLrK/SwypbcNi+QDLHzoRJwIcprT70pQ4yo
         /x08CVZtzmdXX8+Igos3flQJIgSMHkKGdhTczS3olvFBxPPkSkyjrUnhEkio+KNq9W30
         JBdXts3UAmY/Of0Dyg3J4mETE5xd8UZUlT3eu41Y00NIUQZnqRnWQPbpYPkTXhTEahXX
         EpWGrXdLcz1zYKqY61np+l1b68m35PgYKAS2DXFpR8bbnrJWnDIfXb/fKp6czDGiSKSm
         hTgQ==
X-Gm-Message-State: ALQs6tBbqibcBzPgRMHHjZKEUeUKznKl1ZsutouuqC6+jiXbABPrRXB6
        crgndCGtCEC8gaPtJzwABZdX2w==
X-Google-Smtp-Source: AIpwx49Yu1DkNqkLaRCG/Tn4fJQAdTBYoIiASLM8EQ+HiC7hDhUNxMNUykg4xwV8/FrUlDI93D5PoA==
X-Received: by 2002:a17:902:22a:: with SMTP id 39-v6mr30494660plc.128.1524680469471;
        Wed, 25 Apr 2018 11:21:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a4sm43918860pfj.107.2018.04.25.11.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 11:21:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net
Subject: [PATCHv3 0/9] object store: oid_object_info is the next contender
Date:   Wed, 25 Apr 2018 11:20:57 -0700
Message-Id: <20180425182106.162972-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* fixed and extended the commit message of last commit
* fixed the last patch, as Jonathan Tan suggested, see interdiff:

    $ git diff remotes/origin/sb/oid-object-info (which is v2)
    diff --git c/sha1_file.c w/sha1_file.c
    index 94123e0299..dcd6b879ac 100644
    --- c/sha1_file.c
    +++ w/sha1_file.c
    @@ -1289,14 +1289,13 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
     
                    /* Check if it is a missing object */
                    if (fetch_if_missing && repository_format_partial_clone &&
    -                   !already_retried) {
    +                   !already_retried && r == the_repository) {
                            /*
                             * TODO Investigate having fetch_object() return
                             * TODO error/success and stopping the music here.
    -                        * TODO Pass a repository struct through fetch_object.
    +                        * TODO Pass a repository struct through fetch_object,
    +                        * such that arbitrary repositories work.
                             */
    -                       if (r != the_repository)
    -                               die(_("partial clones only supported in the_repository"));
                            fetch_object(repository_format_partial_clone, real->hash);
                            already_retried = 1;
                            continue;
    
Thanks,
Stefan

v2:

* fixed the sha1/oid typo
* removed spurious new line
* Brandon and Jonthan discovered another dependency that I missed due
  to cherrypicking that commit from a tree before partial clone was a thing.
  We error out when attempting to use fetch_object for repos that are not
  the_repository.

Thanks,
Stefan

v1:
This applies on top of origin/sb/object-store-replace and is available as
https://github.com/stefanbeller/git/tree/oid_object_info

This continues the work of sb/packfiles-in-repository,
extending the layer at which we have to pass in an explicit
repository object to oid_object_info.

A test merge to next shows only a minor merge conflicit (adding
different #include lines in one c file), so this might be a good next
step for the object store series.

Notes on further object store series:
I plan on converting the "parsed object store" next,
which would be {alloc, object, tree, commit, tag}.c as that is a prerequisite
for migrating shallow (which is intermingled with grafts) information to the
object store.

There is currently work going on in allocation (mempool - Jameson Miller)
and grafts (deprecate grafts - DScho), which is why I am sending this
series first. I think it can go in parallel to the "parsed object store"
that is coming next.

Thanks,
Stefan

Jonathan Nieder (1):
  packfile: add repository argument to packed_object_info

Stefan Beller (8):
  cache.h: add repository argument to oid_object_info_extended
  cache.h: add repository argument to oid_object_info
  packfile: add repository argument to retry_bad_packed_offset
  packfile: add repository argument to packed_to_object_type
  packfile: add repository argument to read_object
  packfile: add repository argument to unpack_entry
  packfile: add repository argument to cache_or_unpack_entry
  cache.h: allow oid_object_info to handle arbitrary repositories

 archive-tar.c            |  2 +-
 archive-zip.c            |  3 ++-
 blame.c                  |  4 ++--
 builtin/blame.c          |  2 +-
 builtin/cat-file.c       | 12 ++++++------
 builtin/describe.c       |  2 +-
 builtin/fast-export.c    |  2 +-
 builtin/fetch.c          |  2 +-
 builtin/fsck.c           |  3 ++-
 builtin/index-pack.c     |  4 ++--
 builtin/ls-tree.c        |  2 +-
 builtin/mktree.c         |  2 +-
 builtin/pack-objects.c   | 11 +++++++----
 builtin/prune.c          |  3 ++-
 builtin/replace.c        | 11 ++++++-----
 builtin/tag.c            |  4 ++--
 builtin/unpack-objects.c |  2 +-
 cache.h                  |  7 +++++--
 diff.c                   |  3 ++-
 fast-import.c            | 16 ++++++++++------
 list-objects-filter.c    |  2 +-
 object.c                 |  2 +-
 pack-bitmap-write.c      |  3 ++-
 pack-check.c             |  3 ++-
 packfile.c               | 40 +++++++++++++++++++++++-----------------
 packfile.h               |  6 ++++--
 reachable.c              |  2 +-
 refs.c                   |  2 +-
 remote.c                 |  2 +-
 sequencer.c              |  3 ++-
 sha1_file.c              | 37 +++++++++++++++++++++----------------
 sha1_name.c              | 12 ++++++------
 streaming.c              |  2 +-
 submodule.c              |  2 +-
 tag.c                    |  2 +-
 35 files changed, 124 insertions(+), 93 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog

