Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB2C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 14:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbiE0OkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiE0OkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 10:40:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EABF13C4CA
        for <git@vger.kernel.org>; Fri, 27 May 2022 07:40:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j28so5659290eda.13
        for <git@vger.kernel.org>; Fri, 27 May 2022 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RWxpJMO99fi9g3C3iKQjg6VUi0UpbwJfxYg1HeGv5Og=;
        b=cJSqvjzXbRanSTyHZ+NvlNk0P1W9/4dXmVcNddMs8F+2pWtorGP35XMWOCpE/NM3f5
         tu2DOLxG/QS4uMOazKZe9fDQVuM6hY5CB4UZ6bmuC8g+mvpzyHuYSZTmZbkHZhjKNq+p
         hK1jx5ki3OusCeF4C6q7GsH3D42xKLxGQ7kJnNI5SF7vyfhGsNAJQQFkYSgv/48yt/oI
         JqIlq+sQoMyD66AmXHr4e7BpsLzg5fGGHfuH5SrGu+cQnSXKeVy+Vzkuf2WmycnBScIq
         UfiQKyWPTm6k1MLReLkWCT8rKkj0/MYdjb3tidROGcpDvh5ReI78x+iU005qi1gEchgl
         lpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RWxpJMO99fi9g3C3iKQjg6VUi0UpbwJfxYg1HeGv5Og=;
        b=HVcLwVPsYp+8+9UIDmoOdY3alCG4eqtldUHsmThJwbNSRK28scBKr2jVQc1K3roP/F
         eUaiUCIxkKU5DUHQt3vySPQZ/xVFNuGdMSO90kIQkhg4opUBeayiivO2o+kJUWWAnkJ7
         UHCx8LOXNHHsmLqGtcKfm4D0084BT5lafyDEB/6484y0xUMTQUjyXefVDSzXwo3qGouR
         bEm4yeTwgE+2WNmIWNGVI4+O8VE9YHyzBWDs6AOLlJgCfrwqFbNakAnmlnOpG7igCMDw
         /qtbZgBx13OurzstQ+z8NrNkw9x3cfwiD750caSfjiLTwmO0zgG57+q04lylIu3dLL+P
         PHAA==
X-Gm-Message-State: AOAM5306U08shfFc21vUL7WFhxFERMWEACNSi+wrDPGxsq0UWX02fNU5
        VW3FZzNTurzCJo0k213CDherjby8f+tjrw==
X-Google-Smtp-Source: ABdhPJz1LOLr5z2xq4C4f6KE0C0gDrtpYvPTE44HBB0ajOmYS43+xnmYwLIcdUpvb+cWCH1HAQ3wow==
X-Received: by 2002:a05:6402:354c:b0:42b:4e22:203b with SMTP id f12-20020a056402354c00b0042b4e22203bmr31028086edd.308.1653662413693;
        Fri, 27 May 2022 07:40:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090633ce00b006fec63e564bsm1508344eja.30.2022.05.27.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 07:40:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nub8N-000WQa-Vc;
        Fri, 27 May 2022 16:40:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] urlmatch: create fetch.credentialsInUrl config
Date:   Fri, 27 May 2022 16:22:41 +0200
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
 <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
Message-ID: <220527.86fskv2g50.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 27 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>

Just real quick, I hadn't taken notice of this before (the rest looks
good at a glance):

> +	/*
> +	 * Let's do some defensive programming to ensure the given
> +	 * URL is of the proper format.
> +	 */
> +	if (!colon_ptr)
> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
> +		    url, (uintmax_t) scheme_len);
> +	if (colon_ptr > at_ptr)
> +		BUG("input url '%s' does not include credentials",
> +		    url);

So the function is renamed to detected_credentials_in_url(), so as a nit
I'd expect some verb like "strip", "redact" or whatever inthe name or
whatever, to make it clear what we're doing.

But since the only caller here below...

> +
> +	/* Include the colon when creating the redacted URL. */
> +	colon_ptr++;
> +	strbuf_addstr(&redacted, url);
> +	strbuf_splice(&redacted, colon_ptr - url, at_ptr - colon_ptr,
> +		      "<redacted>", 10);
> +
> +	if (!strcmp("warn", value))
> +		warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
> +	if (!strcmp("die", value))
> +		die(_("URL '%s' uses plaintext credentials"), redacted.buf);
> +
> +	strbuf_release(&redacted);
> +}
> +
>  static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
>  {
>  	/*
> @@ -144,6 +198,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
>  	 */
>  
>  	size_t url_len = strlen(url);
> +	const char *orig_url = url;
>  	struct strbuf norm;
>  	size_t spanned;
>  	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
> @@ -191,6 +246,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
>  			}
>  			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
>  			if (colon_ptr) {
> +				detected_credentials_in_url(orig_url, scheme_len);

Has already done the work of finding the colon_ptr (and at_ptr) why
re-do that paranoia since we have a static function, we could just pass
the two pointers we found already to strbuf_splice().

This also seems really close to something we could just add to strbuf.c
as e.g a strbuf_splice_to(). I.e. just:
	
	int strbuf_splice_to(const struct strbuf *in, struct strbuf *sb,
			     size_t pos, size_t len,
			     const void *data, size_t data_len);
	
Which would be used as:
	
	struct strbuf sb = STRBUF_INIT;
	if (!strbuf_splice_to(url, &redacted, /* same as strbuf_splice(...) */))
		warn("oh noes a password in %s", sb.buf);
	else
		warn("have no password in %s, no replacement done", url->buf);

Which re earlier talk of sharing an implementation with the other
<redacted> code looks like it could be dropped into the relevant part of
pkt-line.c.

But maybe that's all going overboard :)
