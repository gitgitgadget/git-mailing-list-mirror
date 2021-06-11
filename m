Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F08DC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE13661374
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFKSAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 14:00:51 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:44572 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhFKSAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 14:00:49 -0400
Received: by mail-oi1-f176.google.com with SMTP id a26so6613682oie.11
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGHLTFVWwzMrb+nuJtJWQo9Np6JGFyTeyj2heI4CW6A=;
        b=FjFu+j0o1zy6DHQa1VBkixedRCx/0j+v077nKmooAC4pQOZKxLY4vKdUPE6EWZTase
         jy0e7f3bLfXHBrnh0JDpllVefAQzbZQnYB9dGvVnFkbNfRcmsZkBSLtA7JC9Tr7Txgan
         jehr8c7usFZgG73CRaPixLaKCLc1TjIZqvmmPWJEykaeSvMbhxZ1E3lcrTkoNb2sEEnH
         6SWa4FHHbulVD3WbdhK2eCV3NrATyUGbz0Hj9Yl9TfNqP3pHHJsZIoDKUlalFspXNoLg
         a9CXnbxRCfmlj5tw5kCaYmxPhCbE0vKx51m9oQnK4YRjUI13U0sNsR48wMlQtQmlc76P
         XZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGHLTFVWwzMrb+nuJtJWQo9Np6JGFyTeyj2heI4CW6A=;
        b=EIYcMnd1Dua7XSCqnoyTHVsWQF7Wae5JK/L4FPZBY5YCedusnsr/dhq2oalUpPZgPg
         lDT1aXu/zHk3fa1wOt/GbnFP+ENqWQeFXPn9QwDxVFULO528MPhXf/OVnGUBnRwgKwJp
         34Vz7qrUFyLVARUyooEG94Qkj3fWzX3vEZTuV3NgjINOGJTwAaM1yR7h55vuxpRzIH+u
         uHt9mGOp/Z45ygoqhARkoDn+tbCj13tkZepVTPcwlGjOklvsKWgjcB5Ynk8pHIuFkk+n
         Q4TYgAV2hc7BHz90eatWSvZAaFbR+JIP31yn4ozi24v02gTTUyzSWNNTxOZHHOMGDXSn
         ouDg==
X-Gm-Message-State: AOAM5311LMke3u47pfLykNu4RaWALxwSh02EpT0umHTS1zgkhcM3D3MI
        ixZPTwPIdI9+iqXWi2vcqSzLSvgdmzzHtelbTSw=
X-Google-Smtp-Source: ABdhPJwSKnQ8SPwQyEJhH9R9/VKzLeYXkFR+Wqg+FB6GO436tmlMN0FqjK5/HsqEqNcap9RQIlv8a8F+ccsfBcP5dO0=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr3245078oiw.31.1623434255825;
 Fri, 11 Jun 2021 10:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com> <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net> <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org> <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org> <60c3724de35b4_3ad920839@natae.notmuch>
 <CABPp-BH0aRiSUw03nSK6jHRNQ+zcpUzr6WjeJ5GpdUCqCKxbag@mail.gmail.com> <60c39e1c52c04_8d0f208b2@natae.notmuch>
In-Reply-To: <60c39e1c52c04_8d0f208b2@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Jun 2021 10:57:24 -0700
Message-ID: <CABPp-BGtYnVPijg2OWoDBM915-PPFXk1O3H=BMf_itc4dNjAxQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 11, 2021 at 10:32 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Fri, Jun 11, 2021 at 7:25 AM Felipe Contreras <felipe.contreras@gmail.com>
> > wrote:
>
> > > Personally I have never experienced what you posted, so maybe there's
> > > something else happening behind the scenes.
> > >
> > > Maybe merge-ort changed something.
> >
> > merge-ort made no changes relative to content merges or choice of merge
> > bases.  (In fact, merge ort doesn't even handle content merges; that's the
> > xdiff layer.)  Even if merge-ort had made changes in this area, merge-ort
> > is not the default and I didn't see the necessary config tweaks in your
> > list of config options.  (I would have recommended against people using
> > merge ort until 7bec8e7fa6 ("Merge branch 'en/ort-readiness'", 2021-04-16),
> > which only made it into a release last week with 2.32.  I probably won't be
> > recommending it as the default at least until the optimization work is
> > merged and it's hard to predict how many more months that will take.)
>
> Indeed, I tested on v2.25 and found the same output.
>
> I thought of merge-ort because 1) I've never seen such kind of output
> before, and 2) grepping the code I thought I saw merge-ort being the
> default of something, but now I seem to be unable to find where.

We have briefly discussed multiple times what things might be needed
to eventually make merge-ort the default (though it's not even
complete yet; I'm five months into upstreaming the optimization
patches with an unknown number of months left).  There were also a
couple patches to make the _tests_ default to using merge-ort on most
platforms, while still keeping one suite that tests merge-recursive to
ensure we don't add breakage.  Perhaps one of those is what you're
thinking of?

> > It's more likely that the codebases you work with just don't have
> > criss-cross merges.
>
> Yes, that's it.
>
> I don't see why people in these kinds of codebases would like diff3
> doing that by default.

I suspect they don't[1].  What's the alternative, though?  Not using
diff3?  Picking a different base to avoid the occasional nested
conflict in the inner merge region, but which overall has much worse
other side effects?  I think Junio was addressing this when he
recently said elsewhere in this thread that "Rejecting diff3 style
output because of the way a conflicted part in the inner merge appears
as a common ancestor version may be throwing the baby out with the
bathwater"[2].  Sure, it's an annoyance, but diff3 is still a good
option and there is no current solution to the annoying nested merge
display.

Also, not sure whether it matters or not, but just for completeness I
should point out that you can get nested conflict markers without
criss-cross merges and without merge.conflictStyle=diff3.  It's just
much more rare.

[1] https://lore.kernel.org/git/CAPc5daUC+6cHpexXTO24p4mG_5eL1JmxrYm8h3UfdTh_FMka=w@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqqh7i5ci3t.fsf@gitster.g/
