Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C329DC43467
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AB620795
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx8k0Tah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbgJJW4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730920AbgJJTwD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:52:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74CCC0613DF
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 02:46:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a3so16513127ejy.11
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KxqnfrL1wpL+Bi/YgoJn2S2Kdo3YfRkQRgHyd33qXRQ=;
        b=Hx8k0TahN+KLVs4aNtv94/laLnsRzaCyD+wPU2/iUzz4CWgP+V/ZPpf5NIqxwyjmpM
         +mMzEv9Vu9RiFLeHSKwLQVKZPnj2YRQTZ5CEFsnBhaT900F409oF3uLV2hAex8oEJ3eB
         dm4M8PGeQoN6WAn0l3XITZw73SmRlcbgNh5jgcroaJJgidHwvuau/TU2fer8SjSQCVps
         kYr3AXybO/ra1sJliE8gVpRr4bDDpUPs7ahb3cvsKlSVHoSv5Fr+cpTIHsIW2zAl/jid
         FJPPsI3L5W5SX7O1JMsgRgmR6r3wcW6TJcheIC2v+pzU6O1MqxXAGTJXOmFQIQMA0sqD
         23HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KxqnfrL1wpL+Bi/YgoJn2S2Kdo3YfRkQRgHyd33qXRQ=;
        b=NzXBqwtKAd11STffEsU7asT67PgblDSuRBchH84M21PY3HfHNYnUcAmGly6jWrkS/q
         K98Ob6EYBqdTQ1fuMc6PPQ5r6NzpOuvBvpyxYT/0kK/1UpiNuswG6OoRoAxSLZTWOK6Q
         4lQulBcIMT7A8A5pnT26m+F2bVLdpVUWkuRaRmVTxMw4oLroddVyhcZ++swmPHU77fui
         oeSaLMUzrfh+JIoAYaqNBXJBsE7Yu7LG50SzD5OErQwYpkurBxOulmJ2nagHBD4m71Zn
         2XKeiCKmwbX0JXG4T9uZP47w6eHXRYnD5GnJ0Avbb79zi/YBm2XYRdHsVYyFINboA1RM
         eu5Q==
X-Gm-Message-State: AOAM533lYMPc8G9EFBj6WuVVBaTl+0ifP+ZnPO2F2xsaEXFi7Q0BzLuw
        FM0Tp3n8UBw0hvt+nQZ/Vf3fYLRTfQncJcI6HzLd57uO2QoVww==
X-Google-Smtp-Source: ABdhPJwT2aKv8bW1Lwv6mfPLzkIIWYEqFZjBdDYty2lkokCyJW2v0UKZT58BMUGlv40MTEzEL4AKLGez5jjJjshrbzs=
X-Received: by 2002:a17:907:204c:: with SMTP id pg12mr18549177ejb.160.1602323215346;
 Sat, 10 Oct 2020 02:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de> <CAP8UFD2dWrUXJUuiFtgCu6krbnbGGqJZ7K+6KqstGTcNmSc_xQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2dWrUXJUuiFtgCu6krbnbGGqJZ7K+6KqstGTcNmSc_xQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 10 Oct 2020 11:46:44 +0200
Message-ID: <CAP8UFD16WX-HE6TW2Q15a3us8UMaogPpR+0C8shiEdP3-Cba=Q@mail.gmail.com>
Subject: Re: Feature request: Exponential search in git bisect
To:     =?UTF-8?Q?Manuel_B=C3=A4renz?= <manuel@enigmage.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 10, 2020 at 11:22 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 9:35 PM Manuel B=C3=A4renz <manuel@enigmage.de> wr=
ote:

> > That's problematic because then I might accidentally mark a
> > commit as good that was already untestable bad. Given that bisect has n=
o
> > undo functionality, that can quickly mess up my search. Distinguishing
> > untestable good from untestable bad is really hard automatically. I
> > shouldn't have to do that.
>
> Sometimes it's not very difficult to test if the feature has been
> implemented yet or not. For example with Git you could check if an
> option for a command has been implemented by just checking if it
> appears in the doc. So the bisection script could first check that and
> exit 0 (which means good) if the option doesn't appear in the doc. If
> it appears in the doc, then it could do the regular test: "skip" if
> untestable, "good" if there is no bug, "bad" otherwise.

Also note that it might actually be simpler in many cases to find when
a feature has been implemented by different means than some checks in
the script.

For example in the above example to find using the documentation when
an option for a Git command has been implemented, one could use:

git log --reverse  -S'--option' Documentation/git-command.txt

It could also work by using `git log --reverse  -S...` to find when
some functions or variables related to the feature appeared in the
code itself.
