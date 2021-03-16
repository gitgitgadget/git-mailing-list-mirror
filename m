Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B298AC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 17:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CEB6511D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 17:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhCPR2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbhCPR20 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 13:28:26 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5F8C06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 10:28:25 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o22so29196602oic.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7H7Xwhqu8ug78MPbA0wlEBFc/iZJ3z+2as3JKnjZpgQ=;
        b=Vh0s77G/5D0257hYMuh1Bdt5+lY9sebdexSEbkgFOomFM2+auyZkvI5rerfdq10C+b
         NQYuVKPfoFY7eVMbrGsGWnpHn10euSJUDeOuAijsh6ink5sn/jZP9MCWWSV29m2XI0uj
         snr6zM8m78FE+HbDIgPrKqUqKs+zEG/+Y3uf9DiSSHuw+R0ITM2n+B2cIOudreWZM0iN
         wNtf5wca+1ky8XffUJLu4b+EvpYuBPZV2ZdWUJLHQvuFi7TV88TopM8ARNxFBwbK8XIV
         +5SBgWNTOKF90ulP8kp7Jj7aYrm9+1R+P+sdu35PZe5JM/8vkS5mGuJ9NVFvk9BeL1Rb
         BKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7H7Xwhqu8ug78MPbA0wlEBFc/iZJ3z+2as3JKnjZpgQ=;
        b=tbV2VAWn2J7SH20QRGE4QWY+ZzD8DAIrZeDzqDEM0PvjXUtzH+oZNvQQ7T6AYv13+Y
         YtAzA5/LBN91fRjROS9GGWjeX8pGjIkqE2zKOcCLdNjRLtxY66KxLt/qkZ9PEiDH4MU0
         yylvRyMtQkFWKNiSEHrJaQJ2KvgjKsyUBSmjQ5GgrkbKuv5xbzac+F4a4G7JHsbR/Xso
         uokgEcGcIwZvK5HoTiAnGsA+lNr21Nalx3InTxvQhy+cRVUFVbqYdfSS2DozzqwXVHKW
         tkEI/moZvC1lTsXrBdbiUGXBmaAg3WU7pBajzNyGmp5VLJe7740u3MzqLLDHJuf3Xmnj
         McSw==
X-Gm-Message-State: AOAM532jfwoZJrH2Lba16D0pCC483Qs8GD8joeB3nSfth3osLvnNQZbJ
        TQNWdJxbIZCiZGhl97GRpslRD29FdzHD5TmNhZk=
X-Google-Smtp-Source: ABdhPJz1rywC1izSRjR3uZfgfjLa/7rS+xHW6VoUyvsz6cONRYuKT7Ccb9u/t8pkNrBmQWOVdkTXWhwo0NmFVa70QdI=
X-Received: by 2002:aca:4fc1:: with SMTP id d184mr105694oib.31.1615915702575;
 Tue, 16 Mar 2021 10:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210316021312.13927-1-avarab@gmail.com> <20210316155829.31242-1-avarab@gmail.com>
In-Reply-To: <20210316155829.31242-1-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Mar 2021 10:28:11 -0700
Message-ID: <CABPp-BGnc+e9SBJfufL1zFLf0hoPsBT=+Hivi7ESWyX5ez8cUg@mail.gmail.com>
Subject: Re: [PATCH v3 00/32] tree-walk: mostly replace "mode" with "enum object_type"
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

On Tue, Mar 16, 2021 at 8:58 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The v2 of this series was broken as noted in
> https://lore.kernel.org/git/87blbjfqkh.fsf@evledraar.gmail.com/
>
> Here's a fixed version. This should actually address all of Elijah's
> comments on v1 + v2.

Yep, this one looks good to me.  Thanks!

