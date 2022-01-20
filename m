Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C9DC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 02:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358213AbiATCbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 21:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiATCbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 21:31:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E420C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 18:31:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cx27so22421485edb.1
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 18:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qOf66ViNxUJfEvAuwbMWxG3iuRAtnWdZXXiRrN7nwtY=;
        b=L2O3aiy/CgV0rSGWP7v3L61YLSbFrvJJ63I+qPNPUp2J9WQsMqGDVEEfEGka23iGDX
         CC+E+hBY91hX3uOeZYtLeXtNCD9mjFOEMsZCOzRH9Mp/M1ijgC8IzXy7dBolEOdb4Ex7
         I1/e/1o/GMGLiQ58gb0RGLO8YCYDnDoMJaKoyChpqU7tRfEHtikjtFSrkwPyqPJcahO8
         2IxdUWMFSyb/ZqJB4MQTSZaRcPpG0aSDsZhOzuhpIZOUSCF30q/T1X705oEItrkZI/VD
         CGJifmrwDxRnqtNIHsCvxNjaDs34Wr1R6edrjR5QINLj27og/kDR34H0lxp01xlRFdIJ
         FD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qOf66ViNxUJfEvAuwbMWxG3iuRAtnWdZXXiRrN7nwtY=;
        b=T7Gktb1s7oWek0hhe4a78ncsjfeULxJxzd7dUsgV4qtWlKRRQZMDy1cIIqr8M3aaR0
         Wrpm23VnswvWEVZKspHdikE6pCad/11qLSzvkRdSSZEx7IR7uaFUCYR6Zwn9zl5itLEi
         XJgGOI/7KHAALEkpCdaXT0JU8QXcazP5sAhsTWjYCqSOcVkqEYEJgQe2P4Z9TOFWgnDX
         owpsS68c+GSeDTZjOMfHc4Vst/8r2BA8TZ6ivEL4X138B8iok57F+Lp1CU+PNXIpm4a/
         DYkpV2qhbjB/8TEKPer6MTuUF5mtbmoPFhSkQ84crkFufxIDFVDHDYbDNxRsTiXRc7xc
         T1JA==
X-Gm-Message-State: AOAM53301dmasuNIfjNKRExNy/r55IatJPllCBpVfStF9HVAwlzzyyia
        T8URl9lKsagWYGfG0cm29V1j2JzCqO953zWQncwbIXMK
X-Google-Smtp-Source: ABdhPJyHmHlMs9Jr0TLvW8bs+XWEH6t1B+16L4LRPzF51Zjhp3vovTClNgAFuDDW7ru46sYCOXlA50m3+EB7G21nZ+4=
X-Received: by 2002:a05:6402:5212:: with SMTP id s18mr34964485edd.359.1642645902583;
 Wed, 19 Jan 2022 18:31:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com> <d57ae218cf9eaee0b66db299ee1bba9b488b69b1.1640907369.git.gitgitgadget@gmail.com>
 <220119.86pmonn2mb.gmgdl@evledraar.gmail.com>
