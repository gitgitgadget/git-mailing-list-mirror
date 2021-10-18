Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B36BC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 18:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66748604AC
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhJRSoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhJRSoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 14:44:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AADC061765
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 11:42:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t16so2957456eds.9
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Pfk/TRkMdsXep+Ga9hJ0UGfcqxs3K6hyjBTvhiSgTuc=;
        b=Sf2qBPhz7zuSf1VOdMLFJ1IciBjgMgLxLqauBXDAHd6yl3WYa4dXpkTKoAA6SaDPZP
         sKkZLE1+deWCMDbXLL1p2c45Z+G6N88voDl27SHCVrLvYNfXifcz5BTBEEifSfxxY2I9
         pJSDY52anu78KxvGoSf82U5NOp3qIxm3yFyVTSrYhd8pLtbv9VGLAIaD6QzYHFiLPT+/
         id0DUBK3dKPNSZ2aO1ZvlClfMpzqA2tfxZlc4IgseQ6psN355U5Ju8RHx38gBBvXa+Nd
         muzy/viy5oeOK5kMT57Thz5UJ/h92U8elJx6GvdIRBMV3w7Kvo2dhce9C59lPYvx6gLr
         n56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Pfk/TRkMdsXep+Ga9hJ0UGfcqxs3K6hyjBTvhiSgTuc=;
        b=g4SC18a7HjkwQ0KLseqWgLEb5/+ctp3IUiDM46fVNwFW7upCVHDW/aikB1AtkH1L9L
         BFomWwKVh7UB/xnxdtDaVk4vOOBPWTr3d0UpEmDBX4d/VklUykCac5qDFInDhrvByTYe
         PrWH78dKPJuDkYKKYPT8NlkUj5MHBAp4ivG5PKvap3m23KLl5YawcGjyyFrn+mZJ7nx3
         0BYr0XCapEg0YLMoXrE+Gh48KIBVgtOj5aAwK8THiwlq3mLcTUEkTxXaVM6ZvhEv23mW
         AZ2PKE4bAYGbjhmOkl/gUFwUaxX2EksR30vFAR6SVXPpqfNfqHWSChlZYQRBJsLfaI6x
         iRLw==
X-Gm-Message-State: AOAM5328NpxzGw4DC8s4XI7YnztGx/1MJGCWY/vWm1eT5esbW5mjM/g9
        uosg1My7IBJp0IX0nHQXEzQWBXG8l6M=
X-Google-Smtp-Source: ABdhPJwNSW1wJj/TCmIW0UsRnZb3ZRU2ZNW2ttWzQeCinwjFUDzhVDeypRu526vTLGUZkeA7/DvWhA==
X-Received: by 2002:a17:906:646:: with SMTP id t6mr31320838ejb.197.1634582529744;
        Mon, 18 Oct 2021 11:42:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p3sm276828ejy.94.2021.10.18.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:42:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mcXaK-00059H-TY;
        Mon, 18 Oct 2021 20:42:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
Subject: Re: [PATCH v3] branch: add flags and config to inherit tracking
Date:   Mon, 18 Oct 2021 20:31:58 +0200
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <b9356d9837479914bcf9a265f52afe170be7e2e2.1634445482.git.steadmon@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <b9356d9837479914bcf9a265f52afe170be7e2e2.1634445482.git.steadmon@google.com>
Message-ID: <87a6j6tbsv.fsf@gmgdl.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 16 2021, Josh Steadmon wrote:

> It can be helpful when creating a new branch to use the existing
> tracking configuration from the branch point. However, there is
> currently not a method to automatically do so.

There's no method to get *only* that config, but this use-case is why
the "-c" option (copy branch) was added.

I haven't looked at this in any detail, but the seeming lack of mention
of it in the commit message & docs makes me wonder if you missed that
that option could do what you wanted (but granted, it does a lot more,
which maybe you don't want).

But in terms of implementation can't this share more code with the copy
mode? I.e. I'd think that this would just be a limited mode of that,
where we pass some whitelist of specific config to copy over, instead
the current "all the config" with "copy".

And should these options be made to work together somehow? I.e. if you
want to copy branch A to B, but copy tracking info from C?

> [...]
>  -t::
> ---track::
> +--track [inherit|direct]::
>  	When creating a new branch, set up `branch.<name>.remote` and
> -	`branch.<name>.merge` configuration entries to mark the
> -	start-point branch as "upstream" from the new branch. This
> +	`branch.<name>.merge` configuration entries to set "upstream" tracking
> +	configuration for the new branch. This

Setting up ".remote" is what --tracke does, but doesn't it make sense
for such an option to copy over any other config related to that area,
e.g. also .pushRemote, as a user may have edited it since the creation
of the copied-from branch?

Maybe, maybe not. But this & the above comparison with copy makes me
wonder if we'd be better off with some mode similar to the matching
regexes "git config", i.e. you could do a "copy" but only on a list of
matching variables.

Then the --track mode could just be implemented in terms of that, no?
