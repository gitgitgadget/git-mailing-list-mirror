Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E9E1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 22:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932329AbeCBWUd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 17:20:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55148 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932250AbeCBWUc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 17:20:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id z81so5767991wmb.4
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 14:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hPDmA2rgVZwhABQmnhwvfSrEcbg7dTEOw1HoNtnkoDw=;
        b=WyCzKkcX8lEdFE1QzKIgHQh7P4n8Au+D5FbpXWLjIKQATN2NPxCAu/L7CzrYlHRZz0
         kUOE0Ks4/gduElFBOgGq5nfgbyvYmzUUFF8qFuvrU5qhejOdCEZl3ZlG5ujFsmMZdDeD
         04Clc3sRCdPUf2Zm65RrAtHvfk8mNH/R+kAtOP0kwrofj7Es+OIBsbmTbCZJq/gAtdqX
         Ii5ms8V2SwhnnBLvDtHKsDAncxSGXbeITD3mrr+Gh7AxJSQbcHFo+WeD8OcCKJgAHBit
         Suh8RXVCl1xmPxyAbpJuLQRoUsCe2qBSzs6ppJSUvNxlAZT7qbfZg6oHUDoYCWfkQnZh
         3a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hPDmA2rgVZwhABQmnhwvfSrEcbg7dTEOw1HoNtnkoDw=;
        b=AoA0BApwBtLA8bbF8Rv2P4vRF3MBEXjbZUJVWdCOa81LP+C9hhpHg71Xuevt0UDTjZ
         R9eH0jGFqh4zX4Idb5d0WPtJUx4WrB0imbX5mAt5RO2/I/EttjfIhGyLWxl8ZvYCAf6s
         OWj64CsWD+2GAJLt77ecsCR/u+UeRlwJHG7P/CDs2q2miExoOK/dCaLxEJOghXBhrFMk
         2eK2mrFrKibfzQPwGEK0H+PfLku1zRAxmf9MooROYMC1QELEIcbdvgWYlp42obOx11Np
         8VL+CwIq17WE7tfGzzo02DdN++siwV1aMuJOivuKpafB7/BfRc9TyAGDc9e/QciHbi2+
         fXUA==
X-Gm-Message-State: AElRT7GjI4pGoV4QgLGPaJke0UpmnJ2vdB+VbSevLnPydyWjYkUMzqmI
        hxJ/QVB7ALoeAMwDFOPNbIU=
X-Google-Smtp-Source: AG47ELutyIySs+UUbfEjmSB0/P+QxLyQRBtsgMVQucQPPELO8Fuf7mNzUA+7HxoGEeTNYpaJ+TkTGQ==
X-Received: by 10.28.174.80 with SMTP id x77mr2725698wme.130.1520029230835;
        Fri, 02 Mar 2018 14:20:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o2sm9770875wro.31.2018.03.02.14.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 14:20:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 18/35] fetch: pass ref patterns when fetching
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-19-bmwill@google.com>
Date:   Fri, 02 Mar 2018 14:20:29 -0800
In-Reply-To: <20180228232252.102167-19-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:35 -0800")
Message-ID: <xmqq4llyazma.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 850382f55..695fafe06 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -332,11 +332,25 @@ static struct ref *get_ref_map(struct transport *transport,
>  	struct ref *rm;
>  	struct ref *ref_map = NULL;
>  	struct ref **tail = &ref_map;
> +	struct argv_array ref_patterns = ARGV_ARRAY_INIT;
>  
>  	/* opportunistically-updated references: */
>  	struct ref *orefs = NULL, **oref_tail = &orefs;
>  
> -	const struct ref *remote_refs = transport_get_remote_refs(transport, NULL);
> +	const struct ref *remote_refs;
> +
> +	for (i = 0; i < refspec_count; i++) {
> +		if (!refspecs[i].exact_sha1) {
> +			if (refspecs[i].pattern)
> +				argv_array_push(&ref_patterns, refspecs[i].src);
> +			else
> +				expand_ref_pattern(&ref_patterns, refspecs[i].src);
> +		}
> +	}
> +
> +	remote_refs = transport_get_remote_refs(transport, &ref_patterns);
> +
> +	argv_array_clear(&ref_patterns);

Is the idea here, which is shared with 17/35 about ls-remote, that
we used to grab literally everything they have in remote_refs, but
we have code in place to filter that set using refspecs given in the
remote.*.fetch configuration, so it is OK as long as we grab everything
that would match the remote.*.fetch pattern?  That is, grabbing too
much is acceptable, but if we populated ref_patterns[] with too few
patterns and fail to ask refs that would match our refspec it would
be a bug?

The reason behind this question is that I am wondering if/how we can
take advantage of this remote-side pre-filtering while doing "fetch
--prune".

Thanks.

>  
>  	if (refspec_count) {
>  		struct refspec *fetch_refspec;
