Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BFC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E75610C9
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhEaIeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhEaIeS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 04:34:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E139C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:32:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so12497488edt.13
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAQZNwo4X5lsC9bIJGRQxoKM96yOYa1YshIZ6S/7R1E=;
        b=ZcJK1Au9sGJyHOKSWJndqP0dJK1jMHKT83rN8oo1+6J5dt4/GDjkz8aD8tAGhyh+Wl
         TkLdzZwpqs5ydge+6vnjeoOH1d/s/2k2zKY4MBk2Rm4Bkd8i2MXhYzsE9DAoahZ11EnM
         n1aKK58CQuXkcRx1M4uDj2jJkybEfvDldXMK09uRF3THmY8aVIY9mqi+SHPWhbOhV6WQ
         T4uTypLpGNW/dVcTUQiv1tuu0+9qjdzXyQ8DWisBIJ3mepW203ab80syF1X6h89AS2Bb
         b2N0JsXDsgTf4gg3T+b/wwS1OjEWaK9ZnOpO46yv0UtJ7ooQWsCLcumHvrolUvCAC+8P
         Ylyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAQZNwo4X5lsC9bIJGRQxoKM96yOYa1YshIZ6S/7R1E=;
        b=dGjqG805W5jQWTF38YQLcGrD8Ml4pR9qbaeNVlIFQjiEv96K5OU/Ft6I61OWu8+jur
         0VU0CYgAuJfvYEFiPkXX0mCAXg1EJh3owoKmiISLeNYW/I118ZLS9F+FtKzKO+jx+XN5
         XODxmq5jMS1JBAo45yOczaX6KpNVFuIjxqUIJjBJyFBSLWb90uYV0g379diSaEBQuZDO
         /wh7hC8lE+HwgTI4BagPRdM/YnMCVhPFJw1HsazY/954X3UdmakGbb3znia1uUT3epKi
         Gr+EaTzs8yuGp5AHpwPiMe6Xrjq9BMcMfALRSqWymxEc7AAh7YJ4j1kql3fBM2ipEoql
         dDbw==
X-Gm-Message-State: AOAM53038quqllhMP+68Lc6wGUkJnrWbP2PWTRioZNdtKm7J6QniT2gY
        vxmXWYZAyxpJesWPZnDR9/4AtB2AosyQvixir2JJk3H64QQ=
X-Google-Smtp-Source: ABdhPJxxu8CPagxeo2rRGnLhYf52hlNjIOOoRAHRkx0OjHjKY0Nx9oXJUerhp6qDtP1gZZ3ySgbV1/3Wze9kd8ptUyg=
X-Received: by 2002:a05:6402:1111:: with SMTP id u17mr24299890edv.87.1622449956586;
 Mon, 31 May 2021 01:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
 <B932C097-1B91-4D59-9CC7-1B91C86FA1A1@gmail.com> <2691ddbb-940d-34e2-6865-85890a96ec90@gmail.com>
 <56956774-0BE8-4598-85EB-E92E495C80A3@gmail.com>
In-Reply-To: <56956774-0BE8-4598-85EB-E92E495C80A3@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 May 2021 10:32:25 +0200
Message-ID: <CAP8UFD2c52zQe0mUmLGhFejRgAL_WMas=2rJARtX=Y9Nd_E1vQ@mail.gmail.com>
Subject: Re: [GSoC] My Git Dev Blog
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 9:43 AM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> On 31-May-2021, at 12:25, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > I think it's better to post link to each blogpost as separate threads, because we can discuss each posts at its own merit.
>
> Sure, I can do that next week onwards.

Thanks! I think it could help people get interested in your blog posts too.
