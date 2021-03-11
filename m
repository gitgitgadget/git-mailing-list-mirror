Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84BCC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBCC64F93
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCKRvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhCKRvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:51:13 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE2C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:51:13 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u62so8214412oib.6
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqUUuien511CwLDXG7NX8yvUByzriBySC06TSRsJWt0=;
        b=ocwJMgkL7+4t8KRo5N9/9zcdTTET1aDddwyVzgSjaFw7ckRIaH+LW3sF3D5Sbx3WF8
         Uaf7RKHA9k1PgpaujMWAsXlXw1OEsK28nLrSDQSdKdBnqdPJr9VXNAKm4d/wvYIS6y18
         DCqUVhfoZYCwDn08tB/x0D+gyhCJjKZmUjILYBqqH9DuBsGnlqftG4xOI3gAXfcpamIB
         bqgTCVoNRBu3mxS5ekd+fEt9sj+V+zg6dOFQ7gt7jMGIgl8bZCfP9Msb4gW7w99XRwlV
         SW9jrJWhkN6n3VrtocjqiYPxYWIvF1pOVmcHyp+5iObGxVzK0n29lodvoy0OwI/tbGM+
         xCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqUUuien511CwLDXG7NX8yvUByzriBySC06TSRsJWt0=;
        b=UoPA60zEBJQVMJ+I+Ugxgi3io+1eduh90ChK7BboU3AVsexMwiw66QFsdGb0V3LHWs
         MxBJq+PKWJfWDkjJKx4A0CRWT9f3t2H8rZwqo91lvfBBJWVGCPqcD0FzeLNDa8KvUKIX
         JqNSznqiSDilRbC1GUxi96LUTWR47paMykhV2urUdrOfF77dKDzRLduXhFWyUKbNjtlD
         CngD/xJgfXaVeRLwmvwmM8aZfUpbVwIukT61zM1KlLCv33AIuSR5QuC+h5wOGoJgNsCg
         CZ/VeMPwgNrX9t6mFordfI832FwCa/lhhlfGH/iaTS5pAfPA5H7DwgKeDUZzd9kirwvV
         P/Jw==
X-Gm-Message-State: AOAM533rsHcyHT7f30CwJiXGCyWocB4p3VDXoybv6WMECZXIYNw0cAiN
        /MAcnziOXIRP2nnpfAxdmUXPCqzc7nvAgOKPIgG0yWCvZ/M=
X-Google-Smtp-Source: ABdhPJz9l7VSHFZN9T0zrEDGLtwfNELhzDtyVsV4/RE5aCPLN1Bo9PKU+DxpMr7e6k8iHzs3t0m0FyNH/jmVwTSlP1I=
X-Received: by 2002:a05:6808:1a:: with SMTP id u26mr6943364oic.163.1615485072781;
 Thu, 11 Mar 2021 09:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
 <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
 <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com> <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
In-Reply-To: <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 11 Mar 2021 23:21:01 +0530
Message-ID: <CAPSFM5fc_TtSxFkLvMSN3sX18TLq9ijUQ0Aw8z0P+OG=BMGwqQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Mar 2021 at 22:38, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Mar 11, 2021 at 10:24 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > On Thu, 11 Mar 2021 at 11:55, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > > +               size_t len = get_alpha_len(fixup_message);
> > > > +               if (len && fixup_message[len] == ':') {
> > > > +                       fixup_message[len++] = '\0';
> > > > +                       fixup_commit = fixup_message + len;
> > >
> > > An alternate -- just about as compact and perhaps more idiomatic --
> > > way to write all this without introducing the new get_alpha_len()
> > > function:
> > >
> > >     char *p = fixup_mesage;
> > >     while (isalpha(*p))
> > >         p++;
> > >     if (p > fixup_message && *p == ':') {
> > >         *p = '\0';
> > >         fixup_commit = p + 1;
> >
> > Earlier we had discussed[1] keeping a separate helper function, so
> > that it may re-use it later. But I agree above is easier to get and
> > compact so I think maybe it will be ok, for this patch series to
> > replace it with the above and remove the function.
>
> I don't have strong feelings one way or the other whether you should
> use a function or inline it as I showed above, and since our aim is to
> land this series rather than endlessly re-rolling it, let's not spend
> a lot of cycles worrying about it.
>
> The one thing that does bother me, however, is the name of the
> function, get_alpha_len(), which tells you (somewhat) literally what
> it does but doesn't convey to the reader its actual purpose (which is
> something we should strive for when naming functions and variables).
> In that previous discussion you referenced, Junio mentioned that a
> future sub-option might want to have punctuation in its name. If that
> ever comes about, then the name get_alpha_len() no longer makes sense
> and needs to be renamed so it doesn't become a lie. Giving the
> function a better name up front would not only help readers now to
> understand what is going on, but would also help down the road when or
> if punctuation (or numbers or whatnot) become valid in a sub-option
> name. suboption_length() is one possibility. With a slight semantic
> change, skip_suboption() or latch_suboption() are other possibilities.
> Or, if you were to open-code the loop as I did above, then you might
> have a function named is_suboption_char() and use that in place of
> isalpha().
>
> So, if you do re-roll, I wouldn't mind seeing a better name for the
> function; but the rest is subjective and not worth spending time
> refining unless you actually feel that one style has a clear advantage
> over others.

Okay, I will rename the get_alpha_len() to skip_suboption().

Thanks and Regards,
Charvi
