Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ED8C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870FD6141B
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhKSRJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhKSRJT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 12:09:19 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33371C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 09:06:17 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x9so10856255ilu.6
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 09:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1DODtMCH6eu2OoGPjH6rWYihh0CiQXSjeTNy4b10M0=;
        b=c7D6t2EOpG5U3pSll0j7lpD7VYtbeTODL+l4I7ddLtG5UCiAZMv7MTl3Q2vY6C81qy
         bD80CqUycEYGc9PH1HoA5eLWyOBNoQIPGG1fc9GQCz/RItizdZ8PKY98IjL61hoHV+0W
         iZ5YDU29Moraz03d+ETC+aJMj3bTiisHXcITLhUe4Ds8CnhDKksIqMAQW6bsLhzKyxez
         2MbGef1yWL/eJmqqZq7pmpW+jqlhtxs71OIGqQw4iP4QgtgrmWCGBKtmj3fq48jNaLhb
         KMIekrEdF/06oUEvtUfbr+i3ENEi20FbMQOA5V00LDQBuxLLkw9TRqnK0v2UjYtIayhu
         mFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1DODtMCH6eu2OoGPjH6rWYihh0CiQXSjeTNy4b10M0=;
        b=GAFTnjzJgY5cDyFWF24DzRdlak5ZguqmREKHT4niSqYdeRPGNE4JKJYJhXspud5Zt9
         IkvdItVdU2qmCAeFumcahOI76y7NhZNF6XoS3Ffq6OIrbmavhPbuRc+FVuqjqHXX844p
         Dce/LJCVV/t8duNgXvaAf4B4aUo3QremiuatdRN31RpNibBTPnvAh4k1xVOl2U25if8Q
         TgJP2e3fqhv/K9Zyqt/x9ETgkEkLS5SWWLtPT3+IZZtaqnYdBNMZ9pQE85zLtuEx0nf1
         SnoGMu99elU9OyG5eg+PoMqQZTaSz5HNKfk//OYqYuhAlTbZKqscoTyzyHf+92ApqNL6
         jVtw==
X-Gm-Message-State: AOAM531Up8H4xNKeSpLgtrpl2fdTeSQsrtwMUTJxvc/AQHt1iQGARxNt
        hm+EeUcwKgwJyMpg69Z60kgyXNOE66fCOQ7Ga2g=
X-Google-Smtp-Source: ABdhPJzKNVSMWilRaMoocweTMVKzFhJ37COtGnaxf9g/NIVqYafjS4mT7U4289sdSiA/SQ3cQZH5omGbdwz/Vcev0zs=
X-Received: by 2002:a92:ca0b:: with SMTP id j11mr5565781ils.289.1637341576240;
 Fri, 19 Nov 2021 09:06:16 -0800 (PST)
MIME-Version: 1.0
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net> <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
 <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com> <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
In-Reply-To: <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
From:   Danial Alihosseini <danial.alihosseini@gmail.com>
Date:   Fri, 19 Nov 2021 20:36:04 +0330
Message-ID: <CACLOEFb41ZLvvkaF6xivFShOJfSHcNupzstiShKHiNCg4DCEhQ@mail.gmail.com>
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Derrick.

> What is unclear to me is what exactly "match a directory" means.
> If we ignore a directory, then we ignore everything inside it (until
> another pattern says we should care about it), but the converse
> should also hold: if we have a pattern like "!data/**/", then that
> should mean "include everything inside data/<A>/ where <A> is any
> directory name".

I think if we consider directory and files separately, it would be more clear.
If a pattern in gitignore matches a directory, it is just about that
directory and not about its contents.
The contents are ignored by another rule which states:
> It is not possible to re-include a file if a parent directory of that file is excluded.

In our test case, the "data1" directory is ignored by the "data/**" pattern.
However, the contents are ignored by two rules. One of them is that
the parent ("data1") is not tracked. Another one is that the "data/**"
pattern matches them.
By adding the "!data/**/" pattern, the "data1" directory is
re-included, but its contents are still ignored by the "data/**"
pattern.

I hope this will help to make the rules more clear.

Thanks
Danial
