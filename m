Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C4DC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3632E65279
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhCIUmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCIUlx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:41:53 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EB0C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 12:41:52 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v12so14148850ott.10
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 12:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UNH1+g8QzYuY6FdpBgwPxclcp/jk702fqOcU7oaWwzA=;
        b=NeJQcu74sC6V3Oo4ZLF+CD1Z9s8BLlqxiKipHZRuwSIZeHNEzQxMeVei6GuMcdFgaB
         z/etVM9NPQczAR95l2rGi5zt+Ox6uAktZ7e7CaqDucZdFxkHR+HYJoiRSQWiNsvpXQYd
         nf8TTXgVCOSAZdowNqYenHjXesAFnclrGs9GKWS9qQxdWA5wFlm5OOo8cESMnpu9XxTx
         QzSiks5sZfFkJbyvS0x/xj1krOiO+rqbyYCf08sXzzHOfzMN5adAAkNqycJxhm1D4Huf
         6eJwU7j4wLMTphqCGQjPqHpO+CCUghqxzrfT5c4PkKOX2U3mZxbROGTo0J4ud7Ug0YKe
         7IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UNH1+g8QzYuY6FdpBgwPxclcp/jk702fqOcU7oaWwzA=;
        b=W80gXUCHt7sAIrfr1fK4Var8mqukTMxKovgWxNQ3UOdSuoloh5sPEMvBf9i78oO34d
         Iek4cjKFtUT6LK5kqDeS8yJZTMLhRZd0sAaHT8Q90+x+dWwMKlg+fO8hs0ZP80VhYsgB
         MNJdtj9Z5xrDpohMhOlTo8uDh0JbLbS7SBvk2JIOMYFdAI+fXfyIsmotPX1VlWFjYLyU
         StTZ8EuW+SGI1ooX9uf41yWJRfrZs2cKBRZtzHRAMGydrosgKETjjLdkkWbNpBTQZJCE
         bMuVPOwe+5KcxS8v8Fo2WQaQR2YYzfqxybXXA1nQTleQT0u7uGnemZfulA7W1nyUdXZK
         9P1A==
X-Gm-Message-State: AOAM532DePlxvDB8Q02wXLrV7Y2PfjumarSGEqfOnvX5JRV94QkSiIMd
        x8cD1u4MFDYVk5YMV2LfpKMWMcr1kBCIvJqNtOQewTRGk6I=
X-Google-Smtp-Source: ABdhPJxImmvLxEqjUUcI6gZt+oAkOEoxdbAtqGRmyK6Uph0Rb7xU6pAW6v35fmEjRsbGfJ+ALhAGTxt+UZclL/jDNmk=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr6649559otf.316.1615322512206;
 Tue, 09 Mar 2021 12:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-1-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 12:41:41 -0800
Message-ID: <CABPp-BGqcG7Hpz1=Kf5wNMsTTdxVccGyRVmq5ShYOMG0phcqDg@mail.gmail.com>
Subject: Re: [PATCH 00/30] tree-walk: mostly "mode" to "enum object_type"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> This large series goes on top of my 6 patch series for
> read_tree_recursive() as this one further refactors that function. See
> https://lore.kernel.org/git/20210308022138.28166-1-avarab@gmail.com/
> for that series.
>
> I noticed that since 2014 or so we haven't been doing the fsck checks
> for bad file modes in trees. This series fixes that. I plan to add
> tests etc. for that in another follow-up series.
>
> I wanted to get this out for review sooner than later, particularly
> since the fsck testing will probably get me down another refactoring
> path (fsck testing in general in this area is pretty bad...).
>
> As noted in 30/30 it would have been way easier to simply do an
> isolated fix for that bug by introducing some fsck-specific API for
> raw tree reading.
>
> But I thought the bug was symptomatic of a wider problem in our
> codebase. Namely that we pass around the tree's mode *a lot*.
>
> But almost everything that then deals with the mode doesn't per-se
> care about the mode bits in the tree, but using them to map that mode
> to a tree entry for one of of OBJ_{BLOB,TREE,COMMIT}.
>
> So this is a large refactoring of all users of the widely used
> tree-walk.h API to "enum obj2ect_type", finally in 29/30 I rename the
> field to a scary "raw_mode".
>
> At that point we have just ~30-50 grep hits left for "raw_mode" in the
> codebase (depending on whether we count names in function parameters).
>
> Hopefully being in that state alleviates e.g. Elijah's concerns
> expressed in
> https://lore.kernel.org/git/CABPp-BEdu1PqV5W=3DFuL0f08iFhGzvzV8oSUybNj4eF=
0aAwTnAw@mail.gmail.com/
> I agree that doing the equivalent of 30/30 on top of master would be
> way too scary, but once we're at 29/30 I think it's sane.

It's partially less scary (good cleanups that help make things
clearer, your comment about the code having been in a similar state
once upon a time in patch 30), but in some ways even more scary (after
reading through 30/30 and readily noticing a few missing areas and
starting to dig and finding several more).

>
> I tested this in combination with his on-list series to add more
> merge-ort testing:
> https://lore.kernel.org/git/pull.973.git.git.1614905738.gitgitgadget@gmai=
l.com/
>
> I found a regression I'd caused in the merge-ort.c code with those
> tests, fixed here. See the comment in merge-ort.c in 30/30.

