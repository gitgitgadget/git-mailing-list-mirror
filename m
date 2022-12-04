Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6ABC4321E
	for <git@archiver.kernel.org>; Sun,  4 Dec 2022 16:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiLDQjd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 4 Dec 2022 11:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLDQj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 11:39:29 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBECE1E
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 08:39:28 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso9637098pjb.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 08:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgWLSCtULWRlXCWUi2/kn9YfkLaa0S+tAyQbO9+ubQM=;
        b=stYPeofPqowXkIBObTJd5H4Q3NcKapey5JvgAv50cDqmXkgiTarUHPiSIlqXAYq5e4
         Ik3FDm/pwnipoDJAEivGdA6VwElLKmpYLftL4kXpFaXlwHTDyYg8aetBI3ZQW7n5BNCg
         7YrWeMXO58+qHK4poLvuQoNGjBXtBPZ0sVOWvRvu4UWow8mbkQNHGQ/nY+O4pBkOu9o3
         tJ+jNjRyWXJI0XxqaViXP356GNN/O4f02VX3ROzxPjmApODwdeYsghcgfzBbwX3rqBBw
         c4jYB48sHCPpNL22qbcUB3jvHc4EZ80dF1E0WScehrUXPLqtzIpUGCulPLKntmdPkIW1
         hmxA==
X-Gm-Message-State: ANoB5pmOpOkEt/zVu7HrKsoqiujq/El3iMbwj+nXWdw9I4uZXlL7eqm2
        SYdSxyTh815E0TI961OIlkNUSnmK9LGCTJo5uCQ=
X-Google-Smtp-Source: AA0mqf58qQEWy36X2V5jgTssVMVeGFGMsxmBV/Pk1cnN3E1UOkdcZsoYUwAiWDV6dD6ExI+CgnOkQeqCSGfC8JaFN2E=
X-Received: by 2002:a17:90a:9f46:b0:219:b1db:f7e3 with SMTP id
 q6-20020a17090a9f4600b00219b1dbf7e3mr6329019pjv.64.1670171968109; Sun, 04 Dec
 2022 08:39:28 -0800 (PST)
MIME-Version: 1.0
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <203cb627-2423-8a35-d280-9f9ffc66e072@web.de> <CAPig+cQack=pJ04fwEiq81x6+2AAG4ni0Gd4GQgr4FS=PERb_Q@mail.gmail.com>
 <4611a23a-e7e9-6039-5d54-c2f8cadc2f73@web.de> <221203.86lenoeipb.gmgdl@evledraar.gmail.com>
 <491ad25c-1cf3-98dd-f7aa-e8d1f24c8cd0@web.de> <221204.86cz8zecam.gmgdl@evledraar.gmail.com>
In-Reply-To: <221204.86cz8zecam.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Dec 2022 11:39:17 -0500
Message-ID: <CAPig+cQq6Jy9y8vNCFjW+J-GDqTsgbbGJW_SZpNsrb5pkLFDPw@mail.gmail.com>
Subject: Re: [PATCH 4/1] t3920: replace two cats with a tee
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 4, 2022 at 4:41 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Sat, Dec 03 2022, René Scharfe wrote:
> > Am 03.12.22 um 13:53 schrieb Ævar Arnfjörð Bjarmason:
> >> On Sat, Dec 03 2022, René Scharfe wrote:
> >>> Am 03.12.22 um 06:09 schrieb Eric Sunshine:
> >>>> On Fri, Dec 2, 2022 at 11:51 AM René Scharfe <l.s.r@web.de> wrote:
> >>>>> -       cat >.crlf-orig-$branch.txt &&
> >>>>> -       cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
> >>>>> +       tee .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
> >>>>
> >>>> This feels slightly magical and more difficult to reason about than
> >>>> using simple redirection to eliminate the second `cat`. Wouldn't this
> >>>> work just as well?
> >>>>
> >>>>     cat >.crlf-orig-$branch.txt &&
> >>>>     append_cr <.crlf-orig-$branch.txt >.crlf-message-$branch.txt &&
> >>>
> >>> It would work, of course, but this is the exact use case for tee(1).  No
> >>> repetition, no extra redirection symbols, just an nicely fitting piece
> >>> of pipework.  Don't fear the tee! ;-)
> >>
> >> I don't really care, but I must say I agree with Eric here. Not having
> >> surprising patterns in the test suite has a value of its own.
> >
> > That's a good general guideline, but I wouldn't have expected a pipe
> > with three holes to startle anyone. *shrug*
>
> It's more that you're used to seeing one thing, the "cat >in" at the
> start of a function is a common pattern.
>
> Then it takes some time to stop and grok an a new pattern. If I was
> hacking on a function like that I'd probably stop to try to understand
> "why", even though I understood the "what".
>
> I'm not saying it's not worth it in this case, just pointing out that
> boring "standard" patterns have a value of their own in us collectively
> understanding them, which has a value of its own. Whether optimizing a
> test case outweighs that is another matter (sometimes it would).

Perhaps my experience is atypical, but in decades of using Unix, my
use of `tee` can (probably) be counted on a single finger, so the
patch, as implemented, did have higher cognitive load for me than a
patch using simple redirection would have had. Anyhow, I mentioned the
redirection approach, not to ask for a change, but only in case you
had overlooked the (to me) simpler approach. I didn't expect it to
spark so much discussion (though I do agree with everything Ævar has
said about following established patterns).

That said, I'm still rather unclear on the purpose of this patch. In a
sense, it feels like mere churn for 1/100 of a second gain (assuming
I'm reading the `hyperfine` output correctly).
