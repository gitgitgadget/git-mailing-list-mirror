Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50AF1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 04:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfBTEhV (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 23:37:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55935 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfBTEhV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 23:37:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id q187so5134562wme.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 20:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=YnicO3d8lelJtCnnMBMfvI1fLiA+ILy1xW10wcBUs+A=;
        b=gZAcqzKFEG8vUj4FkLforAUcZTmrXrxY9yGdYHdnnRIGS/7Qmy/YwoZSquGMf79AXL
         ZQ33PP4dIDy4kitmlCgcGdgMW0RH+oeV05bDNlTmNud4llHPNN/nLnHQacAz5o4yS3yJ
         /emXyzWgLt42t5UvHSCq0nValpSvJeD6t+SwsTmmHxWU3g1zPlPOQnMUYOGJRvjwbIqj
         7AV+zhk7XEsCKxwlJkhU/alXFx2VC7Yc9QawzqRedhjgETwBGO3NozgD0DWHUFIcAZoe
         d99kHBRuzvuq5AFu7lnCq89LxNhs1QUkaFHghE1GoylokU9BKAQurXuG/ji+KXksM1yj
         KjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=YnicO3d8lelJtCnnMBMfvI1fLiA+ILy1xW10wcBUs+A=;
        b=QoZpIPhJ+ov5Czk/CwE0vejEC6wrATKoh8M8MYsPUM0SuIiIsMrhuX/3Rg5DCbKuWq
         54v8zXvs2uGAgzOg+e6hWQmp0tdihR216OQSHnTiy6pW61+IqStin40XtanjKFrHOrs4
         FrC4kgCC48T4HVgikZ4WTQyX6/XuffxGDvjvCe5Xvcb2WGayVTmU/CC3TPPCLHIhcy0C
         z8t8PNUx9DyE3yuzt91Kq2b7siqp6YUocL9vl94J36e0tpTenLRC6uj3TByUFIKH4Cbn
         X5lZYFq3YQtsEAxA3EDBQfwFzdBsbzHSuT8VSWdu4ODaYj/+Jfntq3UwSycpC0ZrL32c
         0xiA==
X-Gm-Message-State: AHQUAub/gqj4bqypWlIuVaMMU8dvOBlMNvnhIh05Yt35ndtTNHNRPuNe
        0x8iYAPFFwvse/uVVuS+jy0=
X-Google-Smtp-Source: AHgI3IZG3Vzulvg69AGztk696GYOzhBV21J93vH+KisRPb/GJp4XXSMsFQw40CLQdfI5Gx6+FroG7Q==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr3579996wmm.103.1550637437695;
        Tue, 19 Feb 2019 20:37:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n129sm1053285wmf.21.2019.02.19.20.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 20:37:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
        <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
        <20190208113059.GV10587@szeder.dev>
        <20190210221712.GA9241@hank.intra.tgummerer.com>
        <20190211011306.GA31807@szeder.dev>
        <20190212231837.GI6085@hank.intra.tgummerer.com>
        <20190219002336.GN1622@szeder.dev>
        <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
        <20190219235913.GM6085@hank.intra.tgummerer.com>
Date:   Tue, 19 Feb 2019 20:37:15 -0800
Message-ID: <xmqqmumrvzwk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> Now, I seriously believe that we missed the best time to move
>> ps/stash-in-c into `next` for cooking. The best time would have been just
>> ...
>> Anyway, that's my plan for now.
>
> I must say I am not very happy about this plan.  The series has been
> marked as "Will merge to 'next'" in previous iterations, but then we
> found some issues that prevented that.  However I thought we were fine
> fixing those on top at this point, rather than starting with a new
> iteration again.

First before going into anything else, let me thank, and let me
invite readers of this thread to join me thanking, Paul (Sebi) for
sticking with this topic for this long.  It is above and beyond what
GSoC calls for.

Having said that.

I too was somehow led to believe that the topic was in a good enough
shape, with some room for clean-up by reordering the patches to make
them into a more logical progression and squashing an existing and
recently figured out "oops, that was wrong" fixes into the patches
where the breakages originate.

And that was where the "Will merge to" originally came from.  Thanks
to tools like range-diff, a topic that goes through such reordering
and squashing of patches should not have to "waste" a lot of review
cycles out of those who have seen the previous round.

It however is a totally different matter if the topic was so
unsalvageable that it needs a total rewrite---that would need
another round of careful review, of course, and it would be
irresponsive to merge a topic in such a messy state to 'next'.  But
my impression was that the topic was not _that_ bad, so Dscho's
message and the plan were something that was totally unexpected to
me, too..

> I was always under the impression that once the problem that was
> discovered here was fixed we'd advance the series to 'next' with the
> patch that comes out of this discussion on top.  Whether it's in next
> shortly before 2.21 or not doesn't seem to make much of a difference
> to me, as this wasn't going to make the 2.21 release anyway.  My hope
> was that we could get it into 'next' shortly after 2.21 is released to
> get the series some further exposure (which may well turn up some
> other issues that we are not aware of yet, but such is the life of
> software).

I was hoping similar, but also was hoping that people would use the
time wisely while waiting for the next cycle to polish the topic with
reordering and squashing, so that it can hit 'next' early once the
tree opens.

Anyway.

I actually have a different issue with this topic, though.  It is
wonderful to see a GSoC student's continued involvement in the
project, but it is not healthy that we need so much work on top of
what was marked "done" at the end of the GSoC period.  Especially
the impression I am getting for the post GSoC work of this topic is
not "we are already done converting to built-in during GSoC, and now
we are extending the command", but "we ran out of time during GSoC;
here is what we would have seen at the end of GSoC in an ideal
world."

I wonder if this is an unfortunate indication that our expectation
is unrealistically high when we accept students' applications.
Being overly ambitious is *not* students' fault, but those of us on
the list, especially those who mentor, have far deeper experience
with how our code and project is structured than any students do.
We should be able to, and should not hesitate to, say things like
"that's overly ambitious---for such and such, you'd need to even
invent an internal API---can we reduce the scope and still produce a
useful end result?"

One suggestion I have is to have success criteria (e.g. "gets merged
to 'master' before GSoC ends" [*1*]) clearly spelled out in the
application.  Something like that would help managing the
expectation and biting way too much for a summer, I'd hope.

    Side note *1*.  Of course, depending on the alignment of the
    stars ^W our ~10-12 week development cycle and the end of GSoC,
    getting merged to 'master' might become impossible if it
    coincides with the pre-release freeze period.  But we on the
    list and the mentors know how the project works, and can help
    stating a more realistic success criterion if the development
    cycle and other quirks specific to this project gets in the way.

Thanks.
