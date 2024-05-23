Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F611C92
	for <git@vger.kernel.org>; Thu, 23 May 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477250; cv=none; b=Fqoq0XAhSfJ2Q74698tPiRFyT8aMWEb+xxzcy6qXPXc30K2+zwmAy0FoGY11CU8DEKJGcL7oOj07lEAqv65LcbvqBANUhGUzMdHdq7zMOeK3MBdB4ib7TzqqvhXzYl6PgBJAhjqiMcZmo1J64nBbvfuBHd1d1pPQVDMinrD5AGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477250; c=relaxed/simple;
	bh=jIqq22PZfk3IvtpZFZ/NjUMUC4U0w0y6bclABTDGaHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n9Sy5aPeLv43YqtEgAPb7uWvkeVWhSfcjlHaZuBT+kfpVlr6oh+49XammajgV6poyqfK5JDe2SK+OZPuwIZHu60Q9EZxPewcXX/E6hv+9gxH51U1jgVqe2bY/R8fh9l0/EDIvd99IJDK9duGqJVr+/bj20MY8oHQNFWpQ7sjylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ic5haszx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ic5haszx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A7DD3162A;
	Thu, 23 May 2024 11:14:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jIqq22PZfk3IvtpZFZ/NjUMUC4U0w0y6bclABT
	DGaHk=; b=ic5haszx4XVHRO9LEuoqrtI9geaygwccVbg7ySV08erFoy8Y71f27d
	0aDwUqNe/GeBXaVv27JGRVWLydydkee3DpnIPbL6Wl0o88pX1InvjlSeWrhHFi0i
	LY+3qhdS379r710IhoxCncPcxzKOUODZoR9yY2tdkEAcwDG3wNQok=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 427BB31629;
	Thu, 23 May 2024 11:14:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A03B531628;
	Thu, 23 May 2024 11:14:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Documentation: alias: rework notes into points
In-Reply-To: <20240523043806.1223032-1-iwienand@redhat.com> (Ian Wienand's
	message of "Thu, 23 May 2024 14:37:54 +1000")
References: <20240523042143.1220862-1-iwienand@redhat.com>
	<20240523043806.1223032-1-iwienand@redhat.com>
Date: Thu, 23 May 2024 08:14:04 -0700
Message-ID: <xmqq7cfky30j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 190904C2-1917-11EF-A057-25B3960A682E-77302942!pb-smtp2.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> There are a number of caveats when using aliases.  Rather than
> stuffing them all together in a paragraph, let's separate them out
> into individual points to make it clearer what's going on.

Nicely explained.

> diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
> index 01df96fab3..40851ef429 100644
> --- a/Documentation/config/alias.txt
> +++ b/Documentation/config/alias.txt
> @@ -21,8 +21,9 @@ If the alias expansion is prefixed with an exclamation point,
>  it will be treated as a shell command.  For example, defining
>  `alias.new = !gitk --all --not ORIG_HEAD`, the invocation
>  `git new` is equivalent to running the shell command
> +`gitk --all --not ORIG_HEAD`.  Note:
> ++
> +* Shell commands will be executed from the top-level directory of a
> +  repository, which may not necessarily be the current directory.
> +* `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
> +  from the original current directory. See linkgit:git-rev-parse[1].

Looking for '[NOTE]' in the Documentation/ files finds sections
marked up like this (this one is from Documentation/git-blame.txt):

    ...
    parser (which should be quite natural for most scripting languages).
    +
    [NOTE]
    For people who do parsing: to make it more robust, just ignore any
    lines between the first and last one ("<sha1>" and "filename" lines)
    ...

and its rendition looks like this:

https://git.github.io/htmldocs/git-blame.html#:~:text=most%20scripting%20languages).-,Note,-For%20people%20who

I am undecided if it gives a better presentation, especially when we
are giving bulletted list, so let's take the patch as-is and leave
it to interested folks to explore the use of [NOTE] _after_ this set
of patches lands as #leftoverbit follow-up topic.

Thanks.
