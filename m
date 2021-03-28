Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A091C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 19:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F5761972
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 19:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhC1TMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 15:12:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56037 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhC1TMH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 15:12:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88D7EAE880;
        Sun, 28 Mar 2021 15:12:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nIRKBE5kfet2YMvG/dKhA4raK5w=; b=JioIbv
        vbbFPf97UfWnwZB3fa/249B6D2TRYrr+yqSxcBfCZBeU1ZL2zDeEWUwuoclAd5iy
        OQOCv7cRKQxV/ltQkOry7pEdKqfcxGsEkqz1IwzMSj0VT/4q9ElZ4YXi1CDPMW0t
        BnJf9qAbdzT3RykrsJNeqFrTXWDj0Jz/Pq+1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UhWC6VJOGlDqNA5EHfvDZRnzZ+cV9scs
        fpqTGKW7y5SdROfnFZARUPrfVMadC/vWrXDx55Dg50MR1Hwg7qEoFnjFkszGEbpH
        1V/3TE8uEhN41PPZAMbDmPUYNgHg9xTDkRR8sG3sHua6LE1y/WuYZJpWPI6LXCHC
        R/JAIZwDauQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F33EAE87F;
        Sun, 28 Mar 2021 15:12:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E479FAE87D;
        Sun, 28 Mar 2021 15:12:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stavros Ntentos <stdedos@gmail.com>
Cc:     git@vger.kernel.org, stdedos+git@gmail.com, bagasdotme@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2] pathspec: advice: long and short forms are incompatible
References: <xmqqft1iquka.fsf@gitster.g>
        <20210328154532.23803-1-133706+stdedos@users.noreply.github.com>
Date:   Sun, 28 Mar 2021 12:12:05 -0700
In-Reply-To: <20210328154532.23803-1-133706+stdedos@users.noreply.github.com>
        (Stavros Ntentos's message of "Sun, 28 Mar 2021 18:45:32 +0300")
Message-ID: <xmqqmtunks8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C463794-8FF9-11EB-A4AA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stavros Ntentos <stdedos@gmail.com> writes:

Administrivia.

If "Stavros Ntentos <133706+stdedos@users.noreply.github.com>" is an
address that is not meant to receive any e-mail, please do not
include it on the Cc line and force those who respond to you to
remove it when replying.

> +static const char mixed_pathspec_magic[] = N_(
> +	"'%.*s...': cannot mix shortform magic with longform [e.g. like :(glob)].\n"

OK.  Just a bit of bikeshedding.

cannot mix short and long form magic
cannot mix shortform magic with longform
	
The former is a bit shorter.  Also, if we show (with %.*s) the
actual beginning of their attempt, e.g.  when they gave us [*]

	git show -- ':!(global,icase)foo'

if we show

	':!(glo...': cannot mix short and long form pathspec magic

or even just

	':!(...': cannot mix short and long form pathspec magic

it may be sufficiently clear where the problem is.

> +	"If '%.*s...' is a valid path, explicitly terminate magic parsing with ':'; or");

The seemingly-stray '; or' at the end aside, I am not sure what this
is trying to say.  If the sample input were [*] above, what are we
asking?  "if 'foo' is a valid path"?  No, we are showing 7 chars
starting at pos, so "if 'global,i...' is a valid path"?

If ':(global,icase)foo' were the exact path the user wants to match
with, then "prefix the whole thing with ":(literal)" would be an
understandable hint, but that is not what you are suggesting.

In short, I do not quite agree with the second line of the message.

It may be more helpful if, rather than looking at what comes after
'(', we looked at what came before '(' and helped the user write
them out in the longform, i.e. perhaps we can tell them the moral
equivalent of:

    If you meant by to use the pathspec magic '!' with other
    longform magic after '(' with ":!(...", use ":(exclude,..."
    instead.  Short and long form of pathspec magic do not mix.

> +static int extra_lookahead_chars = 7;

A few problems:

 - This is not something we want to configure.  It does not need to
   be a variable.

 - This is not something anybody other than the code in the new
   block "if (ch  == '(')" in parse_short_magic() needs to know.  It
   does not need to be a file-scope static.

 - 7 is way too long for warning against something like ":!(glob)",
   no?

But with the above "It may be more helpful" suggestion, notice that
I am deliberately refraining from looking at what comes after '(',
so extra-lookahead may not be necessary after all, and nitpicking
about it may be moot.

Thanks.

> @@ -356,6 +361,17 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
>  			continue;
>  		}
>  
> +		if (ch == '(') {
> +			/*
> +			 * a possible mistake: once you started a shortform
> +			 * you cannot add a longform, e.g. ":!(top)"
> +			 */
> +			advise_if_enabled(ADVICE_MIXED_SHORT_LONG_MAGIC_PATHSPEC,
> +			                  _(mixed_pathspec_magic),
> +			                  (int)(pos-elem+extra_lookahead_chars), elem,
> +			                  extra_lookahead_chars, pos);
> +		}
> +
>  		if (!is_pathspec_magic(ch))
>  			break;
