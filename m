Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A92C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 00:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870ED206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 00:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA1JJTEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgFHA2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgFHA2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 20:28:16 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F69C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 17:28:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id n6so2927011otl.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qm7vYF5PIJMOKj/bOKl9Ybad1GlTRbXwNXZAT0LjwM=;
        b=mA1JJTEuA0KHixkkxTBji5CymlyZkSirlK9iG9hl0HEoMWaX4XDIdMft0M+f0dxGVb
         taqzpD7AtGDukiSfppAdUeaNQ0PIOb4oJrPmyy4qBA9xsCuxIPYQOZTlypIueb4NvwX0
         zxAcz/EOEfGnZIuiuHa3QcXPeyeohmW1+UkPvtzJ1N/fNCZdPww8aXiWP/Z709akz0A9
         HSuJ00+XK0icAz+fytyjRPlsLYGFt++1MwIs+FPgJQGLvKCLXsSDf+LuSsGBHoTBuhoW
         5DezRa+i7Z0YKrkKNNAH8FOYEVExSFzSbYNIay+VyOyLD+P9rQ3tLRCaGSz/EpIToJgH
         z0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qm7vYF5PIJMOKj/bOKl9Ybad1GlTRbXwNXZAT0LjwM=;
        b=D347G6YF8zGmikJbgcDFFsKbz2nAYZs5McZrpoq0GLe4aCcpT0PCtCNipyO3fP9Emb
         9vaiSRxD/16Kr641sLL2mKX/at1xWGUvNEEidhhHr8S9v4t6mixax5qe115+ceVJ/MYI
         Hcgvxrz9cHFNlvuvbRCVJuOmOQ6mNec0j717dgPRPD6hthofpCYaJZmFkSk88gCuZ+ru
         cD1zQYR5pPbFFoq9O9JrZ24TOKzzJdL9fTrvvLqJwT1O4ciOJ9EiOnwhH/u/MZ/mCIxy
         iAqXrfynLiLWiUPEOq5rKOXt7EFgGMm9QPP0gtwFulsORCbhg7Xo6WiDU2t2MBP2RyCn
         YLiw==
X-Gm-Message-State: AOAM533GXgOpFrwugRPRIE0YG/L0UlFOVFdBLG2eC+hBoFn5R5SCbcfv
        6FzBhCZ/AEqi2KoI0QtWSHyW3FPTFCjebkyBCOrFVHiq
X-Google-Smtp-Source: ABdhPJx8CNV3R2PYtjSkMExQZxSE+q0xF1bpEbXrv9h1YRDDng/Mmw7A/xwU2+MeNW7fzba7r32CbDCf3AfI2CeQQeE=
X-Received: by 2002:a9d:5612:: with SMTP id e18mr14835994oti.24.1591576094485;
 Sun, 07 Jun 2020 17:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2i4DCyovfV78rXwH+B+tNOeDM7rJCHWSCPFOiCv7mVR+56ew@mail.gmail.com>
 <20200605232413.GG6569@camp.crustytoothpaste.net>
In-Reply-To: <20200605232413.GG6569@camp.crustytoothpaste.net>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Sun, 7 Jun 2020 19:28:03 -0500
Message-ID: <CAD2i4DD8-iWi4WCCQyVuyy_oHzOxKqAXmcM82qWJdfx=kGn_bQ@mail.gmail.com>
Subject: Re: Standardizing on Oxford English
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Varun Varada <varuncvarada@gmail.com>,
        konstantin@linuxfoundation.org
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Jun 2020 at 18:24, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> I should point out that many of your arguments about U.S. English are
> true of English in general.  As a native U.S. English speaker who also
> knows Spanish and French, I can confidently say that even French, which
> many find difficult, has a mostly regular correspondence between letters
> and sounds, and, overall, a reasonably consistent set of rules for verb
> conjugations, albeit with many irregular verbs.  English, in any form,
> has none of that.  It is, as languages go, highly irregular.

Agreed, as I'm a native US English who knows French as well. But I
guess my point is that out of all of the varieties, Oxford English is
the most prevalent, international, and etymologically correct, which
is why I suggested it.

>
> I didn't write the text in question, but I suspect the reason is
> practicality: most open source projects use U.S. English, and most
> contributors to Git are able to write the U.S. variety.  It's hard for
> me personally to write Oxford English because I have never written or
> spoken it, and when I need to consult a reference, the one I have is
> from the University of Chicago, not Oxford.  I suspect many Canadians
> and second-language speakers from at least parts of the Americas are
> more likely to be familiar with the U.S. variety than Oxford or British
> English, although I don't know for certain.

The reference for Oxford is the first spelling on lexico.com, which is
a very widely-used resource. Canadian English is essentially identical
to Oxford except for the -yze set of words, for which Oxford maintains
the etymologically correct -yse endings. And second-language speakers
learn Oxford by and large, though many from Brazil apparently end up
just moving to the US to learn English, where they necessarily learn
US English.

However, I never found the guidance of doing what other people are
doing a convincing one, especially when the alternatives are more
logical/convincing/"better". Though I do recognize Konstantin's point
that the project is decades old.

> This isn't a defense of U.S. English (after all, I wrote the first
> paragraph), but just an acknowledgement of the way things are.  This
> project is all about practicality rather than purity; to quote from
> CodingGuidelines:
>
>    Again, we live in the real world, and it is sometimes a
>    judgement call, the decision based more on real world
>    constraints people face than what the paper standard says.
> --

While I somewhat sympathize with the sentiment, from the text, it
seemed like things were in a mixed state, so I wanted to suggest
picking the standard that makes the most international sense. As the
usual guidance goes: when faced with two choices of relatively equal
difficulty, choose the one that makes the most sense long-term.

Varun
