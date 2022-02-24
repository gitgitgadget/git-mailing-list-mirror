Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3523C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiBXWt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiBXWtC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:49:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1852E17C42A
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:48:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x5so4914896edd.11
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gK9gOOhZ3n8O1jUbcec/ja8SWf4ESu8w/MxQ7oxx+kk=;
        b=mqNMN3JLIX3DID/RauvLCmX93+jp6qs5AE9rOkavEsSfsh/crNzu3BlwNksSsNyxb2
         p/cvs/W8XYLyftAINJAo+7avaAODzbglEphTvonaXrR9jYh0VLk4O515pFLyDp4vViNU
         TgXZ1kWLqcPZcE0PMiKezkfuTE7RZ6PexzXwpgyR5m5RNcOw98PDaZ+Qs8PMobfuuXeh
         ymVNSnPgXAfIKPkh5Q8+hcAsytmgCJeTr+vcZWRFADfkfhVW0LGg5YP469G9eN+fdwph
         255eO8RVxlmicZmOZZ2Z7/z2C/Iu7I1gT5qMjHRWP2xTV5JhvMvgzoUn79UkJJVEYXY3
         Go5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gK9gOOhZ3n8O1jUbcec/ja8SWf4ESu8w/MxQ7oxx+kk=;
        b=c8qQcgJP/0G3Uk1UruVXSHsH+Raf1x3lzgRzuyD1u1S4FAg4YoW+GmNZ4Ci8M+orZk
         5q1WlqTMUZeKtXGQSlORhZVZLzaUhfcXxOT66VpRC/irtToonb3evaJuliV8BeQbxmwE
         Rg/0OmSVpqUzYcarr+jNKLfxJoD9XWC5Tu7ZPK+8artTuARKq0D9qXJt0G+XaUAO6tfc
         /4M82szOx+3f114YGqwxLefir1S2FQkpXFXAAwx9roNFNPeZS+z5K5Rnig3DZlkA2D4n
         3NTreaTlVdv/V8MJ/7QYYs3eK941UUZtmTUCsYzXj++uAVQgME1aKTxs+RgdQ3/BhqHT
         PPaQ==
X-Gm-Message-State: AOAM532k6CtM3cDA1x/wJ+8bJ/SNmlujyaqDAEEBgtgbJ3RKEFLTphmC
        K8b3k6jaYS2D9YNN8iwZuderSSklE3WN1A==
X-Google-Smtp-Source: ABdhPJzcOAM6CBpNRXSme5D0IZjpBDqo2Oeyt6/Cs01YXw4I644clnjwUwH1an/GZS3GgAN6S8RHoA==
X-Received: by 2002:a05:6402:d0d:b0:412:d49c:74d3 with SMTP id eb13-20020a0564020d0d00b00412d49c74d3mr4390609edb.207.1645742906425;
        Thu, 24 Feb 2022 14:48:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7c38c000000b00413458d2981sm392969edq.54.2022.02.24.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:48:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNMuP-000JzP-12;
        Thu, 24 Feb 2022 23:48:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 00/12] c99: use more designated initializers
Date:   Thu, 24 Feb 2022 23:43:58 +0100
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2202242017590.11118@tvgsbejvaqbjf.bet>
 <xmqqsfs8kpm4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqsfs8kpm4.fsf@gitster.g>
Message-ID: <220224.86y21z98zr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> This is probably a bit premature given that we still are treating the
>> C99-isms as weather balloons. The idea was to keep things in an
>> easily-revertable state for at least a couple of major versions.
>>
>> The referenced changes are only in core Git as of v2.34.0, and we are not
>> even half-way through the v2.36.0 cycle.
>
> The proposed commit log messages need updating.  By refering to much
> newer commits created by the same author, instead of the beginning
> of the official weather balloon experiments, it created an unnecessary
> confusion.
>
> Read the CodingGuidelines document.  Everybody knows what it says by
> heart by now, right? ;-)
>
>    . since mid 2017 with cbc0f81d, we have been using designated
>      initializers for struct (e.g. "struct t v = { .val = 'a' };").
>
>    . since mid 2017 with 512f41cf, we have been using designated
>      initializers for array (e.g. "int array[10] = { [5] = 2 }").
>
> I do not think doing this in early 2022 is still premature.

It's hard sometimes to anticipate what'll be the best reference. I
figured linking to similar recent tree-wide changes would make it easier
for reviewers to shortcut to "oh, we had similar tree-wide changes
recently, so this is OK too".

As opposed to referencing the initial forays into designated
initializers, which wouldn't provide the same overview of how tree-wide
this pattern already is at a glance.

But sure, I can mention that more prominently/discuss both.

> I hate to having to deal with such a tree-wide churn, though.  I'd
> rather see "let's do this only on quiescent part of the tree a small
> bit at a time" like on imap-send.c but not involving anything known
> to be actively touched, like ref backends.

While these are tree-wide, I don't think you'll have any trouble with
them, including the ones touching the refs backend.

We're anticipating the final bits of the reftable integration, which
will add another declaration like the one in 2/12, but that won't
conflict with these modifications of the existing assignment.

Of course such a change might also want to use designated initializers
to match, but that would have been a good idea anyway for new code
regardless of whether this series got merged or not.
