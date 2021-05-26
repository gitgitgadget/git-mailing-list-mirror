Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D899C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 06:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2546613C3
	for <git@archiver.kernel.org>; Wed, 26 May 2021 06:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEZGrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 02:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhEZGrr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 02:47:47 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F03C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 23:46:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k22so9769790ioa.9
        for <git@vger.kernel.org>; Tue, 25 May 2021 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spsqd5PMAIvzm2a8kBWHbhTCZgYSyTSe8HaERhSsmgg=;
        b=s1yVXVf5ZVBts+MkXssPZwbXMiMh1ZMLumhVNRkrUP1+YbbxnKsdeBHVEYVt6CPE+L
         7t1R9Ndbd6M373MS/2VBJl4xYF1o/HHF5wnHDkYUubNmvn8Je2zROLkfbjCgJtb6BF4N
         d+gIiXd80er+fMwJs49JFQHis0ctFUxs2yrszzChCPz+cdS60W7cVTwiWGDu8Fzh1+u0
         0b/LNB1I0qOlPU7PjLFa9myuF9ocJaAARW7Xt89rutr3a2YdH9jDVXm1XmBTemhrmQHy
         F5Knr2TtjSnNCkEj8lwn3TPUEfrVMF9fyUvag5A/1PR6ULp3yBDGr0rk3IPxUh64fST9
         Yh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spsqd5PMAIvzm2a8kBWHbhTCZgYSyTSe8HaERhSsmgg=;
        b=fBwbiYZ3gagdlVGrju0tF7LK6Khogsq8IXB/I3lileHzLFh0AHI9JctYi3Sz+bQVL5
         HZypS7KPyJd2173IEZ4+dg1/GTFKNXJ6VoZboYJH07tkhMIMnzreOWnrVKcnzf1tsaeV
         d53kLW2BewvotC9wRcZCHc1v8DcFB08n8imLW/SE9McQnI6sXT7HLyLiZSckA+P/C4Zz
         tsD8vAMgthPtyAQM/BiyVIZf1ClzzBOtgQ4q4WlLNZxL1A1Xo2yI5LuP16eUwo4O+sNy
         wFkPaYeR/azUUIXhdI04fTqxdumnCdR+UuIPibkQmFBlJ9o5UufRNecVIhaZND5OON2Z
         oGng==
X-Gm-Message-State: AOAM533Hb/zKCh80+6K4NcFl+xxUwEwTp742Rvn5i5yElBt2xkjNPLUq
        eHjwME2snlKNxthqnGpF9TaQ4Q9Qg1DsnQ7mDx3dFDN+ZUz/yw==
X-Google-Smtp-Source: ABdhPJw4ooF4W0Crs5RQncp3avWpSH1BJwzXlsmDSFKY64qn1n29HpBGo/X4tfrVVJ6P10vS0kjvcdhU7KTd9zvdymw=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr22837413ioo.203.1622011574387;
 Tue, 25 May 2021 23:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
 <xmqq1r9xndjf.fsf@gitster.g> <xmqq8s42cnyb.fsf@gitster.g>
In-Reply-To: <xmqq8s42cnyb.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 26 May 2021 14:45:58 +0800
Message-ID: <CAOLTT8ReZffY5gznSDD=Fgbt7YTtA5aJWX+f8Q8npcj0OwcuFQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Another thing to keep in mind is that not all host languages may be
> capable of expressing a string with NUL in it.  Most notably, shell.
> The --shell quoting rule used by for-each-ref would produce an
> equivalent of the "script" produced like this:
>
>         $ tr Q '\000' >script <<\EOF
>         #!/bin/sh
>         varname='varQname'
>         echo "$varname"
>         EOF
>
> but I do not think it would say 'var' followed by a NUL followed by
> 'name'.  The NUL is likely lost when assigned to the variable.
>

Yes, in the following example you mentioned earlier, I have also
noticed the loss of '\0'.

> >     git for-each-ref --format='
> >               name=%(refname)
> >               var=%(placeholder)
> >                 mkdir -p "$(dirname "$name")"
> >               printf "%%s" "$var" >"$name"
> >     ' --shell | /bin/sh
> >

> So for some host languages, binaries may be useless with or without
> quoting.  But for ones that can use strings to hold arbitrary byte
> sequence, it should be OK to let for-each-ref to quote the byte
> sequence as a string literal for the language (so that the exact
> byte sequence will end up being in the variable after assignment).
>

I agree, and maybe some'\0' can be escaped appropriately to let host
languages recognize it....

> That reminds me of another thing.  The --python thing was written
> back when Python3 was still a distant dream and strings were the
> appropriate type for a random sequence of bytes (as opposed to
> unicode, which cannot have a random sequence of bytes).  Somebody
> needs to check if it needs any update to work with Python3.

$ printf '%b' "name='a\\\0b\\\0c'\nprint(name)" | python2.7 | od -c
0000000   a  \0   b  \0   c  \n
0000006

$ printf '%b' "name='a\\\0b\\\0c'\necho -e \"\$name\"" | sh | od -c
0000000   a  \0   b  \0   c  \n
0000006

In shell or python2/3, we can replace'\0' with "\\0".

In Tcl and perl, they are ok with '\0'.

$ printf '%b' "set name \"a\0b\0c\"\nputs \$name" | tclsh | od -c
0000000   '   a  \0   b  \0   c   '  \n
0000010

$ printf '%b' "\$name = 'a\0b\0c';\n print \"\$name\""  | perl | od -c
0000000   a  \0   b  \0   c
0000005

So I currently think that a possible strategy is to modify
`python_quote_buf_with_size()` and `sq_quote_buf_with_size()` from
'\0' to "\\0".

Thanks!

--
ZheNing Hu
