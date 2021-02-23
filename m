Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F522C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C236C64E4D
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBWGFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhBWGFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 01:05:53 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B866C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:05:13 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id e45so5235252ote.9
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmi0l7XMKBa6YJNFv2I7jCP4PN52CzDD4RkcZbyIu3o=;
        b=ehSBkA6LSclwLRq5EHq34PnIriOILGiY9iOJLECHBAExT8qPgG8CEGHYIdGk2N5c83
         4d0pJq8P3SKqaYjHgW/B+PAwBbQlDmC6HjJRr4a6EsDmvB+TifKvf2md9pCxL3+QOwcC
         nBw+8yWyCQ/sEz+X0qduHJdEO7AqRHZ8bbe9giebvCYlMRK9OVIGN4RVLBRgixueDwSZ
         1gITeTw/BzBDCxSyevKD7iNMLhP21DhN3CTPvrwwPumZdDJCoV/UcYqjRQKVdVqP73Wa
         CtmSPPyR/Dx5zX0xUK6J6AY8qfgWDihmZScpo2YHFsZ1zJ382X5ykQ2R0IkutpR1CU1G
         09Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmi0l7XMKBa6YJNFv2I7jCP4PN52CzDD4RkcZbyIu3o=;
        b=Y108sckJr4EWXLPRBhB0So05Ne3i8z/3ZQq5JeNaYDpcMhykN40VNjIyQi8J1jil41
         Kpa6TnndLjKjjUCUvdound/reab2hp5G7wvMGsgr14142HrkdTXPHNICuQdDRzP4njOC
         oEpQf1hc6WH4OOSyvuY/pcmAlC08I1U7hsOedYEz0HdFcO2YU+M5ga4jPpjxx3vXspWE
         KmuHo0D8GSEtTP6r0th2hNEjUX8liSpaxNZUlf6CrtU7gg0F76imCMBWWAPYPEcCxxI1
         Gw6xvCTXK0tJuJaHAwY8JT/D8U2CNn3apQ5XjMGfnp94rhkO6rUDpqmyt/q/xFiINSuq
         PPoA==
X-Gm-Message-State: AOAM533Jg+KGRKGR6g66CbBjZUotFeB62pmvYdUhX208kXbjYTBmiVpC
        1DJuhB4nh8LyAMEygK9hWuc7BRcDx9osJn5zo00=
X-Google-Smtp-Source: ABdhPJy0GHUIkLOOiWOVnT6iFTlnKAU0c8jxUYB4r5PFF3f3CSnIywvLObX8ah0D1YadDmE7waKT57OjPOXU5Svig6g=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr15681790oth.184.1614060312339;
 Mon, 22 Feb 2021 22:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-2-charvi077@gmail.com> <xmqq35xulbj0.fsf@gitster.g>
 <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
 <xmqqpn0xfal8.fsf@gitster.g> <CAPSFM5eJNUdzy0CA1GNjNkqL_a7ivM8qydxvHf3208nznkG9KQ@mail.gmail.com>
 <xmqq4ki7bf9y.fsf@gitster.g> <CAPSFM5cRq9OfxypwTAsv3OFpTPM88e4_agTmFEGbaVyLi6Qbig@mail.gmail.com>
 <xmqqtuq599zj.fsf@gitster.g> <CAPSFM5dZ=CR21eqE7Y-4AssD9h0ddnUYpy4PSzWVaf8kzsLv_g@mail.gmail.com>
 <xmqqft1o80pe.fsf@gitster.g>
In-Reply-To: <xmqqft1o80pe.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 23 Feb 2021 11:35:00 +0530
Message-ID: <CAPSFM5fnxZ+WF9Df-naibeauNq1-e9=E=oh86xb9JOeeuHp3Jg@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 22 Feb 2021 at 23:05, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> If we were to make -m/-F incompatible with these new features, then
> sure, we'd notice the combination, show an error message and abort.
>
> >>than just accepting and doing useless thing, I am OK
> >> if we left them as they are.
> >
> > ....If we allow both `m` and `F` to work with `git commit
> > --fixup=amend/reword` with the same working as it is doing now i.e to
> > use `m` to write new commit message, upon `--autosquash`, If it is
> > okay? then I also agree to update the documentation more precisely and
> > include the uses when passed with `m` /`F`(not yet added) option.
>
> What would that more precise documentation would say, though?
>
> "'-m message' gets appended to the message taken from the original
> commit"?  Saying that alone, without explaining why doing such an
> appending is useful, would puzzle users and makes them ask "but why
> such a useless feature exist?" and that was why I was trying to
> figure out what it is useful for with you, which I think we have
> failed to do so far.
>
> My preference at this point is to error out the combination that we
> cannot figure out how it could be useful at this moment, so that
> users who find how it would be useful to come to us and present a
> hopefully good case for using -m <msg> with --fixup=amend:<commit>.
> I am assuming that allowing the combination at that point is easy,
> and the user request will give us a good use case we can use in the
> documentation to explain for what purpose a user may want to use -m
> <msg> to append a short string at the end.  The end users' use case
> we see at that point might even suggest that it would be more useful
> to prepend (as opposed to append) the message we get from -m <msg>
> to the original log message, and such a change will not be possible
> if we just choose to append without thinking through the use case we
> intend to support and release "we do not know what good it would do
> to append with -m <msg>, but that is what the code happens to do now"
> version to the users, as people will depend on the behaviour of any
> released versions.

Okay, I admit prepending the msg can be another way. Thanks a lot for
clarifying in detail, I completely agree with it and will error out
the combination for now.

Thanks and Regards,
Charvi
