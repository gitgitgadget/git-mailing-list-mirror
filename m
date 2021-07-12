Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548D6C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8EF60FEA
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhGLNwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhGLNwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:52:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EAAC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:49:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b1so22751651ioz.8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I7EcBp6eNL03smqTbYeoMvg3UP2sM3NAtbYKXpnPzQ8=;
        b=CVWOTQ/qpUbMamUEbKw1usXBi2ZVsb/VWAd/pHLTSMcT/WRwVaZWRrfoWi82qMMerX
         jp31Vh0OfcIbGRVWCvCmRaJcAxki9T0mV9wlKuTtVvvjiyPJcN47qcPU6JJEoSF98lY7
         RrQYB+Kn273UgIfnpi91OczCVbWEZPh/QmGeq4ijtpUQVofpU7rIS7+FCiiVo9gHWlmE
         +3FZ3QbVjgcKGH2isei0x/b2pmvSdlOSoX8mFD6+gBBUr8vjDGyGi+PBpix6ifTHPM5i
         PTYBOZjkS08/4g46e8L9Oykz0OFoLW3izrnWe21gnvh2LSCdco4fjf6CYok1ReVfh9N6
         PpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I7EcBp6eNL03smqTbYeoMvg3UP2sM3NAtbYKXpnPzQ8=;
        b=Hiv1SDKVOgBO7coh8th5jRcg3HRDW/Kvauxr8ORJp++3w+xXqZcwr/sfClyPhA/K/8
         O8jGfa6AQ8/nwpHhIi3sx5zPSbGRqXMKX/cDKwiRVKArS8O6hsDz3Vv4zBf6av7T8AAH
         OaFQ/bds7z6NAft37a4Qfgv6/ZFivw8gnpgBNPoEGs6njCExOSblrqJi68gPlyGxCYs9
         rUHJX/Re2pnEoLw2SL6ioQwelWycypKxWj/yAuaqfyGyFbjSuN1OqEffodZUTuNaO5dM
         fcguHEByN3JV/Z8fWqn965XqpuGVvnq2xy2Ee9D8HzOlQTNu23baHxJfcm9ya2aKKvl3
         sTbg==
X-Gm-Message-State: AOAM532xz18pCKLT8SJ4ndbi8pX0fBUtBmn2uTarEvE4tzQE0mXKSC/m
        a4hgngEY5B7LJ82dhogtRt4t4aLY6lX4glQa0Gc=
X-Google-Smtp-Source: ABdhPJyT+criAnaDhzHYZwSBXofq3f4zWu8fs8ttNWQ3n2Qc8Xkt1gk8IARvSIatB6dqj2jwSH7EB0o4tTM2TphKSUA=
X-Received: by 2002:a6b:f81a:: with SMTP id o26mr40756631ioh.68.1626097772638;
 Mon, 12 Jul 2021 06:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
 <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
 <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
In-Reply-To: <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 12 Jul 2021 21:49:41 +0800
Message-ID: <CAOLTT8SKp2Zfd+R31+vJbW_QJG5vJArB2yPn-O_34y1ezaDBcw@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:17=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Jul 12, 2021 at 1:47 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In order to let cat-file use ref-filter logic, let's do the
> > following:
> >
> > 1. Change the type of member `format` in struct `batch_options`
> > to `ref_format`, we will pass it to ref-filter later.
> > 2. Let `batch_objects()` add atoms to format, and use
> > `verify_ref_format()` to check atoms.
> > 3. Use `format_ref_array_item()` in `batch_object_write()` to
> > get the formatted data corresponding to the object. If the
> > return value of `format_ref_array_item()` is equals to zero,
> > use `batch_write()` to print object data; else if the return
> > value is less than zero, use `die()` to print the error message
> > and exit; else if return value is greater than zero, only print
> > the error message, but don't exit.
> > 4. Use free_ref_array_item_value() to free ref_array_item's
> > value.
> >
> > Most of the atoms in `for-each-ref --format` are now supported,
> > such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
> > `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
> > `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
> > `%(flag)`, `%(HEAD)`, because these atoms are unique to those objects
> > that pointed to by a ref, "for-each-ref"'s family can naturally use
> > these atoms, but not all objects are pointed to be a ref, so "cat-file"
> > will not be able to use them.
> >
> > The performance for `git cat-file --batch-all-objects
> > --batch-check` on the Git repository itself with performance
> > testing tool `hyperfine` changes from 669.4 ms =C2=B1  31.1 ms to
> > 1.134 s =C2=B1  0.063 s.
> >
> > The performance for `git cat-file --batch-all-objects --batch
> > >/dev/null` on the Git repository itself with performance testing
> > tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
> > total" to "33.69s user 1.54s system 87% cpu 40.258 total".
>
> Saying that a later patch will add a fast path which will mitigate the
> performance regression introduced by this patch might help reassure
> reviewers.
>

