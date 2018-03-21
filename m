Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E251F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeCUVZI (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:25:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45977 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeCUVZH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:25:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id h2so6643012wre.12
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lC+rRVK5R2ISabIEoVuOHTE2OWqVGr3+71Rfd+1BFPc=;
        b=OOFKbGxDhxRtK92JtHi6fB3rwyItPeQjijWWESkMRh3VYu9S5b1MhUqTdBYwJhl0Nv
         DPs3ivHQuiNfYD/723wYmJJtlh+92dZHvqYfoIEkfj9CLxNyN74Eo3EJnEy83Akt3+ka
         9qgWejitV9eIFt4atteW7kJSs9e4P44Bj6Eq5eBXM6TCaSUJMesAApSQw/MTfvQMGQ26
         fjxI+95HExYwniPYWT+Zd8L+G6NKMF6tjemXLKIe93P5eU64+gP4zINdJcM4YfAAVv3z
         uJKS6q4Gp0M6bj15MclKebj6BTpWp+XR7M3LASOMppuqOAxsEsZdTJkQyW/soRmiwQ4i
         mdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lC+rRVK5R2ISabIEoVuOHTE2OWqVGr3+71Rfd+1BFPc=;
        b=Q7G6m1bPg/5WuwYdFTbNSo+oxl0WGNvrsMWizzYED1cTTqIvE/E1NSoKvaqIm+UC0c
         8eiMgzMkPcB9exSoNpSqHkTB8WlsTtAxp7AQie+AOHOEWYr9yGJkuSHfUdUmUyZtCqiD
         jIdt9hgtomv7Bbmcz5Hy3MuN/AqGFAPuyb7CcOoNuwasgLgNZhh+beiT2PDxfQ1HLMOZ
         VqYuWnHEhYi1mH6dyNTrF64A/J7qU96dmUp0UiNiRdSGam8oBAxpDfYxM+LvGH+cNVVk
         IX9+zfJwSUeU0VVq8r0GmBjZWgryps30FNdPZ8Io6TNO5Ai3CKsM/J4NEg18apy4zUXS
         575g==
X-Gm-Message-State: AElRT7HmBHRRnP5mLuIGRwaJMKVnGuBzERLLi1+Npj3GpgR7GNl8mcGP
        R2J0q2DbUdrvpOw9wyw+lzI=
X-Google-Smtp-Source: AG47ELsvnJRKMT/C1Sj1HQP19IzgnivlG/1jLT8f8kSpfV4CL4AptyrT2XeN7D7pUCdK9oL3MsTVWA==
X-Received: by 10.223.150.175 with SMTP id u44mr17049225wrb.104.1521667505782;
        Wed, 21 Mar 2018 14:25:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g38sm8186192wra.77.2018.03.21.14.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:25:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] json_writer: new routines to create data in JSON format
References: <20180321192827.44330-1-git@jeffhostetler.com>
        <20180321192827.44330-2-git@jeffhostetler.com>
Date:   Wed, 21 Mar 2018 14:25:03 -0700
In-Reply-To: <20180321192827.44330-2-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Wed, 21 Mar 2018 19:28:27 +0000")
Message-ID: <xmqq8talnmts.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Add basic routines to generate data in JSON format.

And the point of having capability to write JSON data in our
codebase is...?

> diff --git a/json-writer.c b/json-writer.c
> new file mode 100644
> index 0000000..89a6abb
> --- /dev/null
> +++ b/json-writer.c
> @@ -0,0 +1,321 @@
> +#include "cache.h"
> +#include "json-writer.h"
> +
> +static char g_ch_open[2]  = { '{', '[' };
> +static char g_ch_close[2] = { '}', ']' };

What's "g_" prefix?

> +
> +/*
> + * Append JSON-quoted version of the given string to 'out'.
> + */
> +static void append_quoted_string(struct strbuf *out, const char *in)
> +{
> +	strbuf_addch(out, '"');
> +	for (/**/; *in; in++) {
> +		unsigned char c = (unsigned char)*in;

It is clear enough to lose /**/, i.e.

	for (; *in; in++) {

but for this one. I wonder if

	unsigned char c;
	strbuf_addch(out, '"');
	while ((c = *in++) != '\0') {
 		...

is easier to follow, though.

> +static inline void begin(struct json_writer *jw, int is_array)
> +{
> +	ALLOC_GROW(jw->levels, jw->nr + 1, jw->alloc);
> +
> +	jw->levels[jw->nr].level_is_array = !!is_array;
> +	jw->levels[jw->nr].level_is_empty = 1;

An element of this array is a struct that represents a level, and
everybody who accesses an element of that type knows it is talking
about a level by the field that has the array being named as
.levels[] (also [*1*]).  In such a context, it is a bit too loud to
name the fields with level_$blah.  IOW,

	struct json_writer_level
	{
		unsigned is_array : 1;
		unsigned is_empty : 1;
	};

> +struct json_writer_level
> +{
> +	unsigned level_is_array : 1;
> +	unsigned level_is_empty : 1;
> +};
> +
> +struct json_writer
> +{
> +	struct json_writer_level *levels;
> +	int nr, alloc;
> +	struct strbuf json;
> +};

[Footnote]

*1* I personally prefer to call an array of things "thing[]", not
    "things[]", because then you can refer to an individual element
    e.g. "thing[4]" and read it as "the fourth thing".

    Unless the code often treats an array as a whole, that is, in
    which case, things[] is OK as you'll be calling the whole thing
    with the plural name (e.g. call that function and give all the
    things by passing things[]).

    In this case, one level instance is an element of a stack, and
    the code would be accessing one level at a time most of the
    time, so "writer.level[4].is_empty" would read more naturally
    than "writer.levels[4].level_is_empty".


