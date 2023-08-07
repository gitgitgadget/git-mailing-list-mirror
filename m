Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21151C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 22:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjHGWwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjHGWwD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 18:52:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B1100
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 15:52:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58440eb872aso65491227b3.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691448721; x=1692053521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mE1Ojdu4281nxyAMkc6rfa6r81lvBCj3pb7VeQxyTQU=;
        b=tpUc/Od9e18QNSnHC15Y4QZ6VfH6hgWKFobQjPmqkgkDb9WG26lo5fhaIIZM2/ITlq
         A8ktk+K2m2m6D3g9xg/JYpK699joEeVC1ZoAqOMvTdg9gzRv91/uN6pNrj/BmzQiEX1g
         n8jQvXhxbag8OzySjQyYnZetuE/o+070FfoK9iN2pekIxfCqX+BqcyCMZeZDNYXc4KIU
         +q1SYvfMQEbqYYBXG4VSGxIgoKq3bRaZQW6jU367sMml75mKKdD4/mWelTDgdEsaL6ZM
         pfW+fh3IWOpnSL8tITi2UMeIPaO4d8qwb3Ca9GTJTlOY+Usut8AFprzmBd4Y8YAw+bHd
         /Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691448721; x=1692053521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mE1Ojdu4281nxyAMkc6rfa6r81lvBCj3pb7VeQxyTQU=;
        b=S2Uim5tY3EwKKYsuEavFBPG5e0PeZDnSa3uSJzVMJIAOabRB1+5Wk5zhNzQCtF99kQ
         nqcSrzo6sORiGapceUivHVj3fnkjuAIH1EAml0qt9Xsk1AUr6ncnD3wz+yF+lwdSSe0E
         C3grtq2urEcevYvPS73cp4lUAfZX4bsl+Kt3K7v3o5NMNUq5ss9V7OWINav1q3VIEEVZ
         QbgyEtsMQsIMK+LoedhlsvPyGn+ZEIL4efOrY9uqHt1pIes9PzbmOWZdvwy1n71JgNL0
         0uVW29aGJJyrbeCcjKOP9ktYO3/sZOmPvH/B088sUkY/3PMMeQsFWGM7nmTeZu80n5e7
         YJNg==
X-Gm-Message-State: AOJu0YzRFUsC+SfSddOFW7vRes/b8wA+lkZ6GDGE7zoe+vKv8P0Y1nR0
        fDORHmsSLEsxF6YK1EelRqtIJjJtFeyUjw==
X-Google-Smtp-Source: AGHT+IG8BecHBLWzv1HJwJ3y3BFbryq9Ejslbo9awMzJvFPXvbCfxRFIBdsPn2XyR7KZ0jbu77D2HxcS8yKF7w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:b144:0:b0:586:4e84:26d2 with SMTP id
 p65-20020a81b144000000b005864e8426d2mr90627ywh.3.1691448721360; Mon, 07 Aug
 2023 15:52:01 -0700 (PDT)
Date:   Mon, 07 Aug 2023 15:51:59 -0700
In-Reply-To: <c8bb013662187e9239d4a2499a63ed76daa78d14.1691211879.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com> <c8bb013662187e9239d4a2499a63ed76daa78d14.1691211879.git.gitgitgadget@gmail.com>
Message-ID: <kl6l1qgea2k0.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 3/5] trailer: split process_command_line_args into
 separate functions
From:   Glen Choo <chooglen@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Previously, process_command_line_args did two things:
>
>     (1) parse trailers from the configuration, and
>     (2) parse trailers defined on the command line.

It parses trailers from two places, but it still only does "one thing",
in that it only parses trailers.

> @@ -711,30 +711,35 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
>  	list_add_tail(&new_item->list, arg_head);
>  }
>  
> -static void process_command_line_args(struct list_head *arg_head,
> -				      struct list_head *new_trailer_head)
> +static void parse_trailers_from_config(struct list_head *config_head)
>  {
>  	struct arg_item *item;
> -	struct strbuf tok = STRBUF_INIT;
> -	struct strbuf val = STRBUF_INIT;
> -	const struct conf_info *conf;
>  	struct list_head *pos;
>  
> -	/*
> -	 * In command-line arguments, '=' is accepted (in addition to the
> -	 * separators that are defined).
> -	 */
> -	char *cl_separators = xstrfmt("=%s", separators);
> -
>  	/* Add an arg item for each configured trailer with a command */
>  	list_for_each(pos, &conf_head) {
>  		item = list_entry(pos, struct arg_item, list);
>  		if (item->conf.command)
> -			add_arg_item(arg_head,
> +			add_arg_item(config_head,
>  				     xstrdup(token_from_item(item, NULL)),
>  				     xstrdup(""),
>  				     &item->conf, NULL);
>  	}
> +}
> +
> +static void parse_trailers_from_command_line_args(struct list_head *arg_head,
> +						  struct list_head *new_trailer_head)
> +{
> +	struct strbuf tok = STRBUF_INIT;
> +	struct strbuf val = STRBUF_INIT;
> +	const struct conf_info *conf;
> +	struct list_head *pos;
> +
> +	/*
> +	 * In command-line arguments, '=' is accepted (in addition to the
> +	 * separators that are defined).
> +	 */
> +	char *cl_separators = xstrfmt("=%s", separators);
>  
>  	/* Add an arg item for each trailer on the command line */
>  	list_for_each(pos, new_trailer_head) {

I find this equally readable as the preimage, which IMO is adequately
scoped and commented.

> @@ -1070,8 +1075,11 @@ void process_trailers(const char *file,
>  
>  
>  	if (!opts->only_input) {
> +		LIST_HEAD(config_head);
>  		LIST_HEAD(arg_head);
> -		process_command_line_args(&arg_head, new_trailer_head);
> +		parse_trailers_from_config(&config_head);
> +		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
> +		list_splice(&config_head, &arg_head);
>  		process_trailers_lists(&head, &arg_head);
>  	}

But now, we have to remember to call two functions instead of just one.
This, and the slight additional churn makes me lean negative on this
change. I would be really happy if we had a use case where we only
wanted to call one function but not the other, but it seems like this
isn't the case.
