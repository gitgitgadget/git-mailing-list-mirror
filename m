Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9D3C48BDF
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 01:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EF3611B0
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 01:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhFUBXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 21:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFUBXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 21:23:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F1C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 18:21:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hz1so3340133ejc.1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 18:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vVlFfoCgphkiTHuIfbu0yR/SfE+jQSnDEVWXkyYScF4=;
        b=rSx7KqtWbk2vamLDubSGaiybMFrC6HDNLgFE6r+gkcSUfxuhjNz8gH+QnYIJrwSp2H
         clnfyiRdsdsX6vUH+4TYOUq7FkDC2g6HFy8Mmc4guvakmU/qnk/HqNrsIMAwS/SKFCSV
         IiXqGRRztXHds34WjLZyvNgeVR2EsuulZZdaaOBv8bjW6nPnoK287i6Ps6Q74HgPEc/u
         iGChoPpnVpV+RU3e9Hluj1Qs9j8o3VM2HtDTbTLu/Cf7KCFqMqqXja4emEBjgGyNTmRG
         F6pUDJM1xQM1LW0/77u2djNlnRrXtq4keTUXRy+b5QcDuj8DY8Q/i2mk+rwWea5cVY+u
         24hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vVlFfoCgphkiTHuIfbu0yR/SfE+jQSnDEVWXkyYScF4=;
        b=VUh11Y8DJGmtsHeHloo1TkdNANymmX43rFlRhjnshRJcUOv4Eq3XCtDT8QdVcFc/+7
         sqRwGitbjHLF0EmDRxJTWf4TeONuydwHMjDuXSDDn5o7dCVaGoAELfu0vhpE8P665tfb
         nxKkHmiV4zpxHDKsF+6pQOU9dCKcAsvKSB0M32fYrp4++hsCAyuNGk/zLA3qxPH9QOOi
         y5Jq4AElqPN4ds5s8X9ObiQnwiSJe51t665EDd+cQsFsKZWpKn+dV9GPG+ExYxB9E0Ri
         4OXY1+WFc0u0R0iEbL5HVeXepQub+LruzhqVvDhlhWRRmgL2QOB57+vvp6c54wAZsK3a
         n/lg==
X-Gm-Message-State: AOAM53113MJr/wMYj/n8pTISqrj1wXn+iVlRk7xxLZiJJG6NiF2QIfkB
        tvdFP0EJHS+xTyqQVkWMqqbnOit8fdA=
X-Google-Smtp-Source: ABdhPJxygZFRLi8PL41wZTHOYgfIZea+3FThZpfwgL9H+A2+c6ut90H28oGge9DwqyG51JVUNyR5rA==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr22109488ejg.110.1624238469249;
        Sun, 20 Jun 2021 18:21:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v28sm3527572ejk.84.2021.06.20.18.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 18:21:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/7] progress: verify progress counters in the test suite
Date:   Mon, 21 Jun 2021 02:59:53 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210620200303.2328957-1-szeder.dev@gmail.com>
Message-ID: <874kds3tdn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 20 2021, SZEDER G=C3=A1bor wrote:

> Splitting off from:
>
>   https://public-inbox.org/git/cover-0.2-0000000000-20210607T144206Z-avar=
ab@gmail.com/T/#me5d3176914d4268fd9f2a96fc63f4e41beb26bd6
>
> On Tue, Jun 08, 2021 at 06:14:42PM +0200, Ren=C3=A9 Scharfe wrote:
>> I wonder (only in a semi-curious way, though) if we can detect
>> off-by-one errors by adding an assertion to display_progress() that
>> requires the first update to have the value 0, and in stop_progress()
>> one that requires the previous display_progress() call to have a value
>> equal to the total number of work items.  Not sure it'd be worth the
>> hassle..
>
> I fixed and reported a number of bogus progress lines in the past, the
> last one during v2.31.0-rc phase, so I've looked into whether progress
> counters could be automatically validated in our tests, and came up
> with these patches a few months ago.  It turned out that progress
> counters can be checked easily and transparently in case of progress
> lines that are shown in the tests, i.e. that are shown even when
> stderr is not a terminal or are forced with '--progress'.  (In other
> cases it's still fairly easy but not quite transparent, as I think we
> need changes to the progress API; more on that later in a separate
> series.)

I've also been working on some progress.[ch] patches that are mostly
finished, and I'm some 20 patches in at the moment. I wasn't sure about
whether to send an alternate 20-patch "let's do this (mostly) instead?"
series, hence this message.

Much of what you're doing here becomes easier after that series,
e.g. your global process struct in 2/7 is something I ended up
implementing as part of a general feature to allow progress to be driven
by either display_progress() *or* the signal handler itself.

Thus we can show a "stalled" message if we run start(), but hang before
we ever call display_progress(), as we do on e.g. git.git in gc's
"Enumerating Objects" phase (at least on my laptop).

So e.g. your 2/7 becomes a general hard assertion, not some test-only
mode.

After that I use the same facility to implement a mode where any signal
can update a new "spinner" part of the progress bar. So let's say you're
hanging on item 1/3 and not calling display_progress() at all, we'll
update a spinner on each signal to show the user that git itself isn't
hanging, just working.

I could also rebase on yours, but much of it would be rewriting the
test-only code to be more generalized, perhaps it's easier if we start
going for the more generalized solution first.

Per some of what I mentioned in the thread you linked to I'm a bit
uncomfortable with the direction in your 1/7. I seems it works in-tree
for now, but I'd like to take the progress.c API in the direction of a
more generally useful API, not just something that narrowly fits the
exact set of current use-cases.

There's a lot of potential uses in-tree where the total not matching at
the end is just something that happens due to real-world fuzzyness,
e.g. the unlink() example here:
https://public-inbox.org/git/87lf7k2bem.fsf@evledraar.gmail.com/

Perhaps we can just have it BUG() for now as you're doing and cross that
bridge when we come to it. I just wonder if we can't catch potential
bugs in a more gentle way somehow.

> These checks did uncover a couple of buggy progress lines which are
> fixed in this series as well, but I'm not sure that the fix presented
> in patch 6 is the right approach, hence the RFC.

The approach in 6/7 will also have the effect of not balancing a trace2
start/stop region. Quoting a line from its commit message:

    > Arguably, it is wrong to show "done" at the end of the progress
    > line when not all work was done.

I think for a more general API it makes sense to think of "done" as a
different state than "we have reached =3D=3D total". The target may change
as in the unlink() example, or we may simply decide to abort and "be
done early".
