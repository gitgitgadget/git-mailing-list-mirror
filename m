Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C95B20450
	for <e@80x24.org>; Sat,  4 Nov 2017 02:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbdKDC1n (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 22:27:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55023 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751216AbdKDC1l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 22:27:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7C05B273A;
        Fri,  3 Nov 2017 22:27:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=e7GkpdTYBqMi
        8IY0cF+TqnZss3A=; b=PNaKW7V7fw/O/MwbSQYXnGtmPV+d/SVJrcryytjQe0eP
        EmpYE4ZPwvhd6BlcQBhkpDocaxXrXrh59IIEjISZeVFBMSWK0uqnX6aRG/D6hgyR
        I/R834JGr6rUSfS7pveZpKWWS5Yc/4fGDKx+ef+qRrAN3bkA2rUuyJ2ABlvAX3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DBIbVr
        hswd6svt5f5R+aqIGlkxjV73U4O2bJ+zMADGnRpeJy7lzDeaWMlvfSXMOQc2O4je
        FvXNbs8pJGoQBak4FyucrqnLuyJp0Pik/EAx1epMnYI5sdHB4IYIxW8aNHcgfPvM
        5XDgZnygjMHAeFzzV1ZYkC/8mrf3LdByB9dd0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF744B2739;
        Fri,  3 Nov 2017 22:27:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D969B2738;
        Fri,  3 Nov 2017 22:27:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v1 1/2] refs: extract function to normalize partial refs
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171104004144.5975-2-rafa.almas@gmail.com>
Date:   Sat, 04 Nov 2017 11:27:39 +0900
In-Reply-To: <20171104004144.5975-2-rafa.almas@gmail.com> ("Rafael
 =?utf-8?Q?Ascens=C3=A3o=22's?=
        message of "Sat, 4 Nov 2017 00:41:43 +0000")
Message-ID: <xmqqo9oiok10.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BAF9BE80-C107-11E7-9777-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

> `for_each_glob_ref_in` has some code built into it that converts
> partial refs like 'heads/master' to their full qualified form

s/full/&y/ (read: that "full" needs "y" at the end).

> 'refs/heads/master'. It also assume a trailing '/*' if no glob

s/assume/&s/

> characters are present in the pattern.
>
> Extract that logic to its own function which can be reused elsewhere
> where the same behaviour is needed, and add an ENSURE_GLOB flag
> to toggle if a trailing '/*' is to be appended to the result.
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> Signed-off-by: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>

Could you explain Kevin's sign-off we see above?  It is a bit
unusual (I am not yet saying it is wrong---I cannot judge until I
find out why it is there) to see a patch from person X with sign off
from person Y and then person X in that order.  It is normal for a
patch authored by person X to have sign-off by X and then Y if X
wrote it, signed it off and passed to Y, and then Y resent it after
signing it off (while preserving the authorship of X by adding an
in-body From: header), but I do not think that is what we have here.

It could be that you did pretty much all the work on this patch
and Kevin helped you to polish this patch off-list, in which case
the usual thing to do is to use "Helped-by: Kevin" instead.

> ---
>  refs.c | 34 ++++++++++++++++++++--------------
>  refs.h | 16 ++++++++++++++++
>  2 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index c590a992f..1e74b48e6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -369,32 +369,38 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_=
data)
>  	return ret;
>  }
> =20
> -int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
> -	const char *prefix, void *cb_data)
> +void normalize_glob_ref(struct strbuf *normalized_pattern, const char =
*prefix,
> +		const char *pattern, int flags)

It is better to use "unsigned" for a single word "flags" used as a
collection of bits.  In older parts of the codebase, we have
codepaths that pass signed int as a flags word, simply because we
didn't know better, but we do not have to spread that practice to
new code.

>  {
> -	struct strbuf real_pattern =3D STRBUF_INIT;
> -	struct ref_filter filter;
> -	int ret;
> -
>  	if (!prefix && !starts_with(pattern, "refs/"))
> -		strbuf_addstr(&real_pattern, "refs/");
> +		strbuf_addstr(normalized_pattern, "refs/");
>  	else if (prefix)
> -		strbuf_addstr(&real_pattern, prefix);
> -	strbuf_addstr(&real_pattern, pattern);
> +		strbuf_addstr(normalized_pattern, prefix);
> +	strbuf_addstr(normalized_pattern, pattern);
> =20
> -	if (!has_glob_specials(pattern)) {
> +	if (!has_glob_specials(pattern) && (flags & ENSURE_GLOB)) {
>  		/* Append implied '/' '*' if not present. */
> -		strbuf_complete(&real_pattern, '/');
> +		strbuf_complete(normalized_pattern, '/');
>  		/* No need to check for '*', there is none. */
> -		strbuf_addch(&real_pattern, '*');
> +		strbuf_addch(normalized_pattern, '*');
>  	}
> +}

The above looks like a pure and regression-free code movement (plus
a small new feature) that is faithful to the original, which is good.

I however notice that addition of /* to the tail is trying to be
careful by using strbuf_complete('/'), but prefixing with "refs/"
does not and we would end up with a double-slash if pattern begins
with a slash.  The contract between the caller of this function (or
its original, which is for_each_glob_ref_in()) and the callee is
that prefix must not begin with '/', so it may be OK, but we might
want to add "if (*pattern =3D=3D '/') BUG(...)" at the beginning. =20

I dunno.  In any case, that is totally outside the scope of this two
patch series.

> diff --git a/refs.h b/refs.h
> index a02b628c8..9f9a8bb27 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -312,6 +312,22 @@ int for_each_namespaced_ref(each_ref_fn fn, void *=
cb_data);
>  int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void =
*cb_data);
>  int for_each_rawref(each_ref_fn fn, void *cb_data);
> =20
> +/*
> + * Normalizes partial refs to their full qualified form.

s/full/&y/;

> + * If prefix is NULL, will prepend 'refs/' to the pattern if it doesn'=
t start
> + * with 'refs/'. Results in refs/<pattern>
> + *
> + * If prefix is not NULL will result in <prefix>/<pattern>

s/NULL/&,/;

> + *
> + * If ENSURE_GLOB is set and no glob characters are found in the
> + * pattern, a trailing </><*> will be appended to the result.
> + * (<> characters to avoid breaking C comment syntax)
> + */
> +
> +#define ENSURE_GLOB 1
> +void normalize_glob_ref (struct strbuf *normalized_pattern, const char=
 *prefix,
> +				const char *pattern, int flags);
> +
>  static inline const char *has_glob_specials(const char *pattern)
>  {
>  	return strpbrk(pattern, "?*[");

Thanks.  Other than the above minor points, looks good to me.
