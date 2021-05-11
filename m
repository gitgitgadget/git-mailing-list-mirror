Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DEDC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852866121E
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhEKTyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhEKTyn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:54:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E195C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:53:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j10so30315069lfb.12
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzqSGbtFtkfnMHXkrLTPk6sepLO/7KLNUjw1jH+j1U8=;
        b=e8Wj8W+ANPxUV3FnqUZLh4rtUzhATysbWn/krPAaY/sFvKDMmYwjBuRgA5VQuyjjEL
         v+ZFidhWhYCLsddTedZlhkdC9co6fi4rCyxODls8PWKECtA1l5ami/Wrpe07jQ8dYGFw
         A+1LFQlxqwKy5BgR5tguX0HZz7P1hw5FcSfZHjpdQlJ6+baJDMTJOn69nsPI2GE4PxQW
         RX7FIYZkytlIj4P1NFCfLn4iaIsQP4Wn9DNbkJGpHECXxO8RzAkwf9ZWxtWeDMZqFC4F
         EqQU7gVKCV+7dC1vrG+FdCVT5kTjHWfcz2zimYBmNUMwhAjDux8JBDOs8U/w4BoXPtIe
         llqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzqSGbtFtkfnMHXkrLTPk6sepLO/7KLNUjw1jH+j1U8=;
        b=caLZE4XDYop6Oan0sGwTpn1ZFYIXBwmjLY8nLrYMeBwyddYg/yGgnLcFn2WWMX6+Ab
         8NVn8zXo/fowN5vDrW6ABGrcWDXUWxWQzq947OZqI0RqRD5tMyeUJ6mIe8fcnr3ooqIE
         wrRB0A1fnLOKqCsOCg5Z5b0oceYJ35LMZAPi2vo0FOQAxU99DojubJWmrMuii/15N6DE
         th9coxvMl8/PRBdqvd3MnjxwzoHoiFZhtjg29BHVcRhhREpcE6tO58oD9nmAjXVLjF/u
         1QPS1zGox4HEoV8Fk19gNZ75xAPhCD6LnwIxyxqT/sW0h6uAKfznY2O1+wZ2bQIr2SKl
         Mw0A==
X-Gm-Message-State: AOAM530NgYSQyD/u706AVZRcOsIMxt7IMfwfegb9ML441sUsXK+d6Cg4
        MDiWdsAyA3pEHan1rOdigCRYov0KcU7PIYamY9A=
X-Google-Smtp-Source: ABdhPJx0EinEDvn4s09iX8iOcbuCTnKsGo3R9kp09ROqc6aQmMkZYvOIniBMZYZIiRHM7mryzulWkP/K6/APD3S/O1U=
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr22150324lfn.148.1620762813881;
 Tue, 11 May 2021 12:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com> <20210510153451.15090-7-sorganov@gmail.com>
 <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g> <87v97pv04p.fsf@osv.gnss.ru>
 <CAMMLpeTL9ZOuHLhqonFOwMu8yC9bETMVzkCZ__F2JsR=0umL3A@mail.gmail.com> <878s4lqfbk.fsf@osv.gnss.ru>
In-Reply-To: <878s4lqfbk.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 11 May 2021 13:53:22 -0600
Message-ID: <CAMMLpeR0eeM1droa3sxeToxw+8ACtJM3+3=SkWR9qrWbK_9sDQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 12:46 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > On Tue, May 11, 2021 at 8:03 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> [...]
> >>
> >> > If we enable "some kind of diff" for "-m", I actually think that by
> >> > default "git log -m" should be turned into "log --cc".  As you told
> >> > Alex in your response, "log -m -p" is a quite unpleasant format to
> >> > read---it is there only because it was the only thing we had before
> >> > we invented "-c/--cc".
> >>
> >> Please, no! --cc has unfortunate feature of outputting exactly nothing
> >> for a lot of merge commits, causing even more confusion than historical
> >> "-m -p" format.
> >>
> >> The best default for -m output is --diff-merges=first-parent. Everybody
> >> is familiar with it, and it's useful.
> >>
> >> > But that might be outside the scope of this series.  I dunno, but if
> >> > there is no other constraints (like backward compatibility issues),
> >> > I have a moderately strong preference to use "--cc" over "-m -p"
> >> > from the get go for unconfigured people, rather than forcing
> >> > everybody to configure
> >>
> >> I rather have strong preference for --diff-merges=first-parent. --cc is
> >> only suitable for Git experts, and they know how to get what they want
> >> anyway. Yep, by using --cc. Why spare yet another short option for that?
> >>
> >> Overall, let's rather make -m give diff to the first parent by default.
> >> Simple. Useful. Not confusing.
> >
> > Honestly --diff-merges=separate is fine. Two weeks ago, when I started
> > this discussion, I was trying to use `git log -m` and `git show -m` to
> > find which merge commit introduced a particular change. Extremely
> > verbose diff output would have been great for that, the confusing part
> > was just that `git show -m` produced diff output and `git log -m` did
> > not.
>
> This is not a case in favor of "separate" over "first-parent" as the
> default for "-m", right?
>
> "Which merge commit introduced particular change" is exactly what
> --diff-merges=1 achieves, so "--diff-merges=separate" was not in fact
> needed, as I see it. Moreover, it could have produced wrong positives.
> Looks like --diff-merges=1 is a better fit.

I didn't know which branch the change came from. If the change came
from the first branch, it would not have appeared under the merge
commit with --diff-merges=first-parent. But the change would
definitely appear with --diff-merges=separate, which enabled me to
identify the merge commit that included it. So yes, this is a case in
favor of "separate" over "first-parent", but it's probably not a
common enough scenario to demand keeping "separate" for -m.

On Tue, May 11, 2021 at 12:31 PM Elijah Newren <newren@gmail.com> wrote:
>
> Interesting.  I have a strong preference for --diff-merges=remerge
> (yeah, I know it's not upstream, but it's been ready to submit for
> months, but just backed up behind the other ort changes.  Sorry, I
> can't push those through any faster).  I've had others using it for
> about 9 months now.

--diff-merges=remerge is the default I would expect when no options
have been configured or passed on the command line (although it would
not have helped in the scenario I described above). I look forward to
using it!

-Alex
