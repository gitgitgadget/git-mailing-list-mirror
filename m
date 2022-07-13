Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90413C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 01:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiGMB1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 21:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiGMB1D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 21:27:03 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF7C922B
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:27:02 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id l11so16874760ybu.13
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mK0hOrFnDzNiJ8GahXeA+8fJi93N3FdLVVhYFZeQ5dc=;
        b=KsqZ9DNxYeb0inRh9k+6Rjfwuzg+dEXF5Clc/XcqP7L+URO10ryzQWhAkg4WFoQZaV
         EuU+nHrmVIlAB5dotwahA0vvTW+BqfhZ+4MXy+BWOFgS9Bb78YaMGOxAtMDIRZeunbtn
         bX7B+20iMaZHkiinsB5D5zrALvq/i6tUxv4Iol+FKjUAMhsEqb+VUiAVPXwn/zyQ9IjL
         CTIPLcyowO230p5E9BLD1CbP6SaejU0Q32BbAC0jgf4/GnFR1+EXsTcMKM2ASBv9xYS4
         hVbG8Lvzs+OUppqE3IjRRafNtDl6MDRLbfItjDrSC1dUBZHfP0cfpci22hwQpD9MOKRx
         31lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mK0hOrFnDzNiJ8GahXeA+8fJi93N3FdLVVhYFZeQ5dc=;
        b=cxN0yadCMLuqib7hjDAjIL55uj7Xq2kZRkqlRlzEDQMDki2+C4lu/bCBnoJaYiHs9u
         hpWFuT8iA1/77Du2QeGYvqdMzi1XCBEFA9lycXsxsiV52HfLqmFUt3xUnRGW0+lEfrxr
         S8Y8RvJ84L0S1OQ9UrbDCIL4lRKq8NYcMY1mzMrj0axdxNbltMa5hhTRWBzjY14zyfvB
         vG8EVb69o4e2xLDJPFfu2X4Hd/Scj618P7S5vloyZ4+I7xmNDPCXjXb7ViW+m8dtFoEU
         gWsaJGxfPCHx41cpUSa04GHI+zL1b60T0g1ybgNbMrf8HOSQNKfwNx8xmLNBBSguz+64
         2mog==
X-Gm-Message-State: AJIora9ljGJ6XDet4UP5OYmwOQBfJtqgQ9kusdSK0oP8Wgh4Nz2g+I85
        9Wkvgn7D8yQx9Tj0TeZr8qm1s7XhKcjUZ9ti9iemeuM2kJXYSg==
X-Google-Smtp-Source: AGRyM1vCa3he2fUBqJ0eUoW2faRTjFmP2/iwTxXJuR79iA51JHT3HJ4I6yvTSP62XBbzCuXm9B/N10yOxDpXIzI6hpo=
X-Received: by 2002:a25:4284:0:b0:66f:83b6:64bf with SMTP id
 p126-20020a254284000000b0066f83b664bfmr1221481yba.586.1657675621577; Tue, 12
 Jul 2022 18:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656593279.git.hanxin.hx@bytedance.com> <cover.1657604799.git.hanxin.hx@bytedance.com>
 <3ffeed50deb2d292cef0a518085d60d22c5dd79b.1657604799.git.hanxin.hx@bytedance.com>
 <220712.86zghe4q0c.gmgdl@evledraar.gmail.com>
In-Reply-To: <220712.86zghe4q0c.gmgdl@evledraar.gmail.com>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Wed, 13 Jul 2022 09:26:50 +0800
Message-ID: <CAKgqsWWYGVh_ViPjEn8ezUMysGnxqu9xMkydT+vbuDE_GSWz_w@mail.gmail.com>
Subject: Re: Re: [PATCH v5 1/1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Michael J Gruber <git@grubix.eu>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 5:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > +test_expect_success 'fetch any commit from promisor with the usage of =
the commit graph' '
> > +     # setup promisor and prepare any commit to fetch
> > +     git -C with-commit-graph remote add origin "$(pwd)/with-commit" &=
&
> > +     git -C with-commit-graph config remote.origin.promisor true &&
> > +     git -C with-commit-graph config remote.origin.partialclonefilter =
blob:none &&
> > +     test_commit -C with-commit any-commit &&
> > +     anycommit=3D$(git -C with-commit rev-parse HEAD) &&
> > +     GIT_TRACE=3D"$(pwd)/trace.txt" \
> > +             git -C with-commit-graph fetch origin $anycommit 2>err &&
> > +     ! grep "fatal: promisor-remote: unable to fork off fetch subproce=
ss" err &&
>
> This part seems quite odd, we tested the exit code, so here we're being
> paranoid about not getting a specific "fatal" error message.
>
> It seems more worthwhile to test the warnings we emit, which in this
> case seem to be duplicated (but that's probably an existing issue...).
>

So you mean the grep here is redundant?

>
> > +     grep "git fetch origin" trace.txt >actual &&
> > +     test_line_count =3D 1 actual
> > +'
>
> I wondered if "test_subcomand" here would be better, i.e. fewer things
> scraping GIT_TRACE, and using the machine-readable GIT_TRACE2_EVENT
> instead...

I threw this question up front but got no response.

When using test_subcommand() we should give all the args,
if we remove or add any args later, this test case will always
pass even without this fix. So, is this test case still strict?

    GIT_TRACE2_EVENT=3D"$(PWD)/trace.txt" \
        git -C with-commit-graph fetch origin $anycommit &&
    test_subcommand ! git -c fetch.negotiationAlgorithm=3Dnoop \
        fetch origin --no-tags --no-write-fetch-head \
        --recurse-submodules=3Dno --filter=3Dblob:none \
        --stdin <trace.txt

Existing usages are as follows, and they all have fewer parameters:

     test_subcommand ! git gc --quiet <run-config.txt &&

     test_subcommand ! git multi-pack-index write --no-progress <trace-A

     test_subcommand ! git pack-refs --all --prune \
          <incremental-daily.txt &&

Thanks
-Han Xin
