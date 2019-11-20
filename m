Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B6AC432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 12:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB012250F
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 12:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BER/gqOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfKTMUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:20:10 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:44275 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbfKTMUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 07:20:09 -0500
Received: by mail-lf1-f53.google.com with SMTP id n186so7564875lfd.11
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 04:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iz2+b9bsjcv3o31MBqlTWAyXM2cO6hf75pHJbOlmpWE=;
        b=BER/gqOKqAoq87AIquARz40Q1J4WHbQ6l4YZGfzFjaB5Vsk2m5W6U8lFnq1sW0yj9t
         a4xcGQW+BlIRx1RJNb3e7cqv36+Akw5/T1z3HLLW4N8kP60Ed1IZE25X2kE2n4AHdi9W
         Vy0/eD1560Uyu6AfcAfiD2El5RDvOAsWxyPpr/lOjCI5I+s+Xe0dVfBrzrYr97FoN3eq
         I/+ROyI1T/wxBvtGVLr2arp5eCbEE2/p2Hydfp+zXMT4JrZTpq0ygdkfPqbqrtuE+S5E
         OKmDYW6qZAd1NQ2799DfMabT1NMcP/BB17xsH3QC7WCWrIzb7i0/+xflNohSSn1Gz8w6
         Gy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iz2+b9bsjcv3o31MBqlTWAyXM2cO6hf75pHJbOlmpWE=;
        b=tiGtKUU11Y/B0kiG3fPwB6r5GbX3bRxBJ9YezPxO2n+EUzXl1I52iw5+zfRRFB/JcY
         pLkQmFbwCh8HHbtqLtIzYld/25w59nJbOSLWZ0391qfymje9rVtce1ZnoAMuEHKVw4mB
         UwbZirjA72lUkE3Jy1eJw5qFWTeOZxEr8CLaGIe3z7z2LgBW3xO1QOr+0r2Fz0l+AfMU
         ye6bfw2bAtxi/RbVh5nbkOotY+j6T1yfGCyAvTPYXaskqmrTlI+GR5TQKjpdaeKvRd3e
         MfYgiSiBlgOgAO+otiORQ5qmaHfkfyu/tOnUAgoRaJRavQ4PB6nKrMLfnl8kdl31Trnf
         Iw1g==
X-Gm-Message-State: APjAAAUhIc7+A7mA+FkVGH3MFp2ayBwOOHLrs7TkbC5kWrzMCY8XtR/T
        3WzA/fbWspk20cmA0lg0V0/8kqfEeGAr/kYqiPM/P/T5
X-Google-Smtp-Source: APXvYqzrwNM+53K7fE6dmqrqCAjg7iAIb1uzBnC6SzEq9kXjJDR0p6whZvUKuFxkatHAasGVg0GAchhlISSWPJXKK/A=
X-Received: by 2002:a05:6512:20e:: with SMTP id a14mr2459249lfo.63.1574252407736;
 Wed, 20 Nov 2019 04:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
 <86k18rbbyz.fsf@gmail.com> <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
In-Reply-To: <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 20 Nov 2019 13:19:22 +0100
Message-ID: <CAGr--=LKBq17XSLpe=uJbEPSfCp5Fpi_uw4d87DgJ8-S4Md0kQ@mail.gmail.com>
Subject: Re: RFC: Moving git-gui development to GitHub
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hei Elijah,

On Wed, Oct 30, 2019 at 7:21 AM Elijah Newren <newren@gmail.com> wrote:
> Projects which switch to GitHub tend to have overall commit quality go
> down IMO, because the system (a) makes it nearly impossible to review
> commit messages, so people eventually degrade to writing really bad
> ones,
What do you mean here, exactly? In what way is it "nearly impossible"
to review commit messages in GH?

br
Birger
