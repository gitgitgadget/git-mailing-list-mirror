Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAEAC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 05:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiCVF4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 01:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiCVF4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 01:56:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A90212A86
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 22:55:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so22582977ljr.9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 22:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OoEENMDx8QpqO0i2OSQCL0nVlFs9Qi4TAQd/ULmsmY=;
        b=JrzDJN55+8qsuBr8hBVxerHFRInCJMZwErPdQpKwCXo9KymotksVvVyOW0/zMKhiYQ
         N3SBikl40Lt9jDTHJch3CkraWQb85+Fx9gKATF3gonUW1abETraII1p4e7D5XJv3TjVr
         FCHteKU6kaYu+cAic1tNcHrNH+ZxycJ8EA9KpOIaRYKLftu6x5RjULNpmmEe7LOiupA1
         VCSWVHJEjuqCigsJVyB6cfsJT2TbJHEparJ83evKFsz9eSbtD7dIYoLbv9/OnC2mvjKr
         hSyiHqFp362xNJIpcFXe6BsmOc/+1ZnqH+OdFut64Qyx8Z36E6WVXL9mzFD8+Xz7jwfT
         cAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OoEENMDx8QpqO0i2OSQCL0nVlFs9Qi4TAQd/ULmsmY=;
        b=mLcnI1uCJfYmAg8ALI1HM1B5282FPBYKDUTcu9PxU/Kp47x6jm287y4GmvrixQygXG
         SEuoPfdeN7jMNrPpdp5R8P5D0jod5CL04eW7zjeiywPZNKbI8wGL7sQFmkWeiLtV99B4
         VjObt6ckmZ+jc6zufLO1h4u2k5Prx5fe8+nLGljn2h2FZd95AVMYnQUGncXJth9/1SPD
         ONA02XI4pufp0tseinXsAmXhieB/8jRqMDhK0f2yt1Ee6o6udHckhio15IafkviP2g49
         dNU6Cr3/AYp4AIWpaMgWNeN6/ARrq0JrQK80t3PzcPztYwT4OGVOTu+qAD9drbjAw+Ry
         yoqA==
X-Gm-Message-State: AOAM531PDlVhVK31aRnKwzIKcTgxtQSnZxdWlfFSzYYjyJdeEgrfkP+C
        ceue0XWy5jp45mCoYObIUXs06ACSk5Pqgz51oos=
X-Google-Smtp-Source: ABdhPJyhUuWkoHCG5T57Nz7TuVJcru+gAK/0WpNZygo3QbAblEEUFMWgVQOQO1vdL9kgPZYG6wDagjF5X2ntUdzlWtU=
X-Received: by 2002:a05:651c:241:b0:23e:42c1:2e4 with SMTP id
 x1-20020a05651c024100b0023e42c102e4mr18241901ljn.406.1647928508390; Mon, 21
 Mar 2022 22:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <1937746df47eefecfc343e32eb9bf6c0949fb7b9.1647760561.git.gitgitgadget@gmail.com>
 <xmqqpmmfxigx.fsf@gitster.g>
In-Reply-To: <xmqqpmmfxigx.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 22:54:57 -0700
Message-ID: <CANQDOddc7TPY=BJRPOBMJudFFeEv3j3nUd9+Ewkpg3bwFLPVUA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] core.fsyncmethod: tests for batch mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 11:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Add test cases to exercise batch mode for:
> >  * 'git add'
>
> I was wondering why the obviously safe and good candidate 'git add' is
> not gaining plug/unplug pair in this series.  It is obviously safe,
> unlike 'update-index', that nobody can interact with it, observe its
> intermediate output, and expect anything from it.
>
> I think the stupid reason of the lack of new plug/unplug is because
> we already had them, which is good ;-).
>
> >  * 'git stash'
> >  * 'git update-index'
>
> As I said, I suspect that we'd want to do this safely by adding a
> new option to "update-index" and passing it from "stash" which knows
> that it does not care about the intermediate state.
>
> > These tests ensure that the added data winds up in the object database.
>
> In other words, "git add $path; git rev-parse :$path" (and its
> cousins) would be happy?  Like new object files not left hanging in
> a tentative object store etc. _after_ the commands finish.
>
> Good.
>
> > In this change we introduce a new test helper lib-unique-files.sh. The
> > goal of this library is to create a tree of files that have different
> > oids from any other files that may have been created in the current test
> > repo. This helps us avoid missing validation of an object being added due
> > to it already being in the repo.
>
> More on this below.

To me the idea of putting the 'why' into the commit message and the 'what' into
code comments makes sense, since I'd assume people looking into the history
care about the why, but people making future changes would read the
documentation
in the comments for e.g. lib-unique-files.

>
> > We aren't actually issuing any fsyncs in these tests, since
> > GIT_TEST_FSYNC is 0, but we still exercise all of the tmp_objdir logic
> > in bulk-checkin.
>
> Shouldn't we manually override that, if it matters?
> Not a suggestion but a question.

I manually override it for the performance tests.  I think it's
sensible to manually override
this variable for the small number of tests added in this commit so
that we can exercise
the underlying system calls, so I'll do that.

> > +# Create multiple files with unique contents. Takes the number of
> > +# directories, the number of files in each directory, and the base
> > +# directory.
>
> This is more honest, compared to the claim made in the proposed log
> message, in that the uniqueness guarantee is only among the files
> created by this helper.  If we created other test contents without
> using this helper, that may crash with the ones created here.
>

