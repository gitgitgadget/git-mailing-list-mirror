Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D73C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjB0PVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjB0PVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:15 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D376222A3C
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:21:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bi9so9047099lfb.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRpaw0EC/OH5QhxximgV2sF41DOeskiyCoYCx1iBG8o=;
        b=dKZMEJfvSGl23A37pcjvjfaxl+EHraeAheVs3u5IT5w9drRreC/lGt0ha7XBbKNhis
         1f+Coxcu+F9y72EeNBNGynZLoS4goZR36tk2NiQ/d8ENxfdOk2hN8953LBiB4N6asx+u
         5NPoA+xLeyMR9Hew269jP5Ls0dmZxCHKIH6WCrSuGqr+OnA06tpghQAXLAtzOKva3xHR
         cfq32DeZVFiClqllm/J8+ATk4BwLodcIoYLn6R3UtHPpdGi+Fq2ZuQ5isYrFtR7phqql
         6tWK0PHKp32b9mPQEwcgvwMMaG/3Hy3Mn5upq4ZAUz5M6qONSUgmi4FWYwwG7k8Rjjsa
         42zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRpaw0EC/OH5QhxximgV2sF41DOeskiyCoYCx1iBG8o=;
        b=YglPf2Oex8U8OAFCSTWbbMzw6fqc1YNGGOf9PnYClE742B/rPxac6YdT6bS17JswiU
         SX1whX8zHpWD8lTLJZQNAsxexoV5+RfzGmqo5Sr+A7CLf2zUtfosQGH/BQyO9fHDpH7e
         dJ74wJ3yPD2C3f/s4TD0MK+VD014Lr3mR9DxmAsRNUdyPGlfoLHELzp1m2coCH1tvCGR
         DJ7FokQMjB3f5hVgYFWl6quejLlL0RINESK48tKz/GeZwJKMNY/XOhpnZ+xKN+U4KbkE
         XmG09OxdXwacFtu52bpStTxQ+NHg0byKV1bNrLVWl3pL8sSAIHlhWm7zwl2iGTzYByZU
         ykiw==
X-Gm-Message-State: AO0yUKV63EoD54T65cCKMi8kH3F5HCB7q3vwANcM53Q4Cd34xv3NiDPq
        KTIuIpk1gBHaUj6j6rFRVFEZ2J2g3dTjDFgGy37eR17fvBs=
X-Google-Smtp-Source: AK7set+9wA8Ox/HAYgAl3BGIRtuj16642iH2c5JQcCBPwWfAYvfEQJkQv0qZmeWEgWC0xg36g+8XzO8mJxlJhNF36wU=
X-Received: by 2002:a19:7417:0:b0:4e1:f70a:3b11 with SMTP id
 v23-20020a197417000000b004e1f70a3b11mr50202lfe.2.1677511267936; Mon, 27 Feb
 2023 07:21:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk> <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
 <87a615vkqk.fsf@osv.gnss.ru> <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
 <87bklilnvp.fsf@osv.gnss.ru> <CABPp-BHRbKG_cXdwaPT0-Rj6QTkkJRcT4N0f45==i7oAqiTC+w@mail.gmail.com>
 <87fsatixnn.fsf@osv.gnss.ru> <CABPp-BF3JUg4jThS8Y_3v-tOEey55V_9KpXRZ3HvfaC3S2m=GQ@mail.gmail.com>
 <87lekklqpi.fsf@osv.gnss.ru>
In-Reply-To: <87lekklqpi.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Feb 2023 07:20:54 -0800
Message-ID: <CABPp-BGJ+jdwizBNyYr-st58F6BPbyrJ+DwRX81_0NjgU6LhzA@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2023 at 1:29=E2=80=AFAM Sergey Organov <sorganov@gmail.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Sat, Feb 25, 2023 at 7:15 AM Sergey Organov <sorganov@gmail.com> wro=
te:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Fri, Feb 24, 2023 at 2:06 PM Sergey Organov <sorganov@gmail.com> =
wrote:
> >> >>
> >> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> [...]
> >>
> >> > Please, go read at least [1] to see Johannes comments about how the
> >> > prior proposals don't work beyond simple cases.
> >>
> >> It's exactly handling of simple cases that we need most. We can get
> >> fancy afterwards, if feasible.
> >
> > If we can handle just the simple cases without making common cases
> > significantly worse, that'd be a potential path forward.  Any proposal
> > involving the diff between a merge commit and either of its parents
> > (or an equivalent such as a three-way merge involving the merge commit
> > and one of its parents) doesn't achieve that, IMO.
>
> Except the method discussed does achieve exactly that according to the
> evidence gathered at the time of debates, and here is confirmation (from
> Johannes himself) from the reference you provided:

I'm glad you read it.  :-)

> "This strategy, while it performed well in my initial tests (and in
> Buga's initial tests, too), *does* involve more than one 3-way merge,
> and therefore it risks something very, very nasty: *nested* merge
> conflicts."
>
> So, overall, the method performs well in general,

Jumping from "performed well on initial tests" to "performs well in
general" seems to me to be quite a large and unwarranted logical leap.

> and we just need to
> avoid driving ourselves into nested merge conflicts

I'm glad you're discussing a disadvantage and how to address it, but I
don't understand how you can jump to the implication that this is the
only one.

> Setting this back into perspective, in comparison to blind re-merge,
> that fails to keep user changes even when no conflicts at all exist, and
> even when it's applied at the same place in the history, the discussed
> method is a *huge* step forward, especially if re-merge is kept as a
> fallback strategy.

The use of superlatives and asterisks doesn't change my opinion; I'm
still skeptical that the given strategy is overall a step forward, let
alone a large one.

(I do agree we have a huge problem and thus that a huge step forward
theoretically could be taken, I just don't see this as it.)

> P.S. BTW, where this hate for using of diffs with respect to parents
> come from, I wonder, provided we do use them all the time anyway?

I have no hate for such diffs; I just firmly believe they are
inappropriate as a solution for the particular problem space being
discussed.

But I've stated that more than enough, and no one is producing patches
on this topic right now, so I'll drop out of this thread.  I still
believe in my proposed solution, and I'll implement it as I get time
for it.
