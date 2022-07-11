Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C08BC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 16:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiGKQyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiGKQyN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 12:54:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05EF3E754
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 09:54:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eq6so7022671edb.6
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aw7H02FgaEiR7dErs/hrkQZV3LXea09Kru6/D2/AH+Q=;
        b=jBtCjkLkTddZ8imIwjTQCjNhfdGG/fFvXGgKi5Gz7ctZ7lUOowsm4BJAvCMj1uOboo
         0+HLHc0g1u2/zCRDhP7hulOhmZQFSlH00+bYPSmb5rHBgFYIbll6rz4KYyGJkx+3m4HI
         7wweMVgm/NfqDNu8uJp+0IpmWV04dt8se+b3rkTrBKE7UqohXIXsaiR1GB3f/kUpkqht
         A/0USgYezXsX/3W85wUHTQA9y+l28FP7g5rq/gpvYW9whg5SS86BCyK2vM/Ewdak10MI
         HhzkLjN8z/JeFhqaHAKWBRsXBYFPKAu6HoSFqfiTFW4vHNQImm25Qp1P+lwzSTketeY4
         CeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aw7H02FgaEiR7dErs/hrkQZV3LXea09Kru6/D2/AH+Q=;
        b=3FDdWYkDUWM9kGSRwk3ul2LOK/9aABXQa59H5asOUzB6hCcFWG8xqWBDW5H6o74rE4
         dNWKovH/6IAyPlAJUYcG+uu6zo3dAa16YrvkIcb3RFeaIBiqF8UvG0B5jDOouhoPsloF
         vaXcE44XaOokJKV+cO3OMumpwST/whLUEApAMwUg0nV9nYUGQMi2+HVvhpFuY7brWmLv
         YBLHA/3HUPrK0S/xouCVXQIR0dxj2CEB1dQxC1/nIyn1kxKr7yNvZCKT/SyqdQZBa9Xs
         u+gpNw1tRLewYi3GDsqwtN2yBWTs5zOnN0SKXPq8QFd8RbtRbFFQOWE7EjXGKlbeUNU+
         Bi0Q==
X-Gm-Message-State: AJIora/wwjYHFZ7i1w7Dgt7cdS207gJarB5IEvHtiTSjDu0z9t4FUp1L
        3G15QrfA0/yLi5IBNFBairmx8iVnupHq4fuYtgcdwQN9
X-Google-Smtp-Source: AGRyM1sp4jxSsmP13UW6/84XJg6qYt+hcYfOh6vT9YxmaLP15GjQB9IioUDk0PMfdbFlNNINN9Y/PLOhxO8vMpQAe9Q=
X-Received: by 2002:a05:6402:4255:b0:43a:c03f:1aa4 with SMTP id
 g21-20020a056402425500b0043ac03f1aa4mr18482744edb.146.1657558449269; Mon, 11
 Jul 2022 09:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <006c01d894aa$3b9f33b0$b2dd9b10$@nexbridge.com> <Yst1tmpBU0DHdi5P@tapette.crustytoothpaste.net>
 <007f01d894c5$8b1cd3a0$a1567ae0$@nexbridge.com>
