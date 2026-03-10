Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10843C5538
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164691; cv=none; b=Tn1e31kLSF75Uy1d2ZgWgbIXEOgHCTXczSXe9n1IydqrhjTafBd2AGXHbFmCXvs9NICqboziR0okuNizrVb+EGe1sxkTDnJpaFx0wdIJF0HORJ72092suc7/MKw6Qgb1QLLqmZRzKg+Kc7i/liGjCXqFC46a2vbQwS4RMj2dlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164691; c=relaxed/simple;
	bh=cvBfxtAqiFmE2+MkilGDZL8mIVvXJODLXhwLjyTyVhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1Pd0n9ru/OFuWHed8tgH+pGkXTN8B2p2+jCWCADefGDrlWaC5Sx1FtM5xgS+umA3j1c4h+j7Krp1FmHh3AiYVmdcSg9r6QwslgJMeaJ+u+V/CDrx6jIVmRc5AYDnthcQZ157cUe1EPSSNd2YNzRxi7RPNz1yx1voLCFRI0xcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VnPfAVye; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VnPfAVye"
Received: (qmail 62112 invoked by uid 106); 10 Mar 2026 17:44:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cvBfxtAqiFmE2+MkilGDZL8mIVvXJODLXhwLjyTyVhU=; b=VnPfAVye0FerTKwDaIiiZr2m+EeX9lHNWfkiKB61fVO1X41hVnWQbxCNxCjtiBlw2p1/I7fw+dLy35WT2ig5dpPaUXSqxpO90F07f6t1xIWCZ5xG0y4cgHGQdjupwq0K4VT7EGQenxU/5Xl/NxZbzyYffmh/+7B0NF7emWM8dWkd0Y8yBDiWkfTySLdJZZPmrnjXbZPUbYKNp2ezdN0GsBhjDlKRC+OvEfuulusRjxK70kG3Z4mm5VM/tq+yMXq1rg03Ya3mn9opyXp0TC1ZtXKN6ILQgqJ9qwHpLp0f+Pu1qg891zjFu1rR1FbOc7nDjjV5bwRK2dhIawersSaZGA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Mar 2026 17:44:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 474966 invoked by uid 111); 10 Mar 2026 17:44:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Mar 2026 13:44:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Mar 2026 13:44:47 -0400
From: Jeff King <peff@peff.net>
To: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v5 3/4] remote-curl: introduce show_http_message_fatal()
 helper
Message-ID: <20260310174447.GA589835@coredump.intra.peff.net>
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
 <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
 <973703e9ddedb67daa946208ef7edb9eb50425a7.1771856405.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <973703e9ddedb67daa946208ef7edb9eb50425a7.1771856405.git.gitgitgadget@gmail.com>

On Mon, Feb 23, 2026 at 02:20:04PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:

> From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
> 
> Several code paths in remote-curl.c follow the same pattern of calling
> show_http_message() to display server error messages followed by die()
> to terminate with an error. This duplication makes the code more verbose
> and harder to maintain.
> 
> Introduce a new show_http_message_fatal() helper function that combines
> these two operations. This function:
> 
> 1. Displays any HTTP error message from the server via show_http_message()
> 2. Calls die() with the provided error message
> 3. Returns NORETURN to help the compiler with control flow analysis
> 
> Refactor existing call sites in remote-curl.c to use this new helper,
> reducing code duplication and improving readability. This pattern will
> also be used by upcoming HTTP 429 rate limiting support.

I'm unconvinced that this actually makes things simpler. It doesn't save
any lines, the show_http_message() becomes less flexible, and we now
encode die-logic like the numeric code for exit() in the curl code.

> +static NORETURN void show_http_message_fatal(struct strbuf *type, struct strbuf *charset,
> +				    struct strbuf *msg, const char *fmt, ...)
>  {
>  	const char *p, *eol;
> +	va_list ap;
> +	report_fn die_message_routine = get_die_message_routine();

If we got the die_routine here and not the die_message_routine, we
wouldn't have to exit() ourselves. But sadly there is not a
get_die_routine() helper yet, so we'd have to add one.

>  	/*
>  	 * We only show text/plain parts, as other types are likely
>  	 * to be ugly to look at on the user's terminal.
>  	 */
>  	if (strcmp(type->buf, "text/plain"))
> -		return -1;
> +		goto out;
>  	if (charset->len)
>  		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
>  
>  	strbuf_trim(msg);
>  	if (!msg->len)
> -		return -1;
> +		goto out;
>  
>  	p = msg->buf;
>  	do {

OK, we jump to the end since now we have to make sure to hit the exit
bits.

> @@ -391,7 +393,16 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
>  		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
>  		p = eol + 1;
>  	} while(*eol);
> -	return 0;
> +
> +out:
> +	strbuf_release(type);
> +	strbuf_release(charset);
> +	strbuf_release(msg);

This cleanup seems pointless. These strbufs came from the caller, so
they are not our responsibility to release. But also, we're about to
call die(), so there is no need to clean them up.

> +	va_start(ap, fmt);
> +	die_message_routine(fmt, ap);
> +	va_end(ap);
> +	exit(128);

This part is the advertised change for the function, which looks correct.

>  static int get_protocol_http_header(enum protocol_version version,
> @@ -518,21 +529,21 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  	case HTTP_OK:
>  		break;
>  	case HTTP_MISSING_TARGET:
> -		show_http_message(&type, &charset, &buffer);
> -		die(_("repository '%s' not found"),
> -		    transport_anonymize_url(url.buf));
> +		show_http_message_fatal(&type, &charset, &buffer,
> +					_("repository '%s' not found"),
> +					transport_anonymize_url(url.buf));

So this is what the refactoring bought us: we trade 3 lines for 3 lines.  ;)

If we could roll in policy decisions like anonymizing the URL, or
showing the curl_errorstr, I think it might be worth it. But we can't do
that easily because they are varargs for the %s format.

IMHO we should just drop this patch, and patch 4 should do the usual
show_http_message() and die().

-Peff
