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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692F3C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B9764DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhBRQz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhBRPFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 10:05:17 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D76C061788
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 07:04:23 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id k204so2286180oih.3
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 07:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3kgIBwcDEVE6YadvX+CMJFfuPwFvbB9jdBLM3Vgn7LA=;
        b=oOI4AMaivwaq9lJgyYTgEp9N3vvqX+7zlEnf/TepAfNCY0CEqbCL8wK2FIedQF7NgS
         cOYo8zuVOXWcdGBPMtplYP8dhquphrwa/p2oFTV+Bdd5Ig8URO9aPqfiG3ybuIRgXT/J
         sqaknOcx0SYBjg/uHgwX1dsHfvQSDFoIFlgoLapPzRnchBnMDl7mYXp2L2S1vIH/T9ep
         8X+T1/O3TJIwqVo0Epcz+nq9c6dNyeyEvdu1CQb0UqxUb4a0wxgY5PywgmBNIl6crnP+
         FpDeqdO5RIsOfgkXod7rpKd/ZXjAdrPmbvDpexNWkJ+B1eK/cNDUKM4fWi/cNknDF5NX
         Ig/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3kgIBwcDEVE6YadvX+CMJFfuPwFvbB9jdBLM3Vgn7LA=;
        b=L2nncgXLLf2QOaQtV0+l7EQ5C/V9Ne76k+nXIswaz3U3M89WwxCtXR3QErgeguC0Jz
         pBcCKy0DzwlyOaYqIr4luGLIFpNcHmZv662lXEHYvyJHHUXYxOui5QKUluTzpvWu5MbD
         Aeo1eTkHOE8dyuj5kGtZk2S0zYwzzxlICTuMBle9RjptLCg7fkA+1A6U5Y82o9TGrfhX
         aJsGKMlTa3/7S+TAZRDCDDZCvhVaukMlnDnRLwbo5MBc99cy61NtPi+zsmI7/DwwT562
         NlsHwSXtQWSfHZS9zEVcGwQ3vSwo5XuAF7AxyAYXr73PxF+5XP1pj7N1SJjf8I3UhAIi
         Y2qQ==
X-Gm-Message-State: AOAM5338SKt5mpbc8atJu7dsEty+Gs607ZwOwTyhqGxGeiJz4OgSXTdu
        brx8NP19NtwwuQmOTsiSLym/10LewzFa+fcDQg4=
X-Google-Smtp-Source: ABdhPJwF9jhB0FP1ozfcfTSG0WZ51s/mlZqu/YGXOKrIY/wtv6ZoqE0GmQGoYkhfFNZ6Qo35UkkSD8x8IUse1tTN53s=
X-Received: by 2002:aca:52d1:: with SMTP id g200mr3176336oib.44.1613660663460;
 Thu, 18 Feb 2021 07:04:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
 <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
 <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
 <YCz6oDZCAODPS8sY@generichostname> <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com>
 <xmqqo8gile02.fsf@gitster.g>
In-Reply-To: <xmqqo8gile02.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 18 Feb 2021 23:04:10 +0800
Message-ID: <CAOLTT8QNbTeSJfo2O7f5vv6Q9ZVMrkGjRCikc4P7eN7M6aeZdw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8818=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:56=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Denton Liu <liu.denton@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi ZheNing,
> >>
> >> On Wed, Feb 17, 2021 at 12:12:10PM +0800, ZheNing Hu wrote:
> >> > Oh, I am sorry.
> >> > Then I only need to squash the two commit, right?
> >>
> >> I've never used GGG before but I suspect that in your GitHub PR, you
> >> need to set the PR base to 'master' instead of 'jc/diffcore-rotate'.
> >>
> >> CCing the creator of GGG, please correct me if I'm wrong.
> >>
> >> -Denton
>
> > Hi Denton Liu,
> > You mean I should cherry-pick Junio's patch to my topic branch, right?
>
> Thanks, Denton, for helping.
>
> ZheNing, the end result we want to see on the list is just a single
> patch, your 2/2 alone, that says "this patch depends on the
> diffcore-rotate topic" _under_ its "---" three-dash lines (where
> "meta" comments on the patch to explain how it fits the rest of the
> world, etc.).  As a single patch "topic", there won't be even 1/1
> marking, i.e. something like:
>
>     Subject: [PATCH v6] difftool.c: learn a new way start at specified fi=
le
>     From: ZheNing Hu <adlternative@gmail.com>
>
>     `git difftool` only allow us to ...
>     ...
>     Teach the command an option '--skip-to=3D<path>' to allow the
>     user to say that diffs for earlier paths are not interesting
>     (because they were already seen in an earlier session) and
>     start this session with the named path.
>
>     Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>     ---
>
>      * An earlier round tried to implement the skipping all in the
>        GIT_EXTERNAL_DIFF, but this round takes advantage of the new
>        "diff --skip-to=3D<path>" feature implemented by gitster
>        (therefore, the patch depends on that topic).
>
>      Documentation/git-difftool.txt | 10 ++++++++++
>      t/t7800-difftool.sh            | 30 ++++++++++++++++++++++++++++++
>      2 files changed, 40 insertions(+)
>
>     ... patch here ...
>
>
> I do not know how to achieve that end result with GGG and I do not
> know if GGG allows its users to do so easily, though.
>
Hi, Junio,
I think my patch is stuck in GGG, and the current version is after I
cherry-pick your patch and my patch on the master. Because I don=E2=80=99t
know how to based on your patch but not submit your patch. Is there
any good way?
Thanks.
> Thanks.
