Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC47E1F424
	for <e@80x24.org>; Tue, 10 Apr 2018 09:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeDJJfJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 05:35:09 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34796 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeDJJfI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 05:35:08 -0400
Received: by mail-wm0-f47.google.com with SMTP id w2so20957169wmw.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bW+s7VrpxBI7MQneOBgdwwNavFDWgf6eee+KJrgho2E=;
        b=dMLgwWLRwraZpVJHAi5v3qdG1UviOhlNwDPKnjHAlZ6tlGphpZcHMCR68826swwW+B
         GP41Xz8ArXIiwJljUeyXgcUliqKbICTDIO27JyGGZSe79qJKwGAB6GMIR349pIJxAXMG
         CdO4GGJ7HdMRhYc84mCiu6aQUsaNrwO2VBh0R6l6foe6NlW82kjSYqiQQ/MZTUoxpesn
         jt/olQP0E2xJqfqo1I0xcO3nJ+lVGrAC0o4dg+/lMxIGaeZ38fT95IKE/Zr6R2UFiydF
         kBYr3Kjg5EtFSY32i8l5029XSOHAapN9smE00vepdiZw5AlQDOXQigQiPcNFMFjsXkWj
         o+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bW+s7VrpxBI7MQneOBgdwwNavFDWgf6eee+KJrgho2E=;
        b=GIszlqlgbq59LNAvYzhjMnSXrewBQaucHto2sJk7JbA7Syq5acHk83wxMsLtSBrQM3
         HmH2VyqszSdFf5XFU8bApu/0P25pY88usi8lY488mxTKLQHKeg264N/xVskU/6Nq7DPY
         VxbX5tam6ML1jsqr3xi2Vc63IwCdqI9Ndg4HMYhTWSbumBtHFAcDg+I/5ArabFuu5KcS
         fVgFjzilPrGPmM7mJcElwiYFYdBFXTt/y6Z30Gy3jBve8r4ICrR2Cr7odw+AShtKRJnX
         3LSMsul0VM1hHjiKMmNUlEd8XvMFdQfDllGIgE44XzirdWdHAK1V+LIrgqMwLbvG9/hl
         S0jA==
X-Gm-Message-State: ALQs6tB0HoiXcsGVyXKVAtGot4Wm1Bp6sdih4Ale3gzwcqBQZPxs9p9B
        vQDJsmsPaWCLYeboFk2H7Y4=
X-Google-Smtp-Source: AIpwx4+JDmqG78WPAgR7qhioFgcKGm+2DoFyIl4DisDdxHEXE5zaKwYN8LFnniDxhN+nerxFLh9hLA==
X-Received: by 10.28.59.70 with SMTP id i67mr1039650wma.10.1523352906649;
        Tue, 10 Apr 2018 02:35:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q71sm2644666wmd.41.2018.04.10.02.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 02:35:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
References: <20180409204129.43537-1-mastahyeti@gmail.com>
        <20180409204129.43537-9-mastahyeti@gmail.com>
Date:   Tue, 10 Apr 2018 18:35:04 +0900
In-Reply-To: <20180409204129.43537-9-mastahyeti@gmail.com> (Ben Toews's
        message of "Mon, 9 Apr 2018 14:41:29 -0600")
Message-ID: <xmqqr2nn2ylz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Toews <mastahyeti@gmail.com> writes:

> From: Ben Toews <btoews@github.com>
>
> Currently you can only sign commits and tags using "gpg".
> ...
> have asked before on the list about using OpenBSD signify).
> ---

Missing sign-off.

> -gpg.program::
> -	Use this custom program instead of "`gpg`" found on `$PATH` when
> -	making or verifying a PGP signature. The program must support the
> -	same command-line interface as GPG, namely, to verify a detached
> -	signature, "`gpg --verify $file - <$signature`" is run, and the
> -	program is expected to signal a good signature by exiting with
> -	code 0, and to generate an ASCII-armored detached signature, the
> -	standard input of "`gpg -bsau $key`" is fed with the contents to be
> +signingtool.<name>.program::
> +	The name of the program on `$PATH` to execute when making or
> +	verifying a signature.

I think you do not want "on `$PATH`", as you should be able to
specify a full path /opt/some/where/not/on/my/path/pgp and have it
work just fine.  The mention of "found on `$PATH`" in the original
is talking about the behaviour _WITHOUT_ the configuration, i.e. by
default we just invoke "gpg" and expect that it is found in the
usual measure, i.e. being on user's $PATH.  What you are describing
in this updated explanation is what happens _WITH_ the configuration.

> +	This program will be used for making
> +	signatures if `<name>` is configured as `signingtool.default`.
> +	This program will be used for verifying signatures whose PEM
> +	block type matches `signingtool.<name>.pemtype` (see below). The
> +	program must support the same command-line interface as GPG.
> +	To verify a detached signature,
> +	"`gpg --verify $file - <$signature`" is run, and the program is
> +	expected to signal a good signature by exiting with code 0.
> +	To generate an ASCII-armored detached signature, the standard
> +	input of "`gpg -bsau $key`" is fed with the contents to be
>  	signed, and the program is expected to send the result to its
> -	standard output.
> +	standard output. By default, `signingtool.gpg.program` is set to
> +	`gpg`.

I do not think the description is wrong per-se, but reading it made
me realize that with this "custom" program, you still require that
the "custom" program MUST accept the command line options as if it
were an implementation of GPG.  Most likely you'd write a thin
wrapper to call your custom program with whatever options that are
appropriate when asked to --verify or -bsau (aka "sign")?  If that
is the case, I have to wonder if such a wrappper program can also
trivially reformat the --- BEGIN WHATEVER --- block and behave as if
it were an implementation of GPG.  That makes the primary point of
this long series somewhat moot, as we won't need that pemtype thing
at all, no?

> +signingtool.<name>.pemtype::
> +	The PEM block type associated with the signing tool named
> +	`<name>`. For example, the block type of a GPG signature
> +	starting with `-----BEGIN PGP SIGNATURE-----` is `PGP
> +	SIGNATURE`. When verifying a signature with this PEM block type
> +	the program specified in `signingtool.<name>.program` will be
> +	used. By default `signingtool.gpg.pemtype` contains `PGP
> +	SIGNATURE` and `PGP MESSAGE`.

As Eric noted elsewhere, I suspect that it is cleaner and more
useful if this were *NOT* "pemtype" but were "boundary", i.e.
letting "-----BEGIN PGP SIGNATURE-----\n" string be specified.

> +signingtool.default::
> +	The `<name>` of the signing tool to use when creating
> +	signatures (e.g., setting it to "foo" will use use the program
> +	specified by `signingtool.foo.program`). Defaults to `gpg`.

Will there be a command line option to say "I may usually be using
whatever I configured with signingtool.default, but for this single
invocation only, let me use something else"?  Without such a command
line option that overrides such a default, I do not quite get the
point of adding this configuration variable.

Thanks.
