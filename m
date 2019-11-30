Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5540BC432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 16:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9F720732
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhu/AT+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfK3QiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 11:38:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37241 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3QiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 11:38:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id 128so20575490oih.4
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwPssNUgUhU++f1K9vX9F0TUuOTjhsYutWGmGRkxXLY=;
        b=vhu/AT+V5orDe3+qruON0LXqDEK9pLTERJcMvShb3RfZgevYEXlf/04ExEx6t9jmRD
         Yd6OnT1A2LDykIzbQhXRo4HVO2HJTfgKTy4o7yyL4Wnq1b6lPDpj50+ROQkCw8Z7Ihxp
         R2gWbV0SJQNdlTLpySVVi0AS49MYV8bKpMLAvOdrRNigZZPtrOtd4ra3VwEslz3YjMOe
         MQ/gtcoJINMSIv7OJvLC8g5HyEIPKZW2sMTYHZQ2dTHffWqgnjfdGA3ogHxAwJI2f7l3
         l8njFIHgbtf7ScQaPlQVZUEhcrvV4Vcr783mrwDYW2mkk2fj2Y62FHHKpm1KnlpIvkdx
         oxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwPssNUgUhU++f1K9vX9F0TUuOTjhsYutWGmGRkxXLY=;
        b=Q23/r4GvXeNaReEcP2HnDLMk1Te8YVzZ4On+6cDmEymzHrWoP+W1v/HICH4KIusxIh
         FBGRtArarH3uBJN9dMrKGHToSM6TEJoP9tst8EcdwJ5HAwaK5kixXGWFAWkLVj3+ANQg
         5Be81mWBEVyGCo6jUsvLCuWO8fg5n8sIOBxN/SFw+wDkxIW+lCGTWFt/InNFVTLBj0fF
         lVh/zw05qmztP134KCtwTfwGcYC9sIUrOfq11YYfuOKNiqfE4IHJOBmPUX+bDJCatoC4
         jReokZgCTA73N2h/l+Xv+RhB6kV3v1aZpC6dCuLIqBicwWWs/aHP6IRVDkt0GDgzXpQF
         AKpg==
X-Gm-Message-State: APjAAAUumprbmYYbD4wQzowUli0xEHsfW2a7aByyiF8ha0Q7293sCt6x
        a2PDUCA0rk0rVX66DsB8t++C5A8EewJfz20MdGY=
X-Google-Smtp-Source: APXvYqxE3cUAp7O8XpGusdbdfWS/oE5gbyezfrqE61AGq51maYOjuVTM249jEpLAZ3M772XlBznqNGBy5MuWaycnV1A=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr1272235oig.39.1575131885178;
 Sat, 30 Nov 2019 08:38:05 -0800 (PST)
MIME-Version: 1.0
References: <CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com>
 <CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com>
In-Reply-To: <CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 Nov 2019 08:37:54 -0800
Message-ID: <CABPp-BHPkwnbLR0xNaY3SphCpmR6QRA1j953c2hU7ZFpL38Nig@mail.gmail.com>
Subject: Re: git-rebase produces incorrect output
To:     Pavel Roskin <plroskin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 29, 2019 at 8:22 PM Elijah Newren <newren@gmail.com> wrote:
> On Fri, Nov 29, 2019 at 12:24 AM Pavel Roskin <plroskin@gmail.com> wrote:

> So, to summarize here:
>   * you have a case where the default 3 lines of context mess stuff
> up; but rebase --merge works great
>   * am doesn't have a -U option, and ignores the diff.context setting,
> making it impossible to force the am backend to work on your case
>   * rebase doesn't have an option to use the merge/interactive backend
> by default (nor an --am option to override it)
>
> Also:
>   * The performance of the merge/interactive backend is slightly
> better than the am-backend
> (https://public-inbox.org/git/CABPp-BF=ev03WgODk6TMQmuNoatg2kiEe5DR__gJ0OTVqHSnfQ@mail.gmail.com/)
> and will continue to get better
>   * The merge/interactive backend supports many more options than the
> am-backend, though the am one still has a few the merge backend
> doesn't.  Once the ra/rebase-i-more-options topic merges, --whitespace
> will be the only consequential option that the am-backend supports
> that the merge/interactive-backend doesn't.  (There's also -C, but as
> noted above, the merge/interactive backend already have access to the
> full file).

In case it wasn't clear above, the merge/interactive backend could
just accept the -C option and ignore it and do nothing, since it
already has access to the full file (thus why I consider the -C option
to not be consequential).

Also, I remembered and dug out a few more items about the default
rebase backend that might be worth including in this summary:
  * The am backend operates with incomplete tree information as well,
limiting what the merge/resolve/whatever can do and what information
can be provided to the user (see
https://public-inbox.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/)
  * The interactive backend, although slightly faster than the
am-backend (on p3400 at least), is slightly slower with split-index
which hasn't yet been investigated (see
https://public-inbox.org/git/nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet/)

> Maybe we should just switch the default, for everyone?  (And provide
> an --am option to override it and a config setting to get the old
> default?)

CC'ing a few folks for opinions on switching the default backend of
rebase from --am to --merge.  Johannes already agreed it was the right
path eventually[1], and Junio suggested the am backend should be
deprecated[2] and eventually replaced, so I was going to push on this
after some merge performance work but perhaps it's a good time to
query if it's time to switch the default sooner.

[1] See the end of
https://public-inbox.org/git/nycvar.QRO.7.76.6.1808311158540.71@tvgsbejvaqbjf.bet/,
also linked above.
[2] https://public-inbox.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/,
also linked above.
