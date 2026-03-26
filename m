Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628B391E4C
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558441; cv=none; b=my4Zl+LDV7RFyKR5dDlRgI6dtBuEflxSSzf6UUT1NxD9aCyDAtUQZ7n9dlusFuqTa2oms1HDKAZ2mwtfgyPtSYcxFt2oWQ0TIl3iMEJWGKowc9ZB3zUULURmviTw9JiQZ6/MJ4F9zmF5r0KwRkOwfg18W1ouG88KlcaWQbdzook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558441; c=relaxed/simple;
	bh=pa2Kel8oqdqFusW0qC4HI7RFU+KZ2clRNqjVTyareh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba1N4AL3Ekt1s10xUI1SdKgpM/yuhhC7Br5r8KBNT3z2+kXD7XNeZfyAaIfKMnUb5eucUsxjIZBaCh9H+QRTyq0X28x8W1JHxLgnVlyxG6dxIKJjOZRtZTR9q0qdukAC1fZr+A3WHTshuI3wOlRYtLmUtSc4h7IXdMMYTUBXzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=f/Q0ArkX; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="f/Q0ArkX"
Date: Thu, 26 Mar 2026 21:53:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774558437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTkv9kBesnrBlolQMiURn13E4jGXpCRELl2bR9oi4Ts=;
	b=f/Q0ArkX07wHcICKC/TMxxZPRs1KhmRCkJqZ38E9MOO8DdV/k5mtkBegJ+brxNha8ixMwk
	zA70Wt5eMIMgHYQM6CQMzDcWoqk5jBYwB/DdjkG0PP7Npv2Gq1XhkRzKhoM29UbcUAukBN
	5MwKVvPdGVfLZkK2OUDiLw9wid9jA+OAeCcQeUdCyyvzIxLfh1g160VUGaPr8EUcjGD0vQ
	y5CVEBdebaSw7aEF1/ZuePPgFO+AkRUhqayQlXkUNxiq/TucMy0sUitQ9qVpbdpk7vqdBW
	SddltS1QRjqCw5U8QXWi5Fc5MCl5ZSayNE12h88WHOFIzJqDl1vZkXNNSW888w==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2] docs: fix --commit-list-format related entries
Message-ID: <acWbpJTRusOv6bPk@exploit>
References: <20260326185541.17523-1-mroik@delayed.space>
 <20260326200643.20251-1-mroik@delayed.space>
 <xmqqse9mnwv8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse9mnwv8.fsf@gitster.g>
X-Spamd-Bar: --

On Thu, Mar 26, 2026 at 01:45:15PM -0700, Junio C Hamano wrote:
> Being verbose is usually a good way to discourage readers from
> reading.

You're right, and most of the proposed changes do shorten the text very
well (will apply), but...

> Let's see if we can shorten them without losing information.
> 
> >  --commit-list-format=<format-spec>::
> >  	Specify the format in which to generate the commit list of the patch
> > +	series. The accepted values for format-spec are `shortlog`, `modern` or
> > +	a format-string prefixed with `log:`. E.g. `log: %s (%an)`.
> > +	Modern is the same as `log:[%(count)/%(total)] %s`.
> 
> "Modern" -> "`modern`".
> 
> This is necessary to stress the fact that this is a fixed token the
> user must give verbatim.
> 
> > +	The user is allowed to drop the `log:` prefix if the format-string
> > +	contains a '%' character. The '%' is expected as part of a placeholder
> > +	but this is not validated by git.
> 
>     The `log:` prefix can be omitted if the format-string has a `%`
>     in it (expecting that it is part of `%<placeholder>`).
> 
> > +	If not given, defaults to `shortlog` unless the
> > +	`format.commitListFormat` configuration variable is set.
> 
>     Defaults to the `format.commitListFormat` configuration
>     variable, if set, or `shortlog`.
> 
> > +	This option given from the command-line implies the use of
> > +	`--cover-letter` unless `--no-cover-letter` is given. Note that
> > +	`format.commitListFormat` being set does not imply the use of
> > +	`--cover-letter`.
> 
>     The use of this command line option implies `--cover-letter`,
>     unless explicitly countermanded with `--no-cover-letter`.

this part in particular is no different than the original text:

    This option implies the use of `--cover-letter` unless
    `--no-cover-letter` is given.

If we want to emphasize that the configuration variable doesn't imply
--cover-letter, we have to add the note on `format.commitListFormat`.

Thank you
