Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C460C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EB1617C9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhELCUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:20:16 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:46870 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhELCUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 22:20:16 -0400
Received: by mail-ej1-f41.google.com with SMTP id u21so32606922ejo.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyekOdVjvEsO++08WNgFZTJ87cV3KqQO6HX0Jt/Ki1U=;
        b=nMbL61Cvy4FsMjrcvOOD0uKlmcCVJAx5+wN3FDoGHg8wWo3i9IVdIp2OybAGX75oQz
         86wJXantaN3i6uw5C3tZlQko3lqlnblMdHjLCVtvzSk3mojNhPk3HhR5Vao4Jg3Er3/+
         AKXemX22rstUTrLy2ewlI1AOfmx8ZkF/bJleQIlzFHvt6i6nf40EIjjPcr2oeeZ0ivOH
         gRTUqyFrK7JxAqTIrhdV11s8+22obpVuQuOqXHTMenrc9Qw2YpOHmyeFglOTm64McuxR
         tuaGE23xBp/exfz0zpzx5Ur2GrI01zExBERY4U7KJWoeHAXc6b9wfjY08xLRbF/Y6Gny
         tZpA==
X-Gm-Message-State: AOAM531cz7ZX/OWKcuu1jRgjxkrNx3zyHXn92pH6qB7ZQI8y4EZJYvn/
        IslBTqa6cMDADhntqelwJXQ2vd3YQuurfL7V4Ng=
X-Google-Smtp-Source: ABdhPJwyrvnKLEd7E9DFJZGQis9LR86N5uplrpArMKQ9HI4bpV8eI4J7mVzizqvEN7tt680qr1Wrr7jTHiJBA0pX/jA=
X-Received: by 2002:a17:906:980a:: with SMTP id lm10mr5546653ejb.482.1620785947159;
 Tue, 11 May 2021 19:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <609b2828309fc_678ff2082@natae.notmuch> <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <20210512021138.63598-2-sandals@crustytoothpaste.net>
In-Reply-To: <20210512021138.63598-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 May 2021 22:18:54 -0400
Message-ID: <CAPig+cQh+8Zo4mh9NtnZbGJLRRXY+zTj_9JXeMkCUz-b9nmkzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: remove GNU_ROFF option
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 10:11 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> By default, groff converts apostrophes in troff source to Unicode
> apostrophes.  This is helpful and desirable when being used as a
> typesetter, since it makes the output much cleaner and more readable,
> but it is a problem in manual pages, since apostrophes are often used
> around shell commands and these should remain in their ASCII form for
> compatibility with the shell.
>
> Fortunately, the DocBook stylesheets contain a workaround for this case:
> they detect the special .g number register, which is set only when using
> groff, and they define a special macro for apostrophes based on whether
> or not it is set and use that macro to write out the proper character.
> As a result, the DocBook stylesheets handle all cases correctly
> automatically, whether the user is using groff or not, unlike our
> GNU_ROFF code.
>
> Additionally, this functionality was implemented in 2010.  Since nobody
> is shipping security support for an operating system that old anymore,
> we can just safely assume that the user has upgraded their system in the
> past decade and remove the GNU_ROFF option and its corresponding
> stylesheet altogether.
> ---

Missing sign-off.
