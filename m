Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFF4438B
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095379; cv=none; b=emraAu5iL+hLdRLdBod+qjt+ElWnDyDjGTKUJ9dtopJ46Y33MjY5klWdj6weIGHjwzbtLpVhGejgGyspAmWfTGW8VwM0qRS1PMWNZ1E81hxQ0dBZQO/bNLJimowTjTTd2NmdbJkD9rzgY+rZYXXAEvCQtDD2X+VkqVU0KYliBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095379; c=relaxed/simple;
	bh=ew8TDarCuKKwXeoKdO6HP7+pDH9+PJAcceCQcxMs7JM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WMCh7W1HF5RuFfInUmkX3EPtb26kmKx3ZnudIQrj6Rms34HXG23g5UZ5W1nJwP+zxo9aHTIIY4lvfcfuJ0i8fcM+n6oHoktpoRexG7C33xgITAY2olH1SutarA0ltTtDADwPE1XWAk0mWo1cUYDCb3e1taTQrfGeAwhOCexrCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uUgofGEf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uUgofGEf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E05502EEE8;
	Mon, 19 Aug 2024 15:22:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ew8TDarCuKKwXeoKdO6HP7+pDH9+PJAcceCQcx
	Ms7JM=; b=uUgofGEfBqEdWHlTx502C8aZgYatfWDCu7T9pNFRjegIO4p/+Kk0dp
	98VzLihVVd8SidFjZChKC+Ac81+sMkBrCqlzsnTZ/KoUyIfKeKlb+Io5ikpgTqhx
	3GQXTDJnT7tWkgYQ1sZeaw1u19XhHl5lTC7JDnYlxUjdLYageuB3I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D754E2EEE7;
	Mon, 19 Aug 2024 15:22:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 457022EEE6;
	Mon, 19 Aug 2024 15:22:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, Yukai Chou
 <muzimuzhi@gmail.com>
Subject: Re: [PATCH v2] doc: add --show-names for git config
In-Reply-To: <CAEg0tHQDT7LesB2kiQD4rXwcUs5ZhOH+YWdn990tfGdrnYdgZg@mail.gmail.com>
	(Yukai Chou's message of "Tue, 20 Aug 2024 02:27:56 +0800")
References: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
	<xmqqcym4fqhp.fsf@gitster.g>
	<CAEg0tHQDT7LesB2kiQD4rXwcUs5ZhOH+YWdn990tfGdrnYdgZg@mail.gmail.com>
Date: Mon, 19 Aug 2024 12:22:49 -0700
Message-ID: <xmqqle0se2ra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6C900CD8-5E60-11EF-8CD2-9B0F950A682E-77302942!pb-smtp2.pobox.com

[Cc-ing the author of 4e513890 that was referred to by this change.]

Yukai Chou <muzimuzhi@gmail.com> writes:

> 4e513890 (builtin/config: introduce "get" subcommand,
> 2024-05-06) introduced "--show-names" option that is used to
> give the name of the configuration variable to each output entry
> in addition to the value.  It however forgot to document it,
> even though the option is used in a few examples.
>
> Document it.
>
> Signed-off-by: Yukai Chou <muzimuzhi@gmail.com>
> ---
> Thanks for your review and suggestions Junio. I must have stayed up
> too late yesterday, so what the commit message was sent was not the
> final version.
>
>  Documentation/git-config.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 65c645d461..16323c4ed0 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -268,6 +268,9 @@ Valid `<type>`'s include:
>   all queried config options with the scope of that value
>   (worktree, local, global, system, command).
>
> +--show-names::
> + Output also the names of config variables for `list` or `get`.
> +
>  --get-colorbool <name> [<stdout-is-tty>]::
>
>   Find the color setting for `<name>` (e.g. `color.diff`) and output
