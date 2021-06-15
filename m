Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458AFC2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AE2613FA
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFODHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhFODHM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:07:12 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5802BC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 20:05:07 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id c8so16677320ybq.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 20:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5aeCgs85X7olYAAgLSZggp/iAE5DmKcRRWZey/l41b8=;
        b=IlXT1oQI6BSJYPN/w0TQX2axOKAWP4EhHdvbzAeTKTABi2mMHNCe4bYFVr+S+54fnf
         VEfzbcG83EPSYEIr3LJDq3VOzNypIa7/ephfTNe5IPWrFhuWFEpthV1sIe8tmBo8YYox
         7YhE62QEVWgZc3tlg1Es4dNYiycZWa1YzqxBHk9UlfWfilOtrh1qMfNQ/HvdP4U7xXjy
         cBiUGaa5i050Y0QVZV54ho9X8z/ixI2+s5AiUgSQ05jwmM7rBE2dmZtyxWS+7nBEnEzr
         XJu55cGEHiWMXJEdw5I8fJmuIxxMOpw0TDIi/MR58YIoJF6fNjBFPXenxE5fPpDIFmD1
         eDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5aeCgs85X7olYAAgLSZggp/iAE5DmKcRRWZey/l41b8=;
        b=FAwD8nK7MGQ7DaBc/hrGGFl9dWQJjRpnOjkqs1wrP8bg5Rl0okQM14VpHVydm7xSCK
         wTlziXIjzUqwM7jbXjLkRG1wd+iJMEpa1+qAns+Uvmq+pgzjpqL/mz1TXw7UCmgIBCZw
         /Mhymg9Y41wcHMECoI6+rhGC49CUU0cVPqXYGrOZ40HUNGlJDDCRBucc+m5pYTx5Sl5f
         ATdxzFimio9JRsWw2p+p/VUkijBfgbdEl7Pf8t5YAGypO0O7kMW3CzdH0iBiHZ7Opdo1
         t1dGkjkuCUsO7dxiUIYsWh+4yuWUOYQbmMl9MR+UZy3PvXAisT6oOxqXbN+evh/UKGua
         t/tQ==
X-Gm-Message-State: AOAM533VbQTaxhUZoWbaQiD7EPglVZqE9YJhDD3qT/0DxdYnh1PmAEuV
        RX9fc2rPkYe50qBP2rQy82ZdJdjzQWX1pjS3zTM=
X-Google-Smtp-Source: ABdhPJzxdWwhV70/BHMaClW/C5QGoiVYsixIBJ+JaX/dfrTpW+wphUJO6fl6/KvNZqYNvR+2mm9JgVdjCdb/jI+Pw0U=
X-Received: by 2002:a25:c012:: with SMTP id c18mr27775692ybf.41.1623726306662;
 Mon, 14 Jun 2021 20:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <87im2s5jjm.fsf@evledraar.gmail.com> <20210612050711.4057-4-worldhello.net@gmail.com>
 <xmqqim2hyuj1.fsf@gitster.g> <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com>
 <xmqqk0mwylhc.fsf@gitster.g> <CANYiYbG6bKwheThWz2ecHUTh7JFmTsi-F9FtYkcoS0az=f=m6Q@mail.gmail.com>
 <0pqq6s9-n238-95ss-nsqr-42o75sr933r@syhkavp.arg>
In-Reply-To: <0pqq6s9-n238-95ss-nsqr-42o75sr933r@syhkavp.arg>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 15 Jun 2021 11:04:55 +0800
Message-ID: <CANYiYbFsqj9j_UT9-mF+BSOAHU4=On+BUxCU4w6rXhhMaeo=zg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 15 Jun 2021, Jiang Xin wrote:
>
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:17=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > Jiang Xin <worldhello.net@gmail.com> writes:
> > >
> > > >     /*
> > > >      * Let's insert a suffix to clear the end
> > > >      * of the screen line, but only if current
> > > >      * line data actually contains something.
> > > >      */
> > > >
> > > > So my implementation is to try not to break the original
> > > > implementation, and keep the linelen unchanged.
> > >
> > > I knew what you wanted to do from your code---I am questioning if
> > > that "only when something is there" was really sensible, or if it
> > > was just attracting bugs.
> > >
> >
> > @Nicolas, what's your opinion? Is it ok to add clear-to-eol suffix to
> > each line even empty ones?
>
> That would be the simplest thing to do.
>
> But there must have been a reason for doing it otherwise. I just don't
> remember anymore.
>
> Maybe it had to do with progress reporting that does a bunch of
> percentage updates followed by '\r' to remain on the same line, and at
> the end a single '\n' to move to the next line without erasing the final
> status report line. That would be a case for not clearing empty lines.
>

Thank @Nicolas for helping me understand the story behinds the code.

If there are two sideband #2 packets like this:

    PKTLINE(\2 "<progress-1>" CR "<progress-2>" CR)
    PKTLINE(\2 "<message-3>" LF "<message-4>" LF)

We should append clear-to-eol suffix to "<progress-1>", "<progess-2>"
and "<message-3>" to erase the last message displayed on the same
line.  Even though there is no need to add the clear-to-eol suffix to
"<message-4>", always adding suffix before line breaks (CR or LF) of
nonempty message make it simple to program.

If there are empty messages in sideband #2 packets like this:

    PKTLINE(\2 "<progress-1>" CR LF "<message-2>" LF)
    PKTLINE(\2 "<message-3>" LF)

For the empty message between "<progress-1>" and "<message-2>",
nothing to display and no need to add clear-to-eol suffix.

The issue this patch try to fix is like the following example:

    PKTLINE(\2 "<progress-1>" CR "<progress-2>")
    PKTLINE(\2 CR "<message-3>" LF)

The message "<progress-2>" is displayed without a proper clear-to-eol
suffix, because it's eol (CR) is in another pktline.

Since we can distinguished this case by checking the size of
"scratch", IMHO, it better not add suffix before all line breaks.

--
Jiang Xin
