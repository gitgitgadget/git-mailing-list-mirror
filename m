Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E8DC6FA82
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 21:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiIBVAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiIBVAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 17:00:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0697509
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 14:00:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bz13so331501wrb.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=CETWTj1sG8WZXgA1Jk47VYu69GWexsxk3DKxPOhKbQk=;
        b=Mlyf24rgMsL7Ke5D2nNVMf4EkIRzsnpNsJ+y1KDcUY4oHoqaYKjqyCxNF0p6jljxFg
         G+Jn3KJ6C+B/zdywrQQdDq7vsJQkmrq9Ttvg1nOoU+29jWIPBg0ljnMcIQ9LXE9lkKkq
         WxSj4nQ3XC9T8rSpFOZPk1lRzGFhPKmrfqiprA0QA1A/K7Nx3ht41yknup/XT6MmEjpY
         10LjNIQDObvJw2fIuwS0LTslg38X2TzTUEiLQvxFdlp1Vl+pbRlH65t+5eaNW8e4/kd3
         GRiRTYA9nAOrjjYR+x+2kEidsyHlCIOb+EUoylejSwGEXNDNFCaKsz8T3jxByuhNg4YV
         X50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CETWTj1sG8WZXgA1Jk47VYu69GWexsxk3DKxPOhKbQk=;
        b=NiNpjVbSdqaPzqVLgyflXoRD81EKcKu90mvWXPPfbXIBZPF+ffT+CGD73bs7VbDgLh
         u9CyFbIoXUdWF13a5wqGj8hWg7H8ODLeRLqMjaO7amWlGET9q9YEaEsIC+9KOlDEeScZ
         x6iMsEAYS7j4yV46zx1hZnUzPkrQYMXQuLJjMvfU1zqiNbD+kdnRWGVW8pAlzcgPhT05
         TcOr662+b1RSZVb4N2FWxY04uD4fyEl3yCNKsVWbQG0Bk2maTLrYd/tOBwsBqsUh4A7W
         uySemXFy6Ujv9FEdxIEnVsJskH5jYGCp+crXRPOTbgjRbWBd2UA+M4Y7ppK/AEt7rvlO
         wOhA==
X-Gm-Message-State: ACgBeo3SPCErOhqerS/XhUBdJQxIanAvOjy708oaDFu+ewSKNAkJPJIB
        gyRyVtLRZ8+g+4agfOEfWW6mj/DE7Fc=
X-Google-Smtp-Source: AA6agR5CAhjHTYr5l98hS+gbx/2f4K5n0P4i/0xECpsNlFJM4BoZFRFn0P6AdjBR/YMxtFnLEr4OPw==
X-Received: by 2002:a5d:6b09:0:b0:225:37cf:fb8b with SMTP id v9-20020a5d6b09000000b0022537cffb8bmr18452732wrw.179.1662152427825;
        Fri, 02 Sep 2022 14:00:27 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b002253d865715sm2285995wrs.87.2022.09.02.14.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:00:27 -0700 (PDT)
Date:   Fri, 2 Sep 2022 23:00:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, ingy@ingy.net
Subject: Re: [PATCH] rev-parse --parseopt: detect missing opt-spec
Message-ID: <20220902210025.GA1839@szeder.dev>
References: <xmqq5yi5aghf.fsf@gitster.g>
 <20220902175902.22346-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902175902.22346-1-oystwa@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2022 at 07:59:02PM +0200, Øystein Walle wrote:
> After 2d893dff4c (rev-parse --parseopt: allow [*=?!] in argument hints,
> 2015-07-14)

Oh, no, that's not the first bad commit!  The segfault started
earlier, with commit 9bab5b6061 (rev-parse --parseopt: option argument
name hints, 2014-03-22).

Before that it printed the following for the spec input used in the
new test:

  $ ./git rev-parse --parseopt -- <spec
  set -- --

I'm not sure what the desired behavior should have been back then.

Anyway, since 2d893dff4c the documentation is clear that 'opt-spec'
"May not contain any of the `<flags>` characters", so now erroring out
is the right thing to do.

> updated the parser, a line in parseopts's input can start
> with one of the flag characters and be erroneously parsed as a opt-spec
> where the short name of the option is the flag character itself and the
> long name is after the end of the string. This makes Git want to
> allocate SIZE_MAX bytes of memory at this line:
> 
>     o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
> 
> Since s and sb.buf are equal the second argument is -2 (except unsigned)
> and xmemdupz allocates len + 1 bytes, ie. -1 meaning SIZE_MAX.
> 
> Avoid this by checking whether a flag character was found in the zeroth
> position.
> 
> Reported-by: Ingy dot Net <ingy@ingy.net>
> Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> 
> Hi guys, thanks for the review. I incorporated a reference to the old
> commit into the message (and took the liberty of adding --parseopt to
> the subject like it had). I tried to verify that it was in fact this
> commit, since the code prior to this one had the exact same xmemdupz()
> call. I wasn't able to build that commit,

Yeah, that's why I didn't check it in the morning...

NO_OPENSSL=1 NO_PERL_MAKEMAKER=1 sometimes helps building older
versions on modern setups, and, FWIW, Ubuntu 16.04 can build both
today's Git and v1.6.0 (my goto version when I want to check
historical behavior) even with OPENSSL.

>  builtin/rev-parse.c           | 3 +++
>  t/t1502-rev-parse-parseopt.sh | 7 +++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index b259d8990a..85c271acd7 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -479,6 +479,9 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>  		if (!s)
>  			s = help;
>  
> +		if (s == sb.buf)
> +			die(_("missing opt-spec before option flags"));
> +
>  		if (s - sb.buf == 1) /* short option only */
>  			o->short_name = *sb.buf;
>  		else if (sb.buf[1] != ',') /* long option only */
> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
> index 284fe18e72..de1d48f3ba 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -306,6 +306,13 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'test --parseopt invalid opt-spec' '
> +	test_write_lines x -- "=, x" >spec &&
> +	echo "fatal: missing opt-spec before option flags" >expect &&
> +	test_must_fail git rev-parse --parseopt -- >out <spec 2>err &&
> +	test_cmp expect err
> +'
> +
>  test_expect_success 'test --parseopt help output: multi-line blurb after empty line' '
>  	sed -e "s/^|//" >spec <<-\EOF &&
>  	|cmd [--some-option]
> -- 
> 2.34.1
> 
