Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20798C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 05:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E833261108
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 05:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhILFyt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 12 Sep 2021 01:54:49 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:38477 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhILFys (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 01:54:48 -0400
Received: by mail-ej1-f48.google.com with SMTP id n27so13338458eja.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 22:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wFTLxIIh57bEar4rv4lMs5vPIP7VjFTEriHsFmGsxK8=;
        b=mVgHKe2r7zBasjkUIzQo/Cgjl+CRXWHSBTPI7JBQKrSrzYYCEukXRdA8akuOfO3XC5
         hDfmckgGGr5By16rlMLyaSo7OunrZSYKG9Gj48Ja4ptrr2ugmti6SXUz1CXpMfA4kbqi
         PHUnVv8nxSTc9fxjQQxnJ8m+pQtD+cV56DA2PUsaoSeDKNVc6i6zf3C06e9sOZGVdYLE
         fgO2Mco2NpDvB9XhVhOs7bQvD2z8d8OybNzsYwcRQfzFVFxA41zNQoUQ0DY3ZqHQlDvo
         flq4F0pOzIkm2tzyo2LJSjoXn31FMj2oNIqW0ysUJMmjartuPaQtJ7aArZItxhm0XRvj
         WXWQ==
X-Gm-Message-State: AOAM530JZX5z8d6Bxpls/viqhZ05UrMU5hiz+JUWS4HrOFJVFe3qXW7i
        c4WBvgltctNa3823xx7LSxmFBqciGl51hNxIfLHy2rs1
X-Google-Smtp-Source: ABdhPJyTNRYDijz+mDNYvZSmkG6eu1YMTqPTvcip0NCjnim4H9E2j6YZklHJ7pz/LyIbmw1ksA0LFBXBuzPwWNARonA=
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr6000100ejd.568.1631426014010;
 Sat, 11 Sep 2021 22:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <20210830072118.91921-4-sunshine@sunshineco.com> <xmqqwno2505w.fsf@gitster.g>
 <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
 <xmqqeeaa4y0v.fsf@gitster.g> <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
 <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
 <xmqqwnnos2jz.fsf@gitster.g> <CAPig+cQdAuLkZ0pDK6XOfm_WXCJAOm8Tr19oK14n-Tf7DcfW=w@mail.gmail.com>
 <878s03c1of.fsf@evledraar.gmail.com> <CAPig+cQ+qVNBJqHmQgk6D1fbYHHJpAxhfwyBOgevi9Hvs6JYkw@mail.gmail.com>
 <87wnnn8kba.fsf@evledraar.gmail.com>
In-Reply-To: <87wnnn8kba.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Sep 2021 01:53:23 -0400
Message-ID: <CAPig+cTRo_bLrCyhWC5on-HHco=H=3Mc6Xfi4gRP0xVE+Xk=BA@mail.gmail.com>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 6:43 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Sep 11 2021, Eric Sunshine wrote:
> > Notes don't store the indented blank lines; it's only at output time,
> > such as with `git format-patch --notes` that the blank lines get
> > indented along with the rest of the note text (just as is happening in
> > your `git show` example in which the entire commit message is being
> > indented, including the blank lines).
>
> Ah, so with your change we'd end up with trimmed notes, but not the
> trimmed main body of the commit message?

That's correct. This "fix" is specific to the note-printing machinery
which is invoked by (at least) git-format-patch and git-log.

(Until your demonstration of git-show indentation, I wasn't even aware
that blank lines in commit messages were getting indented there, as
well.)

> > Anyhow, since then, I've discovered that `git format-patch
> > --range-diff` also indents blank lines. And you've now shown that `git
> > show` does, as well, so the behavior which triggered this "fix" turns
> > out to be somewhat normal in this project, rather than a one-off "bug"
> > in need of a fix.
>
> Per the above I wouldn't mind this just being changed for all of them,
> even one at a time.

I'm not a fan of the trailing whitespace either, however, Junio does
have the concern that there may be some tooling somewhere which relies
upon the "indented blank lines" (even if such tooling would not be
robust).
