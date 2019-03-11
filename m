Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0159A20248
	for <e@80x24.org>; Mon, 11 Mar 2019 02:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfCKC6p (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 22:58:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32890 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfCKC6p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 22:58:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id i8so3376329wrm.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 19:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WDhQRlAbDv5SWXHn8mCr+Moqu+9cX26pfNwDjt7Lc+0=;
        b=JRyITuj3N1RBAKNtqeup+pgrLfXPG8OsUYgAbI1sy6nMTABMTOKgTjiP5Gl0rZci+K
         7CBi/o29ZO/dYV2MDvPfno2j6y3U3G0rmtmsqjaAjeYdB4IrrSC7kvxGW7mGIMurR8au
         PY4hwYgwe2nNGUair5fwb6m7HGzrgbK0ybxHwESFumgOC+01ELxqD+61U3vWd0dpJQF2
         sfVemjda8nXAmc6BkM8mEODxabwQRihN80Pk9qvi+YvXEHFOIygvH6zi518KNAkMBHPk
         QLnSwRCjYGJ3lwAvmlwQskj7OD1H2BBhxtYqf4UyPSaLKVsQ9kw/RHp/ybZx/SZD42Yn
         9/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WDhQRlAbDv5SWXHn8mCr+Moqu+9cX26pfNwDjt7Lc+0=;
        b=iljomoTaq+3ESYfbH/9lCs4mfz4y/J517U7dkqMiwP63uke9mQYjv1c7KSBKIUneEI
         eZb2xonL6sGMgaEBo79FPnGm2UqrHeflvQ7ZUnrrMup8kyoyKtsdNwdCgs0F+a573TMm
         zIQxwfS3oGqFyDG19qHPetk2oSeq8mb9yyKpSUuRZu6tn/kPnxtKe6bsQSwy/MMRRK+r
         mH5Gr75WPDRciV4PRuDWqcx6yVEFSe+KnCdQT0ZIDscSNXAt+xm4sNh8Sv9JKIA77LF8
         vyD0hk2ITarIqZwWMPwcgADEWdlMi/Lo9PgOQAKmj7r9NraHk4dk5WZ898nTw8r6IHtz
         lCRw==
X-Gm-Message-State: APjAAAVrzXGNMQyAFyIa1mdSu9C1D/ZVvfOD2MlUIzA4COJqIz3LK3Yv
        aDXOWBEUXQ89VBIUby8J8S7Jz6a0dQg=
X-Google-Smtp-Source: APXvYqwoYZEcfjjr29n53iFVJLlTbN+2/rIJP4/k7fpGlT6d+wYmyvFLILI1IVgIsAK5jgJbC4fekA==
X-Received: by 2002:adf:81a1:: with SMTP id 30mr20091971wra.285.1552273123053;
        Sun, 10 Mar 2019 19:58:43 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a8sm18565351wmh.26.2019.03.10.19.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 19:58:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC v1 1/1] convert.c: Escape sequences only for a tty in trace_encoding()
References: <20190310061914.24554-1-tboegi@web.de>
Date:   Mon, 11 Mar 2019 11:58:41 +0900
In-Reply-To: <20190310061914.24554-1-tboegi@web.de> (tboegi's message of "Sun,
        10 Mar 2019 07:19:14 +0100")
Message-ID: <xmqqo96iktge.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

>  I am temped to remove the "dim" functionality all together,
>  or to remove the printout of the values which are now dimmed,
>  what do others think ?

I am for removing the color settings we see here for two reasons.
One is that the tracing is primarily for machine readability.
Another is that if we want to have an option to make the output more
human friendly, we should have (a) a facility for users of the
tracing mechanism, like the codepath we see here, to mark the parts
of its output in a more logical ways (e.g. "here comes a less
important piece of info"), (b) a knob to tell the tracing mechanism
what kind of output (e.g. "more friendly to humans using color") is
requested, and (c) code in the tracing mechanism (e.g. the helper
functions implemented at the same level as trace_printf()), and what
we have are far from such a structured thing---and then such a new
effort for more structured tracing should probably go to the trace2
effort jeffhost is spearheading.

But I am speaking as just one of the reviewers here, and if people
feel differently, I would want to hear it first before deciding
anything.

Thanks.


> convert.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 5d0307fc10..70e58f1413 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -42,6 +42,9 @@ struct text_stat {
>  	unsigned printable, nonprintable;
>  };
>
> +static const char *terminal_half_bright;
> +static const char *terminal_reset_normal;
> +
>  static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
>  {
>  	unsigned long i;
> @@ -330,14 +333,23 @@ static void trace_encoding(const char *context, const char *path,
>  	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
>  	struct strbuf trace = STRBUF_INIT;
>  	int i;
> -
> +	if (!terminal_half_bright || !terminal_reset_normal) {
> +		if (isatty(1)) {
> +			terminal_half_bright  = "\033[2m";
> +			terminal_reset_normal = "\033[0m";
> +		} else {
> +			terminal_half_bright = "";
> +			terminal_reset_normal = "";
> +		}
> +	}
>  	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
>  	for (i = 0; i < len && buf; ++i) {
> +		char c = buf[i] > 32 && buf[i] < 127 ? buf[i] : ' ';
>  		strbuf_addf(
> -			&trace, "| \033[2m%2i:\033[0m %2x \033[2m%c\033[0m%c",
> -			i,
> +			&trace, "| %s%2i:%s %2x %s%c%s%c",
> +			terminal_half_bright, i, terminal_reset_normal,
>  			(unsigned char) buf[i],
> -			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
> +			terminal_half_bright, c, terminal_reset_normal,
>  			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
>  		);
>  	}
> --
> 2.21.0.135.g6e0cc67761
