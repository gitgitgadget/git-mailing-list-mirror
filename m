Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C9C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5193223359
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbhANIQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbhANIQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 03:16:37 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA3C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:15:57 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j12so4472906ota.7
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qboZ1RJHgwms9wY6OIGD/5dZkqbUPs1pjzWY4TQ3w9g=;
        b=CcvgzWhk0jd+49JEQLfk4xwbva8OkPlbSG6K0KVcAD1HGsdqedQISzqsydVXcHHKU8
         4XIjYG9RXbdDtAwXTWTGgLA4lOzgdpSPMte+OX/cJRsUD/sHR7rskPvonT8t7B9Aaiml
         X5/NxMAdlwHDcd/ibc/OnDfMS6Wes7RBl/1n0rvlJ1/6ZCApH5elj1+uncOiFHzLjW3D
         5mOJTkFBQtJveBss3VigRJptNJQQ10Vp4EnGcatLXQMSUzMxJpRgAf6QBQvQvsIvUywf
         epsQvu2UhCrBQSYiRzM4ApMCGnIzfZLr+hDIWE1d0EqPb1orbjgFybKQNvRwp27qokCe
         4fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qboZ1RJHgwms9wY6OIGD/5dZkqbUPs1pjzWY4TQ3w9g=;
        b=tOo4LnWUIWGUkbtWKwhdMSIe+LystAoE8FhlxrJjn1xCROjhmN6T92EB+Dz21ifAPO
         MJ9o6fNkr9IAG6+Z/OGiB0151WdyGpPITH3GdI0KnsRvw5FdEsvQAYmvV1OqtOpYWtHY
         5lmy66eOFqcjifegSRclReb7JLg7e9uy2xk4gQxmAlxirHzJFGtcIFti/WfCi6y/Bo82
         Cx4XFrLWhKPoHNXXaUn2j/fn+ZVBWoVYCq5JayNlDYLIFoEeFF1ESU7lG1tLldb7CC2n
         cDMEMfACMtGYPuBPWCfY2DI/RO3SgMb8MammTYrFY63q1YpQS2N8VLwXJYgGsRAJQYry
         U7Ig==
X-Gm-Message-State: AOAM531XxiVsCiClJ31GS7eydW1vhvHMAT5cwd5jxoZ2QxGM1dZFO4Y1
        kR7j67ytHDX3FH6SnuVBwoRRZFxA7+oI3NOMk1yqkb2Hsb7wT8+i
X-Google-Smtp-Source: ABdhPJy+q7eEU606R2+Z7Za5TKp9fwp/2cB0dKTSOw3ttUSiy2VLZNmregfV9FINE5cZxC5B+sSJFLOFxB1Ogseth2Q=
X-Received: by 2002:a9d:816:: with SMTP id 22mr3881345oty.164.1610612157245;
 Thu, 14 Jan 2021 00:15:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
 <pull.832.v2.git.1610116600.gitgitgadget@gmail.com> <a09a5098aa66ea0ed89fe0fcde3f016b4a65814d.1610116600.git.gitgitgadget@gmail.com>
 <CAPig+cT+1XZbg3Nv15Hfsmc0qLTku0iMvp0dOjuebv_55D1OSQ@mail.gmail.com>