I've revised this comment to indicate that the files are only unique
within this test run.

> > +# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
> > +#                                     each in my_dir, all with unique
> > +#                                     contents.
> > +
> > +test_create_unique_files() {
>
> Style.  SP on both sides of ().  I.e.
>
>         test_create_unique_files () {
>

Fixed

> > +     test "$#" -ne 3 && BUG "3 param"
> > +
> > +     local dirs=$1
> > +     local files=$2
> > +     local basedir=$3
> > +     local counter=0
> > +     test_tick
> > +     local basedata=$test_tick
>
> I am not sure if consumption and reliance on tick is a wise thing.
> $basedir must be unique across all the other directories in this
> test repository (there is no other $basedir)---can't we key
> uniqueness off of it?

In the performance tests, we create sets of files with the same basedir
but we want the files to have different contents since we don't blow away
the repo between tests.  The current approach still generates uniqueness
if someone simply copy/pastes a test_create_unique_files invocation, rather
than subtly failing to make new objects.

> > +     rm -rf $basedir
>
> Can $basedir have any $IFS character in it?  We should "$quote" it.

Fixed.

>
> > +     for i in $(test_seq $dirs)
> > +     do
> > +             local dir=$basedir/dir$i
> > +
> > +             mkdir -p "$dir"
> > +             for j in $(test_seq $files)
> > +             do
> > +                     counter=$((counter + 1))
> > +                     echo "$basedata.$counter"  >"$dir/file$j.txt"
>
> An extra SP before ">"?
>

Fixed.

> > +             done
> > +     done
> > +}
>
> There is no &&- cascade here, and we expect nothing in this to
> fail.  Is that sensible?
>

I apologize, there's a lot of subtlety about UNIX shell scripting that
I simply do not know.   I put an '&&' chain in, but I might still have it wrong.

> > +test_expect_success 'git add: core.fsyncmethod=batch' "
> > +     test_create_unique_files 2 4 fsync-files &&
> > +     git $BATCH_CONFIGURATION add -- ./fsync-files/ &&
> > +     rm -f fsynced_files &&
> > +     git ls-files --stage fsync-files/ > fsynced_files &&
>
> Style.  No SP between redirection operator and its target.  I.e.
>
>         git ls-files --stage fsync-files/ >fsynced_files &&
>
> Mixture of names-with-dash and name_with_understore looks somewhat
> irritating.
>

Will switch to underscores for both. Also will rename the base dir to be more
distinct from the list of files that we expect to see.

> > +     test_line_count = 8 fsynced_files &&
>
> The magic "8" matches "2 4" we saw earlier for create_unique_files?
>

Will comment to explain the 8.

> > +     awk -- '{print \$2}' fsynced_files | xargs -n1 git cat-file -e
>
> A test helper that takes the name of a file that has "ls-files -s" output
> may prove to be useful.  I dunno.
>
> > diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> > index a11d61206ad..8e2f73cc68f 100755
> > --- a/t/t5300-pack-object.sh
> > +++ b/t/t5300-pack-object.sh
> > @@ -162,23 +162,25 @@ test_expect_success 'pack-objects with bogus arguments' '
> >
> >  check_unpack () {
> >       test_when_finished "rm -rf git2" &&
> > -     git init --bare git2 &&
> > -     git -C git2 unpack-objects -n <"$1".pack &&
> > -     git -C git2 unpack-objects <"$1".pack &&
> > -     (cd .git && find objects -type f -print) |
> > -     while read path
> > -     do
> > -             cmp git2/$path .git/$path || {
> > -                     echo $path differs.
> > -                     return 1
> > -             }
> > -     done
> > +     git $2 init --bare git2 &&
> > +     (
> > +             git $2 -C git2 unpack-objects -n <"$1".pack &&
> > +             git $2 -C git2 unpack-objects <"$1".pack &&
> > +             git $2 -C git2 cat-file --batch-check="%(objectname)"
> > +     ) <obj-list >current &&
> > +     cmp obj-list current
> >  }
>
> I think the change from the old "the existence and the contents of
> the object files must all match" to the new "cat-file should say
> that the objects we expect to exist indeed do" is not a bad thing.
>
> We used to only depend on the contents of the provided packfile but
> now we assume that obj-list file gives us the list of objects.  Is
> that sensible?  I somehow do not think so.  Don't we have the
> corresponding "$1.idx" that we can feed to "git show-index", e.g.
>

I believe that "obj-list" is in some sense more authoritative,
assuming arbitrary
future bugs in the pack implementation.  We make sure that the pack we were
handed isn't missing any objects.  It makes sense to accept obj-list from
the outside so that check_unpack itself doesn't depend on that file name.
But the previous code wouldn't catch a bug where the pack code mistakenly drops
an object.

>         git show-index <"$1.pack" >expect.full &&
>         cut -d" " -f2 >expect <expect.full &&
>         ... your test in "$2", but feeding expect instead of obj-list ...
>         test_cmp expect actual
>
> Also make sure you quote whatever is coming from outside, even if
> you happen to call the helper with tokens that do not need quoting
> in the current code.  It is a good discipline to help readers.
>
> Thanks.

I'll take another pass over the shell code in the morning to make sure
I'm following all the conventions and recommendations.  Apologize
for the set of mistakes. In terms of shell, I am a rookie.

Thanks,
-Neeraj
