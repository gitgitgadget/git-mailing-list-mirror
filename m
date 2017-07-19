Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E80E20288
	for <e@80x24.org>; Wed, 19 Jul 2017 18:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbdGSSXq (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 14:23:46 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34193 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753959AbdGSSXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 14:23:45 -0400
Received: by mail-pg0-f41.google.com with SMTP id 123so3661453pgj.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vjZZW8UPLtWX/uFUVLHB0AyBb8LM2lFzYwNpDnAv/xU=;
        b=VeEPk7/9eonMEgqmihF2MgYd2wfx7YWT6XBf+PZNC7SnpAwqjvZwozhFcNZhx5Vh5y
         bVVpY23y6k3OsHZVndcegYXMysQZb0HuiRA0DliSiRaTjovQcHqQN6b5+dgg2CXWqBFT
         /qLOSLKfSdPx0+Ta9USw3m/hQoG/KLWeGRYgTla6O/I6X+Ix6zsjoZTyXjViE2qG4s8/
         F4kIk7r2kIvzH+EUFH+P2rO/7rkfV7lwmrg3bK2ZOeoxz+nfUjke+8vrjzJfP4O5Us2G
         hbbWzEc4Bl3AZfr0MJs/tjF+pt9xuoHsIuvNZV3YgD7AaXrc0rTwlRJm+anajd2U5DZ4
         UvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vjZZW8UPLtWX/uFUVLHB0AyBb8LM2lFzYwNpDnAv/xU=;
        b=g86FPdeHYy8ZRgb8uxJyDGzBo6DG0E9ihdEyfpdDrsbouqYkP86ZRWhUJoQgpnsKfj
         mO1S3LAvpjvxiq+thXHitLeM0HNNYjokarmI+1MVVkSWauyFqogNS226Nz2frhkXlf1/
         K72oySbfLgfbgPBArwXr/DBK02SQgNOloika56p3XSmJRfd+49d3Zpzw6KtDAC1h1K5t
         VvFPRvkmuauj7FQCwDrnr5gv9o8XkyKwWPuwQlCT2Qr1KrkEyb6p8W8nCyMX3Po/Bnsh
         TVSsutZPJnmBCGvg5tk7aLnjEigcBfstEibR7vpkf8mxjoXKedLFkPh/hykFJ39OrgqX
         JtKg==
X-Gm-Message-State: AIVw113QGQ6vPegLeFfpUjX6CfkTSwbhD6v5dW1agqCzQJz6lk8wBISU
        W9aUlvl2YB1AtReN
X-Received: by 10.84.133.226 with SMTP id f89mr1108373plf.11.1500488624736;
        Wed, 19 Jul 2017 11:23:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:45af:5bd:4181:d396])
        by smtp.gmail.com with ESMTPSA id z86sm1031072pfl.40.2017.07.19.11.23.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 11:23:43 -0700 (PDT)
Date:   Wed, 19 Jul 2017 11:23:42 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, j6t@kdbg.org, l.s.r@web.de,
        peff@peff.net, schwab@linux-m68k.org
Subject: Re: [PATCH] objects: scope count variable to loop
Message-ID: <20170719182342.GA158344@google.com>
References: <xmqq8tjqrfq4.fsf@gitster.mtv.corp.google.com>
 <20170719181956.15845-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170719181956.15845-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/19, Stefan Beller wrote:
> This is another test balloon to see if we get complaints from people
> whose compilers do not support variables scoped to for loops.
> 
> This part of the code base was chosen as it is very old code that does
> not change often, such that a potential revert is easy.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> This is a rather aggressive test ballon, my compiler needed some
> good arguments to accept the new world order:
> 
> object.c: In function ‘object_array_remove_duplicates’:
> object.c:404:2: error: ‘for’ loop initial declarations are only allowed in C99 mode
>   for (unsigned src = 0; src < nr; src++) {
>   ^
> object.c:404:2: note: use option -std=c99 or -std=gnu99 to compile your code
> 
> Using -std=c99 works for me.

This would need a change to the makefile then wouldn't it?

> 
> Thanks,
> Stefan
> 
>  object.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/object.c b/object.c
> index f818777412..af26ee2fbc 100644
> --- a/object.c
> +++ b/object.c
> @@ -397,11 +397,11 @@ static int contains_name(struct object_array *array, const char *name)
>  
>  void object_array_remove_duplicates(struct object_array *array)
>  {
> -	unsigned nr = array->nr, src;
> +	unsigned nr = array->nr;
>  	struct object_array_entry *objects = array->objects;
>  
>  	array->nr = 0;
> -	for (src = 0; src < nr; src++) {
> +	for (unsigned src = 0; src < nr; src++) {
>  		if (!contains_name(array, objects[src].name)) {
>  			if (src != array->nr)
>  				objects[array->nr] = objects[src];
> -- 
> 2.14.0.rc0.3.g6c2e499285
> 

-- 
Brandon Williams
