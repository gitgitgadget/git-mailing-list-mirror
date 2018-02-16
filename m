Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B5A1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 20:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbeBPU1c (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 15:27:32 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52443 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeBPU1b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 15:27:31 -0500
Received: by mail-wm0-f66.google.com with SMTP id t3so5244088wmc.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jlLa15fsf1LgLuxHQnbqoyjP5a0YaWbN8kK/aAXsR4Y=;
        b=prEJ58ozGNIPLX6p3aHNtWTLvG7Gwvn/Oj3hhxPlOO0AGAM3g7YpKNryfotYcCkDE/
         x4OicrE5+LQkWquiiRU7fjzi8ouEr95a0LSlR+qHHduuUiEY8o5Jo5/Atf06jwQ2Xmcn
         Q/1Q61EqebRr9r8rMa5bFW2lGY+BRpKqp96NLc48E9h7haW89QQfEsUOkK3K/UCv2j/I
         vF+4JkXZzG6r9E9XqszKjrg0etgHptaZ9pKU9ZuTBRu6eLE137Xvl8/jJVPBah7ukvWj
         CzfDCamU1iS/YDq5ydn3CfPWSjB3LGAw+duzYqzvlgIAaH43vRD/M3e6qIFJ85dhfbXc
         DTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jlLa15fsf1LgLuxHQnbqoyjP5a0YaWbN8kK/aAXsR4Y=;
        b=pJ0OdhTyUL9pr1zFIITUnZQ0Fp9EDr5X9v1a6iXWGvIz5LvCx8zhAFk1XqywUF4Xhf
         2ST8L8o0VdPgZBM4HiJIzqof2ha54u7G5YCZgIRuWt9gUoms8zw+zNn+CQ/dPxV7uTdu
         tzYM3VWOe+2aKpzrYa8U4lQZv2o29bpUtEU/VPV24AmDXrcb1W/H4fVdxfigAEFibXKp
         ZbiCd6qnd3n/d4f5n+XlBvmx1N7NXNUt5L7CqV4Dg0iX7vrzVPs3Kvo7/pE5iqxjgk9c
         jFRsl76ySEKCaCbYT0nvpe69WfpI16F0ZVRW8S2rQIGrGuZJfqNheZxbKOKQNvuQ3aHV
         uN2A==
X-Gm-Message-State: APf1xPCi4jdg+lTQndl20StThSxx+ASN4zTcBaGZjF+Sxv21vvb8suOZ
        KGCl7lrs8WZ31ZL3S0Js5rI=
X-Google-Smtp-Source: AH8x226GBI3pCAmDHkLPDX2Dedq+1Ef0xSCNhPkkUGlLze6Mf01mjm0ygXwl3KVE61L25BA0aczs5w==
X-Received: by 10.28.13.18 with SMTP id 18mr6380163wmn.112.1518812850175;
        Fri, 16 Feb 2018 12:27:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b72sm16868242wmf.2.2018.02.16.12.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 12:27:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/16] object-store: move packed_git and packed_git_mru to object store
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
        <20180216174626.24677-1-sbeller@google.com>
        <20180216174626.24677-5-sbeller@google.com>
Date:   Fri, 16 Feb 2018 12:27:27 -0800
In-Reply-To: <20180216174626.24677-5-sbeller@google.com> (Stefan Beller's
        message of "Fri, 16 Feb 2018 09:46:14 -0800")
Message-ID: <xmqqfu6065ow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>   @@ @@
>   - packed_git_mru
>   + the_repository->objects.packed_git_mru

Regarding this...

> diff --git a/object-store.h b/object-store.h
> index a3f0d6ac15..024ccc91e9 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -2,6 +2,7 @@
>  #define OBJECT_STORE_H
>  
>  #include "cache.h"
> +#include "list.h"
>  
>  struct raw_object_store {
> ... 
> +	struct packed_git *packed_git;
> +	/*
> +	 * A most-recently-used ordered version of the packed_git list, which can
> +	 * be iterated instead of packed_git (and marked via mru_mark).
> +	 */
> +	struct list_head packed_git_mru;
> +
>  	struct alternate_object_database *alt_odb_list;
>  	struct alternate_object_database **alt_odb_tail;
>  
>  	unsigned ignore_env : 1;
>  };
> -#define RAW_OBJECT_STORE_INIT { NULL, NULL, NULL, 0 }
> +
> +#define MRU_LIST_INIT {NULL, NULL}
> +#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_LIST_INIT, NULL, NULL, 0 }
> ...
> diff --git a/packfile.c b/packfile.c
> index 216ea836ee..d41e4c83d0 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -7,6 +7,7 @@
> -...
> -LIST_HEAD(packed_git_mru);

Given that the definition of LIST_HEAD() is

    /* Define a variable with the head and tail of the list. */
    #define LIST_HEAD(name) \
            struct list_head name = { &(name), &(name) }

doesn't the updated definition of RAW_OBJECT_STORE_INIT look fishy?

