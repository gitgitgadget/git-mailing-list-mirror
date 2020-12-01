Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F63C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E688520639
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1KYqhZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbgLATTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLATTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:19:39 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B7C0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 11:18:59 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id b190so713520vka.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 11:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b5QuAbl2uznS2cBSnbFLDFHysjrIZOhRQQU9tIgThl4=;
        b=i1KYqhZyHMEEig/WfdIb27JP4dIjuj1buv15zOvwDew7wlnYuYP9tYfQpdIzbFRcR7
         U4gu7wyOjJdHZE3D8hBZkETJXIGneMvAfU2tSgmg5TL1UENcxqeA1H3teMPax3oT6AFk
         yxKgq1Mxb77RVJwom9pVaFdXDZ3i94B3Zis04GSYYonknOX2RyUohs/L2FrRn6tOcTtx
         QojakvIqNkbJBHSfaSVsFitdRIJ30vxZGyfb2+KEjwjh542zU1f4RJIxBEyRrKwjFUJz
         JroHKPV7yZtqmipy8eqVaSIHrfD0zHGasgOr1U74TM+bgtwuB5vBjozleW/ExohSFeDh
         p4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b5QuAbl2uznS2cBSnbFLDFHysjrIZOhRQQU9tIgThl4=;
        b=pirYEXaM6oFM8IVty4K6Nuz25kh2b8f3M3mxgWW2lIECLKR+ke7kzx2ltuQBx2fpig
         ZbBtH4zobPEz5qTToA5OLrlAbzC7lH+k6wVzcznSTOqK/Q7hhXSmhAcxjUsZrQreh5Op
         U40XNGXEg2AXyicJIRDIOGXihDJiU7RgLL54leP0n/ypalleHTarmAHg+TwUzfVvUeGi
         /QUztnfPQp+qYuDhwPITqEd/csP62vtOcuAE3cWqg+hkShVIXP8D6tym0iT0cwZElDU0
         +Ck3y23rvYojuyDX4S8rxrr786ZNtMWDXVVOHLV7ltzkPMEubV616A1LJZXPKV0lOsfB
         RZ+g==
X-Gm-Message-State: AOAM530w+nCJDPy+XIUb1/K3c0d43FqtCszZIR8ML07AhqDBI4FjHOJH
        dzfBSOsF8i5VXfVF8WXsoPIFm4QFIAoJW/p5Wf0=
X-Google-Smtp-Source: ABdhPJwIqtBpqlur3HhVNeLAiQJAF2ni+YOYH9uNKWrrV0X16lps/sqRvuukTe+oHOTa8OTfIHTx+5VJyANlFRzx33E=
X-Received: by 2002:a1f:d286:: with SMTP id j128mr4183204vkg.8.1606850338230;
 Tue, 01 Dec 2020 11:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20201201095037.20715-1-arnout@bzzt.net> <20201201154115.GP748@pobox.com>
In-Reply-To: <20201201154115.GP748@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 1 Dec 2020 20:18:45 +0100
Message-ID: <CAN0heSpzA2ecKkjz0kMD8k66x8tDipKs93OHQ0+2efQyrS9_=A@mail.gmail.com>
Subject: Re: [PATCH] doc: make HTML manual reproducible
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Arnout Engelen <arnout@bzzt.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 1 Dec 2020 at 16:41, Todd Zullinger <tmz@pobox.com> wrote:

> Arnout Engelen wrote:
> > This makes sure the generated id's inside the html version of the
> > documentation use the same id's when the same version of the
> > manual is generated twice.

Thanks for this. Your mail still hasn't reached me through the list, so
I'm replying to Todd's reply here.

Looking through the word-diff of the resulting user-manual.html, I see
basically three changes. I've applied some light copy-editing to try to
make them more readable (the lack of spaces means the notion of "word"
diff is a bit off). Do you also have these three changes?

  1. <a name=3D[-"idp1"-]{+"id-1"+}></a>Git User Manual</h1>

  2. <a href=3D[-"#idp2"-]{+"#id-1.2"+}></a>

  3. <a name=3D[-"idp2"-]{+"id-1.2"+}></a>

These names and links don't strike me as particularly useful. But even
so, reproducibility makes sense. I guess you're not really after linking
to these, but want to have binary-identical user-manual.html when
building from the same commit?

> > @@ -380,7 +380,7 @@ SubmittingPatches.txt: SubmittingPatches
> >       $(QUIET_GEN) cp $< $@
> >
> >  XSLT =3D docbook.xsl
> > -XSLTOPTS =3D --xinclude --stringparam html.stylesheet docbook-xsl.css
> > +XSLTOPTS =3D --xinclude --stringparam html.stylesheet docbook-xsl.css =
--stringparam generate.consistent.ids 1

Nit: Maybe add a new line

  XSLTOPTS +=3D --stringparam generate.consistent.ids 1

instead to keep within 80 characters.

> I think this would raise the minimum supported version of
> docbook-xsl to 1.77.1.  That might be fine, but we'd
> probably want to make sure it doesn't negatively impact
> OS/distributions which build the docs as a likely group who
> care about reproducible builds.  And we'd want to update the
> requirement in INSTALL, of course.

Thanks for digging out the version number. Agreed that this change
should be reflected in INSTALL.

> The minimum docbook-xsl version was raised from 1.73 to
> 1.74, in 5a80d85bbe (INSTALL: drop support for docbook-xsl
> before 1.74, 2020-03-29).  That change was discussed in
> <cover.1585486103.git.martin.agren@gmail.com>=C2=B9.

As mentioned there, it's not like I went out and tested with 1.74. So
whether we *actually* support 1.74 right now is anyone's guess.

> AFAICT, the generate.consistent.ids param was added in
> docbook-xsl-1.77.1 which was released in June 2012.  The
> commit which added it is 74735098e (New param to support
> replacing generate-id() with xsl:number for more consistent
> id values., 2011-10-24).
>
> In any case, a minimum of 1.77.1 is present in the supported
> releases of CentOS/RHEL and Debian/Ubuntu, at least (most
> have 1.79.x).  Those are certainly not the only systems Git
> cares about; they're simply the systems with which I am at
> least mildly familiar.

Seems to me like we can go with a change like this. If you're on a
pre-1.77.1 system and want user-manual.html, but don't want to update
your tool chain, you should still be able to clone the "htmldocs" repo.
I'm not sure exactly where the cut-off point is, but I think moving up
to mid-2012 should be ok.

Martin
