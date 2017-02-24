Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E237201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 18:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdBXSfd (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 13:35:33 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33069 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdBXSfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 13:35:31 -0500
Received: by mail-pf0-f194.google.com with SMTP id p185so1303358pfb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 10:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6qr2PeuLVVStDmCRShTZcF+g9mZcAvFogytStuK5jQM=;
        b=bJ3GwpOd7qc5WThq9llYhEZ7BaGHdYRwN4v/f+K4OET7h5hXh9pk6leFLaqZu264Ws
         Z/NFLHKALKjFkHpL3qoJw+bbGwIFueZ8+KPo0xc7nKiena4FcQEQBRjH4PobpXVVUoBP
         XS+ld7uClOBRjOQ1IR7CnV7ofBcUcgJPp4rsruVr6kanyAB0sIE9R8yFJzhU3ePVYLaX
         C7i1XtprZBkVFk1jSp+5FnnyQEBjsJbgTEs9HHLfjqk43svuZiP/0FHTx0tJoKePR3gf
         ZFeeyrjCIRpkxdBod2UFIWLNZ7X/EecNif4JR400oXK7PUaoAtzSZTjBbpf8tSg/nLMt
         crww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6qr2PeuLVVStDmCRShTZcF+g9mZcAvFogytStuK5jQM=;
        b=HG59h2MD9CXbjWkfDLk/BKZA3a56GetVSigtW5cTGc3wjFi1Ch8mNYyynOR+/KTpeR
         548C7/i7/prgCcXkV5HKGjL922DscbOaRO7rSZ1hdLdI+is0jJ9VmUfW+nuP8N4re9x7
         wJIRqINNHC+kHkqgWbKmtA9k4CauFlagZ8U6wodoq7uE/z8Ql1WX4czGlWaFyGh2Te63
         qqF7TX8o/gzr9UjkM548YShSJlZ3nQs0LTwHs86fy7y0tDbK6HLrWkH//oP6OF9cf4AD
         SupUE0v7f4TVM11QwZkljDSYtja+cuC454862L7jxTdU0xnRDc4wNPgLQJNYpak2orLS
         gbPQ==
X-Gm-Message-State: AMke39lInbdMeFG2WEMBD5UUKu6li61eSxqPIg2xAy0GX5q8xoViCM2hh2UEi5jEOau5eA==
X-Received: by 10.84.197.131 with SMTP id n3mr5781352pld.43.1487961330630;
        Fri, 24 Feb 2017 10:35:30 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id v186sm16416594pgv.44.2017.02.24.10.35.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 10:35:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 1/1] config: add conditional include
References: <20170223122346.12222-1-pclouds@gmail.com>
        <20170224131425.32409-1-pclouds@gmail.com>
        <20170224131425.32409-2-pclouds@gmail.com>
Date:   Fri, 24 Feb 2017 10:35:29 -0800
In-Reply-To: <20170224131425.32409-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 24 Feb 2017 20:14:23 +0700")
Message-ID: <xmqqfuj34etq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +Conditional includes
> +~~~~~~~~~~~~~~~~~~~~
> +
> +You can include one config file from another conditionally by setting
> +a `includeIf.<condition>.path` variable to the name of the file to be
> +included. The variable's value is treated the same way as `include.path`.
> +
> +The condition starts with a keyword followed by a colon and some data
> +whose format and meaning depends on the keyword. Supported keywords
> +are:
> +
> +`gitdir`::
> +
> +	The data that follows the keyword `gitdir:` is used as a glob
> +	pattern. If the location of the .git directory match the
> +	pattern, the include condition is met.

s/match/&es/, I think.

> ++
> +The .git location which may be auto-discovered, or come from

s/ which//?

> +`$GIT_DIR` environment variable. If the repository auto discovered via

s/If the /In a/?

> +a .git file (e.g. from submodules, or a linked worktree), the .git
> +location would be the final location, not where the .git file is.

OK.

> @@ -170,9 +171,99 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>  	return ret;
>  }
>  
> +static int prepare_include_condition_pattern(struct strbuf *pat)
> +{
> + ...
> +		/* TODO: escape wildcards */
> +		strbuf_add_absolute_path(&path, cf->path);

Is this still TODO?  As this one returns the prefix length (which
probably wants to be commented before the function) and this codepath
computes the prefix to cover the path to here, doesn't caller already
do the right thing?

> +static int include_condition_is_true(const char *cond, size_t cond_len)
> +{
> +	/* no condition (i.e., "include.path") is always true */

Does this want to say "includeIf.path" instead?  "include.path" is
done by handle_path_include() without involving a call to this
function.

> +	if (!cond)
> +		return 1;
> +
> +	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
> +		return include_by_gitdir(cond, cond_len, 0);
> +	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
> +		return include_by_gitdir(cond, cond_len, 1);
> +
> +	error(_("unrecognized include condition: %.*s"), (int)cond_len, cond);
> +	/* unknown conditionals are always false */
> +	return 0;
> +}

Thanks.
