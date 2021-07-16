Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C9CC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 09:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733836128D
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 09:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhGPJNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhGPJNO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 05:13:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09868C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 02:10:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hd33so14077945ejc.9
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UtA3A5QSxaz2RX6pICls7wHjPfVAiQgI54BtNugjB3U=;
        b=ToB70Br8rZ9bIiS85x2XDoDcpnnIO3r+I04nS0jA1ZsPPe7iKVuHYcwj7JfQ5YcgLN
         yLKtnyxqNsJLS7vJtxzDmaUN2zwiCCmAdPa+P++/2go8Xl8lZl9bBg2NHfAkO2S7wFJs
         BGz++En2SyO+ytTy+qU5se0v4+lfsTXwYPav3/uvCt+l1XCxVarbtzD20D7Aj+bl+DZp
         1CuQobWLJyGSmmZRi/YFRgnrFaoN/zS6WSMgqgGLU11R8vEJ0FFSfuxwhNF1W016MXwi
         Dg45p7hIZij22w14TCvreXIgfIH3khsPkz5vtlOiGscsJicemUJYsAzq6GzGLkuieNyq
         52iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UtA3A5QSxaz2RX6pICls7wHjPfVAiQgI54BtNugjB3U=;
        b=JmJh9hzHRmDcRnqovYIBBJ9WODdW05n7jw/m7tb6kibo8or4z93RAoQs7w4FUZtblH
         q4T1RiO+pVPlHSvyOQG7aNo+j/aFm2FAr4mfpWmZkQXKlFOiUEHQAE5/L8PUpM83RtcL
         R3/2OKTMm1oxq6J2atOyln5p1AS0TZDgl3W2xuS4PLX7wQ+IGrQ5fti7B67/zOscnsEa
         SqozRmPfEBkdqO3Ie941Slu1Wc3HctyL099jgfNkbiaWRvKu4UW5vloc6UjA0ZGOFeiv
         gN1kSGddtkCdTCv1SpqMXvVXiI8MK+mxTkY8V1qfE9Cg2uPwa/WMzlIcHCdMKXeu0vB0
         9nJw==
X-Gm-Message-State: AOAM532nCGDzeiEZmsoKK+sBZQf4zh1Pwp2WGA5362bj4x0UGmralDFE
        zpDsrojRZW1/VrDK8ecxyis=
X-Google-Smtp-Source: ABdhPJyLvLw5Sd9fc0GeWgqrnOHn1TFtjKeiodW7WypRRQcObFNOyofOJYcDbbgpXb8hblT+sAauFQ==
X-Received: by 2002:a17:907:762d:: with SMTP id jy13mr10531109ejc.211.1626426618548;
        Fri, 16 Jul 2021 02:10:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n2sm3485473edi.32.2021.07.16.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:10:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/9] hook: include hooks from the config
Date:   Fri, 16 Jul 2021 11:01:24 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-7-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210715232603.3415111-7-emilyshaffer@google.com>
Message-ID: <87im1ay67y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Emily Shaffer wrote:

> +static struct hook * find_hook_by_command(struct list_head *head, const char *command)

nit: "*find[...]" not "* find[...]", also let's wrap the long line.

> +{
> +	struct list_head *pos = NULL, *tmp = NULL;
> +	struct hook *found = NULL;
> +
> +	list_for_each_safe(pos, tmp, head) {
> +		struct hook *it = list_entry(pos, struct hook, list);
> +		if (!strcmp(it->command, command)) {
> +		    list_del(pos);
> +		    found = it;
> +		    break;

Indented with spaces.

Also is there some subtlety in the list macro here or can we just
"s/break/return it/" and skip the break/return pattern?

> +static struct hook * append_or_move_hook(struct list_head *head, const char *command)

Same whitespace nits.

> +	if (!to_add) {
> +		/* adding a new hook, not moving an old one */
> +		to_add = xmalloc(sizeof(*to_add));
> +		to_add->command = command;
> +		to_add->feed_pipe_cb_data = NULL;
> +		/* This gets overwritten in hook_list() for hookdir hooks. */
> +		to_add->from_hookdir = 0;

I commented on init verbosity elsewhere, i.e. we could do some things
via macros, but in this case just having an "init" helper make sense,
but we have at least two places copying the same init of all fields,
should just be hook_init_hook() or whatever it'll be called. Maybe with
a second "from hookdir" param?

> +	if (!strcmp(key, hook_key)) {
> +		const char *command = value;
> +		struct strbuf hookcmd_name = STRBUF_INIT;
> +
> +

Nit: 3x\n, not 2x\n

> +		if (!command) {
> +			strbuf_release(&hookcmd_name);

You don't need to strbuf_release() things that you haven't done anything
except init'd, but also...

> +			BUG("git_config_get_value overwrote a string it shouldn't have");

...even if that were the case and it called malloc() memory diligence
when we're calling BUG() is probably going overboard, and I say that as
someone who'll tend to go overboard with it :)

> +		}
> +
> +		/* TODO: implement skipping hooks */
> +
> +		/* TODO: immplement hook aliases */
> +
> +		/*
> +		 * TODO: implement an option-getting callback, e.g.
> +		 *   get configs by pattern hookcmd.$value.*
> +		 *   for each key+value, do_callback(key, value, cb_data)
> +		 */

I think we should drop the TODO and just let the commit message /
comments speak to what we actually implement, and subsequent patches can
add more features.

> -
> +	struct strbuf hook_key = STRBUF_INIT;
> +	struct hook_config_cb cb_data = { &hook_key, hook_head };

Let's use designated initializers.

>  
>  	INIT_LIST_HEAD(hook_head);
>  
>  	if (!hookname)
>  		return NULL;
>  
> +	/* Add the hooks from the config, e.g. hook.pre-commit.command */
> +	strbuf_addf(&hook_key, "hook.%s.command", hookname);
> +	git_config(hook_config_lookup, &cb_data);
> +
> +

Another 3x\n

> +	/* to enable oneliners, let config-specified hooks run in shell */
> +	cp->use_shell = !run_me->from_hookdir;

I've lost track at this point, but doesn't that mean we're going to use
a shell when we run our own do-not-need-a-shell hooks ourselves?

Isn't isatty() more appropriate here, or actually even interactively why
is the shell needed (maybe this is answered elswhere...).
