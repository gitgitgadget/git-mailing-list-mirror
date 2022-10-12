Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F579C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 10:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJLKiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJLKiD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 06:38:03 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD8BA24E
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 03:38:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c20so7658106ljj.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqBndlKLSZBZHtPN0vB04hp9sxm5XpT3gj7Ka6bk7+s=;
        b=d8ZlyA29pJ4kMqKHIWuCIolRbEYvSJLk/o12eEaK5GVApbB8KG7KSa8UREWzi0vLM0
         GXBYLRVT573W4hDZLsaTYtH9DZ+SF9dZPtW2X68uYGs4Fa2SOFR0pO0oJUJhEONDTO+5
         A1UIs18cKTR8mxhgRnaHm9QJkM06dG6fZi6imhTV8sAMT+A7orPhcGOcVdqGu1Jkpu65
         tCREyOgiklo1pKhGNaR3uLrixfgO9Ojkmx/Zguyhyk3WZHrJJZiYdR+xE5PhcB/6zbYw
         E+uQKWsZ1Vs3biJX9aWX1FxK39reAZNnYxaXvVRAgV3FG8b2JMpIjSUoG2LruqmoPL1S
         VtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqBndlKLSZBZHtPN0vB04hp9sxm5XpT3gj7Ka6bk7+s=;
        b=q3biszGuT7obLptQEZzM6uoUO5UyGZ/CtUioBn2nCa7Chlo3+qv2lb6XPLYH43/88f
         BOq5kRN19GrhyBnu1iOZOjTO1r0zVLg2QMj3etDaXgcVP6kq+ySXJaEZwUIaA57IStTm
         Y5XI/+osYcV23rwt7E8DhT7kMB0ifSJOgNu2dWK2Hn5JInwWpMf/QZpmXWGG8wwWfl82
         6cHnYVzPOSaBvtOt3xg78QVDQXziGk8kqRnriyKMZ6aNh9JT/DMpcwKRfbMABFLae73T
         X/wJn6mcljBvfbDNYh/DoEOdHhBSuD5iBueGBRHAXE6+u187w7HLo0PE8iIhbB0M+Nlg
         fi0g==
X-Gm-Message-State: ACrzQf19royc3zGfI0qVPPWKutAW2tE756q+2Wo8sgi/jzcrzWQyul5c
        Nr678jo8M57tAHGM8Mek2qZkn3Y8qpkBRwp0jENsmWWiyZ7TAUNu3E7DJA==
X-Google-Smtp-Source: AMsMyM693+2bol1HZ+lwViF+OnGDkVlC6QOFOPNZ/SiC6yuJzN051k3aFJarXkQCotFHNFgzP6+WmnxKZZgSY3onJaE=
X-Received: by 2002:a2e:8812:0:b0:26e:98ee:7274 with SMTP id
 x18-20020a2e8812000000b0026e98ee7274mr7222736ljh.354.1665571079662; Wed, 12
 Oct 2022 03:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com> <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
 <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com> <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
 <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
 <xmqqleplmz3n.fsf@gitster.g> <Y0Zig4XUePPhMaA3@danh.dev>
In-Reply-To: <Y0Zig4XUePPhMaA3@danh.dev>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Wed, 12 Oct 2022 13:37:48 +0300
Message-ID: <CA+PPyiGPo1j-2MxTvmV2jDYNVFV1q8+7TVX1uoEUpWc0o+Rkdw@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luna Jernberg <droidbittin@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am using ubuntu(wsl)

On Wed, Oct 12, 2022 at 9:45 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2022-10-11 21:42:52-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com> writes:
> >
> > > Hi team, I am reading through "My first contribution"
> > > when I run make all doc, I get the following;
> > >
> > > SUBDIR git-gui
> > >     SUBDIR gitk-git
> > >     SUBDIR templates
> > > make -C Documentation all
> > > make[1]: Entering directory '/mnt/c/Users/USER/documents/git/Document=
ation'
> > > make[2]: Entering directory '/mnt/c/Users/USER/documents/git'
> > > make[2]: 'GIT-VERSION-FILE' is up to date.
> > > make[2]: Leaving directory '/mnt/c/Users/USER/documents/git'
> > >     XMLTO git-version.1
> > > /bin/sh: 1: xmlto: not found
> > > make[1]: *** [Makefile:355: git-version.1] Error 127
> > > make[1]: Leaving directory '/mnt/c/Users/USER/documents/git/Documenta=
tion'
> > > make: *** [Makefile:2720: doc] Error 2
> > >
> > > How should I go about it?
> >
> > Googling "xmlto: not found", the first result is
> >
> >     https://command-not-found.com/xmlto
> >
> > The page lists how to get and install it for various platforms, and
> > WSL/Windows should be included there.
> >
> > I believe "My first contribution" recommends to first read the
> > top-level INSTALL before continuing (and if not, it should be
> > updated to).  Simpler things first---building and installing the
> > vanilla source code without any of your changes should be simpler
> > and you should become confident in doing that, before you start
> > modifying anything. Otherwise, when you encounter a problem, you
> > would not be able to tell if you broke it with your change, or your
> > basic set-up is not complete (e.g. missing necessary tools like
> > xmlto) and unable to build and install from even vanilla set of
> > sources.
>
> Maybe he is on Windows and using Git-for-Windows SDK? I'm not sure
> what's included there, but I can imagine that man-pages is useless
> on Windows, they would prefer html docs instead. Perhaps, they want:
>
>         make all && make -C Documentation html
>
> When building only html, xmlto is not necessary to be installed.
>
> --
> Danh
