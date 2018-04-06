Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F511F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDFFTR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:19:17 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:34612 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeDFFTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:19:17 -0400
Received: by mail-pl0-f44.google.com with SMTP id z5-v6so3846242pln.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q2/nDfsHbt5iZV64CxJOiegxKBtWi2fF565HOi4TqbE=;
        b=RaMTxG074f2I3/u14YP525pjA+VgUkVk6kS6h+N3sPP6FpYH7fEgZR68wKTng4nu9G
         VHJQsbxZaGMKdpLYZsULQCz7nbaL6nn6vPfAgb7TeCm9MwfsGhHx6HXWZAbQj0GgK7lh
         ylwPhUAf63tcc5W8ub6uSX4cllEAP/5RdbrTqBdPBI7sordK3275EYqyXNUR2h/6K1lE
         ltIUJRo8bhweXfx59XVr5GqzwGXKb9z2mWPLMHUsxc4S0o5BNFgilLd1QIDwxwW9InAE
         ePEd/7JsAkxmPKEN4DEg3KwmRKiaNnVhiIOb/93Avw9v9uTJUHhClCUbySQMAOrClvTG
         5LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2/nDfsHbt5iZV64CxJOiegxKBtWi2fF565HOi4TqbE=;
        b=VGRmXSW+GwY+ou12Bx0MmzNPwa2rAZjPBKVDWTDuIAzga5QRxjg7KuB2nVQ4DeN62/
         L9ZXXy3twVg2rJlS8HtCAaIV9Tosmf7jusVHMuGTo2FI8IaQWFakdSsqZUPVw3xg5Ig6
         NUq5fzVc8n52vxQPqnc0XC/eqC/GPW0YgDR/+iX4qLj7OR3Ge9J5JVQ1bTom0xQprdYy
         qi/IG5j+vs/OGW0+Doa/F2nkZn7CDeTNaCOiYIi/VdDq1U+ZaFfbVqc2Z6kZqFo4u4AB
         f5qvCDXhdyMQUlfpdghD9NMTqa41JJdfu479uvR5JSgv6aPbL/oyl6ZtYUFpRjaZrYc0
         ig4w==
X-Gm-Message-State: AElRT7FqtU5gfbIKIiSjRb46lnHvaG6109tbq3hDmDqwWOuwRuV/4b7G
        e7jkz7Ufyrqtd39c8Oebx+vSZw==
X-Google-Smtp-Source: AIpwx4+YuM89WeNg5show81k3VF3Ls8uAbsGWIf5rHV0uiMBFP4ywNNgQVlDNsr6g/FyB4zQ9xP+Hg==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4-v6mr25903118plv.312.1522991956408;
        Thu, 05 Apr 2018 22:19:16 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id y2sm9290729pgv.38.2018.04.05.22.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 22:19:15 -0700 (PDT)
Date:   Thu, 5 Apr 2018 22:19:14 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180406051914.GB53143@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522893363.git.me@ttaylorr.com>
 <20180405020040.GC8879@syl.local>
 <CAPig+cSr744Y293qvgLG8jLHdNsGypkHU6QUQ-AcOyk=-JAbDw@mail.gmail.com>
 <20180405224051.GF29117@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405224051.GF29117@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:40:51PM -0400, Jeff King wrote:
> On Thu, Apr 05, 2018 at 06:29:18PM -0400, Eric Sunshine wrote:
>
> > > +ensure that the variable(s) are of the given type and convert the value to the
> > > +canonical form. If no type specifier is passed, no checks or transformations are
> > > +performed on the value.
> > > @@ -160,30 +158,34 @@ See also <<FILES>>.
> > >  --list::
> > >         List all variables set in config file, along with their values.
> > >
> > > ---bool::
> > > -       'git config' will ensure that the output is "true" or "false"
> > > +--type <type>::
> > > +  'git config' will ensure that any input output is valid under the given type
> > > +  constraint(s), and will canonicalize outgoing values in `<type>`'s canonical
> > > +  form.
> >
> > In response to my question[2] about whether the typesetting "[type]"
> > meant that it was optional, you responded[1] that it was not, thus
> > correctly changed the typesetting to "<type>". However...
>
> Right, "--type" without a specifier means nothing (also, I missed this
> in my review, but "input output" in the quoted text?)

I missed this too; thanks for pointing it out. I have amended this in
the forthcoming re-roll.

> > > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> > > @@ -1622,4 +1623,21 @@ test_expect_success 'later legacy specifiers are given precedence' '
> > > +test_expect_success '--no-type unsets type specifiers' '
> > > +       echo "10" > expect &&
> > > +       git config --type=bool --no-type core.number >actual &&
> > > +       test_cmp expect actual
> > > +'
> >
> > What does --no-type mean and why is it being tested? If this is an
> > explicitly supported user-facing option, should it be documented? If
> > it's not meant to be user-facing, then why are we enforcing its
> > presence and behavior via a test?
>
> It would be the same as if no --type option had been given. The current
> documentation says:
>
>   If no type specifier is passed, no checks or transformations are
>   performed on the value.
>
> That's retained in the DESCRIPTION section, but it may be worth a
> mention of the "--no-type" behavior in the OPTIONS section, too. I
> dunno.

Fair; my inclination is to document it, since it is potentially useful
for scripts (as I mentioned in my mail to Eric).

Thanks,
Taylor
