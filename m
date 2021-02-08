Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D450C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 04:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2095064D73
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 04:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBHEbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 23:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhBHEbP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 23:31:15 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB3C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 20:30:30 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id y11so13032652otq.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 20:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XltloPaFKnDun1X+3fSwhYkbblv6ejAqEjJk+GiR7Ws=;
        b=JZebkFhY57fZaV4IWxHiCRgY5i+u/nd450vudmWyLa8TpzHxI/q6CZrCFm0xAcrDCP
         rbUjiXV3rz6+Px/Donse7sY4rhp30lTWCPgWOQh5iZ+KTsecgLpWw3oCGt/WeSqfN2za
         mrmYwMmkHfsy81XX4/SkqnPsY6TrZoiiAAz7jxqQLZ1NT/RfBW7/B+zPab5EHB7et2H5
         8dWTOzKI7Xdi3dIQOjT9nN4MyRlkPBmXznq5PcKeljx8wslODoHI3NjN+Ve5oZJF+yvj
         ZyWbJVbq3zAZ7zq/JWTOUdZeRjzOCJF18NOX99Jouspx40xP5EHRfX9VOQ45mQdmcjBc
         JnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XltloPaFKnDun1X+3fSwhYkbblv6ejAqEjJk+GiR7Ws=;
        b=M96Z3h/mtweV4j46huNfPrIvGx4GvFLvVPvqTax67sUxeaqwnnL41P0ccGtwlLF61i
         B8T+zIt9jL76mOd99uyVaRNKaeAqAw7idODU94pN1PRAUu23h0rKdh6hjhlYiJA4eSUp
         bhp8AEtNdeN+MUt/tMBm78jdaq128HOaarbCo7ki5XZx1NOLwtZgSV1OXjV6C6GxW700
         gTb+UFfQgMon/fBUf8UV0rnftGAormIvdJ8M2IBRzGlK4lKin6fErFyPnoSaaaI0Fu89
         epo/kWbpidauqR/IQSujYZ+t8dyYwSli07eipbBJn9ECbLAu62kibndi9pt8Nqgn/epA
         SsNw==
X-Gm-Message-State: AOAM532gOQjutFW/2TA9ejrAglyM380UvVlOYFzdkQ74XRqup37qwBtT
        Ix4IpdI63UL+6Ts2R8rk4P8GEmB5/FTdVwIs7qM=
X-Google-Smtp-Source: ABdhPJye+oktMnuUufJYzvVuAE0+kELWRtwdvAAVNpPjX/QeLdm9QXyRNS/wN+5+4jYsTdqQr8Bh9ktS6+GKFO8Nc0U=
X-Received: by 2002:a9d:313:: with SMTP id 19mr11249641otv.147.1612758629381;
 Sun, 07 Feb 2021 20:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210207181439.1178-7-charvi077@gmail.com>
 <CAPig+cTDT5Hct7dUTY93nO+P5-US=ZokuGhOQeELPpZwQGzf=w@mail.gmail.com>
In-Reply-To: <CAPig+cTDT5Hct7dUTY93nO+P5-US=ZokuGhOQeELPpZwQGzf=w@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 8 Feb 2021 10:00:18 +0530
Message-ID: <CAPSFM5f0pYv_0wJFw61wQnWP_cPVA8Baz6HQLcrBsB=zCkNqvw@mail.gmail.com>
Subject: Re: [PATCH 6/7] t/t3437: update the tests
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 8 Feb 2021 at 00:13, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
[...]
> Typically, if you find yourself enumerating a list of distinct changes
> like this in a commit message, it's a good indication that it should
> be split into multiple patches, each taking care of one item from the
> list. A good reason for splitting it up like this is that it's
> difficult for reviewers to keep the entire list in mind while
> reviewing the patch, however, it's easy to keep in mind a single
> stated goal while reading the changes.
>
> Having said that, I'm not sure it's worth a re-roll or the extra work
> of actually splitting it up since you've already been dragged deeper
> into this than planned, and these are relatively minor issues.

> (Returning to this after reading the remainder of the patch, I did
> find it reasonably confusing trying to figure out which changes
> related to each other and to items from the list above. It would have
> been easier to reason about the changes had they been done in separate
> patches. Still, though, I'm not sure it's worth the time and effort to
> split them up -- but I wouldn't complain if you did.)
>

Agree, I will split this patch.

> More below...
>
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> > diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
> > @@ -8,8 +8,10 @@ test_description='git rebase interactive fixup options
> >  This test checks the "fixup [-C|-c]" command of rebase interactive.
> >  In addition to amending the contents of the commit, "fixup -C"
> >  replaces the original commit message with the message of the fixup
> > -commit. "fixup -c" also replaces the original message, but opens the
> > -editor to allow the user to edit the message before committing.
> > +commit and similar to "fixup" command that works with "fixup!", "fixup -C"
> > +works with "amend!" upon --autosquash. "fixup -c" also replaces the original
> > +message, but opens the editor to allow the user to edit the message before
> > +committing.
> >  '
>
> I had trouble digesting this run-on sentence due, I think, to the
> mixing of thoughts. It might be easier to understand if you first talk
> only about the options to `fixup` (-c/-C), and then, as a separate
> sentence, talk about how `amend!` is transformed into `fixup -C` (like
> `fixup!` is transformed into `fixup`). However, as this is just minor
> descriptive text in a test file, not user-facing documentation, I'm
> not sure it matters enough to warrant a re-roll.
>

Okay, will change it.

> >  test_commit_message () {
> > +       git show --no-patch --pretty=format:%B "$1" >actual &&
> > +    case "$2" in
> > +    -m) echo "$3" >expect &&
> > +           test_cmp expect actual ;;
> > +    *) test_cmp "$2" actual ;;
> > +    esac
> >  }
>
> The funky indentation here is due to a mix of tabs and spaces. It
> should use tabs exclusively.

Oh, thanks I will correct it.