In-Reply-To: <007f01d894c5$8b1cd3a0$a1567ae0$@nexbridge.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jul 2022 09:53:58 -0700
Message-ID: <CABPp-BF0vCE4pzKEhjzNaJAOQYkYQ3Wvt+H5guzD3aZLdMO8kQ@mail.gmail.com>
Subject: Re: Automatic code formatting
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2022 at 6:31 PM <rsbecker@nexbridge.com> wrote:
>
> On July 10, 2022 8:59 PM, brian m. carlson wrote:
> >On 2022-07-10 at 22:13:01, rsbecker@nexbridge.com wrote:
> >>
> >> Being one of the platforms that will be specifically excluded from
> >> this proposal, I would like to offer an alternative. Before that,
> >> please remember that not everything is Linux. My suggestion is to
> >> create infrastructure to automatically format on add/commit. This
> >> could be pluggable relatively simply with clean filter that is
> >> language specific - perhaps with a helper option that installs the
> >> formatter easily (because clean filters are notoriously painful to
> >> install for newbies from my observations). It would be nice to have
> >> something in perl that is more portable and pervasive than clang -
> >> although perl could launch clang where available. I think having
> >> infrastructure for code formatting that is built into git is actually
> >> highly desirable - assuming that it is not unduly difficult to install
> >> those. It would extend beyond git contributions, but the contributors
> >> could be told (Contributor's Guide) that then need to follow standard
> >> X, which may very well be clang format. There are java formatters, php
> >> and perl formatters, even COBOL and TAL formatters. My position is
> >> that having a standard way to plug these in is a more general plan
> >> that would reach a larger community. Git contributions could then just
> >> leverage standard git functionality.
> >
> >I am willing to acknowledge the fact that not everybody has clang on the=
ir
> >preferred platform.  However, I assume you do have a laptop or desktop w=
ith
> >which you access your platform (since I believe it's a server
> >platform) and that you can install software there, or that you have the =
ability to
> >run some sort of virtualization framework on some system.
> >
> >I am in general not very willing to say that we can't use or have useful=
 developer
> >tools because of uncommon platforms.  Linux, Windows, macOS, and (I beli=
eve)
> >FreeBSD, NetBSD, and OpenBSD all support clang and related tools, and I =
don't
> >think it's unreasonable for us to expect that someone can have access to=
 such a
> >system as part of development, even if that's in a VM.  Those six operat=
ing
> >systems plus Chrome OS constitute the overwhelming majority of desktop a=
nd
> >laptop systems, and there are several options which are free (both as in=
 speech
> >and beer).
> >
> >Moreover, clang and LLVM are extremely portable[0].  As a practical matt=
er, any
> >platform wanting to support software written in Rust (a popular and grow=
ing
> >language) will likely need LLVM, and there is also a lot of software in =
C and C++
> >that only supports GCC-compatible compilers.  I do feel that providing s=
upport for
> >modern toolchains is an important part of providing a viable OS port, an=
d that we
> >should be able to rely on porters for that OS to do that work.  I realiz=
e that LLVM is
> >not yet ported to your system, but I believe it's going to functionally =
need to
> >happen sooner or later.  When it does, you'll be able to send patches di=
rectly
> >without needing to copy to another OS to format the code.
>
> I should point out that gcc will *never* according to our latest intel, b=
e supported on my platforms. *Never* is, of course, an indeterminate defini=
tion, but until various matters I cannot legally discuss change, which are =
not likely for at least 5 years, anything depending on gcc is out of the pi=
cture and unavailable, including clang. I understand the position regarding=
 git contributions, but I am trying to get the point across that formatting=
 code to a standard is a more general desire than just git contributions. I=
t is a broad desire/requirement that should be considered. Rather than maki=
ng processes git-contribution-specific, providing a more general solution t=
hat git contributors can use is more effective.

I don't understand why this matters to the proposal, though.  My
experience with projects adopting code-formatting is that there are
always some people who just don't use it (e.g. because they use a
different IDE that doesn't integrate with it, or they never bother
installing the extra tool, etc.).  Such users run the risk of having
automated CI jobs flag their code with a problem, and then they have
to go back and fix it, but it's still a net win because reviewers
don't have to spend time catching those problems, and the original
folks would have had to fix their code anyway.  In fact, in some
projects, I've been one of those users and having the project use a
code formatter that I didn't want to bother to set up and run didn't
negatively impact me at all.

Whether or not we have an automatic formatter, you're still
responsible to fix your code to match the project's guidelines.  I
don't think that becomes any harder, because if we have an automatic
formatter, the _most_ that changes is there's a flag day where the
style is adjusted slightly.  After that point, all you have to do is
the same as today: look at the surrounding code to see the format and
follow it.  So, from what I can see, you lose nothing from this
proposal if it is implemented.
