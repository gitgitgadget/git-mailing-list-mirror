Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF08C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiKVOLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiKVOLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:11:15 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B45B95
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:11:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y24so15754518edi.10
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNxf9Mvhap/3yDCTHBU8uMI1zdjVyCGnh//3RJs5IHc=;
        b=SJsYjTmqvktvXOctiMOwMlSnTkcp/uh/uvPpqRKIt59DmQqeZ9ENkWKKbOLweqlIoH
         aEt3hOiMAeSblWOCs8ddB3QGDlfSbd2CIETBSpmLBYGVOcuME8b1mrevHGqXIjYE23xS
         s08C3oN5mCoQDHiuEWlySzRlhnzORuFF5xKEN/rmuiNLQQesiOJjm+uFF/lxNEWzi373
         VzS84wI89lwfkxvK4LMLrmahsiNxcjeFcy8R9vCotXVH76wVojQC0E3WKLvyDii4csHq
         cX7QnzFYhnqq1dJcNwAtmqHvaeHUQ8O0hs81SrrNhBSPSqgWSTt+b0hfp1KqfwCBzAXx
         epLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNxf9Mvhap/3yDCTHBU8uMI1zdjVyCGnh//3RJs5IHc=;
        b=4/oOTkj5fkKjOP+mPcz6J/NLFFlKgLhuQ1IPyvHOjYlNqVHKb6XHRIe7qeuMZRmL5O
         Z73dXrRMQwzA2/11L+TE3m5HfeC6pmSoFVkkyIgm4qkg6eBMlnq0FZ/xzfDdx6842Oej
         19AOaJEUxnnnopNLJaDgIQf3a9mpbX+M3aO5F8yJQI/1FrzueXLszQQMtfVEv4i1+hdu
         DpuxMeKHNw5M9ofblaXb18DCZwt1plfvHtSwp15NDXmHAEkKNuVoiX0sxB05gXCgiVuC
         F1slCdVzznXD6jC4zxJO7TfgKdkCeDbIA2WmQFTaAq2FObwwxiEh6fnpdUzIxHG0L5CM
         y9WQ==
X-Gm-Message-State: ANoB5pl0qnDmjL81nTyBDJARep+/x0WSWzu+ADM9kgqZVIHdP/qOFGE+
        1IoR8JTzc/BpO0dLi9Hx1G/B6stKV0EyVg==
X-Google-Smtp-Source: AA0mqf4bYpyLL3wlrItrKA2hs8Jrj904K9rk2iAjNitD3uz7TSIOmokF8r35F8a07xx9HMONBtIooA==
X-Received: by 2002:a05:6402:1859:b0:469:a5a6:5e9d with SMTP id v25-20020a056402185900b00469a5a65e9dmr8209568edy.418.1669126267181;
        Tue, 22 Nov 2022 06:11:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id w14-20020a056402070e00b004691de0e25bsm5221628edx.54.2022.11.22.06.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:11:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxTzN-000bLh-2b;
        Tue, 22 Nov 2022 15:11:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
Date:   Tue, 22 Nov 2022 15:01:24 +0100
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
Message-ID: <221122.864juraxl2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> +`os`::
> +	The data that follows this keyword is taken as the name of an
> +	Operating System, e.g. `Linux` or `Windows`; If it matches the
> +	current Operating System, the include condition is met.
> +
>  A few more notes on matching via `gitdir` and `gitdir/i`:

The reste of the "includeif" use glob matching and "/i" for icase. IOW
this is how this new feature would fit in:
	
	|--------+--------+----------+----------+------------------+----|
	|        | gitdir | gitdir/i | onbranch | hasconfig:remote | os |
	|--------+--------+----------+----------+------------------+----|
	| icase? | N      | Y        | N        | N                | Y  |
	| glob?  | Y      | Y        | Y        | Y                | N  |
	| path?  | Y      | Y        | Y        | Y                | N  |
	|--------+--------+----------+----------+------------------+----|

I think at least flipping that "glob" to "Y" so you could match e.g.
"*BSD" would be useful, and easier to explain in context, rather than
why the rest use wildmatch() and this doesn't.

For matching the uname the case doesn't really matter, but for
consistency of the interface I think making it case-sensitive or adding
an "os/i" would make sense. I.e. let's consistently use "/i" if & when
something's case-insensitive.

> +test_expect_success '[includeIf "os:..."]' '
> +	test_config x.y 0 &&
> +	echo "[x] y = z" >.git/xyz &&
> +
> +	if test_have_prereq MINGW
> +	then
> +		uname_s=Windows
> +	else
> +		uname_s="$(uname -s)"
> +	fi &&
> +	test_config "includeIf.os:not-$uname_s.path" xyz &&
> +	test 0 = "$(git config x.y)" &&
> +	test_config "includeIf.os:$uname_s.path" xyz &&
> +	test z = "$(git config x.y)"
> +'

As I pointed out in the v1, this still:

 * Hides segfaults in "git config", let's check the exit code.
 * Doesn't test the "icase" semantics you're introducing. Let's do that
   if it's intentional.
