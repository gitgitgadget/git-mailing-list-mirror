Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E0C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0097561166
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhFMDe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 23:34:57 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:38583 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhFMDe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 23:34:56 -0400
Received: by mail-ej1-f54.google.com with SMTP id og14so10610613ejc.5
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 20:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqJLzfN/57Mg49yOvjfan+zMODaze+tdBJNZZH02h70=;
        b=V0C9Wb7XZ9y+bvB042I0bp6qTjrzpMqTGF10Bi1AMUxR3OKxOxo9QVpAdbrdaM4bAM
         LcRH8/vUS0opnX05+HEHhz8cquL+zLMVmQ62bv6DnNxeTcSwratcSlna77lFt5B/S+dE
         ok0kG3LFdOrnjH8aL8VnGCN7/4t0GGm/L7x4zsEgVBoSrxfFEG6vshB8zJu+e0ySSDIw
         T52YCXd80rcj3OS9yjMV29EHnG3F/pCql5FT/pmj1KXPJGIMvgrRimL73y/kp1SCxJeU
         fcOOCVvxTniZjO9xpOG7r5M25CpTQmaSQdU8l39TU5MLh/OOfc9iO/gJdnql0r3fhHDB
         m1vg==
X-Gm-Message-State: AOAM531N5k2RLuP52f/mKxf5ywfu9mgSgbKbuyZCy3ni3SqVgje0uN4M
        KsWcCjp67bObu4d/cySdaIWL+GVSfGOZa7ZpV9o=
X-Google-Smtp-Source: ABdhPJwRdprEjmDSoOFSFcguoFw6dbFRL74fmTRuB/eZwCL/uqs8fMSkX2agr6ZUwX2TmH0GJfT/D9J5U1QgABjkp9g=
X-Received: by 2002:a17:907:960e:: with SMTP id gb14mr10193014ejc.231.1623555158875;
 Sat, 12 Jun 2021 20:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
In-Reply-To: <20210613004434.10278-1-felipe.contreras@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 12 Jun 2021 23:32:28 -0400
Message-ID: <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 8:44 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> The original explanation didn't seem clear enough to some people.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> @@ -299,22 +299,22 @@ empty range that is both reachable and unreachable from HEAD.
> +For example, if you have a linear history like this:
>
> +    ---A---B---C---D---E---F
>
> +Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
> +commits, but doing A..F B..E will not retrieve two revision ranges
> +totalling 8 commits. Instead the starting point A gets overriden by B,
> +and the ending point of E by F, effectively becoming B..F, a single
> +revision range.

s/overriden/overridden/

For what it's worth, as a person who is far from expert at revision
ranges, I had to read this revised text five or six times and think
about it quite a bit to understand what it is saying, whereas with
Junio's original[1], I understood it on the first read with only a
little thought.

Also, if this explanation is aimed at newcomers, then saying only
"doing A..F will retrieve 5 commits" without actually saying _which_
commits those are is perhaps not so helpful. A newcomer might be
helped more by enumerating the precise commits:

    The range A..F represents five commits B, C, D, E, F, and the
    range B..E represents three commits C, D, E, ...

[1]: https://lore.kernel.org/git/xmqqv97g2svd.fsf@gitster.g/
