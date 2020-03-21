Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE6C4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F75720754
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="uoNd68n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgCUWnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:43:03 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35558 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCUWnD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 18:43:03 -0400
Received: by mail-lj1-f182.google.com with SMTP id u12so10512291ljo.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfqICplvYYdba9RwjaAI/eYsUKpR4I9W0Lar0/LoI3M=;
        b=uoNd68n/u4zKuyXIMXdmh7mnZcf4YXWtKYnd3ANTwLm6v2mC87jq8j3uUYr4nflYKX
         loyEZPpfTQ/zjbF42T136FjWxk1dEX6lL7I/IhHdGJn0ZMB5l8Oc7DLQsU8Hyx7XKOMp
         HVfFtyerG1nSkqBRyLHAH8H41aj8W5mOqho8QzJFhNCOaGKm24JvwXwEm9c3jP1i5X2G
         fzue+BL6LT0OdcRotaN5yTQXVaRKehKkXzpxt9Ps2GH5RVKspru+ksHM+OWEzOOyyGVY
         +yIknIBLu/HKNTHkWzHeejt8UfqcXtBrMKBHWcHc64e+L4iggzM5T0StfxZc90OTbGat
         HDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfqICplvYYdba9RwjaAI/eYsUKpR4I9W0Lar0/LoI3M=;
        b=nmxQh9GIiqHJKbMLbbMdDgeUUAkQrvihJZ78J1l0AFD8RUf4lMtfiHGbUado8hvGBe
         qrgply/SXSIg9pDf2xt0n7L8VUjr/ePo9TkZVg10h8/Fov9VxQYkejxpe/p1jIaDwwE1
         oIQ6AvmOPg0b78WDdj2unwuqW3J7fni/ckwDKe0e8QvRhy3ZRwyvHWgjW7WKrPsa+l/g
         88Us7edg/JfVyvLfVU8XTLadBeYgSbsSo91POeQBf3Hm9ljdoSBxzMCfYy1kNLSqN25Q
         MVllj0mNldo5/5BzPzrmrJeWq8KpiN6oVOZ1sY3ZYwMCxxucps6V4ZwaXF9FxcTZZKOG
         M7XQ==
X-Gm-Message-State: ANhLgQ1LWg/og7mCcG1/+uhFKbG7hx+20I5HEKuwLrkdSRkEmulF8Y8X
        AOhi7weXUecqCOLeO/TyUqaWJ8l+Io3aP6x7LUwMIg==
X-Google-Smtp-Source: ADFU+vv0TpZ/jwiBKBSOkkt5wRK1tagHrjYLGKLJUrJ9G8VMGlShEdeOIA0HQRqYQ8pbI+drUi23bnfSSrPNqQjqTrI=
X-Received: by 2002:a05:651c:228:: with SMTP id z8mr9788432ljn.71.1584830580986;
 Sat, 21 Mar 2020 15:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
 <7a6a8197dcd58e8690892d03cb904dd1eec5d7c1.1584818457.git.matheus.bernardino@usp.br>
 <xmqqtv2h8oac.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtv2h8oac.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 21 Mar 2020 19:42:49 -0300
Message-ID: <CAHd-oW6V4cTpf4L-usGYEOMrn_VOY7ajMpBeLzfs_NTyi8pbxg@mail.gmail.com>
Subject: Re: [PATCH v2] test-lib: allow short options to be bundled
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 5:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > +opt_required_arg=
> > +# $1: option string
> > +# $2: name of the var where the arg will be stored
> > +mark_option_requires_arg ()
> > +{
>
> "{" on the same line, just like you did for parse_option below.

Thanks. Will fix.

> > +     if test -n "$opt_required_arg"
> >       then
> > +             echo "error: options that require args cannot be bundled" \
> > +                     "together: '$opt_required_arg' and '$1'" >&2
> > +             exit 1
> >       fi
> > +     opt_required_arg=$1
> > +     store_arg_to=$2
> > +}
> > +
> > +parse_option () {
> > +     local opt="$1"
> > ...
> > +     case "$opt" in
> > +     --*)
> > +             parse_option "$opt" ;;
>
> I think J6t's suggestion to the previous round still has merit here.

Yeah, I agree with your last reply that it makes the codeflow clearer.
I'll wait a bit to see if anyone else has other comments about this
iteration and then send v3 with both changes.

Thanks.
