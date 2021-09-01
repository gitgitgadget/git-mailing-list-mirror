Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0BBC43214
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04E160F6C
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbhIALfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243838AbhIALfA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:35:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B10C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:34:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m2so1661717wmm.0
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EXCzYUpvTSlY0dzifim6GIIV9FsfgazrrZqGJvfmp1Q=;
        b=LMAcuv09/AC+uLOyXlj6GLC017T0ZWerd9JTOy1F+69w+7oKjQ7aCvjbGGgWJ1jYze
         FG0gWFRfZGYQi9+mYc40w+YMUjeukVug3KwH3hy59iYubQQQEA4k4Vo4zWGcKjrYgcAT
         Z+Bi+INubBG8s8k/pZp7Jw5F8zjraj7Yi1oUydY2G2xt+LNTyUKoY3Q3eDCE8WPz/g4k
         EgaRKf/6ntD2An4t3d2Jr/O0Qklw1O+/OaodHgu9s01hYUqC8lvlKSraq4EBElC7QQUO
         vSrHJ55SvJjC8FclNojRD8O1OlLv0o7tgUlYeiH9x4AkM3jecjVWd9JwXCEGILdfMqkJ
         6TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EXCzYUpvTSlY0dzifim6GIIV9FsfgazrrZqGJvfmp1Q=;
        b=oNHCrJjniKZAY4WMMXxneWZJmKdr1pJ6pNSqKaMFEnECpqBosoRmouvyvjsYf1K7VR
         fzjFeXsyfUpLf9OiLTWKWD9CyzCU1qfy8QUuswzH9iLGA5rMHsBITHa9+rq3fMSXntia
         SNwIw+ezspUu5LlvAE87PCnh11BcwTMubpnUWZr1lC0GeMSE2d8rB37Fqn9BbvRrQKfL
         1sRn8h1N+aOKgR+83/WDc0wKKhdMDxrlZKSwR8p0/7fcQMfCno11NPuznFaXIKhGGQoa
         tZSEAxvoCHHFwgQaqIhT/yDQ1ey98/DWvMBZQbD5KB8TQKjRpRjMgabc9ZWQyBCfgD3u
         H5Dg==
X-Gm-Message-State: AOAM531S5zz4jXLKfMoE0sI8ww9YU8Md77jIDKM08BQ1Bibl0QZQBxe5
        NVBlVVQVtMaVht1OUSrFE64=
X-Google-Smtp-Source: ABdhPJwWSXETgj+fODMfNCwkfiiC9Xco/1J9SU6jzi9pKHHTJaAiuEh2/R8QLfD4ZAAnEERhIv2Ofg==
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr9115025wmr.28.1630496042548;
        Wed, 01 Sep 2021 04:34:02 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o7sm5057962wmq.36.2021.09.01.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:34:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com,
        mackyle@gmail.com, sunshine@sunshineco.com
Subject: Re: [RFC PATCH v2 0/4] developer: support pedantic
Date:   Wed, 01 Sep 2021 13:27:41 +0200
References: <20210809013833.58110-4-carenas@gmail.com>
 <20210901091941.34886-1-carenas@gmail.com>
 <YS9RieTeJSFmd6M7@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YS9RieTeJSFmd6M7@coredump.intra.peff.net>
Message-ID: <878s0gwmvq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[I should have included this in my just-sent [1], but forgot]

On Wed, Sep 01 2021, Jeff King wrote:

> On Wed, Sep 01, 2021 at 02:19:37AM -0700, Carlo Marcelo Arenas Bel=C3=B3n=
 wrote:
>
>> first patch was suggested[1] by Peff, so hopefully my commit message
>> and his assumed SoB are still worth not mixing it with patch 2 (which
>> has a slight different but related focus and touches the same files)
>> but since it is no longer a single patch, lets go wild.
>
> My SoB is fine there (though really =C3=86var did the actual thinking; I =
just
> deleted a lot of lines in vim :) ).
>
> Patch 2 looks good to me, though I kind of wonder if it is even worth
> having an option to turn it off.
>
>> patches 3 and 4 are optional and mostly for RFC, so that a solution
>> to any possible issue that the retiring of USE_PARENS_AROUND_GETTEXT_N
>> are addressed.
>
> IMHO the issue it is trying to find is not worth the inevitable problems
> that hacky perl parsing of C will cause (both false positives and
> negatives). Not a statement on your perl code, but just based on
> previous experience.
>
> So I'd probably take the first two patches, and leave the others.

Agreed. Per the rationale in my version of the commit messsage for
Carlo's 1/4 at [1] I don't think this was ever worth it.

I.e. it wasn't even an N_()-specific issue to begin with, but just a
migration from usage() (takes a string) to usage_with_options() (takes
an array of strings).

I just submitted a related series at [2] to fix the alignment of
continued strings containing "\n" in parse-options.c, which is the
reason we need to support "\n"-continued strings at all in
parse-options.c.

So I think (per [1]) that we should just remove
USE_PARENS_AROUND_GETTEXT_N, and that the 3/4 here isn't needed at all
(aside from concerns about parsing C with Perl).

But in the future we needed any assertion for this sort of thing at all
it would be better built on top of my [2]. I.e. parse-options.c could do
some basic sanity checking on the usage array it takes, we'd then end up
detecting the issue USE_PARENS_AROUND_GETTEXT_N was trying to address,
and more (such as the alignment problems I fixed in 1/2 of my [2]).

1. https://lore.kernel.org/git/patch-1.1-d24f1df5d49-20210901T112248Z-avara=
b@gmail.com
2. https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avara=
b@gmail.com
