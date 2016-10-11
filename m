Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242891F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 23:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbcJKXZj (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 19:25:39 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35271 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbcJKXZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 19:25:38 -0400
Received: by mail-qk0-f170.google.com with SMTP id z190so10831369qkc.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xoel499fCivslB+XaBoAB9LhhCCVCgf3GX3RNVolGh0=;
        b=M1Z+4XipIaAlfO/iIlYyjGfEEW035vZhUoROXcLUVewo2JsrD0j6TRx+tXu8yUFWzv
         KOlkF79FDO207J8d+P3vdhLpgp7cO8ZNGx2UzuVOjxngx4teSZ1FyFWvCQNe5ds3iF8g
         kmhPjp3Zy6WFaSQLmxrvh6vbArh9q1C6ahOuiib4+ryxMWuiMPjds3qUCt0zZ7Kh6Tmb
         XomHa79TJJHC4PUmZsfjELYO6NP7pGN8PvYRJ82QZ5WYQxltl4+JtvX54ZMr7mdzakI0
         gHpqXWGoA99f/HgYoNOn5IdsGFq9BQkgEFyT6LDaWfzTm76laQT8MVPfrBns3MWnaU4o
         nlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xoel499fCivslB+XaBoAB9LhhCCVCgf3GX3RNVolGh0=;
        b=Xyk2f8iRVSLe4gKQvKMmgNo7ff+TwM35w+6mZl2apA8ajw2clq3EC6YUtoOC/7QwjF
         EjD7S/BTWM82lKAZeAk909AnggLEcXQOOHcCYKP9wlmKzrotUK6s7TMmyvbA8YusDALi
         jgDm82OZ9XVzXlefo9HZSjdTswEyLJhC+NekhzjuImJ8bcuHdUcs8fPMqACbOrLGC/UW
         taqvrpJfV9oZ5qq6tG2eY5ryw58ysm9l5Venyy/1vWliOIAQHKD8WkZmgHHQP1RdbcpQ
         TJTifHEK2ImX8NpIeesA/3zvgzU4gBba2pucpeIOGg/0CaNx1U0B4ADijQXcljcpWw3u
         F3xQ==
X-Gm-Message-State: AA6/9RlbJp2A0PYWdaT3PLnni2wijEEM11fW8POicPjJFISJjMS3/AlAaFrB+58P4olj8l0giWIhlbN0Rn82G4OA
X-Received: by 10.55.45.193 with SMTP id t184mr5384148qkh.58.1476227896621;
 Tue, 11 Oct 2016 16:18:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 16:18:15 -0700 (PDT)
In-Reply-To: <20161011225942.tvqbbzxglvu7lldi@sigill.intra.peff.net>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
 <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
 <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com> <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
 <20161011225942.tvqbbzxglvu7lldi@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 16:18:15 -0700
Message-ID: <CAGZ79kaKOiy-HJboaujXXc66P6CLupteDw4JyPOGetREfz_q_Q@mail.gmail.com>
Subject: Re: Make `git fetch --all` parallel?
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Ram Rachum <ram@rachum.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 3:59 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 11, 2016 at 03:50:36PM -0700, Stefan Beller wrote:
>
>> I agree. Though even for implementing the "dumb" case of fetching
>> objects twice we'd have to take care of some racing issues, I would assu=
me.
>>
>> Why did you put a "sleep 2" below?
>> * a slow start to better spread load locally? (keep the workstation resp=
onsive?)
>> * a slow start to have different fetches in a different phase of the
>> fetch protocol?
>> * avoiding some subtle race?
>>
>> At the very least we would need a similar thing as Jeff recently sent fo=
r the
>> push case with objects quarantined and then made available in one go?
>
> I don't think so. The object database is perfectly happy with multiple
> simultaneous writers, and nothing impacts the have/wants until actual
> refs are written. Quarantining objects before the refs are written is an
> orthogonal concept.

If a remote advertises its tips, we'd need to look these up (clientside) to
decide if we have them, and I do not think we'd do that via a reachability
check, but via direct lookup in the object data base? So I do not quite
understand, what we gain from the atomic ref writes in e.g. remote/origin/.


> I'm not altogether convinced that parallel fetch would be that much
> faster, though.

Ok, time to present data... Let's assume a degenerate case first:
"up-to-date with all remotes" because that is easy to reproduce.

I have 14 remotes currently:

$ time git fetch --all
real 0m18.016s
user 0m2.027s
sys 0m1.235s

$ time git config --get-regexp remote.*.url |awk '{print $2}' |xargs
-P 14 -I % git fetch %
real 0m5.168s
user 0m2.312s
sys 0m1.167s

A factor of >3, so I suspect there is improvement ;)

Well just as =C3=86var pointed out, there is some improvement.

>
> I usually just do a one-off fetch of their URL in such a case, exactly
> because I _don't_ want to end up with a bunch of remotes. You can also
> mark them with skipDefaultUpdate if you only care about them
> occasionally (so you can "git fetch sbeller" when you care about it, but
> it doesn't slow down your daily "git fetch").

And I assume you don't want the remotes because it takes time to fetch and =
not
because your disk space is expensive. ;)

>
> -Peff
