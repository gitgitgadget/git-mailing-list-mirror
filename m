Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756C5C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 05:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiBSFxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 00:53:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiBSFxF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 00:53:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EC1693AB
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 21:52:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k25so19715596ejp.5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 21:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=t8JreeTypaNTbeltxweJS+3goo9gTgNhnGAZXoAQswM=;
        b=m3JoAHVnVzzQuinJv05iu9I4PBR1V7Mz+F5WVb1zwJT0sqUflE6lqit2xaeP3URI5o
         HT2X3JT9J6/wks39C6VM9aLGbj8/NtWqNiBire4j50Im4wFxExBlVbS7CKJuqfCN3MD3
         nopmsZ+5ZAOjmwRQL6TwHuahVzoFiGs0xo6zRUCEGLoxUpsDMmEAm8jmJf1b5MZJ1Ina
         7YVuGw5pbfnXzbxkjik/hnc9rHP/jiOvdns/SdbXQJaXILhJ972r28LOy0FV6sakI3Qi
         Rw/YtR7qSEtp7jHJiWnY3D1/2sakeIkZr0sGR98tAQaeDxcc8dYqO9M537l7SSfepQxO
         orMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=t8JreeTypaNTbeltxweJS+3goo9gTgNhnGAZXoAQswM=;
        b=MhXgOREPIlkHCGF0pAdXjhneW+qVytuWE1gQ+MLeTOVpcIUtAOAv9wjFvgXWv+NIGX
         xKE4Lp1A+Fk/lWa50xYUQtE59ZrrFQoxklKKuCuN3usyhqKlDD1OzzykScoNcBAkZyTv
         tbev3OgwGRp+R+v4LmBhJ98umJYaYv8s02E2hxpJ4uJ7+K4Dv6eeImqnUVTuo+KIUk3a
         BYRYLZE7v0bu7G/Ya92UCAn7kw4lg0PAjdzl6F9wxJpgp3yTAFD9YA8dhKoSNlOMvBl0
         PicneUpmPX5h34GaN0Gtq2GtorCMnKvXFEcyB/z2i69DJQZWmcptNG2ccUpOktDOoaax
         wSOA==
X-Gm-Message-State: AOAM533arFY98Ns/wK9+Qs3G6cJPuuIMbAf4he8gHSTBxbu+azwZo7rY
        bPvSp7CvYx9KYmZ9pEqj6s4=
X-Google-Smtp-Source: ABdhPJwIVzMpl5Q2dGPpWA+3j8M92glG4vQ0JxzfBSCCjRh68pPCDOwxrkH33GAEN9yL3CxbKxig8A==
X-Received: by 2002:a17:906:2a1b:b0:6ce:a15b:a561 with SMTP id j27-20020a1709062a1b00b006cea15ba561mr9163535eje.403.1645249964638;
        Fri, 18 Feb 2022 21:52:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id eo14sm5345372edb.46.2022.02.18.21.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 21:52:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLIfj-004ns2-Eb;
        Sat, 19 Feb 2022 06:52:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v11 11/13] ls-tree.c: introduce "--format" option
Date:   Sat, 19 Feb 2022 06:44:29 +0100
References: <cover.1644319434.git.dyroneteng@gmail.com>
 <5936004f1386388740ded0208ebeb8c5d0c88ef2.1644319434.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <5936004f1386388740ded0208ebeb8c5d0c88ef2.1644319434.git.dyroneteng@gmail.com>
Message-ID: <220219.86r17ze72s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 08 2022, Teng Long wrote:

> +	if (*start != '(')
> +		die(_("bad ls-tree format: as '%s'"), start);

My typo surely, but I think I menat "as of" not just "as" there:

    $ ./git ls-tree --format="%[blah)" -r HEAD
    fatal: bad ls-tree format: as of '[blah)'

> +
> +	end = strchr(start + 1, ')');
> +	if (!end)
> +		die(_("bad ls-tree format: element '%s' does not end in ')'"), start);

Or actually:

    $ ./git ls-tree --format="%(blah]" -r HEAD
    fatal: bad ls-tree format: element '(blah]' does not end in ')'

We could rather say for the first one:

    $ ./git ls-tree --format="%[blah)" -r HEAD
    fatal: bad ls-tree format: element '[blah)' does not start with '('

> [...]
> +		errlen = (unsigned long)len;
> +		die(_("bad ls-tree format: %%%.*s"), errlen, start);

I wondered why that %% is there (and I probably wrote this in the first
place, I didn't check:). But it makes sense, because strbuf_expand()
skips past the % for us, and we'd like to say e.g. %(foobar) here, not
(foobar) or whatever.

> new file mode 100755
> index 0000000000..e08c83dc47
> --- /dev/null
> +++ b/t/t3104-ls-tree-format.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +
> +test_description='ls-tree --format'
> +
> +TEST_PASSES_SANITIZE_LEAK=true

I notice now after commenting on your 13/13 that you should add
TEST_PASSES_SANITIZE_LEAK=true to it (assuming it doesn't leak, which I
don't think it does, but test with SANITIZE=leak first!)

> +test_ls_tree_format () {
> +	format=$1 &&
> +	opts=$2 &&
> +	fmtopts=$3 &&
> +	shift 2 &&
> +	git ls-tree $opts -r HEAD >expect.raw &&
> +	sed "s/^/> /" >expect <expect.raw &&
> +	git ls-tree --format="> $format" -r $fmtopts HEAD >actual &&
> +	test_cmp expect actual
> +}

I also forgot I wrote this, but also per my comment on 13/13 you can
just add your tests added in 13/13 to this file, then we'll assert that
-r etc. work the same for both.
