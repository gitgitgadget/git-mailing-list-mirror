Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A62C433FE
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 08:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiABIMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 03:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiABIMP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 03:12:15 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D991C061574
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 00:12:15 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g13so39140634ljj.10
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 00:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lCxh32HM9uxch/oTkkk/wa6WG44Ci8IH4yiMF9ISktQ=;
        b=Csy8TsXx/PnUO18gX/KiloRcvI+V2fBWCxTczh7vTsH9Phvihhqi1Dywhw+l7/f2Bs
         jke7KfVbdEWuOm6tVoPkJZ8+X5lIzSGt1JD7cIJXi2Dtc65NgrLNtY9n/l5ooLChoQ89
         16TtyhKupNEO9mXQG1KKSpyjodiNgbqz8Ft+KDNZ955Ks4JVMBYxAxf0nPu4fjAGGb3z
         zg0PSVDZOWJOhtVtdiI1UaBqK8N7cO2vPRyB98p4B6zig7CokA3ZWoVtTMxbPqyK1zHX
         Zw0yF6tibSr3mwZQCVC//WuZDXoF2RFFsRTBst1Hj3L2Jb7iNH8hrb+Brwt6A+WOljPY
         KX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lCxh32HM9uxch/oTkkk/wa6WG44Ci8IH4yiMF9ISktQ=;
        b=x1ytQ0/rzA2gr28GzlBo4z3qxQdRdCiu7/ogBhXnAXBD94fS8aS+wz+j5aN44Qko/a
         DnV2Jf9HoffEJCFM7oYYHLfi3e9YxwNO4ynslI2D3Jo1AtY06XqHic61qXVUWSZ1M6YW
         2qSSC68TQN93yL+IMdrCxo9HVMUT053TcBHs/aQlhCY7XylXsAvLsMdpuFPK5e9Bd/Tr
         P84w+pmR+jmr2EEbC6Rzi5FyYnz1jfZhcFhc6liC9BhR3i5822nSelrl0s3twSyh/4Ig
         6C73wI8NG4GpsRPO3Vgkua6skyFvD7YKfdijPwNr/YYaKGGv6e/fDWCGrYxSn7v8BQNB
         uD+Q==
X-Gm-Message-State: AOAM533ipR/XWXVsZf5yTTExwwQJx0UgEb74q+BOGJQdLuOm6NhyOGsb
        ckOw62wnX+2UzO8gN+L4fgvnX+E/UtE38ROU0j8=
X-Google-Smtp-Source: ABdhPJyBWq7rdosjj7YbVcmZmBFfyZfuXn7ZZtv94vUZM4nB//+LUP89GhJs2ORyIGvjCMWZRmX6oyab1PvECW880+Q=
X-Received: by 2002:a2e:90cb:: with SMTP id o11mr24890760ljg.158.1641111133370;
 Sun, 02 Jan 2022 00:12:13 -0800 (PST)
MIME-Version: 1.0
References: <CAC4O8c-2sxHyAjtd4jZQcjzX4d9+19AUx-h13nttjwP=pd1Ukw@mail.gmail.com>
 <CABPp-BEQdpO5=j_f2MjgZjhudNZgKhDgV31M_Cy6Agx_U=KweQ@mail.gmail.com>
In-Reply-To: <CABPp-BEQdpO5=j_f2MjgZjhudNZgKhDgV31M_Cy6Agx_U=KweQ@mail.gmail.com>
From:   Britton Kerin <britton.kerin@gmail.com>
Date:   Sat, 1 Jan 2022 23:12:02 -0900
Message-ID: <CAC4O8c95QEnV2=KueE0AOE4Dg+Jh58M2iYiVv=-655667AX85Q@mail.gmail.com>
Subject: Re: something like git-check-ignore but considering only patterns?
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 2:15 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Dec 29, 2021 at 12:54 PM Britton Kerin <britton.kerin@gmail.com> wrote:
> >
> > I'd like to query if a file e.g. symLinkToDir/foo.o would be ignored
> > if it were in a real dir instead (don't ask) but in a general way and
> > hopefully without parsing and matching all the .gitignore entries
> > myself.  Is it possible?
>
> How would that even work?  If there is just one gitignore pattern and it was:
>
>     build/*
>
> And you tried to ask (making up a new `--patterns` flag):
>
>     git check-ignore --patterns '*/foo.o'

You're right that it wouldn't make sense for a pattern but I want to
ask about a concrete path.  I've got a setup that hashes source trees
(some of which are large, and some of which sometimes switch between
sym links and identical dirs) and some make tricks to cause it to
first consider timestamps then hashes in a link-transparent way before
commiting to a rebuild.  I want to recycle .gitignore (and
~/.gitignore) etc. to filter out built files out of the hash input so
it works right for dirs that build into themselves (as most do).

> What should the command return?  True?  False?  It kinda depends on
> what that '*' actually is.  If it's "build" then it's ignored.  If
> it's not, then for this example it wouldn't be ignored.  So the best
> answer we would be able to give is "maybe", which isn't particularly
> useful.  Also, typical cases will be much more complex than that.  So
> we can only answer whether specific paths are ignored, not whether

The problem is just that check-ignore won't answer for paths it finds
are beyond a link, when what I want to know is just whether a given
path matches any of the patterns (and doesn't later get excluded etc.)
regardless of other git or filesystem state (except source names and
contents of course).

Britton
