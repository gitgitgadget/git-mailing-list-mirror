Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175D420248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfDSTsL (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:48:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39435 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDSTsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:48:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so8044482wrn.6
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A3zZEI68qRAoPl+tevtMDNY3hUwlLNeh+MvqAq0AMUg=;
        b=auhZGRFhvs+KQJe4WPsasdmST83pEeWp1BmAsAtfjRCTEVFXXbTrGpVPcXmp94V2a6
         12iN0l+wQuS875+MDtc6muwGRvOgITROvWKe+Wt8WZWMkCuW9a4dJi3HvTYxnEu71Jy0
         xhXquFVxnS6ML/DoNKGE3EcGtTNMz2CKy7xLI62z3jvCD5zwTJMvAVcuul2gjOMzus9g
         3jDnlc8IGQzHGuw/D8ZZScWRfHEGzPoP7p7T0b52yZkcj6VuxvNTcozhnLjcThGx5DSI
         YNfVqr9JKjNG1JL3ncGqDuWAay4VGF53DSTC3GCqisdqGm63GjCtY9U++wTaRwNbU3/a
         SHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A3zZEI68qRAoPl+tevtMDNY3hUwlLNeh+MvqAq0AMUg=;
        b=mGVsgBrkdQQDhnlT/ynt7pCi+374owLNnIyBefCou/g3HknsFTCHu1rXvxx+PoVxxZ
         6dUbHJ5fTDke6WJIxwQsJDN+bey8nVib+dfCunsyHp19DxMsj9x8KWJr0Zqi6XFrLEmu
         QFYyC9OG6GAgEUP6ZJCQPbWKCJhSfuwSRoesjoJb37vK3RS8BDw0lJvRRJWWzSy9fF/f
         FWSStWuFYMjDewTtLEUShI4jJTgAbCrDTeQDedLpb3UbSht3ZvwXvYYHzbqOYQODAbM5
         FRQwV+oG5T9Ay6gFFZ00pyLk7+MQg32X+7/fRpkL+J9OH9Ykcsx2Q34X6FQ2JsLWzmV8
         zlqg==
X-Gm-Message-State: APjAAAVmUJuDvlHIZxMK5ed3Mu79V4j0a8/cxUEg1wxGUeHl5p58PdNA
        GXSD2WE+hH+5m+ttT8AckPwv5SjVNgw=
X-Google-Smtp-Source: APXvYqwCVIYsg9yWmHM2sTo8w8FyrBopiHxvvfqqLhV67oGLeprP5afsJmWnsHwZaxtNqymZV3s+Og==
X-Received: by 2002:a5d:6388:: with SMTP id p8mr1339467wru.322.1555648756749;
        Thu, 18 Apr 2019 21:39:16 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b11sm3900641wru.61.2019.04.18.21.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 21:39:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] parse-options: don't emit "ambiguous option" for aliases
References: <20190325202329.26033-3-avarab@gmail.com>
        <20190417124438.8191-1-avarab@gmail.com>
        <CACsJy8D215hMvfCwz1G9mP2te-ZERVaMMRrnM=MK1_bc0oFsjw@mail.gmail.com>
        <xmqq4l6wjfyw.fsf@gitster-ct.c.googlers.com>
        <20190418092940.GA13484@ash>
Date:   Fri, 19 Apr 2019 13:39:15 +0900
In-Reply-To: <20190418092940.GA13484@ash> (Duy Nguyen's message of "Thu, 18
        Apr 2019 16:29:41 +0700")
Message-ID: <xmqq1s1yfw24.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> So an alternative is simply outsource the ambiguity decision back to
> git-clone. If the same situation appears again elsewhere, we'll need
> to sit back and fix it for real. But this way we don't potentially
> introduce any new traps.

Sounds like a sensibly safe approach.

> +/*
> + * Avoid ambiguation error between --recursive and --recurse-submodule
> + * because they are the same. --recurs can be expanded to any of them
> + * and it still works.
> + */
> +static int is_abbrev_ambiguous(const struct option *prev,
> +			       const struct option *next)
> +{
> +	const struct option *opts[] = { prev, next };

By looking at its caller, I think the caller keeps track of the
candidate it saw so far, and ask this function to see if the one it
is looking at right now (i.e. "this one") should be flagged as
conflicting with the other one (or "the other one").  So it probably
makes more sense to call them <it, the_other> or <it, prev> [*1*].

	Side note: *1* I would have used "this" instead of "it", but
	I vaguely recall there are those who want to use C++ aware
	static checkers and avoiding the identifier "this" is easy
	enough so ...

> +	int i, found = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(opts); i++) {
> +		if (!opts[i]->long_name)
> +			continue;
> +		if (!strcmp(opts[i]->long_name, "recursive"))
> +			found |= 1 << 0;
> +		if (!strcmp(opts[i]->long_name, "recurse-submodules"))
> +			found |= 1 << 1;
> +	}
> +
> +	return found != 3;
> +}

For any two options that share the prefix, unless they are
"recursive" and "recurse-submodules" pair, we say "that's
ambiguous".  But when they are these two specifically singled out,
we say it is OK.  Makes sense.

The above may be sufficient for this purpose, but I would have
expected that these groups of aliases would be the ones in the
table, not the <it, the_other> pair.  IOW, with helpers like these:

	static const char *recurse_submodules[] = {
		"recurse-submodules", "recursive", NULL,
	};

	static struct {
		const char **aliases;
	} disamb[] = {
		recurse_submodules,
	};
		
	static int has_string(const char *it, const char **array)
	{
		while (*array)
			if (!strcmp(it, *(array++)))
				return 1;
		return 0;
	}

the body would look something like:

	int j;

	for (j = 0; j < ARRAY_SIZE(disamb); j++) {
		/* it and other are from the same family? */
		if (it->long_name &&
		    has_string(it->long_name, disamb[j].aliases) &&
		    other->long_name &&
		    has_string(other->long_name, disamb[j].aliases))
			return 0;
	}
	return 1;

Perhaps?

I suspect that renaming the function (and the field in the context
struct) to .is_alias() and reverse the polarity of its return value
may make the flow of the logic at the caller side easier to follow?

> diff --git a/parse-options.c b/parse-options.c
> index cec74522e5..c0354e5a92 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -294,7 +294,8 @@ static enum parse_opt_result parse_long_opt(
>  			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
>  			    !strncmp(long_name, arg, arg_end - arg)) {
>  is_abbreviated:
> -				if (abbrev_option) {
> +				if (abbrev_option &&
> +				    p->is_abbrev_ambiguous(abbrev_option, options)) {

The above suggestion would make the guard here to

			if (abbrev_option &&
			    !p->is_alias(abbrev_option, options)) {

That is, at this point, we know that the user may have used the
given string to name the "abbrev_option" we earlier saw (and made
sure it prefix matches the string), and now we are looking at
another one, options[0], that also prefix matches the string.  We
usually flag this case as a problematic ambiguity inside the body of
this if statement, but if one is an alias to the other, we do not do
so.

>  					/*
>  					 * If this is abbreviated, it is
>  					 * ambiguous. So when there is no
