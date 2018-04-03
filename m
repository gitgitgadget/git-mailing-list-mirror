Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24C71F404
	for <e@80x24.org>; Tue,  3 Apr 2018 20:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeDCUoc (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 16:44:32 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:54662 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeDCUob (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 16:44:31 -0400
Received: by mail-wm0-f42.google.com with SMTP id r191so5524403wmg.4
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vSCMpKbg1s7U5955i9XTIZTNYjgrMMNKL38LY3gx54M=;
        b=fPpURass74+bg6llLZ18t67UKTIpvqw1qw9qd20EzQF0oWkJbk5Tvir36NAFVqhwRE
         I0BCp3oSAVopVCxeDYdHF+DOqsff9BwpEhzD4LqqitgjD3ldWq7FQ5d01MIggbqGLJAC
         Z1eY0csIpMQcG0DjdKg+jsMsRii1EwWuUFECXxAsxcRUxKw+PYpZCnEy4B/k6vPHMNEJ
         e4RiQkeaXhMBzXBmEdv5dmxcLmIlxKNoyjB+kRnIL9dz3ZwsdH8g0hBl4UAbg65o6DQY
         9Wfx2zITiOt+jvRxE1czeOgRmK4GcY2xoCSCfdlEwoJko4h5z8l2CwRoedOQgcUrdDdc
         TnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vSCMpKbg1s7U5955i9XTIZTNYjgrMMNKL38LY3gx54M=;
        b=tjjIWFUkPaD+8a5wJph6wnnx48k40nUVvm4UFd4ObHfFcTVJczEDp7S5Cseyh4ynEW
         aP5KsyQ/7U6F6/oOfc0hez4Hw26uhBDslNFGNi1/U5v06EbWJUhuIFaGxqN4pVoaw+Zi
         AzTeHeV61sdbzc/VYA/owMd57aroNfMmEliTOq9yfRTDr3wqM4KN5IFidz8VHtn1x6vC
         LaHIgOb9L617TGNhxJyUDvg6GUw1pAemJPgbv6W4UrjOUnO9XzRoBU3DuRacmruuEOeT
         EhoEAmJmT0dLQpv4cM3vuGlE1HQcn2OEwOeDb9uB/vVAah6pQ7hM5syziwO7zQkSOr8p
         jbFw==
X-Gm-Message-State: AElRT7GnyyXSFnmALATK5lA1yNI5xi4sVnfdllwdpzTswKOBOx1R/XiY
        nCFBZNfmje64/+Pql5oTd8Q=
X-Google-Smtp-Source: AIpwx4/PYQgMMq2h9deD6hLeaMarcMEDdJ3KBNFtxC9jYtPx/mzLpKAs9LmIIsr4VWoacz73g79xkQ==
X-Received: by 10.80.130.67 with SMTP id 61mr17869076edf.184.1522788269930;
        Tue, 03 Apr 2018 13:44:29 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id m7sm2318962eda.36.2018.04.03.13.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 13:44:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Simon Ruderich <simon@ruderich.org>, git <git@vger.kernel.org>
Subject: Re: [PATCH 5/7] diff.c: refactor internal representation for coloring moved code
References: <20180402224854.86922-1-sbeller@google.com>
        <20180402224854.86922-6-sbeller@google.com>
        <87o9j0uljo.fsf@evledraar.gmail.com>
        <CAGZ79kaQV-F0by52fbv3fmOH_ZVMU6u=KOkJFxALyHHaH2Enfw@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAGZ79kaQV-F0by52fbv3fmOH_ZVMU6u=KOkJFxALyHHaH2Enfw@mail.gmail.com>
Date:   Tue, 03 Apr 2018 22:44:28 +0200
Message-ID: <87muykuij7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 03 2018, Stefan Beller wrote:

> On Tue, Apr 3, 2018 at 12:39 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Mon, Apr 02 2018, Stefan Beller wrote:
>>
>>> At the time the move coloring was implemented we thought an enum of modes
>>> is the best to configure this feature.  However as we want to tack on new
>>> features, the enum would grow exponentially.
>>>
>>> Refactor the code such that features are enabled via bits. Currently we can
>>> * activate the move detection,
>>> * enable the block detection on top, and
>>> * enable the dimming inside a block, though this could be done without
>>>   block detection as well (mode "plain, dimmed")
>>>
>>> Choose the flags to not be at bit position 2,3,4 as the next patch
>>> will occupy these.
>>
>> When I've been playing with colorMoved the thing I've found really
>> confusing is that the current config has confused two completely
>> unrelated things (at least, from a user perspective), what underlying
>> algorithm you use, and how the colors look.
>
> Not sure I follow. The colors are in color.diff.X and the algorithm is in
> diff.colorMoved, whereas some colors are reused for different algorithms?
>
>>
>> I was helping someone at work the other day where they were trying:
>>
>>     git -c color.diff.new="green bold" \
>>         -c color.diff.old="red bold" \
>>         -c color.diff.newMoved="green" \
>>         -c color.diff.oldMoved="red" \
>>         -c diff.colorMoved=plain show <commit>
>>
>> But what gave better results was:
>>
>>     git -c color.diff.new="green bold" \
>>         -c color.diff.old="red bold" \
>>         -c color.diff.newMoved="green" \
>>         -c color.diff.oldMoved="red" \
>>         -c diff.colorMoved=zebra \
>>         -c color.diff.oldMovedAlternative=red \
>>         -c color.diff.newMovedAlternative=green show <commit>
>>
>> I don't have a public test commit to share (sorry), but I have an
>> internal example where "plain" will consider a thing as falling under
>> color.diff.old OR color.diff.oldMoved, but zebra will consider that
>> whole part only color.diff.old.
>
> What do you mean by "OR" ?
> Is the hunk present multiple times and colored one or the other way?
> Is it colored differently in different invocations of Git?
> Is one hunk mixing up both colors?
>
> Is the hunk "small" ?
> small hunks are un-colored, to avoid showing empty lines
> or closing braces as moved. But plain mode ignores this heuristic.
>
>> I see now that that might be since only the "zebra" supports the
>> *Alternative that it ends up "stealing" chunks from something that would
>> have otherwise been classified differently, so I have no idea if there's
>> an easy "solution", or if it's even a problem.
>
> Can you describe the issue more to see if it is a problem?
> (It sounds like a problem in the documentation/UX to me already
> as the docs could not tell you what to expect)
>
>> Sorry about being vague, I just dug this up from some old notes now
>> after this patch jolted my memory about it.

Forget about what I said so far, sorry, that was a really shitty
report. I dug into this a bit more and here's a better one.

I still can't share the actual diff I have in front of me (internal
code).

Currently we have plain, zebra & dimmed_zebra, and zebra is the
default.

I got an internal report from someone who had, because zebra looked
crappy in his terminal, moved to "plain", and was reporting getting
worse moved diffs as a result.

I found that there's essentially a missing setting between "plain" and
"zebra", in git command terms:

    # The "plain" setting
    git -c diff.colorMoved=true \
        -c diff.colorMoved=plain \
        show <commit>

    # We don't have this, it's "plain" but with "zebra" heuristics,
    # plain_zebra?
    git -c diff.colorMoved=true \
        -c color.diff.oldMovedAlternative="bold magenta" \
        -c color.diff.newMovedAlternative="bold yellow" \
        -c diff.colorMoved=zebra \
        show <commit>

    # The "zebra" setting.
    git -c diff.colorMoved=true \
        -c diff.colorMoved=zebra \
        show <commit>

Which is what I mean by the current config conflating two (to me)
unrelated things. One is how we, via any method, detect what's moved or
not, and the other is what color/format we use to present this to the
user.

You can feed that plain_zebra invocation input where it'll color-wise
produce something that looks *almost* like "plain", but will differ (and
usually be better) in what lines it decides to show as moved, which of
course is due to *MovedAlternative.
