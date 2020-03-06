Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAECBC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BEE20726
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU80j47H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFPsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:48:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36885 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFPsN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 10:48:13 -0500
Received: by mail-oi1-f194.google.com with SMTP id q65so2969668oif.4
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 07:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrPf/l58K4M7nPcL5nPmQwJN86gqVczsKhJaWdBIF9g=;
        b=KU80j47HoA2AyU4JyON1l8iZ2h99vVnBfE2f5GhJInsJDDgxeijfGjB5pnrelfg6is
         6OXfeVA9upnWn+K+v1l0kXA0FeoKrdjD618cq1zHhQQlpxtbre4hy8HePRoAW2r+aZKz
         H5xu3hJdi9fS3jdUUlNpumedJ8uydMVHApYNhVGVmoBshnJs+7izd6JaXUwpzqQgSZ3I
         uoqpWR6HKe7w2Ag7NaGHdRDrPChMJIuFllMTLnry/W6yl9Yc2GUxrReevqQaVZ9swvq0
         ljKKQKoFGhhydUZtfQgYPlBi2S+DiTe+A2RPPABp8fvP0IEuId2oKz5cBN1LO5URYixV
         wjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrPf/l58K4M7nPcL5nPmQwJN86gqVczsKhJaWdBIF9g=;
        b=jtRboZJCi19fxF15SdHax1x2+F/4GiJX+9+/kDy/hEFBePGjfZdmKIrPZgF61G5cpi
         VuWePGJKagS0qqTYt2ib6NrbUevdAUSiKQXl852285W4ufzGnAxBOSO3OdPJfl34Wkdi
         72d+3i8l4w8erZhIl5VuMXROg2aqzTZEbQgYrTM1lI9HJ8tFjtgFLwHAF0s0RtsfElXs
         nW8HQQDda5kPhAFNqr1EOggANrTCXOsK75DAD8k8tX/mSZAHW0HvCl+DWqPmJatkc7XT
         Jg0ZjQXeQxYl4MCrIkAeAnF8OpndFQYbjk34JpaGUq1IhQ043u0AzTeCEjVLOCuM1czE
         uyLw==
X-Gm-Message-State: ANhLgQ0EAeYCznvTzfYjq1KsX4Qc6MtI14q/+2RUbJjf8wHPawjBcn7A
        pNwZrrIzC79WCXwcAM2RYjq6GOpRWgsTBgJIW1+7/WzG
X-Google-Smtp-Source: ADFU+vujdV5e/aKwQyj23AjXhUvQgwq2hz3CxmOnjvdYWCL9XkX/RU1WTcULALUep6c7cC9xzaS/aI4jkF0b4Fz2Ntk=
X-Received: by 2002:aca:130c:: with SMTP id e12mr3011721oii.122.1583509692137;
 Fri, 06 Mar 2020 07:48:12 -0800 (PST)
MIME-Version: 1.0
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
 <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com> <20200302181832.GA1571684@cat>
 <20200302181924.GB1571684@cat> <xmqqy2si9z4x.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2si9z4x.fsf_-_@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Mar 2020 07:48:01 -0800
Message-ID: <CABPp-BGtez4qjbtFT1hQoREfcJPmk9MzjhY5eEq1QhXT23tFOw@mail.gmail.com>
Subject: Re: non-regression bug in 'git merge' (really, xdiff/xmerge, I think)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 2, 2020 at 2:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > diff --git a/Makefile b/Makefile
> > index 9804a0758b..096c6d1fbb 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -609,7 +609,6 @@ SCRIPT_SH += git-merge-one-file.sh
> >  SCRIPT_SH += git-merge-resolve.sh
> >  SCRIPT_SH += git-mergetool.sh
> >  SCRIPT_SH += git-quiltimport.sh
> > -SCRIPT_SH += git-legacy-stash.sh
> >  SCRIPT_SH += git-request-pull.sh
> >  SCRIPT_SH += git-submodule.sh
> >  SCRIPT_SH += git-web--browse.sh
>
> Merging this topic to 'pu', which has dl/merge-autostash topic
> already merged, breaks the build and it is not fault of Thomas's
> topic.  dl/merge-autostash has the following bit:
>
> commit 4b981afaa03c00524f1d4986271a3f4cc119f4cd
> Merge: 06928448f7 de4db86ff2
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Mon Mar 2 13:23:26 2020 -0800
>
>     Merge branch 'dl/merge-autostash' into pu
>
>     "git merge" learns the "--autostash" option.
>
>     * dl/merge-autostash:
>       ...
>       Makefile: alphabetically sort += lists
>
> diff --git a/Makefile b/Makefile
> index a5961113d8..c0793ac75b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -604,12 +604,12 @@ unexport CDPATH
>  SCRIPT_SH += git-bisect.sh
>  SCRIPT_SH += git-difftool--helper.sh
>  SCRIPT_SH += git-filter-branch.sh
> +SCRIPT_SH += git-legacy-stash.sh
>  SCRIPT_SH += git-merge-octopus.sh
>  SCRIPT_SH += git-merge-one-file.sh
>  SCRIPT_SH += git-merge-resolve.sh
>  SCRIPT_SH += git-mergetool.sh
>  SCRIPT_SH += git-quiltimport.sh
> -SCRIPT_SH += git-legacy-stash.sh
>  SCRIPT_SH += git-request-pull.sh
>  SCRIPT_SH += git-submodule.sh
>  SCRIPT_SH += git-web--browse.sh
> @@ -617,8 +617,8 @@ SCRIPT_SH += git-web--browse.sh
>
> which makes it appear to the xmerge code that legacy-status that
> used to exist in between quiltimport and request-pull has already
> been removed.
>
> As Thomas's above patch exactly wants to do that (i.e. we want to
> remove legacy-stash between quiltimport and request-pull), the
> xmerge code seems to think incorrectly that the requested change has
> already been applied.  And as a result of that, there remains
> legacy-stash between fliter-branch and merge-octopus, breaking the
> build by having one unbuildable build target X-<.

Thanks for the heads up; I agree that it looks like an xdiff thing,
and in particular it reminds me of
https://lore.kernel.org/git/20190816184051.GB13894@sigill.intra.peff.net/
and https://lore.kernel.org/git/CABPp-BHvJHpSJT7sdFwfNcPn_sOXwJi3=o14qjZS3M8Rzcxe2A@mail.gmail.com/

I'm collecting these cases because I'd like to look into it at some
point, though for now I'm more focused on merge-ort (my
merge-recursive replacement).
