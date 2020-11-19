Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D272C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2723E20BED
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kliy5qLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKSWmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:42:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56253 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgKSWmo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 17:42:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0173F116C3F;
        Thu, 19 Nov 2020 17:42:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0CmCcgXILQWETMWDv4zYmYaRQkw=; b=Kliy5q
        LBRQCxJW39J2NjAJ3FHZxT62j9veBjYaSgZ+tFsx+3k4BSXStTcmaF/+CSAj3Q62
        xaVZ+ARvbVMBsESy/cJiksHNeNqt0D5OnWuUzMvYQBalyD2MxRhxxOmsV8t6BJSV
        g2AsMUtJNR6ymtQ3qwFkqq0C5tFPsJjNv5vvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UDyB00PfhHuXkM4AgQ70QrFRBYTxmGpE
        fPrVKWR/m9WoUCjZ4vXSR7MysU1XgtYR1Ab1QpvHxvcJX/b62FYxFBadYkEmE7ls
        wUKSPQnOkdSeabe8ZrY3nZ20uHxFuFCad00jF4J6NDEXgbPxtylrVhsMGWcElp0u
        eYwx/PQIAME=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED93B116C3E;
        Thu, 19 Nov 2020 17:42:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CF1D116C3D;
        Thu, 19 Nov 2020 17:42:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/7] config: add --literal-value option, un-implemented
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <28493184b60d3fa46cde346eaae6128bce87c114.1605801143.git.gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 14:42:36 -0800
In-Reply-To: <28493184b60d3fa46cde346eaae6128bce87c114.1605801143.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 Nov 2020
        15:52:20 +0000")
Message-ID: <xmqqft55vuhv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 866EAF0E-2AB8-11EB-A91E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--literal-value::
> +	When used with the `value_regex` argument, treat `value_regex` as
> +	an exact string instead of a regular expression. This will restrict
> +	the name/value pairs that are matched to only those where the value
> +	is exactly equal to the `value_regex`.

Makes sense.

>  --type <type>::
>    'git config' will ensure that any input or output is valid under the given
>    type constraint(s), and will canonicalize outgoing values in `<type>`'s
> diff --git a/builtin/config.c b/builtin/config.c
> index e7c7f3d455..ad6c695737 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -34,6 +34,7 @@ static int respect_includes_opt = -1;
>  static struct config_options config_options;
>  static int show_origin;
>  static int show_scope;
> +static int literal;
>  
>  #define ACTION_GET (1<<0)
>  #define ACTION_GET_ALL (1<<1)
> @@ -52,6 +53,16 @@ static int show_scope;
>  #define ACTION_GET_COLORBOOL (1<<14)
>  #define ACTION_GET_URLMATCH (1<<15)
>  
> +#define ACTION_LITERAL_ALLOWED (\
> +	ACTION_GET |\
> +	ACTION_GET_ALL |\
> +	ACTION_GET_REGEXP |\
> +	ACTION_REPLACE_ALL |\
> +	ACTION_UNSET |\
> +	ACTION_UNSET_ALL |\
> +	ACTION_SET_ALL\
> +)

I am not sure about this, though.

Even if an action can potentially take value_regex, e.g.

    git config --get name [value_regex]

should we allow litral when value_regex is not given?  IOW

    $ git config --get --literal-value vari.able v2.26.0+next

may make sense, but shouldn't

    $ git config --get --literal-value vari.able

be an error?

To put it differently, I think the macro being defined is not
ACTION_LITERAL_ALLOWED, but ACTION_VALUE_REGEX_ALLOWED. i.e. list of
actions that can potentially take value_regex.  A command line that
gives value_regex to an action that is not listed there is an error.

> +	if (literal && !(actions & ACTION_LITERAL_ALLOWED)) {
> +		error(_("--literal only applies with 'value_regex'"));
> +		usage_builtin_config();
> +	}

This check is not incorrect per-se, because an action that never
takes value_regex is by definition incompatible with the literal
value option.  But it does not flag it as an error to ask a
value_regex to be treated as a literal string when there is no
value_regex given.

Having said that, I think it is OK, at least for now, to leave such
an error undetected---it falls into the "if it hurts, don't do it"
category.

Thanks.

>  	if (actions & PAGING_ACTIONS)
>  		setup_auto_pager("config", 1);
>  
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 74e0f84c0a..73f5ca4361 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1965,4 +1965,17 @@ test_expect_success '--replace-all and value_regex' '
>  	test_cmp expect .git/config
>  '
>  
> +test_expect_success 'refuse --literal-value for incompatible actions' '
> +	git config dev.null bogus &&
> +	test_must_fail git config --literal-value --add dev.null bogus &&
> +	test_must_fail git config --literal-value --get-urlmatch dev.null bogus &&
> +	test_must_fail git config --literal-value --get-urlmatch dev.null bogus &&
> +	test_must_fail git config --literal-value --rename-section dev null &&
> +	test_must_fail git config --literal-value --remove-section dev &&
> +	test_must_fail git config --literal-value --list &&
> +	test_must_fail git config --literal-value --get-color dev.null &&
> +	test_must_fail git config --literal-value --get-colorbool dev.null &&
> +	test_must_fail git config --literal-value --edit
> +'
> +
>  test_done
