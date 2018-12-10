Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850CF20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 08:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeLJIpo (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 03:45:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45135 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIpo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 03:45:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id b14so9502689wru.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 00:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F5MJSi8glOgoRjS5XgdFtGUtrKO+WW9f8Ptw76WeZ0A=;
        b=rU2Yd6FNYy92BzCWAQoNnLhnEi8MWaIQ3nKps0SMVtRr2pjTMErA7y+8Wg83vbRoWs
         4oPlBOssBchW3EnK9z3mtSkWq8l6n/Tb/vC3AEcRTQcqUBSXoU7K//3w+ah/RGY6ZVjU
         rpeiqaQnHEMVpCyVGOm5tYOlwTB8cwhyVBBT8Ghn/IsDxGrtEHr2OAHfrGSp37gAH+I3
         N8avLO0EDx+ueDQ6WaceAYHr1wyPS1JA6Xs2lXqXI5nqyuEltldkrPm3VR4VmyO2prMt
         Dn3qMgI7apFNVCiIOAiLMuI1TAlprEi1O8qZBza7Tp03qH5Eby/0yu/X1T135GjUxrx0
         o79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F5MJSi8glOgoRjS5XgdFtGUtrKO+WW9f8Ptw76WeZ0A=;
        b=b4kWvF4yW4DZP7paXfzMi0csbOwBj7YMdWZYpgRuZEQ8okjiVMHHnuFUQMzYL4do9J
         0ppSVWiyl7uNNMGC1MWsJAtEx0SdxX9H1KxRw7o+ommTGeGbgo9CXJroi6D9sbX4Z2R8
         fsUf34ehJGfCHBoND5HRRjWgoZ0sIYASjXcwPwxiz8XOpVonqONtOKBKJbky8YNric2X
         NwF1a0sWACJ8VnUgDEE2v/XApkRK+PHqMm6biKiXpZo+F/eRWDXJ8qLfBeEkdzdcCKjX
         FtpyCB0kDHuvq8ZP+ZvnvXp5g413kXjvm9IM31x/XcJzY/zFCZ4bPeqa5Pu1NgDQ81dm
         wwRg==
X-Gm-Message-State: AA+aEWYFOj0+5du28VNZJ5AL6wPES+tJjYNsVJqQJCk5YFtlwFQqeCxS
        YiLYtgQ60qXHYbWMgyW1wXNo3QMzB6A=
X-Google-Smtp-Source: AFSGD/WKsul7S7QTjnrogotoa3+MuIvF5vpD0HeCm7OOVTDilskHFR9tTlQwTwK7xWdA/X0m0plYdw==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr8869500wrv.288.1544431541902;
        Mon, 10 Dec 2018 00:45:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f66sm9843432wmd.28.2018.12.10.00.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 00:45:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v4 2/7] pretty: allow %(trailers) options with explicit value
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181208163647.19538-1-anders@0x63.nu>
        <20181208163647.19538-3-anders@0x63.nu>
Date:   Mon, 10 Dec 2018 17:45:40 +0900
In-Reply-To: <20181208163647.19538-3-anders@0x63.nu> (Anders Waldenborg's
        message of "Sat, 8 Dec 2018 17:36:42 +0100")
Message-ID: <xmqqa7ldkbwr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> In addition to old %(trailers:only) it is now allowed to write
> %(trailers:only=yes)

s/$/. Similarly the unfold option can take a boolean./

> By itself this only gives (the not quite so useful) possibility to have
> users change their mind in the middle of a formatting
> string (%(trailers:only=true,only=false)). However, it gives users the
> opportunity to override defaults from future options.

Makes sense.

> +** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
> +   option was given. In same way as to for `only` it can be followed
> +   by an equal sign and explicit value. E.g.,
> +   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.

> +static int match_placeholder_bool_arg(const char *to_parse, const char *candidate,
> +				      const char **end, int *val)
> +{
> +	const char *p;
> +	if (!skip_prefix(to_parse, candidate, &p))
> +		return 0;
> +
> +	if (match_placeholder_arg(p, "=no", end) ||
> +	    match_placeholder_arg(p, "=off", end) ||
> +	    match_placeholder_arg(p, "=false", end)) {
> +		*val = 0;
> +		return 1;
> +	}
> +
> +	if (match_placeholder_arg(p, "", end) ||
> +	    match_placeholder_arg(p, "=yes", end) ||
> +	    match_placeholder_arg(p, "=on", end) ||
> +	    match_placeholder_arg(p, "=true", end)) {
> +		*val = 1;
> +		return 1;
> +	}

Hmph.  Is there a possibility to arrenge the code so that we do not
have to maintain these variants of true/false representations here,
when we should already have one in config.c?

The match_placeholder_arg() function is a bit too limiting as it can
only recognize the value that we know about for a thing like this.
Instead, perhaps we can cut what follows "=" syntactically, looking
for either NUL, ',', or ')', and then call git_parse_maybe_bool() on
it.  That way, we can handle %(trailers:only=bogo) more sensibly,
no?  Syntactically we can recognize that the user wanted to give
'bogo' as the value to 'only', and say "'bogo' is not a boolean" if
we did so.

> +	return 0;
> +}
> +