>
> It's up to 32 patches because I added some tests for the
> mostly-never-been-tested code being changed in 09/32.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (32):
>   diff.c: remove redundant canon_mode() call
>   notes & match-trees: use name_entry's "pathlen" member
>   cache.h: add a comment to object_type()
>   tree-walk.h: add object_type member to name_entry
>   tree-walk.c: migrate to using new "object_type" field when possible
>   fast-import tests: test for sorting dir/file foo v.s. foo.txt
>   mktree tests: test that "mode" is passed when sorting
>   diff tests: test that "mode" is passed when sorting
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
>   match-trees: use "tmp" for mode in shift_tree_by()
>   tree-walk.h API: add get_tree_entry_type()
>   tree-walk.h API: document and format tree_entry_extract()
>   tree-entry.h API: rename tree_entry_extract() to
>     tree_entry_extract_mode()
>   tree-walk.h API: add a tree_entry_extract_all() function
>   tree-walk.h API: add get_tree_entry_all()
>   tree-walk.h API: add a get_tree_entry_path() function
>   blame: emit a better error on 'git blame directory'
>   tree-walk.h API: add a tree_entry_extract_type() function
>
>  archive.c                       | 50 +++++++++---------
>  blame.c                         |  9 ++--
>  builtin/checkout.c              |  6 ++-
>  builtin/fast-import.c           | 12 +++--
>  builtin/grep.c                  |  6 +--
>  builtin/log.c                   |  7 +--
>  builtin/ls-files.c              |  6 ++-
>  builtin/ls-tree.c               | 14 +++---
>  builtin/merge-tree.c            | 30 +++++++----
>  builtin/mktree.c                |  4 +-
>  builtin/pack-objects.c          |  6 +--
>  builtin/reflog.c                |  3 +-
>  builtin/rm.c                    |  2 +-
>  builtin/update-index.c          |  6 ++-
>  cache-tree.c                    |  2 +-
>  cache.h                         | 11 ++--
>  combine-diff.c                  |  8 +--
>  delta-islands.c                 |  2 +-
>  diff.c                          |  2 +-
>  fsck.c                          | 23 ++++-----
>  http-push.c                     |  6 ++-
>  line-log.c                      |  2 +-
>  list-objects.c                  | 20 +++++---
>  match-trees.c                   | 52 +++++++++----------
>  merge-ort.c                     | 13 ++---
>  merge-recursive.c               | 33 ++++++------
>  notes.c                         | 14 +++---
>  object-name.c                   |  7 ++-
>  pack-bitmap-write.c             |  8 +--
>  read-cache.c                    | 16 +++---
>  revision.c                      | 12 +++--
>  t/t1450-fsck.sh                 | 66 ++++++++++++++++++++++++
>  t/t4300-merge-tree.sh           | 44 ++++++++++++++++
>  t/t8004-blame-with-conflicts.sh | 21 ++++++++
>  t/t9300-fast-import.sh          | 87 ++++++++++++++++++++++++++++++++
>  tree-diff.c                     | 30 +++++++----
>  tree-walk.c                     | 89 ++++++++++++++++++++++++---------
>  tree-walk.h                     | 63 ++++++++++++++++++++---
>  tree.c                          | 19 ++++---
>  tree.h                          |  5 +-
>  unpack-trees.c                  | 24 +++++----
>  walker.c                        | 22 ++++----
>  42 files changed, 618 insertions(+), 244 deletions(-)
>
> Range-diff:
>  1:  f9bbc30f69 =3D  1:  26bc38fbdd diff.c: remove redundant canon_mode()=
 call
>  2:  187fc2c3e6 =3D  2:  8502cf8134 notes & match-trees: use name_entry's=
 "pathlen" member
>  3:  311637c558 =3D  3:  68133fa6aa cache.h: add a comment to object_type=
()
>  4:  fecfe3d462 =3D  4:  9f714d6c01 tree-walk.h: add object_type member t=
o name_entry
>  5:  db961ab5e8 =3D  5:  6dbf2b0a6a tree-walk.c: migrate to using new "ob=
ject_type" field when possible
>  -:  ---------- >  6:  354a8e9a2a fast-import tests: test for sorting dir=
/file foo v.s. foo.txt
>  -:  ---------- >  7:  e2331df28e mktree tests: test that "mode" is passe=
d when sorting
>  -:  ---------- >  8:  9e9486c2ea diff tests: test that "mode" is passed =
when sorting
>  6:  df2fc76161 !  9:  be5c713336 cache.h: have base_name_compare() take =
"is tree?", not "mode"
>     @@ Commit message
>          958ba6c96eb (Introduce "base_name_compare()" helper function,
>          2005-05-20).
>
>     +    None of these comparison functions used to have tests, but with
>     +    preceding commits some of them now do. I thought the remainder w=
as
>     +    trivial enough to review without tests, and didn't want to spend=
 more
