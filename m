Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10089C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C372161158
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhDUIEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUIEi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 04:04:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D9C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:03:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so48244757edd.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Eh051tMwnf9O85Rtkdaf6kWB2v19Vy6AFBGlp1vrvHk=;
        b=lDEfKPPHoXUIWyxCFg/lTUoNceklis1O5EdSQvGCVPOx3z0EAFKJvWa+jAvydM4ubG
         Hp1atIK/1budRE/zRHuYiRGhyTUNcoI7MJNn5LFXRR7b4jLOMc6d+noTgxu0johIbmCe
         5Zf+RH9w6pRwuGZOku5qRtAxxO8K5CCqs4Gy+iUgh/8QNNsuJOKRXJ/qDQ09c7r9wqx6
         GdtyYiZOUZKh5kanPW+2YXW3cshh758YG6jCHp8fb4GMbVnRED4owgP54k+E4GZf9W+n
         BdREvlb2bjvizMpkpoKPwaVIt3jrZZxwpAGLcFx/NjbF9ThWRbff1N6igeSItjSOtIQ0
         ht6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Eh051tMwnf9O85Rtkdaf6kWB2v19Vy6AFBGlp1vrvHk=;
        b=boeudSxNqAvLLdW8hkC9OAyves55fQYQb3wChHMJWORuxwjK2gpMCynGJXr3F2PcDI
         3RvevvipQiQsGMS5G2eY+A90Xw87Fu+F/7beTcQHFJWa+d8js83rOeRuj9IiReaUtSkK
         KJL9fBQq4C9XsfNOhGwV0F5uH7aidss7rlK+mJKLEFHmm/iGbGDmrFpI792e38/NWM5g
         P28rkoELmYmFjC8H9J1wHU5dOWtyCwGnse6MietcgWjx8OUQPTxvjwN8QV3HMiUQ4i90
         AC9JSZ3DpbZjp9Zz51z0UwC1iXgOUTZZYUg8gaaSvKN9+pJxJoSzqFH0LZxFSbhi86bb
         ZXlw==
X-Gm-Message-State: AOAM533qY0fVP/lVTouGR2t0EThHBQB2sAhGy26Iofi0nFl/G8+j+/0C
        ZAxBheQLR+gFCxLgY9btwCM=
X-Google-Smtp-Source: ABdhPJwc40yuBBFojgclPhu4fApOs4qNFq3cva0OJujYmVaUXZNsxhJ4B43eCOQ9qwMJHP4VffUuKw==
X-Received: by 2002:a05:6402:31af:: with SMTP id dj15mr25327725edb.231.1618992238339;
        Wed, 21 Apr 2021 01:03:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lj21sm1510742ejb.74.2021.04.21.01.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:03:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
References: <20210420190552.822138-1-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210420190552.822138-1-lukeshu@lukeshu.com>
Date:   Wed, 21 Apr 2021 10:03:57 +0200
Message-ID: <8735vk3vyq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 20 2021, Luke Shumaker wrote:

> -static void handle_tag(const char *name, struct tag *tag)
> +static void handle_tag(const char *refname, struct tag *tag)
>  {
>  	unsigned long size;
>  	enum object_type type;
>  	char *buf;
> -	const char *tagger, *tagger_end, *message;
> +	const char *refbasename;
> +	const char *tagname, *tagname_end, *tagger, *tagger_end, *message;

Let's put the new "*tagname, *tagname_end" on its own line, the current
convention is to not conflate unrelated variable declarations on the
same line (as e.g. the existing "message" and "tagger" does.

>  	size_t message_size = 0;
>  	struct object *tagged;
>  	int tagged_mark;
> @@ -800,6 +801,11 @@ static void handle_tag(const char *name, struct tag *tag)
>  		message += 2;
>  		message_size = strlen(message);
>  	}
> +	tagname = memmem(buf, message ? message - buf : size, "\ntag ", 5);
> +	if (!tagname)
> +		die("malformed tag %s", oid_to_hex(&tag->object.oid));
> +	tagname += 5;
> +	tagname_end = strchrnul(tagname, '\n');

So it's no longer possible to export a reporitory with a missing "tag"
entry in a tag? Maybe OK, but we have an escape hatch for it with fsck,
we don't need one here?

In any case a test for it would be good to have.

> @@ -884,14 +890,19 @@ static void handle_tag(const char *name, struct tag *tag)
>  
>  	if (tagged->type == OBJ_TAG) {
>  		printf("reset %s\nfrom %s\n\n",
> -		       name, oid_to_hex(&null_oid));
> +		       refname, oid_to_hex(&null_oid));
>  	}
> -	skip_prefix(name, "refs/tags/", &name);
> -	printf("tag %s\n", name);
> +	refbasename = refname;
> +	skip_prefix(refbasename, "refs/tags/", &refbasename);
> +	printf("tag %s\n", refbasename);
>  	if (mark_tags) {
>  		mark_next_object(&tag->object);
>  		printf("mark :%"PRIu32"\n", last_idnum);
>  	}
> +	if ((size_t)(tagname_end - tagname) != strlen(refbasename) ||

Would be more readable IMO to have a temporary variable for that
"tagname_end - tagname", then just cast that and use it here.

> +	    strncmp(tagname, refbasename, (size_t)(tagname_end - tagname)))

and here.

> @@ -2803,6 +2803,13 @@ static void parse_new_tag(const char *arg)
>  	read_next_command();
>  	parse_mark();
>  
> +	/* name ... */
> +	if (skip_prefix(command_buf.buf, "name ", &v)) {
> +		name = strdupa(v);
> +		read_next_command();
> +	} else
> +		name = NULL;
> +

Skip this whole (stylistically incorrect, should have {}) and just
initialize it to NULL when you declare the variable?
