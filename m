Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885DE1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeHNX5O (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:57:14 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33211 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHNX5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:57:14 -0400
Received: by mail-yw1-f67.google.com with SMTP id c135-v6so17328810ywa.0
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IIndzS+xAdXqHWLiI3LIOSoyDhJHxahnivShGghZPY=;
        b=bRRQWDltsYsfyg9/31Z/vSoV3gMY+tVi4LXYlXGPxpt2pPlCpxpuiF0rn6TVb92sT8
         MRA4JUBnHHkdZIq0jp1R+jl9NAI8FNHitJtW+Ke12q1W+2Ii/QPslBIbWkxJ26BEUrEm
         PwulJEF2lbvAsfy/20T8q8EtVQqk/Y9VkNp4B1GDxVugBTIePQ5VgSZB3AcFuA+64PDN
         o4dGeQpLXAPou2srB1TCppUb2NjN6qH0dqmkjRFQJADvqgHd00z+1dsq6kXg8Epk97tj
         trFh+x+3GaTXVZF2TKh81hEtkrrmyPUSBjpiaE3S0cG0m89MCvE4OGtvGH4jB9greNVW
         f1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IIndzS+xAdXqHWLiI3LIOSoyDhJHxahnivShGghZPY=;
        b=k6eS0qrqW7/d5akX7d2pjDNOvil+aUwQ+oiSRDIK5j2itvD2W1O+21mKTV8VkxuFpX
         kmU+1z3vaG7+2SmsFLNE8tTDFXRdSw+UMXTFV6lHoPhMe5pPhWNCOewdGq5U8JS258oi
         G5U7k9UF55Y2IMe92rgKLeAjsd9MKhkn1NJvAWuE2r9iO/y/hpmHoH7N90el4wyLaoYe
         88Hwzb6ESIFK89+GO+Jxug22WheVJf6Idhm0v0N19cahQSwl+b0VvUyrKIiFAzlM21B6
         TkD3QupPcem2XKPyI/YZRimnGKbaQKQX6Uqt/bmdzxhUxIqZ/CburqPSmKgTDujuf5n2
         pBcw==
X-Gm-Message-State: AOUpUlF4j1uW8YP3yQyH6vnFKiQmSQQ9alJUtfT7BBHTg8XBgo61DvUE
        rkUnxtIdfiHOAbR8r083giCc2TlfKrNerg8MhzxQng==
X-Google-Smtp-Source: AA+uWPzT19MhizcOWd2TOWBBgBB7yOA+VLyGB/YQ8vVHNW8Sci6q1vaJhw/WnuF8Bl8zXyu1I9WEHe0ugT7dZt3mwNg=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr12384889ywh.238.1534280892202;
 Tue, 14 Aug 2018 14:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com> <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com> <20180814185743.GE142615@aiede.svl.corp.google.com>
In-Reply-To: <20180814185743.GE142615@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 14:08:01 -0700
Message-ID: <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:57 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Brandon Williams wrote:
> > On 08/09, Jeff King wrote:
>
> >> One interesting thing about url-encoding is that it's not one-to-one.
> >> This case could also be %2F, which is a different file (on a
> >> case-sensitive filesystem). I think "%20" and "+" are similarly
> >> interchangeable.
> >>
> >> If we were decoding the filenames, that's fine. The round-trip is
> >> lossless.
> >>
> >> But that's not quite how the new code behaves. We encode the input and
> >> then check to see if it matches an encoding we previously performed. So
> >> if our urlencode routines ever change, this will subtly break.
> >>
> >> I don't know how much it's worth caring about. We're not that likely to
> >> change the routines ourself (though certainly a third-party
> >> implementation would need to know our exact url-encoding decisions).
> >
> > This is exactly the reason why I wanted to get some opinions on what the
> > best thing to do here would be.  I _think_ the best thing would probably
> > be to write a specific routine to do the conversion, and it wouldn't
> > even have to be all that complex.  Basically I'm just interested in
> > converting '/' characters so that things no longer behave like
> > nested directories.
>
> First of all, I think the behavior with this patch is already much
> better than the previous status quo.  I'm using the patch now and am
> very happy with it.
>
> Second, what if we store the pathname in config?  We already store the
> URL there:
>
>         [submodule "plugins/hooks"]
>                 url = https://gerrit.googlesource.com/plugins/hooks
>
> So we could (as a followup patch) do something like
>
>         [submodule "plugins/hooks"]
>                 url = https://gerrit.googlesource.com/plugins/hooks
>                 gitdirname = plugins%2fhooks
>
> and use that for lookups instead of regenerating the directory name.
> What do you think?

As I just looked at worktree code, this sounds intriguing for the wrong
reason (again), as a user may want to point the gitdirname to a repository
that they have already on disk outside the actual superproject. They
would be reinventing worktrees in the submodule space. ;-)

This would open up the security hole that we just had, again.
So we'd have to make sure that the gitdirname (instead of the
now meaningless subsection name) is proof to ../ attacks.

I feel uneasy about this as then the user might come in
and move submodules and repoint the gitdirname...
to a not url encoded path. Exposing this knob just
asks for trouble, no?

On the other hand, the only requirement for the "name" is
now uniqueness, and that is implied with subsections,
so I guess it looks elegant.

What would happen if gitdirname is changed as part of
history? (The same problem we have now with changing
the subsection name)

The more I think about it the less appealing this is, but it looks
elegant.

Stefan
