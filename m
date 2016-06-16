Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9FB1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 16:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbcFPQ7r (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 12:59:47 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35017 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbcFPQ7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 12:59:46 -0400
Received: by mail-qk0-f180.google.com with SMTP id c73so59455551qkg.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 09:59:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eQX5oS+yIll6Ics5TtLCNQwuxUMR2xPw/vNLwPvOqtU=;
        b=D+VMgfIBP8kwi4T+TBRs1FDXb+5xLnSczVh8csZjBvTdj96Mz4nu9synLUCSAPoF3W
         L83erCI6PU1UWcRw2TyQZ5Ua3G4n9O2xZaF58FHbmEvdKpR8bIXw/2afv8J9x3xFyFgV
         S2iwuxpAUUe6ZILBTKVTarc/zlh/V1sllUosOWuo4sfYIFGKxqeuUagc/DE1VbUmhnKv
         B71wwjOkt6qOi16y0NElaPBoBfHICglSdnwheE3JDhg1/O7s7u9+inrrj+Y3MMf6W1dx
         hmUtbwOaXKb4ZOqNu/S9n3Q6d3O9R+bdNfNxHjbPgRityYW5E3qXFZMRQBNFUbAlkS2y
         cGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eQX5oS+yIll6Ics5TtLCNQwuxUMR2xPw/vNLwPvOqtU=;
        b=bpDUWPQUAeutuf9Puef7nfxFbeMieKtLgcOcmTGB7UHFo/V0boJeMJp1jpw2pbH3Ij
         wieZuN3YvR0th9g2CO5CHdDSrFpYdsbar3xDSk4grOBy+w3pnGKy1OvD7UiiCbczGz6f
         k6scyYjCzm/fzVIsjPsj1RMgGUhkfTmOcxBQM4va5Wl6YO3WOKvUrSxncp3qvmdwFbKk
         AWM7PVHzq4nNjwH6OtN78zkQPZSCd4HcxLjZl8boE7w/yfrJRhYUA8yFlGVdvZUV6Scw
         QbqVx79nXgKc6u2emX6hTkvQWkDzmLxy82mcAj8V/bT1PrTcu2aRbolaYmdBtcfBZhoy
         on5A==
X-Gm-Message-State: ALyK8tL9Af390LY4NOo04Imsrbg8ou2QnjpkbEJvJD9snO9doBM3kx8O9guq1cQvfiAQvTnb2Q9G4k15wjhBwMnu
X-Received: by 10.55.10.147 with SMTP id 141mr6247266qkk.91.1466096385163;
 Thu, 16 Jun 2016 09:59:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Thu, 16 Jun 2016 09:59:44 -0700 (PDT)
In-Reply-To: <1466096135.28161.9.camel@kaarsemaker.net>
References: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
 <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com> <1466096135.28161.9.camel@kaarsemaker.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 16 Jun 2016 09:59:44 -0700
Message-ID: <CAGZ79kbw=XbqmjPQYMsG_F9FYx4o9wY5DpneBXX7RSBUeQ=3CA@mail.gmail.com>
Subject: Re: [bug] assertion in 2.8.4 triggering on old-ish worktree
To:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:	Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 9:55 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On do, 2016-06-16 at 17:02 +1200, Chris Packham wrote:
>> On Thu, Jun 16, 2016 at 4:59 PM, Chris Packham <judge.packham@gmail.c
>> om> wrote:
>> >
>> > Hi All,
>> >
>> > I have the git-sh-prompt configured in my .bashrc today I visited
>> > an
>> > old worktree that I haven't really touched in a few years (sorry
>> > can't
>> > remember the git version I was using back then). I received the
>> > following output when changing to the directory
>> >
>> > git: pathspec.c:317: prefix_pathspec: Assertion `item-
>> > >nowildcard_len
>> > <= item->len && item->prefix <= item->len' failed.
>> >
>> > I assume it's one of the git invocations in git-sh-prompt that's
>> > hitting the assertion. Any thoughts on what might be triggering it?
>> > Any debug I can gather?
>> A bit more info. The directory in question is a uninitialised
>> submodule. It doesn't trigger in the root of the parent project.
>
> That very much smells like a class of bugs we've seen before, with git
> getting confused around submodules. See also for example
>
> https://www.mail-archive.com/git@vger.kernel.org/msg68447.html
>
> I don't think an accepted fix exists yet.

Thanks for pointing me at that report. I was not aware of this "class of bugs",
I'll see if I can fix it.

Thanks,
Stefan

>
> D.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
