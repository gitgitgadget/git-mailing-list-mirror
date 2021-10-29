Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5747BC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D426023F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhJ2MAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhJ2MAf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 08:00:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF38C061570;
        Fri, 29 Oct 2021 04:58:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j21so14899167edt.11;
        Fri, 29 Oct 2021 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Rwlo8FdhYRtBlqo68p6ZXREef+lIIdNlKykDKKYBIXg=;
        b=b6B7Q4SLcnl+9TcBbdkFODdeIk/dB4LKftsRiS/DR1zKLXzT0xKbfel8C3ftba/Z2p
         F02pPmYY/nXbpuf9bppU02jK9YYMocv++/qRq38mDfKdsolNNgdBCnLDZy/G0CQ3U6x3
         7ehJWe9koBF1auB8ZhgmuqHrWhdttSmNMkXni6Y6VyqbeGWkEuCLe56bXbCbJNbmzcYC
         WijlUgYm0x0SRtf5I+s63o5iDqfbleYInE49SkrhCDRGqz42ktvT82PSJywdLVO08Ju9
         3MnXF6pkRcnMd9wP0wTczOhwwZJoDW1yUtcjWVnwsMHo40n9vSfCLAsjvJxZoRaxwXhk
         t+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Rwlo8FdhYRtBlqo68p6ZXREef+lIIdNlKykDKKYBIXg=;
        b=5LYYuVlptxsLz2IgR4LipeoTOg2FarQXmTssBEoPDDAXHojSLnOvDHa26gKja4ZZao
         a9OOO7t7akdKjWzromXKj+UZqOvtlYY/V7Lbz5S5AaW1HLykmMjspHynrcd3fYQSLIqk
         h/Elsb7USOU9gx6BR7AiNgSKXHinxLSjDcoUPZ8L6q79yPwFUi3GSlt5xbzJ5ZXtJAHw
         vS/IcmyKtnvOVXQrbH0GpCgvNdTD0cnsccXqbJ5BzUTudfu7VG7t4XdNOhyO9Yq6CuHu
         htjEuIqYLXWvaNYuoZJJzF6ra5pYe8m7W8B9bGRhgRDX+N2qasePaZiPJ0wYXclzuK4e
         1YEQ==
X-Gm-Message-State: AOAM533L8tPxwrYKINJG18DTjNfj0leC61Xc/4S/dOqCkCGxTBvxXU+1
        qwUe5cCwpHa1v2AYv9wz608wnn/8CxPWDQ==
X-Google-Smtp-Source: ABdhPJz3QK99OBKgw0ThChm+DfT+MpTOrqIHhv4FZkJ423dEckeSmj09GDw5vPbeOlDWOmI/7WcTmQ==
X-Received: by 2002:aa7:ccc2:: with SMTP id y2mr10634789edt.149.1635508685469;
        Fri, 29 Oct 2021 04:58:05 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hc15sm2752681ejc.73.2021.10.29.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:58:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgQWK-00251f-KM;
        Fri, 29 Oct 2021 13:58:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Libc-alpha <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, git@vger.kernel.org,
        "tech@openbsd.org" <tech@openbsd.org>,
        "Benoit Lecocq" <benoit@openbsd.org>,
        "Klemens Nanni" <kn@openbsd.org>
Subject: Re: Is getpass(3) really obsolete?
Date:   Fri, 29 Oct 2021 13:40:36 +0200
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
Message-ID: <211029.86r1c43uwj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Alejandro Colomar (man-pages) wrote:

> [Add a few CCs, since I mentioned them.]

[I'm not sure what the full context of this thread is, but just replying
from the POV of git@ being CC'd on this]

> On 10/29/21 13:15, Alejandro Colomar wrote:
>> Hi,
>> As the manual pages says, SUSv2 marked it as LEGACY, and POSIX
>> doesn't have it at all.=C2=A0 The manual page goes further and says "This
>> function is obsolete. Do not use it." in its first lines.
>> But, glibc doesn't seem to have deprecated this function at all.=C2=A0
>> And it seems to be the most portable way to get a password, even if
>> it's not in POSIX.
>> BSDs have readpassphrase(3), but glibc doesn't, so unless you
>> recommend=20
>
> OpenBSD also marks getpass(3) as obsolete and recommends readpassphrase(3=
):
> <https://man.openbsd.org/getpass>

Simply not being familiar with that case: Is that suggestive of
getpass(3) being bad to use in general, or a case where OpenBSD's
deprecation of it makes sense holistically on that OS, but not
necessarily elsewhere?

Just skimming the linked man pages it looks like OpenBSD might have
deprecated it at least partly due to getpass() accepting a password on
stdin.

Even within OpenBSD I wonder what that case means for software such as
git. I.e. is it better to be portable and accept the same behavior on
OpenBSD as elsewhere, or conform more closely to platform-specific
conventions.

I haven't looked closely out our getpass() integration, maybe that's a
moot point either way.

>> using readpassphrase(3) from libbsd, or plan to add it to glibc, I
>> think getpass(3) should be the recommended function in Linux, and
>> therefore we should remove the hard words against it.
>> As a real example, git(1) uses getpass(3).
>> <https://github.com/git/git/blob/master/compat/terminal.c>
>> What are your thoughts?
>> Thanks,
>> Alex
>>=20

Just while we've got some OpenBSD people CC'd (added the devel/git
maintainers). I occasionally test git on OpenBSD myself (on the GCC
farm), and we've got a few broken tests on the platform.

Looking at the ports source there's at least a couple of OpenBSD
portability patches in there that would make sense to
upstream.

So if that's easy for you or you're willing to submit them upstream we'd
be happy to take them. Usually the only reason we haven't fixed things
like that already is because nobody told us, and we're not actively
looking into the local patches local packagers apply.
