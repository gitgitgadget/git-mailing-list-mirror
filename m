Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDD2211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 03:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfALDHS (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 22:07:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38279 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfALDHS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 22:07:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so17173588wrw.5
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 19:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pFigP3n47y4LSbFiZ058uNKSpuZMuN/xyki7WC4W36s=;
        b=Ok5rY4eGzhRFB6eqQORAHQMMo38eYGE42s1jPNr4HWu690uXjyLssCakKYlaGWYwaq
         u8XCYQHiF4pmpd3w0k5VC3WFWQm2YYhHO6rHTEKr8cXOi/ux5/ESqJbDSnMwRI1jj4mn
         /iZWlhj+7ctSknXTlbZE6iSu9qovLzmFPwd99TGOYzgkoBDincJsqZcvEBYd6RWp5W3F
         lUgQfZQOjLTOCVp0hnUs2TCp/lzAUsXbLBiYCLGtAmoIwdX87truBwj/2cICiwT55O23
         BsMYPKxIc3xvUmeqLJd3gL1bD3W0wBL8XBELFsdlp1QDa8CwqbNVbAw8lDo+nG3phIva
         82YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pFigP3n47y4LSbFiZ058uNKSpuZMuN/xyki7WC4W36s=;
        b=pP3RNbTXd5AVSmBATW9hhyON9h0vu2iLAxIT3SEqN1wU0wn3qhOFa7hSi58PODw5QY
         RewN9uM+CxO+KEVI5UtJsDE/xijpyOXhC20zuuKJ7snwNfI7lJGr/8FwiFBLnqlbpNZF
         ofM5QuVcMqn6dH6RnD9QtwUKn6hsKRAEU4XnoYxlYKcTEo+IZxr8zCORuhuGf9yS6txb
         W5ixqqPTXpT3jHaQ/wBPmhoOjTLVf6hB0alX3CdCJsMo04SLr/pT5pdnklXYTbkcgOXZ
         8G3UvO1t6Ca0rbzKJ4IjLfylz7rh9Bpy3+13IzeUduOpcNNH81Qs0rAaqY+TtlNYLJ/7
         Kcwg==
X-Gm-Message-State: AJcUukeUIBbJ2XLQK3iUY4ksb/04gySH+tEDWcUAeK9kPQlGxnwYN8bQ
        kZPFT/hw6Hvt3RyY79++StM=
X-Google-Smtp-Source: ALg8bN4Hp/iKjdIl1GXQB96OQ7mwIBQ2+mG4Zh8vTiCOa3O2ghOQOaW5dskwk0vZ3r3OBfqyehSZ3g==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr14879131wre.94.1547262436458;
        Fri, 11 Jan 2019 19:07:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 198sm27485891wmt.36.2019.01.11.19.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 19:07:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] commit: copy saved getenv() result
References: <20190111221414.GA31335@sigill.intra.peff.net>
        <20190111221539.GB10188@sigill.intra.peff.net>
Date:   Fri, 11 Jan 2019 19:07:15 -0800
In-Reply-To: <20190111221539.GB10188@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 Jan 2019 17:15:40 -0500")
Message-ID: <xmqqsgxywp3w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We save the result of $GIT_INDEX_FILE so that we can restore it after
> setting it to a new value and running add--interactive. However, the
> pointer returned by getenv() is not guaranteed to be valid after calling
> setenv(). This _usually_ works fine, but can fail if libc needs to
> reallocate the environment block during the setenv().
>
> Let's just duplicate the string, so we know that it remains valid.
>
> In the long run it may be more robust to teach interactive_add() to take
> a set of environment variables to pass along to run-command when it
> execs add--interactive. And then we would not have to do this
> save/restore dance at all. But this is an easy fix in the meantime.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/commit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 004b816635..7d2e0b61e5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -351,7 +351,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>  		if (write_locked_index(&the_index, &index_lock, 0))
>  			die(_("unable to create temporary index"));
>  
> -		old_index_env = getenv(INDEX_ENVIRONMENT);
> +		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
>  		setenv(INDEX_ENVIRONMENT, get_lock_file_path(&index_lock), 1);
>  
>  		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
> @@ -361,6 +361,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>  			setenv(INDEX_ENVIRONMENT, old_index_env, 1);
>  		else
>  			unsetenv(INDEX_ENVIRONMENT);
> +		FREE_AND_NULL(old_index_env);
>  
>  		discard_cache();
>  		read_cache_from(get_lock_file_path(&index_lock));

Even though it is not wrong per-se to assign a NULL to the
now-no-longer-referenced variable, I do not quite get why it is
free-and-null, not a straight free.  This may be a taste-thing,
though.

Even if a future update needs to make it possible to access
old_index_env somewhere in the block after discard_cache() gets
called, we would need to push down the free (or free-and-null) to
prolong its lifetime a bit anyway, so...


