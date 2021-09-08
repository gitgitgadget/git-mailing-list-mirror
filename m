Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B5C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1FC61164
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhIHFZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhIHFZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 01:25:39 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4FC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 22:24:32 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso396047ooe.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 22:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fN56CN7ZnCwmkXBd5TKD93LlTR1B71kx2ZcfI6OpBQU=;
        b=jArPVIcaJO7HnUDfUS8iKtvDu1X+mV/X16fHxWTmXTbHZFhwutZL8r9yMt5NAq1ioV
         Xu4YwMDsaTRSW32/L1Z7y9FXIDSS7paM9QFIW0O2+Sw8SQjdC6BKzL+k8+VzMnOSQZtx
         1LvWCNNJm0IoA3KlUyVxolVhsF2hFK4xOR7JHwbhwadeZuttJnIaTKc/V9taiUUc43KJ
         fTNmXy771X81UWhrwWfJOZ05y6RNlloAjoXsEeFPyPCYMbCel+5lfs3vifHALB6CtbHN
         abzIdoddg6YKAwisHo3VX9723XKa6GXvHy1+I0N6IdnJLKb3kEUSDGeKczmz96wooc4t
         eL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fN56CN7ZnCwmkXBd5TKD93LlTR1B71kx2ZcfI6OpBQU=;
        b=edK4/u+VOtZcK1p9ULo9ME6SPPUOAmC7jxfH4q3S8WaT8z/P1PkiVmZ8OxKQT2SsyR
         3adpl3Jh+qrwgeNcbK8C7jaEkQMjGgxCWs4w/58qKbsfKEkjZcqKkELV8MjX2c58VY9K
         ZTjLy+qSB6CM5o+67A/U+MZAiXx5CFHuG5oM25L/gjhvsGN4TdjV4SUW+HnkGlvoWq6C
         JMUPrqyoPBNAMHEVAOgLJA129GrnHu0PInoK8hmE55mGEXM/mMseqiMn0T+damgAh7zI
         lD+cKjttwqXJAHa6AU4WIFsRln3kcnocH128u3B+kKMo16H5e7ObkNKKwsYTYBB88kgq
         FFLA==
X-Gm-Message-State: AOAM530rkp3vC18li8PxCubywYKW3Lpb5lj8B4nivZ8EN3DPMgsZoj8y
        GmbDk+Iy4YDkD0YUrlvAfECzgJ7VvMPrN+AyGmq5psQF
X-Google-Smtp-Source: ABdhPJz2ntCGQmY3jebUURjIWUBeTkc/FcuBnKycNIC9NYCwBWj1uixXNQKxwVXuo0LsZF+v6J9YtZA44utfL+4FFDs=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr1480688ooq.15.1631078671783;
 Tue, 07 Sep 2021 22:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
 <b8a418bc63ab0a4add25724a11eb5f992e3d4472.1631067429.git.gitgitgadget@gmail.com>
 <96e001e5-56d7-7806-19ad-ac41f833b0a7@gmail.com>
In-Reply-To: <96e001e5-56d7-7806-19ad-ac41f833b0a7@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Sep 2021 22:24:20 -0700
Message-ID: <CABPp-BE812VNn9Qq8bWdCMH0bMcaN8JqKJYt=XKC430y1eE=xA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t4151: document a pair of am --abort bugs
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 10:13 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 08/09/21 09.17, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >   t/t4151-am-abort.sh | 31 +++++++++++++++++++++++++++++++
> >   1 file changed, 31 insertions(+)
> >
> > diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> > index 9d8d3c72e7e..501a7a9d211 100755
> > --- a/t/t4151-am-abort.sh
> > +++ b/t/t4151-am-abort.sh
> > @@ -23,7 +23,11 @@ test_expect_success setup '
> >               test_tick &&
> >               git commit -a -m $i || return 1
> >       done &&
> > +     git branch changes &&
> >       git format-patch --no-numbered initial &&
> > +     git checkout -b conflicting initial &&
> > +     echo different >>file-1 &&
> > +     git commit -a -m different &&
> >       git checkout -b side initial &&
> >       echo local change >file-2-expect
> >   '
> > @@ -191,4 +195,31 @@ test_expect_success 'am --abort leaves index stat info alone' '
> >       git diff-files --exit-code --quiet
> >   '
> >
> > +test_expect_failure 'git am --abort return failed exit status when it fails' '
> > +     test_when_finished "rm -rf file-2/ && git reset --hard" &&
> > +     git checkout changes &&
> > +     git format-patch -1 --stdout conflicting >changes.mbox &&
> > +     test_must_fail git am --3way changes.mbox &&
> > +
> > +     git rm file-2 &&
> > +     mkdir file-2 &&
> > +     echo precious >file-2/somefile &&
> > +     test_must_fail git am --abort &&
> > +     test_path_is_dir file-2/
> > +'
> > +
> > +test_expect_failure 'git am --abort returns us to a clean state' '
> > +     git checkout changes &&
> > +     git format-patch -1 --stdout conflicting >changes.mbox &&
> > +     test_must_fail git am --3way changes.mbox &&
> > +
> > +     # Make a change related to the rest of the am work
> > +     echo related change >>file-2 &&
> > +
> > +     # Abort, and expect the related change to go away too
> > +     git am --abort &&
> > +     git status --porcelain -uno >actual &&
> > +     test_must_be_empty actual
> > +'
> > +
> >   test_done
> >
>
> I expect BUGS section in git-am(1) to be added to describe known bugs
> you demonstrated above, judging from the patch subject.

There's no point documenting the first one since it'll be fixed by the
next patch.  As for the second, as I noted in my cover letter, I'm not
quite sure that it really is a bug.  If it isn't, the second testcase
should be dropped.  However, if the second testcase represents an
actual bug rather than me just misjudging the intent, then your
suggestion certainly makes sense.
