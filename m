Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6A15F403
	for <git@vger.kernel.org>; Mon, 27 May 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833699; cv=none; b=XH/XHzLdaWNhgbHK2HfU+mrjOd4erhTnIx4W6eVYAv+qSICtbdJSCuudLcvI6lIRWHe/809tJG8d/10tB5nAJoE+fbDq7lxF/6b4Fx3d2ozpo1pbHkXG0YwKouSpnC2PWa7wdVvd8HwyO285GxKiYg6pjj2mUccKpeHEMAJJKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833699; c=relaxed/simple;
	bh=oosu5RlOi++dKYp/UkfaC2h+JZqQ1SlJXX1dCDmNgik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MKDYduHGWk215F7ODrMavAxdwWYRDu4I03W4uSc5DNuoCw6cOYfpdSWk3rc4psV3jTm+iocEkySURfZTZEbdu5r5MbhUA+d4pS2vQrzKwsPrjOTD6dgK5JWt5UbgnaLsVZlV0VHwmeFIav2rrK0niw8x950B2nNDeDBJlzhYNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wmYEPJHM; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wmYEPJHM"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5D8D22705;
	Mon, 27 May 2024 14:14:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oosu5RlOi++dKYp/UkfaC2h+JZqQ1SlJXX1dCD
	mNgik=; b=wmYEPJHMDxapdlEfP95PUkF/ApwGjtG+W1rDmT504o2Jl1TA3j8nml
	V3XYUixB5ssfBEW7LU9/lENMCNqh98cC5K3ERFClFKKqFIVkENxxstHk0t5uLNag
	/GhzaiuNNjKuV+nawqFszzwoM0OVMvDNxlE3+FT9UHd25DdZrYYk4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD3AB22704;
	Mon, 27 May 2024 14:14:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3098A22703;
	Mon, 27 May 2024 14:14:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org,  worldhello.net@gmail.com
Subject: Re: [PATCH 2 1/1] parse-options: allow localized substitution hints
 in macros
In-Reply-To: <20240525122514.2608-2-ash@kambanaria.org> (Alexander Shopov's
	message of "Sat, 25 May 2024 14:24:38 +0200")
References: <xmqq5xwa1pfl.fsf@gitster.g>
	<20240525122514.2608-2-ash@kambanaria.org>
Date: Mon, 27 May 2024 11:14:55 -0700
Message-ID: <xmqqttij86lc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 05843DAE-1C55-11EF-A191-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Alexander Shopov <ash@kambanaria.org> writes:

> Subject: Re: [PATCH 2 1/1] parse-options: allow localized substitution hints in macros

These are not "macros", though.  Perhaps

    parse-options: localize marking-up of placeholder text in the short help

or something?  As to the body of the proposed log message, I've
covered it in my respoinse of the cover letter.

> diff --git a/parse-options.c b/parse-options.c
> index 30b9e68f8a..06d962b00e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1070,11 +1070,17 @@ static int usage_argh(const struct option *opts, FILE *outfile)
>  		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
>  	if (opts->flags & PARSE_OPT_OPTARG)
>  		if (opts->long_name)
> -			s = literal ? "[=%s]" : "[=<%s>]";
> +			s = literal ? "[=%s]" :
> +			  /* TRANSLATORS: change `<>' to other characters or leave as is */
> +			  _("[=<%s>]");
>  		else
> -			s = literal ? "[%s]" : "[<%s>]";
> +			s = literal ? "[%s]" :
> +			  /* TRANSLATORS: change `<>' to other characters or leave as is */
> +			  _("[<%s>]");
>  	else
> -		s = literal ? " %s" : " <%s>";
> +		s = literal ? " %s" :
> +		  /* TRANSLATORS: change `<>' to other characters or leave as is */
> +		  _(" <%s>");
>  	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
>  }

Just like user's language may use a convention different from
enclosing it in a pair of <angle brackets> to mark a placeholder
text, the use of [square brackets] to mark an optional part may
have different per-language counterpart, no?

The above change, on the side that handles PARSE_OPT_OPTARG case,
already allows "[=<%s>]" to be translated, but the translator hints
can and should clarify that possibility as well, no?

    /* TRANSLATORS: change [] and <> mark-up, if necessary */

The SP that appears before <%s> on the mandatory argument side MUST
NOT be translated.  To go back to the "--author <author>" example I
gave in my response for the cover letter, when the program says:

	OPT_STRING(0, "author", &au, N_("author"), N_("override author")),

in the output of "git commit -h", we give

        --[no-]author <AUTHOR>    OVERRIDE AUTHOR

where I used uppercase letters for the translated string.  The SP
before <%s> in " <%s>" is what we see after "--[no-]author" in the
output.

So, if we were to allow localizing this truly, probably the "else"
clause needs a bit more work, e.g.

	if (opts->flags & PARSE_OPT_OPTARG) {
		...
	} else {
		s = literal 
		? "%s"
                : _("<%s>");
		fputc(' ', outfile);
	}

The "=" that appears before %s should NOT be translated for exactly
the same reason.  If --author were an option that took an optional
argument, "git commit -h" would have given

        --[no-]author[=<AUTHOR>]    OVERRIDE AUTHOR

No matter what language the user writes, the user MUST write '='
after "--author" if he or she wants to give an optional argument to
the option.  So some care must be taken to make sure they keep '='
even if they were to translate _("[=<%s>]").  The easiest way to do
so may be to punt and *tell* them (without us having a way to make
sure that they followed what we told them to), e.g.

    s = literal 
      ? "[=%s]"
      /*
       * TRANSLATORS: change [] that signals optional-ness, and
       * <> that signal placeholder-ness, of what is enclosed 
       * as necessary to match your locale's convention.  Do not
       * move or change '='; no matter what your language is, the
       * equal sign MUST be the first character in the optional
       * string.
       */
      : _("[=<%s>]");

Other than the above two points on the " " and "=" that must not be
changed, the intent of this change looks very good to me.

Thanks.