OK.

> By the way it is not clear if adding the fast path fully mitigates
> this performance regression or not. You might want to discuss that in
> the cover letter, or maybe in the patch adding the fast path.
>

I mentioned it: "By using this fast path, we can reduce some of the
extra overhead
when cat-file --batch using ref-filter. The running time of
git cat-file --batch-check will be similar to before, and the
running time of git cat-file --batch will be 9.1% less than before."
which is using the result of t/perf/p1006-cat-file.sh.

>
> I wonder if the above function and some of the tests below could be
> introduced in a preparatory patch before this one. It could help check
> that reusing ref-filter doesn't change the behavior with some atoms
> that were previously supported or rejected. Of course if some atoms
> are now failing or are now supported, then it's ok to add new tests
> for these atoms in this patch.
>

Yes, it might be worth splitting into two commits.

> > +batch_test_atom refs/heads/main '%(refname)' fail
> > +batch_test_atom refs/heads/main '%(refname:)' fail
>
> [...]
>
> > +batch_test_atom refs/heads/main 'VALID'
> > +batch_test_atom refs/heads/main '%(INVALID)' fail
> > +batch_test_atom refs/heads/main '%(authordate:INVALID)' fail
> > +
> > +test_expect_success '%(rest) works with both a branch and a tag' '
> > +       cat >expected <<-EOF &&
> > +       123 commit 123
> > +       456 tag 456
> > +       EOF
> > +       git cat-file --batch-check=3D"%(rest) %(objecttype) %(rest)" >a=
ctual <<-EOF &&
> > +       refs/heads/main 123
> > +       refs/tags/testtag 456
> > +       EOF
> > +       test_cmp expected actual
> > +'
>
> It's a bit strange that this test is added in this patch while the
> commit message doesn't talk about %(rest). So I wonder if this new
> test could move to another previous commit.
>

It's just used for checking the uncommonly atoms "%(rest)".
But as you said, we can move it to a split commit.

> > +batch_test_atom refs/heads/main '%(objectname) %(objecttype) %(objects=
ize)
> > +%(raw)'
> > +batch_test_atom refs/tags/testtag '%(objectname) %(objecttype) %(objec=
tsize)
> > +%(raw)'
> > +batch_test_atom refs/myblobs/blob1 '%(objectname) %(objecttype) %(obje=
ctsize)
> > +%(raw)'
> > +batch_test_atom refs/myblobs/blob2 '%(objectname) %(objecttype) %(obje=
ctsize)
> > +%(raw)'
> > +
> > +
>
> It looks like there are two empty lines instead of one above.
>
> > +test_expect_success 'cat-file --batch equals to --batch-check with ato=
ms' '
> > +       git cat-file --batch-check=3D"%(objectname) %(objecttype) %(obj=
ectsize)
> > +%(raw)" >expected <<-EOF &&
> > +       refs/heads/main
> > +       refs/tags/testtag
> > +       EOF
> > +       git cat-file --batch >actual <<-EOF &&
> > +       refs/heads/main
> > +       refs/tags/testtag
> > +       EOF
> > +       cmp expected actual
> > +'
>
> I also wonder if the above new test belong to this commit or if it
> could be moved to a previous commit.

It's same.

Thanks.
--
ZheNing Hu
