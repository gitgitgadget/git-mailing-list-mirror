Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AC3C26
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705773322; cv=none; b=NqhhkkwV7T0o88lmkzUO/xYy0MH9TOW8zkchwiHNSBAvHgJSgsqOLREGb7JdxMCevkOW/5KSlEzRpTUoBnWC6DIzyMKEBtjROInu1tgKGX1xRHK+2xBbgU2czCojWAIHWZdO/cfKFKbaCBC8hHFAUfMOx4FwIfV8YlaFeL8ihrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705773322; c=relaxed/simple;
	bh=WwFCtDEDSt9a687r9sa59VeWRVS5uvvLBVzRWyKjQec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rW3EhSpSP8pf2dwpsQkaDuLK+nLjBZNRkNfnPjs7/YwHhdKoBNTTgThrhzr62fAsAWMrxAzmFk8joLxR23EmFoNc8dBfi/z0lIs2Fjp3zNCla3dWmNr0R5yAFg6pUs9hW/yArdQw3MwP9tqkQaqchOdBVVH2eZodp0GC3QE78Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MZ3/cIOo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MZ3/cIOo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 49BF31DCE1B;
	Sat, 20 Jan 2024 12:55:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WwFCtDEDSt9a
	687r9sa59VeWRVS5uvvLBVzRWyKjQec=; b=MZ3/cIOo7/o7BQbGhSsD+ixdzwx9
	V2Arj7HodmakIo6ObNgYNqk0Mqn2o1LeBh3KDsLOdLRzer6wFL6O6oomS8E3zGP5
	XQ/WapxyNvwHA1h8morYIqEHVUpXbnOYk+f7MR04WlxmWsMxOMdd/ww2ojhu7cNO
	EOOX/FOtSVJyBMk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 404AD1DCE1A;
	Sat, 20 Jan 2024 12:55:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A19931DCE19;
	Sat, 20 Jan 2024 12:55:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [Bug?] "git diff --no-rename A B"
In-Reply-To: <579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 20 Jan 2024 15:39:38 +0100")
References: <xmqq34uvtpob.fsf@gitster.g>
	<20240120011800.GF117170@coredump.intra.peff.net>
	<579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de>
Date: Sat, 20 Jan 2024 09:55:17 -0800
Message-ID: <xmqqmsszga9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 12C70A5C-B7BD-11EE-96D2-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Because diff_opt_parse() passes PARSE_OPT_KEEP_UNKNOWN_OPT, which makes
> parse_long_opt() skip abbreviation detection.  Which it does since
> baa4adc66a (parse-options: disable option abbreviation with
> PARSE_OPT_KEEP_UNKNOWN, 2019-01-27).
>
> It added a condition only to the if.  Its body can be reached via goto
> from two other places, though.  So abbreviated options are effectively
> allowed through the back door.

Wow, that is nasty.  Thanks for spotting.

I agree with you that the structure of that loop and the processing
in it does look confusing.