In-Reply-To: <CAPig+cT+1XZbg3Nv15Hfsmc0qLTku0iMvp0dOjuebv_55D1OSQ@mail.gmail.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Thu, 14 Jan 2021 16:17:21 +0800
Message-ID: <CAOLTT8SPMA5hNF2GrbjWzQusjq1tCz1SC2842ApcYAVE9tYHew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] builtin:ls-files.c:add git ls-file --dedup option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can see that the coding and documentation of GIT community are really v=
ery
standard, which may be one of the things I lack and need to improve ;)
Thanks for patiently correct my errors.

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:39=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Fri, Jan 8, 2021 at 9:36 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > builtin:ls-files.c:add git ls-file --dedup option
>
> This subject concisely explains the purpose of the patch. That's good.
> A more typical way to write it would be:
>
>     ls-files: add --dedup option
>
OK.I will correct it more specification.
> > This commit standardizes the code format.
>
> Fixing problems pointed out by reviewers is good. Normally, however,
> when you submit a new version of your patch or patch series, you
> should apply these fixes directly to the patch(es) which introduced
> the problems in the first place rather than adding one or more
> additional patches to fix problems introduced in earlier patches. To
> do this, you typically would use `git rebase -i` or `git commit
> --amend` to squash the fixes into the problematic patches. Thus, when
> you re-submit the patches, they will appear to be "perfect".
>
> For this particular two-patch series, patch [2/2] is doing two things:
> (1) fixing style problems from patch [1/2], and (2) adding
> documentation and tests which logically belong with the feature added
> by patch [1/2]. Taking the above advice into account, a better
> presentation when you re-submit this series would be to squash these
> two patches into a single patch.
>
I thought before this was gitgitgadget would sent duplicate patch
over and over again. It seems like I really should go straight ahead
and squash my commits , so I know what I should do.
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> > @@ -81,6 +82,9 @@ OPTIONS
> > +--dedup::
> > +       Suppress duplicates entries when conflicts happen or
> > +       specify -d -m at the same time.
>
> For consistency with typesetting elsewhere in this file, use backticks
> around the command-line options. It also often is a good idea to spell
> the options using long form since it is typically easier to search for
> the long form of an option in documentation. So, perhaps the above can
> be written like this:
>
>     Suppress duplicate entries when `--deleted` and `--modified` are
>     combined.
>
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > -       const struct cache_entry *last_stage=3DNULL;
> > +       const struct cache_entry *last_stage =3D NULL;
> > -                       if(show_cached && delete_dup){
> > +                       if (show_cached && delete_dup) {
> > -                                       last_stage=3Dce;
> > +                                       last_stage =3D ce;
> > -                       if(delete_dup){
> > +                       if (delete_dup) {
> > -                       if(delete_dup && show_deleted && show_modified =
&& err)
> > +                       if (delete_dup && show_deleted && show_modified=
 && err)
> > -                       else{
> > -                               if (show_deleted && err)/* you can't fi=
nd it,so it's actually removed at all! */
> > +                       else {
> > +                               if (show_deleted && err)
>
> As mentioned above, these style fixes should be squashed into the
> first patch, rather than being done in a separate patch, so that
> reviewers see a nicely polished patch rather than a patch which
> requires later fixing up.
>
> > diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
> > @@ -0,0 +1,63 @@
> > +test_expect_success 'master branch setup and write expect1 expect2 and=
 commit' '
>
> We usually give this test a simple title such as "setup" so that we
> don't have to worry about the title becoming outdated as people make
> changes to the test itself.
>
> > +       touch a.txt &&
> > +       touch b.txt &&
> > +       touch delete.txt &&
>
> On this project, we use `touch` when the timestamp of the empty files
> is important to the test. If the timestamp is not important, then we
> just use `>`, like this:
>
>     >a.txt &&
>     >b.txt &&
>     >delete.txt &&
>
OK,maybe because I always use touch to generate files.
> > +       cat <<-EOF >expect1 &&
> > +       M a.txt
> > +       H b.txt
> > +       H delete.txt
> > +       H expect1
> > +       H expect2
> > +       EOF
> > +       cat <<-EOF >expect2 &&
> > +       C a.txt
> > +       R delete.txt
> > +       EOF
>
> When no variables are being interpolated in the here-doc content, we
> use -\EOF to let readers know that the here-doc body is literal. So:
>
>     cat >expect1 <<-\EOF &&
>     ...
>     EOF
>
> > +       git add a.txt b.txt delete.txt expect1 expect2 &&
> > +       git commit -m master:1
> > +'
> > +
> > +test_expect_success 'main commit again' '
> > +       echo a>a.txt &&
> > +       echo b>b.txt &&
> > +       echo delete>delete.txt &&
> > +       git add a.txt b.txt delete.txt &&
> > +       git commit -m master:2
> > +'
> > +
> > +test_expect_success 'dev commit' '
> > +       git checkout HEAD~ &&
> > +       git switch -c dev &&
> > +       echo change>a.txt &&
> > +       git add a.txt &&
> > +       git commit -m dev:1
> > +'
>
> These two tests following the "setup" test also seem to be doing setup
> tasks rather than testing the new --dedup functionality. If this is
> the case, then it probably would make sense to combine all three tests
> into a single "setup" test.
>
> > +test_expect_success 'dev merge master' '
> > +       test_must_fail git merge master &&
> > +       git ls-files -t --dedup >actual1 &&
> > +       test_cmp expect1 actual1 &&
> > +       rm delete.txt &&
> > +       git ls-files -d -m -t --dedup >actual2 &&
> > +       test_cmp expect2 actual2
> > +'
>
> Do you foresee that people will add more tests to this file which will
> use the files and branches set up by the "setup" test(s)? If not, if
> those branches and files are only ever going to be used by this one
> test, then it probably would be better to combine all the above code
> into a single test.
No,the test file may just need only one.
