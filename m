Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222081F453
	for <e@80x24.org>; Mon, 28 Jan 2019 22:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfA1Wiv (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 17:38:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50331 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfA1Wiv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 17:38:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so15812538wmd.0
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6WMPQc9YkML9BuLyOUk6exT0j6yR/xHhaJOVO0sL9MU=;
        b=HS79aQo5bykHwWCjsWsEZ7iOoYTS0QJnoozpgrxkT8yKf00ZwwTvr0lmFQqqLal9/E
         YfNZEOCUU3Vy0CDQdmnZYCD0gw8qvyhtRjfOscUTOLX3vQB1fZ7iaxbaiyABaiGId0bY
         sdOlj9i/EoBOEU8qNph3atFQPY1GZ/u/x5veNdKXfLIS1rE+g0Sj8/qoZAgeqDAhpt1f
         /9QswkaTPvOuTrGH2rkDeci8OwKtNyJrDWGZnit/i7Y1u738oDdUYFbhfGTkzUgQ776y
         tRDKzxv3hot881tCrCQVALMrBLrKekLfS0YUkpClX1QFBz8OrR9mgDIGX8KD/a33FVgT
         KJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6WMPQc9YkML9BuLyOUk6exT0j6yR/xHhaJOVO0sL9MU=;
        b=hWLefD+IKraXDE5gzSp2+auZj7VrnzSotACRGYE1V+caMKDaBUeEg7BRUqt+qd3piP
         AWxmtoyX1FqOm+ozhUBtIrJFBGt17DmpJZ8o71F16AH6SrORXSY+y8MoiD4u5D8GqeSV
         AWMhAaNTIKMj8ai8ivTp80salWHZpDJdqclP/OJ8L7Bun0hpb5Eh0QHZrMrh1Moh1VuD
         IyREjxB7zA18aOHWCHJDc63EEZwZtJ0E1l+DlOHDNQLYyYwtLMjUI+1RxRhV+LUl8e7v
         2UlCVIPkEIrinVCdthf1aff6Kqi4npw0OefwRTQDa7dSWO+x/qwuwqNIrntKy1NJoKXK
         nxNQ==
X-Gm-Message-State: AHQUAua2Pc47feUdNrTHY3OjOUUdDnt6YS++Yye1ZNrWZgvZPFDDmM6x
        Oe3N/eWPVtVrJy0cbjjIZ0XCEi2f
X-Google-Smtp-Source: AHgI3IZQs1YQsdMYrdTbCY5WahBZHb/7o0IDqUgSs575xVBeG/HCuViwPbRbPPJ2f6Swhm4iZgzGzA==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr903236wmf.99.1548715128055;
        Mon, 28 Jan 2019 14:38:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q3sm129876803wrn.84.2019.01.28.14.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 14:38:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/7] pretty: Allow %(trailers) options with explicit value
References: <20181028125025.30952-1-anders@0x63.nu>
        <20190128213337.24752-1-anders@0x63.nu>
        <20190128213337.24752-3-anders@0x63.nu>
Date:   Mon, 28 Jan 2019 14:38:46 -0800
In-Reply-To: <20190128213337.24752-3-anders@0x63.nu> (Anders Waldenborg's
        message of "Mon, 28 Jan 2019 22:33:32 +0100")
Message-ID: <xmqq8sz49zm1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> Subject: Re: [PATCH v5 2/7] pretty: Allow %(trailers) options with explicit value

Style: s/pretty: Allow/pretty: allow/ (haven't I said this often enough?)

> +** 'only[=val]': select whether non-trailer lines from the trailer
> +   block should be included. The `only` keyword may optionally be
> +   followed by an equal sign and one of `true`, `on`, `yes` to omit or
> +   `false`, `off`, `no` to show the non-trailer lines. If option is
> +   given without value it is enabled. If given multiple times the last
> +   value is used.
> +** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
> +   option was given. In same way as to for `only` it can be followed
> +   by an equal sign and explicit value. E.g.,
> +   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.

Sounds sensible.

> diff --git a/pretty.c b/pretty.c
> index b83a3ecd23..b8d71a57c9 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1056,13 +1056,25 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
>  	return 0;
>  }
>  
> -static int match_placeholder_arg(const char *to_parse, const char *candidate,
> -				 const char **end)
> +static int match_placeholder_arg_value(const char *to_parse, const char *candidate,
> +				       const char **end, const char **valuestart, size_t *valuelen)

An overlong line here.

> ...
> +static int match_placeholder_bool_arg(const char *to_parse, const char *candidate,
> +				      const char **end, int *val)
> +{
> +	char buf[8];
> +	const char *strval;
> +	size_t len;
> +	int v;
> +
> +	if (!match_placeholder_arg_value(to_parse, candidate, end, &strval, &len))
> +		return 0;
> +
> +	if (!strval) {
> +		*val = 1;
> +		return 1;
> +	}
> +
> +	strlcpy(buf, strval, sizeof(buf));
> +	if (len < sizeof(buf))
> +		buf[len] = 0;

Doesn't strlcpy() terminate buf[len] if len is short enough?
Even if the strval is longer than buf[], strlcpy() would truncate
and make sure buf[] is NUL terminated, no?

> +	v = git_parse_maybe_bool(buf);

Why?

This function would simply be buggy and incapable of parsing a
representation of a boolean value that is longer than 8 bytes (if
such a representation exists), so chomping an overlong string at the
end and feeding it to git_parse_maybe_bool() is a nonsense, isn't
it?

In this particular case, strlcpy() is inviting a buggy programming.
If there were a 7-letter representation of falsehood, strval may be
that 7-letter thing, in which case you would want to feed it to
git_parse_maybe_bool() to receive "false" from it, or strval may
have that 7-letter thing followed by a 'x' (so as a token, that is
not a correctly spelled falsehood), but strlcpy() would chomp and
show the same 7-letter falsehood to git_parse_maybe_bool().  That
robs you from an opportunity to diagnose such a bogus input as an
error.

Instead of using "char buf[8]", just using a strbuf and avoidng
strlcpy() would make the code much better, I would think.

