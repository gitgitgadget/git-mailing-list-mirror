Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C54C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E4223AFE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgLHU7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgLHU7A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:59:00 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE912C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:58:19 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so3541125wmg.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TewDWGKpF3C7bi8nsIPTbq/Ou/AyM+tXLkGK8sB83Qk=;
        b=Mey5+aY2GN+x+NSETYJHBU8VuB4P8fEfZapaXtMB7/yfGnG6nLMggMa/KIQko0lKzs
         DyOHvY3j5FyAt6MPGrv3n8eSR1XqGLnqlLuiUZvO83VxiFfeYtcOPb/h8nvIL/5WtaFn
         8LZn/TuGvWQcoIRks0lqiqHpQbvPvtxXUTkryY3aOh/fWIMd/uZDdgNzx5aa4aKchFwA
         nj3G7zpAVM6g94nTZLCBdETrbgARqloybDirOGr59YLL23Rrre9BTmVoLu3/ma3E1OzU
         GIItATNpgYZPcA1HZ1tW1EDYdr9WvQ2snSonC2Cl23UtxL2SI50J4+dU7RO7T+KVwPBV
         s3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TewDWGKpF3C7bi8nsIPTbq/Ou/AyM+tXLkGK8sB83Qk=;
        b=J70wtEVroSobODEJX4oXSNLV94o9hQidkwnwt9eOiPaVFhVxo5ILaiQ64pQ6zxwcuv
         godyO9T8Q3TtSeqz466PmvBF63C1Y3qJACGQLNgRYEhKF6zAt4G36aX0gdiv8vGCZAGE
         aUFJushi7LwZOhEszHIxjY361N+5v2uFDbp9tigeeVhUXpWgU7yv9dUOaTCidDsOPzRn
         lZtH8bgBWySyx8E04hcKRQ3xHe+Hytsy/PScs/JSi6o4jjdxo8zVMvwSQLJZktTyQWjS
         sEiRUgIjeqIi22HWECe3si3gRmdwcymrsw0LGYOlmKLRgCrUCdGkeHOCuAQhv/RtPt7Y
         r4Ww==
X-Gm-Message-State: AOAM5306lZrUnexg87hyXFqlJLHGe7M0tPrDGOIzkYgkZkIXPuPeNgX0
        PbgrLbUiEUjGCHSxMgEWYDDzRCTto7F6KyHMq8s1foR+TVck5WSG
X-Google-Smtp-Source: ABdhPJxSKTfzVU3MUEZeZ0WwI7IkyS2T0MlIKisel/3RhP4sNh+tBnbY1hdyOuShFh9wmDQy4RpiLKCijd/kM6qk7bE=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr4987508wmc.55.1607453726191;
 Tue, 08 Dec 2020 10:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
 <20201205195313.1557473-2-felipe.contreras@gmail.com> <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
 <CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com>
 <CABPp-BEkKMuZHWJ8mrFUFm3okDDsMHeZZNxtGzgq-RLLddMxdw@mail.gmail.com>
 <CAMP44s0g7JLTZZs=O3gUcEiPt--p3gXEPHL0GsBqoqweKA=9Rw@mail.gmail.com>
 <CABPp-BESMs1tuVoLFMy-BahSChFz7oANqTaeJShFa_zDbEnvBA@mail.gmail.com> <CAMP44s2JMNML2a8ckdrorgMH6x+NduvWsvRn-p6O=XbYBofNgg@mail.gmail.com>
In-Reply-To: <CAMP44s2JMNML2a8ckdrorgMH6x+NduvWsvRn-p6O=XbYBofNgg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 8 Dec 2020 12:55:15 -0600
Message-ID: <CAMP44s0jERkEoJgCvV3SkehviW0HhLZHCw0jfKUBn1kd=YBtEQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 8:37 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> Take for example the word "calibration". It is a noun, but you can't
> point to any calibration thing. It comes from the verb calibrating,
> and such conversions are called nominalizations.
>
> I'm currently re-reading The Sense of Style, and it's interesting that
> in Chapter 2 Steven Pinker mentions precisely these nouns, which he
> calls "zombie nouns". They certainly do exist, and people use them,
> but they suck the lifeblood out of prose. Take for example
> "comprehension checks were used as exclusion criteria" (zombie nouns),
> compared to "we excluded people who failed to understand the
> instructions" (live verbs).

Actually I found this video, which is more digestible and enjoyable:

Zombie Nouns and the Passive Voice in Writing
https://www.youtube.com/watch?v=sS-Txm3R3v8

-- 
Felipe Contreras