>     +    time on them.
>     +
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>       ## builtin/fast-import.c ##
>      @@ builtin/fast-import.c: static int tecmp0 (const void *_a, const v=
oid *_b)
>     + {
>         struct tree_entry *a =3D *((struct tree_entry**)_a);
>         struct tree_entry *b =3D *((struct tree_entry**)_b);
>     ++  int istree_a =3D S_ISDIR(a->versions[0].mode);
>     ++  int istree_b =3D S_ISDIR(b->versions[0].mode);
>         return base_name_compare(
>      -          a->name->str_dat, a->name->str_len, a->versions[0].mode,
>      -          b->name->str_dat, b->name->str_len, b->versions[0].mode);
>     -+          a->name->str_dat, a->name->str_len, 1,
>     -+          b->name->str_dat, b->name->str_len, 1);
>     ++          a->name->str_dat, a->name->str_len, istree_a,
>     ++          b->name->str_dat, b->name->str_len, istree_b);
>       }
>
>       static int tecmp1 (const void *_a, const void *_b)
>     -@@ builtin/fast-import.c: static int tecmp1 (const void *_a, const v=
oid *_b)
>     + {
>         struct tree_entry *a =3D *((struct tree_entry**)_a);
>         struct tree_entry *b =3D *((struct tree_entry**)_b);
>     ++  int istree_a =3D S_ISDIR(a->versions[1].mode);
>     ++  int istree_b =3D S_ISDIR(b->versions[1].mode);
>         return base_name_compare(
>      -          a->name->str_dat, a->name->str_len, a->versions[1].mode,
>      -          b->name->str_dat, b->name->str_len, b->versions[1].mode);
>     -+          a->name->str_dat, a->name->str_len, 1,
>     -+          b->name->str_dat, b->name->str_len, 1);
>     ++          a->name->str_dat, a->name->str_len, istree_a,
>     ++          b->name->str_dat, b->name->str_len, istree_b);
>       }
>
>       static void mktree(struct tree_content *t, int v, struct strbuf *b)
>  7:  49d5da8c08 =3D 10:  43623edddf tree-walk.h users: switch object_type=
(...) to new .object_type
>  8:  c9d209d496 =3D 11:  030898f884 tree.h: format argument lists of read=
_tree_recursive() users
>  9:  a6d2660fe1 =3D 12:  0ce197950b tree.h users: format argument lists i=
n archive.c
> 10:  15f7f89acc =3D 13:  051c9f32ac archive: get rid of 'stage' parameter
> 11:  7a71404ea3 =3D 14:  bc73994b4c tree.h API: make read_tree_fn_t take =
an "enum object_type"
> 12:  64dc9364ba =3D 15:  e2b0964228 tree-walk.h users: migrate "p->mode &=
&" pattern
> 13:  93ed3edbbd =3D 16:  29dbc4292e tree-walk.h users: refactor chained "=
mode" if/else into switch
> 14:  7aa48aa34c =3D 17:  ada6d05176 tree-walk.h users: migrate miscellane=
ous "mode" to "object_type"
> 15:  3ae81621dc =3D 18:  01860daa55 merge-tree tests: test for the mode c=
omparison in same_entry()
> 16:  4249ad5c4d =3D 19:  e4be48fb50 merge-ort: correct reference to test =
in 62fdec17a11
> 17:  e5e17505dd =3D 20:  189d2550fb fsck.c: switch on "object_type" in fs=
ck_walk_tree()
> 18:  3f0b884f1f =3D 21:  3b7b12e6f7 tree-walk.h users: use temporary vari=
able(s) for "mode"
> 19:  174167613b =3D 22:  6c3a07a327 tree-walk.h API: formatting changes f=
or subsequent commit
> 20:  ec76db613f =3D 23:  879eb3da2a tree-walk.h API: rename get_tree_entr=
y() to get_tree_entry_mode()
> 21:  11e3494172 ! 24:  d2fa360ab9 tree-walk.h API users: use "tmp" for mo=
de in shift_tree_by()
>     @@ Metadata
>      Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
>       ## Commit message ##
>     -    tree-walk.h API users: use "tmp" for mode in shift_tree_by()
>     +    match-trees: use "tmp" for mode in shift_tree_by()
>
>          Refactor code added in 85e51b783c3 (Make "subtree" part more
>          orthogonal to the rest of merge-recursive., 2008-06-30) to make =
it
> 22:  b31c106557 =3D 25:  cc50cfcf51 tree-walk.h API: add get_tree_entry_t=
ype()
> 23:  304d5d4d1a =3D 26:  f642a35482 tree-walk.h API: document and format =
tree_entry_extract()
> 24:  346453df35 =3D 27:  a0bcb59fa5 tree-entry.h API: rename tree_entry_e=
xtract() to tree_entry_extract_mode()
> 25:  dd012b661e =3D 28:  c7d4ba7734 tree-walk.h API: add a tree_entry_ext=
ract_all() function
> 26:  b6ee8410e3 =3D 29:  1d5421d67a tree-walk.h API: add get_tree_entry_a=
ll()
> 27:  5c98afd9e7 ! 30:  a3e1063ac4 tree-walk.h API: add a get_tree_entry_p=
ath() function
>     @@ Commit message
>          need neither the mode nor "enum object_type" parameters filled f=
or
>          them.
>
>     -    There's callers here which doesn't need the "struct object_id" f=
illed
>     -    either, and provides a throwaway variable for us.
>     +    There are callers here which don't need the "struct object_id" f=
illed;
>     +    forcing callers to pass one just requires they create a throwawa=
y
>     +    variable.
>
>          See the following commits for the introduction of such code that=
's
>          being modified here:
>
>     -     - shift_tree(): 68faf68938e (A new merge stragety 'subtree'.,
>     +     - shift_tree(): 68faf68938e (A new merge stragety[sic] 'subtree=
'.,
>              2007-02-15) for the shift_tree()
>
>           - tree_has_path(): 96e7ffbdc31 (merge-recursive: check for dire=
ctory
> 28:  3e7e0f7eb8 ! 31:  da3dd6dd53 blame: emit a better error on 'git blam=
e directory'
>     @@ Commit message
>
>              fatal: no such path 't' in HEAD
>
>     +    The main point of this test is to assert that we're not doing
>     +    something uniquely bad when in a conflicted merge. See
>     +    cd8ae20195 (git-blame shouldn't crash if run in an unmerged tree=
,
>     +    2007-10-18) and 9aeaab6811 (blame: allow "blame file" in the mid=
dle of
>     +    a conflicted merge, 2012-09-11) for the bug the t8004 test was
>     +    originally meant to address.
>     +
>     +    But when extending it let's grep out the specific error message =
for
>     +    good measure. Having to change it in the future (e.g. as part of=
 my
>     +    parallel series to improve such 'OID does not match type' messag=
es) is
>     +    a small price for ensuring it doesn't regress.
>     +
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>       ## blame.c ##
>     @@ t/t8004-blame-with-conflicts.sh: test_expect_success 'blame does n=
ot crash with
>      +  test_commit second &&
>      +  test_commit d/file &&
>      +  test_must_fail git blame d 2>expected &&
>     ++  grep "unsupported file type d" expected &&
>      +
>      +  git reset --hard second &&
>      +  >d &&
> 29:  ac1ccf1357 =3D 32:  80e5cb0b30 tree-walk.h API: add a tree_entry_ext=
ract_type() function
> --
> 2.31.0.256.gf0ddda3145
>
