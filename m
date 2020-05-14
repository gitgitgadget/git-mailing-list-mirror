Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922BC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 20:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F198207D5
	for <git@archiver.kernel.org>; Thu, 14 May 2020 20:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="gwwtP/Pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgENUyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 16:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727935AbgENUyM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 16:54:12 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED377C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 13:54:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h10so205859iob.10
        for <git@vger.kernel.org>; Thu, 14 May 2020 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FmPR6qh56rMMQCaQzEHsGym9UJjdKFmdFS3BjtjLd9E=;
        b=gwwtP/Pq89tm+OR+vKd55ODWz+1Hz+ZbeIat7sYgpY1SyTqV5GHA+mrY9g/qPQn0Yw
         l/VYn85OeERG3gn7mLA+1E7ryZUgLOgPJDzwg8eDnz54vk2wNxuylFy0jYfLaaiBNbQH
         cx4TMgUOU6eYB+wNtN0/JQZY+/ZMJX9AE8ttry9GBOv/ZsaXwaUIPxp2F4HOxl7ceNfv
         pi5w74pT4dAlSPipi+b0dsEx5sZnBQ2YZJdcb01V/a7PJ7Gj8ph7dDyLiQh0wKyeXRnj
         DdBwo62N5Z49tsSnR+ch/Hlp73BbIAdu74+UkFEL6Sj7tnSrhDKwSBEVL/FCcK37npIO
         2uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FmPR6qh56rMMQCaQzEHsGym9UJjdKFmdFS3BjtjLd9E=;
        b=tceGyRPTC3c/LrKqc7+OhW3vq0ZmLJONQWBtNPPg2dbRkgRKZAUkRunC213iDVGRqV
         6aMbl1949NeXMS/yztOXbLXCiHjFhgr3WWJvq/oNlSNItRQk1I92SK5F+F/Ee8Z2J4N6
         kdxo5Nhn8iC38pp/+SAT/nfDcm45pd+msjjySWhK+bGul50gKLLdzQ6yCICVxr9hrGLa
         mg+cF8TJUC86NI3dxKm15nyJPGGKCTerKNTO9q2/3ax6P2G3x6y1VFjlNFQk2cw5W3RL
         u32j4fjqP/7OAxSYNJ0nX7i+E0BbhR/OtIZ0uIWWv3ecB1hJ7nu346zsh4cABF0wTAgG
         Yrwg==
X-Gm-Message-State: AOAM532SBbNM/OOFXWmWI3W56RCLJMYSL5qvnUpiH6XLCvqG7fGGyAH8
        v7iY1oANbNwm6Le6U8nqj4UK0qZhZC+6aLJchKJffspR
X-Google-Smtp-Source: ABdhPJxnrxNeytsSjTQiElH17GiiXk8i0cPB0ZwqgqHAmFmStb8Auh8xB9ShQuklpq7k68UwDzW2594hOEtjnQrRZEo=
X-Received: by 2002:a05:6638:243:: with SMTP id w3mr162310jaq.20.1589489651136;
 Thu, 14 May 2020 13:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
In-Reply-To: <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 14 May 2020 13:54:00 -0700
Message-ID: <CAGyf7-E6amUCOs7fZ_7Zfjfx5qTwytM+zROZQqaM6NML2Ci-Zw@mail.gmail.com>
Subject: Re: Add a "Flattened Cache" to `git --clone`?
To:     Caleb Gray <hey@calebgray.com>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 1:33 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Thu, May 14, 2020 at 07:34:08AM -0700, Caleb Gray wrote:
> > I've done some searching around the Internet, mailing lists, and
> > reached out in IRC a couple of days ago... and haven't found anyone
> > else asking about a long-brewed contribution idea that I'd finally
> > like to implement. First I wanted to run it by you guys, though, since
> > this is my first time reaching out.
> >
> > Assuming my idea doesn't contradict other best practices or standards
> > already in place,  I'd like to transform the typical `git clone` flow
> > from:
> >
> >  Cloning into 'linux'...
> >  remote: Enumerating objects: 4154, done.
> >  remote: Counting objects: 100% (4154/4154), done.
> >  remote: Compressing objects: 100% (2535/2535), done.
> >  remote: Total 7344127 (delta 2564), reused 2167 (delta 1612),
> > pack-reused 7339973
> >  Receiving objects: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
> >  Resolving deltas: 100% (6180880/6180880), done.
> >
> > To subsequent clones (until cache invalidated) using the "flattened
> > cache" version (presumably built while fulfilling the first clone
> > request above):
> >
> >  Cloning into 'linux'...
> >  Receiving cache: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
>
> I don't think it's a common workflow for someone to repeatedly clone
> linux.git. Automated processes like CI would be doing it, but they tend
> to blow away the local disk between jobs, so they are unlikely to
> benefit from any native git local cache for something like this (in
> fact, we recommend that people use clone.bundle files for their CI
> needs, as described here:
> https://www.kernel.org/best-way-to-do-linux-clones-for-your-ci.html).
>
> I believe there's quite a bit of work being done by Gitlab folks to make
> it possible to offload more object fetching to lookaside-caches like
> CDN. Perhaps one of them can provide an update on how that is going.

I can't speak for Gitlab, but Bitbucket Server (formerly Stash) has
done this for years, and I believe Github does as well. For Bitbucket
Server, our caching doesn't change what the client sees (i.e. they
still see "Counting objects", "Compressing objects"), but the early
steps essentially jump straight to 100% (since that progress
information is included in our cached data) and then the client starts
receiving the pack.

I'm not sure how straightforward--or desirable--it would be for
something like this to be done natively by Git itself. Certainly it
would make building hosting solutions simpler, which could be a win
for simpler setups that don't use something like Bitbucket Server,
Gitlab or Github, but I'm not sure that's a big "win". Effort on
something like clonebundles (in Mercurial parlance) or similar seems
likely to offer a lot more bang for the buck than caching packs for
specific wants/haves.

Just my 2 cents as someone who has directly worked on this sort of caching.

Bryan Turner
