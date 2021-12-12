Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA49C433FE
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 22:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhLLW1g convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 12 Dec 2021 17:27:36 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:46726 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLLW1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 17:27:36 -0500
Received: by mail-pj1-f45.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so11838076pjb.5
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 14:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xo7fZHFLLuIsnCsznBzQ5ElifLKPqTpsbG3c3zCSxRE=;
        b=Gy67hW8Ew9ksQTyFD5eetEtdIDgd0iv8ZEBqRA7jbXXdg+8tMdBtgJI424GWTZVw4Q
         UBM4QhUg1ncQ/qRCiTSmt+bZ+Fph9eQCugjJ7lmvUTlzXnCRvro2yJ/N3uC3RTR2JHzo
         xcf9MSwWmKT7GWwCHX3TSsr4eVjcMI6u2Xe0Epc6AydnsTwF17lXLpSY+9xSXyM/tUIi
         OalG0qNbHclCXzJ84C5rCTUO5F7VWIADUYxajz4vQv+kPSHoPGQ2X/MpT73W/rpw5FCJ
         AJgnUGkd22nNs5iCEuKbcGm8qGbdazw/5UGGDDLSasKTbCiso+QsdrM0CuDmKjhYe2qf
         e7vg==
X-Gm-Message-State: AOAM530bVQ0CUnDd9ksYakmwKqiUexOhbT6Gpg4gaMChAmwitBZitrDY
        x3bHHRTz8iIqHzXv8C3X6hf2ZO287RzmRmqx/qk=
X-Google-Smtp-Source: ABdhPJwq4E/7HDeegistUr+CI0FNQIzwqK2WYCk8zUeuGcseltRP95g+QGDA26MPrtcB3PwKd72Y1rI6xThIRYZ3WNQ=
X-Received: by 2002:a17:90b:3558:: with SMTP id lt24mr8931156pjb.150.1639348055787;
 Sun, 12 Dec 2021 14:27:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
 <211210.86r1akbes8.gmgdl@evledraar.gmail.com> <20211210164249.bahhe5ogjjhz4lxo@fs>
 <CAJrA3nKbUK=_5d5KTCDehrfge4y1aB9YGsFwQYNzUDWGcfog4w@mail.gmail.com>
 <211211.86a6h7c1mq.gmgdl@evledraar.gmail.com> <xmqq4k7dlld3.fsf@gitster.g> <211212.86o85labj1.gmgdl@evledraar.gmail.com>
In-Reply-To: <211212.86o85labj1.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Dec 2021 17:27:24 -0500
Message-ID: <CAPig+cT-9GAtadPW-=3sVFVWyKTf9Kybs3TwSW-s0BzhsfGJyQ@mail.gmail.com>
Subject: Re: Please, paint new branch errors in RED (or any visible color)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jose Wielandt <jose.wielandt@timining.com>,
        Fabian Stelzer <fs@gigacodes.de>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 12, 2021 at 4:22 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Yes, I think it's a bug if we add any such coloring that isn't
> configurable via the usual color.* configuration. Although in this case
> it's usage.c. So perhaps "color.usage" (as in usage.c). But that squats
> on any future hypothetical "git usage". So maybe "color.coreUsage" (a
> "color.core.usage" would squat on any future "color.core.usage.<slot>"
> (i.e. there's no 4-level keys)>
>
> > Making it opt-in is even better, but it is my personal taste.
>
> *nod*. I'll see how it turns out. FWIW I think that it's probably too
> over-colored to do:
>
>     <RED>fatal: the message</RED>
>
> And it's probably better to just do:
>
>     <RED>fatal</RED>: the message
>
> But I'll see once we have actual examples. The advice output is
> fully-colored now. I.e. "hint: message", not just the "hint" part...

As a minor bikeshedding datapoint, a script I wrote a few years ago
highlights outdated entries in a larger output. The highlighting is
applied only to a single word ("outdated") on one line related to the
item, and I found that my eye would regularly glide right over the
highlighting in the somewhat voluminous output without ever seeing the
highlight. Very recently, I changed it to highlight the entire line,
and that has helped me take more notice of it (though, admittedly, I
still sometimes still overlook the highlighted item).
