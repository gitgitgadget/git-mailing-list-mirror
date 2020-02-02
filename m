Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B08C35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 20:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A25206D3
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 20:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="Amraix6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgBBUrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 15:47:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36593 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgBBUrs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 15:47:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so15420910wru.3
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 12:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hvwAhkhWzLNK2U0mMqeHfoEnrwi5IqWgrjDVWwvL6QQ=;
        b=Amraix6SSofmZq5hn0M6nDKpcmYHXeTPCXq7WxlWBiofgQYo050smtT16TkG7pp//b
         KAbd4g4KV/09B5ntdYjMWJsZR5Lj41CaKo0S4Z66EAL1gDrUvTeoI/6nnzkAaapJLNYh
         f+GlE6e6rTv3oIPpAFaNaDMf65rAgGDhFDcfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hvwAhkhWzLNK2U0mMqeHfoEnrwi5IqWgrjDVWwvL6QQ=;
        b=RDoenABX0bUTXPp89yIxw6OftdFLicujM1v9FLjXMgDMjOGfaG/yMGCTP+uHFiHOUC
         Fn8YHBuglVsK1hN0ZK8hSV/6HQlY/NDTS8IHugeA2iey+F+0LlJcUkOThzNuJmdzA3Fv
         bHED4KIzz6kzR+eJTNVRqfJOgnLM4/EDlSatDMwjfNYKo3RdCBS+DG3QXEHNuwqRS7Kj
         NlR2O0CZEURZPNxdNXsN/zeCvAN3xOQkosTVTttFWWbBgb7HqlPQd8vG8zJ0x7pd85G/
         Z3PXSm64mGk1g0UcRBKh3LWS3OkygCmx0Z9TRgvvTekiFjLtcg/rvKJTWyXOrARv8pJo
         c75A==
X-Gm-Message-State: APjAAAUpF+3fGo7uWT9hEeCeGSgaBKQ9ETUi9bPrjiAQ8Sr04wgThPmK
        3Tt1PCcL/EKgwXFe6GEFtnMScA==
X-Google-Smtp-Source: APXvYqzRAkcpgnabU9cvGPDVH2TZCGoWOPec7lz6OhVu3U8B7hosdGHXSzddrxzdRWsIceeWmfLUng==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr11375791wrn.245.1580676466872;
        Sun, 02 Feb 2020 12:47:46 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id a13sm22638565wrp.93.2020.02.02.12.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Feb 2020 12:47:46 -0800 (PST)
Date:   Sun, 2 Feb 2020 20:47:39 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Phil Hord <phil.hord@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-options.txt: correct command syntax
Message-ID: <20200202204739.GA24686@dinwoodie.org>
References: <20200202192226.29176-1-adam@dinwoodie.org>
 <CAN0heSoxgsNDbi_tbxEoSSaGOxoJYArqYa-cLu1sPWVvH6wkFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoxgsNDbi_tbxEoSSaGOxoJYArqYa-cLu1sPWVvH6wkFg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday 02 February 2020 at 08:45 pm +0100, Martin Ågren wrote:
> Hi Adam,
> 
> On Sun, 2 Feb 2020 at 20:24, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> >
> > Change the example arguments in the description of the -G diff argument
> > to be consistent throughout the description.
> >
> > Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> > ---
> >  Documentation/diff-options.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> > index 09faee3b44..84a74cb2da 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -561,19 +561,19 @@ Binary files are searched as well.
> >  -G<regex>::
> >         Look for differences whose patch text contains added/removed
> >         lines that match <regex>.
> >  +
> >  To illustrate the difference between `-S<regex> --pickaxe-regex` and
> >  `-G<regex>`, consider a commit with the following diff in the same
> >  file:
> >  +
> >  ----
> >  +    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
> >  ...
> >  -    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
> >  ----
> >  +
> > -While `git log -G"regexec\(regexp"` will show this commit, `git log
> > --S"regexec\(regexp" --pickaxe-regex` will not (because the number of
> > +While `git log -G<regex>` will show this commit, `git log
> > +-S<regex> --pickaxe-regex` will not (because the number of
> >  occurrences of that string did not change).
> 
> I don't think this is correct. "<regex>" is a placeholder and this
> example wants to use a real-world regex instead of the placeholder.
> Maybe this could be made clearer by having an example that does not try
> to grep in regex-code using the regex "regexec\(regexp".
> 
> Maybe instead of "regexec", "regexp" and "regmatch", this example could
> use words from some other domain? Would something like this be clearer?
> 
>  To illustrate the difference between `-S<regex> --pickaxe-regex` and
>  `-G<regex>`, consider a commit with the following diff in the same
>  file:
>  +
>  ----
>  +    return !frotz(nitfol, two->ptr, 1, 0);
>  ...
>  -    hit = !frotz(nitfol, mf2.ptr, 1, 0);
>  ----
>  +
>  While `git log -G"frotz\(nitfol"` will show this commit, `git log
>  -S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
>  occurrences of that string did not change).

Ah, thank you!  I had completely misread what these examples were trying
to achieve.  I think your example (or indeed anything from a different
domain) would have avoided me getting confused in the first place.
Although I'm much less fussed now I realise the problem here was
entirely my understanding rather than an error in the docs.

> BTW, I wonder what "in the same file" tries to say -- my hunch is we
> could drop those words without any loss of correctness or readability.
> Would you agree?

I think "in the same file" is meaningful here: as I understand it both
forms would find a commit that removed a line from one file and added it
back to a _different_ file, but only the -G form would pick it when
removed and added lines are in the same file.

Adam
