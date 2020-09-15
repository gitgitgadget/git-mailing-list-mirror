Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C757FC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FE62064B
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+6ZMHAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgIOWDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgIOWDM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 18:03:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253DEC06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 15:03:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d190so5944232iof.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wPJiKsQoPEktBPKoTbLJfQsYuOBRUr/mERfGL8pmmGk=;
        b=J+6ZMHAwZhdLfnV5JLRN5kN2+sJGRC2u6fbLh4i09XI6pn9D1C4VjoKHhqKH9h1T2J
         HkIMHUojeVbqjGIV3+ZVV7i2hznEDonFb8VZMMBXwGylXpzBQysYETbhkzOTdrdDR7Hu
         y9bkXwEd5x0DY91g3D5EJ1Tsx2bcfLtPHOW61BJPhFDOz64qjYMecjcSiLF6FNpQB0K0
         j8gcA1sN2uxfpV+62cB0/awS3aINxWTNccN13RpcSYlXe2F7crcZ0/ogG4AJex5XSo7T
         zsi1e8FEDvq6y41FsyNw5MvUaJ3GH5PPhY1lNBNzwdnpciUkUTiSzbuMScqgeDcx/gzI
         rJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wPJiKsQoPEktBPKoTbLJfQsYuOBRUr/mERfGL8pmmGk=;
        b=Q46TAx160U2KNiCyOFuVIz8y6YlMdHBW2TgoTk0s0kIZAg7tnkujS+9fHLjXQDnO/V
         HoqqYmvbJmYE67Vb5r0LNtqRqClNwiKUTm1HYa1Kp4FzQirZ1BTVrYj/JQajR3x0VsNX
         rBqgkzfctfKJafjcCVrPg9x8L4p4T6DRhj1pTFqyTJ2EqA6DPuaLol1kZ1SGUzfXMYnt
         aTYmjvLE6SuIdBDduoVxQwPMBJ0daHNyMtTAO8V2s3TV9waMMDDee9PkqZsGlTlchUI9
         J3pvEiBAa7JVlqfvzKw0o81UNCMQzvaFSuMAUFJJ4jTof84krOW2Ga+WZMxIYuNUCsvo
         s85w==
X-Gm-Message-State: AOAM530ssvXbawoGPTPHkMPtzHDu4SpB4ercRdHRDGjW5FTSTxwRQBLb
        rACnS+3O6FGhLi98G5+ZwDtcz6ltulBNgptMa4Y=
X-Google-Smtp-Source: ABdhPJyKLhR6ZeDcjtIT/Z74AOKNgNyExZe3x46ykXIS8qo587KrA8rZTasBvlhP/r8RrAzXmOuuGEcx473GcFjLT8k=
X-Received: by 2002:a05:6638:242:: with SMTP id w2mr20091401jaq.32.1600207391322;
 Tue, 15 Sep 2020 15:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com> <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
 <xmqqimcezqs5.fsf@gitster.c.googlers.com> <CANQwDwc3-n4X16F1Xuf-y-yLeXoGRTeT5c=kVVFXH1E6P=ZEqA@mail.gmail.com>
 <xmqqzh5qyar4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh5qyar4.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Wed, 16 Sep 2020 00:02:34 +0200
Message-ID: <CANQwDwdgjV8ZTHKdUjEn5TKTXvTcODTXnbLEinWSQDYpZzfAvA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 15 Sep 2020 at 23:45, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>
> >> My gut feeling is that overflow handling needs to be there whether the
> >> field is 32-bit or 64-bit.
> >
> > Not if the size on-disk is the same as the size in memory:
> > timestamp_t is usually 64 bit (and even unsigned 64 bit epoch
> > would be enough - its range is over twenty times the present
> > age of the universe per direction).
>
> Yes, and "corrected commit dates" is about accommodating commits
> with absurd out-of-sync timestamp mixed in a history with commits
> with correct timestamp, right?  What happens if the absurd timestamp
> is near the limit of the range?  You do not have to live through the
> end of the universe---you only have to create a commit object that
> records such a timestamp, no?

Well, as Git stores dates using timestamp_t type, it wouldn't
be able to handle such commit dates anyway. Also, commit-graph
format has only 34 bits reserved for storing commit dates anyway
(32 + 2 bits, with 30 bits of the other byte used for topological
levels aka generation number v1).

As parse_timestamp is strtoumax, having textual representation
of timestamp not fit in 64 bits results in a range error (errno,
which we do not check, is set to ERANGE) and UINTMAX_MAX
is returned.

Best,
--=20
Jakub Nar=C4=99bski
