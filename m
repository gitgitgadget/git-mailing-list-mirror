Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F3C433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 21:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiAIVh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 16:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiAIVh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jan 2022 16:37:58 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014AC06173F
        for <git@vger.kernel.org>; Sun,  9 Jan 2022 13:37:58 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id t66so12885937qkb.4
        for <git@vger.kernel.org>; Sun, 09 Jan 2022 13:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k++J1sE1pUn5SzIPFEDOiZfKNs1ZfYpZ0LCOXfepkrQ=;
        b=fVkk4tXlv4Op56BOAKoRhMxQcZ9E4hs4lGrPrYRM+a0KOceLOjANEgRuSFRMUgDaP/
         4OhT/Zt0GAwPP23U5OZoKBFhBZdraKngwqt8EaoShKoQhu5jmcQ3g7mpyLlPiShlShEg
         bqRDaXq89g3QEhfc2QS95GEX4eNdNI6tCVUoVVSGMl6DvRfi6SQZ0zjG25TU8p4gaAff
         kP82Z+05AYONGCC++ZPZkcYpUDGYjye9FfS4vz5hUS0Z8o3D+hbubjfMQ9/gND8g/rys
         C5rui3ogvCzbBwf+/qTB4KSNhx/i6LV4mx0zcLRAVfmOP1T+yKB3yJDSOmIISCxSBY3B
         Pjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=k++J1sE1pUn5SzIPFEDOiZfKNs1ZfYpZ0LCOXfepkrQ=;
        b=M0GJME0E5LSmh8n1OGxZod/Fz2tV6ODhqt+6C7YKt/ujlLPp6jDnS6zamonEXJjuGU
         s4avLUgQ6qFgfih6dVTU/4Poq2o0+ncc+m7uYdMUYGZXJewW6V/vjKDfCxgklCAkpuXq
         HtHwWEjXp938cNBLqYUQHPuN5AMQXzTOTsVB+Wj+XKNVVkcAmGOfUPVTHki6+jN0mUIk
         QQvPB+q5sns3P+BQWfkhgXCjVCUMpTyspNpA6G2vR4y/yAyvumVARb8DR6VriKQrE2XZ
         e/vCWX8Wsfz2jq+lQXWP/RrW8dCaIsKQDEd1nFOloSYQx/vcx1D1L5HUKt3eYjsAFF/V
         H3ag==
X-Gm-Message-State: AOAM533S6I34o3mkNZ+2kAav03y1lhYbM/VvYOukPEXp44QJexON5ZmM
        +WaH9uDC8zB2edyAtiG0Ncm8gERPRPkqcA==
X-Google-Smtp-Source: ABdhPJy6inczhlAEhPTtqsdU5Dx46+0lxuNp89aNFfG4bj1SjOO8SXK+Rxj1+wnaCq1eHe//LRcRvA==
X-Received: by 2002:a05:620a:22b0:: with SMTP id p16mr2161116qkh.187.1641764277172;
        Sun, 09 Jan 2022 13:37:57 -0800 (PST)
Received: from flurp.local (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id q10sm3411794qtw.88.2022.01.09.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:37:56 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Date:   Sun, 9 Jan 2022 16:37:49 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Pedro Martelletto <pedro@yubico.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] gpg-interface: trim CR from ssh-keygen
Message-ID: <YdtVrT4gBvnXfNr6@flurp.local>
References: <20220103095337.600536-1-fs@gigacodes.de>
 <20220107090735.580225-1-fs@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107090735.580225-1-fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 07, 2022 at 10:07:35AM +0100, Fabian Stelzer wrote:
> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
> this hypothesis. Signature verification passes with the fix.
>
> Helped-by: Pedro Martelletto <pedro@yubico.com>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>

Should this also have a "Helped-by: Junio" since this code was heavily
inspired by his suggestion[1]?

[1]: https://lore.kernel.org/git/xmqqo84rcn3j.fsf@gitster.g/

> ---
> diff --git a/gpg-interface.c b/gpg-interface.c
> @@ -502,15 +501,30 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
> +		const char *next;
> +		for (line = ssh_principals_out.buf;
> +		     *line;
> +		     line = next) {
> +			const char *end_of_text;
> +
> +			next = end_of_text = strchrnul(line, '\n');
> +
> +			 /* Did we find a LF, and did we have CR before it? */
> +			if (*end_of_text &&
> +			    line < end_of_text &&
> +			    end_of_text[-1] == '\r')
> +				end_of_text--;
> +
> +			/* Unless we hit NUL, skip over the LF we found */
> +			if (*next)
> +				next++;
> +
> +			/* Not all lines are data.  Skip empty ones */
> +			if (line == end_of_text)
> +				continue;
> +
> +			/* We now know we have an non-empty line. Process it */
> +			principal = xmemdupz(line, end_of_text - line);

Considering that this code makes a copy of the line _anyhow_ which it
assigns to `principal`, it still seems like it would be simpler and
far easier to understand at-a-glance to instead take advantage of one
of the existing string-splitting functions. For instance, something
like this:

    struct strbuf **line, **to_free;
    line = to_free = strbuf_split(&ssh_principals_out, '\n');
    for (; *line; line++) {
        strbuf_trim_trailing_newline(*line);
        if (!(*line)->len)
            continue;
        principal = (*line)->buf;

keeping in mind that strbuf_trim_trailing_newline() takes care of
CR/LF, and with appropriate cleanup at the end of the loop:

        strbuf_list_free(to_free);

(and removal of `FREE_AND_NULL(principal)` which is no longer needed).

Something similar can be done with string_list_split(), as well.
