Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79841F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbdHPStd (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:49:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60637 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751893AbdHPStc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:49:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C563AF31F;
        Wed, 16 Aug 2017 14:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gt6GaNYK+S4qhuMX1VcskcEWJGU=; b=nGWA5z
        UVZpnc8UVTL1VMcVroAScRi80zXiuQ9P8CMTAlUtwF4xkUmaUJQ7QBbhcJn/hK2T
        1lBDVsw/pVZFs/JEYj+9mpjmeOfbYcIHle+iDk+k1mSl8iJMv8uvn/CiYFDZ+d9R
        uIlNvJeGmySZpOeuVU1/57Fm4wVFzhv8ZR274=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lzUVuDXIfhvmNL0MajVhn4DA0IPjjLhs
        5v4DPfMrUm5S8q7JiYJRrWmf5fVgtr4wLmB6vCoJVYXxypq8LC3HhLGGSV/jMfA5
        9+emytQx9nQ1xtJLq86EXoGBe493Y3zkf0Ia7D7K7RbXIv73XY3m/R8qxC1bv074
        3VKiDX7lj2o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1590DAF31E;
        Wed, 16 Aug 2017 14:49:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C8B6AF31D;
        Wed, 16 Aug 2017 14:49:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     ryenus <ryenus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] fix revisions doc about quoting for ':/' notation
References: <CAKkAvazj28RR1nHEWNNeZeyE6mpkb3opk6kvrxP6Lau6tcCbJQ@mail.gmail.com>
Date:   Wed, 16 Aug 2017 11:49:30 -0700
In-Reply-To: <CAKkAvazj28RR1nHEWNNeZeyE6mpkb3opk6kvrxP6Lau6tcCbJQ@mail.gmail.com>
        (ryenus@gmail.com's message of "Wed, 16 Aug 2017 11:21:10 +0800")
Message-ID: <xmqq7ey3l551.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3B2F580-82B3-11E7-9F78-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ryenus <ryenus@gmail.com> writes:

> To make sure the `<text>` in `:/<text>` is seen as one search string,
> one should quote/escape `<text>` properly.
>
> Especially, the example given in the manual `:/fix nasty bug` does not
> work because of missing quotes. The examples are now corrected, and a
> note about quoting/escaping is added as well.
> ---
>  Documentation/revisions.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 61277469c..fdfdde0ad 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -169,14 +169,14 @@ existing tag object.
>    and dereference the tag recursively until a non-tag object is
>    found.
>
> -'<rev>{caret}{/<text>}', e.g. 'HEAD^{/fix nasty bug}'::
> +'<rev>{caret}{/<text>}', e.g. 'HEAD^{/"fix nasty bug"}'::

This made me scratch my head, as I rarely read the formatted result
but look at the documentation in the source form.  The original
meant to quote the whole thing inside a single quote, but AsciiDoc
of course will strip that and instead makes the whole thing typeset
in monospace.

What you did is not wrong per-se, but I think quoting the whole
thing, instead of quoting just what is inside the braces, i.e.
'"HEAD^{/fix nasty bug}"' (or if you can manage it, using single
quote instead of double quote) would read better.

>    A suffix '{caret}' to a revision parameter, followed by a brace
>    pair that contains a text led by a slash,
>    is the same as the ':/fix nasty bug' syntax below except that
>    it returns the youngest matching commit which is reachable from
>    the '<rev>' before '{caret}'.
>
> -':/<text>', e.g. ':/fix nasty bug'::
> +':/<text>', e.g. ':/"fix nasty bug"'::

Likewise.

> @@ -185,7 +185,8 @@ existing tag object.
>    e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
>    is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
>    literal '!' character, followed by 'foo'. Any other sequence beginning with
> -  ':/!' is reserved for now.
> +  ':/!' is reserved for now. And make sure to quote/escape for the text to be
> +  seen as one search string.

Good.

Please sign-off your work (cf. Documentation/SubmittingPatches).

Thanks.
