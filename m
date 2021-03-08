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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4133BC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075F465189
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhCHUwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhCHUwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:52:22 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4B9C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:52:22 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id v12so10588485ott.10
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Anzx1DvqxU+BUgFDomQG4GlQzzQf4RE/TqJyLCBX844=;
        b=RudFwfe3Q3T9l++/SvjnvUrgCNpeHoewOntf9QQsLTox94bk7ncCobhcF09xeIr5lk
         +3zJM/o+HvD8hMRUWNuQDtVeF3ialE06ppeiPdE5+tL0yby9V1KYJp1mYeF5XRJMtvQp
         pcvs8wkboD1Ihi3d+hQ2tVAHSGfA8k9zQXBhd5fK5UzqVWziQzzrxXng9Smm2j93WspT
         nyRknVkSPyPZcFRzmUvmI17IoahtrWRhcdf6S8l5DfWfwYT2cZoLnoXG2RfAX0juJTpH
         5PlC/PLh2ZnHmgzYsOvz13W7o0yUoZoZpC6ugZb7faI5FIeF9GbvSoqRoczwITH3dppe
         bgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Anzx1DvqxU+BUgFDomQG4GlQzzQf4RE/TqJyLCBX844=;
        b=mg4xp3slh5X+fuBeVGOzZ/tc0Q3NDujhd4cxzyy5w6AqcY4cbLG1d0sPJqN+ydh4Bl
         w0uO196JuuDtz/V26swMpyeV8HqrJRnCV8qhyWKYsZ9p6X6hmnqvfRy6mQOLnh8c75M7
         BKSMd+BFMcrKiVaYumbcdVcKWfpjM6SOvPjcUjUjqwicfmAas5sRgMl0L2/8S68W2eEj
         mUSo6UqyzNhve+D3mrsgp7WhpEJ7l8lNiIJVTCKZPvaxdENWALItf/JxcGc9eN69yKKr
         YQnXa4U2A+FlyZvlRT3zG/hY+Fay1lYZT58xLfwArglwZRgo7AjSr1j4rWbUhordC5oO
         Bc4w==
X-Gm-Message-State: AOAM533bvfqfolCj8SNgMtC8s48BbzbWZsU9khFiTVjQeXQkVntSjE/S
        iyRME6vuECCFedSRspVeaQoInVlaUiVJDOwMRHQ=
X-Google-Smtp-Source: ABdhPJyZk4im3AR4cpm0w0/R9qhGIOsAyGS83hvGt0kE5RmLO2WFMSBH05G0T/6oJX4Acwg68VluTHxztZOdXMDxahg=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr2637459otf.162.1615236741725;
 Mon, 08 Mar 2021 12:52:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <6ccb24b557fc9c9d8e3d307d3e142d8393920414.1614905738.git.gitgitgadget@gmail.com>
 <874khlkdb0.fsf@evledraar.gmail.com>
In-Reply-To: <874khlkdb0.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Mar 2021 12:52:10 -0800
Message-ID: <CABPp-BEZpq7yX0vOamXhDa3M6696YqrD_-UZE2GfFFJrORDdMQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] t6428: new test for SKIP_WORKTREE handling and conflicts
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 5:03 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > If there is a conflict during a merge for a SKIP_WORKTREE entry, we
> > expect that file to be written to the working copy and have the
> > SKIP_WORKTREE bit cleared in the index.  If the user had manually
> > created a file in the working tree despite SKIP_WORKTREE being set, we
> > do not want to clobber their changes to that file, but want to move it
> > out of the way.  Add tests that check for these behaviors.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  t/t6428-merge-conflicts-sparse.sh | 158 ++++++++++++++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> >  create mode 100755 t/t6428-merge-conflicts-sparse.sh
> >
> > diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflict=
s-sparse.sh
> > new file mode 100755
> > index 000000000000..1bb52ff6f38c
> > --- /dev/null
> > +++ b/t/t6428-merge-conflicts-sparse.sh
> > @@ -0,0 +1,158 @@
> > +#!/bin/sh
> > +
> > +test_description=3D"merge cases"
> > +
> > +# The setup for all of them, pictorially, is:
> > +#
> > +#      A
> > +#      o
> > +#     / \
> > +#  O o   ?
> > +#     \ /
> > +#      o
> > +#      B
> > +#
> > +# To help make it easier to follow the flow of tests, they have been
> > +# divided into sections and each test will start with a quick explanat=
ion
> > +# of what commits O, A, and B contain.
> > +#
> > +# Notation:
> > +#    z/{b,c}   means  files z/b and z/c both exist
> > +#    x/d_1     means  file x/d exists with content d1.  (Purpose of th=
e
> > +#                     underscore notation is to differentiate differen=
t
> > +#                     files that might be renamed into each other's pa=
ths.)
> > +
> > +. ./test-lib.sh
> > +. "$TEST_DIRECTORY"/lib-merge.sh
> > +
> > +
> > +# Testcase basic, conflicting changes in 'numerals'
> > +
> > +test_setup_numerals () {
> > +     test_create_repo numerals_$1 &&
> > +     (
> > +             cd numerals_$1 &&
> > +
> > +             >README &&
> > +             test_write_lines I II III >numerals &&
> > +             git add README numerals &&
> > +             test_tick &&
> > +             git commit -m "O" &&
>
> As an aside this could use the --printf option to test_commit I've got
> in next, but that's also a bit painful to use since you can't use
> test_write_lines.
>
> I've wanted to just support something like this for this use-case of
> using an existing file:
>
>     test_write_lines A B C D >lines &&
>     test_commit --add O lines &&
>
>
> > +
> > +             git branch O &&
> > +             git branch A &&
> > +             git branch B &&
> > +
> > +             git checkout A &&
> > +             test_write_lines I II III IIII >numerals &&
> > +             git add numerals &&
> > +             test_tick &&
> > +             git commit -m "A" &&
> > +
> > +             git checkout B &&
> > +             test_write_lines I II III IV >numerals &&
> > +             git add numerals &&
> > +             test_tick &&
> > +             git commit -m "B" &&
> > +
> > +             cat <<-EOF >expected-index &&
> > +             H README
> > +             M numerals
> > +             M numerals
> > +             M numerals
> > +             EOF
> > +
> > +             cat <<-EOF >expected-merge
> > +             I
> > +             II
> > +             III
> > +             <<<<<<< HEAD
> > +             IIII
> > +             =3D=3D=3D=3D=3D=3D=3D
> > +             IV
> > +             >>>>>>> B^0
> > +             EOF
> > +
> > +     )
> > +}
> > +
> > +test_expect_merge_algorithm success failure 'conflicting entries writt=
en to worktree even if sparse' '
> > +     test_setup_numerals plain &&
>
> A small nit, but makes it easier to debug things: I think having what
> you have in "test_setup_numerals" above in a test_expect_success is a
> better pattern, then if it fails we can see where exactly.
>
> Then instead of calling "test_setup_numerals" here you'd do:
>
>     cp -R template plain &&
>
> To just copy over that existing setup template, or re-use it and have
> have the tests call a small helper to "test_when_finish" reset --hard
> back as appropriate.

I used to have tests follow that pattern, but Dscho objected
strenuously to it; see e.g.
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbj=
f.bet/

I went through and replaced most of the merge-recursive-related ones
to the current style to help him out.
