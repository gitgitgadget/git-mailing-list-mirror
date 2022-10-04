Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C23C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 15:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJDP4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDP4H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 11:56:07 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215431E3D3
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 08:56:06 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1321a1e94b3so11189201fac.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9G0qMC/ABjMPqiy9S5JGEdHQ+CYHKXaMUSMSPV9fg4c=;
        b=FUe/rZpBGHkD8IP8pwNgULjzAo9By8kGQI7tf54h49nxCH1QbII527fk39Lk1+KbHf
         GpQgZvF+LLLW8lrqen623iQKB+B4QIiAJtWB75uH7MjF3N3wJx8kA8jfcrtwlI/7rrak
         2esbnoyavMFJyGZqw9HYpWAinYQAf/r53mBRy3FN0eK5shCRjotoFjY55TB8YtY4OPoj
         AQZ46fEt5Bj8fLFHiobf11KAMe2rq3x81XLqPqUMaLDgty3kGwFocTEsjdOm5asgp8H4
         wby1w4zwHKdkA/dXA5FVCfpG7EZqFvLqRkRr08D+4BcthYXO85jZHRSLi6Jv8cyWoBwL
         k3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9G0qMC/ABjMPqiy9S5JGEdHQ+CYHKXaMUSMSPV9fg4c=;
        b=WrdHeqsaNt/skb/sWSALtNp0ViBwBnL5Rzi/WUiz/iMKM9JQW8vGOc7FH8ff7a3udt
         JnIIBAzO6530JpKyYtq4FVFwFp5dS7/pSVuoTGnlLayZL/AP+pcvdUON3bCL9QSE4M2J
         gTkXOVfg3id1JEpKoX5Us+Q85nxyHVUTAVW0z6vgJ9kVT9sA5dt/3+cuRCkhPcd4TIFx
         j+cPtlxA7g06UlnRGPFQm8CW6f9aUuZ0NzmVE8wimeg+6UcggufnSqDbNR2CYVY42wo9
         U7u3hq4/snMbqfIl6yzB6D+XIsYfcYIplXcjkXRivCEp3q6dZZbrT1pZrjIFa3GUYvya
         DsgA==
X-Gm-Message-State: ACrzQf2K+Hu39d6iKUDB3gTNrNJD2a3lqZL9YqGEegzPuNqLmumn8aLS
        lnAuJPSQf0kDSSC5TzxYYQjdbk1J6FDdEP5uq6U=
X-Google-Smtp-Source: AMsMyM4Xn3qa2rjdI2cdhotAZrt1QPiayp2f5V2dlOyEF930R9pM8xzuBKqYSHhdRxUToCOY55Ybn43+jZy6TLYOjeI=
X-Received: by 2002:a05:6870:9614:b0:11d:3906:18fc with SMTP id
 d20-20020a056870961400b0011d390618fcmr242234oaq.190.1664898965475; Tue, 04
 Oct 2022 08:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2a1c3861-c752-4f40-59d3-803a62cd1bc2@dunelm.org.uk> <CAN84kKnDvvG5V=eCnTPiNVC+CfWu9NFqwF+L4QuX26TAPov2Zg@mail.gmail.com>
In-Reply-To: <CAN84kKnDvvG5V=eCnTPiNVC+CfWu9NFqwF+L4QuX26TAPov2Zg@mail.gmail.com>
From:   Chris P <christophe.poucet@gmail.com>
Date:   Tue, 4 Oct 2022 17:55:54 +0200
Message-ID: <CAN84kKmx8fMppFdFG98VyKfK_vpb5nbXLXGUbJWupyVTNqak3A@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add the Git Change command
To:     phillip.wood@dunelm.org.uk, Christophe Poucet <poucet@google.com>
Cc:     Christophe Poucet via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I got the tests to work, except the last one, that one fails.

How can I see the output of actual and expect?

