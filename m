Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDAFC433EA
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AF82065C
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 09:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="eawHXlLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgG0Ja2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgG0Ja2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 05:30:28 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1EBC061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 02:30:27 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so993021iow.11
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C2qf3/hEri4mU2iPsBfEr0xNPymHq+jM4GfZHdM0ZOA=;
        b=eawHXlLlRrh5gcXV1xJi88RFb7HZp0HTqAYCGdR+Cg53/gw9OWCgI0xEjOSv/6cmiH
         7sjlmi3YnLcWWtrFgo2Q4gErFhAy47x3QnvS1/w1VOGz5FxYR2WJ4VEZNudTaoNPnhNg
         LJFVGkWHQBnOH8GG1wMdx1po2OVvBjkAmtrmhGZLrdEIv1PwV0XohEylKuZWsj1pl7xt
         OcWRV1pvVDeCvjJCwOaab72K3Rw7mR90J+RAKuXKSpchpmTk9ebXP5C3YvfdezAqfml8
         zUAM46P/zPfH2a1gP6eZfLiMNqMoEyVoQ57FXv80e4Gl7/1xxwdHJ+Xb0DvYp9ENrcNq
         T79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C2qf3/hEri4mU2iPsBfEr0xNPymHq+jM4GfZHdM0ZOA=;
        b=VSgZBe2P5uZjtryPHVkR8K0Z3Ooa/cdBL+24YWP5lFxwBXtKX8/2UEYRWjycUG656Y
         s9YkojFA9gsLDH1eXqOUadIGAwEAoJVsOQujtMCPA2OsLi64aMopbBXFD7g0m4XDGsyj
         ZZWEGKmDEAWsWcAMpLT8TO/Z7zx3bzRArTlxoilKf5HozONBNbxt8g/Z0OLnAW9JArA5
         8zpMzAgn9aQt4sBt3xyQTmxbKQ0pBJoP/vDy4ettua5XBOBuz94b6iQTmhwYquhIOv8N
         qsjL9LUFz+RMxQgmVjt7rDdsZMLprY64SqW8/PKRCrrr2Z2Pa4iCDqScRsaXEEVBtofp
         ytIg==
X-Gm-Message-State: AOAM531QEqVKWrcTz0FsUUwAKOYh1kQyreQ78gw5PgGSTxBKup6e+Cy3
        Q2PwPuADCKdvxhKqspC523kpsMYPS3RYZ6GDPOyIuw==
X-Google-Smtp-Source: ABdhPJwsVafr2DCttsT2AnaxWePOevnMSb36woibXGWZiOQnnWkFnGuCI0USByaithAxctdNlVPVF8/vsYYasLveulk=
X-Received: by 2002:a6b:8b10:: with SMTP id n16mr6373300iod.11.1595842227050;
 Mon, 27 Jul 2020 02:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
 <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
 <20200724160045.GA10590@syl.lan> <20200724200042.GC4013174@coredump.intra.peff.net>
 <xmqqv9ick5j4.fsf@gitster.c.googlers.com> <DM5PR1801MB20765394FC05BA6830475B7CF0720@DM5PR1801MB2076.namprd18.prod.outlook.com>
In-Reply-To: <DM5PR1801MB20765394FC05BA6830475B7CF0720@DM5PR1801MB2076.namprd18.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 27 Jul 2020 02:30:15 -0700
Message-ID: <CAGyf7-E6uyBnDZ7Uaz9awbUzgfPCabYeRNcYbw+yaHXDiLPdxw@mail.gmail.com>
Subject: Re: Creation of a branch named that has a directory prefix equal to
 the name of another branch fail.
To:     Tommaso Ercole <Tommaso.Ercole@qlik.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 27, 2020 at 1:21 AM Tommaso Ercole <Tommaso.Ercole@qlik.com> wr=
ote:
>
> Hi all and thanks for the answers.
>
> By my understanding it seems that you are aware of all the problems and y=
ou have just in place a solution for the future.
>
> I will just wait for it.
>
> Thank you really much for your effort, best regards,
> Tommaso Ercole
>
> P.S. btw this chat is it private between us or published somewhere, I jus=
t thought about it now, when I saw my phone number on my signature...

It's a public list, which anyone can register for, and it also has
multiple archives, like:
https://lore.kernel.org/git/DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1=
801MB2076.namprd18.prod.outlook.com/

I don't think there's any way to scrub the data now. Even if it was
removed from lore.kernel.org as a one-off, the original email was
delivered to the entire list.

>
>
> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: venerd=C3=AC 24 luglio 2020 22:44
> To: Jeff King <peff@peff.net>
> Cc: Taylor Blau <me@ttaylorr.com>; Tommaso Ercole <Tommaso.Ercole@qlik.co=
m>; git@vger.kernel.org
> Subject: Re: Creation of a branch named that has a directory prefix equal=
 to the name of another branch fail.
>
> Jeff King <peff@peff.net> writes:
>
> > Note that even though packed-refs does not have this limitation, we
> > still enforce it in order to avoid headaches when moving between loose
> > and packed refs.
> >
> > Likewise, we'll probably[1] continue to enforce it with reftables, at
> > least for a while, to make things less confusing when pushing and
> > pulling between repositories with different storage.
>
> Yup, that coincides with my understanding.
>
> The files backend could also learn encoding/decoding refnames and that co=
uld be used to transition, if/when we decide to discard the "refs are organ=
ized in a directory-tree like fashion" design we have been using, to a new =
world order where a branch M and branches M/A, M/B, and M/C can co-exist.  =
Encoding/decoding refname to map to the filename would also help those on c=
ase insensitive filesystems.
>
> Thanks to the recent preparation work for reftable, we are ensuring that =
we do not leave direct accesses to $GIT_DIR/refs/* in our codebase outside =
the files backend implementation, such a transition hopefully is getting mu=
ch easier to do than before.
