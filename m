Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF627C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982DE64E7A
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBIHUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhBIHUE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:20:04 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78C1C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:19:17 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id m7so18419243oiw.12
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YAGQ+Au4ZhbjJ01WlATpbC0J+TA686xKBaGGu+fauo=;
        b=sjWM3Co9RZk5XpiPLoCLHCseM8tj6RUetQhNC0NA1JNwmNrA0BISeQi0H4ACJLh1IV
         JGKhBA3qrBQtiBRJ8aGEDPKTDJVtBx+y2EEtnWdwq82dO7XNv9lH6a5rrHFUu3xZk+kP
         Xgn7TwOKSdMFKgLSXLZkkU5T6fegMDpI3c10EJwRju08HORxJCsP4LQaUZ7w/b2EKfwC
         ahgnN8IYICMqIrmZhoJjvKNS0mreyKtbhNfnkuHb1o1vXe/K3LlpkxpozjAFKVixgSaq
         Y2ZBwNzx2EU8KB3z8Hy93xPKdZTGanCaTpK45xilGejvw83OH3zpGxesvx++gkwBQMRB
         fKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YAGQ+Au4ZhbjJ01WlATpbC0J+TA686xKBaGGu+fauo=;
        b=R6MZ3774QB7a7/bbjOwZ5vzEpsbO8McBmJ/7RijJL5XS8TcQ/jcql0SLlhwFCGuBZr
         Pt2+ZAmRCw7zP8ll5xdXMqbVdlPmiPxujgAm/jdhxu2qr485gxy9lmJouWL5vkeXSpUk
         KFkcB6wPxTdfjsWdAk8hZkRrCy/qYx9MQ4c6neij3biF26MrekNrbXFrEPOEGF/DcGvO
         sGXQReG48W5vaeNPfPgFZA5unl/jWq+/7Nvgt/c3QcbzX2r8PLTmLGFHG3meITgAZ41/
         ax2vmlygkfXZM8O9rXyrxNlYQTDi0Kuip53h56QYShaKtzJzAcrA02/BFV2YFYMqqP2e
         O0Zw==
X-Gm-Message-State: AOAM532M2vLEPg25ZAv4l0IJwsjLfYHOiwlf3koY3bgwc8oAY9/95LI3
        zBcQcA2D9+fdPbDwNuLWlhys1fAbj4yQPXVYEoWe9q+lf/0=
X-Google-Smtp-Source: ABdhPJwi11UnKs+j8BH70I5UqHS3Rp4eV/SGCdKqKKTqE45CLhvyVcGQ4znDEUYLJs72S4TvD8rs+5sjbRA1E0GmEsA=
X-Received: by 2002:a05:6808:c:: with SMTP id u12mr1539802oic.163.1612855157230;
 Mon, 08 Feb 2021 23:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210208192528.21399-5-charvi077@gmail.com>
 <xmqq1rdq5jis.fsf@gitster.c.googlers.com> <CAP8UFD1GV2s4SjB3YaT5qiW+E12-hikMEiFoU_LV81aK14g8bA@mail.gmail.com>
In-Reply-To: <CAP8UFD1GV2s4SjB3YaT5qiW+E12-hikMEiFoU_LV81aK14g8bA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 9 Feb 2021 12:49:05 +0530
Message-ID: <CAPSFM5fdpvb9uOFpZvy_Le3+33nbq6yE8ZBDxAXBBDgNhYU0dg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] t/lib-rebase: change the implementation of
 commands with options
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I agree with that, and discussed it with Eric. See:
>
> https://lore.kernel.org/git/CAPig+cSBVG0AdyqXH2mZp6Ohrcb8_ec1Mm_vGbQM4zWT_7yYxQ@mail.gmail.com/
>
> The discussion was:
>
> -----------------------
>
> > > > However, "fixup" is a very different beast. Its arguments are not
> > > > arbitrary at all, so there isn't a good reason to mirror the choice of
> > > > "_" to represent a space, which leads to rather unsightly tokens such
> > > > as "fixup_-C". It would work just as well to use simpler tokens such
> > > > as "fixup-C" and "fixup-c", in which case t/lib-rebase.sh might parse
> > > > them like this (note that I also dropped `g` from the `sed` action):
> > > >
> > > >     fixup-*)
> > > >         action=$(echo "$line" | sed 's/-/ -/');;
> > >
> > > I agree that "fixup" arguments are not arbitrary at all, but I think
> > > it makes things simpler to just use one way to encode spaces instead
> > > of many different ways.
> >
> > Is that the intention here, though? Is the idea that some day `fixup`
> > will accept arbitrary arguments thus needs to encode spaces? If not,
> > then mirroring the treatment given to `exec` confuses readers into
> > thinking that it will/should accept arbitrary arguments. I brought
> > this up in my review specifically because it was confusing to a person
> > (me) new to this topic and reading the patches for the first time. The
> > more specific and exact the code can be, the less likely it will
> > confuse readers in the future.
>
> -----------------------
>
> > So, if I didn't know you folks have invested enough hours in this
> > patch, I would have said not to do this, but it is such a small
> > change, its effect isolated to only those who would be writing tests
> > for "rebase -i", it may be OK to let them endure a bit additional
> > burden to remember an extra rule with this patch.  I dunno.
>
> I would be ok with dropping this patch.

Earlier from the discussions I thought it would be ok to make separate rules for
command taking arbitrary arguments(exec) and the command taking single
option(fixup).

But I also agree we can make the same rules and will remove it.

> It might be a good idea to
> improve the documentation before the function though.

Okay, Maybe we can improve like below:

update the current comment:
# "exec_cmd_with_args" -- add an "exec cmd with args" line.

with:
# "_" -- add a space, like "fixup_-C" implies "fixup -C" and
#        "exec_cmd_with_args" add an "exec cmd with args" line.

Thanks and Regards,
Charvi.
