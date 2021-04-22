Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C83AC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 09:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3F96145A
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 09:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhDVJVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 05:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhDVJVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 05:21:40 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568CC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 02:21:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id p15so1491112iln.3
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nwGQeyRXFRLSIEfIraXflEmBPszOCR/iYtrU9drGNq4=;
        b=YZIzYFqxrFBBZL+t04XUsRDKiqMqMykFuLtcA0EnvQybi98KnbaGM7jdlsvO+q3XXy
         Gl/DqnSCguteypx5CzRqIhJCd/tjrD+L7lIbyS5uHKKoyYOfzIIRgBhkx7gSBCh9y0AH
         /K66RvmK5L0del7ihcHKEAnm+BUrIwzCJ0OuZBxkNeW8gHPobiJT5vWJ+DqGSTx9AxGq
         l1Bmyjh+Siutm8IA/oUJ+1V8nowJnMaAVn2HjCwYBhnTUoJsGcIl4riXpj+fxXcp27bB
         LmgxS09aXUb9lRk1fgLjp0Q7DDb+6reevLBJm6BwoQx1bQOe55iRELjG8078NoMmZqGV
         d6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nwGQeyRXFRLSIEfIraXflEmBPszOCR/iYtrU9drGNq4=;
        b=tNcgAnuDLzHekQbQlXMdqN5RpXR0GQ/0aPodMQ44ahpoyGaRkmHyf40BRMoHv1TXp3
         M1dCu+xju6oNQv1wrXC/2HxRLmgXGfEKho1WPNt2m2jMP7lYNR2FXgl3u7lF7aZ9biLO
         REnwC60Ir5eBCgQVMWETiQJqGHHbQxOUazQUrgsHsS9LB7nmP8Df6jS4jdD7MXi0sU2c
         JECkc5yo8IGSk9NfH9qy+HVg6xEyLJTuQr+NVox05y4sqD/tfjBIoBloFIaWxWj4vzPp
         6ZshoIWlM4rTv+OVZ/R128YICVYdy5Vj3KcfP0XgqPYu+Co0ZZRPslEpXXPs8yuFaMlb
         Rurg==
X-Gm-Message-State: AOAM531Sew1EvvK8SVPKSSrrSOTghZfJECmUFoCIQCZoxWkVkZXEk2ZT
        dltumf0pFPrDXmtUI2h4QIf+kDl7EbGyYlXV2Yk=
X-Google-Smtp-Source: ABdhPJydlifyOYa97XZ0xPCwYdrzvWga52Srfm2gi+I6NuAT78JWHZk7+H3U3gZIpSjvPm8dQ/dgEXDttFoBWa8m+jY=
X-Received: by 2002:a05:6e02:1152:: with SMTP id o18mr1902469ill.174.1619083265818;
 Thu, 22 Apr 2021 02:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
 <pull.913.v11.git.1618672417.gitgitgadget@gmail.com> <xmqq5z0kbl8x.fsf@gitster.g>
 <CAOLTT8RKCV+Kpya-_AVjuVGWzs1WtGS8n_+sD0FVzwEpeXGwCw@mail.gmail.com>
 <xmqqfszk1ot6.fsf@gitster.g> <CAOLTT8QUA+m1W6-v=ZA205SZo8G5GBKMzJHBzU8DuQSTKiPUBw@mail.gmail.com>
 <xmqq1rb3xl3t.fsf@gitster.g>
In-Reply-To: <xmqq1rb3xl3t.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 22 Apr 2021 17:20:54 +0800
Message-ID: <CAOLTT8TciU7rvmEgXGMuVCMDN6HjMadL-L=Q9kej6=j6ktJHwA@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:40=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > I admit that your idea makes sense, but we actually have another requir=
ement:
> > Construct a trailer with an empty value.
>
> It can be done with a different script given to .cmd, which would
> say "exit 0" when allowing an empty string given as its input to
> appear in the output.
>

Now I think that we should keep those trailers which ask for a
"name <email>" pair, like "Helped-by", "Signed-off-by", when we
provide a "help:","sign:" in command line, This allows the user to
dynamically fill in the "name <email>" pair of other people in the
commit message later. It is worthwhile for users to exit with exit(0).

But those dispensable things like "Commit-Count", It must depend
on a person's statistics in the git repository. So "cnt:" is meaningless,
users' script can let it exit(1).

> I was reacting what the "count" example does, and found that
> counting commits by all authors (that is what an empty string would
> match when given to --author=3D"") somewhat illogical in the context
> of that example.
>

The "Commit-Count" in the example here can only target a specific person,
which has great limitations.

I have a bold idea:

Our current --trailer can only fill in one data item, and we don't
expect it to fill
in multiple rows. something like "Commit-Count", we hope to count the numbe=
r of
commits from everyone. But as we can see:

Commit-count: 7 Linus Arver
  1117  Linus Torvalds

So If we have the opportunity to capture every line or every "block" of con=
tent,
and feed it to git interpret-trailer, maybe we can get something like:

Commit-count: 7 Linus Arver
Commit-count: 1117  Linus Torvalds

This will definitely make it easy for us to generate a lot of trailer at on=
ce.
For example, a newbie like me, after making a patch, want to --cc all autho=
rs
of one file, maybe I only need a command to get it.

I don't know if it's a bit whimsical.

> After all, these examples are to pique readers' interest by
> demonstrating what the mechanism can do and how it can be used, and
> for this feature, I think showing that
>
>  (1) we can squelch the output from unasked-for execution;
>
>  (2) we can reject --trailer=3D<key>:<value> when we do not like the
>      given <value>;
>
>  (3) we can insert the trailer with the value we compute (and it is
>      OK for the computed result happens to be an empty string).
>
> should be plenty sufficient.

OK. I will add these three examples in the new patch (when .cmd merge to
master).

Thanks.
--
ZheNing Hu
