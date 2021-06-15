Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26028C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF295613F5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFOCbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:31:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65054 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFOCbP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:31:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66202C6D67;
        Mon, 14 Jun 2021 22:11:39 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=ukdw+iMrMYAI9CMh8tC0jGNYuRIZ3/E/klkjt4
        9aJGg=; b=L9pP9h9Psy6AtsGzzdHK2OgYet0VAw4mmlYv373KlVhuTUxHc2C3VY
        zcKkRaXBfwgUGum5OYbOek2Wkp2AVOYPdzOvYYOkhGpzfUMzyupfeyG46STUcykd
        Og1DoeT1QqdHUgTaq9EJVqna6iXUj0TDvRVph9mUYt4HAe8tJWrHI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B9E1C6D65;
        Mon, 14 Jun 2021 22:11:39 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=5mTrEMyGvKUDAvrRwbvuAclgzk6cdc4Gqdi6KqQ3A3I=; b=uVAZHPTVPkGdSevRf3ovAn4zbZR04goXaHPtrcoB0fsEL5zB7GDwkfZJjN6ZoZYIPHxDR9Id7girQzSZoalO5p8K4h3k4AagNqYpZiIeHY20ce1XzGUYaG3zvGo5TiHUcKHGgAExtQ4hfS0yPoB2z0YSOi9HT5bSc1Km8AoWrek=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9C72C6D62;
        Mon, 14 Jun 2021 22:11:38 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id B62B52DA0737;
        Mon, 14 Jun 2021 22:11:37 -0400 (EDT)
Date:   Mon, 14 Jun 2021 22:11:37 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
In-Reply-To: <CANYiYbG6bKwheThWz2ecHUTh7JFmTsi-F9FtYkcoS0az=f=m6Q@mail.gmail.com>
Message-ID: <0pqq6s9-n238-95ss-nsqr-42o75sr933r@syhkavp.arg>
References: <87im2s5jjm.fsf@evledraar.gmail.com> <20210612050711.4057-4-worldhello.net@gmail.com> <xmqqim2hyuj1.fsf@gitster.g> <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com> <xmqqk0mwylhc.fsf@gitster.g>
 <CANYiYbG6bKwheThWz2ecHUTh7JFmTsi-F9FtYkcoS0az=f=m6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-249243180-1623723097=:2908939"
X-Pobox-Relay-ID: 04BEF9F4-CD7F-11EB-B3DC-FD8818BA3BAF-78420484!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-249243180-1623723097=:2908939
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Jun 2021, Jiang Xin wrote:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:17=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Jiang Xin <worldhello.net@gmail.com> writes:
> >
> > >     /*
> > >      * Let's insert a suffix to clear the end
> > >      * of the screen line, but only if current
> > >      * line data actually contains something.
> > >      */
> > >
> > > So my implementation is to try not to break the original
> > > implementation, and keep the linelen unchanged.
> >
> > I knew what you wanted to do from your code---I am questioning if
> > that "only when something is there" was really sensible, or if it
> > was just attracting bugs.
> >
>=20
> @Nicolas, what's your opinion? Is it ok to add clear-to-eol suffix to
> each line even empty ones?

That would be the simplest thing to do.

But there must have been a reason for doing it otherwise. I just don't=20
remember anymore.

Maybe it had to do with progress reporting that does a bunch of=20
percentage updates followed by '\r' to remain on the same line, and at=20
the end a single '\n' to move to the next line without erasing the final=20
status report line. That would be a case for not clearing empty lines.


Nicolas
--8323328-249243180-1623723097=:2908939--
