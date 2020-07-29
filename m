Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5512C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 06:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B510C2070B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 06:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEo9rDIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgG2GTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgG2GTr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 02:19:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F658C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 23:19:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so9241352ejr.5
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 23:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBL4JJPxkITN2uZige/qIxvVmx9i9okOqEWW0z0bMQw=;
        b=CEo9rDIq0LAd6QhW1y+115cX+aEk/9weY63L5xQOPDxGrjbSk7YBdAdkVYGzcFX7JK
         Nm3fI3lsazFu5aq28y2lU2XLYpiYUFi1qNtIOqu2D2dJLiDc1YgfHFyzBE6gi6MB7UaL
         8a/bhwJA/hgyNLr9EfVHuzA5tJZQ0ejU+rG0QZBLjRLJq8HHnZboU6Eb+0DHTD6UIlZ3
         bywi6On5J3pt3oTTSZh8FInI0nv9fY7ZUgG1r6Ulx+2qA7qNVIWi0hnUwALGswG0n732
         stMlOSz03ipJE8R7VgM2XgOUVfH9+GqWGpwmBDlfAhuyZTFWIc+4p4sqCl6AHDqZqM+4
         pa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBL4JJPxkITN2uZige/qIxvVmx9i9okOqEWW0z0bMQw=;
        b=G0S6/INW96xhkzI7Wlhc5YNlv7bNRT5jwYABsZF9NehVNmkdCBc+e5dHPpfI2r2NY1
         ccZu1XW5ErIIfPD98DHwmikaSkczzVA0DJfWeJxf2+3QFIqMgJ6B0ARxhgoFGAEfXlpW
         hsxzUw5lih+reAdzC+VxA+bWWiCEeVQ8uKBsBRisGZxgIDEak81lRfKvUEZ5NnCl6slp
         BFqbN9nIROpfuVfDC8Yl9a2/YKA+IIDZpNIm1F9wM7KlE3tlZA9Zy76QCoW0nHksTZ3r
         Tf1sb5hWrhD0Q3n0eaqnGzKioA7sUJ//1w5YdHHIC9Ri/B9nNAcCkvJ/LN5KEwI1fUPP
         HlPg==
X-Gm-Message-State: AOAM531zBldQTwCcrUtAqkLVjxvCo9+SAli/uU8SDoJIA6zXXI263W+H
        E0lS1ytEjzS+l+ZXsQrpjeU8ntR0jU8lssR9tMgwOCGv9oY=
X-Google-Smtp-Source: ABdhPJwG2/PNxykRj2QVa2WCVQmUaK1XJUsQOUIvlOQnYvrf7q7b4KkjYmP3O40O8I7eiwHtrPs5hRiVnAkGwCUnUog=
X-Received: by 2002:a17:906:c7d4:: with SMTP id dc20mr14781192ejb.283.1596003585893;
 Tue, 28 Jul 2020 23:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202124.GA1021264@coredump.intra.peff.net> <CAP8UFD26J6W50SeQqJiG0y04kcdNzr6RRT7ZeJmrQ2V-QTS3Lg@mail.gmail.com>
In-Reply-To: <CAP8UFD26J6W50SeQqJiG0y04kcdNzr6RRT7ZeJmrQ2V-QTS3Lg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 Jul 2020 08:19:34 +0200
Message-ID: <CAP8UFD1rXJ2WcnTmjj8avnzqJauBoT9swfoF5s2Fa+JfRUvy9Q@mail.gmail.com>
Subject: Re: [PATCH 0/11] renaming argv_array
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 8:15 AM Christian Couder
<christian.couder@gmail.com> wrote:

> > "strarray" would work, too, but it's
> > longer and a bit more awkward to say (and don't we all say these things
> > in our mind as we type them?).
>
> It's longer than "strarray" by 2 characters only.

Sorry, I mean it's shorter than "strarray" by 2 characters only.
