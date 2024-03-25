Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D524CDDC3
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394301; cv=none; b=BEYbaYgWPHZgAX8is5j+rtWPkE3ck4IMrC1OH+1rxfUcp2mgWoYVrkleE9BpBORh7EKCj28NrR48aKkKCPwgDOjHz29OE62KeVh6sRfMyZc1RE8afLrvUstbUXg9rEUhe1TcZfz06jiWqZKHlgcQ+QPFERfmailTbFXRPZgMT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394301; c=relaxed/simple;
	bh=mZN9B+PPpLyAV6GIgvpwxOXi8lx2gMJD2z7trl/O3yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cfnj1vykjnEgJEl8F0ZUgmOROTVawkrHM0rX82HTY4ITsfH1ctK7vnBpvMCpcPT8JtU2DFFlIGNUGPhYM14fLsPuER1f4JL6pTUGzQZZbZCkMqnVSVxYnL6qbWWUT1Y4ZmELuJPGWd6bfkWC2pf94dxf+uYljqdfK9gD2K2l8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KzQAeHhw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KzQAeHhw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD9C21E978B;
	Mon, 25 Mar 2024 15:18:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mZN9B+PPpLyAV6GIgvpwxOXi8lx2gMJD2z7trl
	/O3yo=; b=KzQAeHhwlA6uB/aTI/d8IgOL7XiarPGpacA25jZLvb7mv5Ook1hQQv
	L61I25LP2PwLjc85/Z0ecSRhtfW0AaRqQXGqhq/Ueqx6pBp0xr16ks4IoJAuFc4E
	9fgHCOwV1DZFXzwXezEe2doGalcxk6oJawd2lXDnI9mnULWwcmerc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A46401E978A;
	Mon, 25 Mar 2024 15:18:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A6B11E9789;
	Mon, 25 Mar 2024 15:18:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  jn.avila@free.fr
Subject: Re: [PATCH v2 3/3] grep docs: describe --no-index further and
 improve formatting a bit
In-Reply-To: <a7e5151fa615d572ab4ed05519dd277048ce935c.1711302588.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sun, 24 Mar 2024 18:51:13 +0100")
References: <cover.1711302588.git.dsimic@manjaro.org>
	<a7e5151fa615d572ab4ed05519dd277048ce935c.1711302588.git.dsimic@manjaro.org>
Date: Mon, 25 Mar 2024 12:18:16 -0700
Message-ID: <xmqqa5mmjf2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6F926590-EADC-11EE-9951-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> +--no-index::
> +	Search files in the current directory that is not managed by Git,
> +	or by ignoring that the current directory is managed by Git.  This
> +	is rather similar to running the regular `grep(1)` utility with its
> +	`-r` option specified, but with some additional benefits, such as
> +	using multiple worker threads to speed up searches.

Sorry for not mentioning this earlier, but I do not think
multi-threaded grep has to be something we own and others cannot
implement.  A richer pathspec globbing [*1*] and logical operation
on match results may be better examples of "additional benefits" if
we really wanted to mention why people might want to use
"--no-index" in a directory that is outside Git.

[Footnote]

 *1* When you want to look for something in files whose name begins
     with "g" but does not have "rc" in it, you'd do

     $ git grep --no-index -c . ':(exclude)*rc*' 'g*'

> ++
> +This option cannot be used together with `--cached` or `--untracked`.
> +See also `grep.fallbackToNoIndex` in 'CONFIGURATION' below.
> +

OK.

>  --threads <num>::
> -	Number of grep worker threads to use.
> -	See `grep.threads` in 'CONFIGURATION' for more information.
> +	Number of `grep` worker threads to use, to speed up searches.
> +	See 'NOTES ON THREADS' and `grep.threads` in 'CONFIGURATION'
> +	for more information.

I actually do not think adding ", to speed up searches" is an
improvement.  But referring to NOTES ON THREADS is a good idea, and
by reading that NOTES ON THREADS section, readers can tell why it
sometimes does not speed things up or even slow them down.

Other than that, looking great.

Thanks.