On Tue, Oct 4, 2022 at 5:19 PM Chris P <christophe.poucet@gmail.com> wrote:
>
> Thanks a lot.
>
> Is there something special I must do to get these scripts to work? The
> entire script fails for me, despite having build git-change.
>
> On Tue, Oct 4, 2022 at 4:24 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > Hi Chris
> >
> > On 23/09/2022 19:55, Christophe Poucet via GitGitGadget wrote:
> > > I'm reviving the original git evolve work that was started by
> > > sxenos@google.com
> > > (https://public-inbox.org/git/20190215043105.163688-1-sxenos@google.com/)
> > >
> > > This work is intended to make it easier to deal with stacked changes.
> > >
> > > The following set of patches introduces the design doc on the evolve command
> > > as well as the basics of the git change command.
> >
> > Our test suite can be a little tricky to get started with and I was impatient to
> > check the basic functionality of these patches so I've written some simple
> > example tests for the change command and a couple of fixups to make them pass.
> >
> > Best Wishes
> >
> > Phillip
> >
> > ---- >8 ----
> >
> >  From a7c38d0f388e4d8a1f3debcc3069a7fb43084eda Mon Sep 17 00:00:00 2001
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Date: Tue, 4 Oct 2022 15:12:36 +0100
> > Subject: [PATCH 1/3] fixup! evolve: add support for writing metacommits
> >
> > ---
> >   metacommit.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/metacommit.c b/metacommit.c
> > index d2b859a4d3..8f970fa104 100644
> > --- a/metacommit.c
> > +++ b/metacommit.c
> > @@ -296,7 +296,7 @@ int record_metacommit_withresult(
> >          if (override_change) {
> >                  string_list_clear(changes, 0);
> >                  overridden_head = get_change_head(chtable, override_change);
> > -               if (!overridden_head) {
> > +               if (overridden_head) {
> >                          /* This is an existing change */
> >                          old_head = &overridden_head->head;
> >                          if (!force) {
> > --
> > 2.37.3.947.g1b8ba4da7f.dirty
> >
> >
> >  From cc7e8ba0b1a90268ced85d3f0c91aed49f2246d6 Mon Sep 17 00:00:00 2001
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Date: Tue, 4 Oct 2022 15:15:32 +0100
> > Subject: [PATCH 2/3] fixup! evolve: implement the git change command
> >
> > ---
> >   t/t9999-changes.sh | 126 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 126 insertions(+)
> >   create mode 100755 t/t9999-changes.sh
> >
> > diff --git a/t/t9999-changes.sh b/t/t9999-changes.sh
> > new file mode 100755
> > index 0000000000..9e58925b23
> > --- /dev/null
> > +++ b/t/t9999-changes.sh
> > @@ -0,0 +1,126 @@
> > +#!/bin/sh
> > +
> > +test_description='git change - low level meta-commit management'
> > +
> > +. ./test-lib.sh
> > +
> > +. "$TEST_DIRECTORY"/lib-rebase.sh
> > +
> > +test_expect_success 'setup commits and meta-commits' '
> > +       for c in one two three
> > +       do
> > +               test_commit $c &&
> > +               git change update --content $c >actual 2>err &&
> > +               echo "Created change metas/$c" >expect &&
> > +               test_cmp expect actual &&
> > +               test_must_be_empty err &&
> > +               test_cmp_rev refs/metas/$c $c || return 1
> > +       done
> > +'
> > +
> > +# Check a meta-commit has the correct parents Call with the object
> > +# name of the meta-commit followed by pairs of type and parent
> > +check_meta_commit () {
> > +       name=$1
> > +       shift
> > +       while test $# -gt 0
> > +       do
> > +               printf '%s %s\n' $1 $(git rev-parse --verify $2)
> > +               shift
> > +               shift
> > +       done | sort >expect
> > +       git cat-file commit $name >metacommit &&
> > +       # commit body should consist of parent-type
> > +           types="$(sed -n '/^$/ {
> > +                       :loop
> > +                       n
> > +                       s/^parent-type //
> > +                       p
> > +                       b loop
> > +                   }' metacommit)" &&
> > +       while read key value
> > +       do
> > +               # TODO: don't sort the first parent
> > +               if test "$key" = "parent"
> > +               then
> > +                       type="${types%% *}"
> > +                       test -n "$type" || return 1
> > +                       printf '%s %s\n' $type $value
> > +                       types="${types#?}"
> > +                       types="${types# }"
> > +               elif test "$key" = "tree"
> > +               then
> > +                       test_cmp_rev "$value" $EMPTY_TREE || return 1
> > +               elif test -z "$key"
> > +               then
> > +                       # only parse commit headers
> > +                       break
> > +               fi
> > +       done <metacommit >actual-unsorted &&
> > +       test -z "$types" &&
> > +       sort >actual <actual-unsorted &&
> > +       test_cmp expect actual
> > +}
> > +
> > +test_expect_success 'update meta-commits after rebase' '
> > +       (
> > +               set_fake_editor &&
> > +               FAKE_AMEND=edited &&
> > +               FAKE_LINES="reword 1 pick 2 fixup 3" &&
> > +               export FAKE_AMEND FAKE_LINES &&
> > +               git rebase -i --root
> > +       ) &&
> > +
> > +       # update meta-commits
> > +       git change update --replace tags/one --content HEAD~1 >out 2>err &&
> > +       echo "Updated change metas/one" >expect &&
> > +       test_cmp expect out &&
> > +       test_must_be_empty err &&
> > +       git change update --replace tags/two --content HEAD@{2} &&
> > +       oid=$(git rev-parse --verify metas/two) &&
> > +       git change update --replace HEAD@{2} --replace tags/three \
> > +               --content HEAD &&
> > +
> > +       # check meta-commits
> > +       check_meta_commit metas/one c HEAD~1 r tags/one &&
> > +       check_meta_commit $oid c HEAD@{2} r tags/two &&
> > +       # NB this checks that "git change update" uses the meta-commit ($oid)
> > +       #    corresponding to the replaces commit (HEAD@2 above) given on the
> > +       #    commandline.
> > +       check_meta_commit metas/two c HEAD r $oid r tags/three &&
> > +       check_meta_commit metas/three c HEAD r $oid r tags/three
> > +'
> > +
> > +reset_meta_commits () {
> > +    for c in one two three
> > +    do
> > +       echo "update refs/metas/$c refs/tags/$c^0"
> > +    done | git update-ref --stdin
> > +}
> > +
> > +test_expect_success 'override change name' '
> > +       # TODO: builtin/change.c expects --change to be the full refname,
> > +       #       ideally it would prepend refs/metas to the string given by the
> > +       #       user.
> > +       git change update --change refs/metas/another-one --content one &&
> > +       test_cmp_rev metas/another-one one
> > +'
> > +
> > +test_expect_success 'non-fast forward meta-commit update refused' '
> > +       test_must_fail git change update --change refs/metas/one --content two \
> > +               >out 2>err &&
> > +       echo "error: non-fast-forward update to ${SQ}refs/metas/one${SQ}" \
> > +               >expect &&
> > +       test_cmp expect err &&
> > +       test_must_be_empty out
> > +'
> > +
> > +test_expect_success 'forced non-fast forward update succeeds' '
> > +       git change update --change refs/metas/one --content two --force \
> > +               >out 2>err &&
> > +       echo "Updated change metas/one" >expect &&
> > +       test_cmp expect out &&
> > +       test_must_be_empty err
> > +'
> > +
> > +test_done
> > --
> > 2.37.3.947.g1b8ba4da7f.dirty
> >
> >
> >  From 7784f253fa799dd11fcbc81fe815fb387af52d97 Mon Sep 17 00:00:00 2001
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Date: Tue, 4 Oct 2022 15:16:05 +0100
> > Subject: [PATCH 3/3] fixup! evolve: add the git change list command
> >
> > ---
> >   builtin/change.c   | 16 +++++-----------
> >   t/t9999-changes.sh | 11 +++++++++++
> >   2 files changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/builtin/change.c b/builtin/change.c
> > index 07d029d82d..888ef648fa 100644
> > --- a/builtin/change.c
> > +++ b/builtin/change.c
> > @@ -34,9 +34,8 @@ static int change_list(int argc, const char **argv, const char* prefix)
> >                  OPT_END()
> >          };
> >          struct ref_filter filter;
> > -       /* TODO: See below
> >          struct ref_sorting *sorting;
> > -       struct string_list sorting_options = STRING_LIST_INIT_DUP; */
> > +       struct string_list sorting_options = STRING_LIST_INIT_DUP;
> >          struct ref_format format = REF_FORMAT_INIT;
> >          struct ref_array array;
> >          int i;
> > @@ -53,19 +52,15 @@ static int change_list(int argc, const char **argv, const char* prefix)
> >
> >          filter_refs(&array, &filter, FILTER_REFS_CHANGES);
> >
> > -       /* TODO: This causes a crash. It sets one of the atom_value handlers to
> > -        * something invalid, which causes a crash later when we call
> > -        * show_ref_array_item. Figure out why this happens and put back the sorting.
> > -        *
> > -        * sorting = ref_sorting_options(&sorting_options);
> > -        * ref_array_sort(sorting, &array); */
> > -
> >          if (!format.format)
> >                  format.format = "%(refname:lstrip=1)";
> >
> >          if (verify_ref_format(&format))
> >                  die(_("unable to parse format string"));
> >
> > +       sorting = ref_sorting_options(&sorting_options);
> > +       ref_array_sort(sorting, &array);
> > +
> >          for (i = 0; i < array.nr; i++) {
> >                  struct strbuf output = STRBUF_INIT;
> >                  struct strbuf err = STRBUF_INIT;
> > @@ -79,8 +74,7 @@ static int change_list(int argc, const char **argv, const char* prefix)
> >          }
> >
> >          ref_array_clear(&array);
> > -       /* TODO: see above
> > -       ref_sorting_release(sorting); */
> > +       ref_sorting_release(sorting);
> >
> >          return 0;
> >   }
> > diff --git a/t/t9999-changes.sh b/t/t9999-changes.sh
> > index 9e58925b23..9312eba86d 100755
> > --- a/t/t9999-changes.sh
> > +++ b/t/t9999-changes.sh
> > @@ -123,4 +123,15 @@ test_expect_success 'forced non-fast forward update succeeds' '
> >          test_must_be_empty err
> >   '
> >
> > +test_expect_success 'list changes' '
> > +       cat >expect <<-\EOF &&
> > +       metas/another-one
> > +       metas/one
> > +       metas/three
> > +       metas/two
> > +       EOF
> > +       git change list >actual &&
> > +       test_cmp expect actual
> > +'
> > +
> >   test_done
> > --
> > 2.37.3.947.g1b8ba4da7f.dirty
