Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9F81F404
	for <e@80x24.org>; Fri,  2 Mar 2018 22:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeCBWN7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 17:13:59 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41332 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeCBWN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 17:13:58 -0500
Received: by mail-wr0-f196.google.com with SMTP id f14so11522681wre.8
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SvFTf1KonBVKqxMhlcEDyS7vXJcZv2NU5X3lpLWnW4o=;
        b=ezFq3vvccu8gYzJ3d7Z+rIH0QFrX7bDQlEVCLzAPV/z7AGoogD7xwVepH2dufh9Mzd
         rjEolL+J8dxKFgDotmJWe2gkN4Uhgi1Vlgjr5H5du2rEXvMhQXMYZRydlpZtXg+CO7oS
         jWOE6kjLyQ0hCmjZeSMB2pZ3iawoJuXlU7jY3p14gzwy3eD9coAu8EMW2ZZ/xj4riEGz
         zfZuBF2gkpzoT3Tj2nUSc3ziwslkJib5INETiM9X7b/36OmzjD2TBopmQmY+10A03fq0
         GhEeKl54qqX7MAGgupHwOoYgGdp7MledXX90wXKfwtmwwjMD7KROm+USMwQk0UlYWQmu
         FwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SvFTf1KonBVKqxMhlcEDyS7vXJcZv2NU5X3lpLWnW4o=;
        b=IqO6vHc5AAArRu1azFAVZmSSqdHxZ84SAlPCygCcYB9rhJLA7vgfgoj1WtS450PGuy
         t0TxSwqgZTpJJhr7REZjhlMah8vnI7oynT/2amfvuK27MGuW5VYAYkGJOYza5x5X3B80
         svL+3cCSF8KFt8HToINe0r8rAA1k31XOMj6emNAg4dVvYd15K5pbj5PM9pqkN5MhFpZd
         RPtPKWBzi6ThIJH74ONQ+ENRzgg6Fmf7y3Yinxu6D0MccjLSMyAe9jThj1V4NauOPI+A
         hene8ZGhvSoRTdi5DJtbEgIT5sKW+B/srrjzrEz8khn3Dn5CkaW4fVRPVdQE89Bl8CBV
         EtJw==
X-Gm-Message-State: APf1xPDn6tVONFgE5BzJVlk6ZlIt7y395HYKxE7bOClmyx5yPOwzaQ9m
        e42oeA2NDGyPcT/vKCAe6f0=
X-Google-Smtp-Source: AG47ELubwx3yTRqnuiYmQ7zfVe4kmdRQz9eT0yWwETbLV7IuJUc4hcaUb5sIWJQl1OX1BfhO7uMJ8A==
X-Received: by 10.223.177.138 with SMTP id q10mr5753472wra.132.1520028837194;
        Fri, 02 Mar 2018 14:13:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r71sm2933880wmd.48.2018.03.02.14.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 14:13:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 17/35] ls-remote: pass ref patterns when requesting a remote's refs
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-18-bmwill@google.com>
Date:   Fri, 02 Mar 2018 14:13:54 -0800
In-Reply-To: <20180228232252.102167-18-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:34 -0800")
Message-ID: <xmqq8tbaazx9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Construct an argv_array of the ref patterns supplied via the command
> line and pass them to 'transport_get_remote_refs()' to be used when
> communicating protocol v2 so that the server can limit the ref
> advertisement based on the supplied patterns.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/ls-remote.c    | 12 ++++++++++--
>  refs.c                 | 14 ++++++++++++++
>  refs.h                 |  7 +++++++
>  t/t5702-protocol-v2.sh | 26 ++++++++++++++++++++++++++
>  4 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index c6e9847c5..083ba8b29 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -2,6 +2,7 @@
>  #include "cache.h"
>  #include "transport.h"
>  #include "remote.h"
> +#include "refs.h"
>  
>  static const char * const ls_remote_usage[] = {
>  	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
> @@ -43,6 +44,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	int show_symref_target = 0;
>  	const char *uploadpack = NULL;
>  	const char **pattern = NULL;
> +	struct argv_array ref_patterns = ARGV_ARRAY_INIT;
>  
>  	struct remote *remote;
>  	struct transport *transport;
> @@ -74,8 +76,14 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	if (argc > 1) {
>  		int i;
>  		pattern = xcalloc(argc, sizeof(const char *));
> -		for (i = 1; i < argc; i++)
> +		for (i = 1; i < argc; i++) {
>  			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
> +
> +			if (strchr(argv[i], '*'))
> +				argv_array_push(&ref_patterns, argv[i]);
> +			else
> +				expand_ref_pattern(&ref_patterns, argv[i]);
> +		}
>  	}
>  
>  	remote = remote_get(dest);
> @@ -96,7 +104,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	if (uploadpack != NULL)
>  		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
>  
> -	ref = transport_get_remote_refs(transport, NULL);
> +	ref = transport_get_remote_refs(transport, &ref_patterns);

Yup, this is a logical and an obvious conclusion of the past handful
of steps ;-) I actually was wondering why the previous step didn't
do this already, but the resulting series is easier to understand if
this is kept as a separate step.

However, this also means that traditional pattern language ls-remote
used to support dictates what ls-refs command over the wire can
take, which may not be optimal.
