Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCA21F453
	for <e@80x24.org>; Fri, 19 Oct 2018 08:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJSQda (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 12:33:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34634 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSQda (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 12:33:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so36066295wrt.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 01:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=otRi/xLiAdPFkBTzPpz62E1U1Q04AOIUrJUuWpH45ZM=;
        b=r2t5NrAZQ/vb01Qo+xbOju8/6R2vSmlWH6rl03H7viLKabzf5P//6NzNVn4XqLLsZN
         r3Dp0JI0FWhnBFCkFNFwXjAnXMcCJBsoUf6SZ6gh6zN3aUjl5neHbV+1i1nkBQVGeBiI
         zC1IaIfJW8yxXyJjW98ZBb61YFQcBfAZh1EmFLv5F7zfhdDqCpZV1pWyECvKWfrrKJhe
         UEnIQTA5hM+M52uCDNlYEQbv4BZfAu0oOqBLBEd17l8hcUWI+tkhTB7Qibl/Bbjg+5w4
         pi3qBbnazDGZFqz7i+tWEKEKoL1i0kZUT1eLiGwJDox5KW628MiJ0eSoB33AWyZTIWak
         dQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=otRi/xLiAdPFkBTzPpz62E1U1Q04AOIUrJUuWpH45ZM=;
        b=iLnTDGUL6/DouX7yC9BqGGviA+c4XDsIGnTAlJCA8bItf+k7cQea4Ximkko9hwkV+N
         GmGRNSsMZGM2XklK0+cfuRsiU2IMpYYBPXw3jETbOgGV3uH+3aYDX8cLWPhZm/2d1kt2
         L/GOAJ2CNwPPziQ/JJMaiqYdXwnB394nXjEzmk+HAitnxpyCmNvNY3M06ESQL6qjkrMi
         41tBeEUO8x/8bd8lBx9vjHa9ZWp0sJt7eIz0jQf6pIlcF9JkBKBZepxCHsHqTiXxA/Ay
         RXsHL5rJE5ATv7pnZe5x/RWxTr5xbzumH8+qyNobhPvjtSus09lVJt4fEZDvq/Eh0g8g
         dZ/Q==
X-Gm-Message-State: AGRZ1gLouqG3ExM1WNVDdUy1gFfhKgA9rET0cMRoz9wNADhwZSHQjLKG
        lxTHE4ACZvwvmASY0/xJCTLB+er8yw0=
X-Google-Smtp-Source: AJdET5cN02eb2m1Z6kq0zwqqR/XC4NdUxyfD5wu6MuqUP5Wh3pnbAMYrd2UgBjhx4l9miShD7KsrfA==
X-Received: by 2002:adf:edcf:: with SMTP id v15-v6mr1144657wro.47.1539937705334;
        Fri, 19 Oct 2018 01:28:25 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id y7-v6sm2293483wmy.27.2018.10.19.01.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 01:28:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
References: <87o9dar9qc.fsf@evledraar.gmail.com> <20181018225739.28857-1-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181018225739.28857-1-avarab@gmail.com>
Date:   Fri, 19 Oct 2018 10:28:22 +0200
Message-ID: <87pnw6cpcp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 18 2018, Ævar Arnfjörð Bjarmason wrote:

> +static void init_cmd_history(struct strbuf *env, struct string_list *cmd_list)
> +{
> +	const char *old = getenv(COMMAND_HISTORY_ENVIRONMENT);
> +	struct strbuf **cmd_history, **ptr;
> +
> +	if (!old || !*old)
> +		return;
> +
> +	strbuf_addstr(env, old);
> +	strbuf_rtrim(env);
> +
> +	cmd_history = strbuf_split_buf(old, strlen(old), ' ', 0);
> +	for (ptr = cmd_history; *ptr; ptr++) {
> +		strbuf_rtrim(*ptr);
> +		string_list_append(cmd_list, (*ptr)->buf);
> +	}
> +	strbuf_list_free(cmd_history);
> +}
> +
> +static void add_cmd_history(struct strbuf *env, struct string_list *cmd_list,
> +			    const char *cmd)
> +{
> +	string_list_append(cmd_list, cmd);
> +	if (env->len)
> +		strbuf_addch(env, ' ');
> +	strbuf_addstr(env, cmd);
> +	setenv(COMMAND_HISTORY_ENVIRONMENT, env->buf, 1);
> +}
> +
>  static int run_argv(int *argcp, const char ***argv)
>  {
>  	int done_alias = 0;
> -	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
> +	struct string_list cmd_list = STRING_LIST_INIT_DUP;
>  	struct string_list_item *seen;
> +	struct strbuf env = STRBUF_INIT;
>
> +	init_cmd_history(&env, &cmd_list);
>  	while (1) {
>  		/*
>  		 * If we tried alias and futzed with our environment,
> @@ -711,7 +742,7 @@ static int run_argv(int *argcp, const char ***argv)
>  			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
>  		}
>
> -		string_list_append(&cmd_list, *argv[0]);
> +		add_cmd_history(&env, &cmd_list, *argv[0]);
>
>  		/*
>  		 * It could be an alias -- this works around the insanity

Just to sanity check an assumption of mine: One thing I didn't do is use
sq_quote_buf() and sq_dequote_to_argv() like we do for
CONFIG_DATA_ENVIRONMENT. This is because in the case of config we need
to deal with:

    $ git config alias.cfgdump
    !env
    $ git -c x.y=z -c "foo.bar='baz'" cfgdump|grep baz
    GIT_CONFIG_PARAMETERS='x.y=z' 'foo.bar='\''baz'\'''

But in this case I don't see how a command-name would ever contain
whitespace. So we skip quoting and just delimit by space.

There's also nothing stopping you from doing e.g.:

    $ GIT_COMMAND_HISTORY='foo bar' ~/g/git/git --exec-path=$PWD one
    fatal: alias loop detected: expansion of 'foo' does not terminate:
      foo
      bar
      one
      two <==
      three
      four
      five ==>

Or even confuse the code by adding a whitespace at the beginning:

    $ GIT_COMMAND_HISTORY=' foo bar' ~/g/git/git --exec-path=$PWD one
    fatal: alias loop detected: expansion of '' does not terminate:

      foo
      bar
      one
      two <==
      three
      four
      five ==>

I thought none of this was worth dealing with. Worst case someone's
screwing with this, but I don't see how it would happen accidentally,
and even then we detect the infinite loop and just degrade to confusing
error messages because you decided to screw with git's GIT_* env vars.
