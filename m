Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB9C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4140A21582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g2UXA5RM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfLRTqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:46:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53709 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfLRTqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:46:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45204A8493;
        Wed, 18 Dec 2019 14:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=csMf4frZJgmn2N6uUUV7XmXnrZs=; b=g2UXA5
        RM4sTuiRJ2Ta6OSpbGBbfQfU3NZTw10/t9OYUSTkOwavLBObAS7B9+qCriWCc6Q2
        yIkyefPrZ1olioeAgltNYSLS4d+vi92r2TbZZ0VYWu99SGxjKN5IEgC52i4lrYar
        ggJubwRZqfGJePVEUYBfoEpZ8ZTizTCaGpQOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gK2C1KM10cf8te57WWJM5rZS2fkK7pAW
        M0MS7MlJLLokTriKLPcsSEonnKBek/0xVYbg5dKAUgWE85BDr/kZTcbSfmQJC1iW
        tsTA8btOOmfUJLMUQHRt7JxkBYN7UgL/L6gCUGyH75xgNKTO2sqIwPN8V1Z5+11+
        Jx8+RpyeVu0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D6BBA8492;
        Wed, 18 Dec 2019 14:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 675FDA8490;
        Wed, 18 Dec 2019 14:46:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 11:46:06 -0800
In-Reply-To: <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Wed, 18 Dec 2019
        01:11:04 +0000")
Message-ID: <xmqqa77pe7sx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09C9A848-21CF-11EA-A91E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static int end_null;
> +static int end_nul;
> -	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> +	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
> -	const char term = end_null ? '\0' : '\t';
> +	const char term = end_nul ? '\0' : '\t';
> -	if (end_null)
> +	if (end_nul)

These are correct changes, but is unrelated noise in the context of
the theme of the patch, no?

> +static const char *scope_to_string(enum config_scope scope) {
> +	/*
> +	 * --local, --global, and --system work the same as --file so there's
> +	 * no easy way for the parser to tell the difference when it is
> +	 * setting the scope, so we use our information about which options
> +	 * were passed
> +	 */
> +	if (use_local_config || scope == CONFIG_SCOPE_REPO) {
> +		return "local";
> +	} else if (use_global_config || scope == CONFIG_SCOPE_GLOBAL) {
> +		return "global";
> +	} else if (use_system_config || scope == CONFIG_SCOPE_SYSTEM) {
> +		return "system";

The above is slightly tricky; --global/--system/--local are made
mutually exclusive in the higher level, so if any of them is set,
we do not even need to look at the "scope" to tell what kind of
source we are reading from.

> +	} else if (given_config_source.use_stdin ||
> +		given_config_source.blob ||
> +		given_config_source.file ||
> +		scope == CONFIG_SCOPE_CMDLINE) {
> +		return "command line";

I am not sure what the implication of saying "they came from the
command line" when we read from the standard input or from a blob.

> +	} else {
> +		return "unknown";
> +	}
> +}

In any case, the need for such logic that says "scope might not say
it is REPO, but when use_local_config is true, we are doing a local
config" implies that "scope" parameter the caller of this function
has is not set correctly when these options are used---would that be
the real bug that needs fixing, rather than getting "worked around"
with a code like this?

It almost makes me point fingers at config.c::config_with_options()
where config_source is inspected and git_config_from_*() helpers are
called without setting the current_parsing_scope.  Unlike these
cases, when do_git_config_sequence() is called from that function,
the scope is recorded in the variable before each standard config
source file is opened and read.  What would we be breaking if we
taught the function to set the current_parsing_scope variable
correctly even when reading from the config_source?  That would
certainly simplify this function quite a lot, but if the other parts
of the codebase relies on the current behaviour, we cannot make such
a change lightly.

> +static void show_config_scope(struct strbuf *buf)
> +{
> +	const char term = end_nul ? '\0' : '\t';
> +	const char *scope = scope_to_string(current_config_scope());
> +
> +	strbuf_addch(buf, '(');
> +	if (end_nul)
> +		strbuf_addstr(buf, N_(scope));
> +	else
> +		quote_c_style(scope, buf, NULL, 0);

Isn't this overkill?  I think this code was copied-and-pasted from
the other function that needs to show an arbitrary end-user supplied
data which is a pathname, so it makes perfect sense to use c-style
quoting, but the token scope_to_string() returns is taken from a
bounded set that doesn't require such quoting, no?

> +	strbuf_addch(buf, ')');
> +	strbuf_addch(buf, term);
> +}
> +
