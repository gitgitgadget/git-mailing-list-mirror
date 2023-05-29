Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3989C77B7E
	for <git@archiver.kernel.org>; Mon, 29 May 2023 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjE2JvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 05:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjE2Ju6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 05:50:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342218E
        for <git@vger.kernel.org>; Mon, 29 May 2023 02:50:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96fffe11714so576205766b.0
        for <git@vger.kernel.org>; Mon, 29 May 2023 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685353855; x=1687945855;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GneswaysKwzsvwPm72TJFxwrO0BqSO2bqNbbhLgdcQk=;
        b=WNY/LxIVavdk2ZQn01L3R7I2mcJTOgBjlkwS4+W+bbwkG3G9nBbtPme4sDG0IQvgM5
         rMzQ3rJc+v/1RrAxQhbFdbrnPTeuLb+APlzFT4/Lu2R8rtfuCxwZrv9LrNc/isqBjmjt
         ufNI4W67AYMxPx5muTmCjj4MjpEQFLqOY5IuvnMpKzh0YSOmi9lGcrOYTKIP0Numzwis
         7xWJQeY/MN+LmgMWe6fh7Qj2EU/ss+nXo6FgOhmgC3LMHjd3yqvzfBtD/BLohzXWmjzw
         yQJcyQQJGfzvpdBhszqEBCbizxMtYRRl6qb8OJbW/NLiYuaqC13SgzBUYksLmF/cKUOs
         HYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685353855; x=1687945855;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GneswaysKwzsvwPm72TJFxwrO0BqSO2bqNbbhLgdcQk=;
        b=RyQLNaGbVkQ5SAPFyMu/erI5aawNDGEA3awJx8VW3TPPMfeH6lGY6v+nXH0kkqHFbn
         6eMkkJdzngu5udYQK9TkgtoXD+2qrEdjvyRS+ik4KiC7EXVV60czRHH/Ftj1vMJ6o9Sc
         AIzlcist19EUM8YhU/N8YRma6vhnJp10GIJKtFKVvHfyO8eJSJ4AFp/c/MKGkRX2B9YP
         WdAgZyq0W5rn4x1JxjfjWsvPApKeyWNhaXw4yZl/35loZa0iOjlT/eBC42vSei4kLKv0
         jwsfyCE91n4npYDgukjW2AeUXK+Bga7SCogY+NVUm4pZb22frcXluvIjUhAz83rbGPZ/
         wa4w==
X-Gm-Message-State: AC+VfDzKF3jmIYifN56XLKbM6ulCxYOlGwCK65+RJZ4oWfkChru9Tbbn
        7SUIQLK5a1ZtQtzN45JHnmJjirGzrRKkviaX/SI=
X-Google-Smtp-Source: ACHHUZ6g8Zlj70ZW0xSCMtLUSx7IonDKKKvtlkkf80MaFUbBxqKqunaBg3PzPjBmpRpHoDErH+eVTJrT/M5Cu+MuM9w=
X-Received: by 2002:a17:906:ef09:b0:94e:4489:f24d with SMTP id
 f9-20020a170906ef0900b0094e4489f24dmr11893127ejs.61.1685353855291; Mon, 29
 May 2023 02:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1538.git.1685303127237.gitgitgadget@gmail.com> <ZHPa27fbAoKL0uGj@tapette.crustytoothpaste.net>
In-Reply-To: <ZHPa27fbAoKL0uGj@tapette.crustytoothpaste.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Mon, 29 May 2023 10:50:18 +0100
Message-ID: <CAGJzqskGMn9rJDmcC1_ctKV-ut90twK5=FoH9fyUiqKrq6EqFA@mail.gmail.com>
Subject: Re: [PATCH] doc: gitcredentials: introduce OAuth helpers
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, msuchanek@suse.de,
        lessleydennington@gmail.com, me@ttaylorr.com,
        mjcheetham@github.com, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 28 May 2023 at 23:51, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-05-28 at 19:45:27, M Hickford via GitGitGadget wrote:
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > OAuth credential helpers are widely useful but work differently to other
> > credential helpers, so worth introducing in the docs.
> >
> > Link to relevant projects.
>
> There are many possible implementations of credential helpers, and I'd
> prefer we didn't specifically propose any of them here.  We ship with
> some in contrib, and I think it would be better to fix them to be
> functional for this use case rather than link to external projects.

Thanks Brian for your reply. I'd love to upstream OAuth functionality
in Git, but I think it'd be prohibitively difficult technically without
introducing extra dependencies. git-credential-oauth is little more
than 100 lines of Go, but it takes advantage of Go's broad standard
library and a library for OAuth. I expect that would require tens of
thousands of lines of challenging C.
https://github.com/hickford/git-credential-oauth/issues/8

I think OAuth is such a boon for usable security that it's worth
describing and linking to external projects. The text aims to inform
the user rather than tell them to use a particular project. An
alternative would be to link to a new 'credential helpers' page on
git-scm.com

>
> I expect, however, that functionally, that will be difficult to do,
> given the fact that OAuth typically requires registration with the
> remote system, and thus we'd intrinsically be prioritizing some
> well-known forges over less-known or personally-hosted forges, which
> we've traditionally tried not to do.  For example, your

In that spirit, the patch avoids naming "popular Git hosts".

> git-credential-oauth contains a hard-coded list of 11 forges (and also
> proposes adding credentials for new ones into the config, which isn't
> really a secure way to store secrets).

To clarify, it's expected that client credentials in OAuth native apps
(unlike web apps) are non-confidential. "It is assumed that any client
authentication credentials included in the application can be
extracted" https://datatracker.ietf.org/doc/html/rfc6749#section-2.1


> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
