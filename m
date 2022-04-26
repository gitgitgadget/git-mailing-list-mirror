Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5133BC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 17:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiDZRUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 13:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbiDZRSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 13:18:42 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB44C4B
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 10:15:19 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id x5so3348681uap.8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgsqo0ZqbmR0L5SRYPeVh3vR+l39VruuiIpJKJ7t/Kk=;
        b=qwSnV89uRY3TKS2EaMLyrRsB7YK9WDfIh0/A8PVRrrKJ0OVgoZUrsBDsuxcRzAm6ob
         FTHDUD0hN6M3KYxiCunE6Ec5orW4SEly0yx/qhR6BsIKIhevjnqoG8Ocw6Y5JIwH6GG5
         ZnFH/2EjEgL1DYhrf9xLbggVTuomz5jUSGfQfA9rirbFYzeKPvN1q247zoXWgDH73Iwd
         TF0xoIcEzwgmDB+E3ogMFB8e2tIxUAtKwsuLmshccq87v5Q94Yyn+CUfJmRTfKj+LYw9
         vCVhTzvxiRg5XA+kRJ8infJTX9rVnxqogLoY3EDf45B/3dsD5gcO47Pz0AyfaWBlAyLK
         jOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgsqo0ZqbmR0L5SRYPeVh3vR+l39VruuiIpJKJ7t/Kk=;
        b=HizBaN6ffaSlEmfDWlsz6IQaHdueqq4qJpKHOdzwaWqh5R33m0bPnwgxmI8jet54WS
         ftd278pgQSiRrH4dZfr3ZP2+/5MZdyVN10BtkGT3ClcWtvLUCgDuZx1AQkotT9UPp0qx
         nGMhtZ7ba3YjfbFFxFmAa71Ol8D/KEvkpz7hcG8fjM7VKii5WT1qxlLtVThqDA2emTBM
         CW2f2j4B7cJ4m97OG04dVft3xPoPSRgzVWNwIBG+DUROXWZZwtOSgsWZM6GcI73VkMtw
         aOTTGSC1EgAQgw87NM1x6+NdJ3EdLRVwhSO1koShZdvbnLEm9NXxXF+eGCs2bwIwgqM/
         nrFg==
X-Gm-Message-State: AOAM530jSIetQD2b/W66/L0nxvJ85CrGs+jizuQ4BP56xv9W5A6kqojx
        qUZMmi3swdLSGJItVuvDFc3jx7rium1L+qUVZpw=
X-Google-Smtp-Source: ABdhPJxwIAwTL/bBXq86PaCW5Un/g0QrEraj2QftGmUjzRvuobILrZJGTSGJceHdQGKtDsNWxHlHkgHnYnhKERD0QO0=
X-Received: by 2002:ab0:53c9:0:b0:360:2831:be85 with SMTP id
 l9-20020ab053c9000000b003602831be85mr7228567uaa.28.1650993318347; Tue, 26 Apr
 2022 10:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email> <xmqqczh73hns.fsf@gitster.g>
 <xmqqk0bf1i12.fsf@gitster.g> <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
 <xmqqy1zty8dc.fsf@gitster.g> <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan>
 <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan> <nycvar.QRO.7.76.6.2204261742120.355@tvgsbejvaqbjf.bet>
 <CAPUEspiufPMZOfZFunTFYmX7KwPxsKsAeHnfBjKgosA1ZJWqzw@mail.gmail.com> <xmqqpml3rdwx.fsf@gitster.g>
In-Reply-To: <xmqqpml3rdwx.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 26 Apr 2022 10:15:07 -0700
Message-ID: <CAPUEspi9mmoxehydOctGiCddUA0QtafXwKbMnprAWUPjO=vQDw@mail.gmail.com>
Subject: Re: a problem with git describe
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 9:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > Still think that (since we are already touching this) removing the
> > restriction to
> > root owned directories might make sense though, ex the following (unrealistic
> > example) would work:
>
> I think it is essential to protect unsuspecting "root" user from
> wandering into an unfamiliar directory that happens to be a trap,
> i.e. I may do something like this as an admin:
>
>     $ sudo sh
>     # cd / && find usr bin ... >/var/tmp/mylist.txt
>     # cd /var/tmp
>
> with the expectation that I'd then do some text processing on the
> mylist.txt file, and going there first would allow me to refer to
> the files more easily, instead of having to say:
>
>     # sed -e '... processing ...' </var/tmp/mylist.txt >/var/tmp/out.txt
>
> Alas, you as an attacker have done

Which is a career that has ended prematurely, it seems.

>     $ cd /var/tmp
>     $ git init
>     $ edit .git/config
>
> to wait for me.  /var/tmp would be owned by 'root' but allows
> anybody to write to it, only forbidding people from removing other
> people's stuff.

Since we are doing stat in that directory anyway, we should be able
to notice the sticky bit and not fall from that trap, but I get why
"exempting root" would be a bad idea.

Carlo
