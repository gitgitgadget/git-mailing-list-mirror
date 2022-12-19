Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53385C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 22:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiLSW7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiLSW7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 17:59:33 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDCB14D2E
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 14:59:30 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id jo4so16266040ejb.7
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 14:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0i9S9BIZ0eb1GE7jkA8i/qAdgxktYRm+HA4wzipk5o=;
        b=iLVOHshE4W5Jk8IWgHjhrTBEPXSM787Lc+lPhIYhjy7ZMritHxEmgGTvGKDWADNF4W
         MCHqHa0P3ZpjPaqO4JNYj5okBs2b7/XCfi3YD20KwC6jS7PI1+C682ho2Yd+skUbFpyu
         xpnaoj4IELCmyt2y91wBaQ24bXkceZvtBRtOJzOfBL1uWsMbPk70dBmEpyVW/1lJwExw
         blFmL1Hpuxrc6lhZ8PY8dbSlNm4zofxWSbajPt/xVpIt1pGCIKIiGUX/JKEl/tdbZnN5
         Z9DgpGXMMAaNjjjJSiaQelQ3JY208l7DKP8gjGhe//Cv5CC0sMwf6qABH0Zmc5enJEAZ
         bAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0i9S9BIZ0eb1GE7jkA8i/qAdgxktYRm+HA4wzipk5o=;
        b=7+PQ3TQrvg0ddBo7XDT91G9ROsjOUPedoUBjkPxngmm64qspf4H1Rhfpn/3Q3qUAxO
         01LpEn7OQXJgBfCBnrZk1OWlStISgUisOvjBwsGCOTD7VcBULYK718bUnfvthDdnGEY7
         DTjluM0uSEp6tOPDHXrgk8l+RYNdOpX+cXoK58nX+dOZdWrjLUS5KaHpqZY+4b7xTPYz
         U7MqrYuPoBd0MXqFIQuZfr3ji8NzxN+FD6044oIWoe5cadB238szsgbu0IUBvYLI3ql9
         kol+7lH1/xln4SfnLDvkuAcjwXO1vyavD7LRzMsGTst52sn0bBLFE3rDn7CECmY/XKqy
         2tVQ==
X-Gm-Message-State: ANoB5pk42piDgQkc3zEeWLPluCTvBf6dlI0XtmrRih7CIzfwVfI60NxR
        sO9T6cyMtVtVhVzepP8G/T2Ealm5ECQfeg==
X-Google-Smtp-Source: AA0mqf4fYvHWU2/l9aqzUkPKz01F503DvRCpUIuYPJXMFH1m4AmryBO6zfLRnPkgem/jSvJzDe2/AQ==
X-Received: by 2002:a17:906:3716:b0:7c0:bbab:22e5 with SMTP id d22-20020a170906371600b007c0bbab22e5mr34523965ejc.16.1671490768327;
        Mon, 19 Dec 2022 14:59:28 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id wl4-20020a170907310400b0077a201f6d1esm4868142ejb.87.2022.12.19.14.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 14:59:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7P6V-006r9X-10;
        Mon, 19 Dec 2022 23:59:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Kellogg-Stedman <lars@oddbit.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] line-range: fix infinite loop bug with '$' regex
Date:   Mon, 19 Dec 2022 23:55:41 +0100
References: <20221205193625.2424202-1-lars@oddbit.com>
 <20221219224850.2703967-1-lars@oddbit.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221219224850.2703967-1-lars@oddbit.com>
Message-ID: <221219.86edsvxank.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Lars Kellogg-Stedman wrote:

> When the -L argument to "git log" is passed the zero-width regular
> expression "$" (as in "-L :$:line-range.c"), this results in an
> infinite loop in find_funcname_matching_regexp().
>
> Modify find_funcname_matching_regexp to correctly match the entire line
> instead of the zero-width match at eol and update the loop condition to
> prevent an infinite loop in the event of other undiscovered corner cases.
>
> The primary change is that we pre-decrement the beginning-of-line marker
> ('bol') before comparing it to '\n'. In the case of '$', where we match the
> '\n' at the end of the line and start the loop with bol == eol, this
> ensures that bol will find the beginning of the line on which the match
> occurred.
>
> Originally reported in <https://stackoverflow.com/q/74690545/147356>.
>
> Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
> ---
>  line-range.c        |  7 ++++---
>  t/t4211-line-log.sh | 22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/line-range.c b/line-range.c
> index 955a8a9535..47bf0d6f1a 100644
> --- a/line-range.c
> +++ b/line-range.c
> @@ -135,7 +135,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>  {
>  	int reg_error;
>  	regmatch_t match[1];
> -	while (1) {
> +	while (*start) {
>  		const char *bol, *eol;
>  		reg_error = regexec(regexp, start, 1, match, 0);
>  		if (reg_error == REG_NOMATCH)
> @@ -148,8 +148,8 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>  		/* determine extent of line matched */
>  		bol = start+match[0].rm_so;
>  		eol = start+match[0].rm_eo;
> -		while (bol > start && *bol != '\n')
> -			bol--;
> +		while (bol > start && *--bol != '\n')
> +			; /* nothing */
>  		if (*bol == '\n')
>  			bol++;
>  		while (*eol && *eol != '\n')
> @@ -161,6 +161,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>  			return bol;
>  		start = eol;
>  	}
> +	return NULL;
>  }
>  
>  static const char *parse_range_funcname(
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index ac9e4d0928..c6540e822f 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -315,4 +315,26 @@ test_expect_success 'line-log with --before' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'setup tests for zero-width regular expressions' '
> +	cat >expect <<-EOF
> +	Modify func1() in file.c
> +	Add func1() and func2() in file.c
> +	EOF
> +'
> +
> +test_expect_success 'zero-width regex $ matches any function name' '
> +	git log --format="%s" --no-patch "-L:$:file.c" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'zero-width regex ^ matches any function name' '
> +	git log --format="%s" --no-patch "-L:^:file.c" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'zero-width regex .* matches any function name' '
> +	git log --format="%s" --no-patch "-L:.*:file.c" >actual &&
> +	test_cmp expect actual
> +'
> +

Untested, but as most of this is repeated & would fail if the "setup"
test is skipped, a one-off function would be better, e.g.:
	
	test_zerowidth_regex () {
		local rx="$1" &&
		
		test_expect_success "zero-width regex '$rx' matches any function name" '
			cat >expect <<-\EOF &&
			Modify func1() in file.c
			Add func1() and func2() in file.c
			EOF
			git log --format="%s" --no-patch -L:"$rx":file.c >actual &&
			test_cmp expect actual
		'
	}
	
	test_zerowidth_regex '$'
	test_zerowidth_regex '^'
	test_zerowidth_regex '.*'

The change of direction for the fix itself looks good to me (re my
earlier feedback on a previous round), i.e. that we should fix our own
code, not forbid '$' in regexes.
