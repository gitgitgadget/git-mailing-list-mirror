Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182EC433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 03:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A10613F6
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 03:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhDVD7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 23:59:51 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43902 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhDVD7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 23:59:49 -0400
Received: by mail-ed1-f45.google.com with SMTP id e7so51654708edu.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 20:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGhO0Oc16jJnQpKBrfCQLZrdER+sGiHdUOH6AejTZ3Q=;
        b=tEgnAfVI0ij2jJrlh6VpvH7gDQt+tCBMIpLr1z+C5KTxhOQ3zbxx+SJHViJc4FDUo0
         mkZe/kR/JBucPrMp84GxrUVc3JGhNalWMugW/+uiAw8wLYpl68PcXqOa1o+JRiUy6clZ
         CdTw8mv/XOeMrHB9Kph5MHLSpuKBHksXtQ0ilQbDqAn7dggPAW12gducP8mee5i0v9Mn
         xneDdqqe0UsvE7V9VitZDBHOt+VsML0/VSCrc0CO7tM9pX4G2PN0kAeTikOOMYsZbsVQ
         Nv02LQKgHpZIsHtMdFritsifB2TdhaFnc6hLw3kS0wgL+Ywaww9qH/bNbYkIADcKBiV7
         KyYQ==
X-Gm-Message-State: AOAM532oU6D0tB8f6Nud+/ITvInCn3hn8mF0JpFls0/WwV4BSJQT5bTw
        +dfX28oY4F2FcY3gOjourtmecFMyNXSlk7kVmq109qGUAS633Q==
X-Google-Smtp-Source: ABdhPJzd6uZJWupY3lOe5AS2kM3rnrTvxMRUafNzRZLnjWHMr04qgH37DwLgIN8HaRqXck/pS/VDEkVzyqWmssroku8=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr1270231eds.291.1619063954826;
 Wed, 21 Apr 2021 20:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210422002749.2413359-1-lukeshu@lukeshu.com> <20210422002749.2413359-3-lukeshu@lukeshu.com>
In-Reply-To: <20210422002749.2413359-3-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Apr 2021 23:59:04 -0400
Message-ID: <CAPig+cRk_0sevG6iVbCdMPKV7XRwkrCAvEC_YRGvPkxwZoXUuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fast-export: rename --signed-tags='warn' to 'warn-verbatim'
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:34 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> The --signed-tags= option takes one of five arguments specifying how to
> handle signed tags during export.  Among these arguments, 'strip' is to
> 'warn-strip' as 'verbatim' is to 'warn' (the unmentioned argument is
> 'abort', which stops the fast-export process entirely).  That is,
> signatures are either stripped or copied verbatim while exporting, with
> or without a warning.
>
> Match the pattern and rename 'warn' to 'warn-verbatim' to make it clear
> that it instructs fast-export to copy signatures verbatim.
>
> To maintain backwards compatibility, 'warn' is still recognized as
> an undocumented alias.

Maintaining backward compatibility is good; making it undocumented is
perhaps less than good. I understand the motivation for not wanting to
document it: if it's not documented, people won't discover it, thus
won't use it. However, we also should take into consideration that
there may be scripts and documentation in the wild which use `warn`.
If someone comes across one of those and wants to learn what it means,
they won't be able to if the documentation doesn't mention it at all;
they'll either have to consult the source code to find out its purpose
or post a question somewhere, hoping that someone knows the answer.

So, rather than removing it from the documentation altogether, it's
probably better to mention that it is a deprecated alias of
`warn-verbatim`. As precedent, for instance, see the `dimmed-zebra`
option in Documentation/diff-options.txt which still mentions its
`dimmed_zebra` synonym:

    dimmed-zebra::
        Similar to 'zebra', but additional dimming of uninteresting
        parts of moved code is performed. The bordering lines of two
        adjacent blocks are considered interesting, the rest is
        uninteresting. `dimmed_zebra` is a deprecated synonym.

> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> @@ -27,7 +27,7 @@ OPTIONS
> ---signed-tags=(verbatim|warn|warn-strip|strip|abort)::
> +--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
> @@ -36,8 +36,8 @@ When asking to 'abort' (which is the default), this program will die
> -exported and with 'warn', they will be exported, but you will see a
> -warning.
> +exported and with 'warn-verbatim', they will be exported, but you will
> +see a warning.

So, perhaps this could end with:

    `warn` is a deprecated synonym of `warn-verbatim`.
