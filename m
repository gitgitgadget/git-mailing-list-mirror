Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9751F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162785AbeBNTSR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:18:17 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:44848 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162700AbeBNTSM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:18:12 -0500
Received: by mail-yw0-f174.google.com with SMTP id y65so4332083ywg.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G8R8OCN2NQ8AX8quxfq/9A3zH+OLD/NF69zJAj8ShqM=;
        b=nwsGtZvECVXTfzjD6hI1yOVhNM10BmNVoIHM6duNq/wOpb7Gz42pU+3ir36E6ny12G
         EjCuJi9sWD4iCvjRZX/8FEH0Nssve88CbX1FsEiUmOsQM+SM8TEjNUJvC+6eOJcya68K
         HQP06vxMvlzQcPn7g4YbOG2wgbYFZnWei6vPpJLhhIgCjqBJYLmr2YU5nGOSYai/Wjs4
         itz+Ez8GOp7cKncZC42tgaiuufbRVyzatkQxJbVwDyg6IQfRsO0FJY1oqk/kPeQtL+xv
         4UYHmcZeHgya4zrir9ifDrQMln9SY3kXP9MuKkp06dMD0imcH4hWa9V19XA9buYW8EbM
         cvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G8R8OCN2NQ8AX8quxfq/9A3zH+OLD/NF69zJAj8ShqM=;
        b=UzzkpJgFL458LRTgd7u+9bC0u7NAHoH02HSRn1IreRlJ0mLO13JkMZ2z583ixPQ5pg
         B615yUk++/ZALth7KxZ651ZT+Tzy7e/SQc8+2wgW675zrQXgkz/r9T7fhM8PUtlF0bVf
         1NTS1qlxdjTqwNpc60jxmcadLk3Ji8PlGsWfwqDhQE/RU8YrVVbS8BpEjovz9wuIGxf6
         cFKxe0ubrgC6CIYcQ8si7KFZ7U9ssHlazpCh21gIYEkvBpo8yvDryUKTU1tOng7pMpYE
         6Hqzz1tk91EGAX0qECznedfrO8v1v/3sBspg1seaamv3Uk59JrCqMM9l2HEK+2x6H+3n
         etuA==
X-Gm-Message-State: APf1xPBjrS+nyPnnaLCEVv4Q+DivUP1y06t7NrWXX+uTs5NX2nACCsjE
        nnEPyNOlsU5d8My9e99D+6R3xYyvP6fjVDLEAuCPCw==
X-Google-Smtp-Source: AH8x226ONXpJK3r6S2sK/aYFG/4+2Y98fC7vBPcsZHzWHIIMfIeTPe2+j+YA1mKiHSSIsUyXed0Z+iRZdyi/X6YT89U=
X-Received: by 10.37.37.87 with SMTP id l84mr253561ybl.386.1518635891544; Wed,
 14 Feb 2018 11:18:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 11:18:11
 -0800 (PST)
In-Reply-To: <CAFXrp_cP-WaXO27VV1OcVakfmDX0b6M62Qz1j4XRCbtQJzFfnw@mail.gmail.com>
References: <CAFXrp_cP-WaXO27VV1OcVakfmDX0b6M62Qz1j4XRCbtQJzFfnw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 11:18:11 -0800
Message-ID: <CAGZ79ka6UXKyVLmdLg_M5-sB1x96g8FRzRZy=ENy5aJBQf9_QA@mail.gmail.com>
Subject: Re: Can we make git clone --recurse-submodules --shallow-submodules
 work for commits that are not on tags or branches
To:     Ciro Santilli <ciro.santilli@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 9:06 PM, Ciro Santilli <ciro.santilli@gmail.com> wrote:
> I have a git repo with large submodules, notably the Linux kernel, and
> shallow clone saves a lot of time.
>
> However, QEMU is also a submodule, which I don't control, and QEMU has
> submodules which don't point to commits that are not on any tag or
> branch, so:
>
>  git clone --recurse-submodules --shallow-submodules git://git.qemu.org/qemu.git
>
> currently fails with:
>
> error: Server does not allow request for unadvertised object
> 22ead3e0bfdb87516656453336160e0a37b066bf
> Fetched in submodule path 'capstone', but it did not contain
> 22ead3e0bfdb87516656453336160e0a37b066bf. Direct fetching of that
> commit failed.
>
> on git 2.16.1.

In theory this should be easy. :)

In practice not so much, unfortunately. This is because cloning will just obtain
the latest tip of a branch (usually master). There is no mechanism in clone
to specify the exact sha1 that is wanted.

The wire protocol supports for asking exact sha1s, so that should be covered.
(Caveat: it only works if the server operator enables
uploadpack.allowReachableSHA1InWant which github has not AFAICT)

git-fetch allows to fetch arbitrary sha1, so as a workaround you can run a fetch
after the recursive clone by using "git submodule update" as that will use
fetches after the initial clone.


> Furthermore, I reproduce this locally with direct filesystem clones:
> https://github.com/cirosantilli/test-git-web-interface/blob/15335d3002a3e64fc5756b69fb832a733aa63fb9/shallow-submodule.sh#L158
> and on GitHub, so I'm guessing it is not just the settings for a
> specific server?
>
> Would it be possible to make that work, or are there fundamental
> reasons why it is not possible?

The wire protocol allows for it, so it should be possible fundamentally.
There is a redesign of the wire protocol going on currently, which
could allow for a new fetch mode that allows having just one
connection, which would only negotiate on the superproject and
infer the submodule parts from the superproject.


> Here is my use case repo, at the point of the ugly workaround I'm
> having to do: https://github.com/cirosantilli/linux-kernel-module-cheat/blob/a14c95346cfd9d2e7b2e475b0981aa71d819c20b/configure#L23
>
> Some more context:
> https://stackoverflow.com/questions/2144406/git-shallow-submodules/47374702#47374702
>
> This would make some embedded people happy.

Yes, a lot of submodule users would be happy if that
issue is solved.

Thanks for reporting,
Stefan
