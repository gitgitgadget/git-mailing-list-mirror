Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8F5C43217
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B5B64E05
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhBOQDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhBOPty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:49:54 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F5C061797
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:49:06 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t62so6734248qke.7
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=srLViGemGIwi4WlzQQU6QXHOPrqnd7pXMMEeffijWmM=;
        b=WKfi6FrXywzKznqlQqZOeR0F6FjEfzMyaBRxj1BeYEB0xaNyFuKLgv/cd8QNqwniZQ
         yacXULvk8BghiPXc2R8zQ8BU7nWajVeDoWatBJxAsjVkPIM1gfFQgrCiokKIxdS8KqBN
         9OgqRrXMj66cvSMinaDSTJJykvjxKNNYihMOzBxaJmx/1q820moqJ/Nkfu+x18UA+t4H
         aNKLLrYkwFj6l6ea6GrViuLTZs8l+0uyadEMoeoLb39trzImGs0aT+//1tgaTf43WV4V
         dPpj3xRtGVnX8qi9GBXUfii8hL+LdHlrjN4l3ZJCheZPtS8GHEzc69nnwqlNkpO2jHNX
         33JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=srLViGemGIwi4WlzQQU6QXHOPrqnd7pXMMEeffijWmM=;
        b=fymjkb+6iT4bljDqMM8GmIBn79UxQ9WoE4ys6EKnlCbusEcS4STBH7R2eixwCCZqkU
         wmnD6e2GJOV53oZGLAyfK/564NekqRdUfF4QXHx8c+2isWU6VWE44pjeb8DKFWWn8iAL
         h6hgFtyq+/jrCnzkR2ms82Zy9R4FXc83ipW0vIi3HQIVOYmjbvVdDqFi8iJngqy6VpG7
         ESzQ64bUSgohjOKPoUeChKDUukkecuzw9k07LZx+QrpzwX7DS0GevVPDGvT+NBmCoYZT
         YD0avFS3onES3pmdNsgAv5amfgUgo/sTOo6GB6UayzcgExx9jVna8/K1Slqs+2FLqqr5
         8vrg==
X-Gm-Message-State: AOAM532ouowt/qwTVPYooBjaZpFWv0P6GAuAYBeygpxsg8u1wAAptNj2
        etS3lUZuaS/i0MowgnhLUhFZMA==
X-Google-Smtp-Source: ABdhPJxsmWtnyqE0+dE1281yPf1fSY4ztOR7j6cyXhF6CHtn4w6RpPOZ9o97q5HSJlWPKTnm0T/Cgg==
X-Received: by 2002:a37:488b:: with SMTP id v133mr14280963qka.313.1613404145571;
        Mon, 15 Feb 2021 07:49:05 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id x7sm11148410qtv.58.2021.02.15.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:49:05 -0800 (PST)
Date:   Mon, 15 Feb 2021 10:49:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 2/9] midx: allow marking a pack as preferred
Message-ID: <YCqX7hxWWKzmvaUO@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <4a358d57cf6e834cd1756e70bf713d4d104f321e.1612998106.git.me@ttaylorr.com>
 <20210211193314.GG1015009@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210211193314.GG1015009@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 11, 2021 at 08:33:14PM +0100, SZEDER Gábor wrote:
> > +--preferred-pack=<pack>::
> > +	When using the `write` subcommand, optionally specify the
> > +	tie-breaking pack used when multiple packs contain the same
> > +	object. Incompatible with other subcommands, including `repack`,
>
> I think this shouldn't be an option of the 'git multi-pack-index'
> command but an option of its 'write' subcommand.

:-/. I wrote a lengthy response on Friday, but Gmail must have eaten it.

The gist of my response was that the intermingling of sub-commands with
options from other sub-commands goes deeper than just the documentation,
since command-line arguments are only parsed once in
builtin/multi-pack-index.c.

I explored whether or not it would be worth it to parse the common
options first, and then have separate options for each of the
sub-commands (as is done in the commit-graph builtin). But, this is
tricky, since we accept common options on either side of the sub-command
(i.e., we'd expect both 'git multi-pack-index --object-dir=... write' to
behave the same as 'git multi-pack-index write --object-dir=...').

So you could let the first call to parse_options() parse all of the
arguments, but then specialized arguments (e.g., 'repack --batch-size')
would cause the parse-options API to barf because the first call to
parse_options() doesn't recognize '--batch-size'.

I think the easiest way to do it would be to pass
PARSE_OPT_STOP_AT_NON_OPTION, and then let the subsequent calls to
parse_options() pass an array of option structs that also includes the
common options so they can be parsed on either side of the sub-command.

Obviously this leads to a lot of rather unfortunate duplication. So,
I'm content to leave it all as-is, and let the multi-pack-index
builtin check the disallowed combinations itself (e.g., if you passed
'--preferred-pack' but aren't in 'write' mode, then we should complain).

I can certainly move this piece of documentation into the 'write'
section, though, which should alleviate your immediate concern.

Thanks,
Taylor
