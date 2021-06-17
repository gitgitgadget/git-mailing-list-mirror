Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1171C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46106100A
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhFQHSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhFQHSe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:18:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AD6C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:16:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id my49so8049491ejc.7
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cOL9UNcYpb/NH9/VKCCMe2u+jZz2FgJOkK+4swu4Kik=;
        b=nEgxocRGZuA0zTaDk7LnukT4ZHvTMjCX4MOc6BBluyJVB4rrWriWf0QUirwb/7tYw/
         czK44Rl1IudYTVDYeVLOu2rMv4RxUj5F7jwdWFbNHu5aO8UZWBl6Sh5afioAYwIcPp/F
         sp1Yt0pD97CIDCpyxhPVRJYGTchw6afVIw/VqYEYzvnbBt+I75PPNXC1s95guxW5+p8F
         zN7/jowWQee0m6T1I1rdNb246AIfEuDu/eR49KFSJr7GlmzDH95XrVkMTye7f7Hhhog7
         DIeaMtTTpfkhOCEITkDVwwJmVJNAt7nUhQCTvzDx+6XoZniZQa2mYMCM57O038vnlStY
         gyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cOL9UNcYpb/NH9/VKCCMe2u+jZz2FgJOkK+4swu4Kik=;
        b=tZz5y8U7GmpQ4q8u1vrEHtvQWvkOKgyHMlrTrxs2Y9K8c3/Jj7GX52GEAdIh1lJLbP
         ZS5THYX7OUg82nL7wuSymdZUmfpkgzQGenz3Z9ceSMaTnJIed2Otr+J1usp/gDdgwc+C
         8X3V7+IphBkNVesvDZGX0A8tsTxd7hleGY5KMfHa97YWKDxCxP8z9BrdmvO8b0fAjt/A
         OP7fVozUUF9NyRlYLw8Ho27bzdpktgA5lTH6VglM9CkPYZqpbM66RpL9x5L80P4YIvTK
         8jTg9cBCej/IZ1+CdybqOhZXgajvd5snQNwO++Guz5PkWoztKwfhMe0CaEtE0rslj/2f
         Faug==
X-Gm-Message-State: AOAM532ZhkTN5bnOwARiKbZjQzNX/1qr+uY8IfZTuGcVSUqe1X8T7qmH
        58Ww4NVcP8+v1Q3oFztmMaphghAJaHB4vQ==
X-Google-Smtp-Source: ABdhPJwYSm8O0yQndgRApZXXTDZdKMg59Cvh9VLRR9q26/nmnJmldp+8Gh8MxskLqDvk2LCLZ640OQ==
X-Received: by 2002:a17:907:1689:: with SMTP id hc9mr3754051ejc.552.1623914184212;
        Thu, 17 Jun 2021 00:16:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u12sm3100859eje.40.2021.06.17.00.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:16:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/8] [GSOC] ref-filter: add %(raw) atom
Date:   Thu, 17 Jun 2021 09:10:34 +0200
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <abee6a03becb929ffb292648d1ef64e61b66d53d.1623496458.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <abee6a03becb929ffb292648d1ef64e61b66d53d.1623496458.git.gitgitgadget@gmail.com>
Message-ID: <875yydx8oo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 12 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Add new formatting option `%(raw)`, which will print the raw
> object data without any changes. It will help further to migrate
> all cat-file formatting logic from cat-file to ref-filter.

Nice goal and feature to have.

> The raw data of blob, tree objects may contain '\0', but most of
> the logic in `ref-filter` depends on the output of the atom being
> text (specifically, no embedded NULs in it).
>
> E.g. `quote_formatting()` use `strbuf_addstr()` or `*._quote_buf()`
> add the data to the buffer. The raw data of a tree object is
> `100644 one\0...`, only the `100644 one` will be added to the buffer,
> which is incorrect.
>
> Therefore, add a new member in `struct atom_value`: `s_size`, which
> can record raw object size, it can help us add raw object data to
> the buffer or compare two buffers which contain raw object data.

Most of the functions that deal with this already use a strbuf in some
way, before we had a const char *, now there's a size_t to go along with
it, why not simply use a strbuf in the struct for the data? You'll then
get the size and \0 handling for free, and any functions to deal with
conversion can stick to the strbuf API, there seems to be a lot of back
and forth now.

> Beyond, `--format=%(raw)` cannot be used with `--python`, `--shell`,
> `--tcl`, `--perl` because if our binary raw data is passed to a variable
> in the host language, the host language may not support arbitrary binary
> data in the variables of its string type.

Perl at least deals with that just fine, and to the extent that it
doesn't any new problems here would have nothing to do with \0 being in
the data. Perl doesn't have a notion of "binary has \0 in it", it always
supports \0, it has a notion of "is it utf-8 or not?", so any encoding
problems wouldn't be new. I'd think that the same would be true of
Python, but I'm not sure.


> +test_expect_success 'basic atom: refs/tags/testtag *raw' '
> +	git cat-file commit refs/tags/testtag^{} >expected &&
> +	git for-each-ref --format="%(*raw)" refs/tags/testtag >actual &&
> +	sanitize_pgp <expected >expected.clean &&
> +	sanitize_pgp <actual >actual.clean &&
> +	echo "" >>expected.clean &&

Just "echo" will do, ditto for the rest. Also odd to go back and forth
between populating expected.clean & actual.clean.


> +test_expect_success 'set up refs pointing to binary blob' '
> +	printf "a\0b\0c" >blob1 &&
> +	printf "a\0c\0b" >blob2 &&
> +	printf "\0a\0b\0c" >blob3 &&
> +	printf "abc" >blob4 &&
> +	printf "\0 \0 \0 " >blob5 &&
> +	printf "\0 \0a\0 " >blob6 &&
> +	printf "  " >blob7 &&
> +	>blob8 &&
> +	git hash-object blob1 -w | xargs git update-ref refs/myblobs/blob1 &&
> +	git hash-object blob2 -w | xargs git update-ref refs/myblobs/blob2 &&
> +	git hash-object blob3 -w | xargs git update-ref refs/myblobs/blob3 &&
> +	git hash-object blob4 -w | xargs git update-ref refs/myblobs/blob4 &&
> +	git hash-object blob5 -w | xargs git update-ref refs/myblobs/blob5 &&
> +	git hash-object blob6 -w | xargs git update-ref refs/myblobs/blob6 &&
> +	git hash-object blob7 -w | xargs git update-ref refs/myblobs/blob7 &&
> +	git hash-object blob8 -w | xargs git update-ref refs/myblobs/blob8

Hrm, xargs just to avoid:

    git update-ref ... $(git hash-object) ?

> +test_expect_success '%(raw) with --python must failed' '
> +	test_must_fail git for-each-ref --format="%(raw)" --python
> +'
> +
> +test_expect_success '%(raw) with --tcl must failed' '
> +	test_must_fail git for-each-ref --format="%(raw)" --tcl
> +'
> +
> +test_expect_success '%(raw) with --perl must failed' '
> +	test_must_fail git for-each-ref --format="%(raw)" --perl
> +'
> +
> +test_expect_success '%(raw) with --shell must failed' '
> +	test_must_fail git for-each-ref --format="%(raw)" --shell
> +'
> +
> +test_expect_success '%(raw) with --shell and --sort=raw must failed' '
> +	test_must_fail git for-each-ref --format="%(raw)" --sort=raw --shell
> +'

s/must failed/must fail/, but see question above about encoding in these
languages...