In-Reply-To: <220119.86pmonn2mb.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Jan 2022 18:31:31 -0800
Message-ID: <CABPp-BGsf8pcEZrY3vuq0yszy9G57fVa5jMSjT3H+sgDe6hWGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] show, log: provide a --remerge-diff capability
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 19, 2022 at 7:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
>
> > +static int do_remerge_diff(struct rev_info *opt,
> > +                        struct commit_list *parents,
> > +                        struct object_id *oid,
> > +                        struct commit *commit)
> > +{
> > +     struct merge_options o;
> > +     struct commit_list *bases;
> > +     struct merge_result res =3D {0};
> > +     struct pretty_print_context ctx =3D {0};
> > +     struct commit *parent1 =3D parents->item;
> > +     struct commit *parent2 =3D parents->next->item;
> > +     struct strbuf parent1_desc =3D STRBUF_INIT;
> > +     struct strbuf parent2_desc =3D STRBUF_INIT;
> > +
> > +     /* Setup merge options */
> > +     init_merge_options(&o, the_repository);
> > +     o.show_rename_progress =3D 0;
> > +
> > +     ctx.abbrev =3D DEFAULT_ABBREV;
> > +     format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
> > +     format_commit_message(parent2, "%h (%s)", &parent2_desc, &ctx);
> > +     o.branch1 =3D parent1_desc.buf;
> > +     o.branch2 =3D parent2_desc.buf;
> > +
> > +     /* Parse the relevant commits and get the merge bases */
> > +     parse_commit_or_die(parent1);
> > +     parse_commit_or_die(parent2);
> > +     bases =3D get_merge_bases(parent1, parent2);
>
> There's existing leaks all over the place here unrelated to this new
> code, so this is no big deal, but I noticed that get_merge_bases() here
> leaks.

Interesting.

> Shouldn't it call free_commit_list() like e.g. diff_get_merge_base()
> which invokes get_merge_bases() does on the return value?

See the comment describing merge_incore_recursive() in merge-ort.h,
particularly this part:

* merge_bases will be consumed (emptied) so make a copy if you need it.

So free_commit_list() seems like it'd lead to a double free or use-after-fr=
ee.

However, looking at merge_ort_internal() it looks like there is a bug
in its consumption of the merge bases (which I copied from
merge_recursive; oops).  It pops the first one off the commit list,
but then merely iterates through the remainder of the list without
popping.  So, if there's only one merge base, it'll consume it and the
code will look leak free (which must have been the cases I was looking
at when I was doing leak testing).  But in recursive cases, it leaks
the second and later ones.

Since the caller still has a pointer referring to the first (already
free'd) commit, I think that if they attempt to use it then it would
probably cause a use-after-free.


So, yes, I think there's a leak, but it's not due to this patch.  It's
one that has been around since...the introduction of merge-recursive
(though it originally computed the merge bases internally rather than
allowing them to be passed in).  So, it's been around for quite a
while.

I'll look into it, and see if I can come up with a fix, but it doesn't
really belong in this series.  I'll submit it separately.

Thanks for the report.

> > +test_description=3D'remerge-diff handling'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup basic merges' '
> > +     test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
> > +     git add numbers &&
> > +     git commit -m base &&
> > +
> > +     git branch feature_a &&
> > +     git branch feature_b &&
> > +     git branch feature_c &&
> > +
> > +     git branch ab_resolution &&
> > +     git branch bc_resolution &&
> > +
> > +     git checkout feature_a &&
> > +     test_write_lines 1 2 three 4 5 6 7 eight 9 >numbers &&
> > +     git commit -a -m change_a &&
> > +
> > +     git checkout feature_b &&
> > +     test_write_lines 1 2 tres 4 5 6 7 8 9 >numbers &&
> > +     git commit -a -m change_b &&
> > +
> > +     git checkout feature_c &&
> > +     test_write_lines 1 2 3 4 5 6 7 8 9 10 >numbers &&
> > +     git commit -a -m change_c &&
> > +
> > +     git checkout bc_resolution &&
> > +     git merge --ff-only feature_b &&
> > +     # no conflict
> > +     git merge feature_c &&
> > +
> > +     git checkout ab_resolution &&
> > +     git merge --ff-only feature_a &&
> > +     # conflicts!
> > +     test_must_fail git merge feature_b &&
> > +     # Resolve conflict...and make another change elsewhere
> > +     test_write_lines 1 2 drei 4 5 6 7 acht 9 >numbers &&
> > +     git add numbers &&
>
> Just a matter of taste, but FWIW some of the custom
> test_write_lines/commit here could nowadays use test_commit with
> --printf: 47c88d16ba6 (test-lib functions: add --printf option to
> test_commit, 2021-05-10)
>
> I don't think it's worth the churn to change it here, just an FYI.

Good to know; thanks for the heads up.

Note, though, and this has nothing to do with your patches, but I'm
not sure I'll ever use this particular feature since I don't much care
for test_commit except in trivial cases.  Others have recommended the
function to me before, but my attempts to use it have cost me far more
time than it has saved due to its quirks not working well with the
merges I have attempted to setup.  Beyond the fact that its
documentation is a lie and the filename defaults to <message>.t, one
also has to memorize the order of three positional arguments and add a
smattering of additional flags (--printf, --append, --no-tag) and add
a bunch of newline directives to get things right.  The function can
be useful and nice on non-merge tests (e.g. when you can pass it just
one positional argument) and I'm happy to use it there, but for
merge-related tests it's a needless time sink where the best you can
hope for after fighting it is getting code that is overall _less_
readable than what you started with.
