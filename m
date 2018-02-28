Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1511F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934548AbeB1RzJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:55:09 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35884 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933542AbeB1RzG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:55:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id 188so6699871wme.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g7TBrjkZUT0NlCEB45Ey3XNWHIe262bf60DpQQznM5o=;
        b=TDsRoYZRLct77kuk12gVe4xYaGfAy39VbdXjdYJvw2u9oGmTxttmZl1ZkOSCpaGcoI
         X17qNkGz0HHX1zSotJOq3mend1u7fMp6N7HwsVBHdl+JUAWxYzAzvg+xddW5nEjy/MeH
         zx3NbtlqTbu7AEXWzL45H3cUd4Xv92NeTSFQBOlXOOa0y1Vr+mQMeHQ1+b2qkGte53Ih
         LUIRhU/+xoSIhHe0Mmr/kC9oscK3dIWEgaAgv8jVSlZ0KDO0AOROjVoWSdIPqD1DJX+T
         7UvPzaX54HbxE5csJX3lNl4zS8qe+KVIY8YZm+LCDEW2Lvw9s9tWv3JyoGoo6zGfMwlT
         /eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g7TBrjkZUT0NlCEB45Ey3XNWHIe262bf60DpQQznM5o=;
        b=uglMdZerqGaLWdPvaWQ3z/IghER87hSZlgkgB94oaPC/snyuFkJ4kULgEBVHcuyqdM
         ZjqNn5rt7g9R3J3k+5gxsljxgy9/6q8TmIwEjVuibTF0qhhDMup7sFv3P89U1D4b2nMs
         IA2oxdP1MXntT+80jl75lNSB1QZfdg8bX+IeT4pd0ooLh6Y2osFKTpU8TqMAwe+SwXnt
         CXtO8yfPaDA57iUvogewtJuLlteZVpxD7s6VOyA8+IHW0Ias8xAp6UygswkXirnq12UV
         A3kZtqk4GRXAqB1GGVzBULQXR5SpMRavAKKTPzlYNjEg2kCoMUjV+z1OvrW24vBJzFuC
         DHKw==
X-Gm-Message-State: APf1xPA3U3+KWkLr+eGC74sMp+EHc+4Yc2xXJ2pcfpxqqo3fAAV7W6Bo
        Q40d3I0L6uLXFDQGZ8T8/co=
X-Google-Smtp-Source: AG47ELsMVc9Hqkg2LchDBLJHcU8KGYp9/BnmgKuo8VlGhmlMstnwmTbURcr74z6GdfCOKlOpeXgaRw==
X-Received: by 10.28.126.198 with SMTP id z189mr13693538wmc.135.1519840504979;
        Wed, 28 Feb 2018 09:55:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g84sm4002342wmf.38.2018.02.28.09.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 09:55:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] protocol: treat unrecognized protocol.version setting as 0
References: <20180228005059.GA251290@aiede.svl.corp.google.com>
        <20180228010233.GA45342@google.com>
        <CACsJy8Cn2hcodoR8ksRBY9qf7MmJaP+KAzYqv6seeR9s-Be8Hw@mail.gmail.com>
        <20180228012207.GB251290@aiede.svl.corp.google.com>
Date:   Wed, 28 Feb 2018 09:55:03 -0800
In-Reply-To: <20180228012207.GB251290@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 27 Feb 2018 17:22:07 -0800")
Message-ID: <xmqq7eqxm22w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I wonder if it's better to specify multiple versions. If v2 is not
>> recognized by this git but v0 is, then it can pick that up. But if you
>> explicitly tell it to choose between v2 and v3 only and it does not
>> understand either, then it dies. Not sure if this is a good idea
>> though.
>
> Interesting thought.  Something roughly like this (on top of the patch
> this is a reply to)?

I am OK with that, i.e. allow the user to tell us what is acceptable
and pick from them, as long as the blind "we do not know so let's
fall back to v0" is removed.



>
> diff --git i/protocol.c w/protocol.c
> index ce9c634a3a..6aa8857a11 100644
> --- i/protocol.c
> +++ w/protocol.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "string-list.h"
>  #include "config.h"
>  #include "protocol.h"
>  
> @@ -14,14 +15,18 @@ static enum protocol_version parse_protocol_version(const char *value)
>  
>  enum protocol_version get_protocol_version_config(void)
>  {
> -	const char *value;
> -	if (!git_config_get_string_const("protocol.version", &value)) {
> -		enum protocol_version version = parse_protocol_version(value);
> -		if (version != protocol_unknown_version)
> -			return version;
> +	const struct string_list *values;
> +	const struct string_list_item *value;
> +	enum protocol_version result = protocol_v0;
> +
> +	values = git_config_get_value_multi("protocol.version");
> +	for_each_string_list_item(value, values) {
> +		enum protocol_version v = parse_protocol_version(value->string);
> +		if (v != protocol_unknown_version)
> +			result = v;
>  	}
>  
> -	return protocol_v0;
> +	return result;
>  }
>  
>  enum protocol_version determine_protocol_version_server(void)
