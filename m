Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8219C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97A620734
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6nyO+TI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgFOTvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgFOTvV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 15:51:21 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095DC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:51:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so19340519ioe.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6l8EL9ES3h27s7+WxZX/zT6plwNph/0m7d8+sthp+UY=;
        b=S6nyO+TIyCU+IlgwHkhio5HqWSxPdB1PhVdkjFQq91sbD0+9Wxsss3eTczNeXNdEq+
         qnC1I7HN7T/0OrbtOZgfcNO1GREEkrw5JW3zp2pJGJ9FtUE9SpvMLTlN4IFWvUsp7O63
         pVO/1F9GWCl9u2hOC6bfX2qaQANla3aXXlhDQuzipTL8X0K79iRboA989AWQzhWssFEq
         +tlWL5HyPus3r3krLstoepW3KB0VJ40Spiax//iMmLBLqJhOvHW/WqsDO9emPb0JWomw
         cpteng6O/kR/tRzL/jQwCQtMi0ui6uoqOy6Sp2Uz4fyA2h+E60KyNPTSjZaUKILWEsD6
         hm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6l8EL9ES3h27s7+WxZX/zT6plwNph/0m7d8+sthp+UY=;
        b=aWisa5tPAJaVFhF3OAnKkhXwNVqsXLCSNH5q6d/OuZOKOhofFsPGZAnzNSh9Q42ko8
         m+8+vENPUrq51PLp8t7zzV4YEk7uoYvoxribQZvTSEzGnh5I7BdAC8Mz5NWRC0e7BRxT
         BDClMD0RGNGCOdwIMsu+6CuSG9JVrcn3Fuz5wInVus7WmCDsB0XLyU9R8DD2MHLN2PlJ
         WlCzMPJmJNU6CSO0df/VvXu5mojDjM7+caQcF61AxW4MjnRow4Clu8LoD0dHtmWurl/S
         oKJRSQnEf7X1WGvL2SkO34g2fVv7AgxLXzPshonJFRSZktAorncJVRy6uYRLM/mVoaDT
         IBhw==
X-Gm-Message-State: AOAM533v4L78hlndHhu0370RFexAikf9A1YpRVyOHYbV/3yWwb8zXqY/
        xduoWApg4hlK7Uq72Svn1DphkYkQG1TW+KmMr7s=
X-Google-Smtp-Source: ABdhPJx3MrW2o2uGF0KYDnPtEorfGw/FtrdLcfq8eGMreRK0tDqY+hHOjzpRaawOYKdNkXz8xca5phX5x+dTO17C0pk=
X-Received: by 2002:a02:960a:: with SMTP id c10mr22307331jai.12.1592250680808;
 Mon, 15 Jun 2020 12:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200615180744.GB135968@google.com> <3cef6084-e632-c9ce-c0da-a2c250c2f512@gmail.com>
 <CAAwdEzDgJuoQJAZsrT0piuZPVP6nJTSB9RCbcuXO03-BYTnmOQ@mail.gmail.com> <8f9193aa-43bf-2ad3-d067-6330385e1788@gmail.com>
In-Reply-To: <8f9193aa-43bf-2ad3-d067-6330385e1788@gmail.com>
From:   =?UTF-8?Q?Alexandru_P=C4=83tr=C4=83nescu?= <drealecs@gmail.com>
Date:   Mon, 15 Jun 2020 22:50:56 +0300
Message-ID: <CAAwdEzBNwEVFcW5bTE-aWxnoQYamJH+DRhqRgc6abgo+bgYUzQ@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Cc:     jrnieder@gmail.com, johannes.schindelin@gmx.de,
        don@goodman-wilson.com, git@vger.kernel.org, msuchanek@suse.de,
        newren@gmail.com, philipoakley@iee.email,
        sandals@crustytoothpaste.net, simon@bocoup.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

S=C3=A9rgio
On Mon, Jun 15, 2020 at 10:37 PM S=C3=A9rgio Augusto Vianna
<sergio.a.vianna@gmail.com> wrote:
>
>  >But the people that contribute to the code and to an open-source
> project are the owner of that project so they get to get the calls.
>
> Ignoring everyone else's opinions and needs and just exerting your
> authority is the very definition of authoritarianism. Yes, they do have
> the right. But if they ignore the users, they can just use a fork that
> does what they want. Have anyone considered that a breaking change in
> git might very well result in a fork?
Well... fork happens sometimes when two groups of people completely
disagree and cannot work together.
I really hope a vote here would be enough to settle things.

S=C3=A9rgio, I'm actually with you on this side, just to state my opinion a=
s well.

I haven't yet heard of a person that is offended by git master branch.
I've heard thou about persons that think that some others will get offended=
.
But most of the time, I've heard about people that think this world
got crazy on git master branch naming :).

But I guess you've heard that already from other participants already,
so I apologize for repeating it.

And I believe that both of you, S=C3=A9rgio and Jonathan, were a bit rude
to each other :)
Let's relax and have a drink! Cheers!

Alex
