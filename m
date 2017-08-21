Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2211D208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 18:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753662AbdHUSVP (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 14:21:15 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34846 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753644AbdHUSVO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 14:21:14 -0400
Received: by mail-pg0-f44.google.com with SMTP id u191so29844554pgc.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CEtT0xbgIAW5aj/LY+J4hqiGXTQfjg/P/NFXTG+quD4=;
        b=DJowIbKteYeLvpa0b2jK2Mo7leTENhW1nsdMeDebPhdILHH+nZ5SbOeN5E0LYPIVtG
         tJ3WLojMPDweawxn8rvmkxDJ7pwuRne9E+LLil4tCBkf+JuRlfPOZeRn+ATyRAgYFZg0
         lN9b8rKeOrp1BcmB9Vew6yI5Xl5i1Gg7utqwcrsPp++smuQhSX1uKSorMga0gtr5khWo
         sWSR/ySMWXHm5rMZ9nHXy1eRtW/VT3WlK5TQiJCIZ83KOq6XXhyZLt9yUbigxRLfa5nt
         TaNrAn/GWzvtrEACz9GTRGRFwY4/s7gV+hHXS6AsWJjagkFLmGSrsK5/EaJ/BfzqaK1M
         z9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CEtT0xbgIAW5aj/LY+J4hqiGXTQfjg/P/NFXTG+quD4=;
        b=ph+tvURZwfjSN/WQcr4mg0JGrTvjy+nWM+A1GodaQpjI+QCH9Gs+VZRSbpADZxxG4E
         BwRs6+6E1keN0Ym60JorsalJZvvViZRnx+M5s2ydqpOsUp73jmhu5kjucglosF8TwjLu
         4TuVK14FGu1s8OAz3ZiicShHLnFJeCNq8NwnEjsQMEDus+pbzGKlqUMrEf2l3w7aBHUO
         9hEdsgfN5vvN/0IGOLCfNphmqaywbkycaeAoIbs/XZm6IYeYA61wztG2N+5UDU3Fz3kw
         ccQvxOd3zUtzWMzbEu5UGpDWxnr/2QuCvrIS0TlprtBYZ4fxmb6unNX0dv9Ie0Y36Byr
         SMvg==
X-Gm-Message-State: AHYfb5jUO1x7sekuyYA+h0pPCn5+A7PjnPkQaR3yYWViDfewnIZCTloz
        k9BD0mKFK9AzlN2d
X-Received: by 10.84.211.108 with SMTP id b99mr5735268pli.204.1503339673159;
        Mon, 21 Aug 2017 11:21:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:a061:aa36:11d8:7de7])
        by smtp.gmail.com with ESMTPSA id q9sm11279395pgs.45.2017.08.21.11.21.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 11:21:12 -0700 (PDT)
Date:   Mon, 21 Aug 2017 11:21:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] pull: respect submodule update configuration
Message-ID: <20170821182110.GA156514@google.com>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
 <20170818220431.22157-1-sbeller@google.com>
 <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com>
 <20170821162056.GB1618@book.hvoigt.net>
 <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com>
 <85ED93BC-1E27-4B8D-856D-090C6860BAB0@gmail.com>
 <CAGZ79kZMjGNOn0FnJGtO5gRY3rF0Eiow8n0uppTZsCUAHY+m3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZMjGNOn0FnJGtO5gRY3rF0Eiow8n0uppTZsCUAHY+m3A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/21, Stefan Beller wrote:
> On Mon, Aug 21, 2017 at 10:20 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
> >
> >> On 21 Aug 2017, at 18:55, Stefan Beller <sbeller@google.com> wrote:
> >>
> >> On Mon, Aug 21, 2017 at 9:20 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> >>
> >>>> So I am a bit curious to learn which part of this change you dislike
> >>>> and why.
> >>>
> >>> I am also curious. Isn't this the same strategy we are using in other
> >>> places?
> >>>
> >>
> >> I dislike it because the UX feels crude.  When reading the documentation,
> >> it seems to me as if submodule.<name> can be one of the following
> >>
> >>    (none, checkout, rebase, merge, !<custom-command>)
> >>
> >> This is perfect for "submodule-update", whose primary goal is
> >> to update submodules *somehow*. However other commands
> >>
> >>    git rebase --recurse
> >>    git merge --recurse
> >>    git checkout --recurse
> >>
> >> have a different primary mode of operation (note how their name
> >> is one of the modes from the set above), so it may get confusing
> >> for a user.
> >>
> >> 'none'  and '!<custom-command>' seem like they would be okay
> >> for any of the commands above but then:
> >>
> >>    git config submodule.<name>.update "!..."
> >>    git reset --hard --recurse
> >>    git status
> >>    # submodule is reported, because "!..." did not 'reset'.
> >>
> >> Anyway. That dislike is just a minor gut feeling about the UX/UI
> >> being horrible. I wrote the patch to keep the conversation going,
> >> and if it fixes Lars problem, let's take it for now.
> >
> > Well, I need just a way to disable certain Submodules completely.
> > If you show me how "git config --local submodule.sub.active false"
> > works then I don't need this patch.

Yeah if you want to completely disable a submodule (as in not even check
it out) then setting .active to false would do that.  But as stefan
pointed out and IIRC 'submodule update --init' with no pathspec sets all
submodules to be active.  Perhaps it should only init submodules who
don't already have an explicit active flag set.

> >
> > I tried to make it work here:
> > https://public-inbox.org/git/89AB8AA3-8E19-46BA-B169-D1EA4CF4ABE7@gmail.com/
> 
> (A) you need to set expect there as well, to have sub{2,4,5} be expected
> there as well.
> 
> (B) That may hint at another (UX) bug.
> 
> The test case there uses "git submodule update --init".
> The init flag will set all submodules to active.
> 
> Maybe you want
> 
>     git config submodule.active ":(exclude)sub0"
>     git config --add submodule.active ":(exclude)sub2"
>     git config --add submodule.active "."
>     # Read: anything except sub0 and sub2 are interesting
> 
>     git submodule update
>     # no init flag, needed even for new submodules IIUC

-- 
Brandon Williams
