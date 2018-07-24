Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180471F597
	for <e@80x24.org>; Tue, 24 Jul 2018 22:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeGYAHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 20:07:45 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35785 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbeGYAHp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 20:07:45 -0400
Received: by mail-it0-f48.google.com with SMTP id q20-v6so6117931ith.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 15:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hy2Mqx0K49wo1bTGA4wfWueFDCx0ylY6SPY7jryjAvQ=;
        b=atBl/JM4qLBJw5of6uwEL/qsDgSoatDTARC5UfTWW5h9kL5U5Bng8v+idRFSo7vCKI
         SqAhHSTkOuqFkftmGmFMoIjzJ3smwJOOVinmDMU/eo2jZUum2n/KP+ne2F2bTggI3zy3
         1I8ZDue6/NS6xd1dRKzveCCIG1As47lVlk+sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hy2Mqx0K49wo1bTGA4wfWueFDCx0ylY6SPY7jryjAvQ=;
        b=Juwi53PXB79JYGG1lhbrimQOmdKkQuMKuN/L0hnQ1/pCFA0Z4scEDEFHvC+UPuii6E
         TarHWcpv7XKC7XNwX6zCs0TDzeMwbwMMB8D8Q9ekKNkYuUSUPNZKrDU4x+DW8XnqxIE7
         ix7pGxKFkeCpohA4KXiMpDzoSNenbXeAU59iYa4H0BXZnRqId+mfgMKeIAaW7UtgZ7HY
         ZVvEaVH1ykkjXBJvm6rzkoZ+tEtap6I5hOgXYYSoEMBE5o2cltD4fDuer6viU+i9Snvz
         w6YLm1xsjk433GH8g5JhpCZJAEeLOi31JIJlSNSJKZPf3yRNkvcFCgyxY3oqYqP12wRq
         Eg3w==
X-Gm-Message-State: AOUpUlHRq1a79+KiHcGbPcgpZDYMLIfVfGG4vhx+GY3UUaH4DaSDzELT
        3ZjjNOe1kCjI2/oQQNCgbJ0rYusE/zRmPnRfgL3vvat9
X-Google-Smtp-Source: AAOMgpcKV/W0gLAccyvR+A8S+NOJlmw62pnE95eXTQlk9QUs62vRQvXUOKqZZMKmez3ZU0+d/oZ94lCN5xsFemwKNsU=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr4334568itb.16.1532473141199;
 Tue, 24 Jul 2018 15:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
 <alpine.LFD.2.21.999.1807071502260.18818@i7.lan> <xmqqtvoowbgi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvoowbgi.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 15:58:50 -0700
Message-ID: <CA+55aFyXRyBvpq5Yvjg8=m6fdMRO4fdpDjW=bD4Kryo-goSDJA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Add 'human' date format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 2:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> But lack of TZ does not give me enough hint about which content it
> happened.  The fact that this was done late at night on weekend is
> indeed interesting, and I may not care what time it locally was for
> me, so perhaps this is an intended behaviour.

I'm not sure you could call it "intended". The TZ hiding did change as
I was playing with this.

The first version of the patch only hid the timezone if it matched the
current one.

Because, as you say, the time zone can be interesting not so much
because you care about *when* the commit happened, but you care about
*where* the commit happened. And that can be true even if the commit
is very old.

So the timezone data in some sense isn't necessarily about the date at all.

When I used it a bit more (I still have the "--date=auto" as my
default for the kernel), I decided I really don't much care about the
timezone. In any _individual_ case, the timezone looks fine, but when
you look at many different dates, it looks really odd how it sometimes
shows, and sometimes does not, particularly for old dates when it
really doesn't matter for the *time* reason.

So I decided that it's better to not show the timezone at all when you
show a real date.

But honestly, I don't claim to have a really strong argument. It's
just a choice. Nothing says it's the absolute right choice.

I pointed out that you can use "--date=human-local" to get an even
denser representation that gives you the human date without ever
having a TZ. But we don't have the reverse of "-local", which would
explicitly show the timezones.

Again, I think this is really because the timezone is about something
other than just the time. I think the "do we care *where* it was done
or not?" question in many ways is entirely independent of the time
question.

So right now the patch says

                hide.tz |= !hide.date;

which ends up being good for the "times are roughly the same size"
(which I decided was a good thing - again, I don't really have a
hugely strong argument for it, it was a matter of me playing with
options).

But it would make equally much sense to say

                hide.tz |= hide.time;

and just say that the timezone is hidden if it matches the current
one, or if the commit is just so old that we don't show the time at
all.

OR you could just say "timezone is always interesting, because you
want to know _where_ it was done regardless of _when_ it was done",
and just not hide the timezone at all.

I think all are "technically valid" choices to make. The one I made
was just a random personal preference, not necessarily the right one.

Could we extend on the "decorations" (like the "-local" thing)?
Absolutely.  I'm not sure it's worth doing, but it would certainly
solve the "different people have different preferences" issue.

I think that *if* we want to extend on the decorations, that would
probably still be a separate patch from the basic patch.

               Linus
