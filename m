Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5BEC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 00:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiAMAis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiAMAir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 19:38:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67791C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:38:47 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u25so16762047edf.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFPGgGYBYoUFOZ6TiWaSxi4WSFPZqNkItEIQDaLdHuQ=;
        b=CqFuHWVNZPOrcFkpCiCRv95UCrF+8T2w9o808flk89RyXMIoXALjPfyNwvFEbA1b3U
         t9rTmmaZzz4VbCw3AR6rEDfMukvrctcqUELLbh1tnlbtP/+EHwKzMG1EtUPPsAsPGNIm
         DmYxJm0ZEOMQQ/yrPyf3i+DO5Ptto8cok5JQtFayB+4HnT2P8unampBr5sOAcSaQcDCp
         Rq3lsiGOO8U/ijf4DzwbsPiJ2if/gzOscC5sgNnmX+iaCTSQFSrzCFFZWiykWadF/Tpi
         8D+xGWlfHJ+mJ8J1s8jB+yV/oR2yUkHMvxngwuBXglIAXnmR6ruRqjSkgb/2yxcRK30e
         urKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFPGgGYBYoUFOZ6TiWaSxi4WSFPZqNkItEIQDaLdHuQ=;
        b=OBrHk+5Y5gsvKKzahMPP5r4LL+s5Yp+HYKaQz6D9b3/4oVwgvNENlogOjkxXHWlxbz
         Tz+pfIi0yz+iOBues5pj3C3buHssB6c6KjTUiFmEFWv0NPvhl/JZRTapUASJyTcqS0cD
         5qytk3HWuo+3atA3aTFb61gM947nxYqQxv7E4NCDHbaQrQK5FYuirUz1uBovP48GxezF
         qd6RNV5z4NOkEdUM2huopUHw7/2ThIznmpMDbWArErTaBW2AeMoR/MV30BXEfbIOm8ha
         Npx9rQUOgsmxq9keGwgzbnLRhfbwoYs57IJrSKtWyAPeRqj/9NlLnP1ZfbiLMModyiax
         Vwhg==
X-Gm-Message-State: AOAM533vd9iESlDUIZYOhDwspGRNSh1hZLQ9ALVhPJxAa+Z8vHOZCucz
        BMyvQVxRgJ9QT/26YtkZySuFYB5CBLhiaMeOgwBUeRaPj18=
X-Google-Smtp-Source: ABdhPJxchR4lAFLnm2hUkLi0gTUEp6UqREsT3ihGDhcwBoZzx8WHGohqNI7fzrsHz00dCwFRsJZhkNXz+QHbULO3ttw=
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr1701413ejc.192.1642034325903;
 Wed, 12 Jan 2022 16:38:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com> <aa9ea67180dd10ef8bdf17e8c23694da15828b21.1641841193.git.gitgitgadget@gmail.com>
 <0e4bb6f1-337e-38b3-75b2-fe11ff8d68b2@gmail.com>
In-Reply-To: <0e4bb6f1-337e-38b3-75b2-fe11ff8d68b2@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 Jan 2022 16:38:34 -0800
Message-ID: <CABPp-BEvUCPzcWhuVP==Rk=2pJXxRSGZVjdEzPuzbwTcw7kMRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] sparse-checkout: limit tab completion to a single level
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 3:43 PM Lessley Dennington
<lessleydennington@gmail.com> wrote:
>
> > +__gitcomp_directories ()
> > +{
> > +     local _tmp_dir _tmp_completions
> > +
> > +     # Get the directory of the current token; this differs from dirname
> > +     # in that it keeps up to the final trailing slash.  If no slash found
> > +     # that's fine too.
> > +     [[ "$cur" =~ .*/ ]]
> > +     _tmp_dir=$BASH_REMATCH
> > +
> > +     # Find possible directory completions, adding trailing '/' characters
> > +     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
> > +         sed -e s%$%/%)"
> > +
> I am admittedly unfamiliar with the use of this format in sed expressions
> (I'm generally more accustomed to '/' instead of '%'). It's definitely
> working as it should, I'm just not quite sure of how.

These are the same in sed:
   sed -e s/apple/banana/
   sed -e s@apple@banana@
   sed -e s%apple%banana%

You can pick any character you like, but '/' is what people most often
use.  My expression involved a '/', though, so I changed the delimiter
to avoid ugly backslash escapes.

> > +     if [[ -n "$_tmp_completions" ]]; then
> > +         # There were some directory completions, so find ones that
> > +         # start with "$cur", the current token, and put those in COMPREPLY
> > +         local i=0 c IFS=$' \t\n'
> Does c need to be declared before the loop?

It was, but it's super easy to miss.  Look at the "local" line just
before your comment; it almost reads like line noise, but basically
there are three variables declared with two of them given initial
values.  c is in the middle, without an initial value.

> > +         for c in $_tmp_completions; do
> > +             if [[ $c == "$cur"* ]]; then
> > +                 COMPREPLY+=("$c")
> > +             fi
> > +         done
> > +     elif [[ "$cur" =~ /$ ]]; then
> > +         # No possible further completions any deeper, so assume we're at
> > +         # a leaf directory and just consider it complete
> Thank you so much for the detailed comments on this change - it made it
> really easy to parse.
> > +         __gitcomp_direct_append "$cur "
> What's the reason for the trailing space here?

The space was related to the "just consider it complete" aspect of the
comment above.  Anyway, to understand why the space character signals
the completion being final for this token, let's use some comparisons
with bash-completion of just a plain 'ls' command...

In git.git, at the toplevel, if I type
  ls README.md <TAB>
(note the space after README.md before pressing <TAB>), then
completion assumes I'm trying to get another term besides just
README.md, and can complete on anything in the directory.  In
contrast, if I type
   ls README.md<TAB>
(with no space between README.md and <TAB>), then completion figures
I'm trying to find filenames that start with "README.md", finds only
one, and returns "README.md " (note the trailing space).  That
trailing space makes my command line become "ls README.md " (again,
with a trailing space), so that if I try to do any more tab
completions, it's for adding another argument to the ls command, not
extending the README.md one.

You can see similar things with ls and directories.  For example, if you type
  ls Doc<TAB>tec<TAB>m<TAB>

then you'll note after the first <TAB> you'll see
  ls Documentation/
with no trailing space; after the second <TAB> you'll see
  ls Documentation/technical/
with no trailing space; and after the third <TAB> you'll see
  ls Documentation/technical/multi-pack-index.txt
WITH a trailing space.  In the first two cases, further completions
were possible so they didn't add a trailing space to signify the
completion was final, but in the third case it is final and needed the
trailing space to denote that.

Does that help?

> > +     fi
> > +}
>
> Added my review as mentioned in [1].
>
> [1]:
> https://lore.kernel.org/git/pull.1108.v2.git.1640892413.gitgitgadget@gmail.com/T/#md3da435452988b0366ab4c2ee4bc06df2d17cb36
