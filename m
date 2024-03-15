Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E053365
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546106; cv=none; b=mEa8yj652OWd8Gprojg+VELXC0828HF7upzf0/YaFgD/Bk77Sr1kSuciu9cs0n/j8L+p6hM235ekKFUh8FiZ27yRWMFXULutgc5o64AtGuEpaClj6OQuhncbVFf8H5TuyJpr+M/tKe08bNQUBWokdxoMIrnhNm+MOWAXrY8CkfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546106; c=relaxed/simple;
	bh=0hEBM2GmPUQV95A/8o2NhCfELTK1OUgQbZVKtivPZg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OW4d+o6a+f0i7d5Jyd0oBheJd8hte9y+HeqY8f9senJ5kYr7D3yaLyPpFr14e9QvcDoyGyEqSbnWSU4i2K7BSCKtNAFSlah2UKYxVEp4qdTrlXtWE9ZlxAgBmWYjj1o/4qRJxmhjptT1LYl4Zcy3evOe3TtVw7dCpGz/L6I68hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HIRRrJQl; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HIRRrJQl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B3E035501;
	Fri, 15 Mar 2024 19:41:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0hEBM2GmPUQV95A/8o2NhCfELTK1OUgQbZVKti
	vPZg0=; b=HIRRrJQl9v1h4OmKefagD4qaFXQLcI/TQOcNvl/TmvTAm44rP9zIQz
	DevQ3ccBh7r7EU+uqaMvIq6ZyLZKtRDh3Eg5YkMw3rd/mcYwzBufy65OsJpge36D
	Tgtvj+oFZieqULoQBkBQTI2JOH/EAPh6MmeIrYWVJhnwj9EWGn/y8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 22CBB35500;
	Fri, 15 Mar 2024 19:41:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC749354FF;
	Fri, 15 Mar 2024 19:41:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  rsbecker@nexbridge.com,  Dragan Simic
 <dsimic@manjaro.org>,  Chris Torek <chris.torek@gmail.com>,  Ralph
 Seichter <github@seichter.de>
Subject: Re: [PATCH v3] config: add --comment option to add a comment
In-Reply-To: <CAPig+cQwWu=FA4vnKK9+aLkTzAzMXp6h5aJedEh3FT+1bNTjAQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 15 Mar 2024 19:10:37 -0400")
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
	<xmqq8r2jp2eq.fsf@gitster.g>
	<CAPig+cQwWu=FA4vnKK9+aLkTzAzMXp6h5aJedEh3FT+1bNTjAQ@mail.gmail.com>
Date: Fri, 15 Mar 2024 16:41:37 -0700
Message-ID: <xmqqttl7njv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9167E64A-E325-11EE-8158-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> tackled by this patch. Do we foresee a future in which git-config may
> be extended to handle automation of comments other than inline? If so,
> do we really want to lock ourselves into having the generic option
> `--comment=<message>` be restricted to only inline comments? Or would
> it be better to plan for the future by instead having some sort of
> annotation which indicates that we are requesting (or dealing with)
> only inline comments, such as `--inline-comment=<message>` or
> `--comment=inline:<message>`?

I do not see a need for anything, while we fail a request with a
multi-line message and say "don't feed me a multi-line message".

When we start supporting multi-line comment (which I do not think is
a good idea at all, by the way), the code can switch between

	[vari]
		able = value # single line comment
		# a comment with
		# more than one line
		able = value

depending on what is in <message>, so "inline:" prefix does not even
have to exist, I would imagine.  Of course you could even go fancier
and allow something like this with unnecessary tailing LF ...

	$ git config --comment='another single line comment
	'

... as a signal to turn a single line commet on a separate line.

	[vari]
		able = value # single line comment
		# a comment with
		# more than one line
		able = value
		# another single value comment
		able = value

There will most likely need where e.g., above or below, around the
"var = val" line to place the comment as well, so I do not see much
value in investing more brain cycles on what the "--comment" option
should look like, while we only support single-liners and explicitly
reject multi-line messages.
