Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786461F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbeGWWjU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:39:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56048 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbeGWWjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:39:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so497951wmc.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uegvzl+mH0iLxi20wNmyCCvdfVJwy7K0mRuC4Il0xl8=;
        b=Cer9BNFHIZQ7UJCU+ybCuvIDDHImtPYVrGfgqwu11XSdVs1fj8gonR9JjxrvC+FYt1
         tlrttDSLufAwByOZ8sGIAIkuwIxzeI9ffCAL1YOL5Sl83K0A97PlzhwsmMPJiiYTNbaq
         oEB1utGUPgoYs528aFu0ZYUVIy5HvC+z17ecbTkYGv7PYUUgT7cv1ttcvJIC34yWfHz7
         HNUrUzIHYrfgFYo+coE4PATlEkiEF+Y4d+lTg+ltdtgscvfM56pCoDjRcP6huL2WLDhc
         PyqLKYCf67BHVFc8gX9mgVM1poynmJvLwt97MKIqIC8HWDkTvP80EE35+VRsQqEgW4kL
         UX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uegvzl+mH0iLxi20wNmyCCvdfVJwy7K0mRuC4Il0xl8=;
        b=pjkSlaPp+ypE3p4S15cPMzei8ewZhxwJiF25PB+F/FdafZmEUksX5X/cOxQ9EWfV81
         HmKKanJQqh0+kG54Lf2MX1Zb9N2OkP/vVt6QtaAv4pdNjMM9WtwARWqKAtOw0ZIYPHxX
         zpOokDyutnTCBBO0eRoDDs/TnbDVf22Wip0P6ZQ11Ge6uuIXwlcXxl/iMTYDLWsZL7SF
         bRNAuer0UKEZT2lPpT+kwPZv+/DY7QDcjYOpoly2pi09sNM4tIuNz764n5hWwYnviwAl
         wgrmyyplCvRQMbkWnjjDffdLiOWPkx5vCcxzGZ+Af7CyOUtuoVqFGQHZ93xzMNO0Q8Do
         rNeg==
X-Gm-Message-State: AOUpUlH8J2oRSeOki1WEBd/KCeWr/6lAK+Lpjb2PIfFCwzyAgbnpNQST
        8HXRzGE6nqDQ+dHslQqckcc=
X-Google-Smtp-Source: AAOMgpf05we2yQcBkv9xpE3fPHtV/9fAi9z93ooywVmy9QSKn+h1UZDtw7RIr4lf5HTbPdLIcrcuUA==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr335918wme.13.1532381769358;
        Mon, 23 Jul 2018 14:36:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t9-v6sm12574860wra.62.2018.07.23.14.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:36:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/14] format-patch: add --interdiff option to embed diff in cover letter
References: <20180722095717.17912-1-sunshine@sunshineco.com>
        <20180722095717.17912-3-sunshine@sunshineco.com>
        <CACsJy8C8RK6HkfoEYJGZg=sgtJS0WksHD3=7Souw3jYebRo=Sg@mail.gmail.com>
        <CAPig+cRsPV+PGtkEM_c1b4P-NF7Dk7A8DvPVuvdbx4ESr3pmqg@mail.gmail.com>
Date:   Mon, 23 Jul 2018 14:36:08 -0700
In-Reply-To: <CAPig+cRsPV+PGtkEM_c1b4P-NF7Dk7A8DvPVuvdbx4ESr3pmqg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 23 Jul 2018 15:18:14 -0400")
Message-ID: <xmqqh8kp4otz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jul 23, 2018 at 12:03 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Jul 22, 2018 at 11:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > @@ -0,0 +1,17 @@
>> > +void show_interdiff(struct rev_info *rev)
>> > +{
>> > +       struct diff_options opts;
>> > +
>> > +       memcpy(&opts, &rev->diffopt, sizeof(opts));
>> > +       opts.output_format = DIFF_FORMAT_PATCH;
>> > +       diff_setup_done(&opts);
>> > +
>> > +       diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);
>> > +       diffcore_std(&opts);
>> > +       diff_flush(&opts);
>> > +}
>>
>> Is it worth adding a new file just for a single function? I haven't
>> read the rest of the series, but the cover letter's diffstat suggests
>> this is it. Is interdiff intended to become a lot more complicated in
>> the future? If not maybe just add this function in diff-lib.c
>
> Good question. The functionality originally lived in builtin/log.c but
> moved to log-tree.c when I added the ability to embed an interdiff in
> a single patch. However, it didn't "feel" right in log-tree.c, so I
> moved it to its own file to mirror how the range-diff engine resides
> in its own file.

> And, the function actually did several more things as originally
> implemented. For instance, it took care of not clobbering global
> diff-queue state, and consulting 'reroll_count' and printing the
> "Interdiff:" header, but those bits eventually moved to live at more
> "correct" locations, leaving this relatively minimal function behind.
> It does get a bit more complex in a later patch, but not significantly
> so.
>
> I wasn't aware of diff-lib.c, but it does seem like show_interdiff()
> could be at home there.

Yeah, diff-lib.c is meant to be a home for the implementation of low
level "diff-{files,tree,index}" plumbing that can be called from
other routines; if you are adding "take two things, compare them"
that can be reused from places, then it is a good match.
