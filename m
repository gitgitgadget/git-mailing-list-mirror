Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27091F597
	for <e@80x24.org>; Wed, 25 Jul 2018 17:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbeGYSmM (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 14:42:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46288 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbeGYSmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 14:42:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so8137023wrw.13
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lRi8kYbUTnJBZLo8/jMXqxWBPkgyaqfL6zuE/dL+WG0=;
        b=e8xM15lo/XaGzAu8kenRRUnYUHN7R1poS2yiYp5CECpngvw2qvOjCoNWqzgieuJqgq
         9r7nC6bPd6goxfpJjm+wComY/UyXuDswNxR0BqU7qeks7tmERopfJDrtFTI3Ax9BMAhe
         aSA2Pk3jQdlgVqYfsV5vqgAJVIxZ413w4KlXyAMzQwV87Wx4U59lOmLg2pKRZHx/sdpK
         AcT41TnfFNZHf2uohmTmD8blA5PvdjXVypolsK09SfhvOEp2Mu9QXNyAVzclu0vg8hXb
         tC9J1uuyvuYDgmkMcmSuYXX/ZfxSuG3hW0BVpNecfxMqn8A4ZpD0QxwdQNYEfdAbtDLw
         h9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lRi8kYbUTnJBZLo8/jMXqxWBPkgyaqfL6zuE/dL+WG0=;
        b=UvDiGc1tHWOWkN+WsMtEO/kJPukh0Ylvx+Y7xLZR61BDqhM0NHeLRIy8VcF+TRjQSE
         dzz0lntzhWOMUfm4LYTARmgWzWu6k0JJPvDcgnYcSrucaSpte8vPtzrtjadbk7hun46S
         qvwHedIU0+jds44P/cW3oLuJKR1A37N3+1bMYgcblbew0tnzoV01mJvvADfNNaNJd4Tq
         LmNM5sCWl2ApUJFGk17MH8KeZHLrMeo2PX/2NNNKquoXmxbXUsNza5oB183f5rrQ+92B
         h14YxlZVhhY9WfLFNMyMPp4fDXe5etWig8Lwd1jQJ4RBuTKzq6p2uAs/81xuF1R3dDaL
         12Vg==
X-Gm-Message-State: AOUpUlEyCSCqlRhBzywHc3fIWqB70/AGsUWxJvLpqizWWo2Ti1F6Hyj3
        MqAdn4Yl6Dk9J8quqV1FKc4=
X-Google-Smtp-Source: AAOMgpftjTNG4dKd064YzOCdHYK9CSiNcD6eOS4jOrFYiRMEb6PabuxWh74W2HtAtf4pdejDVaCHNA==
X-Received: by 2002:a5d:4410:: with SMTP id z16-v6mr15536060wrq.272.1532539772175;
        Wed, 25 Jul 2018 10:29:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j3-v6sm18675893wrt.70.2018.07.25.10.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:29:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 10/14] format-patch: add --range-diff option to embed diff in cover letter
References: <20180722095717.17912-1-sunshine@sunshineco.com>
        <20180722095717.17912-11-sunshine@sunshineco.com>
        <CACsJy8AOeiKp2JnG0h9mw40TdsNft80vUu573ORtqKMor7B+vw@mail.gmail.com>
        <CAPig+cT_7eDyY6xGev4=dwpJnKufpMevO-+hGnXVt4ec0xhEiA@mail.gmail.com>
Date:   Wed, 25 Jul 2018 10:29:30 -0700
In-Reply-To: <CAPig+cT_7eDyY6xGev4=dwpJnKufpMevO-+hGnXVt4ec0xhEiA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 23 Jul 2018 15:58:49 -0400")
Message-ID: <xmqqva93usud.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jul 23, 2018 at 12:28 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Jul 22, 2018 at 11:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
>> > index f8a061794d..e7f404be3d 100644
>> > --- a/Documentation/git-format-patch.txt
>> > +++ b/Documentation/git-format-patch.txt
>> > @@ -24,6 +24,7 @@ SYNOPSIS
>> >                    [--to=<email>] [--cc=<email>]
>> >                    [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
>> >                    [--interdiff=<previous>]
>> > +                  [--range-diff=<previous>]
>>
>> I wonder if people will use both --interdiff=<rev> and
>> --range-diff=<rev> often enough to justify a shortcut
>> "--all-kinds-of-diff=<rev>" so that we don't have to type <previous>
>> twice. But I guess we don't have to worry about this right now.
>
> My original thought was that --interdiff and --range-diff would be
> mutually exclusive, however, I quickly realized that some people might
> like to use both options together since each format has its strengths
> and weaknesses. (I've used both types of diffs together when preparing
> rerolls of my own series and found that, together, they provided a
> better picture of the reroll than either would have alone.)
>
> Based upon experience on this mailing list, I'd guess that most people
> would use only one or the other, though that doesn't speak for other
> projects. And, as you note, it's something that can be added later if
> warranted (plus, this series is already long and I'd like to avoid
> making it longer for something like this whose value is only
> speculative).

A few random thoughts.

 * I find it somewhat disturbing that use of dash is inconsistent
   between "--interdiff=<arg>" and "--range-diff=<arg>".

 * Perhaps "--interdiff=<previous> --range-diff" may be a possible
   way to say "use the same <previous> and show both"?  Do we want
   "--range-diff=<previous> --interdiff" to mean the same two
   meta-diff but shown in different order?

 * Do we expect that we may find a third-kind of "meta-diff" that
   sits next to interdiff and range-diff in the future?  I *think*
   two separate options "--interdiff=..." and "--range-diff=..." is
   still a good way forward, and we'd add "--frotzdiff=..." when
   such a third-kind of "meta-diff" turns out to be useful, without
   fearing proliferation of options, and that would be OK, but I am
   just thinking aloud to see if other people have better ideas.


