Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F4FC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 06:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiBSGEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 01:04:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiBSGEq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 01:04:46 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD650B32
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:04:28 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p9so19795794ejd.6
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IPrO7hVm1KKy9OWMx7Dw1wCIIvqq65DDoCazk1A5kME=;
        b=dymcNsXzNkFqr+5T3jIIskb8/fMNzryHG1XDjPSvGT8+XhQBxFvYuLkGPBDl5BGVw4
         u6kCh68KGloxHNp1gZ1YvrQ94putnrDa8Vi7UoYTq5MaQ7EAb40Y/1qIAFpjVZ4BO/2y
         nv9NCeUUQm1ttSTeyduEHVDIXSL1SJMKiKGe+f0XPIB9OSTs98aaHtPa2lRGgauTDhfR
         s31slF3aDgaecePckpRzEtvuZtfeKnPvIckGhPy+wdodfN6U6ySAlH2ZxbE56tU+ruIX
         zemjatE2uvy9dGraTJUWKshCIc8Qe+S/k6mcnVQRLgq60tbQaV8YVR8CQTuplcRyoBsB
         mURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IPrO7hVm1KKy9OWMx7Dw1wCIIvqq65DDoCazk1A5kME=;
        b=mYBWsoWjc9qTrFAeEEw2sWJ9Og4t5Prfi+rBdDO7u2veNlHGqSJ6/hBOqw9GMivXdn
         ZyykibF5U/8tc1HBarMs7XseM7NZSpDO2Qn5RX7/Uw8lgmCQFa95j5DzwNavAVkfoKlC
         mqLEVKKryZDHhTgc8glLWFY9udUXMve6BeXhjsOeJ4VaVZSyp87ynn8LvFNrzUbQgquz
         gSDeoK7z8qYruqqj1Xik9RW20JoVEhq9fMAoyXrGSomUjK/lzsWd29qfVp70yQUvMH5F
         JkLx99QYGF8LhpLrIFB+E28q328iqhWtHqgCTUVKRnWwQxI4xzR9xqG/upU2gQwVytXO
         1/Pg==
X-Gm-Message-State: AOAM5330cvlcyTx2xsqlRWL072L9OQYM9iMKN3nCwVFyN7Iv9zWPI8Hh
        Eb8VXsjqXIhFoP5sVMeDPtq2D81di2L61w==
X-Google-Smtp-Source: ABdhPJyl08RwJbXiMuRB/W0WflqufreqSWpnhLlGuItGYxmWUEC8DExkiEoKmzJSpm7htsY87NR/JQ==
X-Received: by 2002:a17:906:8457:b0:6cf:3c6:dbf3 with SMTP id e23-20020a170906845700b006cf03c6dbf3mr9227514ejy.286.1645250666403;
        Fri, 18 Feb 2022 22:04:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x12sm5381222edv.57.2022.02.18.22.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 22:04:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLIr2-004oOK-VD;
        Sat, 19 Feb 2022 07:04:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v11 08/13] ls-tree: slightly refactor `show_tree()`
Date:   Sat, 19 Feb 2022 06:56:47 +0100
References: <cover.1644319434.git.dyroneteng@gmail.com>
 <41e8ed50476a5afd6009db1a69c7a39b04e038b0.1644319434.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <41e8ed50476a5afd6009db1a69c7a39b04e038b0.1644319434.git.dyroneteng@gmail.com>
Message-ID: <220219.86mtine6jb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 08 2022, Teng Long wrote:

> This is a non-functional change, we use a new int "shown_fields" to mark
> which columns to output, and `parse_shown_fields()` to calculate the
> value of "shown_fields".
>
> This has the advantage of making the show_tree logic simpler and more
> readable, as well as making it easier to extend new options (for example,
> if we want to add a "--object-only" option, we just need to add a similar
> "if (shown_fields == FIELD_OBJECT_NAME)" short-circuit logic in
> "show_tree()").

I think this and the 09/13 really don't make sense in combination.

Now, I clearly prefer to put options for the command into its own little
struct to pass around, I think it makes for easier reading than the
globals you end up with.

But tastes differ, and some built-ins use one, and some the other
pattern.

But this is really the worst of both worlds, let's just pick one or the
other, not effectively some some ptions in that struct in 09/13, and
some in globals here...

> +static unsigned int shown_fields;
> +#define FIELD_PATH_NAME 1
> +#define FIELD_SIZE (1 << 1)
> +#define FIELD_OBJECT_NAME (1 << 2)
> +#define FIELD_TYPE (1 << 3)
> +#define FIELD_MODE (1 << 4)
> +#define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */

Why do we need some FIELD_DEFAULT here as opposed to just having it by
an enum field with a valu of 0?

> +enum {
> +	MODE_UNSPECIFIED = 0,
> +	MODE_NAME_ONLY,
> +	MODE_LONG,
> +};
> +
> +static int cmdmode = MODE_UNSPECIFIED;

let's name this enum type and use it, see e.g. builtin/help.c's "static
enum help_action" for an example.

> +
> +static int parse_shown_fields(void)
> +{
> +	if (cmdmode == MODE_NAME_ONLY) {
> +		shown_fields = FIELD_PATH_NAME;
> +		return 0;
> +	}
> +
> +	if (!ls_options || (ls_options & LS_RECURSIVE)
> +	    || (ls_options & LS_SHOW_TREES)
> +	    || (ls_options & LS_TREE_ONLY))
> +		shown_fields = FIELD_DEFAULT;
> +	if (cmdmode == MODE_LONG)
> +		shown_fields = FIELD_LONG_DEFAULT;
> +	return 1;
> +}

I still don't really get why we can't just use the one MODE_*
here. E.g. doesn't MODE_LONG map to FIELD_LONG_DEFAULT, MODE_NAME_ONLY
to FIELD_PATH_NAME etc?

Is this all so we can do "shown_fields & FIELD_SIZE" in show_default()
as opposed to e.g. checking "default format or long format?" ?
