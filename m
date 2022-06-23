Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB4AC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 10:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiFWKyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiFWKy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 06:54:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA04B1EA
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:54:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e40so15395595eda.2
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7iL+nK/GgPjAK64wzElss7FI3hMknvxlfkx0I7RL8/Y=;
        b=JSARyuVsCxY5lMKpTXE4yKaPNOLEOz1xVmbP6vd9aEN6twGR/iPPgvcfM9PiSNE6Lx
         ZisXlQJPQmcKkHoz3xrjDJmHS12ABRuYTVYWRLQ4pi2BVmwFWtTZGPgK5XY23UPYkmzX
         8ces2SBjlYqL0wVVUHA2GbrROEYqSsY31EaLAYwlyvVLf2Gxbn4bW+NzNQO5uLzMJg9G
         Vmc9mcdtYt67UTLqHCPE2qtZQNUNscjI50qnzZXJ15VrBXUkFRAIDJdD02wJ/ejlVTYh
         5kk+mc0vaOggc4NiPsYEXesWiVv9P1kTslkT5WYh8MPxqdpzNk76KV5TfPdKR3ZWx6Ip
         kjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7iL+nK/GgPjAK64wzElss7FI3hMknvxlfkx0I7RL8/Y=;
        b=KbGoOWW5fHB0UBBMg/hOh83aOhhX3ojbg50OSsXp++jNkBQeRARtykuJdq65dSme+5
         cwyKYy8qQWZcL8g1RZYLI8wKTlqGlSL+K5ofiBg5rNAAlEV1p+oiWpwOZKO8QRcHSa/A
         pAfPwemakLLofng0a3yHhcmDoXjcYmBPlzPEEKoyAB16JVRUBiHEI3fWWP7EeLvkFVlD
         tzcSwtOI3iGJ3O2OT3j/2sAGdYDJmDYdV4NmATC0Z8dyPP1/QhiCmAJIJP9nxLhPngps
         rC/+AAs33TEkR8rHrWk4lPtauJE2LlaZHz2+KQcUT3D7YrowWe7NtFA0XJfm1PHgKJQG
         2vbg==
X-Gm-Message-State: AJIora8/8bzNEowM+wvs+SHZ37d2O9ES6/qkdwWVLZr9qIGy21aq2xk8
        kYBd1O7AgxkjHRhBgy1vknCaKYOM98OiRg==
X-Google-Smtp-Source: AGRyM1vbJVVj2S/fi4rVf1PoY/f7FbOhkcQTnuk/SkOIRrPYZo21tdrRzCSqC8IHvB67WvnQOX5asA==
X-Received: by 2002:a05:6402:1771:b0:435:ba4c:eb4e with SMTP id da17-20020a056402177100b00435ba4ceb4emr7475278edb.172.1655981665575;
        Thu, 23 Jun 2022 03:54:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b006fe0abb00f0sm10522313eje.209.2022.06.23.03.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:54:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4KTg-000s9l-3g;
        Thu, 23 Jun 2022 12:54:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH] ls-files: update test style
Date:   Thu, 23 Jun 2022 12:50:01 +0200
References: <pull.1269.git.1655974015414.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1269.git.1655974015414.gitgitgadget@gmail.com>
Message-ID: <220623.86wnd7k5un.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 23 2022, Li Linchao via GitGitGadget wrote:

> From: Li Linchao <lilinchao@oschina.cn>
>
> Update test style in t/t30[*].sh for uniformity, that's to
> keep test title the same line with helper function itself.

We have a few of these sorts of old style tests, and it's good to update
them.

>     Write test code like this:
> diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
> index 48cec4e5f88..76361b92336 100755
> --- a/t/t3001-ls-files-others-exclude.sh
> +++ b/t/t3001-ls-files-others-exclude.sh
> @@ -67,26 +67,26 @@ echo '!*.2
>  
>  allignores='.gitignore one/.gitignore one/two/.gitignore'
>  
> -test_expect_success \
> -    'git ls-files --others with various exclude options.' \
> -    'git ls-files --others \
> +test_expect_success 'git ls-files --others with various exclude options.' '
> +	git ls-files --others \
>         --exclude=\*.6 \
>         --exclude-per-directory=.gitignore \
>         --exclude-from=.git/ignore \
>         >output &&

This though really stops too short, here we end up with:

	<TAB>git-ls-files --others \
	<7 spaces>--exclude [...]

> -     test_cmp expect output'
> +     test_cmp expect output

And you've space-indented this test_cmp, presumably the below has the
same issues (I didn't check in detail)

Instead the argument lists should be <TAB><TAB> indented, and the rest
should be TAB indented.

> +'
>  
>  # Test \r\n (MSDOS-like systems)
>  printf '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
>  
> -test_expect_success \
> -    'git ls-files --others with \r\n line endings.' \
> -    'git ls-files --others \
> +test_expect_success 'git ls-files --others with \r\n line endings.' '
> +	git ls-files --others \
>         --exclude=\*.6 \
>         --exclude-per-directory=.gitignore \
>         --exclude-from=.git/ignore \
>         >output &&
> -     test_cmp expect output'
> +     test_cmp expect output
> +'

Aside from the above I think it's also worth incorporating all the
"printf", "echo", "cat" etc. that we do into the "test_expect_success"
themselves, and if they're needed by more than one test perhaps make
them a "setup" helper function (which would test_when_finished "rm -f
.gitignore" clean up after itself).

That's obviously bigger than some whitespace changes, so we could punt
on it for now, but as we're looking at this anyway we could convert
fully to a more modern style in a follow-up commit...

> -test_expect_success \
> -    'git ls-files with path restriction with --.' \
> -    'git ls-files --others -- path0 >output &&
> +test_expect_success 'git ls-files with path restriction with --.' '
> +    git ls-files --others -- path0 >output &&
>  	test_cmp output - <<EOF
>  path0
>  EOF
>  '

On the topic of leaving things on the table: here we could use "<<-EOF"
(or actually better "<<-\EOF") instead, and indent the here-doc, as we
usually do.