> --- >8 ---
> Subject: [PATCH] parse-options: fully disable option abbreviation with =
PARSE_OPT_KEEP_UNKNOWN
>
> baa4adc66a (parse-options: disable option abbreviation with
> PARSE_OPT_KEEP_UNKNOWN, 2019-01-27) turned off support for abbreviated
> options when the flag PARSE_OPT_KEEP_UNKNOWN is given, as any shortened
> option could also be an abbreviation for one of the unknown options.
>
> The code for handling abbreviated options is guarded by an if, but it
> can also be reached via goto.  baa4adc66a only blocked the first way.
> Add the condition to the other ones as well.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Formatted with --function-context for easier review.
> The code is a quite tangled, any ideas how to structure it better?
>
>  parse-options.c         | 8 +++++---
>  t/t4013-diff-various.sh | 6 ++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 4ce2b7ca16..92e96ca6cd 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -353,93 +353,95 @@ static int is_alias(struct parse_opt_ctx_t *ctx,
>  static enum parse_opt_result parse_long_opt(
>  	struct parse_opt_ctx_t *p, const char *arg,
>  	const struct option *options)
>  {
>  	const char *arg_end =3D strchrnul(arg, '=3D');
>  	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NU=
LL;
>  	enum opt_parsed abbrev_flags =3D OPT_LONG, ambiguous_flags =3D OPT_LO=
NG;
> +	int allow_abbrev =3D !(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT);
>
>  	for (; options->type !=3D OPTION_END; options++) {
>  		const char *rest, *long_name =3D options->long_name;
>  		enum opt_parsed flags =3D OPT_LONG, opt_flags =3D OPT_LONG;
>
>  		if (options->type =3D=3D OPTION_SUBCOMMAND)
>  			continue;
>  		if (!long_name)
>  			continue;
>
>  again:
>  		if (!skip_prefix(arg, long_name, &rest))
>  			rest =3D NULL;
>  		if (!rest) {
>  			/* abbreviated? */
> -			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT) &&
> +			if (allow_abbrev &&
>  			    !strncmp(long_name, arg, arg_end - arg)) {
>  is_abbreviated:
>  				if (abbrev_option &&
>  				    !is_alias(p, abbrev_option, options)) {
>  					/*
>  					 * If this is abbreviated, it is
>  					 * ambiguous. So when there is no
>  					 * exact match later, we need to
>  					 * error out.
>  					 */
>  					ambiguous_option =3D abbrev_option;
>  					ambiguous_flags =3D abbrev_flags;
>  				}
>  				if (!(flags & OPT_UNSET) && *arg_end)
>  					p->opt =3D arg_end + 1;
>  				abbrev_option =3D options;
>  				abbrev_flags =3D flags ^ opt_flags;
>  				continue;
>  			}
>  			/* negation allowed? */
>  			if (options->flags & PARSE_OPT_NONEG)
>  				continue;
>  			/* negated and abbreviated very much? */
> -			if (starts_with("no-", arg)) {
> +			if (allow_abbrev && starts_with("no-", arg)) {
>  				flags |=3D OPT_UNSET;
>  				goto is_abbreviated;
>  			}
>  			/* negated? */
>  			if (!starts_with(arg, "no-")) {
>  				if (skip_prefix(long_name, "no-", &long_name)) {
>  					opt_flags |=3D OPT_UNSET;
>  					goto again;
>  				}
>  				continue;
>  			}
>  			flags |=3D OPT_UNSET;
>  			if (!skip_prefix(arg + 3, long_name, &rest)) {
>  				/* abbreviated and negated? */
> -				if (starts_with(long_name, arg + 3))
> +				if (allow_abbrev &&
> +				    starts_with(long_name, arg + 3))
>  					goto is_abbreviated;
>  				else
>  					continue;
>  			}
>  		}
>  		if (*rest) {
>  			if (*rest !=3D '=3D')
>  				continue;
>  			p->opt =3D rest + 1;
>  		}
>  		return get_value(p, options, flags ^ opt_flags);
>  	}
>
>  	if (disallow_abbreviated_options && (ambiguous_option || abbrev_optio=
n))
>  		die("disallowed abbreviated or ambiguous option '%.*s'",
>  		    (int)(arg_end - arg), arg);
>
>  	if (ambiguous_option) {
>  		error(_("ambiguous option: %s "
>  			"(could be --%s%s or --%s%s)"),
>  			arg,
>  			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
>  			ambiguous_option->long_name,
>  			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
>  			abbrev_option->long_name);
>  		return PARSE_OPT_HELP;
>  	}
>  	if (abbrev_option)
>  		return get_value(p, abbrev_option, abbrev_flags);
>  	return PARSE_OPT_UNKNOWN;
>  }
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index cb094241ec..1e3b2dbea4 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -663,4 +663,10 @@ test_expect_success 'diff --default-prefix overrid=
es diff.mnemonicprefix' '
>  	check_prefix actual a/file0 b/file0
>  '
>
> +test_expect_success 'diff --no-renames cannot be abbreviated' '
> +	test_expect_code 129 git diff --no-rename >actual 2>error &&
> +	test_must_be_empty actual &&
> +	grep "invalid option: --no-rename" error
> +'
> +
>  test_done
> --
> 2.43.0
