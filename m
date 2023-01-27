Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD2BC38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 16:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjA0QeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 11:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjA0QeS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 11:34:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAE7618E
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 08:34:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k13so5585615plg.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yr+QG+kQ5i8MX81UWjf+Ph25/Qgye1e96eYhC9LsKE=;
        b=a7xOPKiESK7goX/8+d7KDBVSbsJdtGescGpywtzK6IS2b+5EqQpjNSb9y/Pp8ghpeq
         DhL9ldhips+oSkVRG6aUzZRBsg2gUZOHn7WpViW/5gti4oBA28kpVottu4EaiTAmYD/b
         yL5YOebSVIP5fVwsxF6KnCI/7qENmu++3fCl1L8EpqQ4NUDioJoREoUTXBJDA3RRi8DM
         l94nxqnDhpXnTFikza5T9mKhG83+B2WCm2t88x8gbilCUF5A2CzEFmtYwuiPFDzknqGW
         8+eOUThCzyc/hnOCx19bXEZzlb8uhw3rzDVImqTROkJPfFCrSw9fjjp/k1U6I1HW3rCm
         HFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1yr+QG+kQ5i8MX81UWjf+Ph25/Qgye1e96eYhC9LsKE=;
        b=s88NQTE3r5wbEEMs0zl9AqiouUmC8HEX9O64a3vY6dR62c4Q3umTsboDwGYYPEbeN+
         ytcI5iFg9eq9d2ky9bHHsq8523yBVRUvH7S+KQH+cO0Qj+cejfo3Wxz6NRaGKBoyFTjp
         lSJcY+Ngb8cRTLRbpxisto9WcGrkz4r/fOMJkcvD7EJ5BqVedKpYfyhUbWeXL7LxOnMF
         d67gonkc8k72Azmq+k7TyADQ7esC5/gvDUOV+S2OFtirJ6hPLh71je3ePnWkA+fB/aMr
         nRadtR4VNQepuh6fFzlPxGqOdutt561IPTdUlBq4KG+egmb6uUxJshf8an77lfKKfUUs
         nWRg==
X-Gm-Message-State: AO0yUKXu/stkGvzrhSlR655mksZrgWicSarbObUonIQHiuh2TZC3sxBm
        XpWnW6QPdlxutsej4GPr/4Q=
X-Google-Smtp-Source: AK7set+Ym+RO/l1unORc8+AoITcPoGQ4vy++V2YShDw154zRcRRPf/UkVuoIsXURTpf5xkjp4tZnbA==
X-Received: by 2002:a17:903:1ca:b0:196:1519:3538 with SMTP id e10-20020a17090301ca00b0019615193538mr16134463plh.57.1674837257255;
        Fri, 27 Jan 2023 08:34:17 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709026e0100b001929f0b4582sm3031987plk.300.2023.01.27.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:34:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
Date:   Fri, 27 Jan 2023 08:34:16 -0800
In-Reply-To: <20230127154952.485913-1-minipli@grsecurity.net> (Mathias
        Krause's message of "Fri, 27 Jan 2023 16:49:52 +0100")
Message-ID: <xmqqbkmk9bsn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> As having a functional PCRE2 JIT compiler is a legitimate use case for
> performance reasons, we'll only do the fallback if the supposedly
> available JIT is found to be non-functional by attempting to JIT compile
> a very simple pattern. If this fails, JIT is deemed to be non-functional
> and we do the interpreter fallback. For all other cases, i.e. the simple
> pattern can be compiled but the user provided cannot, we fail hard as we
> do now as the reason for the failure must be the pattern itself.

I do not know if it is a good idea to rely on the "very simple
pattern".  The implementation of JIT could devise various ways to
succeed for such simple patterns without having writable-executable
piece of memory.  What happened to the earlier idea of falling back
to the interpreted codepath, which will catch any bad pattern that
has "the reason for the failure" by failing anyway?

> +static int pcre2_jit_functional(void)
> +{
> +	static int jit_working = -1;
> +	pcre2_code *code;
> +	size_t off;
> +	int err;
> +
> +	if (jit_working != -1)
> +		return jit_working;
> +
> +	/*
> +	 * Try to JIT compile a simple pattern to probe if the JIT is
> +	 * working in general. It might fail for systems where creating
> +	 * memory mappings for runtime code generation is restricted.
> +	 */
> +	code = pcre2_compile((PCRE2_SPTR)".", 1, 0, &err, &off, NULL);
> +	if (!code)
> +		return 0;
> +
> +	jit_working = pcre2_jit_compile(code, PCRE2_JIT_COMPLETE) == 0;
> +	pcre2_code_free(code);

I'd prefer not having to worry about: Or it might not fail for such
systems, as the pattern is too simple and future versions of
pcre2_compile() could have special case code.

> @@ -317,8 +342,23 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
>  	if (p->pcre2_jit_on) {
>  		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
> -		if (jitret)
> +		if (jitret == PCRE2_ERROR_NOMEMORY && !pcre2_jit_functional()) {
> +			/*
> +			 * Even though pcre2_config(PCRE2_CONFIG_JIT, ...)
> +			 * indicated JIT support, the library might still
> +			 * fail to generate JIT code for various reasons,
> +			 * e.g. when SELinux's 'deny_execmem' or PaX's
> +			 * MPROTECT prevent creating W|X memory mappings.
> +			 *
> +			 * Instead of faling hard, fall back to interpreter
> +			 * mode, just as if the pattern was prefixed with
> +			 * '(*NO_JIT)'.
> +			 */
> +			p->pcre2_jit_on = 0;
> +			return;

Yes, the "instead of failing hard, fall back" makes sense.  Just
that I do not see why the runtime test is a good thing to have.  In
short, we are not in the business of catching bugs in pcre2_jit
implementations, so if they say they cannot compile the pattern (I
would even say I doubt the point of checking the return code to
ensure it is NOMEMORY), it would be fine to let the interpreter
codepath to inspect the pattern and diagnose problems with it, or
take the slow match without JIT.

What am I missing?
