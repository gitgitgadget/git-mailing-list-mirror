Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8E5C4332E
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F5D64DDA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380398AbhCDAW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349073AbhCCIQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:16:19 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E4C0611C0
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:41:31 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id g8so19054185otk.4
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9XENDzkwfD8R2L1+ltLwmuXfCjC/DWckb7M1SmCYH0=;
        b=l2J+OaorJxGmH/Onjhs9ODrA0hawUmtShaqTIzDTYuOhXKM//NmfduXT1jiMduDhsc
         et47BMgMC7trJWMa9qElasz3rNNzrAzMabD8ruJ9Uw4Yu32RmDICBEe8LE6mORcxb99N
         Lun58cbRqO6rnUX6gdEkwK99ZwbuDHrMJUFXBnU6zintFifQawDIR7csN6aXTZsK3O3W
         ZGn61E1bchRCZJX4sABoNDQw49BLB5Op6xd2OwAb0dMwtzV+JQs3At/x1PiptFSTsKNV
         Btf2j/rUR8+dp9hWiaU3LM9k4Tbn0xkB4P5E6eKeqFJxOeabNquPoVq+W0fr9ZCEW1wr
         RJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9XENDzkwfD8R2L1+ltLwmuXfCjC/DWckb7M1SmCYH0=;
        b=iIQKSCitaDt0SlzPoBju+KSmaYjV3XAa9N85bjrgDE8ZRdFwsgeex//qgtQ1YnmUXr
         VzgrPPZdALVQ4YdzkyKClLr5GHlwUsrJsmS4gKvNQiYBIA6VipmN9Sh3WMXmHd1XhWZq
         Dzs9nCO+DybMZBXOLDuI18Sc6sirdFJapIFmTsRO9usEaQgAIQkZS7+Yw/XXELW7vQKk
         TWxw+ntDb3T8AGAQI9vZGVVb64Cctvpa6wHXC7nPdZnpUYNtvxTLG1pHMWSnAzCR0ugG
         V4QRmB/yNfkEmUpzoDmuk4FSykCajRgPyjVpPPaG407opEUe52wEAJjJhMArPRHFhLAT
         vNcA==
X-Gm-Message-State: AOAM530Szn62AIB6HjKOK7i4O3FOLpH5f0KbuQuH9/LgIXnW7FA08RfZ
        jKMYoM2YHQJq2iqA+s1UcsQSds3Q+9xdcFX2X48=
X-Google-Smtp-Source: ABdhPJzjOnJXjRs8ZZIudLJQtXGXAmBY2G1OgT/XE/DPzFoXoZbtVEsntWVkBex8uHDPZw0PYRUOpqFNId7fY4b28Aw=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr21551174otq.210.1614757290749;
 Tue, 02 Mar 2021 23:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com> <xmqqlfb6mrnx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfb6mrnx.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:11:19 +0530
Message-ID: <CAPSFM5fmK_3rFfTbD7o3qCcYYeMXoX7K-HhGorXDPcFseBEDzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 04:02, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> >> +               if (len && fixup_message[len] == ':') {
> >> +                       fixup_message[len++] = '\0';
> >> +                       fixup_commit = fixup_message + len;
> >> +                       if (starts_with("amend", fixup_message))
> >> +                               fixup_prefix = "amend";
> >> +                       else
> >> +                               die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
> >
> > I haven't read ahead in the series yet, but I presume you're making
> > this code extra generic because you plan to support additional `fixup`
> > options (such as `reword`), but I wonder if the cognitive overhead is
> > warranted or you could get by with something simpler, such as:
> >
> >     if (skip_prefix(msg, "amend:", &arg) ||
> >         skip_prefix(msg, "reword:", &arg)) {
> >         ...
> >     }
>
> You still need to compute "len" because you'd want to tell between
> --fixup="HEAD^{/^area: string}" and --fixup=bogus:HEAD (the latter
> would want to say "no such variant 'bogus' for --fixup", but the
> colon in the former is not the end of the name of variant.
>
> So, skip_prefix() would not buy us much, I guess.
>

Yes, I also agree.

> But the use of starts_with() in the original patch is bogus, I
> think.  fixup_message[] by the time the comparison is made is
> NULL terminated at where the colon was originally, so we should be
> doing !strcmp() to reject "--fixup=amendo:HEAD~2" with "no, 'amendo'
> is not a valid variant name for --fixup option".
>

I am not sure about this because we used the starts_with() so that it can
support the _any_ prefix of `amend` or `reword` i.e to make all below
like combinations possible :
--fixup=a:HEAD~2
--fixup=am:HEAD~2

So, I am not sure if we need to replace it with !strcmp and work for
the specified prefix only ?

> > Also, am I misreading when I think that the use of starts_with() could
> > be replaced with a simple strcmp() since you've already inserted a
> > '\0' immediately after the final alphabetic character?
>
> Correct.
>

Same reason for using the starts_with() applies for this part also
after inserting the '\0'.  So, I think we can keep starts_with() ?