I've read through the whole series now.  It is nicely structured, and
has lots of good cleanups.  Unfortunately, there are also some clear
regressions noted in my comments on both patches 6 and 30.

I'm particularly worried with patch 30's basic plan; I think it'd be
far safer to have the tree-walking default to returning canonicalized
modes but allowing callers to request it be off.  I think each caller
is going to need someone to audit the particular path for whether it
can be safely switched over to using raw modes on a case-by-case basis
and with the introduction of new tests.  Some callers probably aren't
worth the effort (e.g. merge-recursive).  Others might be, but require
a fair amount of work or other trade-offs.  I'm split about whether
merge-ort should consider it.  Using raw_modes might allow me to fix
one funny corner case issue in merge-ort that to my knowledge no user
has ever hit in practice, but I'm not sure fixing that testcase is
worth it.  To fix it, we'd also have to allow writing tree objects
with non-canonicalized modes to the object store (for a "temporary"
tree defining the virtual merge-base); that means new objects with
"broken"/"non-canonicalized" modes being written that users can
access.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (30):
>   diff.c: remove redundant canon_mode() call
>   notes & match-trees: use name_entry's "pathlen" member
>   cache.h: add a comment to object_type()
>   tree-walk.h: add object_type member to name_entry
>   tree-walk.c: migrate to using new "object_type" field when possible
>   cache.h: have base_name_compare() take "is tree?", not "mode"
>   tree-walk.h users: switch object_type(...) to new .object_type
>   tree.h: format argument lists of read_tree_recursive() users
>   tree.h users: format argument lists in archive.c
>   archive: get rid of 'stage' parameter
>   tree.h API: make read_tree_fn_t take an "enum object_type"
>   tree-walk.h users: migrate "p->mode &&" pattern
>   tree-walk.h users: refactor chained "mode" if/else into switch
>   tree-walk.h users: migrate miscellaneous "mode" to "object_type"
>   merge-tree tests: test for the mode comparison in same_entry()
>   merge-ort: correct reference to test in 62fdec17a11
>   fsck.c: switch on "object_type" in fsck_walk_tree()
>   tree-walk.h users: use temporary variable(s) for "mode"
>   tree-walk.h API: formatting changes for subsequent commit
>   tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
>   tree-walk.h API users: use "tmp" for mode in shift_tree_by()
>   tree-walk.h API: Add get_tree_entry_type()
>   tree-walk.h API: add a get_tree_entry_path() function
>   tree-walk.h API: document and format tree_entry_extract()
>   tree-entry.h API: rename tree_entry_extract() to
>     tree_entry_extract_mode()
>   tree-walk.h API: add a tree_entry_extract_all() function
>   tree-walk.h API: add a tree_entry_extract_type() function
>   tree-walk.h API users: rename "struct name_entry"'s "mode" to
>     "raw_mode"
>   tree.h API users: rename read_tree_fn_t's "mode" to "raw_mode"
>   tree-walk.h API: move canon_mode() back out of decode_tree_entry()
>
>  archive.c              | 51 +++++++++++++-----------
>  blame.c                |  9 +++--
>  builtin/checkout.c     |  7 +++-
>  builtin/fast-import.c  |  8 ++--
>  builtin/grep.c         |  6 +--
>  builtin/log.c          |  7 ++--
>  builtin/ls-files.c     | 13 +++---
>  builtin/ls-tree.c      | 18 ++++-----
>  builtin/merge-tree.c   | 32 +++++++++------
>  builtin/mktree.c       |  4 +-
>  builtin/pack-objects.c |  6 +--
>  builtin/reflog.c       |  3 +-
>  builtin/rm.c           |  2 +-
>  builtin/update-index.c |  7 +++-
>  cache-tree.c           |  2 +-
>  cache.h                | 11 ++++--
>  combine-diff.c         |  8 ++--
>  delta-islands.c        |  2 +-
>  diff.c                 |  2 +-
>  fsck.c                 | 23 +++++------
>  http-push.c            |  6 ++-
>  line-log.c             |  2 +-
>  list-objects.c         | 20 +++++++---
>  match-trees.c          | 52 ++++++++++++------------
>  merge-ort.c            | 34 ++++++++++------
>  merge-recursive.c      | 33 ++++++++--------
>  notes.c                | 15 +++----
>  object-name.c          |  7 ++--
>  pack-bitmap-write.c    |  8 ++--
>  read-cache.c           | 16 ++++----
>  revision.c             | 12 ++++--
>  t/t4300-merge-tree.sh  | 44 +++++++++++++++++++++
>  tree-diff.c            | 44 ++++++++++++---------
>  tree-walk.c            | 89 +++++++++++++++++++++++++++++++-----------
>  tree-walk.h            | 67 ++++++++++++++++++++++++++-----
>  tree.c                 | 19 +++++----
>  tree.h                 |  5 ++-
>  unpack-trees.c         | 30 ++++++++------
>  walker.c               | 22 ++++++-----
>  39 files changed, 482 insertions(+), 264 deletions(-)
>
> --
> 2.31.0.rc0.126.g04f22c5b82
>
